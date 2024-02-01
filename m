Return-Path: <linux-kernel+bounces-47703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F318A845185
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3F7295241
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107015AAA8;
	Thu,  1 Feb 2024 06:38:37 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2B157E78;
	Thu,  1 Feb 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769516; cv=none; b=TDtLAiG03cMjluqUmbMEIL1irTIaeZ8kZLzYVrbODbtx2zZ7VKAuqqJKN5X4qrgLdSLLIwCSGjK7+lFSNVT372BiFfPs2XNJLgUW+8F16rlYh/+ccybcTzzl4WgVzQLCpStXW4hYc25u6I/qmMfozzz7yjB88TCpetOOBZWWI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769516; c=relaxed/simple;
	bh=FgoOAkQGCz2LvCk0WpcgjLn7q9QSD5DfzKqFyR6V3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2tz7ubdaoYT2JvTOD/6+n3Wht6xJn3MhsGqts8U91fuKbQlAd4f7kSTquU9OOVO4xsmtnME51ereFXRD/t+oxNl0hpXiT3q0P4Znqm0NXGk08FGiuwXe8FZ3lLDHDzTuAnOya6T6UviRN7dGnJ86PU4q0DgQyrhQcIf6rr9WEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQTkV6RGWz4f3kpX;
	Thu,  1 Feb 2024 14:38:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1B7A81A0232;
	Thu,  1 Feb 2024 14:38:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S10;
	Thu, 01 Feb 2024 14:38:30 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	neilb@suse.com,
	mariusz.tkaczyk@linux.intel.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 6/8] md: factor out a helper to sync mddev
Date: Thu,  1 Feb 2024 14:34:02 +0800
Message-Id: <20240201063404.772797-7-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201063404.772797-1-linan666@huaweicloud.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S10
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrJrWfurWDJr17JFW5KFg_yoW8Aryrp3
	yftF9xKr1UGrZIyr47J34DZ3WYgw1Ikayvyry7Ca4xZF97ArsF9ryF9ry8GrykK34xAF4D
	tw18Xa15Wa4UWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbMKZtUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There are no functional changes, prepare to sync mddev in
array_state_store().

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index deee004b8f22..4c7a0225f77d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -515,6 +515,24 @@ void mddev_resume(struct mddev *mddev)
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
@@ -7685,17 +7703,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
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
+		err = mddev_set_closing_and_sync_blockdev(mddev);
+		if (err)
+			return err;
 	}
 
 	if (!md_is_rdwr(mddev))
-- 
2.39.2


