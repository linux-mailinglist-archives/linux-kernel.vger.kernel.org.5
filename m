Return-Path: <linux-kernel+bounces-86500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CD86C64C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3D28A15E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6E651B9;
	Thu, 29 Feb 2024 10:03:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51163506;
	Thu, 29 Feb 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201005; cv=none; b=EY/akmUflaa6PCs/7mtsqITf5RAyB/YYi9uoi3XwvywbBwAXD6Nkzz+PI5D9V04jBbJvHYbRi7BqmT/+O6MgkDVBbtEtNvpn/qplXO5eCb4Tnhvgmp1VTjZpjg4Cx0eMRk4JoA3BSRi2XuJWoDEZesDrVN/AF9nMKjC6MMhpA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201005; c=relaxed/simple;
	bh=bes3PToCDsibsQ7i3d3Xi3EdrGYpwN8sD1+581g+HXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4IescRarLh7f9yBxVhuvDaZQX2jgPiq0cyuzC3wITSO1HJVWWN67ojwSEGe//0A8REqGlfjX7PaR3p2mY/qDo/9WvBarhNh9u8KFnP+bLQLwSYi6+0cGMOBs8sTROIaqlkvakEuGpXlVhmkynCpBhedU2Jp14GfWyysdfn1GDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxr3jPmz4f3mHQ;
	Thu, 29 Feb 2024 18:03:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D86D11A0172;
	Thu, 29 Feb 2024 18:03:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S10;
	Thu, 29 Feb 2024 18:03:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	neilb@suse.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v4 06/11] md/raid1-10: factor out a new helper raid1_should_read_first()
Date: Thu, 29 Feb 2024 17:57:09 +0800
Message-Id: <20240229095714.926789-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229095714.926789-1-yukuai1@huaweicloud.com>
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXr17Jw4DJrWruF4DWr4xCrg_yoWrWF43pw
	4avF93JryUKay3Aws8A3yDua4Sy3yrWrWUKFWxWws5uFySqFZ8Way5JryY9r1DCF95Jw17
	Xa45GrW5C3ZrJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
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
index fa86d9fdb16f..30f467bb48fd 100644
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


