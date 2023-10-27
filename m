Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B507D9CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjJ0PSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346292AbjJ0PSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:18:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC1F186;
        Fri, 27 Oct 2023 08:18:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF949C433C8;
        Fri, 27 Oct 2023 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698419910;
        bh=oPgN+wJlz2W5Tgj+kTSFBjvmDVNGdF3mXRRSOH8eGGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhsTq6xd5kSmiBVudQw/ihhgN2qSvNWfe1Noe8Euntq9AEpxcKtbanNYYdplbxE2P
         fX3of2KOGBB4paphHPyVvevkw8D3NhxKfRfptNAU27u4n7ilj5MVGH1Z3upDHJppJp
         BsgiLd6Nv/QefFMW7Z6mcJcDSFOnMrUusz3XUf0VeA++IHhijoTJmAUUesdC4RklFA
         gHSBQNETTGRw07KVuNW8kxTLYts2WjMnLgB7X+5UJtYm5oUUQeBF0zmBJxxZu5lFBT
         P55KmXR5fLGApz5yIrUyqt8ZyDhJrI41A0Ev41Sr2gNamhO/C9pYHtqDbpXAuwdWX+
         YYqg1ono1FYtQ==
Date:   Fri, 27 Oct 2023 16:18:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
Message-ID: <20231027161813.7bff8866@jic23-huawei>
In-Reply-To: <20231025134404.131485-3-marius.cristea@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
        <20231025134404.131485-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 16:44:04 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Hi Marius,

Various comments inline.


> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> new file mode 100644
> index 000000000000..ea43df292b9c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_X
> +KernelVersion:	6.6
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime and set
> +		by a client application. This attribute allows to set its value
> +		in micro-ohms. X is the IIO index of the device. The value is
> +		used to calculate current, power and accumulated energy.

How common is it that this isn't known?  I'm not sure we've found it necessary to
support userspace control of this for any other device and there are quite a few
where this could in theory be known only at runtime...

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/reset_accumulators
> +KernelVersion:	6.6
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing any value resets the accumulated power device's statistics
> +		for all enabled channels.

> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> new file mode 100644
> index 000000000000..7bed0d9bde54
> --- /dev/null
> +++ b/drivers/iio/adc/pac1934.c
> @@ -0,0 +1,1775 @@

...

> +
> +/*
> + * these indexes are exactly describing the element order within a single
> + * PAC1934 phys channel IIO channel descriptor; see the static const struct
> + * iio_chan_spec pac1934_single_channel[] declaration

enum might be more appropriate given this is just a software
structure.

> + */
> +#define IIO_EN					0
> +#define IIO_POW					1
> +#define IIO_VOLT				2
> +#define IIO_CRT					3
> +#define IIO_VOLTAVG				4
> +#define IIO_CRTAVG				5
> +
> +#define PAC1934_VBUS_SENSE_REG_LEN		2
> +#define PAC1934_ACC_REG_LEN			3
> +#define PAC1934_VPOWER_REG_LEN			4
> +#define PAC1934_VPOWER_ACC_REG_LEN		6
> +#define PAC1934_MAX_REGISTER_LENGTH		6
> +
> +#define PAC1934_CUSTOM_ATTR_FOR_CHANNEL		1
> +#define PAC1934_SHARED_DEVATTRS_COUNT		1


> +/**
> + * struct pac1934_chip_info - information about the chip
> + * @client:			the i2c-client attached to the device
> + * @lock:			lock used by the chip's mutex

That's a circular comment. Chip doesn't have a mutex! Driver does and this is
it.

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
> +	struct mutex		lock; /* lock to prevent concurrent reads/writes */

The bus locks will do that.  What data is actually being protected? I suspect more than
simple reads and writes.

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
> +	u8			crt_samp_spd_bitfield;
> +	unsigned long		jiffies_tstamp;
> +};
> +


> +#define PAC1934_VBUS_CHANNEL(_index, _si, _address) {				\
> +	.type = IIO_VOLTAGE,							\
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
> +		.realbits = PAC1934_VOLTAGE_U_RES,				\
> +		.storagebits = PAC1934_VOLTAGE_U_RES,				\

