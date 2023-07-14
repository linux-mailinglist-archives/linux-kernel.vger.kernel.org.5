Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726727534A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjGNIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjGNIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:07:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2D35BD;
        Fri, 14 Jul 2023 01:05:05 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 13DB680C7;
        Fri, 14 Jul 2023 16:05:03 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 16:05:03 +0800
Received: from [192.168.125.128] (183.27.98.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 16:05:01 +0800
Message-ID: <9a2f0aa0-ad7e-c12d-245d-5f80928705d6@starfivetech.com>
Date:   Fri, 14 Jul 2023 16:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v6 5/7] clk: starfive: jh7110-sys: Add PLL clocks
 source from DTS
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
 <20230704064610.292603-6-xingyu.wu@starfivetech.com>
 <CAJM55Z-OSmQCV6mO+SD4R2eU5gfx9TArSqDy+d-M2aer6bKL_A@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z-OSmQCV6mO+SD4R2eU5gfx9TArSqDy+d-M2aer6bKL_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.46]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 21:15, Emil Renner Berthing wrote:
> On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>
>> Modify PLL clocks source to be got from DTS or
>> the fixed factor clocks.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  drivers/clk/starfive/Kconfig                  |  1 +
>>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 45 +++++++++++--------
>>  2 files changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
>> index 5195f7be5213..978b78ec08b1 100644
>> --- a/drivers/clk/starfive/Kconfig
>> +++ b/drivers/clk/starfive/Kconfig
>> @@ -35,6 +35,7 @@ config CLK_STARFIVE_JH7110_SYS
>>         select AUXILIARY_BUS
>>         select CLK_STARFIVE_JH71X0
>>         select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
>> +       select CLK_STARFIVE_JH7110_PLL
>>         default ARCH_STARFIVE
>>         help
>>           Say yes here to support the system clock controller on the
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> index e6031345ef05..d56f48013388 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -7,6 +7,7 @@
>>   */
>>
>>  #include <linux/auxiliary_bus.h>
>> +#include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> @@ -386,6 +387,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>>
>>  static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>>  {
>> +       bool use_fixed_pll = true;      /* PLL clocks use fixed factor clocks or PLL driver */
> 
> nit: reverse christmas tree ordering, eg. move this below priv
> 
>>         struct jh71x0_clk_priv *priv;
>>         unsigned int idx;
>>         int ret;
>> @@ -402,28 +404,29 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>>         if (IS_ERR(priv->base))
>>                 return PTR_ERR(priv->base);
>>
>> -       /*
>> -        * These PLL clocks are not actually fixed factor clocks and can be
>> -        * controlled by the syscon registers of JH7110. They will be dropped
>> -        * and registered in the PLL clock driver instead.
>> -        */
>> +       if (!IS_ERR(devm_clk_get(priv->dev, "pll0_out")))
>> +               use_fixed_pll = false;  /* can get pll clocks from PLL driver */
> 
> The devm_clk_get() variant will allocate memory for a callback to call
> clk_put() when the driver is unloaded, but proper references
> associated with the consumers of the pll0_out clock are already taken
> below. So unless we find a better way to detect if the pll references
> are specified in the device tree or not, maybe something like this
> instead:
> 

Thanks. It looks more reasonable. I will follow it in next version.

> priv->pll[0] = clk_get(priv->dev, "pll0_out);

The priv->pll[] are clk_hw* struct no clk* struct and this could be failed
when building. So maybe use a temporary clk* struct.


> if (IS_ERR(priv->pll[0])) {
>   /* 24MHZ -> 1000.0MHz */
>   priv->pll[0] = ...
>   ...
> 
> } else {
>   clk_put(priv->pll[0]);
>   priv->pll[0] = NULL;

> 
>> +       /* Use fixed factor clocks if can not get the PLL clocks from DTS */
>> +       if (use_fixed_pll) {
>>         /* 24MHz -> 1000.0MHz */
> 
> These comments are not indented with the code, which just looks weird.

Will fix.

> 
>> -       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
>> -                                                        "osc", 0, 125, 3);
>> -       if (IS_ERR(priv->pll[0]))
>> -               return PTR_ERR(priv->pll[0]);
>> +               priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
>> +                                                                "osc", 0, 125, 3);
>> +               if (IS_ERR(priv->pll[0]))
>> +                       return PTR_ERR(priv->pll[0]);
>>
>>         /* 24MHz -> 1066.0MHz */
>> -       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
>> -                                                        "osc", 0, 533, 12);
>> -       if (IS_ERR(priv->pll[1]))
>> -               return PTR_ERR(priv->pll[1]);
>> +               priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
>> +                                                                "osc", 0, 533, 12);
>> +               if (IS_ERR(priv->pll[1]))
>> +                       return PTR_ERR(priv->pll[1]);
>>
>>         /* 24MHz -> 1188.0MHz */
>> -       priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
>> -                                                        "osc", 0, 99, 2);
>> -       if (IS_ERR(priv->pll[2]))
>> -               return PTR_ERR(priv->pll[2]);
>> +               priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
>> +                                                                "osc", 0, 99, 2);
>> +               if (IS_ERR(priv->pll[2]))
>> +                       return PTR_ERR(priv->pll[2]);
>> +       }
>>
>>         for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
>>                 u32 max = jh7110_sysclk_data[idx].max;
>> @@ -462,8 +465,14 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>>                                 parents[i].fw_name = "tdm_ext";
>>                         else if (pidx == JH7110_SYSCLK_MCLK_EXT)
>>                                 parents[i].fw_name = "mclk_ext";
>> -                       else
>> +                       else if (use_fixed_pll)
> 
> else if (priv->pll[0])

Will change.

> 
>>                                 parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
>> +                       else if (pidx == JH7110_SYSCLK_PLL0_OUT)
>> +                               parents[i].fw_name = "pll0_out";
>> +                       else if (pidx == JH7110_SYSCLK_PLL1_OUT)
>> +                               parents[i].fw_name = "pll1_out";
>> +                       else if (pidx == JH7110_SYSCLK_PLL2_OUT)
>> +                               parents[i].fw_name = "pll2_out";
>>                 }
>>
>>                 clk->hw.init = &init;
>> --
>> 2.25.1
>>

Best regards,
Xingyu Wu
