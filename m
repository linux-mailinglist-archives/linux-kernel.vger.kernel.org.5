Return-Path: <linux-kernel+bounces-36704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B783A544
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C051F22001
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589818AF8;
	Wed, 24 Jan 2024 09:21:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47131B279;
	Wed, 24 Jan 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088096; cv=none; b=AQt5M43r8I0zFze3sSdemqjrSVtyV5yBmMoYheLaOO7ZSNwyCmzqnNXTNhsRRQJ+FVsEPfve9QNlknsZtKr9Xw7RXd3c0Vas35GHalSDIKCEYvgghT02Vv4rhCR7m1ihsl8ZbHdRl8WNL/v9vz39Lm0g3YIGzIUh/ifPSicCuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088096; c=relaxed/simple;
	bh=8VGBgzgDVrfglLO2JX9IIEqLDKT69ItgHmLnK4/ISbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIQ/nZoTaiq+gIS63oKRpzIA7RlOndYmRRrchILvrL5F/YmHo1WJQY/PC1h3UuQgbGuAh2nUM+pJHRTJagBtWvRvtiEgnKkB6ld9g/BHeIm2tUcaT8DUKacv+EDC8f2Br4VccLJjtz7z7Exi+aL3rV4SyZPDo62WqqnT0UUUhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TKdjN43y5z1xmSd;
	Wed, 24 Jan 2024 17:20:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id E8A651A0177;
	Wed, 24 Jan 2024 17:21:17 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:28 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 11/11] md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
Date: Wed, 24 Jan 2024 17:14:21 +0800
Message-ID: <20240124091421.1261579-12-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124091421.1261579-1-yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)

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


