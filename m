Return-Path: <linux-kernel+bounces-88224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAD86DED3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E371D1F256A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39976BFC2;
	Fri,  1 Mar 2024 10:03:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFD6A8B9;
	Fri,  1 Mar 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287389; cv=none; b=cLkI2OdBTBA/85CYfld1S54LC2mVCgH4c1/DKK4g439kub5JlOJoX6lu9osw9wlHQS1WCR1sw4mDvvKa9AtD34ZIaFkpmUPrtEkUFAlQfEg7XUM4jEGR60PADsff+pIo429zJBGzsWY0GiEf+JHcT+C9tSCCj/fGWJN23gErstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287389; c=relaxed/simple;
	bh=u3t3DKW3x7GgosZFCclGCU3l8cfElCExYBTh1wR4y2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0Rt166PLtPaBDUPYfI3qnFCyZDOKXVkNnxMnpYyK9KQDO+N60mj+QUJ3YH0D8aqXu5QvTBtViVghidzF06mtkBuV/8xDdOHL9OL//ulKuwLISJtiU77p0Fw2gkkOFpSCN35CJVWSe4kt03Xgl4XGPvOjpC4tDNXVOpDPZ3yQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmNv42xl4z4f3nbV;
	Fri,  1 Mar 2024 18:02:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C278A1A07FA;
	Fri,  1 Mar 2024 18:03:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHTp+FlqmBuFg--.36874S5;
	Fri, 01 Mar 2024 18:03:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: zkabelac@redhat.com,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	neilb@suse.de,
	jbrassow@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 1/9] md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
Date: Fri,  1 Mar 2024 17:56:49 +0800
Message-Id: <20240301095657.662111-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301095657.662111-1-yukuai1@huaweicloud.com>
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHTp+FlqmBuFg--.36874S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4ktrW3uFy7uFyfZw1UJrb_yoW8Gr4Dpa
	n7Gr1S9rWkArWaka1Dta4q9ayYqa9xJrW0kry3u3y5Xr13Xrn7K3yYg3ZxZryqkF4a9as0
	yFyUArWrC3WFkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

After commit 9dbd1aa3a81c ("dm raid: add reshaping support to the
target") raid_ctr() will set MD_RECOVERY_FROZEN before md_run() and
expect to keep array frozen until resume. However, md_run() will clear
the flag by setting mddev->recovery to 0.

Before commit 1baae052cccd ("md: Don't ignore suspended array in
md_check_recovery()"), dm-raid actually relied on suspending to prevent
starting new sync_thread.

Fix this problem by keeping 'MD_RECOVERY_FROZEN' for dm-raid in
md_run().

Fixes: 1baae052cccd ("md: Don't ignore suspended array in md_check_recovery()")
Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3bd42d76e95f..7156e765d027 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6032,7 +6032,10 @@ int md_run(struct mddev *mddev)
 			pr_warn("True protection against single-disk failure might be compromised.\n");
 	}
 
-	mddev->recovery = 0;
+	/* dm-raid expect sync_thread to be frozen until resume */
+	if (mddev->gendisk)
+		mddev->recovery = 0;
+
 	/* may be over-ridden by personality */
 	mddev->resync_max_sectors = mddev->dev_sectors;
 
-- 
2.39.2


