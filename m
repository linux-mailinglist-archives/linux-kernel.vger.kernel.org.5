Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1809D7DA7BD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjJ1PVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:21:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BA4CE;
        Sat, 28 Oct 2023 08:21:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E07FC433C7;
        Sat, 28 Oct 2023 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698506464;
        bh=rJTXFEs1yguZwtTfGfNbMld+pd0HMbQHSr3a4C8F7Ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oAt9KsNTcA47YWQE/UIUsrg145xB+CMuCUktVbblf2N3xPayJ1uKbQWgR9yIkifxN
         oq7HQZLfs3jirte12heS7kN4s/tlKGo02s6L3bM6kUCdSnIItk+klCg8PKNi2049mw
         gC61efDPNWzTFCbFpXsz6RxX2RQwRDD7M0d6v2zQdA9Ws1LVn0Cz4KUEDkAjg5roXA
         gi645jZzAxL58kzEcmEwMYRgSzBOi9B28DlyEVkAThHWDKg+lptvG3FVn+JjrtiQCo
         6Taqf9hL4N8K5cekpYgidS8BM4bmmealI9+fo6xYEoy2vV84siDYRp2h7fIJZxhG17
         3mtNzb6HusYgA==
Date:   Sat, 28 Oct 2023 16:20:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20231028162025.4259f1cc@jic23-huawei>
In-Reply-To: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
        <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
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

On Fri, 27 Oct 2023 18:15:45 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
> and clear channels with i2c interface. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.

Hi Subhajit,


> 
Change log below the --- 

We don't generally want to end up with this information in the git log
and anything above the --- is used for the commit message.

Note that if you want to keep notes in your local git it is fine adding

Signed-of-by...

---

Version notes
etc


As then git am will drop them anyway when your patches are picked up.


> v1 -> v2
> - Renamed probe_new to probe
> - Removed module id table
> 
> v0 -> v1
> - Fixed errors as per previous review
> - Longer commit messages and descriptions
> - Updated scale calculations as per iio gts scheme to export proper scale
>   values and tables to userspace
> - Removed processed attribute for the same channel for which raw is
>   provided, instead, exporting proper scale and scale table to userspace so
>   that userspace can do "(raw + offset) * scale" and derive Lux values
> - Fixed IIO attribute range syntax
> - Keeping the regmap lock enabled as the driver uses unlocked regfield
>   accesses from interrupt handler
> - Several levels of cleanups by placing guard mutexes in proper places and
>   returning immediately in case of an error
> - Using iio_device_claim_direct_mode() during raw reads so that
>   configurations could not be changed during an adc conversion period
> - In case of a powerdown error, returning immediately
> - Removing the definition of direction of the hardware interrupt and
>   leaving it on to device tree
> - Adding the powerdown callback after doing device initialization
> - Removed the regcache_cache_only() implementation
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

More comments inline.

> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..ae79d3b1129d
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c
> @@ -0,0 +1,1326 @@

...

> +#define APDS9306_INT_CFG		0x19
> +#define APDS9306_INT_PERSISTENCE	0x1A
> +#define APDS9306_ALS_THRES_UP_0		0x21
> +#define APDS9306_ALS_THRES_UP_1		0x22
> +#define APDS9306_ALS_THRES_UP_2		0x23
> +#define APDS9306_ALS_THRES_LOW_0	0x24
> +#define APDS9306_ALS_THRES_LOW_1	0x25
> +#define APDS9306_ALS_THRES_LOW_2	0x26
> +#define APDS9306_ALS_THRES_VAR		0x27

Naming doesn't make it clear what is a field and what is a register address
_REG or _ADDR as a postfix for register addresses tends to make that clear.

> +
> +#define APDS9306_ALS_INT_STAT_MASK	BIT(4)
> +#define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
Naming doesn't make it clear which register these are in and
it definitely should.

> +
> +#define APDS9306_ALS_THRES_VAL_MAX	0xFFFFF
> +#define APDS9306_ALS_THRES_VAR_VAL_MAX	7
> +#define APDS9306_ALS_PERSIST_VAL_MAX	15
> +#define APDS9306_ALS_READ_DATA_DELAY_US	20000
> +
> +enum apds9306_power_states {
> +	STANDBY,
> +	ACTIVE,

Effectively on vs off: I'd just use a boolean.

> +};

