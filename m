Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9050807D63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441896AbjLGAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjLGAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:43:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BACD4B;
        Wed,  6 Dec 2023 16:44:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso126662b3a.0;
        Wed, 06 Dec 2023 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701909841; x=1702514641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyGPqsbyM+o/waC/snbt/Zuwaa3Q4YW9cnMRXpLc38I=;
        b=hCjvRBHKhDEeZUbPUpl4/cjWOS7wPCYRJ8/ihKv1S/ehtQ4+Erzi7hFs5H5oQAx+vP
         b5481IVk4jSFCC0J2smQLnIEDuqtGeH6NYCZjUUsBlVCpgJUN8jJWjYW69B6LRm+4Gpg
         WkFTWGPM5Ocnob2/gR+G32yKvmVInveofisaRiW4J4eHULheN1wFyfgX9MGFSaimovT6
         idxlepn4EjcKaB8Rl25W47SkMhPeMkBr6dmgNdHANwxy2LcJHFqcmGRO1Z5mjKNDDXtk
         kgBZdxh6k/77Io0BtOwetfMtiiGuqs5d2sk8gSUqkOFw+BV33lZTYNB6CvadpCefT6vV
         5kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909841; x=1702514641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyGPqsbyM+o/waC/snbt/Zuwaa3Q4YW9cnMRXpLc38I=;
        b=MmJ4bVYwDOSdRahdLWdWIeqOPgmJRoBSx1Z/xpvtdW1IfbglVNYE6DYj3APNO9YoJE
         ekxlZToPPv03YKvN0i/CgzqoAVcQlEk4+Vq28xgZsPBo1YrYP1vWZ7nKXbuKsgaQNN2j
         Fj/vWzItm3/rct9a7axRDbl8qT76CGdmo98eXRF9rNhvzBhFSfek/qrUpaMczc9CPGE5
         tleQa9VEJLoCcnuPlK+9GG0R7mN0RHrCjQedVaEfL8ZppAjT9MUmw8WSRMgleZK6ejqv
         PB+0N7bTGyZSlqItUiPAtxYu7+0Ab67DRVpDODksPBMsFtw/tlmDaD2zBTMX4EUIoiky
         8zZA==
X-Gm-Message-State: AOJu0Yx2mxEZLyYZnPX4eLK+mf3DNRKw235fd0eqFgsWvMUpHktb8jPQ
        23Sjcny5LQoafGZxdjxI10WzEUi3YfQjSw==
X-Google-Smtp-Source: AGHT+IEnwNUCMDTgXHQpgn/W2yuZcnEzZR3jkgKOSL28Lu5yXG+RTr5nf40kOUZcgJ4J0tto9yQozw==
X-Received: by 2002:a05:6a00:b87:b0:6ce:6b7c:ba41 with SMTP id g7-20020a056a000b8700b006ce6b7cba41mr2046931pfj.64.1701909841025;
        Wed, 06 Dec 2023 16:44:01 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b006cbe1bb5e3asm114399pfo.138.2023.12.06.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:44:00 -0800 (PST)
Date:   Wed, 6 Dec 2023 16:41:44 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
Message-ID: <ZXEUyH/38KeATuF4@yury-ThinkPad>
References: <20231120083559.285174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120083559.285174-1-ming.lei@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Mon, Nov 20, 2023 at 04:35:59PM +0800, Ming Lei wrote:
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
> 
> Then dead lock is caused:
> 
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
> 
> 2) error handler is waiting for CPU hotplug lock
> 
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
> 
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/group_cpus.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index aa3f6815bb12..ee272c4cefcc 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -366,13 +366,25 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>  
> -	/* Stabilize the cpumasks */
> -	cpus_read_lock();
>  	build_node_to_cpumask(node_to_cpumask);
>  
> +	/*
> +	 * Make a local cache of 'cpu_present_mask', so the two stages
> +	 * spread can observe consistent 'cpu_present_mask' without holding
> +	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
> +	 * hotplug code.
> +	 *
> +	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
> +	 * we can live with the case because it only affects that hotplug
> +	 * CPU is handled in the 1st or 2nd stage, and either way is correct
> +	 * from API user viewpoint since 2-stage spread is sort of
> +	 * optimization.
> +	 */
> +	cpumask_copy(npresmsk, data_race(cpu_present_mask));

Now that you initialize the npresmsk explicitly, you can allocate it
using alloc_cpumask_var().

The same actually holds for nmsk too, and even before this patch. Maybe
fix it in a separate prepending patch?

> +
>  	/* grouping present CPUs first */
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  cpu_present_mask, nmsk, masks);
> +				  npresmsk, nmsk, masks);
>  	if (ret < 0)
>  		goto fail_build_affinity;
>  	nr_present = ret;
> @@ -387,15 +399,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		curgrp = 0;
>  	else
>  		curgrp = nr_present;
> -	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>  				  npresmsk, nmsk, masks);

The first thing the helper does is checking if nprepmask is empty.
cpumask_andnot() returns false in that case. So, assuming that present
cpumask in the previous call can't be empty, we can save few cycles if
drop corresponding check in the helper and do like this:
        
	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk) == 0) {
                nr_others = 0;
                goto fail_build_affinity;
        }

  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
  				  npresmsk, nmsk, masks);

Although, it's not related to this patch directly. So, if you fix
zalloc_cpumask_var(), the patch looks good to me.

Reviewed-by: Yury Norov <yury.norov@gmail.com>

>  	if (ret >= 0)
>  		nr_others = ret;
>  
>   fail_build_affinity:
> -	cpus_read_unlock();
> -
>  	if (ret >= 0)
>  		WARN_ON(nr_present + nr_others < numgrps);
>  
> -- 
> 2.41.0
> 
