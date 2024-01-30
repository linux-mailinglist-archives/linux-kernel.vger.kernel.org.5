Return-Path: <linux-kernel+bounces-43807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCE84190E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE171288A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B11376E2;
	Tue, 30 Jan 2024 02:23:08 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1B1A723;
	Tue, 30 Jan 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581387; cv=none; b=pJSkntOQmbFHVuVcflDeKuKE8j55ebQcYnZ/tHZCCtpuMpgQEAdcTnMAONIIpN4kg7mBnt+oX//kw4IabXVgiv9s3IIOnMyNe1dxHFrzxBzoDmWwsdbXVuQwq11QOqQnZAukl2y6cpZjJRfP8/uWpWijaVfSE5bBCy8aMnD1eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581387; c=relaxed/simple;
	bh=h4mAM5munNDh64f9BT7eKjkJVG7xHUqubnznwxYlHRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0JGNCXs9neLjqNVuFAiVDv3gVEl7wkmwSZPLcvFRf8tYR8EDbq9eK+uF8l+T5/ENNow7Rs/K3CE4wybEYRvloA9Ih9nwHdhWm2dKBjcUitYZT6+R25H8wqjcenx13WNdEVRU6t7tXdFd88PLM84YeMSJF4HUKniDamS//4sCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TP88f573Kz4f3lwg;
	Tue, 30 Jan 2024 10:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C94E11A0171;
	Tue, 30 Jan 2024 10:23:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S6;
	Tue, 30 Jan 2024 10:23:02 +0800 (CST)
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
Subject: [PATCH v4 02/14] md: don't ignore read-only array in md_check_recovery()
Date: Tue, 30 Jan 2024 10:18:31 +0800
Message-Id: <20240130021843.3608859-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xZw47XF4fCr17tFyUGFg_yoWrXw45pa
	yfKas8Cr4UtFy3urZrK3WDXayYvr10qrZ0yFy3u34fAw1rtr4Sk34ruFyUJFWDtFyFqw4Y
	vw4rJF43ZFy8Kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOJPEUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Usually if the array is not read-write, md_check_recovery() won't
register new sync_thread in the first place. And if the array is
read-write and sync_thread is registered, md_set_readonly() will
unregister sync_thread before setting the array read-only. md/raid
follow this behavior hence there is no problem.

After commit f52f5c71f3d4 ("md: fix stopping sync thread"), following
hang can be triggered by test shell/integrity-caching.sh:

1) array is read-only. dm-raid update super block:
rs_update_sbs
 ro = mddev->ro
 mddev->ro = 0
  -> set array read-write
 md_update_sb

2) register new sync thread concurrently.

3) dm-raid set array back to read-only:
rs_update_sbs
 mddev->ro = ro

4) stop the array:
raid_dtr
 md_stop
  stop_sync_thread
    set_bit(MD_RECOVERY_INTR, &mddev->recovery);
    md_wakeup_thread_directly(mddev->sync_thread);
    wait_event(..., !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))

5) sync thread done:
 md_do_sync
 set_bit(MD_RECOVERY_DONE, &mddev->recovery);
 md_wakeup_thread(mddev->thread);

6) daemon thread can't unregister sync thread:
 md_check_recovery
  if (!md_is_rdwr(mddev) &&
      !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
   return;
  -> -> MD_RECOVERY_RUNNING can't be cleared, hence step 4 hang;

The root cause is that dm-raid manipulate 'mddev->ro' by itself,
however, dm-raid really should stop sync thread before setting the
array read-only. Unfortunately, I need to read more code before I
can refacter the handler of 'mddev->ro' in dm-raid, hence let's fix
the problem the easy way for now to prevent dm-raid regression.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/9801e40-8ac7-e225-6a71-309dcf9dc9aa@redhat.com/
Fixes: ecbfb9f118bc ("dm raid: add raid level takeover support")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 07b80278eaa5..6906d023f1d6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9445,6 +9445,20 @@ static void md_start_sync(struct work_struct *ws)
 		sysfs_notify_dirent_safe(mddev->sysfs_action);
 }
 
+static void unregister_sync_thread(struct mddev *mddev)
+{
+	if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
+		/* resync/recovery still happening */
+		clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!mddev->sync_thread))
+		return;
+
+	md_reap_sync_thread(mddev);
+}
+
 /*
  * This routine is regularly called by all per-raid-array threads to
  * deal with generic issues like resync and super-block update.
@@ -9482,7 +9496,8 @@ void md_check_recovery(struct mddev *mddev)
 	}
 
 	if (!md_is_rdwr(mddev) &&
-	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) &&
+	    !test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9504,8 +9519,7 @@ void md_check_recovery(struct mddev *mddev)
 			struct md_rdev *rdev;
 
 			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-				/* sync_work already queued. */
-				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+				unregister_sync_thread(mddev);
 				goto unlock;
 			}
 
@@ -9568,16 +9582,7 @@ void md_check_recovery(struct mddev *mddev)
 		 * still set.
 		 */
 		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-			if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
-				/* resync/recovery still happening */
-				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				goto unlock;
-			}
-
-			if (WARN_ON_ONCE(!mddev->sync_thread))
-				goto unlock;
-
-			md_reap_sync_thread(mddev);
+			unregister_sync_thread(mddev);
 			goto unlock;
 		}
 
-- 
2.39.2