I think it would be clearer to just use numbers here.

> +		.endianness = IIO_CPU,						\
> +	}									\
> +}


> +/* Low-level I2c functions */
> +static int pac1934_i2c_read(struct i2c_client *client, u8 reg_addr, void *databuf, u8 len)
> +{
> +	int ret;
> +	struct i2c_msg msgs[2] = {
> +		{ .addr = client->addr,
> +		 .len = 1,
> +		 .buf = (u8 *)&reg_addr,
> +		 .flags = 0

default of 0 is the obvious choice and what C will fill it with anyway, so don't provide it explicitly.

> +		},
> +		{ .addr = client->addr,
> +		 .len = len,
> +		 .buf = databuf,
> +		 .flags = I2C_M_RD
> +		}
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));

Always a bit tricky to figure out but isn't this i2c_smbus_read_i2c_block_data()?

Maybe check the send isn't a standard function as well.


> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

> +
> +static int pac1934_reg_snapshot(struct pac1934_chip_info *info,
> +				bool do_refresh, u8 refresh_cmd, u32 wait_time)
> +{
> +	int ret;
> +	struct i2c_client *client = info->client;
> +	u8 samp_shift, ctrl_regs_tmp;
> +	u8 *offset_reg_data_p;
> +	u16 tmp_value;
> +	u32 samp_rate, cnt, tmp;
> +	s64 curr_energy, inc;
> +	u64 tmp_energy;
> +	struct reg_data *reg_data;
> +
> +	mutex_lock(&info->lock);
guard(mutex)(&info->lock);

then you can return directly in the error paths and rely on scope based
cleanup unlocking the mutex.


...

> +	/* start with VPOWER_ACC */
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		/* check if the channel is active, skip all fields if disabled */
> +		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
> +			curr_energy = info->chip_reg_data.energy_sec_acc[cnt];
> +
> +			tmp_energy = get_unaligned_be48(offset_reg_data_p);
> +
> +			if (info->bi_dir[cnt])
> +				reg_data->vpower_acc[cnt] = sign_extend64(tmp_energy, 47);
> +			else
> +				reg_data->vpower_acc[cnt] = tmp_energy;
> +
> +			/*
> +			 * compute the scaled to 1 second accumulated energy value;
> +			 * energy accumulator scaled to 1sec = VPOWER_ACC/2^samp_shift
> +			 * the chip's sampling rate is 2^samp_shift samples/sec
> +			 */
> +			inc = (reg_data->vpower_acc[cnt] >> samp_shift);
> +
> +			/* add the power_acc field */
> +			curr_energy += inc;
> +
> +			/* check if we have reached the upper/lower limit */
> +			if (curr_energy > (s64)PAC_193X_MAX_POWER_ACC)
> +				curr_energy = PAC_193X_MAX_POWER_ACC;

clamp()?

> +			else if (curr_energy < ((s64)PAC_193X_MIN_POWER_ACC))
> +				curr_energy = PAC_193X_MIN_POWER_ACC;
> +
> +			reg_data->energy_sec_acc[cnt] = curr_energy;
> +
> +			offset_reg_data_p += PAC1934_VPOWER_ACC_REG_LEN;
> +		}
> +	}

...

> +
> +reg_snapshot_err:
> +	mutex_unlock(&info->lock);
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
> +			switch (chan->address) {
> +			case PAC1934_VBUS_1_ADDR:
> +			case PAC1934_VBUS_2_ADDR:
> +			case PAC1934_VBUS_3_ADDR:
> +			case PAC1934_VBUS_4_ADDR:
> +				*val = info->chip_reg_data.vbus[channel];
> +				return IIO_VAL_INT;
> +			default:

Is this extra layer of checking necessary?
The channel type already constrained this to be valid I think and
it would simplify things not to have to check the address as well.


> +				return -EINVAL;
> +			}
> +			break;

...

