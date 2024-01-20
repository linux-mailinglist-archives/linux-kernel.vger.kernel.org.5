Return-Path: <linux-kernel+bounces-31763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C28333AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78762B228D5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E910A38;
	Sat, 20 Jan 2024 10:41:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DC10961;
	Sat, 20 Jan 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747287; cv=none; b=rFH0vcd8yZCiQ7yd1kD+x7WJx45onmgjmO6S6GH1St6EOoBDZzqVZIv98gs1he3Sj/E6exzW9K9Hn9f5AV0WEl/H8Vmld7JcinyQ+6ShzFPke6ytSFizGlq2H61mk7qbrQv4lzhjgPEmG1dsje8Aai/lhtHLURHKIOKgCz0hzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747287; c=relaxed/simple;
	bh=oFTiKVMXXKW9m6GUH6h2P+FXhLEEPVreOg5yS2EU93A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjVchrcTLdBxopiCHtKqYjyW+7bZtm4vQvHWXslh6zSNXc09NQINpahKsrcnKf0Yayn4sMyrkIdaYsr9LsqZZPK3Be2FKlakOKZaD05BjRnSxcCs91Ql3e7XTlqGv+AojBSIJh8bqEn2ahN3TmgqkJwL5W9oXE8Awau34rahLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4THCh91hynz4f3jsD;
	Sat, 20 Jan 2024 18:41:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 116811A09F2;
	Sat, 20 Jan 2024 18:41:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFKo6tlY4mmBQ--.38494S5;
	Sat, 20 Jan 2024 18:41:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	heinzm@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/5] md: don't ignore suspended array in md_check_recovery()
Date: Sat, 20 Jan 2024 18:37:30 +0800
Message-Id: <20240120103734.4155446-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFKo6tlY4mmBQ--.38494S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UCryfKw1fKw4UKF4DJwb_yoWfArcEgF
	s5ur93W347urnIvr1aqr1avryjyanrWr17XF1ftryayFy5GryIgrW8Zw15A347ZFZ8C3Z0
	kryUZr4avrs5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU86wZUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

mddev_suspend() never stop sync_thread, hence it dones't make sense to
ignore suspended array in md_check_recovery(), which might cause
sync_thread can't be unregistered.

Before this patch, use stop_sync_thread() directly for syspended array
will hang because md_check_recovery() can't clear MD_RECOVERY_RUNING,
which is possible for dm-raid.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2266358d8074..07b80278eaa5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9469,9 +9469,6 @@ static void md_start_sync(struct work_struct *ws)
  */
 void md_check_recovery(struct mddev *mddev)
 {
-	if (READ_ONCE(mddev->suspended))
-		return;
-
 	if (mddev->bitmap)
 		md_bitmap_daemon_work(mddev);
 
-- 
2.39.2


