Return-Path: <linux-kernel+bounces-104131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20087C981
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ECE28350B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC214A85;
	Fri, 15 Mar 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEkvEfxq"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14314280
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489596; cv=none; b=Kojbb00QiuhXqTC4SERqKvL1H426n7UY2kRZiCf/jEN9mEYZcCzPsat3AiXTI0z1ehtcSxBtKy7DbunkEge5kmPbqNCvgYiJxSgNRN9FGp7RTb+PXgY2Oltc0fIJsVFfcu7hNZ5LbHgLcK8tZB8K2iOjrdJZq+hw+ibcZjVQ82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489596; c=relaxed/simple;
	bh=8NBYXkgbWm1ldm5E/QICRYLF4GE76XfiXsz0/a1acYc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TGEcJyh24il2IDBFT9hrN0Xxah8NnsGrALhjuBzZbK7izWgI1NVgRIDpzAhagY8Hyarexy22nLKPHDy7R2Lzj0a4SYr0QvO7qWuGJSD61ZPjrr1SY9UhnZD9MmBsMcKglKQURDos4bQlN1m/K3izwG/NjmrgOPraA19UQGcAHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEkvEfxq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so1415939a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710489593; x=1711094393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+q0RWAo5V4NGnWLCMD0VeyK5GzSO5WOFdbw6bveQeY=;
        b=XEkvEfxqxhaVhmY+R110zIAdXJL/aCLFFq4VSYxllHa+kOfL0aQRNY6SgfcDFaHQwW
         OFua5Uoyn97PbGpwlTJ6En5PprqTgM+KuWZ+7Z4QN9lrZMze1zDMuqDu0bcQR8tziLNC
         26JOSatsbpm7iSGBU6HpNcQQA2tM4xGbVZlAN86iLfG7pA63qs6OPrUnfnQbim6O3jVW
         nDvfN30L48H4nDJflVOyxP5iwDr+dViBP7V6DvFMiBVH4lsnDIAXpIK2e0YD29k3otGC
         C8aEBFAeJbzX12dnMrzGZhopLwmCDLx452De3eJQAWhTvuE3ujf5u0Oz2l7H+tKAhis0
         CJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710489593; x=1711094393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+q0RWAo5V4NGnWLCMD0VeyK5GzSO5WOFdbw6bveQeY=;
        b=i1Ye1Lgaq0CUosbZFlw6rIyA4unOllc99VXvcCsGyyVTXE0oE8KGZvGgwsbS+qLkVi
         q0zKvb+fASNgbglRdyEfXG+fOR6Oiup/326bT2q6oCzZIKPPlt45IUD0WAiMdeiRQV9m
         tYwQAhshuTOE8S+c77jcXltHUI7iZFJyrEtd+5NXTSoZ1WqGaTPa1qeawRqBSV918RqH
         Zqi/xiTS66IDoCUXDF4X3IbyNoZrr6zBWeUfERDL8Qo6Z7fv8EDFIM/qGLaogSqL66hk
         7xYrtKvZG3smTMxT/0mIbb0EnNQNalvXCckjnyTXRmoIt9Qk87a/Nb/4LboGcLJtdeNb
         wdXA==
X-Forwarded-Encrypted: i=1; AJvYcCWF41l45O/Rc2gLsEhwsvS8lsGdJLTJxPy6WMrcr+1SsOHZYV7h/vxUR1OTpEYh+lsntiq0owQBeWHCwy9z46Ifw0QtW0YYXNvc8O6r
X-Gm-Message-State: AOJu0YzJryd7z6jpFgYYGWSj4S85+mgkGAt/42vWaRJrzWJRfevvXIz0
	CRyW7fRL5UdvWXZoxt6SQuzPLiiPgxg+tieMFAA0+5lbJ6WVx5ZJR8CA66ieYB9hGw==
X-Google-Smtp-Source: AGHT+IFAHJkmcE/VxxKkZLKlqOHg3oDc3bshc2keoUzfan6bKlC9Avg/WvK9dhbNjsOwXI1abE03Nw==
X-Received: by 2002:a17:90a:ec15:b0:29c:570d:7f5d with SMTP id l21-20020a17090aec1500b0029c570d7f5dmr6550152pjy.9.1710489593320;
        Fri, 15 Mar 2024 00:59:53 -0700 (PDT)
