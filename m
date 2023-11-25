Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D257F8EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKYUiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:38:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F8110
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 12:38:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CD3C433C8;
        Sat, 25 Nov 2023 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700944685;
        bh=Nf3+NsnqpLjXFYnH/sDpw0idmTDPfpumCR2bBfXrNd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=klOEmQs0bVbtj9IBgd5GsZtz2Z//nMJM0lpceiIebOLZI24HNLTW5hUrPm/PVgDH1
         1+9eroBzNjDVcb5N2nfP5FGGudW/mU/aqqoG893fpFUfB6F6zzLMn1SSV7omlsg6n7
         4eayRMOKUsz3fho3BXC9y7hTgGlPyF/vvhLHDbwL1C8NPqO4Oj/sCvDqp6vxP+C+Ch
         kGrTI7k63/mcp8u1lo27NigdrXqX03AgnJmVEdYT6fXykCjI4w7XHTn4K2yLC5ZXA5
         MUaM5gmiLn4JAsyWvger+F7gTzGkuEdf2xex6+TmrbaXtrhj+lUF9vzh2KUY0bJwf5
         I8MFJN2y3RDgQ==
Date:   Sat, 25 Nov 2023 20:37:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC193x
Message-ID: <20231125203755.27b14707@jic23-huawei>
In-Reply-To: <20231115134453.6656-3-marius.cristea@microchip.com>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
        <20231115134453.6656-3-marius.cristea@microchip.com>
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

On Wed, 15 Nov 2023 15:44:53 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1934     |   15 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac1934.c                     | 1673 +++++++++++++++++
>  5 files changed, 1708 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
>  create mode 100644 drivers/iio/adc/pac1934.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> new file mode 100644
> index 000000000000..533429eaac6a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_X
> +KernelVersion:	6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime and set
> +		by a client application. This attribute allows to set its value
> +		in micro-ohms. X is the IIO index of the device. The value is
> +		used to calculate current, power and accumulated energy.
Why the device being in the directory name and the shunt resistor name?

If you drop that, we need to move this abi to a more generic file because
we can't have duplicate entries in the ABI directory.
sysfs-bus-iio-power-mon or similar would do then remove the entries elsewhere.

Or does it mean channel index? In which case don't use X.

I'd love to make shunt resistor a DT problem... I guess that's a non starter
because of potential calibrations etc?


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/reset_accumulators
> +KernelVersion:	6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing any value resets the accumulated power device's statistics
> +		for all enabled channels.

Hmm. We have used channel enables for this before. Might be better to map to that
though it's a bit inelegant to have a write of 1 to in_powerY_enable reset a bunch of
other channels.

I'm not sure if we have an precedent that aligns perfectly with this.
Closest is step counters were we do use enable, but then the reset only covers one
clearly defined channel.

Having in_enable seems a bit odd as I assume some channels don't involve accumulation...

> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> new file mode 100644
> index 000000000000..d2be205c3cb4
> --- /dev/null
> +++ b/drivers/iio/adc/pac1934.c
> @@ -0,0 +1,1673 @@

> +
> +#define PAC1934_MAX_NUM_CHANNELS		4
> +#define PAC1934_CH_1				0
> +#define PAC1934_CH_2				1
> +#define PAC1934_CH_3				2
> +#define PAC1934_CH_4				3

The channel 1 extra naming doesn't actually seem relevant anywhere inside
the driver other than maybe making relationship to datasheet clear.
You might as well use the 0,1,23 values directly I think.

> +#define PAC1934_MEAS_REG_LEN			76

Can you compute these from register addresses and sizes?  If so that will
be self documenting and make it clear these are correct.

> +#define PAC1934_CTRL_REG_LEN			12
> +
> +
> +#define PAC1934_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)


> +/*
> + * Universal Unique Identifier (UUID),
> + * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
> + * reserved to Microchip for the PAC1934 and must not be changed
No need to say it must not be changed. We can't change register addresses either
and this is similar to those.

> + */
> +#define PAC1934_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
> +
...

