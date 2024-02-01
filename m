Return-Path: <linux-kernel+bounces-47701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D5845181
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32EBB2176A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CAC158D8C;
	Thu,  1 Feb 2024 06:38:36 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289E14C5A2;
	Thu,  1 Feb 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769515; cv=none; b=U1V9cUGlMGH86SoDErcyfYaTyX9syGz0xVSw+oXj/Rg/3lc1ReqT0z3qBYSZNRXXLcAcQaUDpl7WQOsxD2fBPlEuDESwHEm8o4H02/bS+lwOEdcJT1B75FNyx4M4Ylm/+i/FJ2eStS9Xs37SHyv02U/LdCvZTq8SUxhIwFBoxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769515; c=relaxed/simple;
	bh=jP4m22rQj6WvFme4jcbJ2GC1m3E6QRznh9H3QFX0PjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9k7xrNN7tpPKYcRZLLlig5NTHz1ySUioHIocC0djGRBpNagZ0u/wln5B1J7SAEgTJkuJyxgpkRNO2kY2a8Ln+fhux7OskdS/fvYzd/m1g3KbppDOSZ0tH/kzaMRxzgPjshgA0yRDtBICem31aJuMRUBEo0tmJE3gxuJKfQDr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQTkS3zN7z4f3kns;
	Thu,  1 Feb 2024 14:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BC2711A027B;
	Thu,  1 Feb 2024 14:38:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S5;
	Thu, 01 Feb 2024 14:38:28 +0800 (CST)
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
Subject: [PATCH v5 1/8] md: merge the check of capabilities into md_ioctl_valid()
Date: Thu,  1 Feb 2024 14:33:57 +0800
Message-Id: <20240201063404.772797-2-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Wr15Wry7tw15KF13CFg_yoW8Ar17pF
	4fJFWay3y5try7GF45t3ykCa45Zwn2q3yrJrWaka4vq3WUA3yUGryrGw4Fvas3Kr97uF4f
	Ga1UGFy8ua18JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0BTYUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is no functional change. Just to make code cleaner.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e351e6c51cc7..1b509fb82040 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7545,16 +7545,17 @@ static int md_getgeo(struct block_device *bdev, struct hd_geometry *geo)
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
@@ -7563,9 +7564,11 @@ static inline bool md_ioctl_valid(unsigned int cmd)
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
 
@@ -7625,18 +7628,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
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


