Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52177B4248
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjI3QpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjI3QpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:45:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0FAB;
        Sat, 30 Sep 2023 09:45:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF69BC433C7;
        Sat, 30 Sep 2023 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696092302;
        bh=Gz+7G2+5nZU2Nq5I2T2NNYFPLkqQLetCmTTjTVkjliw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EBwUUWDe0vcE7YBMUJQqfBIIKCJIuV6q9acqDFHeiqM1HXOtvru9CTtq/W7pNzH84
         JkRNLGGwE/S3yUaHmdEqrutAssjZMvRrltR0H0Dfjq2+lbNEAHkBVNHEE0r6X21RFR
         IYqYI4ItO4gEY8+YWyaVqJ9sEvHea8Adw4NIuVjuseP27o1nWRncQ3mGX3Ejj+nHvm
         2nY+E+GaN0WgT87CfbBZmV5Zr6odusNT06X3Rls5v+vwT9ZrmO0xcCqPFybqV5cCIy
         Xz0n/p4j6MYKuhKyFMmw088ODWqwUj75n/LJKF/5wxY7bs108B0IrLNyXrwKWk9ccb
         CsWQPno6GNtMw==
Date:   Sat, 30 Sep 2023 17:45:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <Potin.Lai@quantatw.com>, <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Message-ID: <20230930174501.039095da@jic23-huawei>
In-Reply-To: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 16:18:45 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Create event sysfs for applying the deglitch condition. When
> in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
> the driver will use the in_voltageY_thresh_rising_value and
> in_voltageY_thresh_falling_value as threshold values. If the ADC value
> falls outside this threshold, the driver will wait for the ADC sampling
> period and perform an additional read once to achieve the deglitching
> purpose.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi Billy

This is pushing the meaning of the events interface too far.
You can't use it to hide a value you don't like from userspace.

