Return-Path: <linux-kernel+bounces-54551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCC584B099
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA6D1C2253B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60912F396;
	Tue,  6 Feb 2024 09:00:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8612DD8B;
	Tue,  6 Feb 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210001; cv=none; b=AhIL5eMUE8k1UF7ld9RP8i5br10WPtQr2C9ERxTfDeduKsgEPCoW6YACaxtcPZ7k0+dWbWDjDo8A7a7dN5vsPjyxZWyOdznvdjhrnG3LQuhV8gz34a6+DYTKNJGmPXwiedUJE5rCgsg09kXtrX2O+Ue+4h92w9tXXkYIe2d3z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210001; c=relaxed/simple;
	bh=H/alJ/3zoRLTUvvj4DHF2RFOl5ysgpYtLrzw+xmVOMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYWUPzegPxHGZpzGWhgc3mFqNPj4SB0VHUV8SYxDvZBXkSytml8qpCsmi6TQb/lE7L8mn5xGxQ27gvw9JEa4PvkQ31VfPc+xTTJz85E3sGFVB+7Zd4uKudGzbW6uqaZ2lovMgC5w3neCX1pwU98rBaTcNUNeS5e2OM9du77vpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TTcdK6Jylz4f3mHr;
	Tue,  6 Feb 2024 16:59:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 926CD1A027B;
	Tue,  6 Feb 2024 16:59:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S13;
	Tue, 06 Feb 2024 16:59:56 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	mariusz.tkaczyk@linux.intel.com,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v6 9/9] md: check mddev->pers before calling md_set_readonly()
Date: Tue,  6 Feb 2024 16:55:11 +0800
Message-Id: <20240206085511.2841555-10-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206085511.2841555-1-linan666@huaweicloud.com>
References: <20240206085511.2841555-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S13
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Xw47uF15tw1DZFWDArb_yoW8Zr47p3
	9aqF98Gr18Xryayr4Dt3WkuFy5Zw17tryDtrWxu3yrua4Fywn8Gryag3WxJrWDKas7Aay5
	Xa1UJFW7ua4Ig3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUY4EEUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If 'mddev->pers' is NULL, there is nothing to do in md_set_readonly().
Except for md_ioctl(), the other two callers of md_set_readonly() have
already checked 'mddev->pers'. To simplify the code, move the check of
'mddev->pers' to the caller.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index adb821626d66..987851db98c1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6412,6 +6412,7 @@ void md_stop(struct mddev *mddev)
 
 EXPORT_SYMBOL_GPL(md_stop);
 
+/* ensure 'mddev->pers' exist before calling md_set_readonly() */
 static int md_set_readonly(struct mddev *mddev)
 {
 	int err = 0;
@@ -6451,20 +6452,18 @@ static int md_set_readonly(struct mddev *mddev)
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
 	return err;
 }
@@ -7752,7 +7751,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-		err = md_set_readonly(mddev);
+		if (mddev->pers)
+			err = md_set_readonly(mddev);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
-- 
2.39.2


