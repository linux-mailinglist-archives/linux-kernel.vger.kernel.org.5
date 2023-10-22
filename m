Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C07D259B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjJVTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 15:35:41 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7EEE;
        Sun, 22 Oct 2023 12:35:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 361CB20003;
        Sun, 22 Oct 2023 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698003332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYpgWJJf8zv+z5DFb3D3Dt9r752umviV97trLK7LvvM=;
        b=REyT4wHU4cY4stlNdikjl8pxKFdFutH11YKtYE8fUOz88B9aZHLvoVSQX8P++W/62gBANj
        I46V66jjN74awznZaf1zrrhS9/i8THaqiEgveyuM6gxVXv3u3hqQebN5RNKZXq/FAPR8zL
        EP/xd2X8n/8RibHhrkAkp9K4B4xxEPhvF8/6dIuhzf2AjAVoIwsUGWdwEPOgAKad5097mO
        DQYRHA5gLLDVjBWlCJVK8Qk2yMZ7knUxUjJ1a28mo3nDXFlDbVa8O7AjZRq4NwIZNqoMAe
        CxE8qDKPQyDkgs2666UDRLu1jd9HGVrmYvLt50L3omInewhas1qTOWYWx1i6WA==
Date:   Sun, 22 Oct 2023 21:35:29 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.satterthwaite@touchnetix.com,
        bartp@baasheep.co.uk, hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v3 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20231022193529.GC3072@kb-xps>
References: <20231012074034.1090436-1-kamel.bouhara@bootlin.com>
 <20231012074034.1090436-4-kamel.bouhara@bootlin.com>
 <20231020120310.vrn6ew3fcg5e545w@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020120310.vrn6ew3fcg5e545w@pengutronix.de>
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:03:10PM +0200, Marco Felsch wrote:
> Hi Kamel,
>

Hi Marco,

> just a rough review.

Thanks !

[...]

> > +#include <linux/crc16.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pm.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
>
> Can you please check if all headers are required e.g. sting.h
> seems a bit suspicious here.

Sure, slab.h and string.h are no more required.

>
> > +/*
> > + * Runtime TCP mode: device is executing normal code and is
> > + * accessible via the Touch Controller Mode
> > + */
> > +#define BOOT_TCP			0
> > +/*
> > + * Bootloader BLP mode: device is executing bootloader and is
> > + * accessible via the Boot Loader Protocol.
> > + */
> > +#define BOOT_BLP			1
>
> Both defines are not used.
>

Ack.

> > +#define AXIOM_PROX_LEVEL		-128
> > +/*
> > + * Register group u31 has 2 pages for usage table entries.
> > + * (2 * AXIOM_COMMS_PAGE_SIZE) / AXIOM_U31_BYTES_PER_USAGE = 85
i> > + */
> > +#define AXIOM_U31_MAX_USAGES		85
>
> The programmer's guid describe the usage as hexadecimal number prefixed
> with an 'u'. The current range is from u00 till uFF, so the max. usages
> should be 0xff.

Based one the above comment, it seems we are computing the byte size of
an usage array. I agree this might require to be more clear though.

>
> > +#define AXIOM_U31_BYTES_PER_USAGE	6
> > +#define AXIOM_U31_PAGE0_LENGTH		0x0C
> > +#define AXIOM_U31_BOOTMODE_MASK		BIT(7)
> > +#define AXIOM_U31_FW_INFO_VARIANT_MASK	GENMASK(6, 0)
> > +#define AXIOM_U31_FW_INFO_STATUS_MASK	BIT(7)
> > +
> > +#define AXIOM_U41_MAX_TARGETS		10
> > +
> > +#define AXIOM_U46_AUX_CHANNELS		4
> > +#define AXIOM_U46_AUX_MASK		GENMASK(11, 0)
>
> I'm still not very happy with the decoding, since the so called
> 'protocol' is clear and versioned we can add the all required protocols
> as struct which has far less magic offsets.

Im not sure it will really make a significant difference as we actually
ihave a limited set of registers for the i2c driver, also could you
please clarify what protocol your refering to here ?

>
> > +
> > +#define AXIOM_COMMS_MAX_USAGE_PAGES	3
> > +#define AXIOM_COMMS_PAGE_SIZE		256
> > +#define AXIOM_COMMS_OVERFLOW_MASK	BIT(7)
> > +#define AXIOM_COMMS_REPORT_LEN_MASK	GENMASK(7, 0)
> > +
> > +#define AXIOM_REBASELINE_CMD		0x03
> > +
> > +#define AXIOM_REPORT_USAGE_ID		0x34
> > +#define AXIOM_DEVINFO_USAGE_ID		0x31
> > +#define AXIOM_USAGE_2HB_REPORT_ID	0x01
> > +#define AXIOM_REBASELINE_USAGE_ID	0x02
> > +#define AXIOM_USAGE_2AUX_REPORT_ID	0x46
> > +#define AXIOM_USAGE_2DCTS_REPORT_ID	0x41
> > +
> > +#define AXIOM_PAGE_MASK			GENMASK(15, 8)
>
> Unused

