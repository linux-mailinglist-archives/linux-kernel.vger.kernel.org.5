Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0357F3DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjKVGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:08:36 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE4B9;
        Tue, 21 Nov 2023 22:08:30 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 1D97028EE6F;
        Wed, 22 Nov 2023 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700633309;
        bh=qXrWiEusWw2mGp8Om+7vfvXGecnaxYZpAvAu49+prmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bFyILb78z0IBNzVGHbVq8BASi75VURs9Qlu5pKkUJdZf/BaJxTFnrlHdfrwluiA7f
         hKiFF/11JtSujkyhyacaYFLXvF4HdJm0lHE5EmKP3qfQCgPNrmoNByZ/ZK0/7WprHA
         u+7QtrA92LHjPbda8XAL2awdOSN98yUAdb4F6BaM=
Date:   Wed, 22 Nov 2023 08:08:27 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <ZV2a213oidterHYZ@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117164232.8474-2-petre.rodan@subdimension.ro>
 <ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

first of all, thank you for the code review.
in the interest of brevity I will skip all comments where I simply remove the block, blankline, or fix indentation.

On Mon, Nov 20, 2023 at 02:35:39PM +0200, Andy Shevchenko wrote:
> > +	select HSC030PA_I2C if (I2C)
> > +	select HSC030PA_SPI if (SPI_MASTER)
> 
> Unneeded parentheses

ack

> > +	help
> > +	  Say Y here to build support for the Honeywell HSC and SSC TruStability
> > +      pressure and temperature sensor series.
> > +
> > +	  To compile this driver as a module, choose M here: the module will be
> > +	  called hsc030pa.
> 
> Yeah besides indentation issues the LKP complain about this.

fixed indentation and now it compiles fine with git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
sorry, what is 'LKP' in this context and how do I reproduce?

> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/init.h>
> > +#include <linux/math64.h>
> > +#include <linux/units.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/printk.h>
> 
> Keep them sorted alphabetically.
> Also there are missing at least these ones: array_size.h, types.h.

'#include <linux/array_size.h>' is a weird one.
$ cd /usr/src/linux/drivers
$ grep -r ARRAY_SIZE * | grep '\.c:' |  wc -l
 32396
$ grep -r 'include.*array_size\.h' * | grep -E '\.[ch]:' | wc -l
11
$ grep -r 'include.*array_size\.h' * | grep -E '\.[ch]:' | grep -v '^pinctrl' | wc -l
0

plus on a 6.1 version kernel, `make modules` actually reports that the header can't be found if I include it. can't comprehend that.
so I'll be skipping that particular include.

> > +// pressure range for current chip based on the nomenclature
> > +struct hsc_range_config {
> > +	char name[HSC_RANGE_STR_LEN];	// 5-char string that defines the range - ie "030PA"
> > +	s32 pmin;		// minimal pressure in pascals
> > +	s32 pmax;		// maximum pressure in pascals
> > +};
> 
> Can you utilize linear ranges data types and APIs? (linear_range.h)

not fit for this purpose, sorry.

> > +/*
> > + * the first two bits from the first byte contain a status code
> > + *
> > + * 00 - normal operation, valid data
> > + * 01 - device in hidden factory command mode
> > + * 10 - stale data
> > + * 11 - diagnostic condition
> > + *
> > + * function returns 1 only if both bits are zero
> > + */
> 
> You really need to be consistent with style of multi-line comments.
> And also C++/C variants. Besides that, respect English grammar and
> punctuation.

ok, I changed all comments to /* */.
this particular block was rewritten (the legend is taken from honeywell's i2c-related datasheet).

> > +static bool hsc_measurement_is_valid(struct hsc_data *data)
> > +{
> > +	if (data->buffer[0] & 0xc0)
> > +		return 0;
> > +
> > +	return 1;
> 
> You use bool and return integers.
> 
> Besides, it can be just a oneliner.

rewritten as a one-liner, without GENMASK.

> 	return !(buffer[0] & GENMASK(3, 2));
> 
> (Note, you will need bits.h for this.)
> 
> > +}
> 
...
> > +	ret = chip->valid(data);
> > +	if (!ret)
> > +		return -EAGAIN;
> > +
> > +	data->is_valid = true;
> 
> Can this be like
> 
> 	bool is_valid;
> 
> 	is_valid = chip->valid(...);
> 	if (!is_valid)
> 		return ...
> 
> 
> 	data->is_valid = is_valid;
> 
> 	// Depending on the flow you can even use that field directly

ack

> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&data->lock);
> > +		ret = hsc_get_measurement(data);
> > +		mutex_unlock(&data->lock);
> 
> Use guard() operator from cleanup.h.

