Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B27664D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjG1HIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjG1HIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:08:44 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B235AB;
        Fri, 28 Jul 2023 00:08:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBzJ11wRgz4f400K;
        Fri, 28 Jul 2023 15:08:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFwacNkzcr3Ow--.15522S3;
        Fri, 28 Jul 2023 15:08:33 +0800 (CST)
Subject: Re: [PATCH -next] md:ensure mddev->reconfig_mutex is hold when try to
 get mddev->sync_thread
To:     Li Lingfeng <lilingfeng@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230727072047.389637-1-lilingfeng@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <155ef03b-8792-7923-cc6c-123be8b12de4@huaweicloud.com>
Date:   Fri, 28 Jul 2023 15:08:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230727072047.389637-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFwacNkzcr3Ow--.15522S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw18uFWfJry7GFWrtry7Jrb_yoWxJFWfpa
        yrJFy3Ar4FvrW3ZrWUJayDuayYv3WIqFWjkryfC3yrJ3Z3W3y5KFyUuFyUXr1DZFyrAr43
        t3W5KF4kWFs2gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/07/27 15:20, Li Lingfeng Ð´µÀ:
> Commit ba9d9f1a707f ("Revert "md: unlock mddev before reap sync_thread in
> action_store"") removed the scenario of calling md_unregister_thread()
> without holding mddev->reconfig_mutex, so add a lock holding check before
> acquiring mddev->sync_thread.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> 
> Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> ---
>   drivers/md/md-cluster.c  | 8 ++++----
>   drivers/md/md.c          | 9 +++++----
>   drivers/md/md.h          | 2 +-
>   drivers/md/raid1.c       | 4 ++--
>   drivers/md/raid10.c      | 2 +-
>   drivers/md/raid5-cache.c | 2 +-
>   drivers/md/raid5.c       | 2 +-
>   7 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 3d9fd74233df..1e26eb223349 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -952,8 +952,8 @@ static int join(struct mddev *mddev, int nodes)
>   	return 0;
>   err:
>   	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
> -	md_unregister_thread(&cinfo->recovery_thread);
> -	md_unregister_thread(&cinfo->recv_thread);
> +	md_unregister_thread(mddev, &cinfo->recovery_thread);
> +	md_unregister_thread(mddev, &cinfo->recv_thread);
>   	lockres_free(cinfo->message_lockres);
>   	lockres_free(cinfo->token_lockres);
>   	lockres_free(cinfo->ack_lockres);
> @@ -1015,8 +1015,8 @@ static int leave(struct mddev *mddev)
>   		resync_bitmap(mddev);
>   
>   	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
> -	md_unregister_thread(&cinfo->recovery_thread);
> -	md_unregister_thread(&cinfo->recv_thread);
> +	md_unregister_thread(mddev, &cinfo->recovery_thread);
> +	md_unregister_thread(mddev, &cinfo->recv_thread);
>   	lockres_free(cinfo->message_lockres);
>   	lockres_free(cinfo->token_lockres);
>   	lockres_free(cinfo->ack_lockres);
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a3d98273b295..5c3c19b8d509 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6258,7 +6258,7 @@ static void mddev_detach(struct mddev *mddev)
>   		mddev->pers->quiesce(mddev, 1);
>   		mddev->pers->quiesce(mddev, 0);
>   	}
> -	md_unregister_thread(&mddev->thread);
> +	md_unregister_thread(mddev, &mddev->thread);
>   	if (mddev->queue)
>   		blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
>   }
> @@ -7990,9 +7990,10 @@ struct md_thread *md_register_thread(void (*run) (struct md_thread *),
>   }
>   EXPORT_SYMBOL(md_register_thread);
>   
> -void md_unregister_thread(struct md_thread __rcu **threadp)
> +void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **threadp)
>   {
> -	struct md_thread *thread = rcu_dereference_protected(*threadp, true);
> +	struct md_thread *thread = rcu_dereference_protected(*threadp,
> +					lockdep_is_held(&mddev->reconfig_mutex));
>   
>   	if (!thread)
>   		return;
> @@ -9484,7 +9485,7 @@ void md_reap_sync_thread(struct mddev *mddev)
>   	bool is_reshaped = false;
>   
>   	/* resync has finished, collect result */
> -	md_unregister_thread(&mddev->sync_thread);
> +	md_unregister_thread(mddev, &mddev->sync_thread);
>   	atomic_inc(&mddev->sync_seq);
>   
>   	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8ae957480976..9bcb77bca963 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -761,7 +761,7 @@ extern struct md_thread *md_register_thread(
>   	void (*run)(struct md_thread *thread),
>   	struct mddev *mddev,
>   	const char *name);
> -extern void md_unregister_thread(struct md_thread __rcu **threadp);
> +extern void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **threadp);
>   extern void md_wakeup_thread(struct md_thread __rcu *thread);
>   extern void md_check_recovery(struct mddev *mddev);
>   extern void md_reap_sync_thread(struct mddev *mddev);
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 23d211969565..581dfbdfca89 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3152,7 +3152,7 @@ static int raid1_run(struct mddev *mddev)
>   	 * RAID1 needs at least one disk in active
>   	 */
>   	if (conf->raid_disks - mddev->degraded < 1) {
> -		md_unregister_thread(&conf->thread);
> +		md_unregister_thread(mddev, &conf->thread);
>   		ret = -EINVAL;
>   		goto abort;
>   	}
> @@ -3179,7 +3179,7 @@ static int raid1_run(struct mddev *mddev)
>   
>   	ret = md_integrity_register(mddev);
>   	if (ret) {
> -		md_unregister_thread(&mddev->thread);
> +		md_unregister_thread(mddev, &mddev->thread);
>   		goto abort;
>   	}
>   	return 0;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 16aa9d735880..6188b71186f4 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4320,7 +4320,7 @@ static int raid10_run(struct mddev *mddev)
>   	return 0;
>   
>   out_free_conf:
> -	md_unregister_thread(&mddev->thread);
> +	md_unregister_thread(mddev, &mddev->thread);
>   	raid10_free_conf(conf);
>   	mddev->private = NULL;
>   out:
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 47ba7d9e81e1..ce9b42fd54b9 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -3171,7 +3171,7 @@ void r5l_exit_log(struct r5conf *conf)
>   	/* Ensure disable_writeback_work wakes up and exits */
>   	wake_up(&conf->mddev->sb_wait);
>   	flush_work(&log->disable_writeback_work);
> -	md_unregister_thread(&log->reclaim_thread);
> +	md_unregister_thread(conf->mddev, &log->reclaim_thread);
>   
>   	conf->log = NULL;
>   
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4cdb35e54251..f41f9b712d3d 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8107,7 +8107,7 @@ static int raid5_run(struct mddev *mddev)
>   
>   	return 0;
>   abort:
> -	md_unregister_thread(&mddev->thread);
> +	md_unregister_thread(mddev, &mddev->thread);
>   	print_raid5_conf(conf);
>   	free_conf(conf);
>   	mddev->private = NULL;
> 

