Return-Path: <linux-kernel+bounces-80463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9498668AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1AB281E96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B131C69A;
	Mon, 26 Feb 2024 03:20:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5501B94D;
	Mon, 26 Feb 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917644; cv=none; b=hHfjoYddR+2lx5h+L5YW0ubuq8hoHpF9XNj79clCzuT5roPBcL94yF9+f/q4jq4Ugdz8LIdz4J9qmQ9aekYbSdTQgeUIhiNtJTfApi7ouO1/Z8/p6fHz814DBUwrKkIubHnxHMkC4TfGOog+1qDV+C4ALWrw2hj1Hhc/gF2hORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917644; c=relaxed/simple;
	bh=GSPJVOmE2/XN7KVmV0JHWgLucdi20fc1hA9jyn6Xw3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZYC5lTe86RNW4yay/Vu8Q8+4NSCAr/ylJ6fy1Qb6goZqzXZWSv2kfRXnMkJxVIIEwdM5oY6jaLF/T1IM9Zjz/Ixy+seFnpAxo5hqiyReEscPM3VzCxID0+xaawjKrYMdaBZ5k2GmlZvneMuyhug5RTgUoe+oR1exX7aKbe7a6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8Y1jvPz4f3jsh;
	Mon, 26 Feb 2024 11:20:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 663801A0232;
	Mon, 26 Feb 2024 11:20:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S5;
	Mon, 26 Feb 2024 11:20:34 +0800 (CST)
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
Subject: [PATCH v7 1/9] md: merge the check of capabilities into md_ioctl_valid()
Date: Mon, 26 Feb 2024 11:14:36 +0800
Message-Id: <20240226031444.3606764-2-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Kw1kWFyfJFy7GFy3Arb_yoW8AF15pF
	4fGFW5A3y5Jr17GF45t3y8Ca4rZwn2q3yfJrWak3yvg3WUArW7GryrKw4FvasakryxuF4x
	GF4UKF18Ca18JrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1oGHUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is no functional change. Just to make code cleaner.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e2a5f513dbb7..332eda680aea 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7521,16 +7521,17 @@ static int md_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static inline bool md_ioctl_valid(unsigned int cmd)
+static inline int md_ioctl_valid(unsigned int cmd)
 {
 	switch (cmd) {
-	case ADD_NEW_DISK:
 	case GET_ARRAY_INFO:
-	case GET_BITMAP_FILE:
 	case GET_DISK_INFO:
+	case RAID_VERSION:
+		return 0;
+	case ADD_NEW_DISK:
+	case GET_BITMAP_FILE:
 	case HOT_ADD_DISK:
 	case HOT_REMOVE_DISK:
-	case RAID_VERSION:
 	case RESTART_ARRAY_RW:
 	case RUN_ARRAY:
 	case SET_ARRAY_INFO:
@@ -7539,9 +7540,11 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 	case STOP_ARRAY:
 	case STOP_ARRAY_RO:
 	case CLUSTERED_DISK_NACK:
-		return true;
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		return 0;
 	default:
-		return false;
+		return -ENOTTY;
 	}
 }
 
@@ -7601,18 +7604,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	struct mddev *mddev = NULL;
 	bool did_set_md_closing = false;
 
-	if (!md_ioctl_valid(cmd))
-		return -ENOTTY;
-
-	switch (cmd) {
-	case RAID_VERSION:
-	case GET_ARRAY_INFO:
-	case GET_DISK_INFO:
-		break;
-	default:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-	}
+	err = md_ioctl_valid(cmd);
+	if (err)
+		return err;
 
 	/*
 	 * Commands dealing with the RAID driver but not any
-- 
2.39.2


