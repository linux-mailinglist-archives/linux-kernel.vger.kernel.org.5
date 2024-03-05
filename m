Return-Path: <linux-kernel+bounces-91802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC138716DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997CC28381D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DDA8062A;
	Tue,  5 Mar 2024 07:29:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811B7EF09;
	Tue,  5 Mar 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623776; cv=none; b=KJ45pPdNi6XKFEQaIY8Vs3uChQxXAYn5rSTbqt2791GiTnEIGYTZ038ggZhO8HLSca0LFfBv0uLL+W3qnd4Dmq9bjwCczwuccksaSXI2Tfnb7OmZOl2ZT/3B31SvOYanccRTNvK4yELUNYiYnRjHthTbZsB4WTLxAARkc/SBZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623776; c=relaxed/simple;
	bh=DdK9NSLtymzytVxiXQOrSWhKL0dKh4wr7ZOBCaMyZaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyN9v38b9gx6G19OHV9/VNSsSQqefcf9G/wtOzzldzz45PFZ8kZ04v07CJVsH71hL8jwUFS+MGM11Fdb1sAF+sZ7nOWjn+rJQr6SOo0LeeSxOYtYio5rQXV8huBeWp5iUzhL7ddy0ajZkwe7ZA8JjG2XowQ/fbG1QZtXWzHvRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpnJ71Nhdz4f3k6M;
	Tue,  5 Mar 2024 15:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A99951A0175;
	Tue,  5 Mar 2024 15:29:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHRyeZlGnf+Fw--.17927S12;
	Tue, 05 Mar 2024 15:29:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	zkabelac@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	jbrassow@redhat.com,
	neilb@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.8 v2 8/9] dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
Date: Tue,  5 Mar 2024 15:23:05 +0800
Message-Id: <20240305072306.2562024-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
References: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHRyeZlGnf+Fw--.17927S12
X-Coremail-Antispam: 1UD129KBjvJXoW3CFy3GFy5uFW5XF1UGF43GFg_yoWkCr1rpa
	y7tas0vr4jq3yY9w4DAFWkWa4SgFn7KrZFyFZ3J34fA3W3trn5C3W5Xa1Yvrn8CFyrury5
	Aa15tayDurWSgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
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
patch on the one hand make sure raid_message() can't change
sync_thread() through raid_message() after presuspend(), on the other
hand detect the above 3 cases before wait for IO do be done in
dm_suspend(), and let dm-raid requeue those IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-raid.c | 22 ++++++++++++++++++++--
 drivers/md/md.c      | 24 ++++++++++++++++++++++--
 drivers/md/md.h      |  3 ++-
 drivers/md/raid5.c   | 32 ++++++++++++++++++++++++++++++--
 4 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 7d48943acd57..ea45f777691c 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -213,6 +213,7 @@ struct raid_dev {
 #define RT_FLAG_RS_IN_SYNC		6
 #define RT_FLAG_RS_RESYNCING		7
 #define RT_FLAG_RS_GROW			8
+#define RT_FLAG_RS_FROZEN		9
 
 /* Array elements of 64 bit needed for rebuild/failed disk bits */
 #define DISKS_ARRAY_ELEMS ((MAX_RAID_DEVICES + (sizeof(uint64_t) * 8 - 1)) / sizeof(uint64_t) / 8)
@@ -3340,7 +3341,8 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
 		return DM_MAPIO_REQUEUE;
 
-	md_handle_request(mddev, bio);
+	if (unlikely(!md_handle_request(mddev, bio)))
+		return DM_MAPIO_REQUEUE;
 
 	return DM_MAPIO_SUBMITTED;
 }
@@ -3724,7 +3726,8 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
-	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags) ||
+	    test_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags))
 		return -EBUSY;
 
 	if (!strcasecmp(argv[0], "frozen")) {
@@ -3808,6 +3811,12 @@ static void raid_presuspend(struct dm_target *ti)
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
 
+	/*
+	 * From now on, disallow raid_message() to change sync_thread until
+	 * resume, raid_postsuspend() is too late.
+	 */
+	set_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
+
 	if (!reshape_interrupted(mddev))
 		return;
 
@@ -3820,6 +3829,13 @@ static void raid_presuspend(struct dm_target *ti)
 		mddev->pers->prepare_suspend(mddev);
 }
 
+static void raid_presuspend_undo(struct dm_target *ti)
+{
+	struct raid_set *rs = ti->private;
+
+	clear_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
+}
+
 static void raid_postsuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
@@ -4085,6 +4101,7 @@ static void raid_resume(struct dm_target *ti)
 
 		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
 		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+		clear_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
 		mddev_lock_nointr(mddev);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
@@ -4105,6 +4122,7 @@ static struct target_type raid_target = {
 	.iterate_devices = raid_iterate_devices,
 	.io_hints = raid_io_hints,
 	.presuspend = raid_presuspend,
+	.presuspend_undo = raid_presuspend_undo,
 	.postsuspend = raid_postsuspend,
 	.preresume = raid_preresume,
 	.resume = raid_resume,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index e9e666240e9f..50d7bfa3c6f9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -366,7 +366,7 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
 	return true;
 }
 