Ack thx.

[...]

> > +/*
> > + * Holds state of a touch or target when detected prior a touch (eg.
> > + * hover or proximity events).
> > + */
> > +enum axiom_target_state {
> > +	TARGET_STATE_NOT_PRESENT = 0,
> > +	TARGET_STATE_PROX = 1,
> > +	TARGET_STATE_HOVER = 2,
> > +	TARGET_STATE_TOUCHING = 3,
> > +	TARGET_STATE_MIN = TARGET_STATE_NOT_PRESENT,
> > +	TARGET_STATE_MAX = TARGET_STATE_TOUCHING,
>
> STATE_MIN/MAX not used.

Ack.

>
> > +};
> > +
> > +struct u41_target {
> > +	enum axiom_target_state state;
> > +	u16 x;
> > +	u16 y;
> > +	s8 z;
> > +	bool insert;
> > +	bool touch;
> > +};
> > +
> > +struct axiom_target_report {
> > +	u8 index;
> > +	u8 present;
> > +	u16 x;
> > +	u16 y;
> > +	s8 z;
> > +};
> > +
> > +struct axiom_cmd_header {
> > +	u16 target_address;
> > +	u16 length:15;
> > +	u16 read:1;
> > +} __packed;
> > +
> > +struct axiom_data {
> > +	struct axiom_devinfo devinfo;
> > +	struct device *dev;
> > +	struct gpio_desc *reset_gpio;
> > +	struct gpio_desc *irq_gpio;
>
> No need to store the irq_gpio here.
>

Right, thanks.

> > +	struct i2c_client *client;
> > +	struct input_dev *input_dev;
> > +	u32 max_report_len;
> > +	u32 report_overflow_counter;
> > +	u32 report_counter;
> > +	char rx_buf[AXIOM_COMMS_MAX_USAGE_PAGES * AXIOM_COMMS_PAGE_SIZE];
> > +	struct u41_target targets[AXIOM_U41_MAX_TARGETS];
> > +	struct usage_entry usage_table[AXIOM_U31_MAX_USAGES];
> > +	bool usage_table_populated;
> > +};
> > +
> > +/*
> > + * aXiom devices are typically configured to report
> > + * touches at a rate of 100Hz (10ms). For systems
> > + * that require polling for reports, 100ms seems like
> > + * an acceptable polling rate.
> > + * When reports are polled, it will be expected to
> > + * occasionally observe the overflow bit being set
> > + * in the reports. This indicates that reports are not
> > + * being read fast enough.
> > + */
> > +#define POLL_INTERVAL_DEFAULT_MS 100
>
> Above you describe that the touch-rate is ~10ms why do we configure it
> 10-times lower here? Also 100ms is huge if you think about user respone
> time.

I am not completely sure aboud this yet, here 100ms is based on my own
*limited* experience, I agree we should stick to the 10ms.

