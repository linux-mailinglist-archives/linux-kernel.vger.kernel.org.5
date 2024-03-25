Return-Path: <linux-kernel+bounces-117361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227988AA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA11F62B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A65CDE6;
	Mon, 25 Mar 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBjHiojb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146546BB29
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380457; cv=none; b=lUpXseidjNqvlGz1OpwfMiCmn89EpwTaHkmIsfc7o9EycYpCUplY8X3sQWtYZZWcyZE5fFAaBXxBcfXvhgy2pDkT4tdzDljIW4fHYqT+xk8qE6plO/iklqQzQuYvgvBi4tYJ7l68AXowJmRlvHib/wSdldPeHiYSYgSooDAWpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380457; c=relaxed/simple;
	bh=bYZG5pNg1OWqiulIpBARahqIyHHQkI5zrD80VoIQK0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJjOJykVH730gUgB9PccpQlSNZLZ3HMODYFmzHvCHByJM7cFDp62UcLExpvR6GzWilfAVwi0vJQ8Ahr71sL+R3p04BNatEdxLRaijx90y3E8oayD62kb2d7KboFZ7bs01f8oHlbw7juXqgs3fLFTJjtpVOIWTYgKYeinmSLteDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBjHiojb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A5C433C7;
	Mon, 25 Mar 2024 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711380456;
	bh=bYZG5pNg1OWqiulIpBARahqIyHHQkI5zrD80VoIQK0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=GBjHiojbSc3MWX4fAZuZ2TnKpEkMthvhxaoCec4169pTA63MnK8Wl6PIBiPALq0t9
	 ziS1E8AxNvudgpkOGpY7VIO+OHKo3lWjqjVt/q1nH7906H8RzWD0F1Pk+zUtaxSznw
	 Me180qDYEg1eSICiOC261/dfJGqmGpEM2gdScfa+69N2QGDFT9oWqYepausBiUDo0s
	 3a72LRom7rt5dDMYFMOjSSWX+yXdi0w4tZB/eKkZCmjb0EiKYHQ4mawf9XmkeuEJkv
	 yUuHVXIy8X3JAjBvia+glNKr2QGk4eUlt1DWBVaQ/jXszZ+MdnQ5zUihwTdkuGErsI
	 VnbLu+QYGXVOw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: introduce map_is_mergeable() for cleanup
Date: Mon, 25 Mar 2024 23:27:25 +0800
Message-Id: <20240325152726.797423-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5ef1874b572a..9c000ca4f808 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1507,6 +1507,23 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 	return true;
 }
 
+static bool map_is_mergeable(struct f2fs_sb_info *sbi,
+				struct f2fs_map_blocks *map,
+				block_t blkaddr, int flag, int bidx,
+				int ofs)
+{
+	if (map->m_multidev_dio && map->m_bdev != FDEV(bidx).bdev)
+		return false;
+	if (map->m_pblk != NEW_ADDR &&
+		blkaddr == (map->m_pblk + ofs))
+		return true;
+	if (map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR)
+		return true;
+	if (flag == F2FS_GET_BLOCK_PRE_DIO)
+		return true;
+	return false;
+}
+
 /*
  * f2fs_map_blocks() tries to find or build mapping relationship which
  * maps continuous logical blocks to physical blocks, and return such
@@ -1653,12 +1670,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 		if (map->m_multidev_dio)
 			map->m_bdev = FDEV(bidx).bdev;
-	} else if ((map->m_pblk != NEW_ADDR &&
-			blkaddr == (map->m_pblk + ofs)) ||
-			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
-			flag == F2FS_GET_BLOCK_PRE_DIO) {
-		if (map->m_multidev_dio && map->m_bdev != FDEV(bidx).bdev)
-			goto sync_out;
+	} else if (map_is_mergeable(sbi, map, blkaddr, flag, bidx, ofs)) {
 		ofs++;
 		map->m_len++;
 	} else {
-- 
2.40.1