Received: from DESKTOP-4R0U3NR.siflower.com ([2a09:bac5:6249:183c::26a:36])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001d9eefef30csm3098935plc.6.2024.03.15.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:59:52 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
Date: Fri, 15 Mar 2024 15:59:44 +0800
Message-Id: <20240315075946.587679-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing jffs2 on a memory-constrained system, lockdep detected a
possible circular locking dependency.

kswapd0/266 is trying to acquire lock:
ffffff802865e508 (&f->sem){+.+.}-{3:3}, at: jffs2_do_clear_inode+0x44/0x200

but task is already holding lock:
ffffffd010e843c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x40

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x6c/0x90
       fs_reclaim_acquire+0x7c/0xa0
       kmem_cache_alloc+0x5c/0x400
       jffs2_alloc_inode_cache+0x18/0x20
       jffs2_do_read_inode+0x1e0/0x310
       jffs2_iget+0x154/0x540
       jffs2_do_fill_super+0x214/0x3f0
       jffs2_fill_super+0x138/0x180
       mtd_get_sb+0xcc/0x120
       get_tree_mtd+0x168/0x400
       jffs2_get_tree+0x14/0x20
       vfs_get_tree+0x48/0x130
       path_mount+0xa64/0x12d0
       __arm64_sys_mount+0x368/0x3e0
       do_el0_svc+0xa0/0x140
       el0_svc+0x1c/0x30
       el0_sync_handler+0x9c/0x120
       el0_sync+0x148/0x180

-> #0 (&f->sem){+.+.}-{3:3}:
       __lock_acquire+0x18cc/0x2bb0
       lock_acquire.part.0+0x170/0x2e0
       lock_acquire+0x6c/0x90
       __mutex_lock+0x10c/0xaa0
       mutex_lock_nested+0x54/0x80
       jffs2_do_clear_inode+0x44/0x200
       jffs2_evict_inode+0x44/0x50
       evict+0x120/0x290
       dispose_list+0x88/0xd0
       prune_icache_sb+0xa8/0xd0
       super_cache_scan+0x1c4/0x240
       shrink_slab.constprop.0+0x2a0/0x7f0
       shrink_node+0x398/0x8e0
       balance_pgdat+0x268/0x550
       kswapd+0x154/0x7c0
       kthread+0x1f0/0x200
       ret_from_fork+0x10/0x20

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&f->sem);
                               lock(fs_reclaim);
  lock(&f->sem);

 *** DEADLOCK ***

3 locks held by kswapd0/266:
 #0: ffffffd010e843c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x40
 #1: ffffffd010e62eb0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab.constprop.0+0x78/0x7f0
 #2: ffffff80225340e0 (&type->s_umount_key#40){.+.+}-{3:3}, at: super_cache_scan+0x3c/0x240

It turns out jffs2 uses GFP_KERNEL as the memory allocation flags
throughout the code, and commonly, inside the critical section of
jffs2_inode_info::sem. When running low on memory, any allocation within
the critical section may trigger a direct reclaim, which recurses back
to jffs2_do_clear_inode().

Replace GFP_KERNEL with GFP_NOFS to avoid the recursion.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
XXX: Posting this as RFC, as I don't know if all GFP_KERNEL occurrences
should be replaced, or if this is just a false positive.


 fs/jffs2/acl.c       |  6 +++---
 fs/jffs2/build.c     |  2 +-
 fs/jffs2/compr.c     |  4 ++--
 fs/jffs2/debug.c     |  2 +-
 fs/jffs2/dir.c       |  2 +-
 fs/jffs2/erase.c     |  4 ++--
 fs/jffs2/fs.c        |  4 ++--
 fs/jffs2/gc.c        |  6 +++---
 fs/jffs2/malloc.c    | 20 ++++++++++----------
 fs/jffs2/read.c      |  4 ++--
 fs/jffs2/readinode.c |  8 ++++----
 fs/jffs2/scan.c      |  4 ++--
 fs/jffs2/summary.c   | 20 ++++++++++----------
 fs/jffs2/super.c     |  4 ++--
 fs/jffs2/wbuf.c      | 20 ++++++++++----------
 fs/jffs2/xattr.c     |  6 +++---
 16 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 888a7ceb6479..cd0e13690174 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -78,7 +78,7 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 	if (count == 0)
 		return NULL;
 
