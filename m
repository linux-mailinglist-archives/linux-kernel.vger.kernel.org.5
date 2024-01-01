Return-Path: <linux-kernel+bounces-13919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712638214D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A517281577
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074EBA31;
	Mon,  1 Jan 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsiRyRuL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BFC12D;
	Mon,  1 Jan 2024 17:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793A1C433C8;
	Mon,  1 Jan 2024 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704131706;
	bh=zaOXVX1K5YkyLFGrpUZ5XXftDxjrRyF/9RXoFoBMMWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NsiRyRuLvgPr1/3WsdM+7Q+pQKrfedYY1yOXePQBuwJBeJV498L/kb5no0VvIMNxQ
	 hQosrPEn7QoWlqqt/XJJaTEaZl4PArgvkZ5XO/k0Vycfe4heNH+CrXwxNqWXmshwEi
	 HdZGNL01K7Z2elb02Hk9f/VN/b5IM2CO+uPxIqyInC2Wki9sHCFOsLHcKtPqSwIQph
	 DbFIEtok+8s0NmYCGuD4eyrGljp85k2jABWs2iKHQchVLRi+qpYUXatM6B/Mtqpv9P
	 i75YRcUfVzZfMKVLuagA6KMfshYDaox9hYPGO8odkB1HizFGfSEMTrhAnCdoC8DItU
	 9jKmRNfSriImw==
Date: Mon, 1 Jan 2024 17:54:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <lee@kernel.org>, <andriy.shevchenko@linux.intel.com>,
 <daniel.lezcano@linaro.org>, <dmitry.baryshkov@linaro.org>,
 <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
 <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
 <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
 <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
 <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
 <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20240101175453.5807483a@jic23-huawei>
In-Reply-To: <20231231171237.3322376-4-quic_jprakash@quicinc.com>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
	<20231231171237.3322376-4-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Dec 2023 22:42:37 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> In this case, we have VADC and ADC_TM functionality combined into the
> same driver. By convention, we reserve the first channel of the first
> SDAM for all immediate reads and use the remaining channels across all
> SDAMs for ADC_TM monitoring functionality.
> 
> Changes since v1:

Move below the --- we don't want this in the eventual git commit as it
is just noise.

> - Removed datashet_name usage and implemented read_label() function
> - In probe, updated channel property in iio_chan_spec from individual
>   channel to virtual channel and set indexed property to 1, due to the
>   above change.
> - Updated order of checks in ISR
> - Removed the driver remove callback and replaced with callbacks in a
>   devm_add_action call in probe.
> - Addressed other comments from reviewers.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---

A few quick comments inline because you already have a request for a substantial
change.  Main one is the devm handling tries to do too much with one callback and
I think introduces various bugs as a result.  Use the appropriate number of callbacks
so each action has it's own undo registered thus they will happen in the correct order
and no unnecessary ones will occur.

Jonathan


> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..5b5848492245
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,1198 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <asm/unaligned.h>

Whilst it isn't alphabetical order, general convention is
to put asm includes in a block after linux ones.

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/qcom-vadc-common.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>

> +
> +/**
> + * Worst case delay from PBS for conversion time can be
> + * up to 500ms, when PBS has timed out twice, once for
> + * the initial attempt and once for a retry of the same
> + * transaction.
> + */
> +
> +#define ADC5_GEN3_CONV_TIMEOUT_MS	501
> +
> +static int adc5_gen3_do_conversion(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop,
> +			u16 *data_volt)
> +{
> +	u8 val, sdam_index = prop->sdam_index;
> +	unsigned long rc;
> +	int ret;
> +
> +	/* Reserve channel 0 of first SDAM for immediate conversions */
> +	if (prop->adc_tm)
> +		sdam_index = 0;
> +
> +	mutex_lock(&adc->lock);
> +	ret = adc5_gen3_poll_wait_hs(adc, 0);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = adc5_gen3_configure(adc, prop);
> +	if (ret) {
> +		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	/* No support for polling mode at present*/
> +	rc = wait_for_completion_timeout(&adc->complete,
> +					msecs_to_jiffies(ADC5_GEN3_CONV_TIMEOUT_MS));
> +	if (!rc) {
> +		dev_err(adc->dev, "Reading ADC channel %s timed out\n",
> +			prop->label);
> +		ret = -ETIMEDOUT;
> +		goto unlock;
> +	}
> +
> +	ret = adc5_gen3_read_voltage_data(adc, data_volt, sdam_index);
> +	if (ret)
> +		goto unlock;
> +
> +	val = BIT(0);
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_EOC_CLR, &val, 1);
> +	if (ret)
> +		goto unlock;
> +
> +	/* To indicate conversion request is only to clear a status */
> +	val = 0;
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
> +	if (ret)
> +		goto unlock;
> +
> +	val = ADC5_GEN3_CONV_REQ_REQ;
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);
> +
> +unlock:
> +	mutex_unlock(&adc->lock);

