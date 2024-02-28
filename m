Return-Path: <linux-kernel+bounces-85066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3486AFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189A5B267E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DF14A09D;
	Wed, 28 Feb 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWO9lZWT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB047351C;
	Wed, 28 Feb 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125742; cv=none; b=emGVGo0iyhtCjLo4aVzo2AhT+GrPVEXX8a8Hvjediv7nKhSvmaikN2bdO0oiQgNvNEuYb5Zg5WE7vieWfD9slEhP1bsQQ2gyQhDqOEHk95x5h58C/60y0FBXyxKj0ZgdEmA1cwmVc3YI4ompidIVhB8VWfDBf/l0WPC9kwoZhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125742; c=relaxed/simple;
	bh=29efipgaYFVLHtU1fYqAE2Oq/obv/17ZcWxe8+cAFgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BseiTzWjbbrFjzMGgAMOK2V9IsjFa6cvkeYBdmcc6FHQE5np7oWItU0JZxQQmNqY/39dKs1++MskxvT7fbnM1l7OYW+xAdEQRqMghq8Naq1nuFQrkvQVTkRZ+n/41GaP1wFJLWC8P/p7Mf/4DvGMWQcMyVweD61URrRxt3V5dC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWO9lZWT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso6525515e87.3;
        Wed, 28 Feb 2024 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709125738; x=1709730538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2nRuHvR03SqSiQ0hwNmb97ByNuecytbXgv6lYhQpis=;
        b=fWO9lZWTwWvI616EHzF0hP841a2CAI+h+K3rPOUawzL8apksgorEL4g9gH1/ipPJxC
         OfTwEuGMTMeZWEZ2dqCVmPItOtsU7Nr6v7WGwrcq3syIra3G8s1r7+gxdRDX5mGtAU3b
         o6b8WTAmGtqfxwwyk82labDL1ev/R7uqTjRHu910ZFC1w1hdBdGj1wjvfY1Xo3X+FtPp
         7RB2JpZahDBFO0Vzg3+rrJcw7PmiMcvpMR596sJQl+YxHSMLfZQioXQ+WNySF6cYveiJ
         2Z1aygkNOrkr0aMhn3lpP+/3jb/KfCKDxfTAmawyrbv1RihgAghjIO75gqv3jE7SdcKM
         Ka6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125738; x=1709730538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2nRuHvR03SqSiQ0hwNmb97ByNuecytbXgv6lYhQpis=;
        b=KIwcsoBw9zVY1F27ZBW5bpL8CO1OG/QAhLlHflB6MrfoZuXG6DAhkIrP6OZdSpiZ4m
         eRQpwoacmXAZij+unqtzfZRb0jBYfyCfkvDv/ab01KLyUYchIM5HPsRXXjbwEtwhlUYk
         luRVwxiZWuSUPhu7MznwWEVuEJeIdNJ1oNGAQqoKD9pELlYBvL+zcTEdMo6dCJwD4LpI
         UZjM2+6Pfl+adZoti6zGvyl/UOqDIbyhEPDdYdLKBrgc/VGmZZLqNEZ3vUnqFqJHH8xr
         LO1MY5l/st+HJmZlPxxmoLC1jKcybhnGpUY+9XK6TVmoK+My2ZIhbPo0bOViZHAlCFlt
         T0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBVlsefUbW01YPP7ZF3+yUFwuFTnXxM7QR6Uf4GWdSj7WCGE3SAqNkw6sTKS1qtK1Cew3ePrAN/bhRRjlWLskVN/TwvORHDCIfEHTIC5kGkG7WhmohyWH2tmSLd/+Pcpng+HRVQTvcTwRSaVEc6MAAZnAOnL1J4USj63tS0G7NCPeYUQ==
X-Gm-Message-State: AOJu0Ywpvwh3xjv/uMm8+zKCVI5Pb9fGuRa6w6Jyy1+qO8nO9ayr9rVM
	nB6B6o1TvQgNgpka5N7BWpP2BcEA5kDSRPfp+Vk3oHJvAMmh/IlD
X-Google-Smtp-Source: AGHT+IHMh/nncsowG6h0Kt/XVHBN81W3SVMH6NStKtf5vA+jYMOFePMzQCEhO2MfQWJ9FSwQGkOErw==
X-Received: by 2002:a05:6512:23a9:b0:512:fe34:9384 with SMTP id c41-20020a05651223a900b00512fe349384mr7247827lfv.58.1709125737984;
        Wed, 28 Feb 2024 05:08:57 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id w19-20020ac254b3000000b005131e2bf3dasm95480lfk.215.2024.02.28.05.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:08:57 -0800 (PST)
