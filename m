Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478767C752C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441914AbjJLRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441905AbjJLRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:53:34 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED69BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:53:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qzs9qaBPZq3uXqzs9qb9YD; Thu, 12 Oct 2023 19:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697133209;
        bh=tYjDKJtATrFkZwN78NGoARA2kvP+9YmLK58WWl0eTY8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jF5MfRztGNJ0gx25YJXDRvUKliknjhzKVUg+osO3fgTjr/e4ICXz6xMeIqlgBFY8/
         x3fB5VO5MgQ7QApc3X5Vi4UZW1jda2iRoWBJYh1ZkgvB3yC5P7j5vaVBbsj50lZkAn
         T0CHtik0yN9PNLdqP3FUDIm1Br9qGO8tp/DJZjQAY1uogX3yPKnpSMsxzkmeLV8E0p
         hX6g8seA4ThVE50PWYfxKv4pVqmQ/1xXj3D5KVQb3ssTnt1iS25pJ7zPH+V1xKOR/L
         jXIpn3BZcutLEXO+YJXyzznXlbG5Q7SF+dTxc+bUW2gcNVn1ey3YFDuD47LDcbtniz
         pxOh5NqRFhtUg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Oct 2023 19:53:29 +0200
X-ME-IP: 86.243.2.178
Message-ID: <338544e7-0be8-47c1-a7d7-89990da305d3@wanadoo.fr>
Date:   Thu, 12 Oct 2023 19:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] clocksource: Add JH7110 timer driver
To:     xingyu.wu@starfivetech.com
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, p.zabel@pengutronix.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        samin.guo@starfivetech.com, tglx@linutronix.de,
        walker.chen@starfivetech.com
References: <20231012081015.33121-1-xingyu.wu@starfivetech.com>
 <20231012081015.33121-3-xingyu.wu@starfivetech.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231012081015.33121-3-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/10/2023 à 10:10, Xingyu Wu a écrit :
> Add timer driver for the StarFive JH7110 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>

...

> +static int jh7110_timer_probe(struct platform_device *pdev)
> +{
> +	struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
> +	char name[4];
> +	struct clk *pclk;
> +	struct reset_control *rst;
> +	int ch;
> +	int ret;
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				     "failed to map registers\n");
> +
> +	rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
> +
> +	pclk = devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
> +				     "failed to get & enable apb clock\n");
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");

Hi,

I'm not very familiar with the reset_control_[de]assert() functions, but 
shouldn't this be undone by a reset_control_assert() call if an error 
occurs later?

> +
> +	for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
> +		clkevt[ch] = devm_kzalloc(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
> +		if (!clkevt[ch])
> +			return -ENOMEM;
> +
> +		snprintf(name, sizeof(name), "ch%d", ch);
> +
> +		clkevt[ch]->base = base + JH7110_TIMER_CH_BASE(ch);
> +		/* Ensure timer is disabled */
> +		jh7110_timer_disable(clkevt[ch]);
> +
> +		rst = devm_reset_control_get_exclusive(&pdev->dev, name);
> +		if (IS_ERR(rst))
> +			return PTR_ERR(rst);
> +
> +		clkevt[ch]->clk = devm_clk_get_enabled(&pdev->dev, name);
> +		if (IS_ERR(clkevt[ch]->clk))
> +			return PTR_ERR(clkevt[ch]->clk);
> +
> +		ret = reset_control_deassert(rst);
> +		if (ret)
> +			return ret;

Same here.

> +
> +		clkevt[ch]->evt.irq = platform_get_irq(pdev, ch);
> +		if (clkevt[ch]->evt.irq < 0)
> +			return clkevt[ch]->evt.irq;
> +
> +		snprintf(clkevt[ch]->name, sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
> +		jh7110_clockevents_register(clkevt[ch]);
> +
> +		ret = devm_request_irq(&pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
> +				       IRQF_TIMER | IRQF_IRQPOLL,
> +				       clkevt[ch]->name, &clkevt[ch]->evt);
> +		if (ret)
> +			return ret;
> +
> +		ret = jh7110_clocksource_init(clkevt[ch]);

Does something should be done if this fails?

CJ

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id jh7110_timer_match[] = {
> +	{ .compatible = "starfive,jh7110-timer", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
> +
> +static struct platform_driver jh7110_timer_driver = {
> +	.probe = jh7110_timer_probe,
> +	.driver = {
> +		.name = "jh7110-timer",
> +		.of_match_table = jh7110_timer_match,
> +	},
> +};
> +module_platform_driver(jh7110_timer_driver);
> +
> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>");
> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
> +MODULE_LICENSE("GPL");

