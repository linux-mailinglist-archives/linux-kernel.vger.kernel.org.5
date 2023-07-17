Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90212755F22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGQJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:22:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9710E4;
        Mon, 17 Jul 2023 02:22:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FF9C6606FFD;
        Mon, 17 Jul 2023 10:22:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689585725;
        bh=7gRjXBVr85XdEEIoKcWzUs1N18XJiB4V4nRdZKFEIPM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZWZoyUPtIdA6D/Sgu/sDHAYDbIyQ/Lr/wERrFpmc4fyu1uU7Z2VLj6/Z1W/Bv6JIK
         Rw/7Mxy3QgX5+PRUaSeykfdGnplf1qp+mFYtg8xm4w2tvrSqfK6LONhbkl7FFqKJHi
         hKc+K81aeoKD2RpKYDDW/tc/dxdcD7xuUFVJI1d1qJMNJCgPN/g7Awb9asKaAup99l
         7dPhg07JqJvVK5Ok9m17T4U8cVHj4DkKXB1Wb3lx/BRjocC8/SJrHEPapLHh6js5Pm
         fuRBM/06iPodRm0Zj17hZo/y28ClpndjJkagXbbW43CNvBFJksF82BR2/te55/cAwc
         QeyNpon2QhM8Q==
Message-ID: <c45cf91e-60fa-c17e-2ec9-bdd7dd64d2dd@collabora.com>
Date:   Mon, 17 Jul 2023 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Disable timer before
 programming CVAL
Content-Language: en-US
To:     walter.chang@mediatek.com, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230717090735.19370-1-walter.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717090735.19370-1-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/07/23 11:07, walter.chang@mediatek.com ha scritto:
> From: Walter Chang <walter.chang@mediatek.com>
> 
> Due to the fact that the use of `writeq_relaxed()` to program CVAL is
> not guaranteed to be atomic, it is necessary to disable the timer before
> programming CVAL.
> 
> However, if the MMIO timer is already enabled and has not yet expired,
> there is a possibility of unexpected behavior occurring: when the CPU
> enters the idle state during this period, and if the CPU's local event
> is earlier than the broadcast event, the following process occurs:
> 
> tick_broadcast_enter()
>    tick_broadcast_oneshot_control(TICK_BROADCAST_ENTER)
>      __tick_broadcast_oneshot_control()
>        ___tick_broadcast_oneshot_control()
>          tick_broadcast_set_event()
>            clockevents_program_event()
>              set_next_event_mem()
> 
> During this process, the MMIO timer remains enabled while programming
> CVAL. To prevent such behavior, disable timer explicitly prior to
> programming CVAL.
> 
> Fixes: 8b82c4f883a7 ("clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Walter Chang <walter.chang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/clocksource/arm_arch_timer.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index e733a2a1927a..7dd2c615bce2 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -792,6 +792,13 @@ static __always_inline void set_next_event_mem(const int access, unsigned long e
>   	u64 cnt;
>   
>   	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
> +
> +	/* Timer must be disabled before programming CVAL */
> +	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
> +		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
> +		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> +	}
> +
>   	ctrl |= ARCH_TIMER_CTRL_ENABLE;
>   	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
>   

