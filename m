Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A97542C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjGNSoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjGNSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:44:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AC2D6B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:44:52 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403470df1d0so16077611cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689360291; x=1691952291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXgsyztGvrQDGInttz11MpkegRPbhEVsnjQCn4E5xz8=;
        b=LClR2IEPIfdcFRH2O8MWhXeLqVzGBbvpkNg5U3On9m1louG27BVa11zEhRUYlJ2MHC
         lUWKFIh0mCYglQpREsm3bEwchKhKKp59BelgMQrHj2tSUzpdErIf8d4JYPI4apPK3wz9
         6EWYIbRPIkefzgkyH4au4XvnhkIryqxj3fyEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360291; x=1691952291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXgsyztGvrQDGInttz11MpkegRPbhEVsnjQCn4E5xz8=;
        b=Z9gjarJE0TTtkOlcx+t2K76fkGl6kh2RT2V56Zlk3gqs+gcZl8/DWBuFDnS7b4K1q3
         D6tP6Mr0PXDMo48Fh2PEHW/0EIDyKw4y56WK01UMAEMJvohsZs8BblowSXriK7EBS4Ii
         SCLEIxefJCdNRFrwG+t4fwScrYbqPKaZby1xpLFEV0p8e+6Sb8Y1t6ba89c1gUwrmTqc
         gPD1YoeWvyq8xP8XOma2uwdZN6hmr4QZrRkXe/7Aq4bUQdYJtnmSeAXfRqSC883t0qSF
         /C4OGuCrKwNtcf9N059ZPHECo4lkkRxgX2E+dilvVI49pKTNg6gL5PANYCB4jJZQguCR
         wRmA==
X-Gm-Message-State: ABy/qLZcELp40WjDek+99UqT3v3AZpc73ryxNQ9y1O6NWu1SOL3ELiE1
        3ZovNhKcwYGvDVsGTzZyriuX5yWwxn80CBOJHXs=
X-Google-Smtp-Source: APBJJlEI5UE9K6C5xAqkX38d9X+5NAVAsAjDGGi0RjWBRtPGQVaF7oGXLdxlcAC837Yd0EdKH9MGTA==
X-Received: by 2002:a05:622a:1483:b0:3f5:16af:17db with SMTP id t3-20020a05622a148300b003f516af17dbmr4097489qtx.0.1689360291040;
        Fri, 14 Jul 2023 11:44:51 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id m15-20020aed27cf000000b003e0945575dasm4225763qtg.1.2023.07.14.11.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:44:50 -0700 (PDT)
Message-ID: <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
Date:   Fri, 14 Jul 2023 14:44:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-4-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230714120852.23573-4-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 08:08, Frederic Weisbecker wrote:
> In lowres dynticks mode, just like in highres dynticks mode, when there
> is no tick to program in the future, the tick eventually gets
> deactivated either:
> 
> * From the idle loop if in idle mode.
> * From the IRQ exit if in full dynticks mode.
> 
> Therefore there is no need to deactivate it from the tick itself. This
> just just brings more overhead in the idle tick path for no reason.
> 
> Fixes: 62c1256d5447 ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/time/tick-sched.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index dd25da8531f4..101251e103be 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1392,18 +1392,16 @@ static void tick_lowres_handler(struct clock_event_device *dev)
>   	tick_sched_do_timer(ts, now);
>   	tick_sched_handle(ts, regs);
>   
> -	if (unlikely(ts->tick_stopped)) {
> -		/*
> -		 * The clockevent device is not reprogrammed, so change the
> -		 * clock event device to ONESHOT_STOPPED to avoid spurious
> -		 * interrupts on devices which might not be truly one shot.
> -		 */
> -		tick_program_event(KTIME_MAX, 1);
> -		return;
> +	/*
> +	 * In dynticks mode, tick reprogram is deferred:
> +	 * - to the idle task if in dynticks-idle
> +	 * - to IRQ exit if in full-dynticks.
> +	 */
> +	if (likely(!ts->tick_stopped)) {
> +		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> +		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
>   	}
>   
> -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> -	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);

One slight concern here though, where in the idle loop is the removed statement 
"tick_program_event(KTIME_MAX, 1);" happening if the tick was already stopped 
before? If it is happening in tick_nohz_stop_tick(), don't we early return from 
there and avoid doing that "tick_program_event(KTIME_MAX, 1);" altogether, if 
the tick was already stopped and the next event has not changed?

         /* Skip reprogram of event if its not changed */
         if (ts->tick_stopped && (expires == ts->next_tick)) {
                 /* Sanity check: make sure clockevent is actually programmed */
                 if (tick == KTIME_MAX || ts->next_tick ==  [...]
                         return;
		[...]
	}

Also just a nit, here you can remove indent by doing:

if (unlikely(ts->tick_stopped))
     return;
hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);

Which is pretty much the original code except for the tick_program_event().

thanks,

  - Joel


>   }
>   
>   static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
> @@ -1508,7 +1506,11 @@ static enum hrtimer_restart tick_highres_handler(struct hrtimer *timer)
>   	else
>   		ts->next_tick = 0;
>   
> -	/* No need to reprogram if we are in idle or full dynticks mode */
> +	/*
> +	 * In dynticks mode, tick reprogram is deferred:
> +	 * - to the idle task if in dynticks-idle
> +	 * - to IRQ exit if in full-dynticks.
> +	 */
>   	if (unlikely(ts->tick_stopped))
>   		return HRTIMER_NORESTART;
>   