> +/**
> + * apds9306_repeat_rate_freq - Sampling Frequency in uHz
> + */
> +static const int apds9306_repeat_rate_freq[][2] = {
> +	{40, 0},
> +	{20, 0},
> +	{10, 0},
> +	{5,  0},
> +	{2,  0},
> +	{1,  0},
> +	{0, 500000},
> +};
> +
> +/**
> + * apds9306_repeat_rate_period - Sampling period in uSec
> + */
> +static const int apds9306_repeat_rate_period[] = {
> +	25000, 50000, 100000, 200000, 500000, 1000000, 2000000
> +};
> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> +	      ARRAY_SIZE(apds9306_repeat_rate_period));
> +
> +/**
> + * struct apds9306_data - apds9306 private data and registers definitions
> + *
> + * All regfield definitions are named exactly according to datasheet for easy
> + * search
> + *
> + * @dev:	Pointer to the device structure
> + * @gts:	IIO Gain Time Scale structure
> + * @mutex:	Lock for protecting register access, adc reads and power
> + * @regmap:	Regmap structure pointer
> + * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
> + * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
> + * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
> + * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
> + * @regfield_scale:	Reg: ALS_GAIN, Field: ALS Gain Range
> + * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
> + * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
> + * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
> + * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
> + * @regfield_int_thresh_var_val:	Reg: ALS_THRSH_VAR, Field: ALS_THRES_VAR
> + * @nlux_per_count:	nano lux per ADC count for a particular model
> + * @read_data_available:	Flag set by IRQ handler for ADC data available
> + * @intg_time_idx:	Array index for integration times
> + * @repeat_rate_idx:	Array index for sampling frequency
> + * @gain_idx:	Array index for gain
> + * @int_ch:	Currently selected Interrupt channel
> + */
> +struct apds9306_data {
> +	struct device *dev;
> +	struct iio_gts gts;
> +	/*
> +	 * Protects device settings changes where some calculations are required
> +	 * before or after setting or getting the raw settings values from regmap
> +	 * writes or reads respectively.
> +	 */
> +	struct mutex mutex;
> +
> +	struct regmap *regmap;
> +	struct regmap_field *regfield_sw_reset;
> +	struct regmap_field *regfield_en;
> +	struct regmap_field *regfield_intg_time;
> +	struct regmap_field *regfield_repeat_rate;
> +	struct regmap_field *regfield_scale;
> +	struct regmap_field *regfield_int_src;
> +	struct regmap_field *regfield_int_thresh_var_en;
> +	struct regmap_field *regfield_int_en;
> +	struct regmap_field *regfield_int_persist_val;
> +	struct regmap_field *regfield_int_thresh_var_val;
> +
> +	int nlux_per_count;
> +	int read_data_available;
> +	u8 intg_time_idx;
> +	u8 repeat_rate_idx;
> +	u8 gain_idx;

As mentioned below, I'm not sure why you need to cache these instead
of just reading the fields back from the regmap cache or the device.
 
> +	u8 int_ch;
> +};
> +
...

> +static struct iio_event_spec apds9306_event_spec_als[] = {
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
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
This matches an entry above for type. Don't have separate entries.
> +	},
> +};
> +
> +static struct iio_event_spec apds9306_event_spec_clear[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define APDS9306_CHANNEL(_type) \
> +	.type = _type, \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \

Scale on the intensity channel is interesting...  What are the units?
There tend not to be any well defined units for intensity (as opposed
to illuminance).  There may be gain on the signal, but it won't be in untils
that map directly to a scale userspace should apply.  This is one of the
rare reasons for using the HARDWARE_GAIN element of the ABI.

A tricky corner however as relationship between raw value and hardwaregain
is not tightly defined (as it can be really weird!)

> +
> +static struct iio_chan_spec apds9306_channels_without_events[] = {
> +	{
> +		APDS9306_CHANNEL(IIO_LIGHT)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		APDS9306_CHANNEL(IIO_INTENSITY)
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +	},
> +};



> +
> +static int apds9306_runtime_power(struct apds9306_data *data, int en)

Why int?  bool seems a better fit.

> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	if (en) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime resume failed: %d\n", ret);
> +			return ret;
> +		}
> +		return 0;
The two paths are entirely unrelated so split power up from power down as two
different functions. Only the power up can actually fail.

> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

Feels like we should suggest a generic version of this given it's such a common pair
I guess the biggest problem would be naming it.

	pm_runtime_mark_and_put_autosuspend() maybe?

Anyhow, that's a question for another day.

> +	return 0;
> +}
> +
> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{
> +	struct device *dev = data->dev;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int ret, delay, intg_time, status = 0;
> +	u8 buff[3];
> +
> +	ret = apds9306_runtime_power(data, 1);
> +	if (ret)
> +		return ret;
> +
> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts,
> +						 data->intg_time_idx);

Feels like caching the intg_time is potentially useful unlike the idx
which can be gotten easily from the register cache.  I haven't checked
how complex looking it up like this is though, so may not be worth bothering.

> +	if (intg_time < 0)
> +		delay = apds9306_repeat_rate_period[data->repeat_rate_idx];
> +
> +	/*
> +	 * Whichever is greater - integration time period or
> +	 * sampling period.
> +	 */
> +	delay = max(intg_time,
> +		    apds9306_repeat_rate_period[data->repeat_rate_idx]);
> +
> +
> +	/*
> +	 * Clear stale data flag that might have been set by the interrupt
> +	 * handler if it got data available flag set in the status reg.
> +	 */
> +	data->read_data_available = 0;
> +
> +	/*
> +	 * If this function runs parallel with the interrupt handler, either
> +	 * this reads and clears the status registers or the interrupt handler
> +	 * does. The interrupt handler sets a flag for read data available
> +	 * in our private structure which we read here.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS,
> +				status, (status & (APDS9306_ALS_DATA_STAT_MASK |
> +				APDS9306_ALS_INT_STAT_MASK)) ||
> +				data->read_data_available,
> +				APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* If we reach here before the interrupt handler we push an event */
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +			       data->int_ch,
> +			       IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +
> +	if ((status & APDS9306_ALS_DATA_STAT_MASK) ||
> +		data->read_data_available) {

If these aren't true isn't it an error that we should report?
	if (!(status & APDS9306_ALS_DATA_STAT_MASK) &&
            !data->read_data_available)
		return -EIO; //maybe indicated timed out?

	ret = regmap
	
> +		ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +		if (ret) {
> +			dev_err(dev, "read data failed\n");
> +			return ret;
> +		}
> +		*val = get_unaligned_le24(&buff);
> +	}
> +
> +	return apds9306_runtime_power(data, 0);
The fact this looks like it can fail is an artefact of combining power up and power down.
	apds9306_runtime_power_down(data);
	
	return 0; 

would make it clear that it can't.

> +}
> +

> +
> +static int apds9306_intg_time_set_hw(struct apds9306_data *data, int sel)
> +{
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfield_intg_time, sel);

Given regmap comes with excellent caching and you have that turned on,
what is the advantage of having your own cache of the value?

I'd just use regmap_field_read() to get it back where you need it.
Having made that change, this wrapper becomes unnecessary and yuo can
just call regmap_field_write() directly wherever it is currently called.

Same applies for all the other caching of status in the driver. If you
can rely on the generic register caching it normally ends ups simpler
than rolling your own.

> +	if (ret)
> +		return ret;
> +
> +	data->intg_time_idx = sel;
> +
> +	return ret;
> +}


> +static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
> +				int val2)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
> +		if (apds9306_repeat_rate_freq[i][0] == val &&
> +				apds9306_repeat_rate_freq[i][1] == val2) {

Align the second line of this with the first one
		if (apds9306_repeat_rate_freq[i][0] == val &&
		    apds9306_repeat_rate_freq[i][1] == val2) {

> +			ret = regmap_field_write(data->regfield_repeat_rate, i);
> +			if (ret)
> +				return ret;
> +			data->repeat_rate_idx = i;
> +			return ret;
> +		}
> +
> +	return ret;
> +}

