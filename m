Return-Path: <linux-kernel+bounces-84971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BA86AE50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307D31C21942
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E323B15AAB7;
	Wed, 28 Feb 2024 11:49:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B6155A5C;
	Wed, 28 Feb 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120984; cv=none; b=crM/MHN14pX4/SmMTUZ62TssTspGXDvfpcnxa8/0cFFzihEQ+95wHSSlZ8zRdWAHIE6LxSSQXa34UJsvij2x0N8QF2UUAAXfdtyMU8a0+UDeZGSGKm+d5YIrESNa13wvO/xsEBh+lVyRPz+ESatHZXlN1Ft9zoab85sfxcPLiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120984; c=relaxed/simple;
	bh=jldN1ct6r5ylRv2hbOuCl1QF6H4dCcHj/0HGIhtPvgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9f457AqO/cftfunRBvIj9lKNzYgDBEfCn3hN1LTAiMkymxAX6o8Ye/bZ6nGr4daVH1UpeaAb2k2jJhW1ZzudmDZQkjj4oMOqeDE6a10L9wzPfg+QP/+fGv6uYJuwhAp3M06u/GhR2u3prMgASakjgjLR3bvoO0/JSZHR0zgZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TlCLv3CZvz4f3js6;
	Wed, 28 Feb 2024 19:49:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AA6431A0D99;
	Wed, 28 Feb 2024 19:49:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7IHd9l+eamFQ--.6969S6;
	Wed, 28 Feb 2024 19:49:32 +0800 (CST)
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
Subject: [PATCH md-6.9 v3 02/11] md/raid1: factor out helpers to add rdev to conf
Date: Wed, 28 Feb 2024 19:43:24 +0800
Message-Id: <20240228114333.527222-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228114333.527222-1-yukuai1@huaweicloud.com>
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7IHd9l+eamFQ--.6969S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF4UAw4kGry3ZFWkJFb_yoWrAw4Upa
	13XasxGr47ZrsIgr1DJrWUCFyFqw4kCa97JryfW3yIvanxKrZ5X3y8JFy5XFyUZFZ8Zw45
	Xa4rJrWDGF1xuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, just make code cleaner and prepare to
record disk non-rotational information while adding and removing rdev to
conf

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 74 ++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a145fe48b9ce..1940ff398c23 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1757,6 +1757,40 @@ static int raid1_spare_active(struct mddev *mddev)
 	return count;
 }
 
+static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk)
+{
+	struct raid1_info *info = conf->mirrors + disk;
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
@@ -1792,15 +1826,13 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 				disk_stack_limits(mddev->gendisk, rdev->bdev,
 						  rdev->data_offset << 9);
 
-			p->head_position = 0;
-			rdev->raid_disk = mirror;
+			raid1_add_conf(conf, rdev, mirror);
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
@@ -1810,13 +1842,11 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (err && repl_slot >= 0) {
 		/* Add this device as a replacement */
-		p = conf->mirrors + repl_slot;
 		clear_bit(In_sync, &rdev->flags);
 		set_bit(Replacement, &rdev->flags);
-		rdev->raid_disk = repl_slot;
+		raid1_add_conf(conf, rdev, repl_slot);
 		err = 0;
 		conf->fullsync = 1;
-		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
 	}
 
 	print_conf(conf);
@@ -1833,27 +1863,20 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
@@ -3000,15 +3023,10 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 		    || disk_idx < 0)
 			continue;
 		if (test_bit(Replacement, &rdev->flags))
-			disk = conf->mirrors + mddev->raid_disks + disk_idx;
-		else
-			disk = conf->mirrors + disk_idx;
+			disk_idx += mddev->raid_disks;
 
-		if (disk->rdev)
+		if (!raid1_add_conf(conf, rdev, disk_idx))
 			goto abort;
-		disk->rdev = rdev;
-		disk->head_position = 0;
-		disk->seq_start = MaxSector;
 	}
 	conf->raid_disks = mddev->raid_disks;
 	conf->mddev = mddev;
-- 
2.39.2