> +
> +	return -EINVAL;
> +}
> +
> +static int pac1934_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret = -EINVAL;
> +	s32 old_samp_rate;
> +	u8 ctrl_reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pac1934_match_samp_rate(info, val);
> +		if (ret)
> +			return ret;
> +
> +		old_samp_rate = info->sample_rate_value;
> +		info->sample_rate_value = val;
> +
> +		/* write the new sampling value and trigger a snapshot(incl refresh) */
> +		mutex_lock(&info->lock);
> +
> +		ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
> +		ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "%s - can't update sample rate\n", __func__);
> +			info->sample_rate_value = old_samp_rate;
> +			mutex_unlock(&info->lock);

Perhaps use the new scoped_guard(mutex, &info->lock) 
to avoid needing to manually unlock in here.

> +			return ret;
> +		}
> +
> +		mutex_unlock(&info->lock);
> +
> +		/*
> +		 * now, force a snapshot with refresh - call retrieve
> +		 * data in order to update the refresh timer
> +		 * alter the timestamp in order to force trigger a
> +		 * register snapshot and a timestamp update
> +		 */
> +		info->jiffies_tstamp -=
> +			msecs_to_jiffies(PAC1934_MIN_POLLING_TIME_MS);
> +		ret = pac1934_retrieve_data(info, (1024 / old_samp_rate) * 1000);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"%s - cannot snapshot ctrl and measurement regs\n",
> +				__func__);
> +			return ret;
> +		}
> +
> +		ret = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

