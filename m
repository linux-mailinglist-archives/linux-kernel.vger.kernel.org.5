Return-Path: <linux-kernel+bounces-45690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6EB843432
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2C71C254CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C38168A3;
	Wed, 31 Jan 2024 02:49:01 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98715485
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669340; cv=none; b=Nk5Hjih0NGZpOa2kwPVy0RyyInwAnSTm8PCdNip+rcqTPhNcdJBvvyDKGZfq7ycH+bE2boMOAMVIARfrv7900+NtHSN6CHRm2nJ1leV8jLy8Wy9k98g4G9G2xfUPMj/VBcbIfeE8fGnH/3WGexyoaFjIIF4fXAeertJ0MEkVDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669340; c=relaxed/simple;
	bh=4PDeWljznvcd9g8jZbAhcbHTaeDfmGJOr3uuOslz9Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MWS92j43V0pzxsb5K4Kuf//OTCQWMLLRV10Y58ZGOoBjA7UBodXj6e2LX0FCsL6qDXo0WaeClb2Kwcu05D/3L2ugxNYjk0dxgaOok4+pvqdfsL6CwCr+YcvhTS64c3eLa4gEgumnQZaQaYbdur2L1GjBG740tenG7gz/3bK6lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40V2m49T092206;
	Wed, 31 Jan 2024 10:48:04 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TPmVM4hYRz2S7v86;
	Wed, 31 Jan 2024 10:40:27 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jan 2024 10:48:02 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v5] f2fs: unify the error handling of f2fs_is_valid_blkaddr
Date: Wed, 31 Jan 2024 10:43:14 +0800
Message-ID: <1706668994-7384-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40V2m49T092206

There are some cases of f2fs_is_valid_blkaddr not handled as
ERROR_INVALID_BLKADDR,so unify the error handling about all of
f2fs_is_valid_blkaddr.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v2: improve patch according Chao's suggestions.
changes of v3:
  -rebase patch to dev-test
  -correct return value for some f2fs_is_valid_blkaddr error case
changes of v4: update according to the latest code
changes of v5: improve patch according Jaegeuk's suggestiongs
  -restore return value of some f2fs_is_valid_blkaddr error case to original
  -remove cp_err checking in __is_bitmap_valid becasue it has done in
   if case
  -return true directly for case (type=DATA_GENERIC_ENHANCE_READ) in
   __is_bitmap_valid to avoid meaningless flow
  -rename __is_bitmap_valid to __is_bitmap_check_valid for avoiding ambiguity
   and handling its return value in the caller uniformly, also cooperate
   switch checking true to false in do_recover_data for error case of
   f2fs_is_valid_blkaddr(type=DATA_GENERIC_ENHANCE_UPDATE) for more readable
---
---
 fs/f2fs/checkpoint.c   | 53 +++++++++++++++++++++++---------------------------
 fs/f2fs/data.c         | 22 +++------------------
 fs/f2fs/extent_cache.c |  5 +----
 fs/f2fs/file.c         | 16 +++------------
 fs/f2fs/gc.c           |  2 --
 fs/f2fs/recovery.c     |  6 +-----
 fs/f2fs/segment.c      |  2 --
 7 files changed, 32 insertions(+), 74 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b85820e..e90fa46 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -134,14 +134,15 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
-static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
+static bool __is_bitmap_check_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 							int type)
 {
 	struct seg_entry *se;
 	unsigned int segno, offset;
 	bool exist;
 
-	if (type == DATA_GENERIC)
+	if (type == DATA_GENERIC ||
+		type == DATA_GENERIC_ENHANCE_READ)
 		return true;
 
 	segno = GET_SEGNO(sbi, blkaddr);
@@ -149,25 +150,16 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	se = get_seg_entry(sbi, segno);
 
 	exist = f2fs_test_bit(offset, se->cur_valid_map);
+	if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
+			(!exist && type == DATA_GENERIC_ENHANCE))
+		goto err;
 
-	/* skip data, if we already have an error in checkpoint. */
-	if (unlikely(f2fs_cp_error(sbi)))
-		return exist;
-
-	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
-		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
-			 blkaddr, exist);
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		return exist;
-	}
-
-	if (!exist && type == DATA_GENERIC_ENHANCE) {
-		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
-			 blkaddr, exist);
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		dump_stack();
-	}
-	return exist;
+	return true;
+err:
+	f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
+		blkaddr, exist);
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	return false;
 }
 
 static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
@@ -178,22 +170,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 		break;
 	case META_SIT:
 		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
-			return false;
+			goto err;
 		break;
 	case META_SSA:
 		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
 			blkaddr < SM_I(sbi)->ssa_blkaddr))
-			return false;
+			goto err;
 		break;
 	case META_CP:
 		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
 			blkaddr < __start_cp_addr(sbi)))
-			return false;
+			goto err;
 		break;
 	case META_POR:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi)))
-			return false;
+			goto err;
 		break;
 	case DATA_GENERIC:
 	case DATA_GENERIC_ENHANCE:
@@ -209,22 +201,25 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 			f2fs_warn(sbi, "access invalid blkaddr:%u",
 				  blkaddr);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			dump_stack();
-			return false;
-		} else {
-			return __is_bitmap_valid(sbi, blkaddr, type);
+			goto err;
+		} else if (!__is_bitmap_check_valid(sbi, blkaddr, type)) {
+			goto err;
 		}
 		break;
 	case META_GENERIC:
 		if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
 			blkaddr >= MAIN_BLKADDR(sbi)))
-			return false;
+			goto err;
 		break;
 	default:
 		BUG();
 	}
 
 	return true;
