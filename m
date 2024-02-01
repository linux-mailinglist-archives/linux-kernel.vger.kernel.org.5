Return-Path: <linux-kernel+bounces-47702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD74845180
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B21C23366
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA6158D90;
	Thu,  1 Feb 2024 06:38:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B971157050;
	Thu,  1 Feb 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769515; cv=none; b=lc91wCJC5hTnCVEt6K2eDXis4eY2RcvAPUIBKTTr/ANjIwvOVilHaIUpkkwYtJkZaxBuLBssWpr8gxx+wRgIRPoCMhw3iPLmnP6B6AJjCV6NQGLu/04j7xqJBiFGs+VMPzOA7UAhLGiAaKm6EH9FPYAyKfj2wl2cHmbZVOwC76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769515; c=relaxed/simple;
	bh=ftZkeplxga5glU/a1AQpEFCjQrpl9nc9WPVPM/ByKWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyAZb1doYm1r1nBdbNYawulY0phNMljDF1JF8S0mVz1P86v4QFGhBPpzvNxNenhn6kqc+wd1+DpbI6zH2TD2o9Q6eKAZf6B2Ba7Mvz0e129bp0BxGUVvbcKPmVrjZxMJ2S2rz3Ih0uAKkC/GdPp3LjXNuv32EkrdsFaIoA73lEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQTkR4dF1z4f3lWC;
	Thu,  1 Feb 2024 14:38:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2DB2C1A0175;
	Thu,  1 Feb 2024 14:38:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S8;
	Thu, 01 Feb 2024 14:38:29 +0800 (CST)
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
Subject: [PATCH v5 4/8] md: return directly before setting did_set_md_closing
Date: Thu,  1 Feb 2024 14:34:00 +0800
Message-Id: <20240201063404.772797-5-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWfXw4UKry7uw15CF48JFb_yoW8Zr4xpF
	ZagF9xtrWrJFWUKr1DJa4DZFyYqw13KFWvkryxCryjvF9FyrsxZryFg3yFqry0g34kA3y5
	tF12qa15Wa4xJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is nothing to do at 'out' before setting 'did_set_md_closing'
in md_ioctl(). Return directly, and it will help us to remove
'did_set_md_closing' later.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 656080086052..5442e8e3c161 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7636,10 +7636,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	 * Commands dealing with the RAID driver but not any
 	 * particular array:
 	 */
-	if (cmd == RAID_VERSION) {
-		err = get_version(argp);
-		goto out;
-	}
+	if (cmd == RAID_VERSION)
+		return get_version(argp);
 
 	/*
 	 * Commands creating/starting a new array:
@@ -7654,23 +7652,20 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			err = -ENODEV;
 		else
 			err = get_array_info(mddev, argp);
-		goto out;
+		return err;
 
 	case GET_DISK_INFO:
 		if (!mddev->raid_disks && !mddev->external)
 			err = -ENODEV;
 		else
 			err = get_disk_info(mddev, argp);
-		goto out;
+		return err;
 
 	case SET_DISK_FAULTY:
-		err = set_disk_faulty(mddev, new_decode_dev(arg));
-		goto out;
+		return set_disk_faulty(mddev, new_decode_dev(arg));
 
 	case GET_BITMAP_FILE:
-		err = get_bitmap_file(mddev, argp);
-		goto out;
-
+		return get_bitmap_file(mddev, argp);
 	}
 
 	if (cmd == HOT_REMOVE_DISK)
@@ -7686,13 +7681,11 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		mutex_lock(&mddev->open_mutex);
 		if (mddev->pers && atomic_read(&mddev->openers) > 1) {
 			mutex_unlock(&mddev->open_mutex);
-			err = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 		if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
 			mutex_unlock(&mddev->open_mutex);
-			err = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
-- 
2.39.2


