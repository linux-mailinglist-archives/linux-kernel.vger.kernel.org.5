Return-Path: <linux-kernel+bounces-30131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30149831A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB63F282425
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24D25553;
	Thu, 18 Jan 2024 13:07:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E30250E1;
	Thu, 18 Jan 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583263; cv=none; b=FNmm1dvampa7D1mqoKIVSOFYJQRQl+l3Yk08hvCt5jAnibRMyxsmml/YqmvNyIIkJc0kuugLZAL43m7oVztLRZhpryARTXL57y0QIN5Yaj3qwh4RP5WdDfYmkGFXXzXGoizpKv28Z8QdFACgn4ZjGxRXln5Oh/K/aJWNxpKoFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583263; c=relaxed/simple;
	bh=BtEeITIhhSJByudkXtg5B1z1EVkxDfr9R3qotxd8td8=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=qFp+5Gic0+Ig+LIzTVAkauHUFILXlzGrzZ3JftEbzeLEDpdmxYHHcp8l1K7HH7MKIVC6ILwIGzs4DgXzKDpfvmy1bKWZz9uHMizdQYimcUrnwwPUr2wHNrs3DnOSoQL1+0OvGoD5Sjs60zBqMByfQwn2dNG9ErK6nj1a/yQ3Ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TG31s54KGz4f3m6x;
	Thu, 18 Jan 2024 21:07:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D245A1A09E5;
	Thu, 18 Jan 2024 21:07:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGWIqllGLveBA--.44857S4;
	Thu, 18 Jan 2024 21:07:35 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: allison.karlitskaya@redhat.com,
	hch@infradead.org,
	axboe@kernel.dk,
	yukuai1@huaweicloud.com
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: [PATCH] block: Move checking GENHD_FL_NO_PART to bdev_add_partition()
Date: Thu, 18 Jan 2024 21:04:01 +0800
Message-Id: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGWIqllGLveBA--.44857S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryUurWxJF18Zry5Cr17KFg_yoW8AFy7pr
	s8XrWjyw1UKFn8uayUta1xu3W5W3Z3JFs7K3yxAw4FvrW3AwnrtFy09ayY9a1Yqr9IkrWS
	vr4SqrWkAFyxCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUouWlDUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit 1a721de8489f ("block: don't add or resize partition on the disk
with GENHD_FL_NO_PART") prevented all operations about partitions on disks
with GENHD_FL_NO_PART in blkpg_do_ioctl() since they are meaningless.
However, it changed error code in some scenarios. So move checking
GENHD_FL_NO_PART to bdev_add_partition() to eliminate impact.

Fixes: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Closes: https://lore.kernel.org/all/CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/ioctl.c           | 2 --
 block/partitions/core.c | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c73a763ef88..438f79c564cf 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	sector_t start, length;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index e6ac73617f3e..8bc68e8acafd 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -439,6 +439,11 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		goto out;
 	}
 
+	if (disk->flags & GENHD_FL_NO_PART) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (partition_overlaps(disk, start, length, -1)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.39.2


