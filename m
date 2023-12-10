Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE980B9FA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjLJJVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjLJJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117AA11A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:20:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79378C433C9;
        Sun, 10 Dec 2023 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702200056;
        bh=BjltPLVDTqSnWr9yrzT9LGYq3m8ffUZKi+SKLGr20ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ym7Re/0FEavQLP5slXvCbzQnjUi0GthG8VNGQYE+0JCOAMo6vdFGa4yWxtFKBBzo3
         b1s0tJK5bocfJeWdBsmpfuyemVDJJWqf6BaiM9QDqjAHBAXweky3SETt+rHTBNGVMD
         7Amm0TM0/D8srUZdU6RgfWOMdmOwVKjEftXL+v77Luu2sxU2iTW+5Y7R2+2KEbmE1S
         QDzfhjJtM0OxeYJqF5SUZSRpiUp6oHlG7O8KAEDt3y3a0eCrlzhb3nc54QEtPEWt4R
         xtWISNMIzEDZAbAL/4SZEEIZlWnbaFCHkMj0nWfjql0rGhlWYkHysZ1F0YrkF0EKAm
         UwBaF0MGJNWvQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 6/6] f2fs: add tracepoint for f2fs_vm_page_mkwrite()
Date:   Sun, 10 Dec 2023 17:20:40 +0800
Message-Id: <20231210092040.3374741-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210092040.3374741-1-chao@kernel.org>
References: <20231210092040.3374741-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to support tracepoint for f2fs_vm_page_mkwrite(),
meanwhile it prints more details for trace_f2fs_filemap_fault().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c              | 25 ++++++++++++++----------
 include/trace/events/f2fs.h | 39 ++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c7e6bfc1265..60290940018d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -46,7 +46,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
-	trace_f2fs_filemap_fault(inode, vmf->pgoff, (unsigned long)ret);
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma->vm_flags, ret);
 
 	return ret;
 }
@@ -59,26 +59,29 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct dnode_of_data dn;
 	bool need_alloc = true;
 	int err = 0;
+	vm_fault_t ret;
 
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
-		return VM_FAULT_SIGBUS;
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		err = -EIO;
+		goto out;
+	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
-		goto err;
+		goto out;
 	}
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
 		err = -ENOSPC;
-		goto err;
+		goto out;
 	}
 
 	err = f2fs_convert_inline_inode(inode);
 	if (err)
-		goto err;
+		goto out;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
@@ -86,7 +89,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 		if (ret < 0) {
 			err = ret;
-			goto err;
+			goto out;
 		} else if (ret) {
 			need_alloc = false;
 		}
@@ -153,13 +156,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
 	f2fs_update_time(sbi, REQ_TIME);
 
-	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	sb_end_pagefault(inode->i_sb);
-err:
-	return vmf_fs_error(err);
+out:
+	ret = vmf_fs_error(err);
+
+	trace_f2fs_vm_page_mkwrite(inode, page->index, vmf->vma->vm_flags, ret);
+	return ret;
 }
 
 static const struct vm_operations_struct f2fs_file_vm_ops = {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 479d26eae22f..7ed0fc430dc6 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1369,13 +1369,6 @@ DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
 	TP_ARGS(page, type)
 );
 
-DEFINE_EVENT(f2fs__page, f2fs_vm_page_mkwrite,
-
-	TP_PROTO(struct page *page, int type),
-
-	TP_ARGS(page, type)
-);
-
 TRACE_EVENT(f2fs_replace_atomic_write_block,
 
 	TP_PROTO(struct inode *inode, struct inode *cow_inode, pgoff_t index,
@@ -1413,30 +1406,50 @@ TRACE_EVENT(f2fs_replace_atomic_write_block,
 		__entry->recovery)
 );
 
-TRACE_EVENT(f2fs_filemap_fault,
+DECLARE_EVENT_CLASS(f2fs_mmap,
 
-	TP_PROTO(struct inode *inode, pgoff_t index, unsigned long ret),
+	TP_PROTO(struct inode *inode, pgoff_t index,
+			vm_flags_t flags, vm_fault_t ret),
 
-	TP_ARGS(inode, index, ret),
+	TP_ARGS(inode, index, flags, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(pgoff_t, index)
-		__field(unsigned long, ret)
+		__field(vm_flags_t, flags)
+		__field(vm_fault_t, ret)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->index	= index;
+		__entry->flags	= flags;
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, flags: %s, ret: %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
-		__entry->ret)
+		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
+		__print_flags(__entry->ret, "|", VM_FAULT_RESULT_TRACE))
+);
+
+DEFINE_EVENT(f2fs_mmap, f2fs_filemap_fault,
+
+	TP_PROTO(struct inode *inode, pgoff_t index,
+			vm_flags_t flags, vm_fault_t ret),
+
+	TP_ARGS(inode, index, flags, ret)
+);
+
+DEFINE_EVENT(f2fs_mmap, f2fs_vm_page_mkwrite,
+
+	TP_PROTO(struct inode *inode, pgoff_t index,
+			vm_flags_t flags, vm_fault_t ret),
+
+	TP_ARGS(inode, index, flags, ret)
 );
 
 TRACE_EVENT(f2fs_writepages,
-- 
2.40.1

