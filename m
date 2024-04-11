Return-Path: <linux-kernel+bounces-139711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D78A06BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55281C2218A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B513BAF1;
	Thu, 11 Apr 2024 03:32:22 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF513B5BC;
	Thu, 11 Apr 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806342; cv=none; b=AZnf4UzZi1ajl8zEZLk211rg175Lgsajuv+x7HkrMMaeoQeh/3Ag7+rE8JMRuwiud/qiafaHdlgjJ5jkwEOx37bmZOKYwwPJjSx/zutps/kpCsohjq9Va6ShWce2+OlTg/NHnfdtUo0nSo1K+Lt/MZxluuLaBP6Arw/NHhIuI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806342; c=relaxed/simple;
	bh=GheM9vxOJCWCBH+6+ieKL67ZOXjrV6PZ0d6G1co9brM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMSjat/7QjjHiMwH7GideV273EZFbArR7Lvu3SQZNbyHWehClpnsGjejG+R8Va8/NWKpiZ0LWjaLq9z+fUk7QRXJZUrUiiSu/yQgzvl5HZNiCZNBFrnIB1zVp4BIuVdRUwHltCixVhKOUaFoFJNLhAMv1km/S6tVNaH0Dk2esXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFQHJ2DSgz4f3k6V;
	Thu, 11 Apr 2024 11:32:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B6CF21A0572;
	Thu, 11 Apr 2024 11:32:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6+WRdmbRutJg--.8020S6;
	Thu, 11 Apr 2024 11:32:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	johannes.thumshirn@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 2/2] block: add plug while submitting IO
Date: Thu, 11 Apr 2024 11:23:49 +0800
Message-Id: <20240411032349.3051233-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6+WRdmbRutJg--.8020S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3Cw48Xr1DGr17AFW8JFb_yoW8XFy5pr
	WY93ZxKFWUWrs2vw48XFy7GF1ftF1DWry7A3y5Canxtr1j9r4qqwn2v340va4Fkr48WrW3
	Ar93Kr98Gw48CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
and __blkdev_direct_IO_async(), block layer can still benefit from caching
nsec time in the plug. And if caller already use plug, then there should be
no affect.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index e317d7bc0696..c833bc875a61 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -647,11 +647,13 @@ static void __submit_bio(struct bio *bio)
 static void __submit_bio_noacct(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
+	struct blk_plug plug;
 
 	BUG_ON(bio->bi_next);
 
 	bio_list_init(&bio_list_on_stack[0]);
 	current->bio_list = bio_list_on_stack;
+	blk_start_plug(&plug);
 
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -685,19 +687,23 @@ static void __submit_bio_noacct(struct bio *bio)
 		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 
+	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
 static void __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
+	struct blk_plug plug;
 
 	current->bio_list = bio_list;
+	blk_start_plug(&plug);
 
 	do {
 		__submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
+	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
-- 
2.39.2


