Return-Path: <linux-kernel+bounces-41102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45C83EBE4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DF1285E16
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B556288AE;
	Sat, 27 Jan 2024 07:52:38 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FC24A10;
	Sat, 27 Jan 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341957; cv=none; b=l3O/wSZjuqTv/4OHU1CC4Po54FOVimghXN4t16J0aYIG4QI01Y+ICjRs70OnlO5SbqRypVJAdadsI/jFe2YqvBwSP75+TKeHz3sWqq0OTlZtxIL48j5KIqEvdxBcPAEQW3cJtSNWmQr/CtuQbWUseJNcfICPv1dFph4JrC7tqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341957; c=relaxed/simple;
	bh=Y2CyAULl8CDT1e354bpgbi56zPjrKUGKSSoo0xNiEag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ul0vXcPBKuM9BzuMYEp1qyEGz2zCDzkSHZQ9aK2P1ItkR/lS4m8lmLN6eVHJ/uOZC74aFsXqah3sPj/Bw8Ivb8X2+40NY/60OgDynv84T0cpnnDlFa8l02t2vc9E9DEbetiTnjVrjhUs4KDGMqlFddyKgILBJD6PkO2ThfVjVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMRcG0FXLz4f3k6Z;
	Sat, 27 Jan 2024 15:52:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 740211A016E;
	Sat, 27 Jan 2024 15:52:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAetrRlWjeACA--.31980S15;
	Sat, 27 Jan 2024 15:52:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	jbrassow@f14.redhat.com,
	neilb@suse.de,
	shli@fb.com,
	akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 11/12] md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
Date: Sat, 27 Jan 2024 15:47:53 +0800
Message-Id: <20240127074754.2380890-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
References: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAetrRlWjeACA--.31980S15
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr13WF4xJry7XF4UXw13Jwb_yoW7uF1fpa
	9Fkas8Zr40v34akrWDJF4kWa4F9Fs7Kry3ZF93Cw4fZ3W3Xr1kA3W5Jay5ur98AFy8J3y5
	JFW5tFyDurs8KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For raid456, if reshape is still in progress, then IO across reshape
position will wait for reshape to make progress. However, for dm-raid,
in following cases reshape will never make progress hence IO will hang:

1) the array is read-only;
2) MD_RECOVERY_WAIT is set;
3) MD_RECOVERY_FROZEN is set;

After commit c467e97f079f ("md/raid6: use valid sector values to determine
if an I/O should wait on the reshape") fix the problem that IO across
reshape position doesn't wait for reshape, the dm-raid test
shell/lvconvert-raid-reshape.sh start to hang:

[root@fedora ~]# cat /proc/979/stack
[<0>] wait_woken+0x7d/0x90
[<0>] raid5_make_request+0x929/0x1d70 [raid456]
[<0>] md_handle_request+0xc2/0x3b0 [md_mod]
[<0>] raid_map+0x2c/0x50 [dm_raid]
[<0>] __map_bio+0x251/0x380 [dm_mod]
[<0>] dm_submit_bio+0x1f0/0x760 [dm_mod]
[<0>] __submit_bio+0xc2/0x1c0
[<0>] submit_bio_noacct_nocheck+0x17f/0x450
[<0>] submit_bio_noacct+0x2bc/0x780
[<0>] submit_bio+0x70/0xc0
[<0>] mpage_readahead+0x169/0x1f0
[<0>] blkdev_readahead+0x18/0x30
[<0>] read_pages+0x7c/0x3b0
[<0>] page_cache_ra_unbounded+0x1ab/0x280
[<0>] force_page_cache_ra+0x9e/0x130
[<0>] page_cache_sync_ra+0x3b/0x110
[<0>] filemap_get_pages+0x143/0xa30
[<0>] filemap_read+0xdc/0x4b0
[<0>] blkdev_read_iter+0x75/0x200
[<0>] vfs_read+0x272/0x460
[<0>] ksys_read+0x7a/0x170
[<0>] __x64_sys_read+0x1c/0x30
[<0>] do_syscall_64+0xc6/0x230
[<0>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

This is because reshape can't make progress.

For md/raid, the problem doesn't exist because register new sync_thread
doesn't rely on the IO to be done any more:

1) If array is read-only, it can switch to read-write by ioctl/sysfs;
2) md/raid never set MD_RECOVERY_WAIT;
3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
   'reconfig_mutex', hence it can be cleared and reshape can continue by
   sysfs api 'sync_action'.

However, I'm not sure yet how to avoid the problem in dm-raid yet. This
patch detect the above 3 cases in dm_suspend(), and fail those IO
directly. If user really meet the IO error, then it means they're
reading the wrong data before c467e97f079f. And it's safe to read/write
the array after reshape make progress successfully.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.h    |  2 +-
 drivers/md/raid5.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 98da86d38ba8..8e81f9e2fb20 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -565,7 +565,7 @@ enum md_ro_state {
 	MD_MAX_STATE
 };
 
-static bool md_is_rdwr(struct mddev *mddev)
+static inline bool md_is_rdwr(struct mddev *mddev)
 {
 	return (mddev->ro == MD_RDWR);
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6a7a32f7fb91..812d7ec64da5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5915,6 +5915,13 @@ static int add_all_stripe_bios(struct r5conf *conf,
 	return ret;
 }
 
+static bool reshape_disabled(struct mddev *mddev)
+{
+	return !md_is_rdwr(mddev) ||
+	       test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
+	       test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+}
+
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -5946,7 +5953,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				return STRIPE_SCHEDULE_AND_RETRY;
+				ret = STRIPE_SCHEDULE_AND_RETRY;
+				goto out;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6025,6 +6033,13 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 out_release:
 	raid5_release_stripe(sh);
+out:
+	if (ret == STRIPE_SCHEDULE_AND_RETRY && !mddev->gendisk &&
+	    reshape_disabled(mddev)) {
+		bi->bi_status = BLK_STS_IOERR;
+		ret = STRIPE_FAIL;
+		pr_err("dm-raid456: io failed across reshape position while reshape can't make progress");
+	}
 	return ret;
 }
 
@@ -8909,6 +8924,18 @@ static int raid5_start(struct mddev *mddev)
 	return r5l_start(conf->log);
 }
 
+/*
+ * This is only used for dm-raid456, caller already frozen sync_thread, hence
+ * if rehsape is still in progress, io that is waiting for reshape can never be
+ * done now, hence wake up and handle those IO.
+ */
+static void raid5_prepare_suspend(struct mddev *mddev)
+{
+	struct r5conf *conf = mddev->private;
+
+	wake_up(&conf->wait_for_overlap);
+}
+
 static struct md_personality raid6_personality =
 {
 	.name		= "raid6",
@@ -8932,6 +8959,7 @@ static struct md_personality raid6_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 static struct md_personality raid5_personality =
 {
@@ -8956,6 +8984,7 @@ static struct md_personality raid5_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static struct md_personality raid4_personality =
@@ -8981,6 +9010,7 @@ static struct md_personality raid4_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static int __init raid5_init(void)
-- 
2.39.2


