Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99C7E63CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjKIGWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:22:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12519A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:22:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28037d046b0so404541a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 22:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699510954; x=1700115754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIzrIC8eL3c2zlsAxARFx0go5r8mD6h6QkGzD0XcWqA=;
        b=ZF/+X9yL7/bCHG8gp91y/xrq9o0aYYuF23Igek3UnprUTtILwlvh0cbuD9aH6OVAw/
         89vildseMOfwyLGAlJv2sOJOAIuR1tuREoVZXJLw0PG7SqrKVZ/tJjb8KOmnG8Zc37xB
         V+bomDE/a3JN7QIpvt1djRo7qgkUuFsC8DFM0IwM2EX142mwQiv7yR58laTR9iflSHRr
         K9hvxDNcGQfaPmkSqy9zmUn0y3ZUnlUxfVUkQPLf3CrRndwz5Uys7qBPTlVotcDcKHyf
         ZvIwaxFdN/BtnWtQI+j65QsBcFWaFbGAudxklI5cunHx1yn0UfJpH1FhV5khh5N+RHgw
         womQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699510954; x=1700115754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIzrIC8eL3c2zlsAxARFx0go5r8mD6h6QkGzD0XcWqA=;
        b=Ts+25/OiZR/HZs05n2BDkPH/IVdA3keRQ7/M89yiQ157qNvPbfyOsW1TRtb8Uas7/l
         5QdGNKYHKO3aeQzoTChC3SXXULiHUuEODpIsrLNdwYBEWqZL5F5Ago0YSlI8/+BBZ9b5
         TdopkjdGzNUkPjACehRjJdV9V8X3d4xW5cMga4dxRNSkDH1uv/4J0l9IFggagKx9tAaq
         oRhDAqL0TIs3EAwdhdBWAebBv5OFyM1bzf7hdd0ZrO6ujY3QFtpmHgCwk0YtQ/xrEbtu
         rRuKOXZcXIBOfCaFen+EuBiyEiAADfjmZqYCFe7IbyV/ZLlgYWV3rf1Kyz1ixwS4aYQf
         6FbQ==
X-Gm-Message-State: AOJu0Yx8CTc/ITlJWygvgmMWjN7pYlv2PQ5HNIs/03aPrcVAFp7BEA0k
        amwo0nYvJO1Hnk/Yxl9W5oc=
X-Google-Smtp-Source: AGHT+IHQo3UfF3AW3DsQM3h0UAyZp7zOHnNohNqB595ZPZw8NHIauWwVr7B/BLGdSLVADycz7CODtg==
X-Received: by 2002:a17:90b:4c50:b0:27f:fcc8:9196 with SMTP id np16-20020a17090b4c5000b0027ffcc89196mr745251pjb.32.1699510953888;
        Wed, 08 Nov 2023 22:22:33 -0800 (PST)
Received: from omkarwagle.hsd1.ca.comcast.net (c-73-92-27-236.hsd1.ca.comcast.net. [73.92.27.236])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b00280a2275e4bsm525139pjb.27.2023.11.08.22.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 22:22:33 -0800 (PST)
From:   Omkar Wagle <ov.wagle@gmail.com>
To:     hughd@google.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omkar Wagle <ov.wagle@gmail.com>
Subject: [PATCH] MM: shmem: Remove code sytle warnings
Date:   Wed,  8 Nov 2023 22:22:28 -0800
Message-Id: <20231109062228.10227-1-ov.wagle@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove most of the code style warnings

Signed-off-by: Omkar Wagle<ov.wagle@gmail.com>
---
 mm/shmem.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 91e2620148b2..fce230cc5ccc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -395,6 +395,7 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
 	if (sbinfo->max_inodes) {
 		raw_spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_ispace += BOGO_INODE_SIZE + freed_ispace;
@@ -735,6 +736,7 @@ static long shmem_unused_huge_count(struct super_block *sb,
 		struct shrink_control *sc)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
 	return READ_ONCE(sbinfo->shrinklist_len);
 }
 #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
@@ -1146,9 +1148,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		return error;
 
 	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
-		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111)
 			return -EPERM;
