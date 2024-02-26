Return-Path: <linux-kernel+bounces-80465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0318668B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AB21C216FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB71CD18;
	Mon, 26 Feb 2024 03:20:47 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641A1CA97;
	Mon, 26 Feb 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917647; cv=none; b=F3qL9FakJDBPesbqk8VNfhDpUnaoCdAmmNaL6nRDvV0Lg1I2lHrYaZnSsiJnow9XFbPF6SvtfcShbHZgpXZ5wZ9T/F9t3jUibyLwAGcTB9vjgibbHbUU6yxWBMgmRehZLW6VVFr3DCW8eWbZwM6/fdLKcwHovbMqp3j+MDw8hDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917647; c=relaxed/simple;
	bh=KFMpj1xexi/nx2hAKByHAD6I9yAndoK3N8l0IPARde0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mx/298Xe7lJlz3C19aRYn73w6fh9qUURmHUuiZBQSB/BkLsYg2exmPUvcqWDH3xBGQTyHrSpZfLGgUDmfhJBjN7HKFN5SMs3QKg3rFHPiHd/BQj5dIOx1Y1SFCf2me9IJS/B9esfpBwG04rVBUkLRJYs271aQ1OpJ13TjCkRhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8b3y9Sz4f3kFK;
	Mon, 26 Feb 2024 11:20:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B36CE1A0232;
	Mon, 26 Feb 2024 11:20:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S10;
	Mon, 26 Feb 2024 11:20:36 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: mariusz.tkaczyk@linux.intel.com,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v7 6/9] md: factor out a helper to sync mddev
Date: Mon, 26 Feb 2024 11:14:41 +0800
Message-Id: <20240226031444.3606764-7-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226031444.3606764-1-linan666@huaweicloud.com>
References: <20240226031444.3606764-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S10
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrAryrGryfAF45Kr4xXrb_yoW8AF1Dpa
	yftF9xKr1UGrZIyr47JryDZ3WYgw1Ikayvyry7Ca4xZF97ArsFgryFgry8GrykK34xAF45
	tw18Xa15W347Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbxR67UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There are no functional changes, prepare to sync mddev in
array_state_store().

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 43ca8a4c02ce..cba1027b279e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -529,6 +529,24 @@ void mddev_resume(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
+/* sync bdev before setting device to readonly or stopping raid*/
+static int mddev_set_closing_and_sync_blockdev(struct mddev *mddev, int opener_num)
+{
+	mutex_lock(&mddev->open_mutex);
+	if (mddev->pers && atomic_read(&mddev->openers) > opener_num) {
+		mutex_unlock(&mddev->open_mutex);
+		return -EBUSY;
+	}
+	if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
+		mutex_unlock(&mddev->open_mutex);
+		return -EBUSY;
+	}
+	mutex_unlock(&mddev->open_mutex);
+
+	sync_blockdev(mddev->gendisk->part0);
+	return 0;
+}
+
 /*
  * Generic flush handling for md
  */
@@ -7657,17 +7675,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		/* Need to flush page cache, and ensure no-one else opens
 		 * and writes
 		 */
-		mutex_lock(&mddev->open_mutex);
-		if (mddev->pers && atomic_read(&mddev->openers) > 1) {
-			mutex_unlock(&mddev->open_mutex);
-			return -EBUSY;
-		}
-		if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
-			mutex_unlock(&mddev->open_mutex);
-			return -EBUSY;
-		}
-		mutex_unlock(&mddev->open_mutex);
-		sync_blockdev(bdev);
+		err = mddev_set_closing_and_sync_blockdev(mddev, 1);
+		if (err)
+			return err;
 	}
 
 	if (!md_is_rdwr(mddev))
-- 
2.39.2


