Return-Path: <linux-kernel+bounces-47706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C7845189
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49002954A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57E15B0F6;
	Thu,  1 Feb 2024 06:38:38 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFC1586D5;
	Thu,  1 Feb 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769517; cv=none; b=CzNyWltf24/5ZLVYoxHVJwzhC7EXnZQBA8oiMtnvoD6QoRIXIknu9xjWQU1RJjlbNnkaVW45xXW+KADeeefzeGdqctoyWndUon+OyVdcg2trH3WbBZ6pV4iGpMblWjFlLx4puo4Kk471A85+ABNEUOUl9J46KYv5BNWJQWU/Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769517; c=relaxed/simple;
	bh=PHJvhZQzij43APMcWRsyeSUFLWsPh9To9Ao12iS0SWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2iNyUI8YJ/sVcB2wvqEjim/KKzl2Dv54kQGueLXbgPevpXCB3kmRvMtffaeS1jgXR8fBmGl6gBRtd7+DZqqzHgaTc2h7vIKnwFnifivV/80mUgVTy4goPrvsk8gEqc73fkmD4WbmYtKD/5w8b08g07FzhE0aUXlgrhwowoLPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQTkT3VnVz4f3m7J;
	Thu,  1 Feb 2024 14:38:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 07BF81A027B;
	Thu,  1 Feb 2024 14:38:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S12;
	Thu, 01 Feb 2024 14:38:31 +0800 (CST)
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
Subject: [PATCH v5 8/8] md: check mddev->pers before calling md_set_readonly()
Date: Thu,  1 Feb 2024 14:34:04 +0800
Message-Id: <20240201063404.772797-9-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S12
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1rAF43ZrWUCr17Jr1fZwb_yoW5Jw4rp3
	9aqF98Gr48Xryavr4Dta4kuFy5Zw17ta4ktry7W34rW3Wftwn8uryFg3W8JrWkKas7AF45
	Xa1UJFW7ua42gFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUopBTDUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If 'mddev->pers' is NULL, there is nothing to do in md_set_readonly().
Except for md_ioctl(), the other two callers of md_set_readonly() have
already checked 'mddev->pers'. To simplify the code, move the check of
'mddev->pers' to the caller.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 86becf0015f5..2976cf778df3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6412,6 +6412,7 @@ void md_stop(struct mddev *mddev)
 
 EXPORT_SYMBOL_GPL(md_stop);
 
+/* ensure 'mddev->pers' exist before calling md_set_readonly() */
 static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 {
 	int err = 0;
@@ -6441,8 +6442,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	mddev_lock_nointr(mddev);
 
 	mutex_lock(&mddev->open_mutex);
-	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sync_thread ||
+	if (atomic_read(&mddev->openers) > !!bdev || mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		if (did_freeze) {
@@ -6453,20 +6453,18 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		err = -EBUSY;
 		goto out;
 	}
-	if (mddev->pers) {
-		__md_stop_writes(mddev);
+	__md_stop_writes(mddev);
 
-		err  = -ENXIO;
-		if (mddev->ro == MD_RDONLY)
-			goto out;
-		mddev->ro = MD_RDONLY;
-		set_disk_ro(mddev->gendisk, 1);
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
-		sysfs_notify_dirent_safe(mddev->sysfs_state);
-		err = 0;
-	}
+	err  = -ENXIO;
+	if (mddev->ro == MD_RDONLY)
+		goto out;
+	mddev->ro = MD_RDONLY;
+	set_disk_ro(mddev->gendisk, 1);
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	md_wakeup_thread(mddev->thread);
+	sysfs_notify_dirent_safe(mddev->sysfs_state);
+	err = 0;
 out:
 	mutex_unlock(&mddev->open_mutex);
 	return err;
@@ -7766,7 +7764,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-		err = md_set_readonly(mddev, bdev);
+		if (mddev->pers)
+			err = md_set_readonly(mddev, bdev);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
-- 
2.39.2