> +
> +static int pac1934_chip_identify(struct pac1934_chip_info *info)
> +{
> +	u8 rev_info[PAC1934_ID_REG_LEN];
> +	struct i2c_client *client = info->client;
> +	int ret = 0;
> +
> +	ret = pac1934_read_revision(info, (u8 *)rev_info);
> +	if (!ret) {
> +		info->chip_variant = rev_info[PAC1934_PID_IDX];
> +		info->chip_revision = rev_info[PAC1934_RID_IDX];
> +
> +		dev_dbg(&client->dev, "Chip variant: 0x%02X\n", info->chip_variant);
> +		dev_dbg(&client->dev, "Chip revision: 0x%02X\n", info->chip_revision);
> +
> +		switch (info->chip_variant) {
> +		case PAC1934_PID:
> +			info->phys_channels = pac1934_chip_config[PAC1934].phys_channels;
> +			break;
> +		case PAC1933_PID:
> +			info->phys_channels = pac1934_chip_config[PAC1933].phys_channels;
> +			break;
> +		case PAC1932_PID:
> +			info->phys_channels = pac1934_chip_config[PAC1932].phys_channels;
> +			break;
> +		case PAC1931_PID:
> +			info->phys_channels = pac1934_chip_config[PAC1931].phys_channels;
> +			break;
> +		default:
> +			info->phys_channels = 0;
> +		}
> +	}
> +
> +	return ret;

Might as well return earlier.  Also, why not return a boolean and
use that instead the value of info->phys_channels to figure that out if we had a match earlier.

> +}
> +
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static const char *pac1934_match_acpi_device(struct i2c_client *client,
> +					     struct pac1934_chip_info *info)
> +{
> +	const char *name;
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
> +		return NULL;
> +
> +	name = dev_name(dev);

The iio_dev->name should be the part number, not the dev_name().
There are a few examples in tree where for historical reasons this is wrong and
we can't fix them. We don't want any more though!

> +	if (!name)
> +		return NULL;
> +
> +	guid_parse(PAC1934_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
> +	if (!rez)
> +		return NULL;
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
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez) {
> +		/*
> +		 * initializing with default values
> +		 * we assume all channels are unidirectional(the mask is zero)
> +		 * and assign the default sampling rate
> +		 */
> +		info->sample_rate_value = PAC1934_DEFAULT_CHIP_SAMP_SPEED;
> +		return name;
> +	}
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		idx = i;
> +		info->shunts[idx] = rez->package.elements[i].integer.value;
> +		info->active_channels[idx] = (info->shunts[idx] != 0);
> +	}
> +
> +	kfree(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
> +	if (!rez)
> +		return NULL;
> +
> +	bi_dir_mask = rez->package.elements[0].integer.value;
> +	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
> +	info->bi_dir[1] = ((bi_dir_mask & (1 << 2)) | (bi_dir_mask & (1 << 6))) != 0;
> +	info->bi_dir[2] = ((bi_dir_mask & (1 << 1)) | (bi_dir_mask & (1 << 5))) != 0;
> +	info->bi_dir[3] = ((bi_dir_mask & (1 << 0)) | (bi_dir_mask & (1 << 4))) != 0;
> +
> +	kfree(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
> +	if (!rez)
> +		return NULL;
> +
> +	info->sample_rate_value = rez->package.elements[0].integer.value;
> +
> +	kfree(rez);

This is all rather horrible, but meh, I guess we are stuck with it.
> +
> +	return name;
> +}
> +
> +static const char *pac1934_match_of_device(struct i2c_client *client,
> +					   struct pac1934_chip_info *info)
> +{
> +	struct fwnode_handle *node, *fwnode;
> +	unsigned int current_channel;
> +	const struct pac1934_features *chip;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);

If you are in an of specific handler, you shouldn't need the i2c_device_id for
anything...  Using it to get the name is fragile. Embed the name in the
chip_info structure we got from the firmware match (dt or ACPI or other).
If you are matching based on part number (which is good) then update the
chip_info pointer as appropriate to get the right parameters.


> +	const char *name;
> +	int idx, ret;
> +
> +	name = id->name;
> +
> +	if (!info->phys_channels) {
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with some newer part number.
> +		 */
> +		chip = device_get_match_data(&client->dev);
> +		if (!chip)
> +			chip = (struct pac1934_features *)id->driver_data;

We have i2c_get_match_data() for this.

> +
> +		if (!chip) {
> +			dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
> +			return NULL;
> +		}
> +
> +		info->phys_channels = chip->phys_channels;
> +	}
> +
> +	info->sample_rate_value = 1024;
> +	current_channel = 1;
> +
> +	fwnode = dev_fwnode(&client->dev);
> +	fwnode_for_each_available_child_node(fwnode, node) {
> +		ret = fwnode_property_read_u32(node, "reg", &idx);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret,
> +				      "reading invalid channel index\n");
> +			fwnode_handle_put(node);

Use a goto and handle the fwnode_handle_put() in one location.

> +			return NULL;
> +		}
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0) {
> +			dev_err_probe(&client->dev, -EINVAL,
> +				      "%s: invalid channel_index %d value\n",
> +				      fwnode_get_name(node), idx);
> +			fwnode_handle_put(node);
> +			return NULL;
> +		}
> +
> +		/* enable channel */
> +		info->active_channels[idx] = true;
> +
> +		ret = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret,
> +				      "%s: invalid shunt-resistor value: %d\n",
> +				      fwnode_get_name(node), info->shunts[idx]);
> +			fwnode_handle_put(node);
> +			return NULL;
> +		}
> +
> +		ret = fwnode_property_read_string(node, "label",
> +						  (const char **)&info->labels[idx]);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret,
> +				      "%s: invalid rail-name value\n",
> +				      fwnode_get_name(node));
> +			fwnode_handle_put(node);
> +			return NULL;
> +		}
> +
> +		info->bi_dir[idx] = fwnode_property_read_bool(node, "bipolar");
> +
> +		current_channel++;
> +	}
> +
> +	return name;
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
> +	info->chip_reg_data.num_enabled_channels = 0;
> +	while (cnt < info->phys_channels) {
> +		if (info->active_channels[cnt])
> +			info->chip_reg_data.num_enabled_channels++;
> +		cnt++;

Looks like a for loop would be cleaner here.


> +	}
> +

...



