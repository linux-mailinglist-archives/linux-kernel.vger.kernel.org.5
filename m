Return-Path: <linux-kernel+bounces-54546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BF84B08D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A31C221B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FF12E1CD;
	Tue,  6 Feb 2024 09:00:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098412C81F;
	Tue,  6 Feb 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209999; cv=none; b=dgh+hpiPfrPzaBZvMod0PoRU3sdzWUXDLeYt6C7QAbdrbVV060MxCkMuvfSfkydBTYhsyXm8j0XgPZqFapJH0KIT1ekHZ7LlFonck5mT9ejrT3N57Qrbx9NkdJGN2W9mD5fCtk+EMb6gourZhzWulTQSFj8ERT/PAFNOt9mtOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209999; c=relaxed/simple;
	bh=W+PbX/stc28z0ut0CCXrOC9+tCdv7a9eAngFWE8eMhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkPesucWVZ8ADLYeh1zIUhUp09GE4NyOoVPSGoAQkcDZpMUAL9wiNJ/Kao+h9dtqHjX7ZNh83ihHQ537Na3bUdpWSmXT81qkycZlVfnqEmrQNM1mdoDMQYnhuXE6y27gB4LvKwl/GJCWAmdmDhRCEls+wYWmIPt3vNJxbXfaJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TTcdK6h9Sz4f3kj6;
	Tue,  6 Feb 2024 16:59:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5B4AF1A0175;
	Tue,  6 Feb 2024 16:59:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S8;
	Tue, 06 Feb 2024 16:59:54 +0800 (CST)
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
Subject: [PATCH v6 4/9] md: return directly before setting did_set_md_closing
Date: Tue,  6 Feb 2024 16:55:06 +0800
Message-Id: <20240206085511.2841555-5-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWfXw43AF4xGw15Xw4fZrb_yoW8Aw4Upa
	9agF9xtrWUJr95Kr1UJasY9FyYqw12kFZ2kryxCF1UZFyUArsxZr1Fg3yFqr95urykA3y5
	t3W7JayrWayxGrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbxR67UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is nothing to do at 'out' before setting 'did_set_md_closing'
in md_ioctl(). Return directly, and it will help us to remove
'did_set_md_closing' later.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fb4e80a0aa9a..02d6197dc944 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7649,26 +7649,19 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	switch (cmd) {
 	case GET_ARRAY_INFO:
 		if (!mddev->raid_disks && !mddev->external)
-			err = -ENODEV;
-		else
-			err = get_array_info(mddev, argp);
-		goto out;
+			return -ENODEV;
+		return get_array_info(mddev, argp);
 
 	case GET_DISK_INFO:
 		if (!mddev->raid_disks && !mddev->external)
-			err = -ENODEV;
-		else
-			err = get_disk_info(mddev, argp);
-		goto out;
+			return -ENODEV;
+		return get_disk_info(mddev, argp);
 
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
@@ -7684,13 +7677,11 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
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


