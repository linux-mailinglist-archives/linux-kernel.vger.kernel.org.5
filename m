Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45847E6DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjKIPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344152AbjKIPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C0384B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G9cfB/SMcsuQUP6NSXMvLH/gTThJ4V8NgpcMlTJhZ4=;
        b=bPyOlFtZj7gh4663+9kktUAZYeoYkqTJmJoiyzIN70H1kzIcwmCyQSU4Z+Q+d7FU2+dV7X
        F5Bpypn+EalY0TKYo2CR2kfrO1dBp62BZEcJav0Fzm5qqwyQfNcef6gckQ0P7Peh9GoOwD
        W4pAU9Jmm8tsBeRgp76pb49PrcN/+6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-HMTp9tTqPLOL3nmlbwdPXQ-1; Thu, 09 Nov 2023 10:40:59 -0500
X-MC-Unique: HMTp9tTqPLOL3nmlbwdPXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5961C185A790;
        Thu,  9 Nov 2023 15:40:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C458C0FE05;
        Thu,  9 Nov 2023 15:40:58 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/41] afs: Dispatch fileserver probes in priority order
Date:   Thu,  9 Nov 2023 15:39:51 +0000
Message-ID: <20231109154004.3317227-29-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probing all the addresses for a fileserver, dispatch them in order of
descending priority to try and get back highest priority one first.

Also add a tracepoint to show the transmission and completion of the
probes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_probe.c          | 25 +++++++++++++++++++++++--
 include/trace/events/afs.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 8008d3ecabab..c5702698b18b 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -102,7 +102,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	struct afs_address *addr = &alist->addrs[call->probe_index];
 	struct afs_server *server = call->server;
 	unsigned int index = call->probe_index;
-	unsigned int rtt_us = 0, cap0;
+	unsigned int rtt_us = -1, cap0;
 	int ret = call->error;
 
 	_enter("%pU,%u", &server->uuid, index);
@@ -182,6 +182,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 out:
 	spin_unlock(&server->probe_lock);
 
+	trace_afs_fs_probe(server, false, alist, index, call->error, call->abort_code, rtt_us);
 	_debug("probe %pU [%u] %pISpc rtt=%d ret=%d",
 	       &server->uuid, index, rxrpc_kernel_remote_addr(alist->addrs[index].peer),
 	       rtt_us, ret);
@@ -207,6 +208,8 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	afs_get_addrlist(alist, afs_alist_trace_get_probe);
 	read_unlock(&server->fs_lock);
 
+	afs_get_address_preferences(net, alist);
+
 	server->probed_at = jiffies;
 	atomic_set(&server->probe_outstanding, all ? alist->nr_addrs : 1);
 	memset(&server->probe, 0, sizeof(server->probe));
@@ -217,10 +220,28 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 		all = true;
 
 	if (all) {
-		for (index = 0; index < alist->nr_addrs; index++)
+		unsigned long unprobed = (1UL << alist->nr_addrs) - 1;
+		unsigned int i;
+		int best_prio;
+
+		while (unprobed) {
+			best_prio = -1;
+			index = 0;
+			for (i = 0; i < alist->nr_addrs; i++) {
+				if (test_bit(i, &unprobed) &&
+				    alist->addrs[i].prio > best_prio) {
+					index = i;
+					best_prio = alist->addrs[i].prio;
+				}
+			}
+			__clear_bit(index, &unprobed);
+
+			trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
 			if (!afs_fs_get_capabilities(net, server, alist, index, key))
 				afs_fs_probe_not_done(net, server, alist, index);
+		}
 	} else {
+		trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
 		if (!afs_fs_get_capabilities(net, server, alist, index, key))
 			afs_fs_probe_not_done(net, server, alist, index);
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 0f68d67f52c8..81eb87fbcfa7 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1387,6 +1387,39 @@ TRACE_EVENT(afs_alist,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(afs_fs_probe,
+	    TP_PROTO(struct afs_server *server, bool tx, struct afs_addr_list *alist,
+		     unsigned int addr_index, int error, s32 abort_code, unsigned int rtt_us),
+
+	    TP_ARGS(server, tx, alist, addr_index, error, abort_code, rtt_us),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		server)
+		    __field(bool,			tx)
+		    __field(u16,			addr_index)
+		    __field(short,			error)
+		    __field(s32,			abort_code)
+		    __field(unsigned int,		rtt_us)
+		    __field_struct(struct sockaddr_rxrpc, srx)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->server = server->debug_id;
+		    __entry->tx = tx;
+		    __entry->addr_index = addr_index;
+		    __entry->error = error;
+		    __entry->abort_code = abort_code;
+		    __entry->rtt_us = rtt_us;
+		    memcpy(&__entry->srx, rxrpc_kernel_remote_srx(alist->addrs[addr_index].peer),
+			   sizeof(__entry->srx));
+			   ),
+
+	    TP_printk("s=%08x %s ax=%u e=%d ac=%d rtt=%d %pISpc",
+		      __entry->server, __entry->tx ? "tx" : "rx", __entry->addr_index,
+		      __entry->error, __entry->abort_code, __entry->rtt_us,
+		      &__entry->srx.transport)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

