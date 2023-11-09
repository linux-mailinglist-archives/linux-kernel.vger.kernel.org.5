Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07D7E6DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjKIPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjKIPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267833854
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkHLclgAySu72dDeE8z00MhD/x3hiDNbRYMLjePsRMs=;
        b=EjoFOcAU2coi2sRdu2gHmGxDXFTVTC7QgRVNbF8aEgFtTGMTbnVI5YaIT9IIyGW/rDYxJU
        1QWkcqrQe9LaShU2dDqjkcWPtYSRHGiQgGP9WHWuGMuWoXy0i/pU58T0WNWQPIOmYvfRe1
        9hAQ8UEjuqPvG05QP/ZHWhwiUrvUfv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-XJLfkXJRNEaI0boDdyPoQA-1; Thu,
 09 Nov 2023 10:41:04 -0500
X-MC-Unique: XJLfkXJRNEaI0boDdyPoQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C9C31C0F497;
        Thu,  9 Nov 2023 15:41:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 433F819E94;
        Thu,  9 Nov 2023 15:41:03 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/41] afs: Combine the endpoint state bools into a bitmask
Date:   Thu,  9 Nov 2023 15:39:54 +0000
Message-ID: <20231109154004.3317227-32-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the endpoint state bool-type members into a bitmask so that some of
them can be waited upon more easily.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_probe.c | 30 +++++++++++++++---------------
 fs/afs/internal.h | 12 ++++++------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index a669aee033c5..c00d38b98a67 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -77,7 +77,7 @@ static void afs_schedule_fs_probe(struct afs_net *net,
 static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server,
 				  struct afs_endpoint_state *estate)
 {
-	bool responded = estate->responded;
+	bool responded = test_bit(AFS_ESTATE_RESPONDED, &estate->flags);
 
 	write_seqlock(&net->fs_lock);
 	if (responded) {
@@ -121,7 +121,7 @@ static void afs_fs_probe_not_done(struct afs_net *net,
 	trace_afs_io_error(0, -ENOMEM, afs_io_error_fs_probe_fail);
 	spin_lock(&server->probe_lock);
 
-	estate->local_failure = true;
+	set_bit(AFS_ESTATE_LOCAL_FAILURE, &estate->flags);
 	if (estate->error == 0)
 		estate->error = -ENOMEM;
 
@@ -156,7 +156,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 		estate->error = 0;
 		goto responded;
 	case -ECONNABORTED:
-		if (!estate->responded) {
+		if (!test_bit(AFS_ESTATE_RESPONDED, &estate->flags)) {
 			estate->abort_code = call->abort_code;
 			estate->error = ret;
 		}
@@ -164,7 +164,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	case -ENOMEM:
 	case -ENONET:
 		clear_bit(index, &estate->responsive_set);
-		estate->local_failure = true;
+		set_bit(AFS_ESTATE_LOCAL_FAILURE, &estate->flags);
 		trace_afs_io_error(call->debug_id, ret, afs_io_error_fs_probe_fail);
 		goto out;
 	case -ECONNRESET: /* Responded, but call expired. */
@@ -179,7 +179,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	default:
 		clear_bit(index, &estate->responsive_set);
 		set_bit(index, &estate->failed_set);
-		if (!estate->responded &&
+		if (!test_bit(AFS_ESTATE_RESPONDED, &estate->flags) &&
 		    (estate->error == 0 ||
 		     estate->error == -ETIMEDOUT ||
 		     estate->error == -ETIME))
@@ -192,13 +192,13 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	clear_bit(index, &estate->failed_set);
 
 	if (call->service_id == YFS_FS_SERVICE) {
-		estate->is_yfs = true;
+		set_bit(AFS_ESTATE_IS_YFS, &estate->flags);
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
 		server->service_id = call->service_id;
 	} else {
-		estate->not_yfs = true;
-		if (!estate->is_yfs) {
-			estate->is_yfs = false;
+		set_bit(AFS_ESTATE_NOT_YFS, &estate->flags);
+		if (!test_bit(AFS_ESTATE_IS_YFS, &estate->flags)) {
+			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
 			server->service_id = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
@@ -216,7 +216,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	}
 
 	smp_wmb(); /* Set rtt before responded. */
-	estate->responded = true;
+	set_bit(AFS_ESTATE_RESPONDED, &estate->flags);
 	set_bit(index, &estate->responsive_set);
 	set_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 out:
@@ -264,7 +264,7 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	atomic_set(&estate->nr_probing, alist->nr_addrs);
 
 	rcu_assign_pointer(server->endpoint_state, estate);
-	old->superseded = true;
+	set_bit(AFS_ESTATE_SUPERSEDED, &old->flags);
 	write_unlock(&server->fs_lock);
 
 	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
@@ -317,7 +317,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 			estate = rcu_dereference(server->endpoint_state);
 			if (!atomic_read(&estate->nr_probing))
 				__clear_bit(i, &untried);
-			if (estate->responded)
+			if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
 				have_responders = true;
 		}
 	}
@@ -344,7 +344,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 		for (i = 0; i < slist->nr_servers; i++) {
 			if (test_bit(i, &untried)) {
 				server = slist->servers[i].server;
-				if (estate->responded)
+				if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
 					goto stop;
 				if (atomic_read(&estate->nr_probing))
 					still_probing = true;
@@ -521,7 +521,7 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 		prepare_to_wait_event(&server->probe_wq, &wait,
 				      is_intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 		if (timo == 0 ||
-		    estate->responded ||
+		    test_bit(AFS_ESTATE_RESPONDED, &estate->flags) ||
 		    atomic_read(&estate->nr_probing) == 0 ||
 		    (is_intr && signal_pending(current)))
 			break;
@@ -531,7 +531,7 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 	finish_wait(&server->probe_wq, &wait);
 
 dont_wait:
-	if (estate->responded)
+	if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
 		return 0;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 259efeeee235..8410ec4d6035 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -534,16 +534,16 @@ struct afs_endpoint_state {
 	refcount_t		ref;
 	unsigned int		server_id;	/* Debug ID of server */
 	unsigned int		probe_seq;	/* Probe sequence (from server::probe_counter) */
-
 	atomic_t		nr_probing;	/* Number of outstanding probes */
 	unsigned int		rtt;		/* Best RTT in uS (or UINT_MAX) */
 	s32			abort_code;
 	short			error;
-	bool			responded:1;
-	bool			is_yfs:1;
-	bool			not_yfs:1;
-	bool			local_failure:1;
-	bool			superseded:1;	/* Set if has been superseded */
+	unsigned long		flags;
+#define AFS_ESTATE_RESPONDED	0		/* Set if the server responded */
+#define AFS_ESTATE_SUPERSEDED	1		/* Set if this record has been superseded */
+#define AFS_ESTATE_IS_YFS	2		/* Set if probe upgraded to YFS */
+#define AFS_ESTATE_NOT_YFS	3		/* Set if probe didn't upgrade to YFS */
+#define AFS_ESTATE_LOCAL_FAILURE 4		/* Set if there was a local failure (eg. ENOMEM) */
 };
 
 /*

