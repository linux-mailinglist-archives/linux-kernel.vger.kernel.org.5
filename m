Return-Path: <linux-kernel+bounces-33086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA2836445
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E7028DC65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45713CF7F;
	Mon, 22 Jan 2024 13:17:23 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE413D965;
	Mon, 22 Jan 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929443; cv=none; b=qdSinQnfJG0aoeoEFyHUtII/oLUULCUGO6mFEJ93FM2OQuiHvS5FSBAt4tJQzWqs3pbk8FhSj+0O4HCApA8UI+BRBKtAsf1SkV3OBn4DyiobStZ1Y6Yp8Ij6CWu896jDsC27wr60ljnBZSut6pUQMQ7QYFFfYBoLx+RX8fujPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929443; c=relaxed/simple;
	bh=4yECQoQNlH9bsEd+fvCW5ixKWErUNJAyZS+uhg6KZ+0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hcLeCwgCGqLwOZLV9UIF9RKMT/7aU4BKOkbnYlmaKlYm377c6Kzc/khpfwrw/BZhx7mEk13IU6OF1R/zNPR4ueDcD1CC4oGt5uGbOzijcv2LMSLWqn7OgrVDKZ9F5cFhAeUzCLdrxtNdtvPA2O5UDwByAAQVL+2cmEIyt9pJb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJW3C1Pvmz4f3jJ3;
	Mon, 22 Jan 2024 21:17:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 15C5C1A0272;
	Mon, 22 Jan 2024 21:17:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDZaq5l3XaFBg--.39166S3;
	Mon, 22 Jan 2024 21:17:14 +0800 (CST)
Subject: Re: [PATCH RFC 5/5] md: use md_reap_sync_thread() directly for
 dm-raid
To: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, msnitzer@redhat.com, heinzm@redhat.com,
 song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
 <20240120103734.4155446-6-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b8f80884-74e8-f294-3a84-713ecca88ea3@huaweicloud.com>
Date: Mon, 22 Jan 2024 21:17:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240120103734.4155446-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDZaq5l3XaFBg--.39166S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWfZw1rKFyrJFy5KFW3Jrb_yoW7Gr1Up3
	y8JFn8Cr45trW5Xr17Ja4DuayYvwnIgFWDtry3GayfJ3Z3KrsxJF15uF1DZFykAa48G3WU
	ta15Kay5ZFyIgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/20 18:37, Yu Kuai Ð´µÀ:
> The root cause is still not clear yet, however, let's convert dm-raid
> back to use md_reap_sync_thread() directly. This is not safe but at
> least there won't be new regressions. We can decide what to do after
> figuring out the root cause.

I think I finally figure out the root cause here. This patch is no
longer needed after following patch. I already verified in my VM for 3
times that lvconvert-raid-reshape.sh won't fail(with raid6 patch
2c265ac5ffde reverted).

I'll run more tests in case there are new regression. Meanwhile I'll try
to locate root cause of the problem decribed in patch 4.

Thanks,
Kuai

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eb009d6bb03a..108e7e313631 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3241,7 +3241,7 @@ static int raid_ctr(struct dm_target *ti, unsigned 
int argc, char **argv)
         rs->md.in_sync = 1;

         /* Keep array frozen until resume. */
-       set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
+       md_frozen_sync_thread(&rs->md);

         /* Has to be held on running the array */
         mddev_suspend_and_lock_nointr(&rs->md);
@@ -3722,6 +3722,9 @@ static int raid_message(struct dm_target *ti, 
unsigned int argc, char **argv,
         if (!mddev->pers || !mddev->pers->sync_request)
                 return -EINVAL;

+       if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+               return -EBUSY;
+
         if (!strcasecmp(argv[0], "frozen"))
                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
         else
@@ -3796,10 +3799,8 @@ static void raid_postsuspend(struct dm_target *ti)
         struct raid_set *rs = ti->private;

         if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-               /* Writes have to be stopped before suspending to avoid 
deadlocks. */
-               if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
-                       md_stop_writes(&rs->md);
-
+               md_frozen_sync_thread(&rs->md);
+               md_stop_writes(&rs->md);
                 mddev_suspend(&rs->md, false);
         }
  }
@@ -4011,9 +4012,6 @@ static int raid_preresume(struct dm_target *ti)
                         DMERR("Failed to resize bitmap");
         }

-       /* Check for any resize/reshape on @rs and adjust/initiate */
-       /* Be prepared for mddev_resume() in raid_resume() */
-       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
         if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
                 set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
                 mddev->resync_min = mddev->recovery_cp;
@@ -4056,10 +4054,11 @@ static void raid_resume(struct dm_target *ti)
                         rs_set_capacity(rs);

                 mddev_lock_nointr(mddev);
-               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
                 mddev->ro = 0;
                 mddev->in_sync = 0;
                 mddev_unlock_and_resume(mddev);
+
+               md_unfrozen_sync_thread(mddev);
         }
  }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9ef17a769cc2..0638d104fe26 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4939,7 +4939,7 @@ static void idle_sync_thread(struct mddev *mddev)
         mutex_unlock(&mddev->sync_mutex);
  }

-static void frozen_sync_thread(struct mddev *mddev)
+void md_frozen_sync_thread(struct mddev *mddev)
  {
         mutex_lock(&mddev->sync_mutex);
         set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
@@ -4952,6 +4952,18 @@ static void frozen_sync_thread(struct mddev *mddev)
         stop_sync_thread(mddev, false, false);
         mutex_unlock(&mddev->sync_mutex);
  }
+EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
+
+void md_unfrozen_sync_thread(struct mddev *mddev)
+{
+       mutex_lock(&mddev->sync_mutex);
+       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+       md_wakeup_thread(mddev->thread);
+       sysfs_notify_dirent_safe(mddev->sysfs_action);
+       mutex_unlock(&mddev->sync_mutex);
+}
+EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);

  static ssize_t
  action_store(struct mddev *mddev, const char *page, size_t len)
@@ -4963,7 +4975,7 @@ action_store(struct mddev *mddev, const char 
*page, size_t len)
         if (cmd_match(page, "idle"))
                 idle_sync_thread(mddev);
         else if (cmd_match(page, "frozen"))
-               frozen_sync_thread(mddev);
+               md_frozen_sync_thread(mddev);
         else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
                 return -EBUSY;
         else if (cmd_match(page, "resync"))
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc59799..332520595ed8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -781,6 +781,8 @@ extern void md_rdev_clear(struct md_rdev *rdev);
  extern void md_handle_request(struct mddev *mddev, struct bio *bio);
  extern int mddev_suspend(struct mddev *mddev, bool interruptible);
  extern void mddev_resume(struct mddev *mddev);
+extern void md_frozen_sync_thread(struct mddev *mddev);
+extern void md_unfrozen_sync_thread(struct mddev *mddev);

  extern void md_reload_sb(struct mddev *mddev, int raid_disk);
  extern void md_update_sb(struct mddev *mddev, int force);