If you can explain what the condition is that you are seeing
and what you need to prevent happening if it is seen that would help
us figure out if there is another way to do this.

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 189 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 998e8bcc06e1..9e746c81d916 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -95,6 +95,7 @@ struct aspeed_adc_model_data {
>  	bool wait_init_sequence;
>  	bool need_prescaler;
>  	bool bat_sense_sup;
> +	bool require_extra_eoc;
>  	u8 scaler_bit_width;
>  	unsigned int num_channels;
>  	const struct aspeed_adc_trim_locate *trim_locate;
> @@ -120,6 +121,26 @@ struct aspeed_adc_data {
>  	int			cv;
>  	bool			battery_sensing;
>  	struct adc_gain		battery_mode_gain;
> +	unsigned int		required_eoc_num;
> +	u16			*upper_bound;
> +	u16			*lower_bound;
> +	bool			*upper_en;
> +	bool			*lower_en;
> +};
> +
> +static const struct iio_event_spec aspeed_adc_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate =
> +			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate =
> +			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	},
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -131,6 +152,8 @@ struct aspeed_adc_data {
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>  				BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
>  				BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.event_spec = aspeed_adc_events,			\
> +	.num_event_specs = ARRAY_SIZE(aspeed_adc_events),	\
>  }
>  
>  static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
> @@ -277,6 +300,35 @@ static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
>  	return 0;
>  }
>  
> +static int aspeed_adc_get_voltage_raw(struct aspeed_adc_data *data,
> +				      struct iio_chan_spec const *chan)
> +{
> +	int val;
> +
> +	val = readw(data->base + chan->address);
> +	dev_dbg(data->dev,
> +		"%d upper_bound: %d %x, lower_bound: %d %x, delay: %d * %d ns",
> +		chan->channel, data->upper_en[chan->channel],
> +		data->upper_bound[chan->channel], data->lower_en[chan->channel],
> +		data->lower_bound[chan->channel], data->sample_period_ns,
> +		data->required_eoc_num);
> +	if (data->upper_en[chan->channel]) {
> +		if (val >= data->upper_bound[chan->channel]) {
> +			ndelay(data->sample_period_ns *
> +			       data->required_eoc_num);
> +			val = readw(data->base + chan->address);
> +		}
> +	}
> +	if (data->lower_en[chan->channel]) {
> +		if (val <= data->lower_bound[chan->channel]) {
> +			ndelay(data->sample_period_ns *
> +			       data->required_eoc_num);
> +			val = readw(data->base + chan->address);
> +		}
> +	}
> +	return val;
> +}
> +
>  static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int *val, int *val2, long mask)
> @@ -299,14 +351,15 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  			 * Experiment result is 1ms.
>  			 */
>  			mdelay(1);
> -			*val = readw(data->base + chan->address);
> +			*val = aspeed_adc_get_voltage_raw(data, chan);
>  			*val = (*val * data->battery_mode_gain.mult) /
>  			       data->battery_mode_gain.div;
>  			/* Restore control register value */
>  			writel(adc_engine_control_reg_val,
>  			       data->base + ASPEED_REG_ENGINE_CONTROL);
> -		} else
> -			*val = readw(data->base + chan->address);
> +		} else {
> +			*val = aspeed_adc_get_voltage_raw(data, chan);
> +		}
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OFFSET:
> @@ -369,9 +422,106 @@ static int aspeed_adc_reg_access(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int aspeed_adc_read_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return data->upper_en[chan->channel];
> +	case IIO_EV_DIR_FALLING:
> +		return data->lower_en[chan->channel];
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int aspeed_adc_write_event_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir,
> +					 int state)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		data->upper_en[chan->channel] = state ? 1 : 0;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		data->lower_en[chan->channel] = state ? 1 : 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_adc_write_event_value(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					enum iio_event_info info, int val,
> +					int val2)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		if (val >= BIT(ASPEED_RESOLUTION_BITS))
> +			return -EINVAL;
> +		data->upper_bound[chan->channel] = val;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		data->lower_bound[chan->channel] = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_adc_read_event_value(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       enum iio_event_info info, int *val,
> +				       int *val2)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val = data->upper_bound[chan->channel];
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		*val = data->lower_bound[chan->channel];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
>  static const struct iio_info aspeed_adc_iio_info = {
>  	.read_raw = aspeed_adc_read_raw,
>  	.write_raw = aspeed_adc_write_raw,
> +	.read_event_config = &aspeed_adc_read_event_config,
> +	.write_event_config = &aspeed_adc_write_event_config,
> +	.read_event_value = &aspeed_adc_read_event_value,
> +	.write_event_value = &aspeed_adc_write_event_value,
>  	.debugfs_reg_access = aspeed_adc_reg_access,
>  };
>  
> @@ -502,6 +652,30 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->base))
>  		return PTR_ERR(data->base);
>  
> +	data->upper_bound = devm_kzalloc(&pdev->dev,
> +					 sizeof(data->upper_bound) *
> +						 data->model_data->num_channels,
> +					 GFP_KERNEL);
> +	if (!data->upper_bound)
> +		return -ENOMEM;
> +	data->upper_en = devm_kzalloc(&pdev->dev,
> +				      sizeof(data->upper_en) *
> +					      data->model_data->num_channels,
> +				      GFP_KERNEL);
> +	if (!data->upper_en)
> +		return -ENOMEM;
> +	data->lower_bound = devm_kzalloc(&pdev->dev,
> +					 sizeof(data->lower_bound) *
> +						 data->model_data->num_channels,
> +					 GFP_KERNEL);
> +	if (!data->lower_bound)
> +		return -ENOMEM;
> +	data->lower_en = devm_kzalloc(&pdev->dev,
> +				      sizeof(data->lower_en) *
> +					      data->model_data->num_channels,
> +				      GFP_KERNEL);
> +	if (!data->lower_en)
> +		return -ENOMEM;
>  	/* Register ADC clock prescaler with source specified by device tree. */
>  	spin_lock_init(&data->clk_lock);
>  	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
> @@ -632,7 +806,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
>  	writel(adc_engine_control_reg_val,
>  	       data->base + ASPEED_REG_ENGINE_CONTROL);
> -
> +	adc_engine_control_reg_val =
> +		FIELD_GET(ASPEED_ADC_CTRL_CHANNEL,
> +			  readl(data->base + ASPEED_REG_ENGINE_CONTROL));
> +	data->required_eoc_num = hweight_long(adc_engine_control_reg_val);
> +	if (data->model_data->require_extra_eoc &&
> +	    (adc_engine_control_reg_val &
> +	     BIT(data->model_data->num_channels - 1)))
> +		data->required_eoc_num += 12;
>  	indio_dev->name = data->model_data->model_name;
>  	indio_dev->info = &aspeed_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -668,6 +849,7 @@ static const struct aspeed_adc_model_data ast2400_model_data = {
>  	.need_prescaler = true,
>  	.scaler_bit_width = 10,
>  	.num_channels = 16,
> +	.require_extra_eoc = 0,
>  };
>  
>  static const struct aspeed_adc_model_data ast2500_model_data = {
> @@ -680,6 +862,7 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
>  	.scaler_bit_width = 10,
>  	.num_channels = 16,
>  	.trim_locate = &ast2500_adc_trim,
> +	.require_extra_eoc = 0,
>  };
>  
>  static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
> @@ -691,6 +874,7 @@ static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
>  	.scaler_bit_width = 16,
>  	.num_channels = 8,
>  	.trim_locate = &ast2600_adc0_trim,
> +	.require_extra_eoc = 1,
>  };
>  
>  static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
> @@ -702,6 +886,7 @@ static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
>  	.scaler_bit_width = 16,
>  	.num_channels = 8,
>  	.trim_locate = &ast2600_adc1_trim,
> +	.require_extra_eoc = 1,
>  };
>  
>  static const struct of_device_id aspeed_adc_matches[] = {

