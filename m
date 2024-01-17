Return-Path: <linux-kernel+bounces-28745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5484830281
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B4FB20EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4E1CD0F;
	Wed, 17 Jan 2024 09:40:46 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFB14003;
	Wed, 17 Jan 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484446; cv=none; b=kbV+jxLpstL2qlDbDf7YsunbhOK837xG7umHtrzcOrdibTRG1YwOLKHUVmUohKT3bUFliMbOwG+U6DT4EcmHOnd4qFR3ZOqiQqsyQbkE2g3s9KJ5lvQstXaqoFVEj5Qcj//QC+WfiIPPzg0GLN8gcpJJWk22lU96wXQnQMqVGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484446; c=relaxed/simple;
	bh=h3dNTuPG6vpBMY8jUp4OPZ0rLICpUpwRIhIAeUnDYu4=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=KIULjxX0QpddjPxuPRm5tEPXg46e/WYuywwUmaW+mDVFUJUu79/lhK2N4WYMlCfdvLbQm6E3/2KxhZdTAzrHHZbZ92SqOismKe4EkOZq1Nnn/u7FaAP/2rBwUXL4an/ssJEHDtmbJ5L/6WDfCfxPO+JjjSDwxECVfc91gSDU4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFLTf0pT1z4f3k5n;
	Wed, 17 Jan 2024 17:40:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 424B11A0840;
	Wed, 17 Jan 2024 17:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGUoKdlvS9nBA--.17816S6;
	Wed, 17 Jan 2024 17:40:40 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	shli@fb.com,
	neilb@suse.com,
	zlliu@suse.com,
	mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 2/3] md: factor out a helper mddev_sync_blockdev() to sync mddev
Date: Wed, 17 Jan 2024 17:37:06 +0800
Message-Id: <20240117093707.2767209-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117093707.2767209-1-linan666@huaweicloud.com>
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGUoKdlvS9nBA--.17816S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrZF4DXFW5AF48Kr4kWFg_yoW8Ar43pa
	yftF9xKr1UJrZxAr47JwnruF1Ygw1IkayvyrW7Ca4xZF9rArsruryFvry8GrykK34xAFWU
	t3WrXa15W347GrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
---
 drivers/md/md.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4bf821b89415..2c793992a604 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -529,6 +529,23 @@ void mddev_resume(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
+/* sync bdev before setting device to readonly or stopping raid*/
+static int mddev_sync_blockdev(struct mddev *mddev) {
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
@@ -7681,20 +7698,10 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
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
+		err = mddev_sync_blockdev(mddev);
+		if (err)
 			goto out;
-		}
 		did_set_md_closing = true;
-		mutex_unlock(&mddev->open_mutex);
-		sync_blockdev(bdev);
 	}
 
 	if (!md_is_rdwr(mddev))
-- 
2.39.2


