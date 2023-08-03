Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21776DEA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHCDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHCDA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:00:57 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AACF10A;
        Wed,  2 Aug 2023 20:00:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EA21F24E225;
        Thu,  3 Aug 2023 11:00:48 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 11:00:49 +0800
Received: from [192.168.125.84] (183.27.98.54) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 11:00:47 +0800
Message-ID: <2ea68c95-1581-a67d-613b-5315fcfd0016@starfivetech.com>
Date:   Thu, 3 Aug 2023 11:00:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/3] ASoC: starfive: Add JH7110 PWM-DAC driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230731032829.127864-1-hal.feng@starfivetech.com>
 <20230731032829.127864-3-hal.feng@starfivetech.com>
 <b938ba84-38e9-b220-9686-6656e4452c10@linaro.org>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <b938ba84-38e9-b220-9686-6656e4452c10@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 09:06:10 +0200, Krzysztof Kozlowski wrote:
> On 31/07/2023 05:28, Hal Feng wrote:
>> Add PWM-DAC driver support for the StarFive JH7110 SoC.
>> 
> 
> 
> ...
> 
>> +static int jh7110_pwmdac_probe(struct platform_device *pdev)
>> +{
>> +	struct jh7110_pwmdac_dev *dev;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>> +	if (!dev)
>> +		return -ENOMEM;
>> +
>> +	dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(dev->base))
>> +		return PTR_ERR(dev->base);
>> +
>> +	dev->mapbase = res->start;
>> +
>> +	dev->clks[0].id = "apb";
>> +	dev->clks[1].id = "core";
>> +
>> +	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(dev->clks), dev->clks);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to get pwmdac clocks\n");
> 
> return dev_err_probe

OK, will fix.

> 
>> +		return ret;
>> +	}
>> +
>> +	dev->rst_apb = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>> +	if (IS_ERR(dev->rst_apb)) {
>> +		dev_err(&pdev->dev, "failed to get pwmdac apb reset\n");
>> +		return PTR_ERR(dev->rst_apb);
> 
> return dev_err_probe

Will fix.

> 
>> +	}
>> +
>> +	dev->dev = &pdev->dev;
>> +	dev->shift = PWMDAC_SHIFT_8;
>> +	dev->duty_cycle = PWMDAC_CYCLE_CENTER;
>> +	dev->cnt_n = PWMDAC_SAMPLE_CNT_1;
>> +	dev->data_change = NO_CHANGE;
>> +	dev->data_mode = INVERTER_DATA_MSB;
>> +	dev->data_shift = PWMDAC_DATA_LEFT_SHIFT_BIT_0;
>> +
>> +	dev_set_drvdata(&pdev->dev, dev);
>> +	ret = devm_snd_soc_register_component(&pdev->dev,
>> +					      &jh7110_pwmdac_component,
>> +					      &jh7110_pwmdac_dai, 1);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register dai\n");
>> +		return ret;
> 
> I guess here as well for consistency and shorter code even though
> EPROBE_DEFER does not happen really.
> 
> return dev_err_probe

Will fix.

> 
>> +	}
>> +
>> +	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register pcm\n");
>> +		return ret;
> 
> return dev_err_probe

Will fix. Thanks for your review.

Best regards,
Hal

> 
>> +	}
>> +