>
> > +/* Translate usage/page/offset triplet into physical address. */
> > +static u16
> > +usage_to_target_address(struct axiom_data *ts, char usage, char page,
> > +			char offset)
> > +{
> > +	struct axiom_devinfo *device_info;
> > +	struct usage_entry *usage_table;
> > +	u32 i;
> > +
> > +	device_info = &ts->devinfo;
> > +	usage_table = ts->usage_table;
> > +
> > +	/* At the moment the convention is that u31 is always at physical address 0x0 */
> > +	if (!ts->usage_table_populated) {
> > +		if (usage == AXIOM_DEVINFO_USAGE_ID)
> > +			return ((page << 8) + offset);
> > +		else
> > +			return 0xffff;
> > +	}
> > +
> > +	for (i = 0; i < device_info->num_usages; i++) {
> > +		if (usage_table[i].id != usage)
> > +			continue;
> > +
> > +		if (page >= usage_table[i].num_pages) {
> > +			dev_err(ts->dev, "Invalid usage table! usage: %u, page: %u, offset: %u\n",
> > +				usage, page, offset);
> > +			return 0xffff;
> > +		}
> > +	}
>
> We can avoid this loop if we store the usage table exactly as it is,
> e.g.:
>
> 	usage_table[0x31] = u31;
> 	usage_table[0x41] = u41;
>

Could you please explain your idea ?

> > +	return ((usage_table[i].start_page + page) << 8) + offset;
> > +}
> > +
> > +static int
> > +axiom_i2c_read(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> > +{
> > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > +	struct axiom_cmd_header cmd_header;
> > +	struct i2c_msg msg[2];
> > +	int ret;
> > +
> > +	cmd_header.target_address = cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> > +	cmd_header.length = cpu_to_le16(len);
> > +	cmd_header.read = 1;
> > +
> > +	msg[0].addr = client->addr;
> > +	msg[0].flags = 0;
> > +	msg[0].len = sizeof(cmd_header);
> > +	msg[0].buf = (u8 *)&cmd_header;
> > +
> > +	msg[1].addr = client->addr;
> > +	msg[1].flags = I2C_M_RD;
> > +	msg[1].len = len;
> > +	msg[1].buf = (char *)buf;
> > +
> > +	ret = i2c_transfer(client->adapter, msg, 2);
> > +	if (ret != ARRAY_SIZE(msg)) {
> > +		dev_err(&client->dev,
> > +			"Failed reading usage %#x page %#x, error=%d\n",
> > +			usage, page, ret);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +axiom_i2c_write(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> > +{
> > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > +	struct axiom_cmd_header cmd_header;
> > +	struct i2c_msg msg[2];
> > +	int ret;
> > +
> > +	cmd_header.target_address = cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> > +	cmd_header.length = cpu_to_le16(len);
> > +	cmd_header.read = 0;
> > +
> > +	msg[0].addr = client->addr;
> > +	msg[0].flags = 0;
> > +	msg[0].len = sizeof(cmd_header);
> > +	msg[0].buf = (u8 *)&cmd_header;
> > +
> > +	msg[1].addr = client->addr;
> > +	msg[1].flags = 0;
> > +	msg[1].len = len;
> > +	msg[1].buf = (char *)buf;
>
> Please check the "comms protocol app note", for write it is not allowed
> to send a stop, so the whole data must be send in one i2c_msg.
>

Well I only have the "Programmer's Guide", I'll have to check that as it
really seems to works as it yet.

> > +
> > +	ret = i2c_transfer(client->adapter, msg, 2);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"Failed to write usage %#x page %#x, error=%d\n", usage,
> > +			page, ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Decodes and populates the local Usage Table.
> > + * Given a buffer of data read from page 1 onwards of u31 from an aXiom
> > + * device.
> > + */
> > +static u32 axiom_populate_usage_table(struct axiom_data *ts, char *rx_data)
> > +{
> > +	u32 usage_id = 0;
> > +	u32 max_report_len = 0;
> > +	struct axiom_devinfo *device_info;
> > +	struct usage_entry *usage_table;
> > +
> > +	device_info = &ts->devinfo;
> > +	usage_table = ts->usage_table;
> > +
> > +	for (usage_id = 0; usage_id < device_info->num_usages; usage_id++) {
> > +		u16 offset = (usage_id * AXIOM_U31_BYTES_PER_USAGE);
> > +		char id = rx_data[offset + 0];
> > +		char start_page = rx_data[offset + 1];
> > +		char num_pages = rx_data[offset + 2];
> > +		u32 max_offset = ((rx_data[offset + 3] & AXIOM_PAGE_OFFSET_MASK) + 1) * 2;
> > +
> > +		if (!num_pages)
> > +			usage_table[usage_id].is_report = true;
> > +
> > +		/* Store the entry into the usage table */
> > +		usage_table[usage_id].id = id;
> > +		usage_table[usage_id].start_page = start_page;
> > +		usage_table[usage_id].num_pages = num_pages;
> > +
> > +		dev_dbg(ts->dev, "Usage %2u Info: %*ph\n", usage_id,
> > +			AXIOM_U31_BYTES_PER_USAGE,
> > +			&rx_data[offset]);
> > +
> > +		/* Identify the max report length the module will receive */
> > +		if (usage_table[usage_id].is_report && max_offset > max_report_len)
> > +			max_report_len = max_offset;
> > +	}
>
> As said, the sorting can be really easy:
>
> 		usage_table[0x01] = u01;
> 		usage_table[0x31] = u31;
>

I still don't get your point here.

> > +	ts->usage_table_populated = true;
> > +
> > +	return max_report_len;
> > +}
> > +

[...]

> > +
> > +static int axiom_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct input_dev *input_dev;
> > +	struct axiom_data *ts;
> > +	int ret;
> > +	int target;
> > +
> > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +	if (!ts)
> > +		return -ENOMEM;
> > +
> > +	ts->client = client;
> > +	i2c_set_clientdata(client, ts);
> > +	ts->dev = dev;
> > +
> > +	ts->irq_gpio = devm_gpiod_get_optional(dev, "irq", GPIOD_IN);
> > +	if (IS_ERR(ts->irq_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(ts->irq_gpio), "failed to get irq GPIO");
>
> Nope you removed this from the binding.

Yes, will be fixed in v4.

>
> > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ts->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
>
> Please also add a regulator for the VDDI/VDDA which is required for the
> device to work properly.
>

Right, Im using the AX54 EV board with fixed regulators.

> > +	axiom_reset(ts->reset_gpio);
> > +
> > +	if (ts->irq_gpio) {
>
> Nope, please drop the ts->irq_gpio check.

Ack.

>
> > +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > +						axiom_irq, 0, dev_name(dev), ts);
> > +		if (ret < 0)
>
> If the threaded_irq does fail you can fallback to the polling mode.

Indeed.

>
> > +			return dev_err_probe(dev, ret, "Failed to request threaded IRQ\n");
> > +	}
> > +
> > +	ret = axiom_discover(ts);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed touchscreen discover\n");
> > +
> > +	ret = axiom_rebaseline(ts);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed touchscreen re-baselining\n");
> > +
> > +	input_dev = devm_input_allocate_device(ts->dev);
> > +	if (!input_dev)
> > +		return -ENOMEM;
> > +
> > +	input_dev->name = "TouchNetix aXiom Touchscreen";
> > +	input_dev->phys = "input/axiom_ts";
> > +
> > +	/* Single Touch */
> > +	input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);
> > +
> > +	/* Multi Touch */
> > +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> > +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
> > +
> > +	/* Registers the axiom device as a touchscreen instead of as a mouse pointer */
> > +	input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> > +
> > +	input_set_capability(input_dev, EV_KEY, BTN_LEFT);
> > +
> > +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> > +	set_bit(EV_REL, input_dev->evbit);
> > +	set_bit(EV_MSC, input_dev->evbit);
> > +	/* Declare that we support "RAW" Miscellaneous events */
> > +	set_bit(MSC_RAW, input_dev->mscbit);
> > +
> > +	if (!ts->irq_gpio) {
> > +		ret = input_setup_polling(input_dev, axiom_i2c_poll);
> > +		if (ret)
> > +			return	dev_err_probe(ts->dev, ret, "Unable to set up polling mode\n");
> > +		input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> > +	}
> > +
> > +	ts->input_dev = input_dev;
> > +	input_set_drvdata(ts->input_dev, ts);
> > +
> > +	/* Ensure that all reports are initialised to not be present. */
> > +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> > +		ts->targets[target].state = TARGET_STATE_NOT_PRESENT;
> > +
> > +	ret = input_register_device(input_dev);
> > +
> > +	if (ret)
> > +		return dev_err_probe(ts->dev, ret,
> > +					"Could not register with Input Sub-system.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void axiom_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > +
> > +	input_unregister_device(ts->input_dev);
>
> This can be part of devm_add_action_or_reset() and we could remove the
> .remove() callback for this driver.
>

Sure, thanks for the tips :)!

> > +}
> > +
> > +static const struct i2c_device_id axiom_i2c_id_table[] = {
> > +	{ "axiom-ax54a" },
>
> Albeit the datasheet says: "axiom ax54a" I think ax stands for axiom. So
> the name should be "ax54a" only?

Yes this is actually a good point, we can move to ax54a only.

>
> > +	{},
>
> Nit:  { },
> > +};
> > +
>
> Please drop the unnecessary newline.
>
> > +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> > +
> > +static const struct of_device_id axiom_i2c_of_match[] = {
> > +	{ .compatible = "touchnetix,axiom-ax54a", },
> > +	{}
>
> same here.
>
> > +};
> > +
>
> same here.
>
> > +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
> > +
> > +static struct i2c_driver axiom_i2c_driver = {
> > +	.driver = {
> > +		   .name = "axiom",
> > +		   .of_match_table = axiom_i2c_of_match,
> > +	},
> > +	.id_table = axiom_i2c_id_table,
> > +	.probe = axiom_i2c_probe,
> > +	.remove = axiom_i2c_remove,
> > +};
> > +
>
> same here.
>

OK.

> > +module_i2c_driver(axiom_i2c_driver);
> > +
> > +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
> > +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
> > +MODULE_AUTHOR("Mark Satterthwaite <mark.satterthwaite@touchnetix.com>");
> > +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
> > +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> > +MODULE_DESCRIPTION("TouchNetix aXiom touchscreen I2C bus driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
> >

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
