Return-Path: <linux-kernel+bounces-86504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183D86C654
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90741F231D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3733865BC1;
	Thu, 29 Feb 2024 10:03:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA3634FA;
	Thu, 29 Feb 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201006; cv=none; b=IyyAZy7PCk9cd6Yy+6vbeZO9ay54qbKcDhVan1zz7V4Hi6bqu6Sd1ZzrWNYGQdiz2KAL+APgJKFsxtpWW8Yw2DZUIwKI28eBowBJwFqNS3p32A+2fh7p/Rla0oSgBdJS5AD97VWghGnwcB3zN+LFawo1zbHES0Qg4XbL5UJ+2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201006; c=relaxed/simple;
	bh=h3AKSqUnWiok8wtyPtLysUhlWxXuXCWLLdVpdRzitwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uv7FnVMXQp1RUYsruRwvoIgKBHuIsgC1An+LAJj0Omf79lOMO7riDi5RwTOouCDZT4f1ZHID0MMqLXcBzG8TSSz518avk2puK8TdgCmY0frxkGTR1rLGp1IgjfT0Umi0hKCe8ysXtH5ZdLF3OylP/opB+sRVJ+fqk2leS+GpSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxr5Py6z4f3khJ;
	Thu, 29 Feb 2024 18:03:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 078ED1A016E;
	Thu, 29 Feb 2024 18:03:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S6;
	Thu, 29 Feb 2024 18:03:17 +0800 (CST)
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
Subject: [PATCH md-6.9 v4 02/11] md/raid1: factor out helpers to add rdev to conf
Date: Thu, 29 Feb 2024 17:57:05 +0800
Message-Id: <20240229095714.926789-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF4UAw4kGryfJr4kCrg_yoWrtF47pa
	13XasxGr47Zrs0gr1DJrWUGFySvw4kCa97JFyfW3yIvanxKrZ5X3y8JFy5XryUZFZ8Zw45
	Ja4rJrWDGF18uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, just make code cleaner and prepare to
record disk non-rotational information while adding and removing rdev to
conf

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 85 +++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a145fe48b9ce..6ec9998f6257 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1757,6 +1757,44 @@ static int raid1_spare_active(struct mddev *mddev)
 	return count;
 }
 
+static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
+			   bool replacement)
+{
+	struct raid1_info *info = conf->mirrors + disk;
+
+	if (replacement)
+		info += conf->raid_disks;
+
+	if (info->rdev)
+		return false;
+
+	rdev->raid_disk = disk;
+	info->head_position = 0;
+	info->seq_start = MaxSector;
+	WRITE_ONCE(info->rdev, rdev);
+
+	return true;
+}
+
+static bool raid1_remove_conf(struct r1conf *conf, int disk)
+{
+	struct raid1_info *info = conf->mirrors + disk;
+	struct md_rdev *rdev = info->rdev;
+
+	if (!rdev || test_bit(In_sync, &rdev->flags) ||
+	    atomic_read(&rdev->nr_pending))
+		return false;
+
+	/* Only remove non-faulty devices if recovery is not possible. */
+	if (!test_bit(Faulty, &rdev->flags) &&
+	    rdev->mddev->recovery_disabled != conf->recovery_disabled &&
+	    rdev->mddev->degraded < conf->raid_disks)
+		return false;
+
+	WRITE_ONCE(info->rdev, NULL);
+	return true;
+}
+
 static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r1conf *conf = mddev->private;
@@ -1792,15 +1830,13 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 				disk_stack_limits(mddev->gendisk, rdev->bdev,
 						  rdev->data_offset << 9);
 
-			p->head_position = 0;
-			rdev->raid_disk = mirror;
+			raid1_add_conf(conf, rdev, mirror, false);
 			err = 0;
 			/* As all devices are equivalent, we don't need a full recovery
 			 * if this was recently any drive of the array
 			 */
 			if (rdev->saved_raid_disk < 0)
 				conf->fullsync = 1;
-			WRITE_ONCE(p->rdev, rdev);
 			break;
 		}
 		if (test_bit(WantReplacement, &p->rdev->flags) &&
@@ -1810,13 +1846,11 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (err && repl_slot >= 0) {
 		/* Add this device as a replacement */
-		p = conf->mirrors + repl_slot;
 		clear_bit(In_sync, &rdev->flags);
 		set_bit(Replacement, &rdev->flags);
-		rdev->raid_disk = repl_slot;
+		raid1_add_conf(conf, rdev, repl_slot, true);
 		err = 0;
 		conf->fullsync = 1;
-		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
 	}
 
 	print_conf(conf);
@@ -1833,27 +1867,20 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (unlikely(number >= conf->raid_disks))
 		goto abort;
 
-	if (rdev != p->rdev)
-		p = conf->mirrors + conf->raid_disks + number;
+	if (rdev != p->rdev) {
+		number += conf->raid_disks;
+		p = conf->mirrors + number;
+	}
 
 	print_conf(conf);
 	if (rdev == p->rdev) {
-		if (test_bit(In_sync, &rdev->flags) ||
-		    atomic_read(&rdev->nr_pending)) {
-			err = -EBUSY;
-			goto abort;
-		}
-		/* Only remove non-faulty devices if recovery
-		 * is not possible.
-		 */
-		if (!test_bit(Faulty, &rdev->flags) &&
-		    mddev->recovery_disabled != conf->recovery_disabled &&
-		    mddev->degraded < conf->raid_disks) {
+		if (!raid1_remove_conf(conf, number)) {
 			err = -EBUSY;
 			goto abort;
 		}
-		WRITE_ONCE(p->rdev, NULL);
-		if (conf->mirrors[conf->raid_disks + number].rdev) {
+
+		if (number < conf->raid_disks &&
+		    conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
 			 * doing this to avoid confusion.
@@ -2994,23 +3021,17 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 
 	err = -EINVAL;
 	spin_lock_init(&conf->device_lock);
+	conf->raid_disks = mddev->raid_disks;
 	rdev_for_each(rdev, mddev) {
 		int disk_idx = rdev->raid_disk;
-		if (disk_idx >= mddev->raid_disks
-		    || disk_idx < 0)
+
+		if (disk_idx >= conf->raid_disks || disk_idx < 0)
 			continue;
-		if (test_bit(Replacement, &rdev->flags))
-			disk = conf->mirrors + mddev->raid_disks + disk_idx;
-		else
-			disk = conf->mirrors + disk_idx;
 
-		if (disk->rdev)
+		if (!raid1_add_conf(conf, rdev, disk_idx,
+				    test_bit(Replacement, &rdev->flags)))
 			goto abort;
-		disk->rdev = rdev;
-		disk->head_position = 0;
-		disk->seq_start = MaxSector;
 	}
-	conf->raid_disks = mddev->raid_disks;
 	conf->mddev = mddev;
 	INIT_LIST_HEAD(&conf->retry_list);
 	INIT_LIST_HEAD(&conf->bio_end_io_list);
-- 
2.39.2