-		}
 	}
 
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
@@ -1172,6 +1173,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		}
 		if (newsize <= oldsize) {
 			loff_t holebegin = round_up(newsize, PAGE_SIZE);
+
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
@@ -1454,6 +1456,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (!folio_test_uptodate(folio)) {
 		if (inode->i_private) {
 			struct shmem_falloc *shmem_falloc;
+
 			spin_lock(&inode->i_lock);
 			shmem_falloc = inode->i_private;
 			if (shmem_falloc &&
@@ -1527,6 +1530,7 @@ static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
 static struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 {
 	struct mempolicy *mpol = NULL;
+
 	if (sbinfo->mpol) {
 		raw_spin_lock(&sbinfo->stat_lock);	/* prevent replace/use races */
 		mpol = sbinfo->mpol;
@@ -2129,6 +2133,7 @@ static int synchronous_wake_function(wait_queue_entry_t *wait,
 			unsigned int mode, int sync, void *key)
 {
 	int ret = default_wake_function(wait, mode, sync, key);
+
 	list_del_init(&wait->entry);
 	return ret;
 }
@@ -2314,6 +2319,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
 	struct inode *inode = file_inode(vma->vm_file);
+
 	return mpol_set_shared_policy(&SHMEM_I(inode)->policy, vma, mpol);
 }
 
@@ -2681,7 +2687,7 @@ static const struct inode_operations shmem_short_symlink_operations;
 
 static int
 shmem_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
+			loff_t pos, unsigned int len,
 			struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
@@ -2716,7 +2722,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 
 static int
 shmem_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
+			loff_t pos, unsigned int len, unsigned int copied,
 			struct page *page, void *fsdata)
 {
 	struct folio *folio = page_folio(page);
@@ -2728,6 +2734,7 @@ shmem_write_end(struct file *file, struct address_space *mapping,
 	if (!folio_test_uptodate(folio)) {
 		if (copied < folio_size(folio)) {
 			size_t from = offset_in_folio(folio, pos);
+
 			folio_zero_segments(folio, 0, from,
 					from + copied, folio_size(folio));
 		}
@@ -3731,6 +3738,7 @@ static const struct xattr_handler * const shmem_xattr_handlers[] = {
 static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
+
 	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
 }
 #endif /* CONFIG_TMPFS_XATTR */
@@ -3762,6 +3770,7 @@ static int shmem_match(struct inode *ino, void *vfh)
 {
 	__u32 *fh = vfh;
 	__u64 inum = fh[2];
+
 	inum = (inum << 32) | fh[1];
 	return ino->i_ino == inum && fh[0] == ino->i_generation;
 }
@@ -3812,6 +3821,7 @@ static int shmem_encode_fh(struct inode *inode, __u32 *fh, int *len,
 		 * to do it once
 		 */
 		static DEFINE_SPINLOCK(lock);
+
 		spin_lock(&lock);
 		if (inode_unhashed(inode))
 			__insert_inode_hash(inode,
@@ -3864,20 +3874,20 @@ static const struct constant_table shmem_param_enums_huge[] = {
 
 const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("gid",		Opt_gid),
-	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
+	fsparam_enum("huge",		Opt_huge,  shmem_param_enums_huge),
 	fsparam_u32oct("mode",		Opt_mode),
 	fsparam_string("mpol",		Opt_mpol),
 	fsparam_string("nr_blocks",	Opt_nr_blocks),
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
-	fsparam_flag  ("inode32",	Opt_inode32),
-	fsparam_flag  ("inode64",	Opt_inode64),
-	fsparam_flag  ("noswap",	Opt_noswap),
+	fsparam_flag("inode32",	Opt_inode32),
+	fsparam_flag("inode64",	Opt_inode64),
+	fsparam_flag("noswap",	Opt_noswap),
 #ifdef CONFIG_TMPFS_QUOTA
-	fsparam_flag  ("quota",		Opt_quota),
-	fsparam_flag  ("usrquota",	Opt_usrquota),
-	fsparam_flag  ("grpquota",	Opt_grpquota),
+	fsparam_flag("quota",		Opt_quota),
+	fsparam_flag("usrquota",	Opt_usrquota),
+	fsparam_flag("grpquota",	Opt_grpquota),
 	fsparam_string("usrquota_block_hardlimit", Opt_usrquota_block_hardlimit),
 	fsparam_string("usrquota_inode_hardlimit", Opt_usrquota_inode_hardlimit),
 	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
@@ -4063,12 +4073,14 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
 
 	if (options) {
 		int err = security_sb_eat_lsm_opts(options, &fc->security);
+
 		if (err)
 			return err;
 	}
 
 	while (options != NULL) {
 		char *this_char = options;
+
 		for (;;) {
 			/*
 			 * NUL-terminate this option: unfortunately,
@@ -4249,7 +4261,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	shmem_show_mpol(seq, mpol);
 	mpol_put(mpol);
 	if (sbinfo->noswap)
-		seq_printf(seq, ",noswap");
+		seq_puts(seq, ",noswap");
 	return 0;
 }
 
@@ -4277,7 +4289,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	int error = -ENOMEM;
 
 	/* Round up to L1_CACHE_BYTES to resist false sharing */
-	sbinfo = kzalloc(max((int)sizeof(struct shmem_sb_info),
+	sbinfo = kzalloc(max_t((int)sizeof(struct shmem_sb_info),
 				L1_CACHE_BYTES), GFP_KERNEL);
 	if (!sbinfo)
 		return error;
@@ -4405,6 +4417,7 @@ static struct kmem_cache *shmem_inode_cachep __ro_after_init;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
+
 	info = alloc_inode_sb(sb, shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
@@ -4429,6 +4442,7 @@ static void shmem_destroy_inode(struct inode *inode)
 static void shmem_init_inode(void *foo)
 {
 	struct shmem_inode_info *info = foo;
+
 	inode_init_once(&info->vfs_inode);
 }
 
@@ -4761,6 +4775,7 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				umode_t mode, dev_t dev, unsigned long flags)
 {
 	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
+
 	return inode ? inode : ERR_PTR(-ENOSPC);
 }
 
@@ -4787,7 +4802,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 		return ERR_PTR(-EINVAL);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, flags);
+				S_IFREG | 0777, 0, flags);
 	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_CAST(inode);
@@ -4806,10 +4821,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 
 /**
  * shmem_kernel_file_setup - get an unlinked file living in tmpfs which must be
- * 	kernel internal.  There will be NO LSM permission checks against the
- * 	underlying inode.  So users of this interface must do LSM checks at a
- *	higher layer.  The users are the big_key and shm implementations.  LSM
- *	checks are provided at the key or shm level rather than the inode.
+ * kernel internal.  There will be NO LSM permission checks against the
+ * underlying inode.  So users of this interface must do LSM checks at a
+ * higher layer.  The users are the big_key and shm implementations.  LSM
+ * checks are provided at the key or shm level rather than the inode.
  * @name: name for dentry (to be seen in /proc/<pid>/maps
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
-- 
2.34.1

