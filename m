Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E49811367
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379293AbjLMNu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbjLMNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285DB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGRxelYCarwZFCdsruOcKzXx+k/Lsiw8QpTx9fiIyV8=;
        b=XcfflpopNYQdMtcKBlR5gkYM/0E2JHIHIyEU2Fn0mNoqPlrXtxXWX+XcewtQgOQSLm3A2O
        iZ9OVMuMnFwrynFQ3U5mMF02fZJ87VatPx9ltCy27/CYFyZQmUUqTKgTfCBa16m1cF/rU0
        zQ8udcs1Dpf9KTGm9U/S6083HY8uqm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--tjJTyOvNL-wvKFQeFZxRQ-1; Wed, 13 Dec 2023 08:50:18 -0500
X-MC-Unique: -tjJTyOvNL-wvKFQeFZxRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1C7E85A589;
        Wed, 13 Dec 2023 13:50:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17E982166B31;
        Wed, 13 Dec 2023 13:50:16 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey E Altman <jaltman@auristor.com>
Subject: [PATCH v2 07/40] afs: Add comments on abort handling
Date:   Wed, 13 Dec 2023 13:49:29 +0000
Message-ID: <20231213135003.367397-8-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some comments on AFS abort code handling in the rotation algorithm and
adjust the errors produced to match.

Reported-by: Jeffrey E Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c | 101 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a840c3588ebb..a3d127953ac6 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -13,6 +13,7 @@
 #include <linux/sched/signal.h>
 #include "internal.h"
 #include "afs_fs.h"
