Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C647C792FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbjIEU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbjIEU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:28:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9429FCC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:28:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c4923195dso444329066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945693; x=1694550493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkISZcLaqCZxGzyRWxa4TPreNR4hA2Z9elkk0qMjrxE=;
        b=btpnHmJUM7hY6u2giew2qjJ9bMLTGQwzAtBtvFF1vSUonK4aI/9QUfYQ41KKzRf/47
         JFm48dIXn08snuPqRSe7lIz63fqadN0nmIV1Jc3HmTvVgmqDpmsUE+XLPZ1It6wcMf99
         ooaSfLW67mapZe6AKXJsVVQeLLalAC2nDZRSGALPAwSssyLDUbVfWyp9LQwhi7ZJDNU5
         hOMTdKHf3dPr5rfMrHgv+8dGAW6+BrZis/XctLVcW4y5vR3lALnPuojk5giMZcQxMn2b
         7yPS2IQNoKaERjxQp8H3Gh6hNLSfYP2ELQce1VVfDp4pp3pyO3cyyp56seKS3mzNlHze
         Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945693; x=1694550493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkISZcLaqCZxGzyRWxa4TPreNR4hA2Z9elkk0qMjrxE=;
        b=XHXOxTPC0xixeyht2GgfOK61GKugacONDyTGyz0hcDN5EQ0pSCKungG52pMmVoM6Vc
         teNOjJhiD++NVYW29IhqGCd7ZeIgeZQa84appcXpv4WUflpKzaobsWwWD53NBLpDi58v
         ImZZymXV3I7gnFGDIH622KRR9q3ZXUUYzAcMAt49P9sCxjLKgcZBx3ltr3ZvM2cao71P
         XU3Mnf5gKF7ESq5FosNAwnn8xJL6jM6c2rHcCUqWyONAf1HnMLqZCxVQVzoyry1CFO4N
         2d8NU3bwlzYCD4FmFSwb5LAFJnc5SBzHYO13jUx0lxlUFESZrGy51IzWJFrAC2VUxIj2
         HcXg==
X-Gm-Message-State: AOJu0YxAdJSkXSo6+XtYYyRtgbv9CUsPILyyx8OF+zf8uMeLGLZf2Em2
        THWBRJABJam8dGvQLcHHqdo=
X-Google-Smtp-Source: AGHT+IF6SkBZrkt0MfXD24vq4uHSo5D0n0KrmybaRHQvRXQPwmcPTT2wuzyZqxKNPWedoaADhqDccQ==
X-Received: by 2002:a17:906:3153:b0:992:7295:61c9 with SMTP id e19-20020a170906315300b00992729561c9mr695139eje.69.1693945692504;
        Tue, 05 Sep 2023 13:28:12 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b00988be3c1d87sm8061384ejv.116.2023.09.05.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:28:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Matthew Croughan <matthew.croughan@nix.how>
Subject: Re: [PATCH v2] mfd: axp20x: Generalise handling without interrupt
Date:   Tue, 05 Sep 2023 22:28:10 +0200
Message-ID: <22003475.EfDdHjke4D@archlinux>
In-Reply-To: <20230828213229.20332-1-andre.przywara@arm.com>
References: <20230828213229.20332-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2023 11:32:29 PM CEST Andre Przywara wrote:
> At the moment we allow the AXP15060 and the AXP806 PMICs to omit the
> interrupt line to the SoC, and we skip registering the PEK (power key)
> driver in this case, since that crashes when no IRQ is described in the
> DT node.
> The IRQ pin potentially not being connected to anything does affect more
> PMICs, though, and the PEK driver is not the only one requiring an
> interrupt: at least the AC power supply driver crashes in a similar
> fashion.
> 
> Generalise the handling of AXP MFD devices when the platform tables
> describe no interrupt, by allowing each device to specify an alternative
> MFD list for this case. If no specific alternative is specified, we go
> with the safe default of "just the regulators", which matches the current
> situation.
> 
> This enables new devices using the AXP313a PMIC, but not connecting the
> IRQ pin.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v2 .. v1:
> - drop reordering approach, use separate cell lists
> 
>  drivers/mfd/axp20x.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index c03bc5cda080a..239e7f18956ae 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1133,6 +1133,8 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  	struct device *dev = axp20x->dev;
>  	const struct acpi_device_id *acpi_id;
>  	const struct of_device_id *of_id;
> +	const struct mfd_cell *cells_no_irq = NULL;
> +	int nr_cells_no_irq = 0;
> 
>  	if (dev->of_node) {
>  		of_id = of_match_device(dev->driver->of_match_table, 
dev);
> @@ -1207,14 +1209,15 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		 * if there is no interrupt line.
>  		 */
>  		if (of_property_read_bool(axp20x->dev->of_node,
> -					  "x-powers,self-
working-mode") &&
> -		    axp20x->irq > 0) {
> +					  "x-powers,self-
working-mode")) {
>  			axp20x->nr_cells = 
ARRAY_SIZE(axp806_self_working_cells);
>  			axp20x->cells = axp806_self_working_cells;
>  		} else {
>  			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
>  			axp20x->cells = axp806_cells;
>  		}
> +		nr_cells_no_irq = ARRAY_SIZE(axp806_cells);
> +		cells_no_irq = axp806_cells;
>  		axp20x->regmap_cfg = &axp806_regmap_config;
>  		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
>  		break;
> @@ -1238,24 +1241,8 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
>  		break;
>  	case AXP15060_ID:
> -		/*
> -		 * Don't register the power key part if there is no 
interrupt
> -		 * line.
> -		 *
> -		 * Since most use cases of AXP PMICs are Allwinner 
SOCs, board
> -		 * designers follow Allwinner's reference design and 
connects
> -		 * IRQ line to SOC, there's no need for those variants 
to deal
> -		 * with cases that IRQ isn't connected. However, 
AXP15660 is
> -		 * used by some other vendors' SOCs that didn't connect 
IRQ
> -		 * line, we need to deal with this case.
> -		 */
> -		if (axp20x->irq > 0) {
> -			axp20x->nr_cells = 
ARRAY_SIZE(axp15060_cells);
> -			axp20x->cells = axp15060_cells;
> -		} else {
> -			axp20x->nr_cells = 
ARRAY_SIZE(axp_regulator_only_cells);
> -			axp20x->cells = axp_regulator_only_cells;
> -		}
> +		axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
> +		axp20x->cells = axp15060_cells;
>  		axp20x->regmap_cfg = &axp15060_regmap_config;
>  		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
>  		break;
> @@ -1263,6 +1250,23 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x-
>variant);
>  		return -EINVAL;
>  	}
> +
> +	/*
> +	 * Use an alternative cell array when no interrupt line is 
connected,
> +	 * since IRQs are required by some drivers.
> +	 * The default is the safe "regulator-only", as this works fine 
without
> +	 * an interrupt specified.
> +	 */
> +	if (axp20x->irq <= 0) {
> +		if (cells_no_irq) {
> +			axp20x->nr_cells = nr_cells_no_irq;
> +			axp20x->cells = cells_no_irq;
> +		} else {
> +			axp20x->nr_cells = 
ARRAY_SIZE(axp_regulator_only_cells);
> +			axp20x->cells = axp_regulator_only_cells;

axp806_cells (old value for AXP806_ID without irq) and 
axp_regulator_only_cells differs in id field. Is that an issue?

Best regards,
Jernej

> +		}
> +	}
> +
>  	dev_info(dev, "AXP20x variant %s found\n",
>  		 axp20x_model_names[axp20x->variant]);




