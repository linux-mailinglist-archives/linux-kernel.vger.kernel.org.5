Return-Path: <linux-kernel+bounces-157297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5988B0F73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CBE1C226EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638016132A;
	Wed, 24 Apr 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0k1y9sK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968516130D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975128; cv=none; b=mqR4XChFjDymp0n96IL3mlQzuvsqGxAlD+XXc0zvfu2DM69zcVXz2RnngzEYh2/nf9UTAEKohP8uMPqE/Sw3ctDF28neh5TEMRbcKZjhvbi3TvE2NBckXGCj1S6c9xtOYwgjjj3Mr0tC+BkuhR5cx3FgzuqtxEPdtdS5ln8Nfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975128; c=relaxed/simple;
	bh=OR0Ifl/VSW+J/w+QyJbU522J3UIzlVuTNFzBzmzolus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFVRCDxOnCf89+vcV/7/z9cDG3dOK6R4e527r/qO9kZU/Cx6As21Sb5k+hHwal6SC2G0rUNbmo8xsM3hqspzMp1ha6QCw/yzvviYJxXQBPhQPUTCtHl/f7D8fnZrjzr1yKlQ5KqXwQJPjFu9HC7vGep510saYni+D1XjzdJOYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0k1y9sK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ff14f249so574575ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975126; x=1714579926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OZcl3AtYOTyvJoa0yfQ2PBBxusCEnnYCOaRNZ4Rn9s=;
        b=U0k1y9sKRJdqy3Ea4SFG0poIiAQo3+Rsp9n1pCX9I+fcepIo+VJThrGF0UcVzm/E6V
         ZqK+vY/R0Ze3ZrgbDzf2UYh814iHrqR+OdAWWLoTMhrR54CQXT7hNCQ7D2+0zUmMhN10
         y9/41FNMLxxVH4ySKIUP5jtK23dyIpq7XTN2riK8P9O5fIXdv6Iw7k2tQbvjTl0ybK0c
         2HLoPrHYioaPArupMT6nJxtb+MmnNs+yXBujtaUhLAN9De6Ww5gxB336tnnpwele93/9
         t0f44xo61oP2kpAX662SCU2Xt7+cxpWUPQYapU6AtDb+JlcvSDcWzSrV5xdl5K9mHZsm
         M99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975126; x=1714579926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OZcl3AtYOTyvJoa0yfQ2PBBxusCEnnYCOaRNZ4Rn9s=;
        b=j/pxhTzhXiUcFOEPir51vh7mcogaE6H0uJLzmrdFH2xnFT3mUOtdSYJNp4bxdn1+rs
         JyUMoNEtCShIMp/bGnHGoBcwuinlr8+/iMMY12rNv2bIaqHm/ksaqrnxVBMDQ6I6GeRV
         ZcOFJME+7zRzTT6+KUGdLqoRijmeml+4bdJEq/iQA7ZM7vie/tFkshSEmcHxZo2tpeRI
         O1fgcH7MtbS7PSOO4JWmcvNE4eD5dGMQ3wz188FKmyFsu7LcUq+C3paWgi1MBjOMHxqj
         0L6uG4AP51mE7fx4HNT+Kgda4PuyyyUd4SIgzxBkfnxQTIf+3Kwg9qDwhewvYmTnpgsH
         blbw==
X-Gm-Message-State: AOJu0Yz33m9udsSRxkZwsdwsvt0/AyHgQ8anVXI5qErL94RkGyAOz5O4
	7F5nVkbNqB7yfaObNW6ygVYyRx5Y17WfxogSDoyXixBOc7cTk1G7KmzItxFa
X-Google-Smtp-Source: AGHT+IGHz81NF8FalHuO8DoeqwT+mwJ4KTA2TpzATppBaLfn2+hwmp1IyQwFiJqE5FOEYebjBI44pg==
X-Received: by 2002:a17:903:11d2:b0:1e4:55d8:e15f with SMTP id q18-20020a17090311d200b001e455d8e15fmr127551plh.32.1713975125394;
        Wed, 24 Apr 2024 09:12:05 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001e446490072sm6460652plg.25.2024.04.24.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:12:05 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in hfsplus_file_extend
Date: Thu, 25 Apr 2024 01:12:01 +0900
Message-Id: <20240424161201.147150-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002dabd805ee5b222e@google.com>
References: <0000000000002dabd805ee5b222e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test deadlock in hfsplus_file_extend

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

---
 fs/hfsplus/attributes.c | 33 +++++++++++++++--
 fs/hfsplus/btree.c      | 14 ++++++-
 fs/hfsplus/catalog.c    | 45 ++++++++++++++++++++--
 fs/hfsplus/extents.c    | 82 ++++++++++++++++++++++++++++++-----------
 fs/hfsplus/xattr.c      | 17 +++++++--
 5 files changed, 159 insertions(+), 32 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index eeebe80c6be4..af142e458ac2 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -198,8 +198,11 @@ int hfsplus_create_attr(struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 	hfsplus_attr_entry *entry_ptr;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 	int entry_size;
-	int err;
+	int err, locked = 0;
 
 	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
 		name ? name : NULL, inode->i_ino);