> +static int apds9306_scale_set(struct apds9306_data *data, int val, int val2)
> +{
> +	int i, ret, time_sel, gain_sel;
> +
> +	/* Rounding up the last digit by one, otherwise matching table fails! */

Interesting.  Sounds like a question for Matti?

> +	if (val2 % 10)
> +		val2 += 1;
> +
> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
> +				     data->intg_time_idx, val, val2, &gain_sel);
> +	if (ret) {
> +		for (i = 0; i < data->gts.num_itime; i++) {
> +			time_sel = data->gts.itime_table[i].sel;
> +
> +			if (time_sel == data->intg_time_idx)
> +				continue;
> +
> +			ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
> +						time_sel, val, val2, &gain_sel);
> +			if (!ret)
> +				break;
> +		}
> +		if (ret)
> +			return -EINVAL;
> +
> +		ret = apds9306_intg_time_set_hw(data, time_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return apds9306_gain_set_hw(data, gain_sel);
> +}

> +
> +static int apds9306_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		mutex_lock(&data->mutex);

Lock taken in all 'real' paths as the default won't actually happen.
So take it outside the switch and use guard() to all direct returns.

> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			ret = apds9306_event_period_set(data, val);
> +		else
> +			ret = apds9306_event_thresh_set(data, dir, val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		mutex_lock(&data->mutex);
> +		ret = apds9306_event_thresh_adaptive_set(data, val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	unsigned int int_en;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
guard()

and direct returns to simplify this.

> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		ret = regmap_field_read(data->regfield_int_en, &int_en);
> +		if (ret)
> +			break;
> +		if (chan->type == IIO_LIGHT)
> +			ret = int_en & data->int_ch;
> +		else if (chan->type == IIO_INTENSITY)
> +			ret = int_en & !data->int_ch;
> +		else
> +			ret = -EINVAL;
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_read(data->regfield_int_thresh_var_en,
> +					&int_en);
> +		if (ret)
> +			break;
> +		ret = int_en;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, int_sel;
> +
> +	state = !!state;
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		/*
> +		 * If interrupt is enabled, the channel is set before enabling
> +		 * the interrupt. In case of disable, no need to switch
> +		 * channels. In case of different channel is selected while
> +		 * interrupt in on, just changing the channel.
> +		 */
> +		if (state) {
> +			if (chan->type == IIO_LIGHT)
> +				int_sel = 1;
> +			else if (chan->type == IIO_INTENSITY)
> +				int_sel = 0;
> +			else
> +				return -EINVAL;
> +
> +			ret = regmap_field_write(data->regfield_int_src,
> +						 int_sel);
> +			if (ret)
> +				return ret;
> +			data->int_ch = int_sel;
> +		}
> +		ret = regmap_field_read(data->regfield_int_en, &int_sel);
> +		if (ret)
> +			return ret;
> +		if (int_sel == state)
Not obvious why you are comparing the enabled state of a channel with the
interrupt selection.  Which might not be set by here anyway.

> +			return 0;
> +		mutex_lock(&data->mutex);
> +		ret = regmap_field_write(data->regfield_int_en, state);
> +		if (!ret)
> +			ret = apds9306_runtime_power(data, state);

This bit is confusing in a way that would be cleaned up by...

		scoped_guard(mutex, &data->mutex) {
			ret = regmap_field_write();
			if (ret)
				return ret;
			return apds9360_runtime_power();
		}

		or simply
		guard(mutex)(&data->mutex);
		ret = regmap_field_write();
		if (ret)
			return ret;
	...


		but I think you need to add brackets to whole case statement for that
		to work as expected.


> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return regmap_field_write(data->regfield_int_thresh_var_en,
> +					  state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define APDS9306_IIO_INFO \
> +	.read_avail = apds9306_read_avail, \
> +	.read_raw = apds9306_read_raw, \
> +	.write_raw = apds9306_write_raw, \
> +	.write_raw_get_fmt = apds9306_write_raw_get_fmt,

I'd not bother with this macro.  It saves very little actual
code and makes things a tiny bit harder to read.

> +
> +static const struct iio_info apds9306_info_no_events = {
> +	APDS9306_IIO_INFO
> +};
> +
> +static const struct iio_info apds9306_info = {
> +	APDS9306_IIO_INFO
> +	.event_attrs = &apds9306_event_attr_group,
> +	.read_event_value = apds9306_read_event,
> +	.write_event_value = apds9306_write_event,
> +	.read_event_config = apds9306_read_event_config,
> +	.write_event_config = apds9306_write_event_config,
> +};

> +static void apds9306_powerdown(void *ptr)
> +{
> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	int ret;
> +
> +	/* Disable interrupts */

As below. The field names hopefully make that obvious so the comment not needed
and just becomes something that can become wrong as the driver evolves.

> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +	if (ret)
> +		return;
> +	ret = regmap_field_write(data->regfield_int_en, 0);
> +	if (ret)
> +		return;

> +	/* Put the device in standby mode */

This one is even more obvious.

> +	apds9306_power_state(data, STANDBY);
> +}
> +
> +static int apds9306_init_device(struct apds9306_data *data)
> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	ret = apds9306_power_state(data, ACTIVE);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 5000);
> +	pm_runtime_use_autosuspend(dev);
this lot of runtime pm stuff isn't initializing the device, so I don't
see it as making sense in here. I'd push it out to the caller with
the power up before init and the autosuspend etc after.
I'll note that I'd expect to see a a pm_runtime_put_autosuspend()
at the end of probe to put device to sleep soon after loading.

> +
> +	/* Init GTS multiplier values according to Part ID */
> +	ret = apds9306_init_iio_gts(data);
> +	if (ret)
> +		return ret;
> +
> +	/* Integration time: 100 msec */
> +	ret = apds9306_intg_time_set_hw(data, 2);
Define as below.

> +	if (ret)
> +		return ret;
> +
> +	/* Sampling frequency: 100 msec, 10 Hz */
> +	ret = apds9306_sampling_freq_set(data, 10, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Scale: x3 */
> +	ret = apds9306_gain_set_hw(data, 1);
As per note below, this is one where the value written isn't 'obvious'.
A good indication that the code could be made more readable.
	ret = apds9306_gain_set_hw(data, APDS9306_GSEL_3X);

for example.

> +	if (ret)
> +		return ret;
> +
> +	/* Interrupt source channel: als */
> +	ret = regmap_field_write(data->regfield_int_src, 1);
I've not checked the datasheet, but this feels like the 1 is
probably a selection value that should have a define like you
have for the GSEL values.  Do that and hopefully the comment
is no longer necessary.

> +	if (ret)
> +		return ret;
> +	data->int_ch = 1;
> +
> +	/* Interrupts disabled */
> +	ret = regmap_field_write(data->regfield_int_en, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Threshold Variance disabled */
Ideal situation is that the code itself makes it obvious what is going on,
reducing need for comments.  Long experience tells me that comments that
add little information and just an opportunity for code rot!

This is a good example. Setting a field called int_thresh_var_en to 0
seems pretty clear without the comment.

Consider all the other similar cases and just keep the ones that non obvious.
In some cases that means using some defines to make the code obvious.

> +	return regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +}


> +
> +static int apds9306_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);

As below.

> +
> +	return apds9306_power_state(data, STANDBY);
> +}
> +
> +static int apds9306_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);

You could combine these lines without significant loss of readability.

	struct apds9306_data *data = iio_priv(dev_get_drvdata(dev));

> +
> +	return apds9306_power_state(data, ACTIVE);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
> +				 apds9306_runtime_suspend,
> +				 apds9306_runtime_resume,
> +				 NULL);


> +static struct i2c_driver apds9306_driver = {
> +	.driver = {
> +		.name = "apds9306",
> +		.pm = pm_ptr(&apds9306_pm_ops),
> +		.of_match_table = apds9306_of_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

Async probe may make sense, but it's not necessarily an obvious choice.
Add a brief comment on why.

> +	},
> +	.probe = apds9306_probe,
> +};
> +module_i2c_driver(apds9306_driver);
> +
> +MODULE_AUTHOR("Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>");
> +MODULE_DESCRIPTION("APDS9306 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_GTS_HELPER);

