Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E17BCD7D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjJHJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjJHJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:22:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761ECA;
        Sun,  8 Oct 2023 02:22:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 58F5F24E2A4;
        Sun,  8 Oct 2023 17:22:28 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 8 Oct
 2023 17:22:25 +0800
Received: from [192.168.125.131] (183.27.97.165) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 8 Oct
 2023 17:22:24 +0800
Message-ID: <5efe573f-238b-778e-58a3-a3f8c04f71eb@starfivetech.com>
Date:   Sun, 8 Oct 2023 17:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230821152915.208366-1-xingyu.wu@starfivetech.com>
 <CAJM55Z_XxHeC-X2d4qcsRK6THLyqWV4SsSW3S+cC8yszpPD9Og@mail.gmail.com>
 <07ddac3c-eb6e-d187-b942-102f117f8d13@starfivetech.com>
 <CAJM55Z-gYpn_FjG2Zb__Nt=rbrNQN8QDNB=KEFdeVkz9Ptv72Q@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z-gYpn_FjG2Zb__Nt=rbrNQN8QDNB=KEFdeVkz9Ptv72Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.165]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/22 16:56, Emil Renner Berthing wrote:
> On Tue, 22 Aug 2023 at 05:33, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>> On 2023/8/21 23:38, Emil Renner Berthing wrote:
>> > On Mon, 21 Aug 2023 at 17:29, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>> >>
>> >> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
>> >> But now PLL0 rate is 1GHz and the cpu frequency loads become
>> >> 333/500/500/1000MHz in fact.
>> >>
>> >> So PLL0 rate should be set to 1.5GHz. Change the parent of cpu_root clock
>> >> and the divider of cpu_core before the setting.
>> >>
>> >> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> >> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
>> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> ---
>> >>
>> >> Hi Stephen and Emil,
>> >>
>> >> This patch fixes the issue about lower rate of CPUfreq[1]
>> >> and sets PLL0 rate to 1.5GHz. In order not to affect the cpu
>> >> operation, the cpu_root's parent clock should be changed first.
>> >> And the divider of the cpu_core clock should be set to 2 so they
>> >> won't crash when setting 1.5GHz without voltage regulation.
>> >
>> > Hi Xingyu,
>> >
>> > It sounds like this is something the driver should handle
>> > automatically whenever clk_set_rate() is called on the PLL0 clock.
>> > Then we should be able to use regular assigned-clocks /
>> > assigned-clock-rates stanzas in the device tree instead of having this
>> > 1.5GHz rate hard-coded in the driver.
>> >
>> > /Emil
>>
>> Hi Emil,
>>
>> The frequency of PLL0 is set according to this process to avoid crash:
>> 1. The divider of the cpu_core clock should be set to 2 if PLL0 is set to 1.5GHz.
>> 2. The parent of cpu_root is changed from pll0 to osc.
>> 3. The PLL0 is set to 1.5GHz.
>> 4. The parent of cpu_root is changed from osc to pll0 back.
>> I don't think assigned-clock-rates/assigned-clock-parents can do such a complicated job.
> 
> Right, but what I'm saying is that if calling clk_set_rate() on the
> PLL0 clock causes a crash, that sounds like a bug in the driver. If
> you fix that bug, and make clk_set_rate() on the PLL0 clock do the
> procedure above when changing the rate, then the PLL0 clock can work
> just like any other clock and assigned-clock-rates would work.
> 
> /Emil

Yeah, if fix this bug, I should add there steps when setting rate in the PLL clock driver. But how to get and use the clocks of cpu_root and cpu_core in the PLL driver? It seem to be only two ways, clk_get() or ioremap(). If use clk_get(), the pll node should add syscrg clocks. It shows that the PLL driver depends on the SYSCRG driver, which seems confusing because normally the syscrg depends on the pll. Do you have a better suggestion?

Thanks.
Xingyu Wu

> 
>> >
>> >> [1]: https://github.com/starfive-tech/VisionFive2/issues/55
>> >>
>> >> This patch is based on linux-next(20230818) which has merge PLL driver
>> >> on the StarFive JH7110 SoC.
>> >>
>> >> Thanks,
>> >> Xingyu Wu
>> >>
>> >> ---
>> >>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 47 ++++++++++++++++++-
>> >>  1 file changed, 46 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> >> index 3884eff9fe93..b6b9e967dfc7 100644
>> >> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> >> @@ -501,7 +501,52 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>> >>         if (ret)
>> >>                 return ret;
>> >>
>> >> -       return jh7110_reset_controller_register(priv, "rst-sys", 0);
>> >> +       ret = jh7110_reset_controller_register(priv, "rst-sys", 0);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       /*
>> >> +        * Set PLL0 rate to 1.5GHz
>> >> +        * In order to not affect the cpu when the PLL0 rate is changing,
>> >> +        * we need to switch the parent of cpu_root clock to osc clock first,
>> >> +        * and then switch back after setting the PLL0 rate.
>> >> +        */
>> >> +       pllclk = clk_get(priv->dev, "pll0_out");
>> >> +       if (!IS_ERR(pllclk)) {
>> >> +               struct clk *osc = clk_get(&pdev->dev, "osc");
>> >> +               struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
>> >> +               struct clk *cpu_core = priv->reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
>> >> +
>> >> +               if (IS_ERR(osc)) {
>> >> +                       clk_put(pllclk);
>> >> +                       return PTR_ERR(osc);
>> >> +               }
>> >> +
>> >> +               /*
>> >> +                * CPU need voltage regulation by CPUfreq if set 1.5GHz.
>> >> +                * So in this driver, cpu_core need to be set the divider to be 2 first
>> >> +                * and will be 750M after setting parent.
>> >> +                */
>> >> +               ret = clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
>> >> +               if (ret)
>> >> +                       goto failed_set;
>> >> +
>> >> +               ret = clk_set_parent(cpu_root, osc);
>> >> +               if (ret)
>> >> +                       goto failed_set;
>> >> +
>> >> +               ret = clk_set_rate(pllclk, 1500000000);
>> >> +               if (ret)
>> >> +                       goto failed_set;
>> >> +
>> >> +               ret = clk_set_parent(cpu_root, pllclk);
>> >> +
>> >> +failed_set:
>> >> +               clk_put(pllclk);
>> >> +               clk_put(osc);
>> >> +       }
>> >> +
>> >> +       return ret;
>> >>  }
>> >>
>> >>  static const struct of_device_id jh7110_syscrg_match[] = {
>> >> --
>> >> 2.25.1
>> >>
>>

