Return-Path: <linux-kernel+bounces-114246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7288895B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C671F2FA51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544B16AFDF;
	Sun, 24 Mar 2024 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvQbyrrg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E01384B3;
	Sun, 24 Mar 2024 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321599; cv=none; b=BsP0TCXnf+rXa4nOr92smFgVyECZ6ktKiKa2CnzIIvL+1wWJ0NCCm3ifQUXtaZWGs3YyrtVBvuq3fAeJIc5Ir0KavZBgmrOtcWBkYYlkiIKPBfdXAeYVImgTkdqV3dk7T5dta2KYl68iqMvUtS7xxYQ50ALslYuSwJuZbyiacB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321599; c=relaxed/simple;
	bh=KMdxwmMNod1obbjCFhfxTYuNvd75ARGzr7DHPrUE1dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa4+x3mSfC6HTrmApk+uQn37vRXfX7GGS/PU+VlAn/ldN5RhMNypxuZIpgXzeqLlVV00kwPzctG1fEfVgA5zWqysvmBjNOHUMTGA24yBIHFE1pi2MURUAdrjHoMb9+fXjyAHg6AHDExnI1v32sbnmvlmJVnirThs5d6CYFPeBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvQbyrrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CB0C433C7;
	Sun, 24 Mar 2024 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321598;
	bh=KMdxwmMNod1obbjCFhfxTYuNvd75ARGzr7DHPrUE1dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvQbyrrgQL3Uq1jkV08tSozwumCG2mP7WaC7WKm8vEjai2nNKQAT+9QNqQv8tzKZG
	 rLYFqPLHMOiCixbJQJwSjpgjea5NMigB9kztMn9tLva7eAqDpoG2DzwombsUJTjJAT
	 +KQhUCDRzXDLmXyX2ui1YPSaGCHK3CNo7ZFEXWLoeVCZ40PMQqNkmMZP/LckM42Yxq
	 MqUqtrYhCHFMLyOLFW7RUxKBoL2GaCjz3JBmrzYrG7pcJvwCTT6SulL/jVRyQACIbf
	 7uzogGlcIBPFOtaivpZ045hW8PhDsWErpnLr71wZeZuo6uWUDcbou4yWe07+12i6be
	 vcpjkulkyEPLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 328/638] block: Provide bdev_open_* functions
Date: Sun, 24 Mar 2024 18:56:05 -0400
Message-ID: <20240324230116.1348576-329-sashal@kernel.org>
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

[ Upstream commit e719b4d156749f02eafed31a3c515f2aa9dcc72a ]

Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put() and provide bdev_open_* functions that return
this structure instead of plain bdev pointer. This will eventually allow
us to pass one more argument to blkdev_put() (renamed to bdev_release())
without too much hassle.

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230927093442.25915-1-jack@suse.cz
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 0f28be64d132 ("erofs: fix lockdep false positives on initializing erofs_pseudo_mnt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c           | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 10 +++++++++
 2 files changed, 58 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 04dba25b0019e..5a54977518eea 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -831,6 +831,25 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
 
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				     const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle = kmalloc(sizeof(*handle), GFP_KERNEL);
+	struct block_device *bdev;
+
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(bdev)) {
+		kfree(handle);
+		return ERR_CAST(bdev);
+	}
+	handle->bdev = bdev;
+	handle->holder = holder;
+	return handle;
+}
+EXPORT_SYMBOL(bdev_open_by_dev);
+
 /**
  * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
@@ -869,6 +888,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
+struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	handle = bdev_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
+	    bdev_read_only(handle->bdev)) {
+		bdev_release(handle);
+		return ERR_PTR(-EACCES);
+	}
+
+	return handle;
+}
+EXPORT_SYMBOL(bdev_open_by_path);
+
 void blkdev_put(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -905,6 +946,13 @@ void blkdev_put(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(blkdev_put);
 
+void bdev_release(struct bdev_handle *handle)
+{
+	blkdev_put(handle->bdev, handle->holder);
+	kfree(handle);
+}
+EXPORT_SYMBOL(bdev_release);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f59fcd5b499a5..5b6e86b2c37a5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1479,14 +1479,24 @@ extern const struct blk_holder_ops fs_holder_ops;
 #define sb_open_mode(flags) \
 	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+};
+
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops);
+struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, void *holder);
+void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.43.0


