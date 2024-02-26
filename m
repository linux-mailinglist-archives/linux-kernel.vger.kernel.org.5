Return-Path: <linux-kernel+bounces-80461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC768668A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F068BB213CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523C1BF32;
	Mon, 26 Feb 2024 03:20:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5018EA1;
	Mon, 26 Feb 2024 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917643; cv=none; b=m8kXdtsW3lRcqblmHedtXM1jpix3L1O37OCmql36zTZWS7ErTcdd6GzB/UUJOsWVdA3eJnW3Vw4fUngvhu7dO0KTJAS9CNob90tg2Z4EeXnpCCJ7GN1Z1/lDy6dK0wYbeq5wjOmOK7eLyk4tTBUF7QBl4i/+IVAjCLajaClFgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917643; c=relaxed/simple;
	bh=pxkzW3x8CNPXo/PaItuAjkfqG+f8YqJQM2EENaYKhYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQFocKs/aubwEhrbieZu2kHq30S4cwavV/NbxgeQpCFkfaw7qxGUhiDdYR+8LdZT0lVk9CI5RdxgzAbqf1zQplYC/nE1wCJsY8dmVbpo/z4trP5S8qm81p3kDznYhGhfbic4dsZixLfbdx364re0O3zFCcfkmX8CXs92m08ETww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8f6FY9z4f3kKD;
	Mon, 26 Feb 2024 11:20:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F4971A016E;
	Mon, 26 Feb 2024 11:20:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S13;
	Mon, 26 Feb 2024 11:20:37 +0800 (CST)
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
Subject: [PATCH v7 9/9] md: check mddev->pers before calling md_set_readonly()
Date: Mon, 26 Feb 2024 11:14:44 +0800
Message-Id: <20240226031444.3606764-10-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S13
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Xw47uF15tw1Dtw1UZFb_yoW8Aryfp3
	9aqF98Gr18X34avr4Uta1kWa45Xw1xt34qkryxu3yfXF15Awn8WrySga18XrWkKas7AFZx
	Xa15GFW7ua4Ig3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUY4EEUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If 'mddev->pers' is NULL, there is nothing to do in md_set_readonly().
Except for md_ioctl(), the other two callers of md_set_readonly() have
already checked 'mddev->pers'. To simplify the code, move the check of
'mddev->pers' to the caller.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 82c12ecf17a6..f227a7613003 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6419,6 +6419,7 @@ void md_stop(struct mddev *mddev)
 
 EXPORT_SYMBOL_GPL(md_stop);
 
+/* ensure 'mddev->pers' exist before calling md_set_readonly() */
 static int md_set_readonly(struct mddev *mddev)
 {
 	int err = 0;
@@ -6443,20 +6444,18 @@ static int md_set_readonly(struct mddev *mddev)
 		goto out;
 	}
 
-	if (mddev->pers) {
-		__md_stop_writes(mddev);
-
-		if (mddev->ro == MD_RDONLY) {
-			err  = -ENXIO;
-			goto out;
-		}
+	__md_stop_writes(mddev);
 
-		mddev->ro = MD_RDONLY;
-		set_disk_ro(mddev->gendisk, 1);
+	if (mddev->ro == MD_RDONLY) {
+		err  = -ENXIO;
+		goto out;
 	}
 
+	mddev->ro = MD_RDONLY;
+	set_disk_ro(mddev->gendisk, 1);
+
 out:
-	if ((mddev->pers && !err) || did_freeze) {
+	if (!err || did_freeze) {
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
@@ -7729,7 +7728,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-		err = md_set_readonly(mddev);
+		if (mddev->pers)
+			err = md_set_readonly(mddev);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
-- 
2.39.2


