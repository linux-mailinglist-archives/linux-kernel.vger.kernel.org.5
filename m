Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8E7860C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbjHWTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjHWTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:38:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02FE60;
        Wed, 23 Aug 2023 12:38:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so7859625a12.0;
        Wed, 23 Aug 2023 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819512; x=1693424312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq991UMi93SvxAEUlvpzQ8KPcTTrf/+SzjBMpbrDAuE=;
        b=Wi/qhG6tPD4aWWf+ZXe8rkuem6kdG8gD3XJH5h/9Q+DmrtHZPSf0w1DeTPdaNtd7vZ
         kxoELZxqfqIqjZ63H5NRWGbTHyKL70hXrbYdPRzh7lWIUZseVn+Z8L7SdXTHPNilv9SV
         F1wVUc0wM/8uZvHtpYDOtlwByenL7mRYl0Iq2KChl9QWNe9KJ7TKQP5ItAGabc19l35v
         64Y7C59BgZ3qNoQ2xeQuXhH6I+O6LdQerNOhDJaM7aLM28yCTyHLqxero3os0niycdBH
         IMdclBCkum9s7XXkRec6UQHUgjMyHY1WUf0HBxJgwEe7uofCrk28EcHEBbyMV1Tm0sBM
         hmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819512; x=1693424312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq991UMi93SvxAEUlvpzQ8KPcTTrf/+SzjBMpbrDAuE=;
        b=lzofcmwAaGRaLE6QWWyqg5gKefd7NCekEqmk2qWc3/7amFYitW/mV3acaZkdDTBWSQ
         3Te9w03BwtVIJLB8jsGLUI45a4bq2NntxO/4oDNI09Et1e4iuQXPzTk6c4qenUdJeDa9
         QCpb4xC3X91x5iHsz4kRtETNPx9GkMnlMJS9aGqaasgpLbfefLf5j0UC02RcrKNKyNuz
         Vb2sbF8DhJr7XQK1AE3WEdnxGHQEf7B70I9yE/ngX9Hxaub+SpE4fycWlXy8e69aULQ8
         OSdYETjDL3M8o59FxeljKl6Z8AWayaPZF2mp61SfCcnTbcn/vFC8XnHKGnNbRBQwkhFk
         HAzQ==
X-Gm-Message-State: AOJu0Yy2X3WR0fX6KZCjFuEuY/XEgKmyz+Ehcl3Juc5hCo5hMUAi8mhb
        mcj0+Pma/0FvQzNMSNf+Vbw=
X-Google-Smtp-Source: AGHT+IHrbQ2XxSa298zOaPbVbfJsz7qc/J48gWuoAjGfAFXCtqqRiorEHwQ6qYK0J9IOBFeBLKh62A==
X-Received: by 2002:a05:6402:3447:b0:523:1004:1ca0 with SMTP id l7-20020a056402344700b0052310041ca0mr12620485edc.5.1692819512408;
        Wed, 23 Aug 2023 12:38:32 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0052a023e9b5dsm7182303edr.47.2023.08.23.12.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:38:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v2 2/3] thermal: sun8i: Add support for H616 THS controller
Date:   Wed, 23 Aug 2023 21:38:30 +0200
Message-ID: <21986607.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20230821-ths-h616-v2-2-cda60d556798@somainline.org>
References: <20230821-ths-h616-v2-0-cda60d556798@somainline.org>
 <20230821-ths-h616-v2-2-cda60d556798@somainline.org>
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

Dne ponedeljek, 21. avgust 2023 ob 16:03:47 CEST je Martin Botka napisal(a):
> Add support for the thermal sensor found in H616 SoC
> which slightly resembles the H6 thermal sensor
> controller with few changes like 4 sensors.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/thermal/sun8i_thermal.c | 74
> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..cf96ab6a445b 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -278,6 +278,66 @@ static int sun50i_h6_ths_calibrate(struct ths_device
> *tmdev, return 0;
>  }
> 
> +static int sun50i_h616_ths_calibrate(struct ths_device *tmdev,
> +				     u16 *caldata, int callen)
> +{
> +	struct device *dev = tmdev->dev;
> +	int i, ft_temp;
> +
> +	if (!caldata[0])
> +		return -EINVAL;
> +
> +	/*
> +	 * h616 efuse THS calibration data layout:
> +	 *
> +	 * 0      11  16     27   32     43   48    57
> +	 * +----------+-----------+-----------+-----------+
> +	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
> +	 * +----------+-----------+-----------+-----------+
> +	 *                      ^           ^           ^
> +	 *                      |           |           |
> +	 *                      |           |           sensor3[11:8]
> +	 *                      |           sensor3[7:4]
> +	 *                      sensor3[3:0]
> +	 *
> +	 * The calibration data on the H616 is the ambient temperature and
> +	 * sensor values that are filled during the factory test stage.
> +	 *
> +	 * The unit of stored FT temperature is 0.1 degree celsius.
> +	 */
> +	ft_temp = caldata[0] & FT_TEMP_MASK;
> +
> +	for (i = 0; i < tmdev->chip->sensor_num; i++) {
> +		int delta, cdata, offset, reg;
> +
> +		if (i == 3)
> +			reg = (caldata[1] >> 12)
> +			      | ((caldata[2] >> 12) << 4)
> +			      | ((caldata[3] >> 12) << 8);
> +		else
> +			reg = (int)caldata[i + 1] & TEMP_CALIB_MASK;
> +
> +		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, reg);

Variable declaration should be done at the beginning of code block.

Best regards,
Jernej

> +
> +		delta = (sensor_temp - ft_temp * 100) * 10;
> +		delta /= tmdev->chip->scale;
> +		cdata = CALIBRATE_DEFAULT - delta;
> +		if (cdata & ~TEMP_CALIB_MASK) {
> +			dev_warn(dev, "sensor%d is not calibrated.
\n", i);
> +
> +			continue;
> +		}
> +
> +		offset = (i % 2) * 16;
> +		regmap_update_bits(tmdev->regmap,
> +				   SUN50I_H6_THS_TEMP_CALIB + (i / 
2 * 4),
> +				   TEMP_CALIB_MASK << offset,
> +				   cdata << offset);
> +	}
> +
> +	return 0;
> +}
> +
>  static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  {
>  	struct nvmem_cell *calcell;
> @@ -608,6 +668,19 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
>  	.calc_temp = sun8i_ths_calc_temp,
>  };
> 
> +static const struct ths_thermal_chip sun50i_h616_ths = {
> +	.sensor_num = 4,
> +	.has_bus_clk_reset = true,
> +	.ft_deviation = 8000,
> +	.offset = 263655,
> +	.scale = 810,
> +	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +	.calibrate = sun50i_h616_ths_calibrate,
> +	.init = sun50i_h6_thermal_init,
> +	.irq_ack = sun50i_h6_irq_ack,
> +	.calc_temp = sun8i_ths_calc_temp,
> +};
> +
>  static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun8i-a83t-ths", .data = 
&sun8i_a83t_ths },
>  	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -616,6 +689,7 @@ static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun50i-a100-ths", .data = 
&sun50i_a100_ths },
>  	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths 
},
>  	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths 
},
> +	{ .compatible = "allwinner,sun50i-h616-ths", .data = 
&sun50i_h616_ths },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);




