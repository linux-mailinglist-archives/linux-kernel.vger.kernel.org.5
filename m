Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9400D7D02CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbjJSTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbjJSTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:52:28 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25F11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:51:46 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd09663b1cso52633a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745106; x=1698349906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U6r7VG/hlgzvJUkfJxMrrqAEusd3ue24ZBPwfHMmPs=;
        b=q5Qmqdexdxs/tbnbfuCW2FJNiMNPDg3v//WboczFtSqTpR5mnFDTNDPlUAdZzFy+DW
         6VQbG9SeQVgy+TVoC9ZFejL3K1Fe7rqGHFmaHqEXkhN+v1XxFC11k5xby2Il7aOHjg/R
         Dga3kLKXoR0FzQEMvVgEg257oUO+TfzLna9LzbLkspJ8Pg6KKHu90ziBUUgbqEu7L90a
         Ou6G1jJSqR6vHmNl66Gu3zW13SuzVG+IByT8MHQbPBCnbamvlyBH1iwGyPLltCtWrmTx
         YP9S+FF97mf47s7r+vCsWZWG7IMIViVIZd7DK+WRAKss/RV3MW6BaYe0MVszXQFDqexJ
         T/Kg==
X-Gm-Message-State: AOJu0YwetwzonM8x68Ur901rb0PV82nuysg63/MKq++dKcIkL4N2b3D4
        mvzXdJOnF5jV7Bn3diC3FjU7
X-Google-Smtp-Source: AGHT+IGqu3XCBNSXWx1rb5do25rd30Uzw7WzImufME+8fw0H9AfKD11QEb3PPFg58B5Ib+Vce2nB6w==
X-Received: by 2002:a05:6830:902:b0:6b8:f588:2c79 with SMTP id v2-20020a056830090200b006b8f5882c79mr4483730ott.1.1697745105671;
        Thu, 19 Oct 2023 12:51:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cab12000000b0065afe284b3csm98823qvb.125.2023.10.19.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:51:45 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:51:43 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christian Loehle <christian.loehle@arm.com>
Cc:     agk@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: dm: delay: use kthread instead of timers and wq
Message-ID: <ZTGIz/erjb8N6AHc@redhat.com>
References: <d90adee6-0b7f-4658-8eb3-84ad38d6ab93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90adee6-0b7f-4658-8eb3-84ad38d6ab93@arm.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023 at  7:21P -0400,
Christian Loehle <christian.loehle@arm.com> wrote:

> The current design of timers and wq to realize the delays
> is insufficient especially for delays below ~50ms.
> The design is replaced with a kthread to flush the expired delays,
> trading some CPU time (in some cases) for better delay accuracy and
> delays closer to what the user requested for smaller delays.
> 
> Since bios can't be completed in interrupt context using a kthread
> is probably the most reasonable way to approach this.

Thanks for working on this.  The tradeoff to burn cpu to poll for bios
that hit their expire time is reasonable for very short delays (which
is the focus of your improvement) _but_ for longer delays it is
definitely wasteful.

Your benchmarks (below) don't quantify the cpu time difference.

Might you use a hybrid aproach where over a certain delay threshold it
does make sense to avoid waking the polling thread?  Otherwise if
delay is below the threshold the busy loop is queued immediately?

Basically: still use workqueue, but bypass jitter associated with
using timer when appropriate (delay is short).

There are some inline comments below on your patch.

Thanks,
Mike