I'm not familiar with that, for the time being I'll stick to mutex_lock/unlock if you don't mind.

> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			*val =
> > +			    ((data->buffer[0] & 0x3f) << 8) + data->buffer[1];
> > +			return IIO_VAL_INT;
> > +		case IIO_TEMP:
> > +			*val =
> > +			    (data->buffer[2] << 3) +
> > +			    ((data->buffer[3] & 0xe0) >> 5);
> 
> Is this some endianess / sign extension? Please convert using proper APIs.

the raw conversion data is spread over 4 bytes and interlaced with other info (see comment above the function).
I'm just cherry-picking the bits I'm interested in, in a way my brain can understand what is going on.

> > +			ret = 0;
> > +			if (!ret)
> 
> lol

I should leave that in for comic relief. missed it after a lot of code changes.

> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (channel->type) {
> > +		case IIO_TEMP:
> > +			*val = -50000000;
> > +			*val2 = 97704;
> > +			return IIO_VAL_FRACTIONAL;
> > +		case IIO_PRESSURE:
> > +			*val = data->p_offset;
> > +			*val2 = data->p_offset_nano;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> 
> > +	return ret;
> 
> Use default with explicit error code.

ack.

> > +static const struct iio_chan_spec hsc_channels[] = {
> > +	{
> > +	 .type = IIO_PRESSURE,
> > +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
> > +	 },
> > +	{
> > +	 .type = IIO_TEMP,
> > +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
> > +	 },
> 
> Strange indentation of }:s...

I blame `indent -linux --line-length 80` for these and weirdly-spaced pointer declarations.
are you using something else?

> > +int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
> > +	      const char *name, int type)
> > +{
> > +	struct hsc_data *hsc;
> > +	u64 tmp;
> > +	int index;
> > +	int found = 0;
> > +
> > +	hsc = iio_priv(indio_dev);
> > +
> > +	hsc->last_update = jiffies - HZ;
> > +	hsc->chip = &hsc_chip;
> > +
> > +	if (strcasecmp(hsc->range_str, "na") != 0) {
> > +		// chip should be defined in the nomenclature
> > +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> > +			if (strcasecmp
> > +			    (hsc_range_config[index].name,
> > +			     hsc->range_str) == 0) {
> > +				hsc->pmin = hsc_range_config[index].pmin;
> > +				hsc->pmax = hsc_range_config[index].pmax;
> > +				found = 1;
> > +				break;
> > +			}
> > +		}
> 
> Reinventing match_string() / sysfs_match_string() ?

match_string() is case-sensitive and operates on string arrays, so unfit for this purpose.

> > +struct hsc_data {
> > +	void *client;                           // either i2c or spi kernel interface struct for current dev
> > +	const struct hsc_chip_data *chip;
> > +	struct mutex lock;                      // lock protecting chip reads
> > +	int (*xfer)(struct hsc_data *data);    // function that implements the chip reads
> > +	bool is_valid;                          // false if last transfer has failed
> > +	unsigned long last_update;              // time of last successful conversion
> > +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE]; // raw conversion data
> > +	char range_str[HSC_RANGE_STR_LEN];	// range as defined by the chip nomenclature - ie "030PA" or "NA"
> > +	s32 pmin;                               // min pressure limit
> > +	s32 pmax;                               // max pressure limit
> > +	u32 outmin;                             // minimum raw pressure in counts (based on transfer function)
> > +	u32 outmax;                             // maximum raw pressure in counts (based on transfer function)
> > +	u32 function;                           // transfer function
> > +	s64 p_scale;                            // pressure scale
> > +	s32 p_scale_nano;                       // pressure scale, decimal places
> > +	s64 p_offset;                           // pressure offset
> > +	s32 p_offset_nano;                      // pressure offset, decimal places
> > +};
> > +
> > +struct hsc_chip_data {
> > +	bool (*valid)(struct hsc_data *data);  // function that checks the two status bits
> > +	const struct iio_chan_spec *channels;   // channel specifications
> > +	u8 num_channels;                        // pressure and temperature channels
> > +};
> 
> Convert comments to kernel-doc format.

