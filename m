Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680DA7EE4B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjKPPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbjKPPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D6EA5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700150003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBtmW26NACg/zkvKRteyy2dwMoZgoN+rImCko2BBVsI=;
        b=GIzAp9CueYxXEpyYLZAK+qZhLtSH+5fGLor9Et5SssjrmLcB6euXRCYd01aVpUqO6X78XX
        4hK8uQclXMskt8LcuBFdqJY/IxKtl4FInGs4fQmNowmAO89Hdmmaj4nBXfFLh9diFyHPTa
        nBlm1WhEogwf/74l5KfhS4Whzk0xu8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-swb9e4RHNRiu82WXFOgmFg-1; Thu,
 16 Nov 2023 10:53:21 -0500
X-MC-Unique: swb9e4RHNRiu82WXFOgmFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29FDB280A9C4;
        Thu, 16 Nov 2023 15:53:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 420CB1121307;
        Thu, 16 Nov 2023 15:53:20 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Suvanto <markus.suvanto@gmail.com>
Subject: [PATCH 3/5] afs: Return ENOENT if no cell DNS record can be found
Date:   Thu, 16 Nov 2023 15:53:10 +0000
Message-ID: <20231116155312.156593-4-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-1-dhowells@redhat.com>
References: <20231116155312.156593-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make AFS return error ENOENT if no cell SRV or AFSDB DNS record (or
cellservdb config file record) can be found rather than returning
EDESTADDRREQ.

Also add cell name lookup info to the cursor dump.

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/vl_rotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 488e58490b16..eb415ce56360 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		}
 
 		/* Status load is ordered after lookup counter load */
+		if (cell->dns_status == DNS_LOOKUP_GOT_NOT_FOUND) {
+			pr_warn("No record of cell %s\n", cell->name);
+			vc->error = -ENOENT;
+			return false;
+		}
+
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			vc->error = -EDESTADDRREQ;
 			return false;
@@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
  */
 static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 {
+	struct afs_cell *cell = vc->cell;
 	static int count;
 	int i;
 
@@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
+	pr_notice("CELL: %s err=%d\n", cell->name, cell->error);
+	pr_notice("DNS: src=%u st=%u lc=%x\n",
+		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
 		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 