> Testing with
> echo "0 2097152 zero" | dmsetup create dm-zeros
> for i in $(seq 0 20);
> do
>   echo "0 2097152 delay /dev/mapper/dm-zeros 0 $i" | dmsetup create dm-delay-${i}ms;
> done
> 
> Some performance numbers for comparison
> beaglebone black (single core) CONFIG_HZ_1000=y:
> fio --name=1msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
> Theoretical maximum: 1000 IOPS
> Previous: 250 IOPS
> Kthread: 500 IOPS
> fio --name=10msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
> Theoretical maximum: 1000 IOPS
> Previous: 45 IOPS
> Kthread: 50 IOPS
> fio --name=1mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
> Theoretical maximum: 1000 IOPS
> Previous: 498 IOPS
> Kthread: 1000 IOPS
> fio --name=10mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
> Theoretical maximum: 100 IOPS
> Previous: 90 IOPS
> Kthread: 100 IOPS
> fio --name=10mswriteasync --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms --numjobs=32 --iodepth=64 --ioengine=libaio --group_reporting
> Previous: 13.3k IOPS
> Kthread: 13.3k IOPS
> (This one is just to prove the new design isn't impacting throughput,
> not really about delays)
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/md/dm-delay.c | 83 ++++++++++++-------------------------------
>  1 file changed, 22 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
> index 7433525e5985..a37f28294f7e 100644
> --- a/drivers/md/dm-delay.c
> +++ b/drivers/md/dm-delay.c
> @@ -13,6 +13,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/bio.h>
>  #include <linux/slab.h>
> +#include <linux/kthread.h>
>  
>  #include <linux/device-mapper.h>
>  
> @@ -26,11 +27,9 @@ struct delay_class {
>  };
>  
>  struct delay_c {
> -	struct timer_list delay_timer;
> -	struct mutex timer_lock;
> -	struct workqueue_struct *kdelayd_wq;
>  	struct work_struct flush_expired_bios;
>  	struct list_head delayed_bios;
> +	struct task_struct *worker;
>  	atomic_t may_delay;
>  
>  	struct delay_class read;
> @@ -48,42 +47,25 @@ struct dm_delay_info {
>  };
>  
>  static DEFINE_MUTEX(delayed_bios_lock);
> +static void flush_delayed_bios(struct delay_c *dc, int flush_all);
>  
> -static void handle_delayed_timer(struct timer_list *t)
> +static int flush_worker_fn(void *data)
>  {
> -	struct delay_c *dc = from_timer(dc, t, delay_timer);
> +	struct delay_c *dc = (struct delay_c *)data;

Cast shouldn't be needed.

> -	queue_work(dc->kdelayd_wq, &dc->flush_expired_bios);
> -}
> -
> -static void queue_timeout(struct delay_c *dc, unsigned long expires)
> -{
> -	mutex_lock(&dc->timer_lock);
> -
> -	if (!timer_pending(&dc->delay_timer) || expires < dc->delay_timer.expires)
> -		mod_timer(&dc->delay_timer, expires);
> -
> -	mutex_unlock(&dc->timer_lock);
> -}
> -
> -static void flush_bios(struct bio *bio)
> -{
> -	struct bio *n;
> -
> -	while (bio) {
> -		n = bio->bi_next;
> -		bio->bi_next = NULL;
> -		dm_submit_bio_remap(bio, NULL);
> -		bio = n;
> +	while (1) {
> +		flush_delayed_bios(dc, 0);
> +		if (unlikely(list_empty(&dc->delayed_bios)))
> +			set_current_state(TASK_INTERRUPTIBLE);
> +		schedule();

cond_resched() likely better?

>  	}
> +
> +	return 0;
>  }
>  
> -static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
> +static void flush_delayed_bios(struct delay_c *dc, int flush_all)

Feel free to switch flush_all to a bool.

>  {
>  	struct dm_delay_info *delayed, *next;
> -	unsigned long next_expires = 0;
> -	unsigned long start_timer = 0;
> -	struct bio_list flush_bios = { };
>  
>  	mutex_lock(&delayed_bios_lock);
>  	list_for_each_entry_safe(delayed, next, &dc->delayed_bios, list) {
> @@ -91,23 +73,12 @@ static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
>  			struct bio *bio = dm_bio_from_per_bio_data(delayed,
>  						sizeof(struct dm_delay_info));
>  			list_del(&delayed->list);
> -			bio_list_add(&flush_bios, bio);
> +			dm_submit_bio_remap(bio, NULL);
>  			delayed->class->ops--;
> -			continue;
>  		}
> -
> -		if (!start_timer) {
> -			start_timer = 1;
> -			next_expires = delayed->expires;
> -		} else
> -			next_expires = min(next_expires, delayed->expires);
>  	}
>  	mutex_unlock(&delayed_bios_lock);
>  
> -	if (start_timer)
> -		queue_timeout(dc, next_expires);
> -
> -	return bio_list_get(&flush_bios);
>  }
>  
>  static void flush_expired_bios(struct work_struct *work)
> @@ -115,24 +86,21 @@ static void flush_expired_bios(struct work_struct *work)
>  	struct delay_c *dc;
>  
>  	dc = container_of(work, struct delay_c, flush_expired_bios);
> -	flush_bios(flush_delayed_bios(dc, 0));
> +	flush_delayed_bios(dc, 0);
>  }
>  
>  static void delay_dtr(struct dm_target *ti)
>  {
>  	struct delay_c *dc = ti->private;
>  
> -	if (dc->kdelayd_wq)
> -		destroy_workqueue(dc->kdelayd_wq);
> -
>  	if (dc->read.dev)
>  		dm_put_device(ti, dc->read.dev);
>  	if (dc->write.dev)
>  		dm_put_device(ti, dc->write.dev);
>  	if (dc->flush.dev)
>  		dm_put_device(ti, dc->flush.dev);
> -
> -	mutex_destroy(&dc->timer_lock);
> +	if (dc->worker)
> +		kthread_stop(dc->worker);
>  
>  	kfree(dc);
>  }
> @@ -188,10 +156,11 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	}
>  
>  	ti->private = dc;
> -	timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
>  	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
>  	INIT_LIST_HEAD(&dc->delayed_bios);
> -	mutex_init(&dc->timer_lock);
> +	dc->worker = kthread_create(&flush_worker_fn, dc, "dm-delay-flush-worker");
> +	if (!dc->worker)
> +		goto bad;
>  	atomic_set(&dc->may_delay, 1);
>  	dc->argc = argc;
>  
> @@ -224,13 +193,6 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		goto bad;
>  
>  out:
> -	dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
> -	if (!dc->kdelayd_wq) {
> -		ret = -EINVAL;
> -		DMERR("Couldn't start kdelayd");
> -		goto bad;
> -	}
> -
>  	ti->num_flush_bios = 1;
>  	ti->num_discard_bios = 1;
>  	ti->accounts_remapped_io = true;
> @@ -260,7 +222,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
>  	list_add_tail(&delayed->list, &dc->delayed_bios);
>  	mutex_unlock(&delayed_bios_lock);
>  
> -	queue_timeout(dc, expires);
> +	wake_up_process(dc->worker);
>  
>  	return DM_MAPIO_SUBMITTED;
>  }
> @@ -270,8 +232,7 @@ static void delay_presuspend(struct dm_target *ti)
>  	struct delay_c *dc = ti->private;
>  
>  	atomic_set(&dc->may_delay, 0);
> -	del_timer_sync(&dc->delay_timer);
> -	flush_bios(flush_delayed_bios(dc, 1));
> +	flush_delayed_bios(dc, 1);
>  }
>  
>  static void delay_resume(struct dm_target *ti)
> -- 
> 2.34.1
> 
