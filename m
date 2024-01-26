Return-Path: <linux-kernel+bounces-39920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939F83D76C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504981C26B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082C1DFFD;
	Fri, 26 Jan 2024 09:27:05 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC01A29C;
	Fri, 26 Jan 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261224; cv=none; b=J+Ark5dg6Cmnp7f4ygfTWdlBKlot5WYTZMbxpwFvXUe1X13xregTGJo8tNZV7NtY0tx/HcBQ+7Yjr/FNbLJC2FzgL833F3QHWRb/7fbXN3hpmUMyT0U5vkYfHDsZwn2jqPXtq+GEUGGqmd/w/LPHaGn/lmuOaTxtcgr/kzffwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261224; c=relaxed/simple;
	bh=kir+NFI9Hc5LZ5fsAA20JMPLyqKzJwdYV2OkBR2+Mi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tE1wm+mUCH0H+GEiiaCJDGPHjDBUqjJEj7kDWKgDr3mpfGzHCx1ntAD3gJqOW1YNAJoLwhS9tuzDh0ItpzgEsUuc5tg5q1bsOR6LWp/mwJisLE4yjq3tLle/oscs50JPrKTQBwUQVBWZIdMEMffq6POG5ryXEJEpfufL118JxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLsld2NPvz4f3mHQ;
	Fri, 26 Jan 2024 17:26:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A763D1A0232;
	Fri, 26 Jan 2024 17:26:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHferNlLsUdCA--.25360S8;
	Fri, 26 Jan 2024 17:26:59 +0800 (CST)
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
Subject: [PATCH v4 4/4] md: check mddev->pers before calling md_set_readonly()
Date: Fri, 26 Jan 2024 17:22:54 +0800
Message-Id: <20240126092254.1314908-5-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBHferNlLsUdCA--.25360S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15CFyUKryfXF4rZrWfGrg_yoW8ur15p3
	ySqF98Gr1UXryavr4Ut3WkZa45Xw1xta4ktry7u3yrZF1fJrs8WrWSgF18ArWvgas7Aay5
	Xa1UJrW7uFy2g3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbxR67UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If 'mddev->pers' is NULL, there is nothing to do in md_set_readonly().
To simplify the code, move the check of 'mddev->pers' to the caller of
md_set_readonly().

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24e33b65c6ff..ece6eddb2748 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6412,6 +6412,7 @@ void md_stop(struct mddev *mddev)
 
 EXPORT_SYMBOL_GPL(md_stop);
 
+/* ensure 'mddev->pers' exist before calling md_set_readonly() */
 static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 {
 	int err = 0;
@@ -6432,28 +6433,25 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	mddev_lock_nointr(mddev);
 
 	mutex_lock(&mddev->open_mutex);
-	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sync_thread ||
+	if (atomic_read(&mddev->openers) > !!bdev || mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		err = -EBUSY;
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
 		md_wakeup_thread(mddev->thread);
@@ -7772,7 +7770,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-		err = md_set_readonly(mddev, bdev);
+		if (mddev->pers)
+			err = md_set_readonly(mddev, bdev);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
-- 
2.39.2


