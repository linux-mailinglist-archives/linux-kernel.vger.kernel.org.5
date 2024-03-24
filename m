Return-Path: <linux-kernel+bounces-114248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFF888F73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C01F22275
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54432257650;
	Sun, 24 Mar 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqtqSWR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15D1386A5;
	Sun, 24 Mar 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321601; cv=none; b=B6VOnEBRP4O0uS1rNTj9OLqrbNyvh6UJjsebkSdxUdnopfbobfAwmlrS29BPUYi9tz02xrMGBfhbIcNNZsuShBjA65gUTVZDx4aT9jWerb8dhRcOS85dLA90RTX/uMFiyKm6hVSRBtmGVlCUMU4b9eTMGtlRYFJ2rtdhEHVoVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321601; c=relaxed/simple;
	bh=IYvzvODyp4KjZ5zUyyxWPZXcnjbFRX/8Pk1R/e7lCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQYl3JjamAMaPDCYpOSNkdNXCd5yxQqCm/+3jb5EhClYPxZ/aEGkaDS46U7zeVmzp41X7QjRy864crGrWN6tWTRJ/wGqrq5aIDe/S5CWtHpK7PD6LDulprnJ+XUB+EjPG6IxvwlYL0R6w8p6DQGaf/P2rMYVzJM7hlgcDAGwzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqtqSWR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B44C433F1;
	Sun, 24 Mar 2024 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321599;
	bh=IYvzvODyp4KjZ5zUyyxWPZXcnjbFRX/8Pk1R/e7lCCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqtqSWR7Su66HWL+c27xEVXWvVcToJPacYfZSQHHCJeonvMSw8QZfWIzGnrlYuWyd
	 L+tcvgN0sdLIeb1K0/p5PKX3QHnwT+rYkr1O1OnPmfm8SbgR4hA9+8e5FitsYVvMhZ
	 RZdNc/HA7USe+RDq0U7SxdQ5wowvONG1KLYcCh6PDEdWLl2zzamm3975XEziEf9jbi
	 rvjpyGBXTLGM8s+6DsRg/7H4vmH8yySoX8fOjhye3fCk3/Pmr2WFEEa07JRUtif5Zl
	 RFhRA6vgpDqEb9xIxcrn06pT8zqVaIpmI+2xek+okwC81qrk33gWD3+auGgRN3AIYE
	 K3SS2ow7rsynQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 329/638] erofs: Convert to use bdev_open_by_path()
Date: Sun, 24 Mar 2024 18:56:06 -0400
Message-ID: <20240324230116.1348576-330-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 49845720080dff0afd5813eaebf0758b01b6312c ]

Convert erofs to use bdev_open_by_path() and pass the handle around.

CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-erofs@lists.ozlabs.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230927093442.25915-21-jack@suse.cz
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 0f28be64d132 ("erofs: fix lockdep false positives on initializing erofs_pseudo_mnt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/data.c     |  4 ++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 977bc23f96e47..a75c89a9a3d0b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -222,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev;
+		map->m_bdev = dif->bdev_handle->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -240,7 +240,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev;
+				map->m_bdev = dif->bdev_handle->bdev;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d8de61350dc05..eb062f19b766a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cc44fb2e001e6..4e1ca36987685 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,7 +174,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -198,13 +198,13 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev = blkdev_get_by_path(dif->path, BLK_OPEN_READ, sb->s_type,
-					  NULL);
-		if (IS_ERR(bdev))
-			return PTR_ERR(bdev);
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
-						  NULL, NULL);
+		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
+						sb->s_type, NULL);
+		if (IS_ERR(bdev_handle))
+			return PTR_ERR(bdev_handle);
+		dif->bdev_handle = bdev_handle;
+		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
+				&dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -750,8 +750,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev)
-		blkdev_put(dif->bdev, &erofs_fs_type);
+	if (dif->bdev_handle)
+		bdev_release(dif->bdev_handle);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
-- 
2.43.0


