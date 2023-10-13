Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F97C82ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJMKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:23:18 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F4AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:23:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78AAF1C000C;
        Fri, 13 Oct 2023 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697192593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grez1VavYsE8MeA1IyNendydX2wgr+/XkRXEEiQMhPE=;
        b=P4TYh65Ey9FWFljdN827vHBiv82oNaQU/KwHOC6ExB4/2CkCywQqA9G0nK5m1r6M8A0w5t
        31KHkEzInug/HgPxlrhRXycEapLG1EU/pAGcQMWK3IwfZoyzo8OJxAnGDSvphPUPQAd8dR
        NeMxmgn0ApO5EdzG7YVY0sEMdCUqDHp2IKPyAtN2Z6jWIa0hfGIiyzqUcCM60JnutakDaD
        2WdcuFozW3PLuLXkVL5O91zmt59qEIq/pAun2Bq3Axxgb85/3IvCWQ6FdYDd39LVa1weXE
        mVTfQvusuRMk+1unUQ4kQega5iBvATGTkeSB//6arL9sUF4YAj9jGwOxYNKbDA==
Date:   Fri, 13 Oct 2023 12:23:11 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [RESEND][PATCH] clocksource/drivers/timer-atmel-tcb: Fix
 initialization on SAM9 hardware
Message-ID: <20231013102311929c3fab@mail.local>
References: <20231007161803.31342-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007161803.31342-1-rwahl@gmx.de>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 18:17:13+0200, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> On SAM9 hardware two cascaded 16 bit timers are used to form a 32 bit
> high resolution timer that is used as scheduler clock when the kernel
> has been configured that way (CONFIG_ATMEL_CLOCKSOURCE_TCB).
> 
> The driver initially triggers a reset-to-zero of the two timers but this
> reset is only performed on the next rising clock. For the first timer
> this is ok - it will be in the next 60ns (16MHz clock). For the chained
> second timer this will only happen after the first timer overflows, i.e.
> after 2^16 clocks (~4ms with a 16MHz clock). So with other words the
> scheduler clock resets to 0 after the first 2^16 clock cycles.
> 
> It looks like that the scheduler does not like this and behaves wrongly
> over its lifetime, e.g. some tasks are scheduled with a long delay. Why
> that is and if there are additional requirements for this behaviour has
> not been further analysed.
> 
> There is a simple fix for resetting the second timer as well when the
> first timer is reset and this is to set the ATMEL_TC_ASWTRG_SET bit in
> the Channel Mode register (CMR) of the first timer. This will also rise
> the TIOA line (clock input of the second timer) when a software trigger
> respective SYNC is issued.
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clocksource/timer-atmel-tcb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
> index 27af17c99590..2a90c92a9182 100644
> --- a/drivers/clocksource/timer-atmel-tcb.c
> +++ b/drivers/clocksource/timer-atmel-tcb.c
> @@ -315,6 +315,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
>  	writel(mck_divisor_idx			/* likely divide-by-8 */
>  			| ATMEL_TC_WAVE
>  			| ATMEL_TC_WAVESEL_UP		/* free-run */
> +			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
>  			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
>  			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
>  			tcaddr + ATMEL_TC_REG(0, CMR));
> --
> 2.41.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
