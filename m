Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3E803670
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbjLDOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345322AbjLDOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB5188
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CBDC433C9;
        Mon,  4 Dec 2023 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701699752;
        bh=3n4i410mggPAAYaBM0kmUSf9QTqNnDLfn4x5PMzKFx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TriP1YR8RAKeEP8u8woDKiJ+l4trAggyVSah2xjdblXTvTGCbMWpsAC/we/GesOr4
         68xipNSThtldH4W8Mc7MxKCOokL1UcowKr/ziNACcNwL6G2lYSxiY1dCs1eddRt8td
         aIcJzNKWhUSJKglaO0RBUgQyQjjQdmFG74bjfttq5spjIIkxmIIZhhD5UgIKhHR7Kc
         b+LY3lwfpOMrSY6mTlQ+svDqrwMwnrLcWF1fHAMrjQvyy5JBLL7puTtCqOZ1TkRBbt
         fbgXoh6JfQ/uo82v5mgYRDS9BoFn2oN0Pb02BE5I9WwMTHjCRoZdKsIJ/z5kA+gB71
         vEwiLBNM0xODA==
Date:   Mon, 4 Dec 2023 14:22:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR
 Temperature sensor
Message-ID: <20231204142224.51f2ccdf@jic23-huawei>
In-Reply-To: <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
References: <cover.1701168726.git.cmo@melexis.com>
        <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 12:02:22 +0100
Crt Mori <cmo@melexis.com> wrote:

> MLX90635 is an Infra Red contactless temperature sensor most suitable
> for consumer applications where measured object temperature is in range
> between -20 to 100 degrees Celsius. It has improved accuracy for
> measurements within temperature range of human body and can operate in
> ambient temperature range between -20 to 85 degrees Celsius.
> 
> Driver provides simple power management possibility as it returns to
> lowest possible power mode (Step sleep mode) in which temperature
> measurements can still be performed, yet for continuous measuring it
> switches to Continuous power mode where measurements constantly change
> without triggering.
> 
> Signed-off-by: Crt Mori<cmo@melexis.com>

Hi Crt,

I don't understand some of the regcache_cache_only() manipulation in here.
If I understand the aim correctly it is to allow us to write settings whilst
powered down (in sleep_step) that will then by synced to the device when it enters
continuous mode?

If so, I'd expect to only see manipulation of whether the caching is or or
not at places where we transition state.  You currently have them in various
other place. In some cases I scan see it's to allow a temporary change of
state, but it's not obvious.  So perhaps a comment ever time you manually
tweak whether writes hit the device or just stick in the regacache.
That comment can explain why each of them is needed.

A few other comments inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 9330d4a39598..07d6e65709f7 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MCP9600) += mcp9600.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
> +obj-$(CONFIG_MLX90632) += mlx90635.o
>  obj-$(CONFIG_TMP006) += tmp006.o
>  obj-$(CONFIG_TMP007) += tmp007.o
>  obj-$(CONFIG_TMP117) += tmp117.o
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> new file mode 100644
> index 000000000000..7db8798aa345
> --- /dev/null
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -0,0 +1,1071 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mlx90635.c - Melexis MLX90635 contactless IR temperature sensor
> + *
> + * Copyright (c) 2023 Melexis <cmo@melexis.com>
> + *
> + * Driver for the Melexis MLX90635 I2C 16-bit IR thermopile sensor
> + */
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/math64.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +
...

> +/* Control register2 address - volatile */
> +#define   MLX90635_REG_CTRL2   0x0016 /* Control Register2 address */
> +#define   MLX90635_CTRL2_BURST_CNT_SHIFT 6 /* Burst count */

It very rarely makes sense to have a _SHIFT macro now we have GENMASK() that will encode
it anyway.
#define   MLX90635_CTRL2_BURST_CND_MASK GENMASK(10, 6)
is something we can easily compare with the datasheet.  Same applies to all the other _SHIFT
defines in here.

