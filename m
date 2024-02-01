Return-Path: <linux-kernel+bounces-47878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E395845410
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B282832EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717B21649D6;
	Thu,  1 Feb 2024 09:30:43 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646991649AD;
	Thu,  1 Feb 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779843; cv=none; b=cS+r96GcXzHOFxwYtdZ9Q3udmSso4vJfLoDCt55Dlsfn71D3aU5tsRQhwydacCK4GW5YxzJidbF0AJJ5H4UQh0E6cTD83UPYZiA2Gd3ZLS6BG6brFQZUI6oEyqFYKXxiqAuppKEDYFT3Gctr7+yaiTh46iDa2s87xqnEsNHKxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779843; c=relaxed/simple;
	bh=Pw8nxEepj3SW3fuzUXlVu8OndBo1SbgV3fSER76rjfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivz8vl+5acLGcqxweoSlnOR39eiPstaE/3RqCXdu0G6/fcY7Ty67Npx/jJFQI/7TwUyYzZkaW0r0S2ppdLG0LD+0gfQ7XBXQiZsIfluxfGbJj6m6LLJfT2eXrNg46/blzg6v7K5AuO0aM1XqRBonuD8vuBKrNK8dqGUjjAaMXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQYY42zs3z4f3l7p;
	Thu,  1 Feb 2024 17:30:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9DD691A0390;
	Thu,  1 Feb 2024 17:30:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S18;
	Thu, 01 Feb 2024 17:30:36 +0800 (CST)
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
Subject: [PATCH v5 14/14] dm-raid: remove mddev_suspend/resume()
Date: Thu,  1 Feb 2024 17:25:59 +0800
Message-Id: <20240201092559.910982-15-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S18
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UXw48Cw4kXrW8Cw4DJwb_yoW5GrWDpw
	4IqFWayw4UtFZrXwsrA3WvgFy5twn5KrWjkrZxW34fWa43Gr13Wr18Gay5XFWDKFWfJF1D
	Aa1Utw48uryIgrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

dm layer will make sure that no new IO can be issued and will wait for
all dispatched IO to be done during suspend or before removing the
device. Hence there is no need to call mddev_suspend/resume() again.

BTW, mddev_suspend/resume() can't gurantee that there are no sync IO,
and previous patch make sure that presuspend will stop sync thread.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c |  8 +++-----
 drivers/md/md.c      | 11 +++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5f78cc19d6f3..ed8c28952b14 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3241,7 +3241,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.in_sync = 1;
 
 	/* Has to be held on running the array */
-	mddev_suspend_and_lock_nointr(&rs->md);
+	mddev_lock_nointr(&rs->md);
 
 	/* Keep array frozen until resume. */
 	md_frozen_sync_thread(&rs->md);
@@ -3829,11 +3829,9 @@ static void raid_postsuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
-	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
+	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
 		/* Writes have to be stopped before suspending to avoid deadlocks. */
 		md_stop_writes(&rs->md);
-		mddev_suspend(&rs->md, false);
-	}
 }
 
 static void attempt_restore_of_faulty_devices(struct raid_set *rs)
@@ -4091,7 +4089,7 @@ static void raid_resume(struct dm_target *ti)
 		mddev->ro = 0;
 		mddev->in_sync = 0;
 		md_unfrozen_sync_thread(mddev);
-		mddev_unlock_and_resume(mddev);
+		mddev_unlock(mddev);
 	}
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2c245341148a..a8db84c200fe 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -437,6 +437,10 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
 {
 	int err = 0;
 
+	/* Array is supended from dm_suspend() for dm-raid. */
+	if (!mddev->gendisk)
+		return 0;
+
 	/*
 	 * hold reconfig_mutex to wait for normal io will deadlock, because
 	 * other context can't update super_block, and normal io can rely on
@@ -488,6 +492,13 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
 
 static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
 {
+	/*
+	 * Array is supended from dm_suspend() and resumed from dm_resume() for
+	 * dm-raid.
+	 */
+	if (!mddev->gendisk)
+		return;
+
 	lockdep_assert_not_held(&mddev->reconfig_mutex);
 
 	mutex_lock(&mddev->suspend_mutex);
-- 
2.39.2