guard(mutex)(&adc->lock); when you take the lock will simplify this funciton
as you can return directly then.

> +
> +	return ret;
> +}

> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc5_chip *adc = container_of(work, struct adc5_chip, tm_handler_work);
> +	struct adc5_channel_prop *chan_prop;
> +	u8 tm_status[2] = {0};
> +	u8 buf[16] = {0};
> +	u8 val;
> +	int ret, i, sdam_index = -1;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		int temp, offset;
> +		u16 code = 0;
> +
> +		chan_prop = &adc->chan_props[i];
> +		offset = chan_prop->tm_chan_index;
> +
> +		if (!chan_prop->adc_tm)
> +			continue;
> +
> +		mutex_lock(&adc->lock);
> +		if (chan_prop->sdam_index != sdam_index) {

Perhaps factor this block out as indent already high and adding scoped_guard would
make it worse.

> +			sdam_index = chan_prop->sdam_index;
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS,
> +					tm_status, 2);
> +			if (ret) {
> +				dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
> +					tm_status, 2);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write TM status failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			/* To indicate conversion request is only to clear a status */
> +			val = 0;
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write status clear conv_req failed with %d\n",
> +						ret);
> +				goto out;
> +			}
> +
> +			val = ADC5_GEN3_CONV_REQ_REQ;
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write conv_req failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CH_DATA0(0), buf,
> +					sizeof(buf));
> +			if (ret < 0) {
> +				dev_err(adc->dev, "adc read data failed with %d\n", ret);
> +				goto out;
> +			}
> +		}
> +
> +		if ((tm_status[0] & BIT(offset)) && (chan_prop->high_thr_en))
> +			upper_set = true;
> +
> +		if ((tm_status[1] & BIT(offset)) && (chan_prop->low_thr_en))
> +			lower_set = true;
> +
> +		mutex_unlock(&adc->lock);
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		code = get_unaligned_le16(&buf[2 * offset]);
> +		pr_debug("ADC_TM threshold code:%#x\n", code);
> +
> +		ret = qcom_adc5_hw_scale(chan_prop->scale_fn_type,
> +			chan_prop->prescale, adc->data, code, &temp);
> +		if (ret) {
> +			dev_err(adc->dev, "Invalid temperature reading, ret = %d, code=%#x\n",
> +					ret, code);
> +			continue;
> +		}
> +
> +		chan_prop->last_temp = temp;
> +		chan_prop->last_temp_set = true;
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +
> +	return;
> +
> +out:
> +	mutex_unlock(&adc->lock);

Messy to do this. Can you use scoped_guard(mutex, &adc->lock) to handle it more
cleanly?

> +}
> +

> +
> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan, int *val, int *val2,
> +			 long mask)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_prop *prop;
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	prop = &adc->chan_props[chan->address];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = adc5_gen3_do_conversion(adc, prop,
> +					&adc_code_volt);
> +		if (ret)
> +			return ret;
> +
> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> +			prop->prescale, adc->data,
> +			adc_code_volt, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adc5_gen3_do_conversion(adc, prop,
> +					&adc_code_volt);
Very short line wrap.  Will be under 80 chars without it.
Please check for similar cases.

