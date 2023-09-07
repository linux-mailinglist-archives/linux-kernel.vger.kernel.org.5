Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B68797F35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjIGX16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjIGX14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:27:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9B3CF3;
        Thu,  7 Sep 2023 16:27:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02945FEC;
        Thu,  7 Sep 2023 16:28:29 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14B893F64C;
        Thu,  7 Sep 2023 16:27:47 -0700 (PDT)
Date:   Fri, 8 Sep 2023 00:26:36 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH v2 2/3] thermal: sun8i: Add support for H616 THS
 controller
Message-ID: <20230908002035.4a2d9be0@slackpad.lan>
In-Reply-To: <20230821-ths-h616-v2-2-cda60d556798@somainline.org>
References: <20230821-ths-h616-v2-0-cda60d556798@somainline.org>
        <20230821-ths-h616-v2-2-cda60d556798@somainline.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 16:03:47 +0200
Martin Botka <martin.botka@somainline.org> wrote:

Hi,

> Add support for the thermal sensor found in H616 SoC
> which slightly resembles the H6 thermal sensor
> controller with few changes like 4 sensors.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

So this doesn't work on both my OrangePi Zero3 and my X96 Mate, the
values reported are way too high. The kernel gets immediately upset
about the alleged >200C, and demands immediate shutdown.
Those are the values from hwmon on the X96 Mate:
/sys/class/hwmon/hwmon0/name:gpu_thermal
/sys/class/hwmon/hwmon0/temp1_input:220301
/sys/class/hwmon/hwmon1/name:ve_thermal
/sys/class/hwmon/hwmon1/temp1_input:219734
/sys/class/hwmon/hwmon2/name:cpu_thermal
/sys/class/hwmon/hwmon2/temp1_input:220868
/sys/class/hwmon/hwmon3/name:ddr_thermal
/sys/class/hwmon/hwmon3/temp1_input:221354
The raw values ranged from 0x273 till 0x294, with various values in
between. The reported temperatures on the OPi Zero3 were a bit lower,
but still around 200C.

The calibration data in the fuses seems to be meaningful, it says the
raw values are 0xb0f, 0xb18, 0xb14, 0xb1d for the four sensors, at an
ambient temperature of 27C. Those raw values would translate to about
34C/42C, so not completely off the scale.

This is as far as I dug today, maybe the sampling procedure is skewed,
so the ADC returns wrong values? Or the calibration write to the THS is
broken? Skipping that doesn't change the outcome significantly, though.

Open to any ideas or debugging suggestions!

Cheers,
Andre

> ---
>  drivers/thermal/sun8i_thermal.c | 74 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 195f3c5d0b38..cf96ab6a445b 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -278,6 +278,66 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>  	return 0;
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
> +
> +		delta = (sensor_temp - ft_temp * 100) * 10;
> +		delta /= tmdev->chip->scale;
> +		cdata = CALIBRATE_DEFAULT - delta;
> +		if (cdata & ~TEMP_CALIB_MASK) {
> +			dev_warn(dev, "sensor%d is not calibrated.\n", i);
> +
> +			continue;
> +		}
> +
> +		offset = (i % 2) * 16;
> +		regmap_update_bits(tmdev->regmap,
> +				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
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
>  	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
>  	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -616,6 +689,7 @@ static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
>  	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
>  	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> +	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);
> 