> +/**
> + * struct reg_data - data from the registers
> + * @meas_regs:			snapshot of raw measurements registers
> + * @ctrl_regs:			snapshot of control registers
> + * @energy_sec_acc:		snapshot of energy values
> + * @vpower_acc:			accumulated vpower values
> + * @vpower:			snapshot of vpower registers
> + * @vbus:			snapshot of vbus registers
> + * @vbus_avg:			averages of vbus registers
> + * @vsense:			snapshot of vsense registers
> + * @vsense_avg:			averages of vsense registers
> + * @num_enabled_channels:	count of how many chip channels are currently enabled
> + */
> +struct reg_data {
> +	u8	meas_regs[PAC1934_MEAS_REG_LEN];
> +	u8	ctrl_regs[PAC1934_CTRL_REG_LEN];

I guess the weird block read stuff where it skips addresses prevents using regmap and
regcache to avoid hand spinning caching?

> +	s64	energy_sec_acc[PAC1934_MAX_NUM_CHANNELS];
> +	s64	vpower_acc[PAC1934_MAX_NUM_CHANNELS];
> +	s32	vpower[PAC1934_MAX_NUM_CHANNELS];
> +	s32	vbus[PAC1934_MAX_NUM_CHANNELS];
> +	s32	vbus_avg[PAC1934_MAX_NUM_CHANNELS];
> +	s32	vsense[PAC1934_MAX_NUM_CHANNELS];
> +	s32	vsense_avg[PAC1934_MAX_NUM_CHANNELS];
> +	u8	num_enabled_channels;
> +};
> +
> +/**
> + * struct pac1934_chip_info - information about the chip
> + * @client:			the i2c-client attached to the device
> + * @lock:			synchronize access to driver's state members
> + * @work_chip_rfsh:		work queue used for refresh commands
> + * @phys_channels:		phys channels count
> + * @active_channels:		array of values, true means that channel is active
> + * @bi_dir:			array of bools, true means that channel is bidirectional
> + * @chip_variant:		chip variant
> + * @chip_revision:		chip revision
> + * @shunts:			shunts
> + * @chip_reg_data:		chip reg data
> + * @sample_rate_value:		sampling frequency
> + * @labels:			table with channels labels
> + * @pac1934_info:		pac1934_info
> + * @crt_samp_spd_bitfield:	the current sampling speed
> + * @jiffies_tstamp:		chip's uptime
> + */
> +struct pac1934_chip_info {
> +	struct i2c_client	*client;
> +	struct mutex		lock; /* synchronize access to driver's state members */
> +	struct delayed_work	work_chip_rfsh;
> +	u8			phys_channels;
> +	bool			active_channels[PAC1934_MAX_NUM_CHANNELS];
> +	bool			bi_dir[PAC1934_MAX_NUM_CHANNELS];
> +	u8			chip_variant;
> +	u8			chip_revision;
> +	u32			shunts[PAC1934_MAX_NUM_CHANNELS];
> +	struct reg_data		chip_reg_data;
> +	s32			sample_rate_value;
> +	char			*labels[PAC1934_MAX_NUM_CHANNELS];
> +	struct iio_info		pac1934_info;

I'd call it iio_info, or just info as the pac1934 bit is obvious from context.

> +	u8			crt_samp_spd_bitfield;
> +	unsigned long		jiffies_tstamp;
> +};
> +
> +#define TO_PAC1934_CHIP_INFO(d) container_of(d, struct pac1934_chip_info, work_chip_rfsh)
> +
> +#define PAC1934_VPOWER_ACC_CHANNEL(_index, _si, _address) {			\
> +	.type = IIO_ENERGY,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 48,							\
> +		.storagebits = 48,						\

IIO elements are always in naturally aligned power of 2. So that needs to be 64 bits.
Standard userspace tooling expects this so we can't change it.
So needs to be 
.storagebits = 64

You may have to repack data to meet this requirement.  It's annoying but one
of the costs we pay for a simple ABI.

I'd not add this stuff until you add the buffer support though.
For now it's just noise.



> +		.endianness = IIO_CPU,						\
> +	}									\
> +}