+err:
+	dump_stack();
+	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+	return false;
 }
 
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 05158f8..300f9ae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			fio->is_por ? META_POR : (__is_meta_io(fio) ?
-			META_GENERIC : DATA_GENERIC_ENHANCE))) {
-		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
+			META_GENERIC : DATA_GENERIC_ENHANCE)))
 		return -EFSCORRUPTED;
-	}
 
 	trace_f2fs_submit_page_bio(page, fio);
 
@@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 			fio->encrypted_page : fio->page;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
-			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)) {
-		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
+			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
 		return -EFSCORRUPTED;
-	}
 
 	trace_f2fs_submit_page_bio(page, fio);
 
@@ -1286,8 +1282,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE_READ)) {
 			err = -EFSCORRUPTED;
-			f2fs_handle_error(F2FS_I_SB(inode),
-						ERROR_INVALID_BLKADDR);
 			goto put_err;
 		}
 		goto got_it;
@@ -1313,8 +1307,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 						dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE)) {
 		err = -EFSCORRUPTED;
-		f2fs_handle_error(F2FS_I_SB(inode),
-					ERROR_INVALID_BLKADDR);
 		goto put_err;
 	}
 got_it:
@@ -1642,7 +1634,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	if (!is_hole &&
 	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
 		err = -EFSCORRUPTED;
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto sync_out;
 	}
 
@@ -2166,8 +2157,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
 			ret = -EFSCORRUPTED;
-			f2fs_handle_error(F2FS_I_SB(inode),
-						ERROR_INVALID_BLKADDR);
 			goto out;
 		}
 	} else {
@@ -2707,11 +2696,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	    f2fs_lookup_read_extent_cache_block(inode, page->index,
 						&fio->old_blkaddr)) {
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
-						DATA_GENERIC_ENHANCE)) {
-			f2fs_handle_error(fio->sbi,
-						ERROR_INVALID_BLKADDR);
+						DATA_GENERIC_ENHANCE))
 			return -EFSCORRUPTED;
-		}
 
 		ipu_force = true;
 		fio->need_lock = LOCK_DONE;
@@ -2739,7 +2725,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
 						DATA_GENERIC_ENHANCE)) {
 		err = -EFSCORRUPTED;
-		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
 		goto out_writepage;
 	}
 
@@ -3706,7 +3691,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
 				DATA_GENERIC_ENHANCE_READ)) {
 			err = -EFSCORRUPTED;
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto fail;
 		}
 		err = f2fs_submit_page_read(use_cow ?
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ad8dfac7..48048fa 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
 	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
 	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
 					DATA_GENERIC_ENHANCE)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
 			  ei->blk, ei->fofs, ei->len);
@@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 		goto out;
 
 	if (__is_valid_data_blkaddr(blkaddr) &&
-	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
-		f2fs_bug_on(sbi, 1);
+	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
 		return -EINVAL;
-	}
 out:
 	/*
 	 * init block age with zero, this can happen when the block age extent
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 25b119cf..23cd6a1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 			if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
 				continue;
 			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
-						DATA_GENERIC_ENHANCE)) {
-				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+						DATA_GENERIC_ENHANCE))
 				continue;
-			}
 			if (compressed_cluster)
 				valid_blocks++;
 		}
@@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
 					DATA_GENERIC_ENHANCE)) {
 			f2fs_put_dnode(&dn);
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			return -EFSCORRUPTED;
 		}
 
@@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
 					DATA_GENERIC_ENHANCE)) {
 			ret = -EFSCORRUPTED;
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			break;
 		}
 
@@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		if (!__is_valid_data_blkaddr(blkaddr))
 			continue;
 		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
-					DATA_GENERIC_ENHANCE))) {
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+					DATA_GENERIC_ENHANCE)))
 			return -EFSCORRUPTED;
-		}
 	}
 
 	while (count) {
@@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		if (!__is_valid_data_blkaddr(blkaddr))
 			continue;
 		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
-					DATA_GENERIC_ENHANCE))) {
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+					DATA_GENERIC_ENHANCE)))
 			return -EFSCORRUPTED;
-		}
 	}
 
 	while (count) {
@@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 						DATA_GENERIC_ENHANCE)) {
 				ret = -EFSCORRUPTED;
 				f2fs_put_dnode(&dn);
-				f2fs_handle_error(sbi,
-						ERROR_INVALID_BLKADDR);
 				goto out;
 			}
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a079eeb..30e93d8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE_READ))) {
 			err = -EFSCORRUPTED;
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto put_page;
 		}
 		goto got_it;
@@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE))) {
 		err = -EFSCORRUPTED;
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto put_page;
 	}
 got_it:
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index aad1d1a..73d81e0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -693,14 +693,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (__is_valid_data_blkaddr(src) &&
 			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
 			err = -EFSCORRUPTED;
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto err;
 		}
 
 		if (__is_valid_data_blkaddr(dest) &&
 			!f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 			err = -EFSCORRUPTED;
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto err;
 		}
 
@@ -750,13 +748,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto err;
 			}
 
-			if (f2fs_is_valid_blkaddr(sbi, dest,
+			if (!f2fs_is_valid_blkaddr(sbi, dest,
 					DATA_GENERIC_ENHANCE_UPDATE)) {
 				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
 					dest, inode->i_ino, dn.ofs_in_node);
 				err = -EFSCORRUPTED;
-				f2fs_handle_error(sbi,
-						ERROR_INVALID_BLKADDR);
 				goto err;
 			}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7901ede..ad6511f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 					DATA_GENERIC_ENHANCE)) {
 				f2fs_put_dnode(&dn);
 				ret = -EFSCORRUPTED;
-				f2fs_handle_error(sbi,
-						ERROR_INVALID_BLKADDR);
 				goto out;
 			}
 
-- 
1.9.1


