Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32A7F8CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjKYRxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjKYRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:53:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E7A8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:53:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC89C433C7;
        Sat, 25 Nov 2023 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700934805;
        bh=scTDkoEb1IwrT50Svg0HycC8i/y6B1eTtwKUotJCdpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fvM5UwSQK4ENk0FJJbr4F/+UkLiGG8zH/m1a/QEi+52Xfg1gOgQdJlDLjzcyn0TNS
         5/lx4mHuyQ5GwVniqV2Z7as5BJi5mC3Hyd9OggPMhpZg+mWcWNhsUkjcNcQsGJyWqs
         0qK1NSVJX+H2TqaraU6779B8cvEn0w3aljvVXZLEuN6inICBGHUb5YI8uE6D23tMkO
         l4LPSrUKx5SU2uKSCVIcA/UcWF3PRg6nFSiHS9qPhB7EvwOk4aN26gd9K57LfMWQCL
         6zkYPURlX5MrnMbr/XnyH2SDwiOoxPLFpNZPTuEWUCT9850yXlc5keTC1/ieSxAldT
         x4D5lGJPSqdQg==
Date:   Sat, 25 Nov 2023 17:53:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature
 sensor
Message-ID: <20231125175318.25c0d6ea@jic23-huawei>
In-Reply-To: <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
References: <cover.1700648164.git.cmo@melexis.com>
        <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 11:24:06 +0100
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

Very nice. A few minor bits inline.

Note (as normal for me), I haven't sanity checked any calibration maths - just assuming
you got that bit right as don't want to spend ages comparing datasheet maths to what
you have coded up + I'm not sure I can get the datasheet anyway :)

Jonathan

> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c

...

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Needed?  Rarely needed in a driver that hasn't had to do custom ABI and I don't
see any here.

> +
> +/* Control register2 address - volatile */
> +#define   MLX90635_REG_CTRL2   0x0016 /* Control Register2 address */
> +#define   MLX90635_CTRL2_BURST_CNT_SHIFT 6 /* Burst count */
> +#define   MLX90635_CTRL2_BURST_CNT_MASK GENMASK(MLX90635_CTRL2_BURST_CNT_SHIFT + 4, MLX90635_CTRL2_BURST_CNT_SHIFT)
> +#define   MLX90635_CTRL2_BURST(ctrl_val) (ctrl_val << MLX90635_CTRL2_BURST_CNT_SHIFT)
> +#define   MLX90635_CTRL2_MODE_SHIFT 11 /* Power mode */
> +#define   MLX90635_CTRL2_MODE_MASK GENMASK(MLX90635_CTRL2_MODE_SHIFT + 1, MLX90635_CTRL2_MODE_SHIFT)
> +#define   MLX90635_CTRL2_MODE(ctrl_val) (ctrl_val << MLX90635_CTRL2_MODE_SHIFT)
> +#define   MLX90635_CTRL2_SOB_SHIFT 15 /* Start burst measurement in step mode */
> +#define   MLX90635_CTRL2_SOB_MASK BIT(MLX90635_CTRL2_SOB_SHIFT)
> +#define   MLX90635_CTRL2_SOB(ctrl_val) (ctrl_val << MLX90635_CTRL2_SOB_SHIFT)

Can't do these with mask and FIELD_PREP() to simplify the macros + ensure any passed
in value doesn't overwrite neighbouring fields?




> +/* Magic constants */
> +#define MLX90635_ID_DSPv1 0x01 /* EEPROM DSP version */
> +#define MLX90635_RESET_CMD  0x0006 /**< Reset sensor (address or global) */

Why the /**< syntax?

> +#define MLX90635_MAX_MEAS_NUM   31 /**< Maximum number of measurements in list */
> +#define MLX90635_PTAT_DIV 12   /**< Used to divide the PTAT value in pre-processing */
> +#define MLX90635_IR_DIV 24   /**< Used to divide the IR value in pre-processing */
> +#define MLX90635_SLEEP_DELAY_MS 6000 /* Autosleep delay */
> +#define MLX90635_MEAS_MAX_TIME 2000 /* Max measurement time in ms for the lowest refresh rate */
> +#define MLX90635_READ_RETRIES 100 /* Number of read retries before quitting with timeout error */
> +#define MLX90635_VERSION_MASK (GENMASK(15, 12) | GENMASK(7, 4))
> +#define MLX90635_DSP_VERSION(reg) ((reg & GENMASK(6, 4)) >> 3)
> +#define MLX90635_DSP_FIXED (BIT(15))

Possible to have too many brackets. I'd drop them around the BIT()

> +



> +static int mlx90635_wakeup(struct mlx90635_data *data)
> +{
> +	s16 Fb, Ga, Gb, Ha, Hb, PG, PO;
> +	u32 Ea, Eb, Fa;
> +	u16 Fa_scale;
> +	int ret;
> +
> +	regcache_cache_bypass(data->regmap, false);
> +	ret = mlx90635_pwr_continuous(data);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Switch to continuous mode failed\n");
> +		return ret;
> +	}
> +	ret = regmap_write_bits(data->regmap, MLX90635_REG_EE, MLX90635_EE_ACTIVE, MLX90635_EE_ACTIVE);