> +
> +/* Low-level I2c functions used to transfer up to 76 bytes at once */
> +static int pac1934_i2c_read(struct i2c_client *client, u8 reg_addr, void *databuf, u8 len)
> +{
> +	int ret;
> +	struct i2c_msg msgs[2] = {
> +		{ .addr = client->addr,
> +		 .len = 1,
> +		 .buf = (u8 *)&reg_addr,
odd indent.
		{
			.addr = client->addr,
			.len = 1,
			.buf
		}, {
			.addr = ..

> +		},
> +		{ .addr = client->addr,
> +		 .len = len,
> +		 .buf = databuf,

can you use i2c_smbus_read_i2c_block_data() here?

I'm rubbish at remembering all the smbus variants, so it might not fit, but
it's close to this.  You used it elsewhere so maybe this one got missed?


> +		 .flags = I2C_M_RD
> +		}
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

> +static ssize_t shunt_value_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	int len = 0;
> +	int target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
There is an address field in the IIO_DEVICE_ATTR().
Use that (bit of container of magic to get to it)


> +
> +	len += sprintf(buf, "%u\n", info->shunts[target]);
> +
> +	return len;

	return sysfs_emit()

> +}
> +
> +static ssize_t shunt_value_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	int sh_val, target;
> +
> +	target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;

Again, address in the attribute for this. Not messy string mangling.

> +	if (kstrtouint(buf, 10, &sh_val)) {
> +		dev_err(dev, "Shunt value is not valid\n");
> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mutex, &info->lock)
> +		info->shunts[target] = sh_val;
> +
> +	return count;
> +}
> +
...


> +
> +static int pac1934_send_refresh(struct pac1934_chip_info *info,
> +				u8 refresh_cmd, u32 wait_time)
> +{
> +	/* this function only sends REFRESH or REFRESH_V */
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u8 bidir_reg;
> +	bool revision_bug = false;
> +
> +	if (info->chip_revision == 2 || info->chip_revision == 3) {
> +		/*
> +		 * chip rev 2 and 3 bug workaround
> +		 * see: PAC1934 Family Data Sheet Errata DS80000836A.pdf
> +		 */
> +		revision_bug = true;
> +
> +		bidir_reg =
> +			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[PAC1934_CH_1]) |

as mentioned above, just use [0], [1], [2], [3] as the CH_1 mapping doesn't make anything much clearer.
 
> +			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[PAC1934_CH_2]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[PAC1934_CH_3]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[PAC1934_CH_4]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDV_MASK, info->bi_dir[PAC1934_CH_2]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDV_MASK, info->bi_dir[PAC1934_CH_3]) |
> +			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDV_MASK, info->bi_dir[PAC1934_CH_4]);
> +
...

> +	return ret;
> +}
> +

> +static int pac1934_retrieve_data(struct pac1934_chip_info *info,
> +				 u32 wait_time)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * check if the minimal elapsed time has passed and if so,
> +	 * re-read the chip, otherwise the cached info is just fine
> +	 */
> +	if (time_after(jiffies, info->jiffies_tstamp +
> +					 msecs_to_jiffies(PAC1934_MIN_POLLING_TIME_MS))) {
> +		ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
> +					   wait_time);
> +
> +		/*
> +		 * Re-schedule the work for the read registers on timeout
> +		 * (to prevent chip regs saturation)
> +		 */
> +		cancel_delayed_work_sync(&info->work_chip_rfsh);
> +		schedule_delayed_work(&info->work_chip_rfsh,
> +				      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));

Doesn't mod_delayed_work() cover this pair more cheaply?
Or is there are race I'm missing?  I think it's safe for this usecase.

> +	}
> +
> +	return ret;
> +}
> +
> +static int pac1934_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	s64 curr_energy;
> +	int ret, channel = chan->channel - 1;
> +
> +	ret = pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus[channel];
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense[channel];
> +			return IIO_VAL_INT;
> +		case IIO_POWER:
> +			*val = info->chip_reg_data.vpower[channel];
> +			return IIO_VAL_INT;
> +		case IIO_ENERGY:
> +			curr_energy = info->chip_reg_data.energy_sec_acc[channel];
> +			*val = (u32)curr_energy;
> +			*val2 = (u32)(curr_energy >> 32);
> +			return IIO_VAL_INT_64;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
Not sure these break; at end of case can be reached.

> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus_avg[channel];
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense_avg[channel];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		/* Voltages - scale for millivolts */
> +		case PAC1934_VBUS_1_ADDR:
> +		case PAC1934_VBUS_2_ADDR:
> +		case PAC1934_VBUS_3_ADDR:
> +		case PAC1934_VBUS_4_ADDR:
> +		case PAC1934_VBUS_AVG_1_ADDR:
> +		case PAC1934_VBUS_AVG_2_ADDR:
> +		case PAC1934_VBUS_AVG_3_ADDR:
> +		case PAC1934_VBUS_AVG_4_ADDR:
> +			*val = PAC1934_VOLTAGE_MILLIVOLTS_MAX;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = PAC1934_VOLTAGE_U_RES;
> +			else
> +				*val2 = PAC1934_VOLTAGE_S_RES;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		/*
> +		 * Currents - scale for mA - depends on the
> +		 * channel's shunt value
> +		 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +		 */
> +		case PAC1934_VSENSE_1_ADDR:
> +		case PAC1934_VSENSE_2_ADDR:
> +		case PAC1934_VSENSE_3_ADDR:
> +		case PAC1934_VSENSE_4_ADDR:
> +		case PAC1934_VSENSE_AVG_1_ADDR:
> +		case PAC1934_VSENSE_AVG_2_ADDR:
> +		case PAC1934_VSENSE_AVG_3_ADDR:
> +		case PAC1934_VSENSE_AVG_4_ADDR:
> +			*val = PAC1934_MAX_VSENSE_RSHIFTED_BY_16B;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = info->shunts[channel];
> +			else
> +				*val2 = info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +		/*
> +		 * Power - uW - it will use the combined scale
> +		 * for current and voltage
> +		 * current(mA) * voltage(mV) = power (uW)
> +		 */
> +		case PAC1934_VPOWER_1_ADDR:
> +		case PAC1934_VPOWER_2_ADDR:
> +		case PAC1934_VPOWER_3_ADDR:
> +		case PAC1934_VPOWER_4_ADDR:
> +			*val = PAC1934_MAX_VPOWER_RSHIFTED_BY_28B;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = info->shunts[channel];
> +			else
> +				*val2 = info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC1934_VPOWER_ACC_1_ADDR:
> +		case PAC1934_VPOWER_ACC_2_ADDR:
> +		case PAC1934_VPOWER_ACC_3_ADDR:
> +		case PAC1934_VPOWER_ACC_4_ADDR:
> +			/*
> +			 * expresses the 32 bit scale value
> +			 * here compute the scale for energy (miliWatt-second or miliJoule)
> +			 */
> +			*val = PAC1934_SCALE_CONSTANT;
> +
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = info->shunts[channel];
> +			else
> +				*val2 = info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = info->sample_rate_value;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;

Shouldn't be able to get here.

> +}
> +

