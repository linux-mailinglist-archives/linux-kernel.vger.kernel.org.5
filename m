Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28E77C74E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjHOGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjHOGAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:00:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6993;
        Mon, 14 Aug 2023 23:00:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQ0xB2RW2z4f403R;
        Tue, 15 Aug 2023 14:00:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnPcV9FNtkZKHTAg--.59135S3;
        Tue, 15 Aug 2023 14:00:30 +0800 (CST)
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to
 md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-4-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bb11d6ca-978a-8e1d-e721-d9d84c9dc5e3@huaweicloud.com>
Date:   Tue, 15 Aug 2023 14:00:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230815030957.509535-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnPcV9FNtkZKHTAg--.59135S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary7WF43WF1kXw4kKr4kWFg_yoW7ZF13pa
        yxJFnxGrWUJrW3XrW2g3WDXayrZr10q39rtry3Wa4rJwn5tFn7KF15uF1UAFWDKa93Ca1U
        Zws5JanxCFyj9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/08/15 11:09, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Before this patch, for read-write array:
> 
> 1) md_check_recover() found that something need to be done, and it'll
>     try to grab 'reconfig_mutex'. The case that md_check_recover() need
>     to do something:
>     - array is not suspend;
>     - super_block need to be updated;
>     - 'MD_RECOVERY_NEEDED' or ''MD_RECOVERY_DONE' is set;
>     - unusual case related to safemode;
> 
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>     md_check_recover() will try to choose a sync direction, and then
>     queue a work md_start_sync().
> 
> 3) md_start_sync() register sync_thread;
> 
> After this patch,
> 
> 1) is the same;
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>     queue a work md_start_sync() directly;
> 3) md_start_sync() will try to choose a sync direction, and then
>     register sync_thread();
> 
> Because 'MD_RECOVERY_RUNNING' is cleared when sync_thread is done, 2)
> and 3) is always ran in serial and they can never concurrent, this
> change should not introduce any behavior change for now.
> 
> Also fix a problem that md_start_sync() can clear 'MD_RECOVERY_RUNNING'
> without protection in error path, which might affect the logical in
> md_check_recovery().
> 
> The advantage to change this is that array reconfiguration is
> independent from daemon now, and it'll be much easier to synchronize it
> with io, consider that io may rely on daemon thread to be done.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 70 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4846ff6d25b0..03615b0e9fe1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9291,6 +9291,22 @@ static bool md_choose_sync_direction(struct mddev *mddev, int *spares)
>   static void md_start_sync(struct work_struct *ws)
>   {
>   	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
> +	int spares = 0;
> +
> +	mddev_lock_nointr(mddev);
> +
> +	if (!md_choose_sync_direction(mddev, &spares))
> +		goto not_running;
> +
> +	if (!mddev->pers->sync_request)
> +		goto not_running;
> +
> +	/*
> +	 * We are adding a device or devices to an array which has the bitmap
> +	 * stored on all devices. So make sure all bitmap pages get written.
> +	 */
> +	if (spares)
> +		md_bitmap_write_all(mddev->bitmap);
>   
>   	rcu_assign_pointer(mddev->sync_thread,
>   			   md_register_thread(md_do_sync, mddev, "resync"));
> @@ -9298,20 +9314,27 @@ static void md_start_sync(struct work_struct *ws)
>   		pr_warn("%s: could not start resync thread...\n",
>   			mdname(mddev));
>   		/* leave the spares where they are, it shouldn't hurt */
> -		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> -		clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> -		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> -		clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -		wake_up(&resync_wait);
> -		if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -				       &mddev->recovery))
> -			if (mddev->sysfs_action)
> -				sysfs_notify_dirent_safe(mddev->sysfs_action);
> -	} else
> -		md_wakeup_thread(mddev->sync_thread);
> +		goto not_running;
> +	}
> +
> +	mddev_unlock(mddev);
> +	md_wakeup_thread(mddev->sync_thread);
>   	sysfs_notify_dirent_safe(mddev->sysfs_action);
>   	md_new_event();
> +	return;
> +
> +not_running:
> +	clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> +	clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> +	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> +	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> +	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> +	mddev_unlock(mddev);
> +
> +	wake_up(&resync_wait);
> +	if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
> +	    mddev->sysfs_action)
> +		sysfs_notify_dirent_safe(mddev->sysfs_action);
>   }
>   
>   /*
> @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
>   		return;
>   
>   	if (mddev_trylock(mddev)) {
> -		int spares = 0;
>   		bool try_set_sync = mddev->safemode != 0;
>   
>   		if (!mddev->external && mddev->safemode == 1)
> @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
>   		clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>   
>   		if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
> -		    test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
> -			goto not_running;
> -		if (!md_choose_sync_direction(mddev, &spares))
> -			goto not_running;
> -		if (mddev->pers->sync_request) {
> -			if (spares) {
> -				/* We are adding a device or devices to an array
> -				 * which has the bitmap stored on all devices.
> -				 * So make sure all bitmap pages get written
> -				 */
> -				md_bitmap_write_all(mddev->bitmap);
> -			}
> +		    test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {

Sorry that I made a mistake here while rebasing v2, here should be

!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)

With this fixed, there are no new regression for mdadm tests using loop
devicein my VM.

Thanks,
Kuai
>   			queue_work(md_misc_wq, &mddev->sync_work);
> -			goto unlock;
> -		}
> -	not_running:
> -		if (!mddev->sync_thread) {
> +		} else {
>   			clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>   			wake_up(&resync_wait);
> -			if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -					       &mddev->recovery))
> -				if (mddev->sysfs_action)
> -					sysfs_notify_dirent_safe(mddev->sysfs_action);
>   		}
>   	unlock:
>   		wake_up(&mddev->sb_wait);
> 

