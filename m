Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C576C54B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHBGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjHBGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:30:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89E26BA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:30:53 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qR5NY-0005Ti-RN; Wed, 02 Aug 2023 08:30:40 +0200
Message-ID: <51e3da0a-edee-a012-139c-f15feb67b973@pengutronix.de>
Date:   Wed, 2 Aug 2023 08:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: imx: composite-8m: avoid glitches when set_rate
 would be a no-op
Content-Language: en-US
To:     Peng Fan <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230801162731.3278396-1-a.fatoum@pengutronix.de>
 <092bddfa-ff9d-ab57-63ed-e6c0f2e9b550@oss.nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <092bddfa-ff9d-ab57-63ed-e6c0f2e9b550@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peng,

On 02.08.23 03:25, Peng Fan wrote:
> 
> 
> On 8/2/2023 12:27 AM, Ahmad Fatoum wrote:
>> Reconfiguring the clock divider to the exact same value is observed
>> on an i.MX8MN to often cause a short clock pause, probably because
>> the divider restarts counting from the time the register is written.
>>
>> This issue doesn't show up normally, because the clock framework will
>> take care to not call set_rate when the clock rate is the same.
>> However, when we configure an upstream clock (e.g. an audio_pll), the
>> common code will call set_rate with the newly calculated rate on all
>> children. As the new rate is different, we enter set_rate and compute
>> the same divider values, write them back and cause the glitch (e.g.
>> on a SAI's MCLK).
> 
> 
> The CCM root has glitch-free mux. When upstream pll freq change,
> the child set rate will also touch the mux bit, since div and mux
> in one register, so the mux logic will also function.
> 
> Per design, it is glitch free, so I not understand well why glitch.
> 
> When you configure pll, the downstream sai clk should still not be enabled, right?

  - sai5 is running normally and divides Audio PLL out by 16.
  - audio_pll1 is increased by 32 Hz -> only kdiv changes, so no glitch
  - imx8m_clk_composite_divider_set_rate(sai5) is called with
    32 / 16 = 2 Hz more
  - imx8m_clk_composite_divider_set_rate computes same divider as before
    and writes register
  - divider starts counting from zero, so we have a longer clock pause
    than usual, e.g. 40ns -> 125ns, external MCLK consumer doesn't like that at all.

So it's not a glitch in the transient high frequency sense, but rather a transient
low frequency period. I can reword the commit message to s/glitch/clock pause/
if you prefer.

And yes, if mux is switched, we will probably get the same clock pause, but
that is not a problem for me currently, because we don't switch parents except
at boot up. Afterwards, only PLL is tuned.

Cheers,
Ahmad

> 
> Thanks,
> Peng.
> 
>>
>> To avoid the glitch, we skip writing the same value back again.
>>
>> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>   drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
>> index cbf0d7955a00..3e9a092e136c 100644
>> --- a/drivers/clk/imx/clk-composite-8m.c
>> +++ b/drivers/clk/imx/clk-composite-8m.c
>> @@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>>       int prediv_value;
>>       int div_value;
>>       int ret;
>> -    u32 val;
>> +    u32 orig, val;
>>         ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
>>                           &prediv_value, &div_value);
>> @@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>>         spin_lock_irqsave(divider->lock, flags);
>>   -    val = readl(divider->reg);
>> -    val &= ~((clk_div_mask(divider->width) << divider->shift) |
>> -            (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
>> +    orig = readl(divider->reg);
>> +    val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
>> +               (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
>>         val |= (u32)(prediv_value  - 1) << divider->shift;
>>       val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
>> -    writel(val, divider->reg);
>> +
>> +    if (val != orig)
>> +        writel(val, divider->reg);
>>         spin_unlock_irqrestore(divider->lock, flags);
>>   
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

