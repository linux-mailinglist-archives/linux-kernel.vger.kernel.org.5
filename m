Return-Path: <linux-kernel+bounces-83173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCF868FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233401F2A77E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786114037E;
	Tue, 27 Feb 2024 12:09:33 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25F13A883;
	Tue, 27 Feb 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035772; cv=none; b=qFytnjMHp/ULR5aK3epdpYmQfs8dBumjyq8x26wuajbra++KRzIOpeV3xKIjKN+P1mVp8toFpZyc6DtBc6tfOnGIDvfOPb8RmZ9tHjY0uOKVRgxaglv06Bjk0sjmWLPJ1B0QufYyUxPb6D4ZezqJCLrPaXrL026h9v6X4xkLt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035772; c=relaxed/simple;
	bh=Dtuvhl1cdTcDzxwUYUJ1R9NwqKmtU3nTt/FeyUFjpmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WexSZ5dNCvJrDV5s2/Gn9kZZj44bxFE7Pnvr2vhX3LsX7HsEgETnw4MgXxUaJqT4yPPZ4zy78ry+uX2qSL0GdzGFRy2DMhYDPRMMTPorZpEGxeub3Vm3OmC0pdS6zi+Z7Bg9HqGJj+7/kQFfvzDJCBJvVFGjeQliHeO2AvhTRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkbrJ5dbBz4f3jdn;
	Tue, 27 Feb 2024 20:09:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 042451A0BA4;
	Tue, 27 Feb 2024 20:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S9;
	Tue, 27 Feb 2024 20:09:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v2 05/10] md/raid1-10: factor out a new helper raid1_should_read_first()
Date: Tue, 27 Feb 2024 20:03:22 +0800
Message-Id: <20240227120327.1432511-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXr17Jw4DJrWruF4DWr4xCrg_yoWrWF43pw
	4avF93AryUKay3Aws8A3yDua4Sy34rWFWUKFWxWws5uFySqFW5Gay5GryY9r1DuF95Jr17
	Xa45GrW5C3ZrJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If resync is in progress, read_balance() should find the first usable
disk, otherwise, data could be inconsistent after resync is done. raid1
and raid10 implement the same checking, hence factor out the checking
to make code cleaner.

Noted that raid1 is using 'mddev->recovery_cp', which is updated after
all resync IO is done, while raid10 is using 'conf->next_resync', which
is inaccurate because raid10 update it before submitting resync IO.
Fortunately, raid10 read IO can't concurrent with resync IO, hence there
is no problem. And this patch also switch raid10 to use
'mddev->recovery_cp'.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1-10.c | 20 ++++++++++++++++++++
 drivers/md/raid1.c    | 15 ++-------------
 drivers/md/raid10.c   | 13 ++-----------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 9bc0f0022a6c..2ea1710a3b70 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -276,3 +276,23 @@ static inline int raid1_check_read_range(struct md_rdev *rdev,
 	*len = first_bad + bad_sectors - this_sector;
 	return 0;
 }
+
+/*
+ * Check if read should choose the first rdev.
+ *
+ * Balance on the whole device if no resync is going on (recovery is ok) or
+ * below the resync window. Otherwise, take the first readable disk.
+ */
+static inline bool raid1_should_read_first(struct mddev *mddev,
+					   sector_t this_sector, int len)
+{
+	if ((mddev->recovery_cp < this_sector + len))
+		return true;
+
+	if (mddev_is_clustered(mddev) &&
+	    md_cluster_ops->area_resyncing(mddev, READ, this_sector,
+					   this_sector + len))
+		return true;
+
+	return false;
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index fc5899fb08c1..640d5d8f789a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -605,11 +605,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	struct md_rdev *rdev;
 	int choose_first;
 
-	/*
-	 * Check if we can balance. We can balance on the whole
-	 * device if no resync is going on, or below the resync window.
-	 * We take the first readable disk when above the resync window.
-	 */
  retry:
 	sectors = r1_bio->sectors;
 	best_disk = -1;
@@ -619,16 +614,10 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
+	choose_first = raid1_should_read_first(conf->mddev, this_sector,
+					       sectors);
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
-	if ((conf->mddev->recovery_cp < this_sector + sectors) ||
-	    (mddev_is_clustered(conf->mddev) &&
-	    md_cluster_ops->area_resyncing(conf->mddev, READ, this_sector,
-		    this_sector + sectors)))
-		choose_first = 1;
-	else
-		choose_first = 0;
-
 	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
 		sector_t dist;
 		sector_t first_bad;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d5a7a621f0f0..8aecdb1ccc16 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -748,17 +748,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	best_good_sectors = 0;
 	do_balance = 1;
 	clear_bit(R10BIO_FailFast, &r10_bio->state);
-	/*
-	 * Check if we can balance. We can balance on the whole
-	 * device if no resync is going on (recovery is ok), or below
-	 * the resync window. We take the first readable disk when
-	 * above the resync window.
-	 */
-	if ((conf->mddev->recovery_cp < MaxSector
-	     && (this_sector + sectors >= conf->next_resync)) ||
-	    (mddev_is_clustered(conf->mddev) &&
-	     md_cluster_ops->area_resyncing(conf->mddev, READ, this_sector,
-					    this_sector + sectors)))
+
+	if (raid1_should_read_first(conf->mddev, this_sector, sectors))
 		do_balance = 0;
 
 	for (slot = 0; slot < conf->copies ; slot++) {
-- 
2.39.2