Long line. Add a break somewhere sensible.

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Powering EEPROM failed\n");
> +		return ret;
> +	}
> +	usleep_range(MLX90635_TIMING_EE_ACTIVE_MIN, MLX90635_TIMING_EE_ACTIVE_MAX);
> +
> +	regcache_mark_dirty(data->regmap);
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to cache everything: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regcache_sync_region(data->regmap, MLX90635_EE_Ha, MLX90635_EE_Gb);

Why is this needed given you just synced the whole thing?

> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to sync EEEPROM region: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mlx90635_read_ee_ambient(data->regmap, &PG, &PO, &Gb);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to read to cache Ambient coefficients EEPROM region: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mlx90635_read_ee_object(data->regmap, &Ea, &Eb, &Fa, &Fb, &Ga, &Gb, &Ha, &Hb, &Fa_scale);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to read to cache Object coefficients EEPROM region: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_async_complete(data->regmap);

What is this syncing here for? Several calls above include internal calls to this.
My knowledge of this stuff is limited, so I may well be misunderstanding what this does.

> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to complete sync: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}

...

> +static int mlx90635_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);

Shouldn't do this in a modern driver because of fragility I mention below.
Use the generic stuff to access data if you need it (but you don't here).

> +	struct mlx90635_data *mlx90635;
> +	struct iio_dev *indio_dev;
> +	unsigned int dsp_version;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90635));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Failed to allocate device\n");
> +		return -ENOMEM;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &mlx90635_regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);

return dev_err_probe() for all messages in probe and things only called from probe.
It's neater, handles the ret printing and even does deferred handling correctly
if that's relevant.  Also, if you used it everywhere I don't have to think about
what might defer which makes for easier reviews :)

> +		return ret;
> +	}
> +
> +	mlx90635 = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	mlx90635->client = client;
> +	mlx90635->regmap = regmap;
> +	mlx90635->powerstatus = MLX90635_PWR_STATUS_SLEEP_STEP;
> +
> +	mutex_init(&mlx90635->lock);
> +	indio_dev->name = id->name;

Not keen on doing this as it can be fragile if id and of tables get out of sync
or we are using backwards compatibles in dt bindings.

Given only one part supported, just hard code the name for now.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mlx90635_info;
> +	indio_dev->channels = mlx90635_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mlx90635_channels);
> +
> +	mlx90635->regulator = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(mlx90635->regulator))
> +		return dev_err_probe(&client->dev, PTR_ERR(mlx90635->regulator),
> +				     "failed to get vdd regulator");
> +
> +	ret = mlx90635_enable_regulator(mlx90635);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&client->dev, mlx90635_disable_regulator,
> +				       mlx90635);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to setup regulator cleanup action %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = mlx90635_wakeup(mlx90635);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Wakeup failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&client->dev, mlx90635_sleep, mlx90635);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to setup low power cleanup action %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(mlx90635->regmap, MLX90635_EE_VERSION, &dsp_version);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "read of version failed: %d\n", ret);
> +		return ret;
> +	}

> +	dsp_version = dsp_version & MLX90635_VERSION_MASK;
FIELD_GET() always preferred as then I don't need to wonder if there is an offset for
the field or not as it will be handled correctly either way

> +	if (MLX90635_DSP_VERSION(dsp_version) == MLX90635_ID_DSPv1) {
> +		dev_dbg(&client->dev,
> +			"Detected DSP v1 calibration %x\n", dsp_version);
> +	} else if ((dsp_version & MLX90635_DSP_FIXED) == MLX90635_DSP_FIXED) {

FIELD_GET() for that bit then just check if it is 0 or 1

> +		dev_dbg(&client->dev,
> +			"Detected Unknown EEPROM calibration %lx\n", MLX90635_DSP_VERSION(dsp_version));
> +	} else {
> +		dev_err(&client->dev,
> +			"Wrong fixed top bit %lx (expected 0x8X0X)\n",
> +			dsp_version & MLX90635_DSP_FIXED);

I'd like to understand what breaks if this happens but we carry on anyway?
I'd 'hope' that any future DSP version is backwards compatible or that there was some way to know if
the difference between backwards compatible versions and ones that aren't.

> +		return -EPROTONOSUPPORT;
> +	}
...


> +
> +static const struct i2c_device_id mlx90635_id[] = {
> +	{ "mlx90635", 0 },

The 0 is unnecessary so I'd drop it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90635_id);
> +
> +static const struct of_device_id mlx90635_of_match[] = {
> +	{ .compatible = "melexis,mlx90635" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mlx90635_of_match);

Thanks,

Jonathan
