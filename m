Return-Path: <linux-kernel+bounces-54545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3C84B08B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC521F22969
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3D12D761;
	Tue,  6 Feb 2024 08:59:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7A12D151;
	Tue,  6 Feb 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209998; cv=none; b=MbG6wg8hZNwA/4l4gkP3A+pUYQiHDY7f2icdUdutX0mVBBoQKSNhRkocQvY0Oe13u0wmxOfltzBlvw/lFIiTSEdBqspxS3RpCpU1FAHGR9Sx9bgN3XyfltpxOIegZsqSqGUdBolx1Fo6N3OtCaPdeqwP4SOVSIRJuvXIwPtkb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209998; c=relaxed/simple;
	bh=fabXSuSbPNoZKn2OMKk7PLCdkCHW8zqLdDk1CeYEfW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uphC93rb+DOJuuoo48RTccwm7+GEl6tdVyahzNpZp5qJad6ToscYoYPfcazme3nhSLkm44lGdPNHpYtp8IsqnYQLyz1zTEx8oN2deOV4dOqlAC/0J4nDgLXQCBsMjhAj4e0rWTDStH8t5PeWrS+5IiLfEQJArDoY4cORMTMCaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TTcdL1q9Nz4f3kKX;
	Tue,  6 Feb 2024 16:59:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 069D11A0C47;
	Tue,  6 Feb 2024 16:59:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S5;
	Tue, 06 Feb 2024 16:59:52 +0800 (CST)
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
Subject: [PATCH v6 1/9] md: merge the check of capabilities into md_ioctl_valid()
Date: Tue,  6 Feb 2024 16:55:03 +0800
Message-Id: <20240206085511.2841555-2-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Kw1kWFyfJFy7GFy3Arb_yoW8AF15pF
	4fGFWay3y5try7GF45t3ykCa4rZwn2q3yfJrWaka4vg3WUArWUGryrKw4Fvasakr929F4f
	Ga1UKFy8Ca18JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUrpndUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is no functional change. Just to make code cleaner.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
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