-void md_handle_request(struct mddev *mddev, struct bio *bio)
+bool md_handle_request(struct mddev *mddev, struct bio *bio)
 {
 check_suspended:
 	if (is_suspended(mddev, bio)) {
@@ -374,7 +374,7 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 		/* Bail out if REQ_NOWAIT is set for the bio */
 		if (bio->bi_opf & REQ_NOWAIT) {
 			bio_wouldblock_error(bio);
-			return;
+			return true;
 		}
 		for (;;) {
 			prepare_to_wait(&mddev->sb_wait, &__wait,
@@ -390,10 +390,13 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 
 	if (!mddev->pers->make_request(mddev, bio)) {
 		percpu_ref_put(&mddev->active_io);
+		if (!mddev->gendisk && mddev->pers->prepare_suspend)
+			return false;
 		goto check_suspended;
 	}
 
 	percpu_ref_put(&mddev->active_io);
+	return true;
 }
 EXPORT_SYMBOL(md_handle_request);
 
@@ -8758,6 +8761,23 @@ void md_account_bio(struct mddev *mddev, struct bio **bio)
 }
 EXPORT_SYMBOL_GPL(md_account_bio);
 
+void md_free_cloned_bio(struct bio *bio)
+{
+	struct md_io_clone *md_io_clone = bio->bi_private;
+	struct bio *orig_bio = md_io_clone->orig_bio;
+	struct mddev *mddev = md_io_clone->mddev;
+
+	if (bio->bi_status && !orig_bio->bi_status)
+		orig_bio->bi_status = bio->bi_status;
+
+	if (md_io_clone->start_time)
+		bio_end_io_acct(orig_bio, md_io_clone->start_time);
+
+	bio_put(bio);
+	percpu_ref_put(&mddev->active_io);
+}
+EXPORT_SYMBOL_GPL(md_free_cloned_bio);
+
 /* md_allow_write(mddev)
  * Calling this ensures that the array is marked 'active' so that writes
  * may proceed without blocking.  It is important to call this before
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 2db0a75febf9..3133650b57d4 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -782,6 +782,7 @@ extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
 void md_account_bio(struct mddev *mddev, struct bio **bio);
+void md_free_cloned_bio(struct bio *bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
@@ -810,7 +811,7 @@ extern void md_stop_writes(struct mddev *mddev);
 extern int md_rdev_init(struct md_rdev *rdev);
 extern void md_rdev_clear(struct md_rdev *rdev);
 
-extern void md_handle_request(struct mddev *mddev, struct bio *bio);
+extern bool md_handle_request(struct mddev *mddev, struct bio *bio);
 extern int mddev_suspend(struct mddev *mddev, bool interruptible);
 extern void mddev_resume(struct mddev *mddev);
 extern void md_idle_sync_thread(struct mddev *mddev);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6a7a32f7fb91..38a49f6eb54b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -760,6 +760,7 @@ enum stripe_result {
 	STRIPE_RETRY,
 	STRIPE_SCHEDULE_AND_RETRY,
 	STRIPE_FAIL,
+	STRIPE_WAIT_RESHAPE,
 };
 
 struct stripe_request_ctx {
@@ -5946,7 +5947,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				return STRIPE_SCHEDULE_AND_RETRY;
+				ret = STRIPE_SCHEDULE_AND_RETRY;
+				goto out;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6025,6 +6027,12 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 out_release:
 	raid5_release_stripe(sh);
+out:
+	if (ret == STRIPE_SCHEDULE_AND_RETRY && reshape_interrupted(mddev)) {
+		bi->bi_status = BLK_STS_RESOURCE;
+		ret = STRIPE_WAIT_RESHAPE;
+		pr_err_ratelimited("dm-raid456: io across reshape position while reshape can't make progress");
+	}
 	return ret;
 }
 
@@ -6146,7 +6154,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	while (1) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
-		if (res == STRIPE_FAIL)
+		if (res == STRIPE_FAIL || res == STRIPE_WAIT_RESHAPE)
 			break;
 
 		if (res == STRIPE_RETRY)
@@ -6184,6 +6192,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 
 	if (rw == WRITE)
 		md_write_end(mddev);
+	if (res == STRIPE_WAIT_RESHAPE) {
+		md_free_cloned_bio(bi);
+		return false;
+	}
+
 	bio_endio(bi);
 	return true;
 }
@@ -8909,6 +8922,18 @@ static int raid5_start(struct mddev *mddev)
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
@@ -8932,6 +8957,7 @@ static struct md_personality raid6_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 static struct md_personality raid5_personality =
 {
@@ -8956,6 +8982,7 @@ static struct md_personality raid5_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static struct md_personality raid4_personality =
@@ -8981,6 +9008,7 @@ static struct md_personality raid4_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static int __init raid5_init(void)
-- 
2.39.2


