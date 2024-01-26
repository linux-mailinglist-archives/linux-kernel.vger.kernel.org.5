Return-Path: <linux-kernel+bounces-39918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34383D761
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9066E1F22F55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1771D6B8;
	Fri, 26 Jan 2024 09:27:04 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2261946B;
	Fri, 26 Jan 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261223; cv=none; b=Jijr8/JReEtyixPbHVa999Lux4m1vJxEhjBZPKvfVEWbvubqt3iMPaTl6AuLPOzcCMknfcPALiQdXSKpE4W+CKBGSvYrRDHcjGi6GKUu3fAE3ahnVQfj1f09mr8pIt8r80MM4cXFLfxSYU1Sv51ctFFkgXuOpeKkOD4RVAKqohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261223; c=relaxed/simple;
	bh=4V/bQdag0va6YAtWVymcSG+PLIDu/Aa9xOdzv2GP9qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyBgEUAVlaTj7f6f7nnH0a5PvPpIe6OqJymM8ebocaKpDHmfuUMX620RwONcDsl60MWBbj0tPdvwrbxmc0Sr8CpkhQmYdbzEKzgPqv5bXu6faFIjxcFudpJXicWHBYWZ13wX/95mR7qlCdT+IeSc8dB4zb9cTqTRJTO6PRq2cZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLslc2vvpz4f3mHM;
	Fri, 26 Jan 2024 17:26:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B9E021A0272;
	Fri, 26 Jan 2024 17:26:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHferNlLsUdCA--.25360S6;
	Fri, 26 Jan 2024 17:26:58 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	neilb@suse.com,
	shli@fb.com,
	mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 2/4] md: factor out a helper to sync mddev
Date: Fri, 26 Jan 2024 17:22:52 +0800
Message-Id: <20240126092254.1314908-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126092254.1314908-1-linan666@huaweicloud.com>
References: <20240126092254.1314908-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHferNlLsUdCA--.25360S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrtFWfXFW5uw48Jw1DZFb_yoW8Cr17pa
	ySqF9xKr4UGrZxZr47JwnrZF1Ygw1Ikayvyry7CFyxZF97ArsF9ryFvFykGrykK34IyFZ8
	t3W8Za15Way3WrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYSoXUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There are no functional changes, prepare to sync mddev in
array_state_store().

Signed-off-by: Li Nan <linan122@huawei.com>
Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/md/md.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 06550fe34aa1..40ab5c7ce394 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -529,6 +529,24 @@ void mddev_resume(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
+/* sync bdev before setting device to readonly or stopping raid*/
+static int mddev_set_closing_and_sync_blockdev(struct mddev *mddev)
+{
+	mutex_lock(&mddev->open_mutex);
+	if (mddev->pers && atomic_read(&mddev->openers) > 1) {
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
@@ -7681,20 +7699,10 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		/* Need to flush page cache, and ensure no-one else opens
 		 * and writes
 		 */
-		mutex_lock(&mddev->open_mutex);
-		if (mddev->pers && atomic_read(&mddev->openers) > 1) {
-			mutex_unlock(&mddev->open_mutex);
-			err = -EBUSY;
-			goto out;
-		}
-		if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
-			mutex_unlock(&mddev->open_mutex);
-			err = -EBUSY;
+		err = mddev_set_closing_and_sync_blockdev(mddev);
+		if (err)
 			goto out;
-		}
 		clear_md_closing = true;
-		mutex_unlock(&mddev->open_mutex);
-		sync_blockdev(bdev);
 	}
 
 	if (!md_is_rdwr(mddev))
-- 
2.39.2


