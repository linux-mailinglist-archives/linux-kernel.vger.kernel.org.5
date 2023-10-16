Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E519D7CA435
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjJPJda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:33:28 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6624AB;
        Mon, 16 Oct 2023 02:33:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4B68B24E43C;
        Mon, 16 Oct 2023 17:33:17 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 17:33:17 +0800
Received: from [192.168.125.131] (183.27.98.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 17:33:16 +0800
Message-ID: <d127c7ff-8883-4069-9cc9-407be1b6feaf@starfivetech.com>
Date:   Mon, 16 Oct 2023 17:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <aou@eecs.berkeley.edu>, <conor@kernel.org>,
        <daniel.lezcano@linaro.org>, <devicetree@vger.kernel.org>,
        <emil.renner.berthing@canonical.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <p.zabel@pengutronix.de>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <samin.guo@starfivetech.com>, <tglx@linutronix.de>,
        <walker.chen@starfivetech.com>
References: <20231012081015.33121-1-xingyu.wu@starfivetech.com>
 <20231012081015.33121-3-xingyu.wu@starfivetech.com>
 <338544e7-0be8-47c1-a7d7-89990da305d3@wanadoo.fr>
 <926ee8c7-fab9-49d5-831e-48c886c4bc44@starfivetech.com>
 <276ed249-9ee8-4dc9-871f-9c449eb00bcf@wanadoo.fr>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <276ed249-9ee8-4dc9-871f-9c449eb00bcf@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/14 2:02, Christophe JAILLET wrote:
> Le 13/10/2023 à 11:34, Xingyu Wu a écrit :
>> On 2023/10/13 1:53, Christophe JAILLET wrote:
>>> Le 12/10/2023 à 10:10, Xingyu Wu a écrit :
>>>> Add timer driver for the StarFive JH7110 SoC.
>>>>
>>>> Signed-off-by: Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg-XMD5yJDbdMStu3cLTcvVIw@public.gmane.orge.org>
>>>
>>> ...
>>
>> It looks normal in my email and the web. Is this due to some settings?
> 
> Hi,
> 
> I use gmane.org and a news reader (Thunderbird).
> Gmane sometimes (not always!) obfuscate e-mail addresses.
> 
> Do not pay attantion to these strange rewritten addresses.
> 
>>
>>>
>>>> +static int jh7110_timer_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
>>>> +    char name[4];
>>>> +    struct clk *pclk;
>>>> +    struct reset_control *rst;
>>>> +    int ch;
>>>> +    int ret;
>>>> +    void __iomem *base;
>>>> +
>>>> +    base = devm_platform_ioremap_resource(pdev, 0);
>>>> +    if (IS_ERR(base))
>>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(base),
>>>> +                     "failed to map registers\n");
>>>> +
>>>> +    rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
>>>> +    if (IS_ERR(rst))
>>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
>>>> +
>>>> +    pclk = devm_clk_get_enabled(&pdev->dev, "apb");
>>>> +    if (IS_ERR(pclk))
>>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>>>> +                     "failed to get & enable apb clock\n");
>>>> +
>>>> +    ret = reset_control_deassert(rst);
>>>> +    if (ret)
>>>> +        return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");
>>>
>>> Hi,
>>>
>>> I'm not very familiar with the reset_control_[de]assert() functions, but shouldn't this be undone by a reset_control_assert() call if an error occurs later?
>>
>> In this case, the reset controller is set from 'assert' state to 'deassert' state. If it is failed and still 'assert' state, I don't think it need to call reset_control_assert().
> 
> Emil already explained what I meaned (sorry for not being clear enough).
> I do agree with his proposed approach.
> 
>>
>>>
>>>> +
>>>> +    for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
>>>> +        clkevt[ch] = devm_kzalloc(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
>>>> +        if (!clkevt[ch])
>>>> +            return -ENOMEM;
>>>> +
>>>> +        snprintf(name, sizeof(name), "ch%d", ch);
>>>> +
>>>> +        clkevt[ch]->base = base + JH7110_TIMER_CH_BASE(ch);
>>>> +        /* Ensure timer is disabled */
>>>> +        jh7110_timer_disable(clkevt[ch]);
>>>> +
>>>> +        rst = devm_reset_control_get_exclusive(&pdev->dev, name);
>>>> +        if (IS_ERR(rst))
>>>> +            return PTR_ERR(rst);
>>>> +
>>>> +        clkevt[ch]->clk = devm_clk_get_enabled(&pdev->dev, name);
>>>> +        if (IS_ERR(clkevt[ch]->clk))
>>>> +            return PTR_ERR(clkevt[ch]->clk);
>>>> +
>>>> +        ret = reset_control_deassert(rst);
>>>> +        if (ret)
>>>> +            return ret;
>>>
>>> Same here.
>>>
>>>> +
>>>> +        clkevt[ch]->evt.irq = platform_get_irq(pdev, ch);
>>>> +        if (clkevt[ch]->evt.irq < 0)
>>>> +            return clkevt[ch]->evt.irq;
>>>> +
>>>> +        snprintf(clkevt[ch]->name, sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
>>>> +        jh7110_clockevents_register(clkevt[ch]);
>>>> +
>>>> +        ret = devm_request_irq(&pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
>>>> +                       IRQF_TIMER | IRQF_IRQPOLL,
>>>> +                       clkevt[ch]->name, &clkevt[ch]->evt);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +
>>>> +        ret = jh7110_clocksource_init(clkevt[ch]);
>>>
>>> Does something should be done if this fails?
>>>
>>> CJ
>>
>> Yes, it should be call reset_control_assert() here and I will add it in next version.
> 
> My point was for the above reset_control_assert() but also for the resources allocated within this for loop.
> 
> I have not checked all paths, but in case of error in the probe:
>   - There is another reset_control_deassert()
> 
>   - jh7110_clocksource_init() --> jh7110_timer_int_init_enable() --> jh7110_timer_enable()
>     Should jh7110_timer_disable() be called?
> 
>   - jh7110_clocksource_init() --> clocksource_register_hz().
>     Should clocksource_unregister() be called?
> 
> If I'm correct and depending on how you update the code, a .remove function may be needed as well.
> 
> CJ
> 

Great. I'm going to add a action which Emil had said to do this job when remove or make the error in the loop. 

Thanks,
Xingyu Wu

>>
>>>
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id jh7110_timer_match[] = {
>>>> +    { .compatible = "starfive,jh7110-timer", },
>>>> +    { /* sentinel */ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
>>>> +
>>>> +static struct platform_driver jh7110_timer_driver = {
>>>> +    .probe = jh7110_timer_probe,
>>>> +    .driver = {
>>>> +        .name = "jh7110-timer",
>>>> +        .of_match_table = jh7110_timer_match,
>>>> +    },
>>>> +};
>>>> +module_platform_driver(jh7110_timer_driver);
>>>> +
>>>> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg-XMD5yJDbdMRS5n6/RkiaJA@public.gmane.orgne.org>");
>>>> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
>>>> +MODULE_LICENSE("GPL");
>>>
>>
>> Thanks,
>> Xingyu Wu
>>
>>
>>
> 