> +#define   MLX90635_CTRL2_BURST_CNT_MASK GENMASK(MLX90635_CTRL2_BURST_CNT_SHIFT + 4, MLX90635_CTRL2_BURST_CNT_SHIFT)
> +#define   MLX90635_CTRL2_MODE_SHIFT 11 /* Power mode */
> +#define   MLX90635_CTRL2_MODE_MASK GENMASK(MLX90635_CTRL2_MODE_SHIFT + 1, MLX90635_CTRL2_MODE_SHIFT)
> +#define   MLX90635_CTRL2_SOB_SHIFT 15 /* Start burst measurement in step mode */
> +#define   MLX90635_CTRL2_SOB_MASK BIT(MLX90635_CTRL2_SOB_SHIFT)
> +
> +/* PowerModes statuses */
> +#define MLX90635_PWR_STATUS_HALT 0 /* Pwrmode hold */
> +#define MLX90635_PWR_STATUS_SLEEP_STEP 1 /* Pwrmode sleep step*/
> +#define MLX90635_PWR_STATUS_STEP 2 /* Pwrmode step */

The comments here add little given the define names are covering that information
already I think.  Keep them for non obvious cases.


> +#define MLX90635_PWR_STATUS_CONTINUOUS 3 /* Pwrmode continuous*/
> +
> +/* Measurement data addresses */
> +#define MLX90635_RESULT_1   0x0002
> +#define MLX90635_RESULT_2   0x0004
> +#define MLX90635_RESULT_3   0x0006
> +#define MLX90635_RESULT_4   0x0008
> +#define MLX90635_RESULT_5   0x000A
> +
> +/* Timings (ms) */
> +#define MLX90635_TIMING_RST_MIN 200 /* Minimum time after addressed reset command */
> +#define MLX90635_TIMING_RST_MAX 250 /* Maximum time after addressed reset command */
> +#define MLX90635_TIMING_POLLING 10000 /* Time between bit polling*/
> +#define MLX90635_TIMING_EE_ACTIVE_MIN 100 /* Minimum time after activating the EEPROM for read */
> +#define MLX90635_TIMING_EE_ACTIVE_MAX 150 /* Maximum time after activating the EEPROM for read */
> +
> +/* Magic constants */
> +#define MLX90635_ID_DSPv1 0x01 /* EEPROM DSP version */
> +#define MLX90635_RESET_CMD  0x0006 /* Reset sensor (address or global) */
> +#define MLX90635_MAX_MEAS_NUM   31 /* Maximum number of measurements in list */
> +#define MLX90635_PTAT_DIV 12   /* Used to divide the PTAT value in pre-processing */
> +#define MLX90635_IR_DIV 24   /* Used to divide the IR value in pre-processing */
> +#define MLX90635_SLEEP_DELAY_MS 6000 /* Autosleep delay */
> +#define MLX90635_MEAS_MAX_TIME 2000 /* Max measurement time in ms for the lowest refresh rate */
> +#define MLX90635_READ_RETRIES 100 /* Number of read retries before quitting with timeout error */
> +#define MLX90635_VERSION_MASK (GENMASK(15, 12) | GENMASK(7, 4))
> +#define MLX90635_DSP_VERSION(reg) (((reg & GENMASK(14,12)) >> 9) | ((reg & GENMASK(6, 4)) >> 4))
> +#define MLX90635_DSP_FIXED BIT(15)
> +
> +
> +/**
> + * struct mlx90635_data - private data for the MLX90635 device
> + * @client: I2C client of the device
> + * @lock: Internal mutex for multiple reads for single measurement

Multiple reads shouldn't be a problem, unless someone else can do something
destructive in between.  Perhaps a little more detail on why multiple reads matter?

> + * @regmap: Regmap of the device
> + * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
> + * @regulator: Regulator of the device
> + * @powerstatus: Current POWER status of the device
> + * @interaction_ts: Timestamp of the last temperature read that is used
> + *		    for power management in jiffies
> + */
> +struct mlx90635_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	u16 emissivity;
> +	struct regulator *regulator;
> +	int powerstatus;
> +	unsigned long interaction_ts;
> +};

...

