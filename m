Return-Path: <linux-kernel+bounces-12968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1E81FD70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131A928200F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70343567D;
	Fri, 29 Dec 2023 07:24:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF177612A;
	Fri, 29 Dec 2023 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T1bzZ5NZlz4f3jR9;
	Fri, 29 Dec 2023 15:07:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CBE701A01C8;
	Fri, 29 Dec 2023 15:07:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHFQwscI5l6ou9Ew--.50337S4;
	Fri, 29 Dec 2023 15:07:25 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	linan122@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] md: get rdev->mddev with READ_ONCE()
Date: Fri, 29 Dec 2023 15:05:00 +0800
Message-Id: <20231229070500.3602712-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHFQwscI5l6ou9Ew--.50337S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw4xtw17ur4xZw43ZF1UJrb_yoWkKrcEgF
	WYvryrG34agryxKr13Cw4Sv3s0yayvgwnrWFySqFZIyr98tFykAryruw15A3ya9F1fCFs8
	KF1Ykr1aqFWrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Users may get rdev->mddev by sysfs while rdev is releasing.
So use both READ_ONCE() and WRITE_ONCE() to prevent load/store tearing
and to read/write mddev atomically.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bdd57324c37..3b38a565bffa 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2562,7 +2562,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
 	mddev_destroy_serial_pool(rdev->mddev, rdev);
-	rdev->mddev = NULL;
+	WRITE_ONCE(rdev->mddev, NULL);
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
 	sysfs_put(rdev->sysfs_unack_badblocks);
@@ -3646,7 +3646,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct kernfs_node *kn = NULL;
 	bool suspend = false;
 	ssize_t rv;
-	struct mddev *mddev = rdev->mddev;
+	struct mddev *mddev = READ_ONCE(rdev->mddev);
 
 	if (!entry->store)
 		return -EIO;
-- 
2.39.2


