Return-Path: <linux-kernel+bounces-87773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E986D8D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED811C2112E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1D2C68F;
	Fri,  1 Mar 2024 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KXTKZuBI"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953F3984A;
	Fri,  1 Mar 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256787; cv=none; b=S56VLnaNeIiu1oijXwKSZX+NmR8AUOaR+2+Fbmzm6qbDh6DjiKCVtc48neIf2z0BLKu68SMT+0cC7+pTpbXKaWne4lML+/HN9dBDMOAtrJmMkNuPeFNv61/hdXnGN7Yrc3DbCZxtw1k3TkixekhqOkRyhXc45h9OG9qrwFgg8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256787; c=relaxed/simple;
	bh=xLeQQdqrm7Aq4hmh/vp/0FElKtBEhB5LlHFCYph3wdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QffO0zFnirgv0MbLvd4TJlshtlCBQP09O9uqi0GSQEjlEadtD8Xcy7DmJfGhFsIDYyqpBZTSTclXjKhcp4ef6i1jyLZoCgcAuVOuNRpfvYUi5iRMsRf3t9RL3x1aaZb9+LMMNwsSefJuU6AU5gy/8hK8NhXZxgU+WrR8HPG5uMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KXTKZuBI; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dcrWG
	GH+E6Je/BEs6GtPRlXPUQyROv4t+ihp6LPlmU4=; b=KXTKZuBIgKG9unmmvJeI1
	2wCEszZcamQ5OQgZxrcqQ+ON+CXdSAp2dk+2gE3lDflVo7z3+dbE+IO9IRKJ3RMj
	rxITFLhc3yl1Lp2fO9kYPEv5rN4R2/eTgq6ApHRv57VQbGEUf4znVnRtWFH/5xNk
	8si+uE+ZXvMMbybPqS2eOI=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S8;
	Fri, 01 Mar 2024 09:32:39 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Martijn Coenen <maco@android.com>,
	Christoph Hellwig <hch@lst.de>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 4/9] loop: Factor out setting loop device size
Date: Fri,  1 Mar 2024 09:30:23 +0800
Message-Id: <20240301013028.2293831-5-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF47GrW5Xw1kZFWfWr4kZwb_yoW5Jw17pF
	13Wa43G3yFvFy7WFsIqr1kZrW5Ka1kW347ury3C34Y9a1YyrnagF4rAry8WrWkJrWkWF1Y
	qa98Ar109r1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHCJQUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHhmUfmV2z7wVDwAAsX

From: Martijn Coenen <maco@android.com>

[ Upstream commit 5795b6f5607f7e4db62ddea144727780cb351a9b ]

This code is used repeatedly.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 281aefba2a6f..6bd07fa3a1fc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -225,20 +225,35 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_set_size() - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t, eg using loop_validate_size()
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
+{
+	struct block_device *bdev = lo->lo_device;
+
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
+	/* let user-space know about the new size */
+	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+}
+
 static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	struct block_device *bdev = lo->lo_device;
 
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
 }
 
 static inline int
@@ -992,11 +1007,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
-- 
2.25.1