> +
> +static int mlx90635_pwr_sleep_step(struct mlx90635_data *data)
> +{
> +	int ret;
> +
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +		return 0;
> +
> +	ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL2, MLX90635_CTRL2_MODE_MASK,
> +				FIELD_PREP(MLX90635_CTRL2_MODE_MASK, MLX90635_PWR_STATUS_SLEEP_STEP));
> +	if (ret < 0)
> +		return ret;
> +
> +	regcache_cache_only(data->regmap, true);
> +
> +	data->powerstatus = MLX90635_PWR_STATUS_SLEEP_STEP;
> +	return 0;
> +}
> +
> +static int mlx90635_pwr_continuous(struct mlx90635_data *data)
> +{
> +	int ret;
> +
> +	if (data->powerstatus == MLX90635_PWR_STATUS_CONTINUOUS)
> +		return 0;
> +
> +	regcache_cache_only(data->regmap, false);
> +
> +	ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL2, MLX90635_CTRL2_MODE_MASK,
> +				FIELD_PREP(MLX90635_CTRL2_MODE_MASK, MLX90635_PWR_STATUS_CONTINUOUS));
> +	if (ret < 0)
> +		return ret;
> +
> +	data->powerstatus = MLX90635_PWR_STATUS_CONTINUOUS;
> +	return 0;
> +}
> +


> +
> +static int mlx90635_read_all_channel(struct mlx90635_data *data,
> +				     s16 *ambient_new_raw, s16 *ambient_old_raw,
> +				     s16 *object_raw)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
> +		regcache_cache_only(data->regmap, false);
> +		ret = mlx90635_perform_measurement_burst(data);

Why is a burst needed here?  Perhaps a comment?

> +		if (ret < 0)
> +			goto read_unlock;
> +	}
> +
> +	ret = mlx90635_read_ambient_raw(data->regmap, ambient_new_raw,
> +					ambient_old_raw);
> +	if (ret < 0)
> +		goto read_unlock;
> +
> +	ret = mlx90635_read_object_raw(data->regmap, object_raw);
> +read_unlock:
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +		regcache_cache_only(data->regmap, true);
> +
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}

> +
> +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> +				     unsigned int *refresh_rate)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +		regcache_cache_only(data->regmap, false);

Definitely needs a comment on why this is needed in this case.

> +
> +	ret = regmap_read(data->regmap, MLX90635_REG_CTRL1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +		regcache_cache_only(data->regmap, true);
> +
> +	*refresh_rate = FIELD_GET(MLX90635_CTRL1_REFRESH_RATE_MASK, reg);
> +
> +	return 0;
> +}
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} mlx90635_freqs[] = {
> +	{0, 200000},
Prefer spaces after { and before }
> +	{0, 500000},
> +	{0, 900000},
> +	{1, 700000},
> +	{3, 0},
> +	{4, 800000},
> +	{6, 900000},
> +	{8, 900000}
> +};

> +
> +static int mlx90635_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *channel, int val,
> +			      int val2, long mask)
> +{
> +	struct mlx90635_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBEMISSIVITY:
> +		/* Confirm we are within 0 and 1.0 */
> +		if (val < 0 || val2 < 0 || val > 1 ||
> +		    (val == 1 && val2 != 0))
> +			return -EINVAL;
> +		data->emissivity = val * 1000 + val2 / 1000;
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(mlx90635_freqs); i++) {
> +			if (val == mlx90635_freqs[i].val &&
> +			    val2 == mlx90635_freqs[i].val2)
> +				break;
> +		}
> +		if (i == ARRAY_SIZE(mlx90635_freqs))
> +			return -EINVAL;
> +
> +		if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +			regcache_cache_only(data->regmap, false);

So here you want the rate to get through even though we otherwise have the
device powered down?  Is that because some registers are safe for writes
and not others?  If so you may need some locking to stop a race where you
turn on writes here and someone else writes.

> +
> +		ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL1,
> +					MLX90635_CTRL1_REFRESH_RATE_MASK, i);
> +
> +		if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> +			regcache_cache_only(data->regmap, true);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

