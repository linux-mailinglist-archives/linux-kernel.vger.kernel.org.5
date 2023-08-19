Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866F0781620
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbjHSAav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbjHSAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BC3C38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECD362C4B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBE5C433C7;
        Sat, 19 Aug 2023 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692405014;
        bh=loHLBJTplHSzjTMzYqPI5s+M0gIJEHIdkekccoZcWr4=;
        h=From:To:Cc:Subject:Date:From;
        b=QDERvJKUOLBGJ30NnycmV/PQw/9dadQAkw0mGGW9nIT5qqwJAvrPA1I8qWVKcw7ks
         ZbVH1hhQs9j0zk22izyjzMJV9hfgatslK4jTq6y/DKWsRKFcL/s6n7kufi87+AAca2
         oHXeZoCzC7P+CUIoPXZbZ7YYwydEDI/MO8A8wfLzpdSpNX+kNnkFvWNd4u6RRs3+bJ
         La1MU7P+3ToQzQErM874yH8LFZ1K0WRx69yTNRUV0BCFcNYvNiG0KZVBzG4j/30Sjy
         Xn265qkiOWBCFHdCq+6g/bHMKSmH7uQ6p/wxhdxlO/emBBTkvWMbBplhuchycgOd7U
         D7W6Rk6xZiVug==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: avoid false alarm of circular locking
Date:   Fri, 18 Aug 2023 17:30:12 -0700
Message-ID: <20230819003012.3473675-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc5-syzkaller-00353-gae545c3283dc #0 Not tainted
------------------------------------------------------
syz-executor273/5027 is trying to acquire lock:
ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_add_inline_entry+0x300/0x6f0 fs/f2fs/inline.c:644

but task is already holding lock:
ffff888077fe07c8 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
ffff888077fe07c8 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_add_dentry+0x92/0x230 fs/f2fs/dir.c:783

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&fi->i_xattr_sem){.+.+}-{3:3}:
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
       f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
       f2fs_getxattr+0xb1e/0x12c0 fs/f2fs/xattr.c:532
       __f2fs_get_acl+0x5a/0x900 fs/f2fs/acl.c:179
       f2fs_acl_create fs/f2fs/acl.c:377 [inline]
       f2fs_init_acl+0x15c/0xb30 fs/f2fs/acl.c:420
       f2fs_init_inode_metadata+0x159/0x1290 fs/f2fs/dir.c:558
       f2fs_add_regular_entry+0x79e/0xb90 fs/f2fs/dir.c:740
       f2fs_add_dentry+0x1de/0x230 fs/f2fs/dir.c:788
       f2fs_do_add_link+0x190/0x280 fs/f2fs/dir.c:827
       f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
       f2fs_mkdir+0x377/0x620 fs/f2fs/namei.c:781
       vfs_mkdir+0x532/0x7e0 fs/namei.c:4117
       do_mkdirat+0x2a9/0x330 fs/namei.c:4140
       __do_sys_mkdir fs/namei.c:4160 [inline]
       __se_sys_mkdir fs/namei.c:4158 [inline]
       __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4158
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&fi->i_sem){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
       down_write+0x93/0x200 kernel/locking/rwsem.c:1573
       f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
       f2fs_add_inline_entry+0x300/0x6f0 fs/f2fs/inline.c:644
       f2fs_add_dentry+0xa6/0x230 fs/f2fs/dir.c:784
       f2fs_do_add_link+0x190/0x280 fs/f2fs/dir.c:827
       f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
       f2fs_mkdir+0x377/0x620 fs/f2fs/namei.c:781
       vfs_mkdir+0x532/0x7e0 fs/namei.c:4117
       ovl_do_mkdir fs/overlayfs/overlayfs.h:196 [inline]
       ovl_mkdir_real+0xb5/0x370 fs/overlayfs/dir.c:146
       ovl_workdir_create+0x3de/0x820 fs/overlayfs/super.c:309
       ovl_make_workdir fs/overlayfs/super.c:711 [inline]
       ovl_get_workdir fs/overlayfs/super.c:864 [inline]
       ovl_fill_super+0xdab/0x6180 fs/overlayfs/super.c:1400
       vfs_get_super+0xf9/0x290 fs/super.c:1152
       vfs_get_tree+0x88/0x350 fs/super.c:1519
       do_new_mount fs/namespace.c:3335 [inline]
       path_mount+0x1492/0x1ed0 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&fi->i_xattr_sem);
                               lock(&fi->i_sem);
                               lock(&fi->i_xattr_sem);
  lock(&fi->i_sem);

Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
Fixes: 5eda1ad1aaff "f2fs: fix deadlock in i_xattr_sem and inode page lock"
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h   | 24 +++++++++++++++---------
 fs/f2fs/inline.c |  3 ++-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c602ff2403b6..c0b7417f1d87 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2122,15 +2122,6 @@ static inline int f2fs_down_read_trylock(struct f2fs_rwsem *sem)
 	return down_read_trylock(&sem->internal_rwsem);
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static inline void f2fs_down_read_nested(struct f2fs_rwsem *sem, int subclass)
-{
-	down_read_nested(&sem->internal_rwsem, subclass);
-}
-#else
-#define f2fs_down_read_nested(sem, subclass) f2fs_down_read(sem)
-#endif
-
 static inline void f2fs_up_read(struct f2fs_rwsem *sem)
 {
 	up_read(&sem->internal_rwsem);
@@ -2141,6 +2132,21 @@ static inline void f2fs_down_write(struct f2fs_rwsem *sem)
 	down_write(&sem->internal_rwsem);
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline void f2fs_down_read_nested(struct f2fs_rwsem *sem, int subclass)
+{
+	down_read_nested(&sem->internal_rwsem, subclass);
+}
+
+static inline void f2fs_down_write_nested(struct f2fs_rwsem *sem, int subclass)
+{
+	down_write_nested(&sem->internal_rwsem, subclass);
+}
+#else
+#define f2fs_down_read_nested(sem, subclass) f2fs_down_read(sem)
+#define f2fs_down_write_nested(sem, subclass) f2fs_down_write(sem)
+#endif
+
 static inline int f2fs_down_write_trylock(struct f2fs_rwsem *sem)
 {
 	return down_write_trylock(&sem->internal_rwsem);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4638fee16a91..0d185ad5e469 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -641,7 +641,8 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 	}
 
 	if (inode) {
-		f2fs_down_write(&F2FS_I(inode)->i_sem);
+		f2fs_down_write_nested(&F2FS_I(inode)->i_sem,
+						SINGLE_DEPTH_NESTING);
 		page = f2fs_init_inode_metadata(inode, dir, fname, ipage);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
-- 
2.42.0.rc1.204.g551eb34607-goog

