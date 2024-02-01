Return-Path: <linux-kernel+bounces-47876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BAC84540B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089ED2828DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8165163AAE;
	Thu,  1 Feb 2024 09:30:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBB160889;
	Thu,  1 Feb 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779840; cv=none; b=e1cQs2DSj9LyitUMZkwlelm/EMjXBPeplRqPp3tDHcDHh4P0eGCIvs4r+4CX5DJH6wykJ/cyizmtp55KIAckEXVeNH1vzV2A+QIUc/yTnID1x6aXbSqeQ92nTmLvPP/N0bwnRMpKcwDYi4dxpAkGrqQFJaxtnJWzh8Xo7iNT3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779840; c=relaxed/simple;
	bh=FUHYpeJoejFasqU+NgXG4b97PBqfEWU8P6POrdD71SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtS7HOf+2iuy8ti8nKuVJnG93x41O3iktF4E0vgUt0eAHL96M64qfBMu1+OcHxprGX81LnUx6KPjyHYwFkAB+0o6mb6Em8VkVRi36AQ+62Ntxz1ed4pjXgK0Y13PgmyvC/TkLniLOV0F3tsoPxRdWTeI957wWC+sRFJZtnQw/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQYY04Mt7z4f3lfZ;
	Thu,  1 Feb 2024 17:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 266F51A0232;
	Thu,  1 Feb 2024 17:30:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S16;
	Thu, 01 Feb 2024 17:30:34 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	blazej.kucman@linux.intel.com,
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
Subject: [PATCH v5 12/14] md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
Date: Thu,  1 Feb 2024 17:25:57 +0800
Message-Id: <20240201092559.910982-13-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S16
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr13WF4xJry7XF4UXw13Jwb_yoW7AF1xpa
	9Fkas0vr40q34akrWDtF4kWa4F9FZ7KrW3ZF93Cw4fA3W7Xr1vy3W5Ja45ury5Ary8J3y5
	JFW5tFyDWrs8Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
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
 drivers/md/raid5.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

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