> +}
> +
> +static int pac1934_prep_iio_channels(struct pac1934_chip_info *info, struct iio_dev *indio_dev)
> +{
> +	struct i2c_client *client;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count, cnt;
> +	void *dyn_ch_struct, *tmp_data;
> +
> +	client = info->client;
> +
> +	/* find out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (info->active_channels[cnt]) {
> +			/* add the size of the properties of one chip physical channel */
> +			channel_size += sizeof(pac1934_single_channel);
> +			/* count how many enabled channels we have */
> +			attribute_count += ARRAY_SIZE(pac1934_single_channel);
> +			dev_info(&client->dev, ":%s: Channel %d active\n", __func__, cnt + 1);
> +		}
> +	}
> +
> +	dyn_ch_struct = kzalloc(channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -EINVAL;
> +
> +	tmp_data = dyn_ch_struct;
> +
> +	/* populate the dynamic channels and make all the adjustments */
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (info->active_channels[cnt]) {
Reverse the logic to reduce indent
		if (!info->active_channels[cnt])
			continue

		memcpy(...)

Could do the same above.

> +			memcpy(tmp_data, pac1934_single_channel, sizeof(pac1934_single_channel));
> +			ch_sp = (struct iio_chan_spec *)tmp_data;
> +			ch_sp[IIO_EN].channel = cnt + 1;
> +			ch_sp[IIO_EN].scan_index = cnt;
> +			ch_sp[IIO_EN].address = cnt + PAC1934_VPOWER_ACC_1_ADDR;
> +			ch_sp[IIO_POW].channel = cnt + 1;
> +			ch_sp[IIO_POW].scan_index = cnt;
> +			ch_sp[IIO_POW].address = cnt + PAC1934_VPOWER_1_ADDR;
> +			ch_sp[IIO_VOLT].channel = cnt + 1;
> +			ch_sp[IIO_VOLT].scan_index = cnt;
> +			ch_sp[IIO_VOLT].address = cnt + PAC1934_VBUS_1_ADDR;
> +			ch_sp[IIO_CRT].channel = cnt + 1;
> +			ch_sp[IIO_CRT].scan_index = cnt;
> +			ch_sp[IIO_CRT].address = cnt + PAC1934_VSENSE_1_ADDR;
> +			ch_sp[IIO_VOLTAVG].channel = cnt + 5;

A comment on the numbering would be useful.

> +			ch_sp[IIO_VOLTAVG].scan_index = cnt;
> +			ch_sp[IIO_VOLTAVG].address = cnt + PAC1934_VBUS_AVG_1_ADDR;
> +			ch_sp[IIO_CRTAVG].channel = cnt + 5;
> +			ch_sp[IIO_CRTAVG].scan_index = cnt;
> +			ch_sp[IIO_CRTAVG].address = cnt + PAC1934_VSENSE_AVG_1_ADDR;
> +
> +			/*
> +			 * now modify the parameters in all channels if the
> +			 * whole chip rail(channel) is bi-directional
> +			 */
> +			if (info->bi_dir[cnt]) {
> +				ch_sp[IIO_EN].scan_type.sign = 's';
> +				ch_sp[IIO_EN].scan_type.realbits = PAC1934_ENERGY_S_RES;
> +				ch_sp[IIO_POW].scan_type.sign = 's';
> +				ch_sp[IIO_POW].scan_type.realbits = PAC1934_POWER_S_RES;
> +				ch_sp[IIO_VOLT].scan_type.sign = 's';
> +				ch_sp[IIO_VOLT].scan_type.realbits = PAC1934_VOLTAGE_S_RES;
> +				ch_sp[IIO_CRT].scan_type.sign = 's';
> +				ch_sp[IIO_CRT].scan_type.realbits = PAC1934_CURRENT_S_RES;
> +				ch_sp[IIO_VOLTAVG].scan_type.sign = 's';
> +				ch_sp[IIO_VOLTAVG].scan_type.realbits = PAC1934_VOLTAGE_S_RES;
> +				ch_sp[IIO_CRTAVG].scan_type.sign = 's';
> +				ch_sp[IIO_CRTAVG].scan_type.realbits = PAC1934_CURRENT_S_RES;
> +			}
> +			tmp_data += sizeof(pac1934_single_channel);
> +		}
> +	}
> +
> +	/*
> +	 * send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +	indio_dev->channels = devm_kmemdup(&client->dev,
> +					   (const struct iio_chan_spec *)dyn_ch_struct,
> +					   channel_size, GFP_KERNEL);

Why do you need to make a copy?

> +
> +	kfree(dyn_ch_struct);
> +
> +	if (!indio_dev->channels)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static ssize_t reset_accumulators_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	int ret, i;
> +	u8 refresh_cmd = PAC1934_REFRESH_REG_ADDR;
> +
> +	ret = i2c_smbus_write_byte(info->client, refresh_cmd);
> +	if (ret) {

All bets are off as to the state if this fails. I'd error out so
that userspace knows it's borked.

> +		dev_err(&indio_dev->dev,
> +			"%s - cannot send 0x%02X\n",
> +			__func__, refresh_cmd);
> +	}
> +
> +	for (i = 0 ; i < info->phys_channels; i++)
> +		info->chip_reg_data.energy_sec_acc[i] = 0;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(in_shunt_resistor_1, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_2, 0644, shunt_value_show, shunt_value_store, 0);
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
> +
> +	pac1934_custom_attributes = devm_kzalloc(&client->dev,
> +						 (PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +						 active_channels_count +
> +						 PAC1934_SHARED_DEVATTRS_COUNT)
> +						 * sizeof(*pac1934_group) + 1,
> +						 GFP_KERNEL);
> +	j = 0;
> +
> +	for (i = 0 ; i < info->phys_channels; i++) {
> +		if (info->active_channels[i]) {
> +			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i];
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
> +
> +static void pac1934_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +
> +	cancel_delayed_work_sync(&info->work_chip_rfsh);
Why not do this via a devm_add_action_or_reset() which would allow
you not to have to handle it explicitly here or in the error paths in probe.

Also avoid ordering issues as this will happen here before the userspace
interfaces are removed, which whereas to reverse the order in probe it should be
after that.

> +}
> +
> +static int pac1934_probe(struct i2c_client *client)
> +{
> +	struct pac1934_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	const char *name = NULL;
> +	int cnt, ret;
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
> +	}
> +
> +	info->crt_samp_spd_bitfield = PAC1934_SAMP_1024SPS;
> +
> +	ret = pac1934_chip_identify(info);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		if (!info->phys_channels)
> +			/* failed to identify part number, unknown number of channels available */
> +			return -EINVAL;
> +
> +		name = pac1934_match_acpi_device(client, info);
> +	} else {
> +		name = pac1934_match_of_device(client, info);
> +	}
> +
> +	if (!name) {
> +		dev_dbg(&client->dev, "parameter parsing returned an error\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&info->lock);
> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
> +	 */
> +	ret = pac1934_chip_configure(info);

This can't fail after the schedule delayed work (which is good because it shouldn't have
side effects on error) so you don't need to cancel it and can return directly I think.

> +	if (ret < 0)
> +		goto fail;
> +
> +	/* prepare the channel information */
> +	ret = pac1934_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = pac1934_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't configure custom attributes for PAC1934 device\n");
> +		goto fail;
> +	}
> +
> +	info->pac1934_info.read_raw = pac1934_read_raw;
> +	info->pac1934_info.read_avail = pac1934_read_avail;
> +	info->pac1934_info.write_raw = pac1934_write_raw;
> +	info->pac1934_info.read_label = pac1934_read_label;
> +
> +	indio_dev->info = &info->pac1934_info;
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * read whatever has been accumulated in the chip so far
> +	 * and reset the accumulators
> +	 */
> +	ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
> +				   PAC1934_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't register IIO device\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	cancel_delayed_work_sync(&info->work_chip_rfsh);
> +
> +	return ret;
> +}

> +/* using MCHP1930 to be compatible with WINDOWS ACPI */
> +static const struct acpi_device_id pac1934_acpi_match[] = {
> +	{"MCHP1930", 0},

Prefer spaces after { and before }

> +	{ }
> +};
> +

Slight preference for no blank line here to visually make the coupling
between the table and the MODULE_DEVICE_TABLE() macro more obvious.

> +MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
> +
> +static struct i2c_driver pac1934_driver = {
> +	.driver	 = {
> +		.name = "pac1934",
> +		.of_match_table = pac1934_of_match,
> +		.acpi_match_table = ACPI_PTR(pac1934_acpi_match)

I'm cynical on this - it saves very little on size and complicates the
driver, so drop ACPI_PTR() protections.  I'm fairly sure that if you build
without ACPI support you'll get 'unused' warnings.

> +		},
> +	.probe_new = pac1934_probe,
> +	.remove = pac1934_remove,
> +	.id_table = pac1934_id,
> +};
> +
> +module_i2c_driver(pac1934_driver);

