Return-Path: <linux-kernel+bounces-55044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEAA84B6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82611F23AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC6133983;
	Tue,  6 Feb 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtDIJ8eX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2E132C17;
	Tue,  6 Feb 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226953; cv=none; b=URJWDDzWjDNEiE/hpLkUL83RfTpo0m1a9hmkPnfJEy8G4FE9yBliLD9rTsSgoGkZwUYlaq4Ol6RX6m2C7hHeCgfrksRaULmLnCI5YkziEPn8MWmBAEUz2dQdbXGkZIDZqxHYW8Sj0ZV2eIodhZhdof3iGxLWUwKTBo3112A87OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226953; c=relaxed/simple;
	bh=zGIol68kVR5PCDpl2i+Kl3r0SUjb+kIeqV5z5WNp7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aern35W4r/cY8s55NZi/sml0IRuvv4JR3hYJXI6XegfUN0+MYtO404W2zcLWD+otPjW3nXpAUlAHFYA4nqJEEN9EU4sDRnssQu+wAwsUl+/sTpKf1+pdpDHV/jsyd8M6XJRT2GXGbBV9PClCf9bDaJEpe/4bvZ2P063An2EzL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtDIJ8eX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707226952; x=1738762952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGIol68kVR5PCDpl2i+Kl3r0SUjb+kIeqV5z5WNp7Zo=;
  b=QtDIJ8eX4/61+7Ha2EDXz8ANly2xEOawGc8ephUYlv+klIQMQB+5SLiu
   beL9lSPhj/XYoqLiBmy6P7JZvdn/Y2TWnpe94oSciXdQCtiQTUKZQLgtn
   paiiPqaYM/zTf3/09eF/WnPIWra1MOaZJ7OAgvqOzbYYwMc9+gCPStOuZ
   e0FxBG7sEnt2nuK47OlScxXTbi2jsfDpw/bVZ1JvYbU9y1PaAgUlM4VKU
   LqIYMc3f/Ipxup+ZDOf4MeJjlJHiKCW/77qTIBM5tlRIHZNixaGqX5C1b
   5voZ20lje09AI8lEJnFXMMpZw+3bLBFfWyIW4hPKrY8nvIS/Au/cEAt7/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="1015415"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1015415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909638436"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909638436"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:42:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLiS-00000002LuH-1J28;
	Tue, 06 Feb 2024 15:42:24 +0200
Date: Tue, 6 Feb 2024 15:42:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZcI3Pz6Z5V4qqpHO@smile.fi.intel.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-6-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206130017.7839-6-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 11:30:17PM +1030, Subhajit Ghosh wrote:
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

..

> +#define APDS9306_ALS_READ_DATA_DELAY_US	20000

(20 * USEC_PER_MSEC) ?

..

> +/*

Make it real kernel doc?

> + * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier
> + *
> + * GTS (Gain Time Scale) are helper functions for Light sensors which along
> + * with hardware gains also has gains associated with Integration times.
> + *
> + * There are two variants of the device with slightly different characteristics,
> + * they have same ADC count for different Lux levels as mentioned in the
> + * datasheet. This multiplier array is used to store the derived Lux per count
> + * value for the two variants to be used by the GTS helper functions.
> + *
> + * part_id: Part ID of the device
> + * max_scale_int: Multiplier for iio_init_iio_gts()
> + * max_scale_nano: Multiplier for iio_init_iio_gts()

(It will be wrong format for referring fields, but easy to fix.)

> + */

..

> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> +		APDS9306_NUM_REPEAT_RATES);

Just make that define to be inside [] in the respective array and drop this
static assert. The assertion might make sense to have different arrays to be
synchronized and when their maximums are different due to semantics (not your
case AFAICS).

..

> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_period) ==
> +		APDS9306_NUM_REPEAT_RATES);

Ditto.

..

> +	struct mutex mutex;

checkpatch probably wants this to have a comment.

..

