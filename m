Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0F8113B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379249AbjLMNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379362AbjLMNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E0C1725
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6hid3YRr4Ej4toqLI+tj94dzeJmRJqcEJFRHPpyqoA=;
        b=QnUwwWl7O0sUh9cqEj7DRCxXqS8SfhNmFdpL0yPKOxXd85K8Lp8vBawYXndIg6uYDts8G3
        le1YKGyhT2GEVxtsjTbPmjjB8PuGnXCavFCL/MD2X3zlHkixVBtrnf6XOQImPEOmNdfSY8
        yUrWU2Vcb/nVAAIq2d6C4Pjchjj119I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-iVedxFAsO4SnDiTzLb4Iew-1; Wed,
 13 Dec 2023 08:51:09 -0500
X-MC-Unique: iVedxFAsO4SnDiTzLb4Iew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B316D3C2A1CD;
        Wed, 13 Dec 2023 13:51:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E88792166B31;
        Wed, 13 Dec 2023 13:51:07 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/40] afs: Fix offline and busy message emission
Date:   Wed, 13 Dec 2023 13:50:01 +0000
Message-ID: <20231213135003.367397-40-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that offline and busy volume states apply to all
instances of a volume, not just the one on the server that returned
VOFFLINE or VBUSY and will emit a notice to dmesg suggesting that the
entire volume is unavailable.

Fix that by moving the flags recording this to the afs_server_entry struct
that is used to represent a particular instance of a volume on a specific
server.  The notice is altered to include the server UUID also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h |  8 ++++----
 fs/afs/rotate.c   | 31 +++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e3e373c1fecf..a6a4fc417dba 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -612,6 +612,8 @@ struct afs_server_entry {
 	time64_t		cb_expires_at;	/* Time at which volume-level callback expires */
 	unsigned long		flags;
 #define AFS_SE_EXCLUDED		0		/* Set if server is to be excluded in rotation */
+#define AFS_SE_VOLUME_OFFLINE	1		/* Set if volume offline notice given */
+#define AFS_SE_VOLUME_BUSY	2		/* Set if volume busy notice given */
 };
 
 struct afs_server_list {
@@ -645,10 +647,8 @@ struct afs_volume {
 #define AFS_VOLUME_UPDATING	1	/* - T if an update is in progress */
 #define AFS_VOLUME_WAIT		2	/* - T if users must wait for update */
 #define AFS_VOLUME_DELETED	3	/* - T if volume appears deleted */
-#define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
-#define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
-#define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
-#define AFS_VOLUME_RM_TREE	7	/* - Set if volume removed from cell->volumes */
+#define AFS_VOLUME_MAYBE_NO_IBULK 4	/* - T if some servers don't have InlineBulkStatus */
+#define AFS_VOLUME_RM_TREE	5	/* - Set if volume removed from cell->volumes */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_volume	*cache;		/* Caching cookie */
 #endif
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ef7fe70777be..700a27bc8c25 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -111,7 +111,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 /*
  * Post volume busy note.
  */
-static void afs_busy(struct afs_volume *volume, u32 abort_code)
+static void afs_busy(struct afs_operation *op, u32 abort_code)
 {
 	const char *m;
 
@@ -122,7 +122,8 @@ static void afs_busy(struct afs_volume *volume, u32 abort_code)
 	default:		m = "busy";		break;
 	}
 
-	pr_notice("kAFS: Volume %llu '%s' is %s\n", volume->vid, volume->name, m);
+	pr_notice("kAFS: Volume %llu '%s' on server %pU is %s\n",
+		  op->volume->vid, op->volume->name, &op->server->uuid, m);
 }
 
 /*
@@ -181,6 +182,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (op->call_error) {
 	case 0:
+		clear_bit(AFS_SE_VOLUME_OFFLINE,
+			  &op->server_list->servers[op->server_index].flags);
+		clear_bit(AFS_SE_VOLUME_BUSY,
+			  &op->server_list->servers[op->server_index].flags);
 		op->cumul_error.responded = true;
 
 		/* We succeeded, but we may need to redo the op from another
@@ -314,9 +319,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * expected to come back but it might take a long time (could be
 			 * days).
 			 */
-			if (!test_and_set_bit(AFS_VOLUME_OFFLINE, &op->volume->flags)) {
-				afs_busy(op->volume, abort_code);
-				clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
+			if (!test_and_set_bit(AFS_SE_VOLUME_OFFLINE,
+					      &op->server_list->servers[op->server_index].flags)) {
+				afs_busy(op, abort_code);
+				clear_bit(AFS_SE_VOLUME_BUSY,
+					  &op->server_list->servers[op->server_index].flags);
 			}
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
 				afs_op_set_error(op, -EADV);
@@ -343,9 +350,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 				afs_op_set_error(op, -EBUSY);
 				goto failed;
 			}
-			if (!test_and_set_bit(AFS_VOLUME_BUSY, &op->volume->flags)) {
-				afs_busy(op->volume, abort_code);
-				clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
+			if (!test_and_set_bit(AFS_SE_VOLUME_BUSY,
+					      &op->server_list->servers[op->server_index].flags)) {
+				afs_busy(op, abort_code);
+				clear_bit(AFS_SE_VOLUME_OFFLINE,
+					  &op->server_list->servers[op->server_index].flags);
 			}
 		busy:
 			if (op->flags & AFS_OPERATION_CUR_ONLY) {
@@ -426,8 +435,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 		default:
 			afs_op_accumulate_error(op, error, abort_code);
 		failed_but_online:
-			clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
-			clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
+			clear_bit(AFS_SE_VOLUME_OFFLINE,
+				  &op->server_list->servers[op->server_index].flags);
+			clear_bit(AFS_SE_VOLUME_BUSY,
+				  &op->server_list->servers[op->server_index].flags);
 			goto failed;
 		}
 