ack. switched to kernel-doc format in multiple places.

> > +enum hsc_func_id {
> > +	HSC_FUNCTION_A,
> > +	HSC_FUNCTION_B,
> > +	HSC_FUNCTION_C,
> > +	HSC_FUNCTION_F
> 
> Leave trailing comma. It make code slightly better to maintain.

ack

> > +static int hsc_i2c_xfer(struct hsc_data *data)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	struct i2c_msg msg;
> > +	int ret;
> > +
> > +	msg.addr = client->addr;
> > +	msg.flags = client->flags | I2C_M_RD;
> > +	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
> > +	msg.buf = (char *)&data->buffer;
> > +
> > +	ret = i2c_transfer(client->adapter, &msg, 1);
> > +
> > +	return (ret == 2) ? 0 : ret;
> > +}
> 
> Can you use regmap I2C?

the communication is one-way as in the sensors do not expect anything except 4 bytes-worth of clock signals per 'packet' for both the i2c and spi versions.
regmap is suited to sensors with an actual memory map.

> > +static int hsc_i2c_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> 
> No use of this function prototype, we have a new one.

oops, I was hoping my 6.1.38 kernel is using the same API as 6.7.0
fixed.

> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > +	if (!indio_dev) {
> 
> > +		dev_err(&client->dev, "Failed to allocate device\n");
> > +		return -ENOMEM;
> 
> First of all, use
> 
> 		return dev_err_probe();
> 
> Second, since it's ENOMEM, we do not issue an errors like this, error
> code is already enough.

ack

> 
> > +	}
> > +
> > +	hsc = iio_priv(indio_dev);
> 
> > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		hsc->xfer = hsc_i2c_xfer;
> > +	else
> 
> Redundant 'else', see below.
> 
> > +		return -EOPNOTSUPP;
> 
> Use traditional pattern, i.e. checking for errors first:
> 
> 	if (...)
> 		return ...

ack

> > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > +	if (ret == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> 
> Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
> interesting.

since I'm unable to test this I'd rather remove the block altogether.
if I go the ENODEV route my module will never load since I can't see any vdd-supply support on my devboard.

> > +	if (!dev_fwnode(dev))
> > +		return -EOPNOTSUPP;
> 
> Why do you need this?
> And why this error code?

it's intentional.
this module has a hard requirement on the correct parameters (transfer function and pressure range) being provided in the devicetree.
without those I don't want to provide any measurements since there can't be a default transfer function and pressure range for a generic driver that supports an infinite combination of those.

echo hsc030pa 0x28 > /sys/bus/i2c/devices/i2c-0/new_device
I want iio_info to detect 0 devices.

> > +	memcpy(hsc->range_str, range_nom, HSC_RANGE_STR_LEN - 1);
> > +	hsc->range_str[HSC_RANGE_STR_LEN - 1] = 0;
> 
> Oh, why do you need this all and can use the property value directly?
> (Besides the fact the interesting operations are being used for strings.)

using directly and moved to main probe() file.

> > +MODULE_DEVICE_TABLE(of, hsc_i2c_match);
> > +
> > +static const struct i2c_device_id hsc_i2c_id[] = {
> > +	{"hsc", HSC},
> > +	{"ssc", SSC},
> 
> Both ID tables should use pointers in driver data and respective API to get
> that.

re-written based on bindings thread.

> > +	spi_set_drvdata(spi, indio_dev);
> 
> How is this being used?

removed.

> > +	spi->mode = SPI_MODE_0;
> > +	spi->max_speed_hz = min(spi->max_speed_hz, 800000U);
> > +	spi->bits_per_word = 8;
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> 
> Why the firmware can't provide the correct information to begin with?

moved 800kHz max requirement to the bindings file.

> > +	ret = device_property_read_u32(dev,
> > +				       "honeywell,transfer-function",
> > +				       &hsc->function);
..
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "honeywell,pmax-pascal could not be read\n");
> > +	}
> 
> Ditto. Why is this duplication?

you're right, moved to main probe()

> -- 
> With Best Regards,
> Andy Shevchenko

patches are ready, but awaiting any aditional feedback to this message.

thanks again,
peter

-- 
petre rodan