> +static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
> +					      struct pac1934_chip_info *info)
> +{
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	struct device *dev = &client->dev;
> +	unsigned short bi_dir_mask;
> +	int idx, i;
> +	guid_t guid;
> +	const struct acpi_device_id *id;
> +
> +	handle = ACPI_HANDLE(&client->dev);
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return false;
> +
> +	guid_parse(PAC1934_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
> +	if (!rez)
> +		return false;
> +
> +	for (i = 0; i < rez->package.count; i += 2) {
> +		idx = i / 2;
> +		info->labels[idx] =
> +			devm_kmemdup(&client->dev, rez->package.elements[i].string.pointer,
> +				     (size_t)rez->package.elements[i].string.length + 1,
> +				     GFP_KERNEL);
> +		info->labels[idx][rez->package.elements[i].string.length] = '\0';
> +		info->shunts[idx] =
> +			rez->package.elements[i + 1].integer.value * 1000;
> +		info->active_channels[idx] = (info->shunts[idx] != 0);
> +	}
> +
> +	kfree(rez);

ACPI_FREE()? I think it's preferred as there is some ACPI tracking code for
allocations that might be enabled.


...

> +	return true;
> +}
> +

> +static int pac1934_chip_configure(struct pac1934_chip_info *info)
> +{
> +	int cnt, ret;
> +	struct i2c_client *client = info->client;
> +	u8 regs[PAC1934_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
> +	u32 wait_time;
> +
> +	cnt = 0;
No need.
> +	info->chip_reg_data.num_enabled_channels = 0;
> +	for (cnt = 0;  cnt < info->phys_channels; cnt++) {
> +		if (info->active_channels[cnt])
> +			info->chip_reg_data.num_enabled_channels++;
> +		cnt++;

? 0-day spotted this one.


> +	}
...




> +static IIO_DEVICE_ATTR(in_shunt_resistor_1, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_2, 0644, shunt_value_show, shunt_value_store, 0);

Put address as index.

> +static IIO_DEVICE_ATTR(in_shunt_resistor_3, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_4, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(reset_accumulators, 0200, NULL, reset_accumulators_store, 0);
> +
> +static struct attribute *pac1934_all_attributes[] = {
> +	PAC1934_DEV_ATTR(in_shunt_resistor_1),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_2),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_3),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_4),
> +	PAC1934_DEV_ATTR(reset_accumulators),
> +	NULL
> +};
> +
> +static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
> +					  struct iio_dev *indio_dev)
> +{
> +	int i, j, active_channels_count = 0;
> +	struct attribute **pac1934_custom_attributes;
> +	struct attribute_group *pac1934_group;
> +	struct i2c_client *client = info->client;
> +
> +	for (i = 0 ; i < info->phys_channels; i++)
> +		if (info->active_channels[i])
> +			active_channels_count++;
> +
> +	pac1934_group = devm_kzalloc(&client->dev, sizeof(*pac1934_group), GFP_KERNEL);
Can fail
> +
> +	pac1934_custom_attributes = devm_kzalloc(&client->dev,
> +						 (PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +						 active_channels_count +
> +						 PAC1934_SHARED_DEVATTRS_COUNT)
> +						 * sizeof(*pac1934_group) + 1,
> +						 GFP_KERNEL);
as can this (in theory anyway and we should always handle that)

> +	j = 0;
> +
> +	for (i = 0 ; i < info->phys_channels; i++) {
> +		if (info->active_channels[i]) {
> +			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i];

Indent the second line one more table as this is very hard to read.

I'm not sure copying it from that table is worth doing. I'd just build the table here
from the attributes.

> +			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j + 1] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i + 1];
> +			j++;
> +		}
> +	}
> +
> +	for (i = 0; i < PAC1934_SHARED_DEVATTRS_COUNT; i++)
> +		pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +			active_channels_count + i] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +			info->phys_channels + i];
> +
> +	pac1934_group->attrs = pac1934_custom_attributes;
> +	info->pac1934_info.attrs = pac1934_group;
> +
> +	return 0;
> +}

> +static int pac1934_probe(struct i2c_client *client)
> +{
> +	struct pac1934_chip_info *info;
> +	const struct pac1934_features *chip;
> +	struct iio_dev *indio_dev;
> +	int cnt, ret;
> +	bool match = false;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	info->client = client;
> +
> +	/*
> +	 * load default settings - all channels disabled,
> +	 * uni directional flow
> +	 */
> +	for (cnt = 0; cnt < PAC1934_MAX_NUM_CHANNELS; cnt++) {
> +		info->active_channels[cnt] = false;
> +		info->bi_dir[cnt] = false;

info is zero initialized. Could just not bother setting this as they
are already 0.  If you think it's useful documentation fine to leave it.
Hopefully the compiler will elide it anyway.

> +	}
> +
...


> +}
> +
> +static const struct i2c_device_id pac1934_id[] = {
> +	{ .name = "pac1931", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1931] },
> +	{ .name = "pac1932", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1932] },
> +	{ .name = "pac1933", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1933] },
> +	{ .name = "pac1934", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
> +	{}
> +};
> +

No blank line here.

> +MODULE_DEVICE_TABLE(i2c, pac1934_id);
> +
> +static const struct of_device_id pac1934_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1931",
> +		.data = &pac1934_chip_config[PAC1931]
> +	},
> +	{
> +		.compatible = "microchip,pac1932",
> +		.data = &pac1934_chip_config[PAC1932]
> +	},
> +	{
> +		.compatible = "microchip,pac1933",
> +		.data = &pac1934_chip_config[PAC1933]
> +	},
> +	{
> +		.compatible = "microchip,pac1934",
> +		.data = &pac1934_chip_config[PAC1934]
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pac1934_of_match);
> +
> +/* using MCHP1930 to be compatible with WINDOWS ACPI */

Presumably BIOS rather than windows, but I guess the point is clear :)

