Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21287FC2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjK1Q4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjK1Q4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:56:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83812D4F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:56:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C737FC433C7;
        Tue, 28 Nov 2023 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701190574;
        bh=OY8Ow22MyrAVlMRwF371bD3qmtjpS3+hhDNNRpCJdKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TI7N3S3KUs661mm3dASe/zGx52toUNAAkHDMpzBCiz8DEW/vqQKomWD3aanAbrW85
         T98u0NPMzpsiEPEUfwLYwFqle00plhbYOtvX6lFQdyZRPvoBFjsjB54VTM/Hxa4FIO
         btogyRh8y7cidA/7UmLGzL8B8EVZ94VvOiiunXLzkSKm7tkTVMxOs8ZidAW4zgXw/n
         8MVmuAKtsgu+eEMofEXAJ/jxDiQJKAQv+7bHPu5Wyn6FAfk9BBl/CKTVPSpQNDSY+3
         mgPI10b+cQ7ykyW4VQyrM/nYvUV8TfqdNz3F3nCCu1trbkmXUF3nsZDzGM2oCSlBX2
         Z/BZVP1FXvrkQ==
Date:   Tue, 28 Nov 2023 17:56:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peng Liu <pngliu@hotmail.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Subject: Re: [PATCH v2 1/2] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Message-ID: <ZWYbqwZrP+WfvT/N@lothringen>
References: <20231127083049.145447-1-pngliu@hotmail.com>
 <TYCP286MB21464DF5148B8FF8B142ADF7C6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB21464DF5148B8FF8B142ADF7C6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:23:54PM +0800, Peng Liu wrote:
> @@ -1529,7 +1519,9 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
>  
>  	return HRTIMER_RESTART;
>  }
> +#endif /* HIGH_RES_TIMERS */
>  
> +#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS

tick-sched.c is only ever built if CONFIG_TICK_ONESHOT=y and
CONFIG_TICK_ONESHOT is basically (CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS)

So probably the above is not needed and if you like you can even send
a subsequent patch removing such ifdefs within this file :-)

>  static int sched_skew_tick;
>  
>  static int __init skew_tick(char *str)
> @@ -1542,15 +1534,19 @@ early_param("skew_tick", skew_tick);
>  
>  /**
>   * tick_setup_sched_timer - setup the tick emulation timer
> + * @mode: tick_nohz_mode to setup for
>   */
> -void tick_setup_sched_timer(void)
> +void tick_setup_sched_timer(int mode)
>  {
>  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>  	ktime_t now = ktime_get();
>  
>  	/* Emulate tick processing via per-CPU hrtimers: */
>  	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> -	ts->sched_timer.function = tick_nohz_highres_handler;
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (mode == NOHZ_MODE_HIGHRES)
> +		ts->sched_timer.function = tick_nohz_highres_handler;
> +#endif

That ifdef could simply be removed.

>  
>  	/* Get the next period (per-CPU) */
>  	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
> @@ -1564,12 +1560,15 @@ void tick_setup_sched_timer(void)
>  	}

That invisible part above is the skew_tick thing, which can probably work
on low-res mode so why not but please tell about that in the changelog.

>  
>  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);

Looks like this can be hrtimer_forward_now() and you can remove the now.

> -	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
> -	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (mode == NOHZ_MODE_HIGHRES)
> +		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
> +	else
> +#endif

And probably that ifdef could simply be turned to
IS_ENABLED(CONFIG_HIGH_RES_TIMERS).

Thanks!
