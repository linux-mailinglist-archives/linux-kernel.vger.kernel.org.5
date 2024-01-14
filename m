Return-Path: <linux-kernel+bounces-25392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C410582CF89
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDEEB21709
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EC21854;
	Sun, 14 Jan 2024 03:12:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D51102;
	Sun, 14 Jan 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TCL1F23zBz4f3jpr;
	Sun, 14 Jan 2024 11:12:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 574361A08C8;
	Sun, 14 Jan 2024 11:12:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4iUaNl9_UYAw--.15255S3;
	Sun, 14 Jan 2024 11:12:35 +0800 (CST)
Subject: Re: [PATCH v4] md/raid5: fix atomicity violation in raid5_cache_count
To: Gui-Dong Han <2045gemini@gmail.com>, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240112071017.16313-1-2045gemini@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3c2951fb-a70f-d91f-c80c-64381d5e427a@huaweicloud.com>
Date: Sun, 14 Jan 2024 11:12:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240112071017.16313-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g4iUaNl9_UYAw--.15255S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDXryrJFyfArWfZF1kKrg_yoW7JF1kpF
	Z3u3WUXr48XwnYyrWDZr4kuFWfC398XFy7Jw47Xw1kZa9Y9FWIyw4xGry5Xry8J3y8GrZ2
	qF9093s5ur4ktrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/01/12 15:10, Gui-Dong Han Ð´µÀ:
> In raid5_cache_count():
>      if (conf->max_nr_stripes < conf->min_nr_stripes)
>          return 0;
>      return conf->max_nr_stripes - conf->min_nr_stripes;
> The current check is ineffective, as the values could change immediately
> after being checked.
> 
> In raid5_set_cache_size():
>      ...
>      conf->min_nr_stripes = size;
>      ...
>      while (size > conf->max_nr_stripes)
>          conf->min_nr_stripes = conf->max_nr_stripes;
>      ...
> 
> Due to intermediate value updates in raid5_set_cache_size(), concurrent
> execution of raid5_cache_count() and raid5_set_cache_size() may lead to
> inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
> The current checks are ineffective as values could change immediately
> after being checked, raising the risk of conf->min_nr_stripes exceeding
> conf->max_nr_stripes and potentially causing an integer overflow.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bugs
> including data races and atomicity violations. The above possible bug is
> reported when our tool analyzes the source code of Linux 6.2.
> 
> To resolve this issue, it is suggested to introduce local variables
> 'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
> values remain stable throughout the check. Adding locks in
> raid5_cache_count() fails to resolve atomicity violations, as
> raid5_set_cache_size() may hold intermediate values of
> conf->min_nr_stripes while unlocked. With this patch applied, our tool no
> longer reports the bug, with the kernel configuration allyesconfig for
> x86_64. Due to the lack of associated hardware, we cannot test the patch
> in runtime testing, and just verify it according to the code logic.
> 
> Fixes: edbe83ab4c27 ("md/raid5: allow the stripe_cache to grow and shrink.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> ---
> v2:
> * In this patch v2, we've updated to use READ_ONCE() instead of direct
> reads for accessing max_nr_stripes and min_nr_stripes, since read and
> write can concurrent.
>    Thank Yu Kuai for helpful advice.
> ---
> v3:
> * In this patch v3, we've updated to use WRITE_ONCE() in
> raid5_set_cache_size(), grow_one_stripe() and drop_one_stripe(), in order
> to pair READ_ONCE() with WRITE_ONCE().
>    Thank Yu Kuai for helpful advice.
> ---
> v4:
> * In this patch v4, we've addressed several code style issues.
>    Thank Yu Kuai for helpful advice.
> ---
>   drivers/md/raid5.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..30e118d10c0b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2412,7 +2412,7 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
>   	atomic_inc(&conf->active_stripes);
>   
>   	raid5_release_stripe(sh);
> -	conf->max_nr_stripes++;
> +	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
>   	return 1;
>   }
>   
> @@ -2707,7 +2707,7 @@ static int drop_one_stripe(struct r5conf *conf)
>   	shrink_buffers(sh);
>   	free_stripe(conf->slab_cache, sh);
>   	atomic_dec(&conf->active_stripes);
> -	conf->max_nr_stripes--;
> +	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);
>   	return 1;
>   }
>   
> @@ -6820,7 +6820,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>   	if (size <= 16 || size > 32768)
>   		return -EINVAL;
>   
> -	conf->min_nr_stripes = size;
> +	WRITE_ONCE(conf->min_nr_stripes, size);
>   	mutex_lock(&conf->cache_size_mutex);
>   	while (size < conf->max_nr_stripes &&
>   	       drop_one_stripe(conf))
> @@ -6832,7 +6832,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>   	mutex_lock(&conf->cache_size_mutex);
>   	while (size > conf->max_nr_stripes)
>   		if (!grow_one_stripe(conf, GFP_KERNEL)) {
> -			conf->min_nr_stripes = conf->max_nr_stripes;
> +			WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_stripes);
>   			result = -ENOMEM;
>   			break;
>   		}
> @@ -7390,11 +7390,13 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
>   				       struct shrink_control *sc)
>   {
>   	struct r5conf *conf = shrink->private_data;
> +	int max_stripes = READ_ONCE(conf->max_nr_stripes);
> +	int min_stripes = READ_ONCE(conf->min_nr_stripes);
>   
> -	if (conf->max_nr_stripes < conf->min_nr_stripes)
> +	if (max_stripes < min_stripes)
>   		/* unlikely, but not impossible */
>   		return 0;
> -	return conf->max_nr_stripes - conf->min_nr_stripes;
> +	return max_stripes - min_stripes;
>   }
>   
>   static struct r5conf *setup_conf(struct mddev *mddev)
> 


