Return-Path: <linux-kernel+bounces-91800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997038716D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86872B236DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA17F7FD;
	Tue,  5 Mar 2024 07:29:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251567E56C;
	Tue,  5 Mar 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623774; cv=none; b=aVOMDYJYtZUWNDjvFlFxnHbR/Qo4qqPBY0+/nibBNHdZdkSXrYoTR8bAiBtB+VPfXkkT6cblrMImbHOK1zYpZ/n0R+O+BlW70x/Drybpxcu5CPauLheJhqi84SmnhduTMTC2gcqwaTLbm5C90BiJ5e4cKHl1IBtqKc99kriSlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623774; c=relaxed/simple;
	bh=XvvAbpEePZjEC0cSUPQ2s2dg9t4q+qLsBBKfup6+WvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRaZuzzPXBarmtKmnuwfmESJfnoGBOcKtYq4dcMum3dUjotVNm8NFrg7OIwvDIS/GrdUGftHOatNguRr97dvS1BvFDl/felBAygsf6gIFyYjMQY0Rt4mz5aLGCOsIE5m1MHI65g8j8em3+Xt8pQl0tay9rqqs6x02hlqhCUFu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpnJ12XT8z4f3lgL;
	Tue,  5 Mar 2024 15:29:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CFEA01A0175;
	Tue,  5 Mar 2024 15:29:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHRyeZlGnf+Fw--.17927S9;
	Tue, 05 Mar 2024 15:29:28 +0800 (CST)
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
Subject: [PATCH md-6.8 v2 5/9] dm-raid: really frozen sync_thread during suspend
Date: Tue,  5 Mar 2024 15:23:02 +0800
Message-Id: <20240305072306.2562024-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHRyeZlGnf+Fw--.17927S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtry3CryrWw1rXw13tw13Arb_yoW7Zr1rpr
	WrtFs8Ar4UJrW7ZFZFy3WvqFW5ZwnIqrZrtry3W3yrA3WfKwsakFy09a47ZFWDGas7Ja4Y
	yan8tFW3u3WDKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

1) commit f52f5c71f3d4 ("md: fix stopping sync thread") remove
   MD_RECOVERY_FROZEN from __md_stop_writes() and doesn't realize that
   dm-raid relies on __md_stop_writes() to frozen sync_thread
   indirectly. Fix this problem by adding MD_RECOVERY_FROZEN in
   md_stop_writes(), and since stop_sync_thread() is only used for
   dm-raid in this case, also move stop_sync_thread() to
   md_stop_writes().
2) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen,
   it only prevent new sync_thread to start, and it can't stop the
   running sync thread; In order to frozen sync_thread, after seting the
   flag, stop_sync_thread() should be used.
3) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, use
   it as condition for md_stop_writes() in raid_postsuspend() doesn't
   look correct. Consider that reentrant stop_sync_thread() do nothing,
   always call md_stop_writes() in raid_postsuspend().
4) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
   and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
   new sync_thread can start unexpected. Fix this by disallow
   raid_message() to change sync_thread status during suspend.

Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), the
test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread(),
and with previous fixes, the test won't hang there anymore, however, the
test will still fail and complain that ext4 is corrupted. And with this
patch, the test won't hang due to stop_sync_thread() or fail due to ext4
is corrupted anymore. However, there is still a deadlock related to
dm-raid456 that will be fixed in following patches.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_stop_writes()")
Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-raid.c | 25 +++++++++++++++----------
 drivers/md/md.c      |  3 ++-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eb009d6bb03a..e2d7a73c0f87 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.ro = 1;
 	rs->md.in_sync = 1;
 
-	/* Keep array frozen until resume. */
-	set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
-
 	/* Has to be held on running the array */
 	mddev_suspend_and_lock_nointr(&rs->md);
+
+	/* Keep array frozen until resume. */
+	md_frozen_sync_thread(&rs->md);
+
 	r = md_run(&rs->md);
 	rs->md.in_sync = 0; /* Assume already marked dirty */
 	if (r) {
@@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
+	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+		return -EBUSY;
+
 	if (!strcasecmp(argv[0], "frozen"))
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	else
@@ -3796,10 +3800,11 @@ static void raid_postsuspend(struct dm_target *ti)
 	struct raid_set *rs = ti->private;
 
 	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-		/* Writes have to be stopped before suspending to avoid deadlocks. */
-		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
-			md_stop_writes(&rs->md);
-
+		/*
+		 * sync_thread must be stopped during suspend, and writes have
+		 * to be stopped before suspending to avoid deadlocks.
+		 */
+		md_stop_writes(&rs->md);
 		mddev_suspend(&rs->md, false);
 	}
 }
@@ -4012,8 +4017,6 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Check for any resize/reshape on @rs and adjust/initiate */
-	/* Be prepared for mddev_resume() in raid_resume() */
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		mddev->resync_min = mddev->recovery_cp;
@@ -4055,10 +4058,12 @@ static void raid_resume(struct dm_target *ti)
 		if (mddev->delta_disks < 0)
 			rs_set_capacity(rs);
 
+		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
+		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 		mddev_lock_nointr(mddev);
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
+		md_unfrozen_sync_thread(mddev);
 		mddev_unlock_and_resume(mddev);
 	}
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 306cbbf92fcf..e9e666240e9f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6335,7 +6335,6 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	stop_sync_thread(mddev, true, false);
 	del_timer_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
@@ -6360,6 +6359,8 @@ static void __md_stop_writes(struct mddev *mddev)
 void md_stop_writes(struct mddev *mddev)
 {
 	mddev_lock_nointr(mddev);
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
 	__md_stop_writes(mddev);
 	mddev_unlock(mddev);
 }
-- 
2.39.2