> +		if (ret)
> +			return ret;
> +		*val = (int)adc_code_volt;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static void adc5_gen3_disable(void *data)
> +{
> +	struct adc5_chip *adc = data;
> +	int i;
> +
> +	if (adc->n_tm_channels)
> +		cancel_work_sync(&adc->tm_handler_work);
If this is required before the place where a simple
devm_request_irq() will result in the irqs being cleaned up
them register this callback earlier to avoid problems there.

> +
> +	for (i = 0; i < adc->num_sdams; i++)
> +		free_irq(adc->base[i].irq, adc);
> +
> +	mutex_lock(&adc->lock);
> +	/* Disable all available TM channels */
> +	for (i = 0; i < adc->nchannels; i++) {
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		adc5_gen3_poll_wait_hs(adc, adc->chan_props[i].sdam_index);
> +		_adc_tm5_gen3_disable_channel(&adc->chan_props[i]);
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +}

> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +				    struct adc5_channel_prop *prop,
> +				    struct fwnode_handle *fwnode,
> +				    const struct adc5_data *data)
> +{
> +	const char *name = fwnode_get_name(fwnode);
> +	const char *channel_name;
> +	struct device *dev = adc->dev;
> +	u32 chan, value, varr[2], sid = 0;
> +	int ret, val;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "invalid channel number %s\n", name);
> +
> +	/*
> +	 * Value read from "reg" is virtual channel number
> +	 * virtual channel number = sid << 8 | channel number
> +	 */
> +
> +	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
> +	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> +
> +	if (chan > ADC5_GEN3_OFFSET_EXT2)
> +		return dev_err_probe(dev, -EINVAL, "%s invalid channel number %d\n", name, chan);
> +
> +	prop->channel = chan;
> +	prop->sid = sid;
> +
> +	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
> +	if (ret)
> +		channel_name = name;
Set this first then don't check ret

	channel_name = name;
	fwnode_property_read_string()

do similar for any other cases with a default.

> +	prop->label = channel_name;
> +
> +	prop->decimation = ADC5_DECIMATION_DEFAULT;
> +	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "%#x invalid decimation %d\n",
> +				chan, value);
> +		prop->decimation = ret;
> +	}
> +
> +	prop->prescale = adc->data->adc_chans[prop->channel].prescale_index;
> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "%#x invalid pre-scaling <%d %d>\n",
> +				chan, varr[0], varr[1]);
> +		prop->prescale = ret;
> +	}
> +
> +	prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;

I'd prefer to see you has through the value that maps to this after qcom_adc5_hw_settle_time_from_dt
so then you can just set a default in value and call the rest of the code unconditionally.
Same for the cases that follow.

> +	ret = fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_hw_settle_time_from_dt(value,
> +						data->hw_settle_1);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "%#x invalid hw-settle-time %d us\n",
> +				chan, value);
> +		prop->hw_settle_time = ret;
> +	}
> +
> +	prop->avg_samples = VADC_DEF_AVG_SAMPLES;
> +	ret = fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_avg_samples_from_dt(value);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
> +				chan, value);
> +		prop->avg_samples = ret;
> +	}
> +
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
> +		prop->cal_method = ADC5_RATIOMETRIC_CAL;
> +	else
> +		prop->cal_method = ADC5_ABSOLUTE_CAL;
> +
> +	prop->timer = MEAS_INT_IMMEDIATE;
> +
> +	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm");
> +
> +	if (prop->adc_tm) {
> +		adc->n_tm_channels++;
> +		if (adc->n_tm_channels > ((adc->num_sdams * 8) - 1))
> +			return dev_err_probe(adc->dev, -EINVAL,
> +				"Number of TM nodes %u greater than channels supported:%u\n",
> +				adc->n_tm_channels, (adc->num_sdams * 8) - 1);
> +
> +		val = adc->n_tm_channels / 8;
> +		prop->sdam_index = val;
> +		prop->tm_chan_index = adc->n_tm_channels - (8*val);
> +
> +		prop->timer = MEAS_INT_1S;
> +	}
> +
> +	return 0;
> +}
>
> +static const struct of_device_id adc5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc5-gen3",
> +		.data = &adc5_gen3_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc5_match_table);
> +
> +static int adc5_get_fw_data(struct adc5_chip *adc)
> +{
> +	const struct adc5_channels *adc_chan;
> +	struct iio_chan_spec *iio_chan;
> +	struct adc5_channel_prop *chan_props;
> +	struct fwnode_handle *child;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	adc->nchannels = device_get_child_node_count(adc->dev);
> +	if (!adc->nchannels)
> +		return -EINVAL;
> +
> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
> +				       sizeof(*adc->iio_chans), GFP_KERNEL);
> +	if (!adc->iio_chans)
> +		return -ENOMEM;
> +
> +	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
> +					sizeof(*adc->chan_props), GFP_KERNEL);
> +	if (!adc->chan_props)
> +		return -ENOMEM;
> +
> +	chan_props = adc->chan_props;
> +	adc->n_tm_channels = 0;
> +	iio_chan = adc->iio_chans;
> +	adc->data = device_get_match_data(adc->dev);
> +	if (!adc->data)
> +		adc->data = &adc5_gen3_data_pmic;

