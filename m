Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C82804041
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjLDUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjLDUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:39:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219830EB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:37:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC688C433CB;
        Mon,  4 Dec 2023 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722232;
        bh=YG5kSmy3zxV7lk5TGHhnO7aXEDqYB5J2IlxEh/BTI/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYjOlun1Lfm4pOme4ujPkK2a/PzdAmi0bN9kSQaA+jeviZg1Ilmv9mB3e0omfuHtf
         1/hWSATHfzTK6yNIYhQjosfW6R325Mn3+BzNKoh8MxNbaj7aqBT80md4MMpDKxDWyz
         Fe9l/dZm7OHYXso7CWg3+br2FUh1Qlo9Rzuqr1Z2mZtZJjnfVus12lo8l6MtVVDYFZ
         IuKbCHmG6e45zz6hvfQLDiBNOuor2OdN0VuucFhh0moDw8eV2xIOPanrj2MEOnC1Xj
         CXGmgTTF9T7OpxDADeRXzY674B+OV2snzc2+0lzAhx3f0Ok4Kli2vqqLsUKYPDgmrO
         7mUokxbdVAhkw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 5/7] debugfs: annotate debugfs handlers vs. removal with lockdep
Date:   Mon,  4 Dec 2023 15:36:48 -0500
Message-ID: <20231204203656.2094777-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f4acfcd4deb158b96595250cc332901b282d15b0 ]

When you take a lock in a debugfs handler but also try
to remove the debugfs file under that lock, things can
deadlock since the removal has to wait for all users
to finish.

Add lockdep annotations in debugfs_file_get()/_put()
to catch such issues.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c     | 10 ++++++++++
 fs/debugfs/inode.c    | 12 ++++++++++++
 fs/debugfs/internal.h |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 9c0aadedfbffe..6bc55a5174469 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -108,6 +108,12 @@ int debugfs_file_get(struct dentry *dentry)
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
+#ifdef CONFIG_LOCKDEP
+		fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
+		lockdep_register_key(&fsd->key);
+		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
+				 &fsd->key, 0);
+#endif
 	}
 
 	/*
@@ -124,6 +130,8 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!refcount_inc_not_zero(&fsd->active_users))
 		return -EIO;
 
+	lock_map_acquire_read(&fsd->lockdep_map);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debugfs_file_get);
@@ -141,6 +149,8 @@ void debugfs_file_put(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = READ_ONCE(dentry->d_fsdata);
 
+	lock_map_release(&fsd->lockdep_map);
+
 	if (refcount_dec_and_test(&fsd->active_users))
 		complete(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index d04930c199cb4..001d5e2513aaa 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -215,6 +215,14 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
+	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
+	if (fsd && fsd->real_fops) {
+#ifdef CONFIG_LOCKDEP
+		lockdep_unregister_key(&fsd->key);
+		kfree(fsd->lock_name);
+#endif
+	}
+
 	kfree(fsd);
 }
 
@@ -708,6 +716,10 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	fsd = READ_ONCE(dentry->d_fsdata);
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
+
+	lock_map_acquire(&fsd->lockdep_map);
+	lock_map_release(&fsd->lockdep_map);
+
 	if (!refcount_dec_and_test(&fsd->active_users))
 		wait_for_completion(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f7c489b5a368c..c7d61cfc97d26 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,6 +7,7 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
+#include <linux/lockdep.h>
 
 struct file_operations;
 
@@ -23,6 +24,11 @@ struct debugfs_fsdata {
 		struct {
 			refcount_t active_users;
 			struct completion active_users_drained;
+#ifdef CONFIG_LOCKDEP
+			struct lockdep_map lockdep_map;
+			struct lock_class_key key;
+			char *lock_name;
+#endif
 		};
 	};
 };
-- 
2.42.0