> +	struct regmap_field *regfield_sw_reset;
> +	struct regmap_field *regfield_en;
> +	struct regmap_field *regfield_intg_time;
> +	struct regmap_field *regfield_repeat_rate;
> +	struct regmap_field *regfield_gain;
> +	struct regmap_field *regfield_int_src;
> +	struct regmap_field *regfield_int_thresh_var_en;
> +	struct regmap_field *regfield_int_en;
> +	struct regmap_field *regfield_int_persist_val;
> +	struct regmap_field *regfield_int_thresh_var_val;

May we reduce the names by

	struct {
		...
		struct regmap_field *int_persist_val;
		struct regmap_field *int_thresh_var_val;
	} regfield;

In the code

	struct regfield *rf = &priv->regfield;

	rf->int...

..

> +static struct attribute *apds9306_event_attributes[] = {
> +	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
> +	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group apds9306_event_attr_group = {
> +	.attrs = apds9306_event_attributes,
> +};

..

> +static int apds9306_runtime_power_on(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		dev_err_ratelimited(dev, "runtime resume failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int apds9306_runtime_power_off(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}

Seems to me like useless wrappers. Why do you need that message?
Btw, it's used only twice, open coding saves the LoCs!
Try making the next submission so the driver LoCs is < 1400.

..

> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> +				status, (status & (APDS9306_ALS_DATA_STAT_MASK |
> +				APDS9306_ALS_INT_STAT_MASK)) ||

Oh, this is interesting indentation...

> +				data->read_data_available,
> +				APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);

Can we write it as

	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
				       status, data->read_data_available ||
				       (status & (APDS9306_ALS_DATA_STAT_MASK |
						  APDS9306_ALS_INT_STAT_MASK)),
				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);

?

> +	if (ret)
> +		return ret;

..

> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			return apds9306_event_period_set(data, val);

> +		else

Redundant 'else'.

> +			return apds9306_event_thresh_set(data, dir, val);
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return apds9306_event_thresh_adaptive_set(data, val);
> +	default:
> +		return -EINVAL;
> +	}

..

> +		if (chan->type == IIO_LIGHT)
> +			return int_en & event_ch_is_light;
> +		else if (chan->type == IIO_INTENSITY)

Ditto.

> +			return int_en & !event_ch_is_light;

..

> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:

> +		return regmap_field_write(data->regfield_int_thresh_var_en,
> +					  state);

One line?

..

> +static int apds9306_init_iio_gts(struct apds9306_data *data)
> +{
> +	int i, ret, part_id;
> +
> +	ret = regmap_read(data->regmap, APDS9306_PART_ID_REG, &part_id);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_gts_mul); i++) {
> +		if (part_id == apds9306_gts_mul[i].part_id)

			break;
	}
	if (i == ARRAY_SIZE(...))
		return -...;

	return devm_iio_init_iio_gts(data->dev,
				     apds9306_gts_mul[i].max_scale_int,
				     apds9306_gts_mul[i].max_scale_nano,
				     apds9306_gains, ARRAY_SIZE(apds9306_gains),
				     apds9306_itimes, ARRAY_SIZE(apds9306_itimes),
				     &data->gts);

?

> +			return devm_iio_init_iio_gts(data->dev,
> +				 apds9306_gts_mul[i].max_scale_int,
> +				 apds9306_gts_mul[i].max_scale_nano,
> +				 apds9306_gains, ARRAY_SIZE(apds9306_gains),
> +				 apds9306_itimes, ARRAY_SIZE(apds9306_itimes),
> +				 &data->gts);
> +	}
> +
> +	return -ENXIO;
> +}

..

> +		return dev_err_probe(dev, ret,
> +				     "regfield initialization failed\n");

One line.

..

> +		indio_dev->num_channels =
> +				ARRAY_SIZE(apds9306_channels_with_events);

Ditto.

..

> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +				apds9306_irq_handler, IRQF_ONESHOT,
> +					"apds9306_event", indio_dev);

Fix indentation.

> +		if (ret)

> +			return dev_err_probe(dev, ret,
> +					     "failed to assign interrupt.\n");

One line.

..

> +		return dev_err_probe(dev, ret,
> +				     "failed to add action or reset\n");

Ditto.


> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed iio device registration\n");

Ditto.

-- 
With Best Regards,
Andy Shevchenko



