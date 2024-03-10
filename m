Return-Path: <linux-kernel+bounces-98213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00718776A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FA281888
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51F28383;
	Sun, 10 Mar 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+XH4FTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6E1E888;
	Sun, 10 Mar 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074575; cv=none; b=crPVkKYG2Uw3c8ymUiwBOwQ+ep9dv6YTfRhBr1HgCpOBGgWdKxySNtslNe62/eQniFTjlAOISuXpFZ79nAj5ehshkWJFMjP9/XrmuqSOyVyXb/73N9hWlfdLX9N+hAU/xxyuHcdNBqjjfMeJoiwnOVLuSnWiZkzA9B78rsdH7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074575; c=relaxed/simple;
	bh=QeHdsOwwo/yEk6Eb2BPKn25Jxgk0Tu0jugL0q0JzM/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxWy/HcP3EwSAzWpXG61UC9HLf/oh+ji30s70MiDlDr0/GHyQGu0uRN9vCjPwkcRWtvDBynprX21lKm4ngNqKEzJs/agiUFEqkqNRdBpv2EalhJCWkoLGGUgq21N5Q5/LwvEueW/cogjkXgQmb4zzKXi8aqtS6QIHrj9I0UVS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+XH4FTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB88FC433F1;
	Sun, 10 Mar 2024 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710074574;
	bh=QeHdsOwwo/yEk6Eb2BPKn25Jxgk0Tu0jugL0q0JzM/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+XH4FTaK+71GqIZzTnxG7lmnA509lRdTRuDySoV77J2NtvCMKnBbIc5+q/QEiUnP
	 rN28SPf3fLtNczjP+caolNGnfgAY6M4tUHqwTxuw98GjlpcchyPuSZLhypW0Q2Uj/x
	 xMaKDdBOcfcDeO34IgZ/1dJRDfG2zw1ER58waF/DIkuOIsTbO1aHflB3Xr/Ts+SM4W
	 Cn3TkZ6ecOV1C80tCq+Sr/4UCjxrZ/4gEZelQAretr0LPw0guEprU7cp1xGzt/RWm0
	 XTU4wX+uBO83IJ1fpT1lYiXAMEVtbh4K4oFVwXJrPtJtLREDr9yYZxsS9A9+RXMTM4
	 RMbGL1VFfOnCQ==
Date: Sun, 10 Mar 2024 12:42:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240310124237.52fa8a56@jic23-huawei>
In-Reply-To: <20240309105031.10313-6-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
	<20240309105031.10313-6-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Mar 2024 21:20:31 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

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

A few things inline, on trivial that I'll tidy up, the other a potential
suggestion for simplifying the code, but not something I'm going to
ask for a v10 for.  If you like the suggestion then a follow up patch,
if not then fair enough - may be a case of "don't let perfect be the enemy
of good" or maybe you disagree.

Anyhow, series applied to the togreg-normal branch of iio.git and pushed out
for 0-day to take a look at it.  This is 6.10 material now.

Thanks,

Jonathan

> +static const struct iio_chan_spec apds9306_channels_with_events[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = apds9306_event_spec,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
Trivial but odd field order - I'll tidy that up whilst applying.
> +		.modified = 1,
> +		.event_spec = apds9306_event_spec,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
> +	},
> +};
> +
> +static const struct iio_chan_spec apds9306_channels_without_events[] = {
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
> +
> +/* INT_PERSISTENCE available */
> +static IIO_CONST_ATTR(thresh_either_period_available, "[0 1 15]");
> +
> +/* ALS_THRESH_VAR available */
> +static IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 1 7]");
> +
> +static struct attribute *apds9306_event_attributes[] = {
> +	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
> +	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
> +	NULL
> +};



> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret, val;
> +
> +	state = !!state;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH: {
> +		guard(mutex)(&data->mutex);
> +
> +		/*
> +		 * If interrupt is enabled, the channel is set before enabling
> +		 * the interrupt. In case of disable, no need to switch
> +		 * channels. In case of different channel is selected while
> +		 * interrupt in on, just change the channel.
> +		 */
> +		if (state) {
> +			if (chan->type == IIO_LIGHT)
> +				val = 1;
> +			else if (chan->type == IIO_INTENSITY)
> +				val = 0;
> +			else
> +				return -EINVAL;
> +
> +			ret = regmap_field_write(rf->int_src, val);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_field_read(rf->int_en, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val == state)
> +			return 0;
> +
> +		ret = regmap_field_write(rf->int_en, state);
> +		if (ret)
> +			return ret;
> +
> +		if (state)
> +			return pm_runtime_resume_and_get(data->dev);
> +
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
Note this isn't a reason to do a v10, just a possible suggestion for
what I think is more readable code.

Flow here is complex, maybe we'd have been better with skipping the
state = !!state, rename val to more explicit enabled
above and something like..

		ret = regmap_field_read(rf->int_en, &enabled);
		if (ret)
			return ret;

		if (state) {
			if (chan->type == IIO_LIGHT)
				ret = regmap_field_write(rf->int_src, 1);
			else if (chan->type == IIO_INTENSITY)
				ret = regmap_field_write(rf->int_src, 0);
			else
				return -EINVAL;

			if (ret)
				return ret;
			if (enabled) /* Already enabled */
				return 0;		
			
			ret = regmap_field_write(rf->int_en, 1);
			if (ret)
				return ret;

			return pm_runtime_resume_and_get(data->dev);
		} else {  // Could drop this else but I think it's useful to show the either or flow. 
			if (!enabled)
				return 0;		

			ret = regmap_field_write(rf->int_en, 0);
			if (ret)
				return ret;
			pm_runtime_mark_last_busy(data->dev);
			pm_runtime_put_autosuspend(data->dev);

			return 0;
		}
	}	
> +
> +		return 0;
> +	}
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return regmap_field_write(rf->int_thresh_var_en, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static void apds9306_powerdown(void *ptr)
> +{
> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret;
> +
> +	ret = regmap_field_write(rf->int_thresh_var_en, 0);
> +	if (ret)
> +		return;
> +
> +	ret = regmap_field_write(rf->int_en, 0);
> +	if (ret)
> +		return;
> +
> +	apds9306_power_state(data, false);
> +}

..


