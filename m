Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E31780A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjHRKzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376471AbjHRKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:55:02 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BB121
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:55:00 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0A6A91F7FB;
        Fri, 18 Aug 2023 12:54:54 +0200 (CEST)
Date:   Fri, 18 Aug 2023 12:54:48 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 2/3] thermal: sun8i: Add support for H616 THS controller
To:     Andre Przywara <andre.przywara@arm.com>
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
Message-Id: <CB2LZR.1KPTPXNXKA5H3@somainline.org>
In-Reply-To: <20230818112930.6b152491@donnerap.manchester.arm.com>
References: <20230818-ths-h616-v1-0-0e1e058b9c7a@somainline.org>
        <20230818-ths-h616-v1-2-0e1e058b9c7a@somainline.org>
        <20230818112930.6b152491@donnerap.manchester.arm.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 18 2023 at 11:29:30 AM +01:00:00, Andre Przywara 
<andre.przywara@arm.com> wrote:
> On Fri, 18 Aug 2023 10:43:17 +0200
> Martin Botka <martin.botka@somainline.org> wrote:
> 
> Hi Martin,
> 
> many thanks for the time and effort for upstreaming this!
> 
>>  Add support for the thermal sensor found in H616 SoC
>>  which slightly resembles the H6 thermal sensor
>>  controller with few changes like 4 sensors.
>> 
>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>  ---
>>   drivers/thermal/sun8i_thermal.c | 115 
>> ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>> 
>>  diff --git a/drivers/thermal/sun8i_thermal.c 
>> b/drivers/thermal/sun8i_thermal.c
>>  index 195f3c5d0b38..9d73e4313ad8 100644
>>  --- a/drivers/thermal/sun8i_thermal.c
>>  +++ b/drivers/thermal/sun8i_thermal.c
>>  @@ -108,6 +108,12 @@ static int sun50i_h5_calc_temp(struct 
>> ths_device *tmdev,
>>   		return -1590 * reg / 10 + 276000;
>>   }
>> 
>>  +static int sun50i_h616_calc_temp(struct ths_device *tmdev,
>>  +			       int id, int reg)
>>  +{
>>  +	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> 
> So if my school maths is not letting me down, this is the same as the
> sun8i_ths_calc_temp() function, when using:
> scale = h616_scale * -10
> offset = h616_offset * h616_scale
> 
> So we do not need this new function, when we use:
> +	.offset = 263655,
> +	.scale = 810,
> below, right?
That looks correct. Seems like my brain has let me down once again hehe.
> Those values are not only positive, but also seem closer to the other
> SoC's values.
> This of course requires some small adjustment in the calibrate 
> function,
> to accommodate for the changed scale, but I leave this up as an 
> exercise
> to the reader ;-)
> 
> Martin, can you confirm that this works?
Will do :)
> 
>>  +}
>>  +
>>   static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int 
>> *temp)
>>   {
>>   	struct tsensor *s = thermal_zone_device_priv(tz);
>>  @@ -278,6 +284,64 @@ static int sun50i_h6_ths_calibrate(struct 
>> ths_device *tmdev,
>>   	return 0;
>>   }
>> 
>>  +static int sun50i_h616_ths_calibrate(struct ths_device *tmdev,
>>  +				   u16 *caldata, int callen)
> 
> nit: alignment
ack
> 
>>  +{
>>  +	struct device *dev = tmdev->dev;
>>  +	int i, ft_temp;
>>  +
>>  +	if (!caldata[0])
>>  +		return -EINVAL;
>>  +
>>  +	/*
>>  +	 * h616 efuse THS calibration data layout:
>>  +	 *
>>  +	 * 0      11  16     27   32     43   48    57
>>  +	 * +----------+-----------+-----------+-----------+
>>  +	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
>>  +	 * +----------+-----------+-----------+-----------+
>>  +	 *                      ^           ^           ^
>>  +	 *                      |           |           |
>>  +	 *                      |           |           sensor3[11:8]
>>  +	 *                      |           sensor3[7:4]
>>  +	 *                      sensor3[3:0]
>>  +	 *
>>  +	 * The calibration data on the H616 is the ambient temperature and
>>  +	 * sensor values that are filled during the factory test stage.
>>  +	 *
>>  +	 * The unit of stored FT temperature is 0.1 degreee celusis.
> 
> nit: degree Celsius
.... I can't even legit excuse this typo (If it even can be called 
typo). Got it tho.
> 
>>  +	 */
>>  +	ft_temp = caldata[0] & FT_TEMP_MASK;
>>  +
>>  +	for (i = 0; i < tmdev->chip->sensor_num; i++) {
>>  +		int delta, cdata, offset, reg;
>>  +
>>  +		if (i == 3)
>>  +			reg = (caldata[1] >> 12)
>>  +			      | (caldata[2] >> 12 << 4)
>>  +			      | (caldata[3] >> 12 << 8);
> 
> Can you add parentheses around the (caldata[2|3] >> 12) part? Makes 
> it a
> bit more readable.
yep
> 
>>  +		else
>>  +			reg = (int)caldata[i + 1] & TEMP_CALIB_MASK;
>>  +
>>  +		delta = (ft_temp * 100 - tmdev->chip->calc_temp(tmdev, i, reg))
>>  +			/ tmdev->chip->scale;
> 
> Looks a bit odd, can you write this as over two lines?
> 		delta = ft_temp ...;
> 		delta /= tmdev->chip_scale;
can do.
> 
> (And this would be the place where you adjust the calculation to use 
> the
> new scale value).
yep. Tho it is bit of a spoiler for the reader ;)
> 
>>  +		cdata = CALIBRATE_DEFAULT - delta;
>>  +		if (cdata & ~TEMP_CALIB_MASK) {
>>  +			dev_warn(dev, "sensor%d is not calibrated.\n", i);
>>  +
>>  +			continue;
>>  +		}
>>  +
>>  +		offset = (i % 2) * 16;
>>  +		regmap_update_bits(tmdev->regmap,
>>  +				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
>>  +				   0xfff << offset,
> 
> That should be TEMP_CALIB_MASK << offset, compare the H6 code.
Agreed. Missed this one. Ty.
> 
>>  +				   cdata << offset);
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>   static int sun8i_ths_calibrate(struct ths_device *tmdev)
>>   {
>>   	struct nvmem_cell *calcell;
>>  @@ -453,6 +517,43 @@ static int sun50i_h6_thermal_init(struct 
>> ths_device *tmdev)
>>   	return 0;
>>   }
>> 
>>  +static int sun50i_h616_thermal_init(struct ths_device *tmdev)
>>  +{
>>  +	int val;
>>  +
>>  +	/*
>>  +	 * T_acq = 20us
>>  +	 * clkin = 24MHz
>>  +	 *
>>  +	 * x = T_acq * clkin - 1
>>  +	 *   = 479
>>  +	 */
>>  +	regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
>>  +		     SUN8I_THS_CTRL0_T_ACQ0(47) | SUN8I_THS_CTRL2_T_ACQ1(479));
> 
> So this whole function is the same as the H6 (diff it!), except this 
> line.
> Which is actually also the same, just written differently (47 == 
> 0x2f).
> Can you please double check this, and if you agree, remove the whole
> function and just use the H6 version?
They are not the same. Yes the 47 can be replaced with the unknown 
value from H6.
What isnt the same is the CTRL at the end. CTRL0 in H6 and CTRL2 in 
H616. A very
small change :)

Cheers,
Martin
> 
> Cheers,
> Andre
> 
> 
>>  +	/* average over 4 samples */
>>  +	regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
>>  +		     SUN50I_THS_FILTER_EN |
>>  +		     SUN50I_THS_FILTER_TYPE(1));
>>  +	/*
>>  +	 * clkin = 24MHz
>>  +	 * filter_samples = 4
>>  +	 * period = 0.25s
>>  +	 *
>>  +	 * x = period * clkin / 4096 / filter_samples - 1
>>  +	 *   = 365
>>  +	 */
>>  +	regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
>>  +		     SUN50I_H6_THS_PC_TEMP_PERIOD(365));
>>  +	/* enable sensor */
>>  +	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
>>  +	regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
>>  +	/* thermal data interrupt enable */
>>  +	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
>>  +	regmap_write(tmdev->regmap, SUN50I_H6_THS_DIC, val);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>   static int sun8i_ths_register(struct ths_device *tmdev)
>>   {
>>   	int i;
>>  @@ -608,6 +709,19 @@ static const struct ths_thermal_chip 
>> sun50i_h6_ths = {
>>   	.calc_temp = sun8i_ths_calc_temp,
>>   };
>> 
>>  +static const struct ths_thermal_chip sun50i_h616_ths = {
>>  +	.sensor_num = 4,
>>  +	.has_bus_clk_reset = true,
>>  +	.ft_deviation = 8000,
>>  +	.offset = -3255,
>>  +	.scale = -81,
>>  +	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
>>  +	.calibrate = sun50i_h616_ths_calibrate,
>>  +	.init = sun50i_h616_thermal_init,
>>  +	.irq_ack = sun50i_h6_irq_ack,
>>  +	.calc_temp = sun50i_h616_calc_temp,
>>  +};
>>  +
>>   static const struct of_device_id of_ths_match[] = {
>>   	{ .compatible = "allwinner,sun8i-a83t-ths", .data = 
>> &sun8i_a83t_ths },
>>   	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
>>  @@ -616,6 +730,7 @@ static const struct of_device_id of_ths_match[] 
>> = {
>>   	{ .compatible = "allwinner,sun50i-a100-ths", .data = 
>> &sun50i_a100_ths },
>>   	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths 
>> },
>>   	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths 
>> },
>>  +	{ .compatible = "allwinner,sun50i-h616-ths", .data = 
>> &sun50i_h616_ths },
>>   	{ /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_ths_match);
>> 
> 