+#include "protocol_uae.h"
 
 /*
  * Begin iteration through a server list, starting with the vnode's last used
@@ -143,6 +144,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 	case -ECONNABORTED:
 		/* The far side rejected the operation on some grounds.  This
 		 * might involve the server being busy or the volume having been moved.
+		 *
+		 * Note that various V* errors should not be sent to a cache manager
+		 * by a fileserver as they should be translated to more modern UAE*
+		 * errors instead.  IBM AFS and OpenAFS fileservers, however, do leak
+		 * these abort codes.
 		 */
 		switch (op->ac.abort_code) {
 		case VNOVOL:
@@ -150,6 +156,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * - May indicate that the VL is wrong - retry once and compare
 			 *   the results.
 			 * - May indicate that the fileserver couldn't attach to the vol.
+			 * - The volume might have been temporarily removed so that it can
+			 *   be replaced by a volume restore.  "vos" might have ended one
+			 *   transaction and has yet to create the next.
+			 * - The volume might not be blessed or might not be in-service
+			 *   (administrative action).
 			 */
 			if (op->flags & AFS_OPERATION_VNOVOL) {
 				op->error = -EREMOTEIO;
@@ -183,16 +194,56 @@ bool afs_select_fileserver(struct afs_operation *op)
 			_leave(" = t [vnovol]");
 			return true;
 
-		case VSALVAGE: /* TODO: Should this return an error or iterate? */
 		case VVOLEXISTS:
-		case VNOSERVICE:
 		case VONLINE:
-		case VDISKFULL:
-		case VOVERQUOTA:
-			op->error = afs_abort_to_error(op->ac.abort_code);
+			/* These should not be returned from the fileserver. */
+			pr_warn("Fileserver returned unexpected abort %d\n",
+				op->ac.abort_code);
+			op->error = -EREMOTEIO;
+			goto next_server;
+
+		case VNOSERVICE:
+			/* Prior to AFS 3.2 VNOSERVICE was returned from the fileserver
+			 * if the volume was neither in-service nor administratively
+			 * blessed.  All usage was replaced by VNOVOL because AFS 3.1 and
+			 * earlier cache managers did not handle VNOSERVICE and assumed
+			 * it was the client OSes errno 105.
+			 *
+			 * Starting with OpenAFS 1.4.8 VNOSERVICE was repurposed as the
+			 * fileserver idle dead time error which was sent in place of
+			 * RX_CALL_TIMEOUT (-3).  The error was intended to be sent if the
+			 * fileserver took too long to send a reply to the client.
+			 * RX_CALL_TIMEOUT would have caused the cache manager to mark the
+			 * server down whereas VNOSERVICE since AFS 3.2 would cause cache
+			 * manager to temporarily (up to 15 minutes) mark the volume
+			 * instance as unusable.
+			 *
+			 * The idle dead logic resulted in cache inconsistency since a
+			 * state changing call that the cache manager assumed was dead
+			 * could still be processed to completion by the fileserver.  This
+			 * logic was removed in OpenAFS 1.8.0 and VNOSERVICE is no longer
+			 * returned.  However, many 1.4.8 through 1.6.24 fileservers are
+			 * still in existence.
+			 *
+			 * AuriStorFS fileservers have never returned VNOSERVICE.
+			 *
+			 * VNOSERVICE should be treated as an alias for RX_CALL_TIMEOUT.
+			 */
+		case RX_CALL_TIMEOUT:
+			op->error = -ETIMEDOUT;
 			goto next_server;
 
+		case VSALVAGING: /* This error should not be leaked to cache managers
+				  * but is from OpenAFS demand attach fileservers.
+				  * It should be treated as an alias for VOFFLINE.
+				  */
+		case VSALVAGE: /* VSALVAGE should be treated as a synonym of VOFFLINE */
 		case VOFFLINE:
+			/* The volume is in use by the volserver or another volume utility
+			 * for an operation that might alter the contents.  The volume is
+			 * expected to come back but it might take a long time (could be
+			 * days).
+			 */
 			if (!test_and_set_bit(AFS_VOLUME_OFFLINE, &op->volume->flags)) {
 				afs_busy(op->volume, op->ac.abort_code);
 				clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
@@ -207,11 +258,20 @@ bool afs_select_fileserver(struct afs_operation *op)
 			}
 			goto busy;
 
-		case VSALVAGING:
-		case VRESTARTING:
+		case VRESTARTING: /* The fileserver is either shutting down or starting up. */
 		case VBUSY:
-			/* Retry after going round all the servers unless we
-			 * have a file lock we need to maintain.
+			/* The volume is in use by the volserver or another volume
+			 * utility for an operation that is not expected to alter the
+			 * contents of the volume.  VBUSY does not need to be returned
+			 * for a ROVOL or BACKVOL bound to an ITBusy volserver
+			 * transaction.  The fileserver is permitted to continue serving
+			 * content from ROVOLs and BACKVOLs during an ITBusy transaction
+			 * because the content will not change.  However, many fileserver
+			 * releases do return VBUSY for ROVOL and BACKVOL instances under
+			 * many circumstances.
+			 *
+			 * Retry after going round all the servers unless we have a file
+			 * lock we need to maintain.
 			 */
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
 				op->error = -EBUSY;
@@ -226,7 +286,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 				if (!afs_sleep_and_retry(op))
 					goto failed;
 
-				 /* Retry with same server & address */
+				/* Retry with same server & address */
 				_leave(" = t [vbusy]");
 				return true;
 			}
@@ -270,10 +330,29 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			goto restart_from_beginning;
 
+		case VDISKFULL:
+		case UAENOSPC:
+			/* The partition is full.  Only applies to RWVOLs.
+			 * Translate locally and return ENOSPC.
+			 * No replicas to failover to.
+			 */
+			op->error = -ENOSPC;
+			goto failed_but_online;
+
+		case VOVERQUOTA:
+		case UAEDQUOT:
+			/* Volume is full.  Only applies to RWVOLs.
+			 * Translate locally and return EDQUOT.
+			 * No replicas to failover to.
+			 */
+			op->error = -EDQUOT;
+			goto failed_but_online;
+
 		default:
+			op->error = afs_abort_to_error(op->ac.abort_code);
+		failed_but_online:
 			clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
 			clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
-			op->error = afs_abort_to_error(op->ac.abort_code);
 			goto failed;
 		}
 