Why do you need a default?  Add a comment so we remember the reasoning.


> +
> +	device_for_each_child_node(adc->dev, child) {
> +		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child, adc->data);
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
I've just sent out automated cleanup handling for this. Not a huge
saving here, but if you want to:
https://lore.kernel.org/linux-iio/20240101172611.694830-1-jic23@kernel.org/T/#t


> +			return ret;
> +		}
> +
> +		chan_props->chip = adc;
> +		chan_props->scale_fn_type =
> +			adc->data->adc_chans[chan_props->channel].scale_fn_type;
> +		adc_chan = &adc->data->adc_chans[chan_props->channel];
> +		iio_chan->channel = V_CHAN(*chan_props);
> +		iio_chan->info_mask_separate = adc_chan->info_mask;
> +		iio_chan->type = adc_chan->type;
> +		iio_chan->address = index;
> +		iio_chan->indexed = 1;
> +		iio_chan++;
> +		chan_props++;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i;
> +	u32 *reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->num_sdams = ret;
> +
> +	reg = kcalloc(adc->num_sdams, sizeof(u32), GFP_KERNEL);

> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read reg property, ret = %d\n", ret);
> +
> +	adc->base = devm_kcalloc(dev, adc->num_sdams, sizeof(*adc->base), GFP_KERNEL);
> +	if (!adc->base)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		adc->base[i].base_addr = reg[i];
> +
> +		adc->base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL, "adc-sdam%d", i);
> +		if (!adc->base[i].irq_name) {
> +			kfree(reg);
> +			ret = -ENOMEM;
> +			goto err_irq;
> +		}
> +
> +		ret = platform_get_irq_byname(pdev, adc->base[i].irq_name);
> +		if (ret < 0) {
> +			kfree(reg);
> +			dev_err(dev, "Getting IRQ %d by name failed, ret = %d\n",
> +					adc->base[i].irq, ret);
> +			goto err_irq;
> +		}
> +		adc->base[i].irq = ret;
> +
> +		ret = request_irq(adc->base[i].irq, adc5_gen3_isr, 0, adc->base[i].irq_name, adc);

Don't mix devm and non dev calls.  And don't group up multiple things in one devm callback
as it almost always leads to bugs where for example only some irqs are allocated.

> +		if (ret < 0) {
> +			kfree(reg);
> +			dev_err(dev, "Failed to request SDAM%d irq, ret = %d\n", i, ret);
> +			goto err_irq;
> +		}
> +	}
> +	kfree(reg);

I would factor out this code and allocation of reg so you can easily use scope
based cleanup (see linux/cleanup.h) to avoid the kfree(reg) entries that
make for awkward code flow.



> +
> +	ret = devm_add_action(dev, adc5_gen3_disable, adc);
As above, this action does multiple things. Also use devm_add_action_or_reset() to cleanup
if the devm registration fails without needing to do it manually.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to register adc disablement devm action, %d\n", ret);
> +		goto err_irq;
> +	}
> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret < 0) {
> +		dev_err(dev, "adc get dt data failed, ret = %d\n", ret);
> +		goto err_irq;

Fairly sure this results in a double free of the irqs.
Use devm_request_irq() in the first place and let the normal handling clean them
up both in the error path and in the remove path.

> +	}
> +
> +	ret = adc_tm_register_tzd(adc);
> +	if (ret < 0)
> +		goto err_irq;
> +
> +	if (adc->n_tm_channels)
> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);

Until this init work seems unlikely you should be calling the cancel
work in gen3_disable()


> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (!ret)
> +		return 0;
Please keep error conditions as the out of line path.

	if (ret)
		goto err_irq;

	return 0;


> +
> +err_irq:
> +	for (i = 0; i < adc->num_sdams; i++)
> +		free_irq(adc->base[i].irq, adc);

Already freed by a devm cleanup handler.

> +
> +	return ret;
> +}


