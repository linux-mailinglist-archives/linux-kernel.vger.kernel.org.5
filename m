Return-Path: <linux-kernel+bounces-161309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60768B4A81
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D828B214CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94250A67;
	Sun, 28 Apr 2024 07:28:55 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B64F8A3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714289335; cv=none; b=itTECVQn1BnETJ9O9c+IGPlhT0sPn8w1cHSWAnz0ONChbpB43Mh9haq26xmLGmmNquOJF4zGyyVlspHbE0bOzch4ekpqd1sjC74s1AB6wCtk6lM5Z2rCBFKfsUKgy20QadS6t3YexZ3JDEfCfuFlBgHbqtMqx5B9a5RrW+FEC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714289335; c=relaxed/simple;
	bh=FGeFBTObhslhjMsVOBLpCyUd93LnC+Y1MOuCbCeu1RM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOYIU8SA+j+5f/EfqCZen5Mc+O7Mf7MhIqujpnSAr6Ql27dwdD93NDJIuvrPe/v/jwHLArOyvNRJfruHrhxHvy1Lnmm2tJdMn1cuA6ViFSDS7xD8520BFhUhUbvFjnObUOVqYNkGNJ3JZImAgRoHNdR5loFyvty0XNdUxNN8h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VRykK1glVz4f3jd1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F3D601A0572
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:28:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCu+i1m9VSxLA--.18736S4;
	Sun, 28 Apr 2024 15:28:48 +0800 (CST)
From: linan666@huaweicloud.com
To: richard@nod.at,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	axboe@kernel.dk,
	chaitanya.kulkarni@wdc.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] ubi: block: fix null-pointer-dereference in ubiblock_create()
Date: Sun, 28 Apr 2024 15:19:22 +0800
Message-Id: <20240428071922.2270892-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCu+i1m9VSxLA--.18736S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4kAr4Dtr4kXFy5Cr4fuFg_yoW8WF1Dpa
	yDWa4Y9rW8GFWDuF4DJw4kCFy5X3W0g34rGFW29w4Fvr93Jr4IkFsYgr1Yvr4IyF97JanI
	qFnxGrW8W3W8C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBSoJUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Similar to commit adbf4c4954e3 ("ubi: block: fix memleak in
ubiblock_create()"), 'dev->gd' is not assigned but dereferenced if
blk_mq_alloc_tag_set() fails, and leading to a null-pointer-dereference.

Using 'gd' directly here is not a good idea, too. 'gd->part0.bd_device'
is not initialized at this point. The error log will be:
  block (null): block: dynamic minor allocation failed

Fix it by using pr_err() and print ubi id.

Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/mtd/ubi/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index f82e3423acb9..bf7308e8ec2f 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
-		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
+		pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
+			dev->ubi_num, dev->vol_id);
 		goto out_free_dev;
 	}
 
@@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	gd->minors = 1;
 	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
 	if (gd->first_minor < 0) {
-		dev_err(disk_to_dev(gd),
-			"block: dynamic minor allocation failed");
+		pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
+			dev->ubi_num, dev->vol_id);
 		ret = -ENODEV;
 		goto out_cleanup_disk;
 	}
-- 
2.39.2


