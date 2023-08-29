Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0378C95F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjH2QLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjH2QLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0031B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A00D64093
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442B3C433C7;
        Tue, 29 Aug 2023 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693325473;
        bh=WESd26CM8l6Fl1FSwuMzzOGxHgpcYQhk+VTqf15cOd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPs7SxUDnWz2fJCB9+Eu1rnfX+LFGYo4ur6T6GiLFiPhUpDvZB5oeWzzQ3OyEifLz
         dlNxPaDmRnZciqx55OQgChfjkbMsLeGkJIAMVdlMTLeGHapEp8GaqPJxWRXr+ructn
         cLEufQc7eIiA310k6+coxHTt27sPXP8kIIEyYq5bdZJdrttcF5VgsfjVfN2jOy3+XP
         zoXaox2tHxhl5LrE90xY3/gRFOBtIHhTVOnjfHhHFIi1O02zXAbEcSh5ZDHHsDKCEE
         SO6KkCLYHaB5xNyk/FW37A7pA+kUxt8PomlEGynhz5dMv8qm1TICEuvE0QF/Lbrqin
         KClhy9lEaV3dw==
Date:   Tue, 29 Aug 2023 18:11:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Xueshi Hu <xueshi.hu@smartx.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz: remove unused
 tick_nohz_idle_stop_tick_protected()
Message-ID: <ZO4YlOWJS8sb62cS@lothringen>
References: <20230813131153.807850-1-xueshi.hu@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813131153.807850-1-xueshi.hu@smartx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 09:11:53PM +0800, Xueshi Hu wrote:
> All the caller has been removed since commit 336f560a8917 ("x86/xen: don't
> let xen_pv_play_dead() return")
> 
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>

Applied to my pending queue, thanks!

> ---
>  include/linux/tick.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 9459fef5b857..716d17f31c45 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -140,14 +140,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
>  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
> -
> -static inline void tick_nohz_idle_stop_tick_protected(void)
> -{
> -	local_irq_disable();
> -	tick_nohz_idle_stop_tick();
> -	local_irq_enable();
> -}
> -
>  #else /* !CONFIG_NO_HZ_COMMON */
>  #define tick_nohz_enabled (0)
>  static inline int tick_nohz_tick_stopped(void) { return 0; }
> @@ -170,8 +162,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>  }
>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> -
> -static inline void tick_nohz_idle_stop_tick_protected(void) { }
>  #endif /* !CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> -- 
> 2.40.1
> 
