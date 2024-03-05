Return-Path: <linux-kernel+bounces-91613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80387143D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30E31C214FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14B37701;
	Tue,  5 Mar 2024 03:28:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F962942A;
	Tue,  5 Mar 2024 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609280; cv=none; b=DJpN/rXgqU4bOTL+FcrZhWLeshKkeBZ6VR5P58v69bQ32waRBYDrYObWMSq25kIr6dgk0D+pGvmq5d2o/ET0M6EUTVS59dd6vyF2XmkNDt5v+R1tI5BbGCzUCRz1sRbkxeDUirhZe73SWrLhj5Yz8AdR+yUTMZ1tHsUWsJPOFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609280; c=relaxed/simple;
	bh=YRh+Mt+daWe/BzDZsCdxpBwt/WHkdjmD0/0uz+38YQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ypr2tHfhW5ybQsSQX5psJ1Eu1Y1ohHg8j/NwAg9IIVZmFD+oEQaOKfLGe9OZc7/LAeqlrWlp4mtjWiU39vSMxNpd8JPp9LNgrc9uQPfobf05JS+a9KrEpM4pw+5Z/l0vspl+9MOCCbO0Lhibz0lWVz4C+gYApFB4nr1Sq7Y2UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpgxF3R8Xz4f3kKQ;
	Tue,  5 Mar 2024 11:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EF2A81A016E;
	Tue,  5 Mar 2024 11:27:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REzkeZlkkvtFw--.19090S4;
	Tue, 05 Mar 2024 11:27:48 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: axboe@kernel.dk,
	min15.li@samsung.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	hch@lst.de,
	yangerkun@huawei.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	lilingfeng@huaweicloud.com
Subject: [PATCH] block: move capacity validation to blkpg_do_ioctl()
Date: Tue,  5 Mar 2024 11:21:32 +0800
Message-Id: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REzkeZlkkvtFw--.19090S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW8XFWfKF1fuFWUWF4UJwb_yoW8Zw1Upr
	s8tay3Jw4rGF17ua42qa1fC34Fg3Zrtr4xJ3y8Gw1Fy347Aws7KFyF93yFv3WUtr93trWa
	vF40vFykuFyxCrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	E_M3UUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit 6d4e80db4ebe ("block: add capacity validation in
bdev_add_partition()") add check of partition's start and end sectors to
prevent exceeding the size of the disk when adding partitions. However,
there is still no check for resizing partitions now.
Move the check to blkpg_do_ioctl() to cover resizing partitions.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/ioctl.c           |  9 ++++++++-
 block/partitions/core.c | 11 -----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 438f79c564cf..de0cc0d215c6 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 {
 	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
-	sector_t start, length;
+	sector_t start, length, capacity, end;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -41,6 +41,13 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
+	capacity = get_capacity(disk);
+
+	if (check_add_overflow(start, length, &end))
+		return -EINVAL;
+
+	if (start >= capacity || end > capacity)
+		return -EINVAL;
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5f5ed5c75f04..b11e88c82c8c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -419,21 +419,10 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length)
 {
-	sector_t capacity = get_capacity(disk), end;
 	struct block_device *part;
 	int ret;
 
 	mutex_lock(&disk->open_mutex);
-	if (check_add_overflow(start, length, &end)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (start >= capacity || end > capacity) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (!disk_live(disk)) {
 		ret = -ENXIO;
 		goto out;
-- 
2.39.2