Message-ID: <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
Date: Wed, 28 Feb 2024 15:08:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 14:24, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> channel approximates the response of the human-eye providing direct
> read out where the output count is proportional to ambient light levels.
> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> caused by artificial light sources. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> Scales, Gains and Integration time implementation.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
> v7 -> v8:
>   - Renamed APDS9306_INT_CH_CLEAR to APDS9306_INT_SRC_CLEAR macro for higher
>     readability
>   - Removed APDS9306_CHANNEL macro for higher readability
>   - Updated iio_push_event() functions with correct type of events (Light or Intensity)
>   - Updated variable name "event_ch_is_light" to "int_src" and change as per
>     review to fix compiler warning
>   - Used scope for guard() functions
>   - Other fixes as per reviews
>     https://lore.kernel.org/all/20240224151340.3f2f51e8@jic23-huawei/
>     https://lore.kernel.org/all/ZdycR6nr3rtrnuth@smile.fi.intel.com/
> 
> v6 -> v7:
>   - Made comments to struct part_id_gts_multiplier as kernel doc
>   - Removed static_asserts for array sizes
>   - Moved regmap_field types from driver private data structure to a new
>     structure and removed regfield_ prefix to reduce names
>   - Used "struct apds9306_regfields *rf = &data->rf" in the respective
>     functions to reduce names
>   - Removed apds9306_runtime_power_on() and apds9306_runtime_power_off()
>     functions in favour of using the runtime_pm calls directly from
>     calling functions.
>   - Fixed indentations
>     https://lore.kernel.org/all/ZcOZX8mWTozC2EAc@smile.fi.intel.com/#r
> 
> v5 -> v6:
>   - Changes as per review
>   - Update kernel doc for private data
>   - Change IIO Event Spec definitions
>   - Update guard mutex lock implementation
>   - Add pm_runtime_get()
>   - Update styling
>     Link: https://lore.kernel.org/all/20240204134056.5dc64e8b@jic23-huawei/
> 
> v2 -> v5:
>   - Removed scale attribute for Intensity channel:
>     Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/
> 
>   - Dropped caching of hardware gain, repeat rate and integration time and
>     updated code as per earlier reviews.
>     Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
> ---

Hi Subhajit,

I just happened to notice couple of minor things. I see the series is 
already in a v8 and don't want to cause extra re-spins. So, perhaps 
consider these points if you need to do v9 but I am sending these only 
as 'nits'. I don't think any of my findings are very serious.

..

> +/*
> + * As per the datasheet, at HW Gain = 3x, Integration time 100mS (32x),
> + * typical 2000 ADC counts are observed for 49.8 uW per sq cm (340.134 lux)
> + * for apds9306 and 43 uW per sq cm (293.69 lux) for apds9306-065.
> + * Assuming lux per count is linear across all integration time ranges.
> + *
> + * Lux = (raw + offset) * scale; offset can be any value by userspace.
> + * HG = Hardware Gain; ITG = Gain by changing integration time.
> + * Scale table by IIO GTS Helpers = (1 / HG) * (1 / ITG) * Multiplier.
> + *
> + * The Lux values provided in the datasheet are at ITG=32x and HG=3x,
> + * at typical 2000 count for both variants of the device.
> + *
> + * Lux per ADC count at 3x and 32x for apds9306 = 340.134 / 2000
> + * Lux per ADC count at 3x and 32x for apds9306-065 = 293.69 / 2000
> + *
> + * The Multiplier for the scale table provided to userspace:
> + * IIO GTS scale Multiplier for apds9306 = (340.134 / 2000) * 32 * 3 = 16.326432
> + * and for apds9306-065 = (293.69 / 2000) * 32 * 3 = 14.09712
> + */
> +static struct part_id_gts_multiplier apds9306_gts_mul[] = {

const ?

> +	{
> +		.part_id = 0xB1,
> +		.max_scale_int = 16,
> +		.max_scale_nano = 3264320,
> +	}, {
> +		.part_id = 0xB3,
> +		.max_scale_int = 14,
> +		.max_scale_nano = 9712000,
> +	},
> +};
..> +static struct iio_event_spec apds9306_event_spec_als[] = {

const ?

> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static struct iio_event_spec apds9306_event_spec_clear[] = {
const ?
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_with_events[] = {
const?
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = apds9306_event_spec_als,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_als),
> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +		.event_spec = apds9306_event_spec_clear,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_clear),
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_without_events[] = {
const?
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +	},
> +};

..

> +static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
> +{
> +	struct device *dev = data->dev;
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret, intg_old, gain_old, gain_new, gain_new_closest, intg_time_idx;
> +	int gain_idx;
> +	bool ok;
> +
> +	if (!iio_gts_valid_time(&data->gts, val2)) {
> +		dev_err_ratelimited(dev, "Unsupported integration time %u\n", val2);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(rf->gain, &gain_idx);
> +	if (ret)
> +		return ret;
> +
> +	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (intg_old == val2)
> +		return 0;
> +
> +	gain_old = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
> +	if (gain_old < 0)
> +		return gain_old;
> +
> +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
> +						     intg_old, val2, &gain_new);

You don't use the 'ret' here, so maybe for the clarity, not assign it.
Or, maybe you wan't to try to squeeze out few cycles for succesful case 
and check the ret for '0' - in which case you should be able to omit the 
check right below as well as the call to iio_find_closest_gain_low(). 
OTOH, this is likely not a "hot path" so I don't care too much about the 
extra call if you think code is clearer this way.

> +	if (gain_new < 0) {
> +		dev_err_ratelimited(dev, "Unsupported gain with time\n");
> +		return gain_new;
> +	}
> +
> +	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
> +	if (gain_new_closest < 0) {
> +		gain_new_closest = iio_gts_get_min_gain(&data->gts);
> +		if (gain_new_closest < 0)
> +			return gain_new_closest;
> +	}
> +	if (!ok)
> +		dev_dbg(dev, "Unable to find optimum gain, setting minimum");
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_field_write(rf->intg_time, ret);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_field_write(rf->gain, ret);
> +}


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