-	acl = posix_acl_alloc(count, GFP_KERNEL);
+	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 
@@ -134,7 +134,7 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 
 	*size = jffs2_acl_size(acl->a_count);
 	header = kmalloc(struct_size(header, a_entries, acl->a_count),
-			GFP_KERNEL);
+			GFP_NOFS);
 	if (!header)
 		return ERR_PTR(-ENOMEM);
 	header->a_version = cpu_to_je32(JFFS2_ACL_VERSION);
@@ -194,7 +194,7 @@ struct posix_acl *jffs2_get_acl(struct inode *inode, int type, bool rcu)
 	}
 	rc = do_jffs2_getxattr(inode, xprefix, "", NULL, 0);
 	if (rc > 0) {
-		value = kmalloc(rc, GFP_KERNEL);
+		value = kmalloc(rc, GFP_NOFS);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		rc = do_jffs2_getxattr(inode, xprefix, "", value, rc);
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 6ae9d6fefb86..cfef48bd7528 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -384,7 +384,7 @@ int jffs2_do_mount_fs(struct jffs2_sb_info *c)
 		c->blocks = vzalloc(size);
 	else
 #endif
-		c->blocks = kzalloc(size, GFP_KERNEL);
+		c->blocks = kzalloc(size, GFP_NOFS);
 	if (!c->blocks)
 		return -ENOMEM;
 
diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 764f19dec3f0..e2ece5e703bf 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -79,7 +79,7 @@ static int jffs2_selected_compress(u8 compr, unsigned char *data_in,
 	uint32_t orig_slen, orig_dlen;
 	char *output_buf;
 
-	output_buf = kmalloc(*cdatalen, GFP_KERNEL);
+	output_buf = kmalloc(*cdatalen, GFP_NOFS);
 	if (!output_buf) {
 		pr_warn("No memory for compressor allocation. Compression failed.\n");
 		return ret;
@@ -187,7 +187,7 @@ uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 			}
 			if (!this->compr_buf) {
 				spin_unlock(&jffs2_compressor_list_lock);
-				tmp_buf = kmalloc(orig_slen, GFP_KERNEL);
+				tmp_buf = kmalloc(orig_slen, GFP_NOFS);
 				spin_lock(&jffs2_compressor_list_lock);
 				if (!tmp_buf) {
 					pr_warn("No memory for compressor allocation. (%d bytes)\n",
diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
index 0925caab23c4..ab74a63bb340 100644
--- a/fs/jffs2/debug.c
+++ b/fs/jffs2/debug.c
@@ -129,7 +129,7 @@ __jffs2_dbg_prewrite_paranoia_check(struct jffs2_sb_info *c,
 	int ret, i;
 	unsigned char *buf;
 
-	buf = kmalloc(len, GFP_KERNEL);
+	buf = kmalloc(len, GFP_NOFS);
 	if (!buf)
 		return;
 
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 2b2938970da3..10d28b283145 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -354,7 +354,7 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 	}
 
 	/* We use f->target field to store the target path. */
-	f->target = kmemdup(target, targetlen + 1, GFP_KERNEL);
+	f->target = kmemdup(target, targetlen + 1, GFP_NOFS);
 	if (!f->target) {
 		pr_warn("Can't allocate %d bytes of memory\n", targetlen + 1);
 		mutex_unlock(&f->sem);
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index acd32f05b519..bd7693d86d2f 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -43,7 +43,7 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 	jffs2_dbg(1, "%s(): erase block %#08x (range %#08x-%#08x)\n",
 		  __func__,
 		  jeb->offset, jeb->offset, jeb->offset + c->sector_size);
-	instr = kzalloc(sizeof(struct erase_info), GFP_KERNEL);
+	instr = kzalloc(sizeof(struct erase_info), GFP_NOFS);
 	if (!instr) {
 		pr_warn("kzalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		mutex_lock(&c->erase_free_sem);
@@ -347,7 +347,7 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
 		return 0;
 	}
  do_flash_read:
-	ebuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	ebuf = kmalloc(PAGE_SIZE, GFP_NOFS);
 	if (!ebuf) {
 		pr_warn("Failed to allocate page buffer for verifying erase at 0x%08x. Refiling\n",
 			jeb->offset);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..b396c9875ad1 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -59,7 +59,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	} else if (S_ISLNK(inode->i_mode)) {
 		mutex_lock(&f->sem);
 		mdatalen = f->metadata->size;
-		mdata = kmalloc(f->metadata->size, GFP_USER);
+		mdata = kmalloc(f->metadata->size, GFP_USER & ~__GFP_FS);
 		if (!mdata) {
 			mutex_unlock(&f->sem);
 			return -ENOMEM;
@@ -562,7 +562,7 @@ int jffs2_do_fill_super(struct super_block *sb, struct fs_context *fc)
 		return ret;
 
 	c->inocache_hashsize = calculate_inocache_hashsize(c->flash_size);
-	c->inocache_list = kcalloc(c->inocache_hashsize, sizeof(struct jffs2_inode_cache *), GFP_KERNEL);
+	c->inocache_list = kcalloc(c->inocache_hashsize, sizeof(struct jffs2_inode_cache *), GFP_NOFS);
 	if (!c->inocache_list) {
 		ret = -ENOMEM;
 		goto out_wbuf;
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 5c6602f3c189..969ea35c45f9 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -621,7 +621,7 @@ static int jffs2_garbage_collect_pristine(struct jffs2_sb_info *c,
 		return -EBADFD;
 	}
 
-	node = kmalloc(rawlen, GFP_KERNEL);
+	node = kmalloc(rawlen, GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
 
@@ -776,7 +776,7 @@ static int jffs2_garbage_collect_metadata(struct jffs2_sb_info *c, struct jffs2_
 			  __func__, mdatalen);
 	} else if (S_ISLNK(JFFS2_F_I_MODE(f))) {
 		mdatalen = fn->size;
-		mdata = kmalloc(fn->size, GFP_KERNEL);
+		mdata = kmalloc(fn->size, GFP_NOFS);
 		if (!mdata) {
 			pr_warn("kmalloc of mdata failed in jffs2_garbage_collect_metadata()\n");
 			return -ENOMEM;
@@ -912,7 +912,7 @@ static int jffs2_garbage_collect_deletion_dirent(struct jffs2_sb_info *c, struct
 		uint32_t name_crc = crc32(0, fd->name, name_len);
 		uint32_t rawlen = ref_totlen(c, jeb, fd->raw);
 
-		rd = kmalloc(rawlen, GFP_KERNEL);
+		rd = kmalloc(rawlen, GFP_NOFS);
 		if (!rd)
 			return -ENOMEM;
 
diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
index ce1189793288..213f8fe5e6bd 100644
--- a/fs/jffs2/malloc.c
+++ b/fs/jffs2/malloc.c
@@ -113,7 +113,7 @@ void jffs2_destroy_slab_caches(void)
 struct jffs2_full_dirent *jffs2_alloc_full_dirent(int namesize)
 {
 	struct jffs2_full_dirent *ret;
-	ret = kmalloc(sizeof(struct jffs2_full_dirent) + namesize, GFP_KERNEL);
+	ret = kmalloc(sizeof(struct jffs2_full_dirent) + namesize, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -127,7 +127,7 @@ void jffs2_free_full_dirent(struct jffs2_full_dirent *x)
 struct jffs2_full_dnode *jffs2_alloc_full_dnode(void)
 {
 	struct jffs2_full_dnode *ret;
-	ret = kmem_cache_alloc(full_dnode_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(full_dnode_slab, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -141,7 +141,7 @@ void jffs2_free_full_dnode(struct jffs2_full_dnode *x)
 struct jffs2_raw_dirent *jffs2_alloc_raw_dirent(void)
 {
 	struct jffs2_raw_dirent *ret;
-	ret = kmem_cache_alloc(raw_dirent_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(raw_dirent_slab, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -155,7 +155,7 @@ void jffs2_free_raw_dirent(struct jffs2_raw_dirent *x)
 struct jffs2_raw_inode *jffs2_alloc_raw_inode(void)
 {
 	struct jffs2_raw_inode *ret;
-	ret = kmem_cache_alloc(raw_inode_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(raw_inode_slab, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -169,7 +169,7 @@ void jffs2_free_raw_inode(struct jffs2_raw_inode *x)
 struct jffs2_tmp_dnode_info *jffs2_alloc_tmp_dnode_info(void)
 {
 	struct jffs2_tmp_dnode_info *ret;
-	ret = kmem_cache_alloc(tmp_dnode_info_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(tmp_dnode_info_slab, GFP_NOFS);
 	dbg_memalloc("%p\n",
 		ret);
 	return ret;
@@ -185,7 +185,7 @@ static struct jffs2_raw_node_ref *jffs2_alloc_refblock(void)
 {
 	struct jffs2_raw_node_ref *ret;
 
-	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_NOFS);
 	if (ret) {
 		int i = 0;
 		for (i=0; i < REFS_PER_BLOCK; i++) {
@@ -248,7 +248,7 @@ void jffs2_free_refblock(struct jffs2_raw_node_ref *x)
 struct jffs2_node_frag *jffs2_alloc_node_frag(void)
 {
 	struct jffs2_node_frag *ret;
-	ret = kmem_cache_alloc(node_frag_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(node_frag_slab, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -262,7 +262,7 @@ void jffs2_free_node_frag(struct jffs2_node_frag *x)
 struct jffs2_inode_cache *jffs2_alloc_inode_cache(void)
 {
 	struct jffs2_inode_cache *ret;
-	ret = kmem_cache_alloc(inode_cache_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(inode_cache_slab, GFP_NOFS);
 	dbg_memalloc("%p\n", ret);
 	return ret;
 }
@@ -277,7 +277,7 @@ void jffs2_free_inode_cache(struct jffs2_inode_cache *x)
 struct jffs2_xattr_datum *jffs2_alloc_xattr_datum(void)
 {
 	struct jffs2_xattr_datum *xd;
-	xd = kmem_cache_zalloc(xattr_datum_cache, GFP_KERNEL);
+	xd = kmem_cache_zalloc(xattr_datum_cache, GFP_NOFS);
 	dbg_memalloc("%p\n", xd);
 	if (!xd)
 		return NULL;
@@ -297,7 +297,7 @@ void jffs2_free_xattr_datum(struct jffs2_xattr_datum *xd)
 struct jffs2_xattr_ref *jffs2_alloc_xattr_ref(void)
 {
 	struct jffs2_xattr_ref *ref;
-	ref = kmem_cache_zalloc(xattr_ref_cache, GFP_KERNEL);
+	ref = kmem_cache_zalloc(xattr_ref_cache, GFP_NOFS);
 	dbg_memalloc("%p\n", ref);
 	if (!ref)
 		return NULL;
diff --git a/fs/jffs2/read.c b/fs/jffs2/read.c
index 0b042b1fc82f..7c8f40b6f686 100644
--- a/fs/jffs2/read.c
+++ b/fs/jffs2/read.c
@@ -90,7 +90,7 @@ int jffs2_read_dnode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	if (ri->compr == JFFS2_COMPR_NONE && len == je32_to_cpu(ri->dsize)) {
 		readbuf = buf;
 	} else {
-		readbuf = kmalloc(je32_to_cpu(ri->csize), GFP_KERNEL);
+		readbuf = kmalloc(je32_to_cpu(ri->csize), GFP_NOFS);
 		if (!readbuf) {
 			ret = -ENOMEM;
 			goto out_ri;
@@ -98,7 +98,7 @@ int jffs2_read_dnode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	}
 	if (ri->compr != JFFS2_COMPR_NONE) {
 		if (len < je32_to_cpu(ri->dsize)) {
-			decomprbuf = kmalloc(je32_to_cpu(ri->dsize), GFP_KERNEL);
+			decomprbuf = kmalloc(je32_to_cpu(ri->dsize), GFP_NOFS);
 			if (!decomprbuf) {
 				ret = -ENOMEM;
 				goto out_readbuf;
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 03b4f99614be..f73e5d1169ca 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -76,7 +76,7 @@ static int check_node_data(struct jffs2_sb_info *c, struct jffs2_tmp_dnode_info
 #endif
 
 	if (!pointed) {
-		buffer = kmalloc(len, GFP_KERNEL);
+		buffer = kmalloc(len, GFP_NOFS);
 		if (unlikely(!buffer))
 			return -ENOMEM;
 
@@ -994,7 +994,7 @@ static int jffs2_get_inode_nodes(struct jffs2_sb_info *c, struct jffs2_inode_inf
 	/* FIXME: in case of NOR and available ->point() this
 	 * needs to be fixed. */
 	len = sizeof(union jffs2_node_union) + c->wbuf_pagesize;
-	buf = kmalloc(len, GFP_KERNEL);
+	buf = kmalloc(len, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1268,7 +1268,7 @@ static int jffs2_do_read_inode_internal(struct jffs2_sb_info *c,
 			uint32_t csize = je32_to_cpu(latest_node->csize);
 			if (csize > JFFS2_MAX_NAME_LEN)
 				return -ENAMETOOLONG;
-			f->target = kmalloc(csize + 1, GFP_KERNEL);
+			f->target = kmalloc(csize + 1, GFP_NOFS);
 			if (!f->target) {
 				JFFS2_ERROR("can't allocate %u bytes of memory for the symlink target path cache\n", csize);
 				return -ENOMEM;
@@ -1392,7 +1392,7 @@ int jffs2_do_read_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 int jffs2_do_crccheck_inode(struct jffs2_sb_info *c, struct jffs2_inode_cache *ic)
 {
 	struct jffs2_raw_inode n;
-	struct jffs2_inode_info *f = kzalloc(sizeof(*f), GFP_KERNEL);
+	struct jffs2_inode_info *f = kzalloc(sizeof(*f), GFP_NOFS);
 	int ret;
 
 	if (!f)
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..088b71d7d58d 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -132,7 +132,7 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	}
 
 	if (jffs2_sum_active()) {
-		s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+		s = kzalloc(sizeof(struct jffs2_summary), GFP_NOFS);
 		if (!s) {
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			ret = -ENOMEM;
@@ -520,7 +520,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				/* Now, make sure the summary itself is available */
 				if (sumlen > buf_size) {
 					/* Need to kmalloc for this. */
-					sumptr = kmalloc(sumlen, GFP_KERNEL);
+					sumptr = kmalloc(sumlen, GFP_NOFS);
 					if (!sumptr)
 						return -ENOMEM;
 					memcpy(sumptr + sumlen - buf_len, buf + buf_size - buf_len, buf_len);
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4fe64519870f..78c9c5636cb1 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -27,14 +27,14 @@ int jffs2_sum_init(struct jffs2_sb_info *c)
 {
 	uint32_t sum_size = min_t(uint32_t, c->sector_size, MAX_SUMMARY_SIZE);
 
-	c->summary = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+	c->summary = kzalloc(sizeof(struct jffs2_summary), GFP_NOFS);
 
 	if (!c->summary) {
 		JFFS2_WARNING("Can't allocate memory for summary information!\n");
 		return -ENOMEM;
 	}
 
-	c->summary->sum_buf = kmalloc(sum_size, GFP_KERNEL);
+	c->summary->sum_buf = kmalloc(sum_size, GFP_NOFS);
 
 	if (!c->summary->sum_buf) {
 		JFFS2_WARNING("Can't allocate buffer for writing out summary information!\n");
@@ -115,7 +115,7 @@ int jffs2_sum_add_padding_mem(struct jffs2_summary *s, uint32_t size)
 int jffs2_sum_add_inode_mem(struct jffs2_summary *s, struct jffs2_raw_inode *ri,
 				uint32_t ofs)
 {
-	struct jffs2_sum_inode_mem *temp = kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_KERNEL);
+	struct jffs2_sum_inode_mem *temp = kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_NOFS);
 
 	if (!temp)
 		return -ENOMEM;
@@ -134,7 +134,7 @@ int jffs2_sum_add_dirent_mem(struct jffs2_summary *s, struct jffs2_raw_dirent *r
 				uint32_t ofs)
 {
 	struct jffs2_sum_dirent_mem *temp =
-		kmalloc(sizeof(struct jffs2_sum_dirent_mem) + rd->nsize, GFP_KERNEL);
+		kmalloc(sizeof(struct jffs2_sum_dirent_mem) + rd->nsize, GFP_NOFS);
 
 	if (!temp)
 		return -ENOMEM;
@@ -159,7 +159,7 @@ int jffs2_sum_add_xattr_mem(struct jffs2_summary *s, struct jffs2_raw_xattr *rx,
 {
 	struct jffs2_sum_xattr_mem *temp;
 
-	temp = kmalloc(sizeof(struct jffs2_sum_xattr_mem), GFP_KERNEL);
+	temp = kmalloc(sizeof(struct jffs2_sum_xattr_mem), GFP_NOFS);
 	if (!temp)
 		return -ENOMEM;
 
@@ -177,7 +177,7 @@ int jffs2_sum_add_xref_mem(struct jffs2_summary *s, struct jffs2_raw_xref *rr, u
 {
 	struct jffs2_sum_xref_mem *temp;
 
-	temp = kmalloc(sizeof(struct jffs2_sum_xref_mem), GFP_KERNEL);
+	temp = kmalloc(sizeof(struct jffs2_sum_xref_mem), GFP_NOFS);
 	if (!temp)
 		return -ENOMEM;
 
@@ -263,7 +263,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 	switch (je16_to_cpu(node->u.nodetype)) {
 		case JFFS2_NODETYPE_INODE: {
 			struct jffs2_sum_inode_mem *temp =
-				kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_KERNEL);
+				kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_NOFS);
 
 			if (!temp)
 				goto no_mem;
@@ -280,7 +280,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 
 		case JFFS2_NODETYPE_DIRENT: {
 			struct jffs2_sum_dirent_mem *temp =
-				kmalloc(sizeof(struct jffs2_sum_dirent_mem) + node->d.nsize, GFP_KERNEL);
+				kmalloc(sizeof(struct jffs2_sum_dirent_mem) + node->d.nsize, GFP_NOFS);
 
 			if (!temp)
 				goto no_mem;
@@ -314,7 +314,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 #ifdef CONFIG_JFFS2_FS_XATTR
 		case JFFS2_NODETYPE_XATTR: {
 			struct jffs2_sum_xattr_mem *temp;
-			temp = kmalloc(sizeof(struct jffs2_sum_xattr_mem), GFP_KERNEL);
+			temp = kmalloc(sizeof(struct jffs2_sum_xattr_mem), GFP_NOFS);
 			if (!temp)
 				goto no_mem;
 
@@ -329,7 +329,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 		}
 		case JFFS2_NODETYPE_XREF: {
 			struct jffs2_sum_xref_mem *temp;
-			temp = kmalloc(sizeof(struct jffs2_sum_xref_mem), GFP_KERNEL);
+			temp = kmalloc(sizeof(struct jffs2_sum_xref_mem), GFP_NOFS);
 			if (!temp)
 				goto no_mem;
 			temp->nodetype = node->r.nodetype;
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index f99591a634b4..a7a6dd80b92f 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -39,7 +39,7 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *f;
 
-	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
+	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_NOFS);
 	if (!f)
 		return NULL;
 	return &f->vfs_inode;
@@ -310,7 +310,7 @@ static int jffs2_init_fs_context(struct fs_context *fc)
 {
 	struct jffs2_sb_info *ctx;
 
-	ctx = kzalloc(sizeof(struct jffs2_sb_info), GFP_KERNEL);
+	ctx = kzalloc(sizeof(struct jffs2_sb_info), GFP_NOFS);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 4061e0ba7010..41dc2a33159b 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -92,7 +92,7 @@ static void jffs2_wbuf_dirties_inode(struct jffs2_sb_info *c, uint32_t ino)
 	if (jffs2_wbuf_pending_for_ino(c, ino))
 		return;
 
-	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	new = kmalloc(sizeof(*new), GFP_NOFS);
 	if (!new) {
 		jffs2_dbg(1, "No memory to allocate inodirty. Fallback to all considered dirty\n");
 		jffs2_clear_wbuf_ino_list(c);
@@ -337,7 +337,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 		/* First affected node was already partially written.
 		 * Attempt to reread the old data into our buffer. */
 
-		buf = kmalloc(end - start, GFP_KERNEL);
+		buf = kmalloc(end - start, GFP_NOFS);
 		if (!buf) {
 			pr_crit("Malloc failure in wbuf recovery. Data loss ensues.\n");
 
@@ -1204,18 +1204,18 @@ int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
 	c->wbuf_pagesize = c->mtd->writesize;
 	c->wbuf_ofs = 0xFFFFFFFF;
 
-	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf)
 		return -ENOMEM;
 
-	c->oobbuf = kmalloc_array(NR_OOB_SCAN_PAGES, c->oobavail, GFP_KERNEL);
+	c->oobbuf = kmalloc_array(NR_OOB_SCAN_PAGES, c->oobavail, GFP_NOFS);
 	if (!c->oobbuf) {
 		kfree(c->wbuf);
 		return -ENOMEM;
 	}
 
 #ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf_verify) {
 		kfree(c->oobbuf);
 		kfree(c->wbuf);
@@ -1265,12 +1265,12 @@ int jffs2_dataflash_setup(struct jffs2_sb_info *c) {
 	}
 
 	c->wbuf_ofs = 0xFFFFFFFF;
-	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf)
 		return -ENOMEM;
 
 #ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf_verify) {
 		kfree(c->wbuf);
 		return -ENOMEM;
@@ -1302,12 +1302,12 @@ int jffs2_nor_wbuf_flash_setup(struct jffs2_sb_info *c) {
 	c->wbuf_pagesize = c->mtd->writesize;
 	c->wbuf_ofs = 0xFFFFFFFF;
 
-	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf)
 		return -ENOMEM;
 
 #ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf_verify) {
 		kfree(c->wbuf);
 		return -ENOMEM;
@@ -1335,7 +1335,7 @@ int jffs2_ubivol_setup(struct jffs2_sb_info *c) {
 
 	c->wbuf_pagesize =  c->mtd->writesize;
 	c->wbuf_ofs = 0xFFFFFFFF;
-	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
+	c->wbuf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
 	if (!c->wbuf)
 		return -ENOMEM;
 
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 00224f3a8d6e..9b5212258bc2 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -213,7 +213,7 @@ static int do_load_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xattr_datum
 	BUG_ON(!list_empty(&xd->xindex));
  retry:
 	length = xd->name_len + 1 + xd->value_len;
-	data = kmalloc(length, GFP_KERNEL);
+	data = kmalloc(length, GFP_NOFS);
 	if (!data)
 		return -ENOMEM;
 
@@ -364,7 +364,7 @@ static struct jffs2_xattr_datum *create_xattr_datum(struct jffs2_sb_info *c,
 	if (!xd)
 		return ERR_PTR(-ENOMEM);
 
-	data = kmalloc(name_len + 1 + xsize, GFP_KERNEL);
+	data = kmalloc(name_len + 1 + xsize, GFP_NOFS);
 	if (!data) {
 		jffs2_free_xattr_datum(xd);
 		return ERR_PTR(-ENOMEM);
@@ -785,7 +785,7 @@ int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
 	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
-			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+			       sizeof(struct jffs2_xattr_ref *), GFP_NOFS);
 	if (!xref_tmphash)
 		return -ENOMEM;
 
-- 
2.34.1


