Return-Path: <linux-kernel+bounces-115177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C659F888D95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8130C293E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2F308403;
	Mon, 25 Mar 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3kDPozZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AD291B76;
	Sun, 24 Mar 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324240; cv=none; b=qqNJHC5N0DKPAfdLmJYcRkRkyye47R2OVuhnuuH8kRsSR4HgGfxX8M9QWTNY8A2nZTIuBWhapq3Yn79Knn6JVPOK5JQaaMSh7TIhKWJL9Fgue6vrUuvUzXNMubdQjRvoQmGrwbv7QtjeaoHrkjK+dj+uWNGNTYPfldQEjIBtons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324240; c=relaxed/simple;
	bh=M5YgR7dp89qvG5/MBGCVJI1h4SHXDq4czn6ZSPk3NT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0bF4ASScNL4jN3yoWcepPm2ynBxybkNJa6VfDi7Vyz5qxqa+W5XKAWLeGIHtuWxjKM8ym3U+U7L7cNxUlKZaKo8TKIXvtRykz+z3vhCzyjLBniV71IucAlW+zRWxFpP37WhJA/3ZIgjBAnOZuGzZuM42qd05LHSNaDqAVy+2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3kDPozZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4584C433C7;
	Sun, 24 Mar 2024 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324238;
	bh=M5YgR7dp89qvG5/MBGCVJI1h4SHXDq4czn6ZSPk3NT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3kDPozZOAEILnXDZF9VvnoSotmHR28PBVIdCy0pynr/qHf9kLh+PM4dRvGddQ9x3
	 Hi2HCL08f3Mv8JUjlevKDyT0foTNmTv3TSy03NF5UC8xGffSbI/wO7KSa1ilBrHJlE
	 ZOLIDeFTl7p/LBBphgaPegc/y6LG1vjp25xuQPXQGpIl4VREJ5n0zEUeGy9dBoBF6L
	 W1XfjXmdeeg9WaSPQqXuMRbkNMCzkIrmH39HmHOa0SKup4/mx9Ni40cyWji4+UuBgK
	 TEj6r8OsW5LIUX0nqvHZ97dNYzELDjncUrPHr+/WJInom9mbUKn4UgrosmqZCQzz+G
	 seiT5igIIiDVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/148] block: add a new set_read_only method
Date: Sun, 24 Mar 2024 19:48:05 -0400
Message-ID: <20240324235012.1356413-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e00adcadf3af7a8335026d71ab9f0e0a922191ac ]

Add a new method to allow for driver-specific processing when setting or
clearing the block device read-only state.  This allows to replace the
cumbersome and error-prone override of the whole ioctl implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 9674f54e41ff ("md: Don't clear MD_CLOSING when the raid is about to stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c          | 5 +++++
 include/linux/blkdev.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3884d810efd27..6d6c4f4c411a6 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -451,6 +451,11 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
+	if (bdev->bd_disk->fops->set_read_only) {
+		ret = bdev->bd_disk->fops->set_read_only(bdev, n);
+		if (ret)
+			return ret;
+	}
 	set_device_ro(bdev, n);
 	return 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ac407c1d4d40f..8f0aafae09d97 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1997,6 +1997,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*set_read_only)(struct block_device *bdev, bool ro);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	struct module *owner;
-- 
2.43.0