@@ -216,9 +219,19 @@ int hfsplus_create_attr(struct inode *inode,
 	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
 	if (err)
 		goto failed_init_create_attr;
-
+	
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	/* Fail early and avoid ENOSPC during the btree operation */
 	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
+	if(locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto failed_create_attr;
 
@@ -306,7 +319,10 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 
 int hfsplus_delete_attr(struct inode *inode, const char *name)
 {
-	int err = 0;
+	int err = 0, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 
@@ -321,9 +337,18 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
 	if (err)
 		return err;
-
+	
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	/* Fail early and avoid ENOSPC during the btree operation */
 	err = hfs_bmap_reserve(fd.tree, fd.tree->depth);
+	if(locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..aea695c4cfb8 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -380,9 +380,21 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	u16 off16;
 	u16 len;
 	u8 *data, byte, m;
-	int i, res;
+	int i, res, locked = 0;
+	struct inode *inode = tree->inode;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+
+	locked = mutex_trylock(&HFSPLUS_I(inode)->extents_lock);
 
+	if(!locked){
+		owner = HFSPLUS_I(inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return ERR_PTR(-MAX_ERRNO);
+	}
 	res = hfs_bmap_reserve(tree, 1);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
 	if (res)
 		return ERR_PTR(res);
 
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 1995bafee839..b5cd01bce6ea 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -257,7 +257,10 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int entry_size;
-	int err;
+	int err, locked = 0;
+	atomic_long_t owner;
+	struct inode *fd_inode;
+	unsigned long curr = (unsigned long)current;
 
 	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
 		str->name, cnid, inode->i_nlink);
@@ -269,7 +272,17 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(fd.tree, 2 * fd.tree->depth);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto err2;
 
@@ -333,7 +346,10 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	struct hfs_find_data fd;
 	struct hfsplus_fork_raw fork;
 	struct list_head *pos;
-	int err, off;
+	struct inode *fd_inode;
+	int err, off, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
 	u16 type;
 
 	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
@@ -345,7 +361,17 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	fd_inode = fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(fd.tree, 2 * (int)fd.tree->depth - 2);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
@@ -439,7 +465,10 @@ int hfsplus_rename_cat(u32 cnid,
 	struct hfs_find_data src_fd, dst_fd;
 	hfsplus_cat_entry entry;
 	int entry_size, type;
-	int err;
+	int err, locked = 0;
+	struct inode *fd_inode;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
 
 	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
 		cnid, src_dir->i_ino, src_name->name,
@@ -453,7 +482,17 @@ int hfsplus_rename_cat(u32 cnid,
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most twice.
 	 */
+	fd_inode = src_fd.tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	err = hfs_bmap_reserve(src_fd.tree, 4 * (int)src_fd.tree->depth - 1);
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 3c572e44f2ad..933c4409618a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -88,7 +88,10 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	int res;
+	int res, locked = 0;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	struct inode *fd_inode;
 
 	WARN_ON(!mutex_is_locked(&hip->extents_lock));
 
@@ -97,6 +100,15 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 				HFSPLUS_TYPE_RSRC : HFSPLUS_TYPE_DATA);
 
 	res = hfs_brec_find(fd, hfs_find_rec_by_key);
+
+	fd_inode = fd->tree->inode;
+	locked = mutex_trylock(&HFSPLUS_I(fd_inode)->extents_lock);
+
+	if(!locked){
+		owner = HFSPLUS_I(fd_inode)->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
 	if (hip->extent_state & HFSPLUS_EXT_NEW) {
 		if (res != -ENOENT)
 			return res;
@@ -115,6 +127,8 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		hip->extent_state &= ~HFSPLUS_EXT_DIRTY;
 	}
 
+	if (locked)
+		mutex_unlock(&HFSPLUS_I(fd_inode)->extents_lock);
 	/*
 	 * We can't just use hfsplus_mark_inode_dirty here, because we
 	 * also get called from hfsplus_write_inode, which should not
@@ -228,36 +242,51 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	struct super_block *sb = inode->i_sb;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned long curr = (unsigned long)current;
 	int res = -EIO;
 	u32 ablock, dblock, mask;
+	atomic_long_t owner;
 	sector_t sector;
-	int was_dirty = 0;
+	int was_dirty = 0, locked = 0;
 
 	/* Convert inode block to disk allocation block */
 	ablock = iblock >> sbi->fs_shift;
 
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
+
 	if (iblock >= hip->fs_blocks) {
-		if (!create)
-			return 0;
-		if (iblock > hip->fs_blocks)
-			return -EIO;
+		if (!create){
+			res = 0;
+			goto out;
+		}
+		if (iblock > hip->fs_blocks){
+			res = -EIO;
+			goto out;
+		}	
 		if (ablock >= hip->alloc_blocks) {
 			res = hfsplus_file_extend(inode, false);
 			if (res)
-				return res;
+				goto out;
 		}
 	} else
 		create = 0;
 
 	if (ablock < hip->first_blocks) {
 		dblock = hfsplus_ext_find_block(hip->first_extents, ablock);
+		if (locked)
+			mutex_unlock(&hip->extents_lock);
 		goto done;
 	}
 
-	if (inode->i_ino == HFSPLUS_EXT_CNID)
-		return -EIO;
-
-	mutex_lock(&hip->extents_lock);
+	if (inode->i_ino == HFSPLUS_EXT_CNID){
+		res = -EIO;
+		goto out;
+	}	
 
 	/*
 	 * hfsplus_ext_read_extent will write out a cached extent into
@@ -267,12 +296,13 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	was_dirty = (hip->extent_state & HFSPLUS_EXT_DIRTY);
 	res = hfsplus_ext_read_extent(inode, ablock);
 	if (res) {
-		mutex_unlock(&hip->extents_lock);
-		return -EIO;
+		res = -EIO;
+		goto out;
 	}
 	dblock = hfsplus_ext_find_block(hip->cached_extents,
 					ablock - hip->cached_start);
-	mutex_unlock(&hip->extents_lock);
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 
 done:
 	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
@@ -292,6 +322,10 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	if (create || was_dirty)
 		mark_inode_dirty(inode);
 	return 0;
+out:
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
+	return res;
 }
 
 static void hfsplus_dump_extent(struct hfsplus_extent *extent)
@@ -454,7 +488,6 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -515,11 +548,9 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 out:
 	if (!res) {
 		hip->alloc_blocks += len;
-		mutex_unlock(&hip->extents_lock);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 		return 0;
 	}
-	mutex_unlock(&hip->extents_lock);
 	return res;
 
 insert_extent:
@@ -546,7 +577,9 @@ void hfsplus_file_truncate(struct inode *inode)
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	struct hfs_find_data fd;
 	u32 alloc_cnt, blk_cnt, start;
-	int res;
+	int res, locked = 0;
+	unsigned long curr = (unsigned long)current;
+	atomic_long_t owner;
 
 	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
 		inode->i_ino, (long long)hip->phys_size, inode->i_size);
@@ -573,7 +606,12 @@ void hfsplus_file_truncate(struct inode *inode)
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
-	mutex_lock(&hip->extents_lock);
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return;
+	}
 
 	alloc_cnt = hip->alloc_blocks;
 	if (blk_cnt == alloc_cnt)
@@ -581,7 +619,8 @@ void hfsplus_file_truncate(struct inode *inode)
 
 	res = hfs_find_init(HFSPLUS_SB(sb)->ext_tree, &fd);
 	if (res) {
-		mutex_unlock(&hip->extents_lock);
+		if (locked)
+			mutex_unlock(&hip->extents_lock);
 		/* XXX: We lack error handling of hfsplus_file_truncate() */
 		return;
 	}
@@ -619,7 +658,8 @@ void hfsplus_file_truncate(struct inode *inode)
 
 	hip->alloc_blocks = blk_cnt;
 out_unlock:
-	mutex_unlock(&hip->extents_lock);
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 	hip->phys_size = inode->i_size;
 	hip->fs_blocks = (inode->i_size + sb->s_blocksize - 1) >>
 		sb->s_blocksize_bits;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..d3f8c0352a24 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -130,7 +130,9 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	int index, written;
 	struct address_space *mapping;
 	struct page *page;
-	int old_state = HFSPLUS_EMPTY_ATTR_TREE;
+	atomic_long_t owner;
+	unsigned long curr = (unsigned long)current;
+	int old_state = HFSPLUS_EMPTY_ATTR_TREE, locked = 0;
 
 	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n", HFSPLUS_ATTR_CNID);
 
@@ -181,9 +183,14 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 						    sbi->sect_count,
 						    HFSPLUS_ATTR_CNID);
 
-	mutex_lock(&hip->extents_lock);
+	locked = mutex_trylock(&hip->extents_lock);
+	if(!locked){
+		owner = hip->extents_lock.owner;
+		if((unsigned long)atomic_long_cmpxchg(&owner, 0, 0) != curr)
+			return -EAGAIN;
+	}
+
 	hip->clump_blocks = clump_size >> sbi->alloc_blksz_shift;
-	mutex_unlock(&hip->extents_lock);
 
 	if (sbi->free_blocks <= (hip->clump_blocks << 1)) {
 		err = -ENOSPC;
@@ -194,6 +201,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		err = hfsplus_file_extend(attr_file, false);
 		if (unlikely(err)) {
 			pr_err("failed to extend attributes file\n");
+			if(locked)
+				mutex_unlock(&hip->extents_lock);
 			goto end_attr_file_creation;
 		}
 		hip->phys_size = attr_file->i_size =
@@ -201,6 +210,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		hip->fs_blocks = hip->alloc_blocks << sbi->fs_shift;
 		inode_set_bytes(attr_file, attr_file->i_size);
 	}
+	if (locked)
+		mutex_unlock(&hip->extents_lock);
 
 	buf = kzalloc(node_size, GFP_NOFS);
 	if (!buf) {
-- 
2.34.1

