Return-Path: <linux-kernel+bounces-102076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6587AE32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806D81C23026
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B715B96C;
	Wed, 13 Mar 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgDOTEr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256515D5A9;
	Wed, 13 Mar 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348457; cv=none; b=AFZbLFCb2X2M2ouohYWnPyFcmw198yMKc3pOkTsKdqzesW+zQZgZ2bQehPxfsles+B6GDzLQ97NmD/sEN5q8jKnuS3H0X8IngaUtZnqj47KfNluKXfVduIAUIlBn+2wOEwMcGRKL1EcuuWdyO3sL0Gm/nVMYgkKOWp2iEueRlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348457; c=relaxed/simple;
	bh=he7vDD0F7WTBM5sUNCP71TiC7WyKB9hFx2d1SuU2sR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnJVsHAVgLIUzRLFgOKE5vwI0ptYcJpK6wb4Q4JkwJ8N1Z8Kn6OaORqYPNAG51aPe9mhHbZyXCkFI06bn/mSkF9kvEdbUuIQbQIZDor5B40mfz9r2iRrfqH7laTUKh+u/8daDa+Y7KDwvmB5iE1hCbmTKbrcSek+YRSpoC/t95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgDOTEr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF09C433F1;
	Wed, 13 Mar 2024 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348457;
	bh=he7vDD0F7WTBM5sUNCP71TiC7WyKB9hFx2d1SuU2sR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgDOTEr4AzyTlbw+ZZoTdf07+dlAjVSD13ygwaSbFTiVs3Nl8G7Fr47+cjouG/hug
	 9cCXywinTNnUS2qiWJ7UjD1/PFTuElpUcBsr8O3V4LaP+Zjmpa7/8XysTDw0H23Xcp
	 y3OgbDsiJ7BIRgQ3NbdmmLqxNvcESK1OHuYOFZ5XO35aJWVeJ78Zm3uu4ADSklfnlM
	 MUTK+MdgKJ7J1xjTn3ttSHO98DLrGQeA7pQfu4yirODEKlkHSPx2nEERXzdgHv3gjf
	 7XcuTOvwlLpRBy3fHshXCLogdsuWL2p30NsYBbj07Ry6dJzlDdeYzUYpeZ1w/0ziCi
	 3DO/A8zgX+5xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 50/73] ext4: convert to exclusive lock while inserting delalloc extents
Date: Wed, 13 Mar 2024 12:46:17 -0400
Message-ID: <20240313164640.616049-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit acf795dc161f3cf481db20f05db4250714e375e5 ]

ext4_da_map_blocks() only hold i_data_sem in shared mode and i_rwsem
when inserting delalloc extents, it could be raced by another querying
path of ext4_map_blocks() without i_rwsem, .e.g buffered read path.
Suppose we buffered read a file containing just a hole, and without any
cached extents tree, then it is raced by another delayed buffered write
to the same area or the near area belongs to the same hole, and the new
delalloc extent could be overwritten to a hole extent.

 pread()                           pwrite()
  filemap_read_folio()
   ext4_mpage_readpages()
    ext4_map_blocks()
     down_read(i_data_sem)
     ext4_ext_determine_hole()
     //find hole
     ext4_ext_put_gap_in_cache()
      ext4_es_find_extent_range()
      //no delalloc extent
                                    ext4_da_map_blocks()
                                     down_read(i_data_sem)
                                     ext4_insert_delayed_block()
                                     //insert delalloc extent
      ext4_es_insert_extent()
      //overwrite delalloc extent to hole

This race could lead to inconsistent delalloc extents tree and
incorrect reserved space counter. Fix this by converting to hold
i_data_sem in exclusive mode when adding a new delalloc extent in
ext4_da_map_blocks().

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 64162470a7e6c..8b48ed351c4b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1728,10 +1728,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
 		/*
 		 * Delayed extent could be allocated by fallocate.
@@ -1773,8 +1771,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-	if (retval < 0)
-		goto out_unlock;
+	if (retval < 0) {
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
+	}
 	if (retval > 0) {
 		unsigned int status;
 
@@ -1790,24 +1790,21 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
-		goto out_unlock;
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
 	}
+	up_read(&EXT4_I(inode)->i_data_sem);
 
 add_delayed:
-	/*
-	 * XXX: __block_prepare_write() unmaps passed block,
-	 * is it OK?
-	 */
+	down_write(&EXT4_I(inode)->i_data_sem);
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
 	map_bh(bh, inode->i_sb, invalid_block);
 	set_buffer_new(bh);
 	set_buffer_delay(bh);
-
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
 	return retval;
 }
 
-- 
2.43.0


