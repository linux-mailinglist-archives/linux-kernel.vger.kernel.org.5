Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D1801C4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjLBKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:49:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D81124;
        Sat,  2 Dec 2023 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=F8PhHlQpw1agE8e4gUoZBwCoedJwGCZUllve+ZMs9lU=; t=1701514184; x=1702723784; 
        b=FEcmzQh0bsIjqk6r5t6yevD+khvz0zRxqI/Z8MWgdf23sUSCiyk43o3BM9PqKEyalOwcHEaIfyy
        DNZqH03AVZbpgEk4oCoBqxwRY2mNAAxwTw16oCn72GLqUUSAXhPbWi3/3VqqAwEHwu1/RQvFryYBs
        ufe1zCpDMIve+8rsG6ZlGl1hLz8wLrUmHMB+qzi48aIisx7DEF6p66nVf/gi0N+aMHsoxuhtWEW2F
        dh9SEIR/hNoPEqpYmm6isFSsDvFaUCCVLarxGQocf26lQBR91jv7djvLD0e7wG6MIjLzOXrZ4omev
        eTAXFa37SnH+v2NgaSEiisljkw/WWrkNh1fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r9NZ7-0000000CR3d-3PqU;
        Sat, 02 Dec 2023 11:49:42 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] Revert "debugfs: annotate debugfs handlers vs. removal with lockdep"
Date:   Sat,  2 Dec 2023 11:49:37 +0100
Message-ID: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit f4acfcd4deb1 ("debugfs: annotate debugfs handlers
vs. removal with lockdep"), it appears to have false positives and
really shouldn't have been in the -rc series with the fixes anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     | 10 ----------
 fs/debugfs/inode.c    |  7 -------
 fs/debugfs/internal.h |  6 ------
 3 files changed, 23 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a5ade8c16375..5063434be0fc 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -108,12 +108,6 @@ int debugfs_file_get(struct dentry *dentry)
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
-#ifdef CONFIG_LOCKDEP
-		fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
-		lockdep_register_key(&fsd->key);
-		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
-				 &fsd->key, 0);
-#endif
 		INIT_LIST_HEAD(&fsd->cancellations);
 		mutex_init(&fsd->cancellations_mtx);
 	}
@@ -132,8 +126,6 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!refcount_inc_not_zero(&fsd->active_users))
 		return -EIO;
 
-	lock_map_acquire_read(&fsd->lockdep_map);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debugfs_file_get);
@@ -151,8 +143,6 @@ void debugfs_file_put(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = READ_ONCE(dentry->d_fsdata);
 
-	lock_map_release(&fsd->lockdep_map);
-
 	if (refcount_dec_and_test(&fsd->active_users))
 		complete(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e4e7fe1bd9fb..034a617cb1a5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -243,10 +243,6 @@ static void debugfs_release_dentry(struct dentry *dentry)
 
 	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
 	if (fsd && fsd->real_fops) {
-#ifdef CONFIG_LOCKDEP
-		lockdep_unregister_key(&fsd->key);
-		kfree(fsd->lock_name);
-#endif
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
@@ -755,9 +751,6 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	lock_map_acquire(&fsd->lockdep_map);
-	lock_map_release(&fsd->lockdep_map);
-
 	/* if we hit zero, just wait for all to finish */
 	if (!refcount_dec_and_test(&fsd->active_users)) {
 		wait_for_completion(&fsd->active_users_drained);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 0c4c68cf161f..dae80c2a469e 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,7 +7,6 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
-#include <linux/lockdep.h>
 #include <linux/list.h>
 
 struct file_operations;
@@ -25,11 +24,6 @@ struct debugfs_fsdata {
 		struct {
 			refcount_t active_users;
 			struct completion active_users_drained;
-#ifdef CONFIG_LOCKDEP
-			struct lockdep_map lockdep_map;
-			struct lock_class_key key;
-			char *lock_name;
-#endif
 
 			/* protect cancellations */
 			struct mutex cancellations_mtx;
-- 
2.43.0

