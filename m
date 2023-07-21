Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18DE75C60D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGULrQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGULrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:47:15 -0400
X-Greylist: delayed 3000 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 04:47:10 PDT
Received: from mx11.pro-ite.de (ox4u.de [212.118.221.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E11FD7;
        Fri, 21 Jul 2023 04:47:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ox4u.de
Received: from ox4u-portal.int.pro-ite.de (ox4u-portal.int.pro-ite.de [10.56.12.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx11.pro-ite.de (Postfix) with ESMTPSA id 5C14818E00DF2;
        Fri, 21 Jul 2023 12:08:34 +0200 (CEST)
Date:   Fri, 21 Jul 2023 12:08:35 +0200 (CEST)
From:   Andre Werner <andre.werner@systec-electronic.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andre Werner <werneazc@gmail.com>
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1739357210.100019.1689934116025@ox4u.de>
In-Reply-To: <ed7a5ab6-3b54-461a-bfa9-7758abd12762@roeck-us.net>
References: <20230718112810.21322-1-andre.werner@systec-electronic.com>
 <20230718112810.21322-2-andre.werner@systec-electronic.com>
 <ed7a5ab6-3b54-461a-bfa9-7758abd12762@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: (hs3001) Add driver for Renesas HS3001
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev27
X-Originating-Client: open-xchange-appsuite
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,

I pushed a new version for the open patch. In addition find my comments to your feedback.

> On 07/19/2023 5:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
>  
> On Tue, Jul 18, 2023 at 01:28:10PM +0200, Andre Werner wrote:
> > Add base support for Renesas HS3001 temperature
> > and humidity sensors and its compatibles HS3002,
> > HS3003 and HS3004.
> > 
> > The sensor has a fix I2C address 0x44. The resolution
> > is fixed to 14bit (ref. Missing feature).
> > 
> > Missing feature:
> > - Accessing non-volatile memory: Custom board has no
> >   possibility to control voltage supply of sensor. Thus,
> >   we cannot send the necessary control commands within
> >   the first 10ms after power-on.
> > 
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 
> checkpatch reports:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Andre Werner <werneazc@gmail.com>' != 'Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>'
> 
> Please make sure that both addresses match; I can not accept your
> patch otherwise.

With our mail provider I was currently not able to send the patch. I will try again sending the next patch version.

> 
> > ---
> > Changelog:
> > v1: Initial version
> > v2: Extensive refactoring following recommendations of reviewers:
> >  - Delete unused defines and device properties. These are added in
> >    the initial version because the device supports a programming mode,
> >    but I was not able to implement it, because the custom board was
> >    not able to control the power supply of the device and so I cannot
> >    enter the programming mode of the device.
> >  - Correct missunderstanding comments for defines.
> >  - Delete mutexes for data and I2C bus accesses.
> >  - Replace attributes with recommented chip-info structure. In the
> >    initial version I followed the sth3x.c implementation that uses
> >    files and attributes in sysfs. The show functions are replaced by
> >    is_visible and read callbacks from the HWMON ABI. I also  delete pointless
> >    function argument checks.
> >  - Correct Yoda programming.
> >  - Refactor probe function and delete sleep and measurement of humidity
> >    and temperature in probe function. I kept an initial I2C
> >    communication to ensure that the device is accessible during probe.
> >  - Reduce the number of atteributes to humidity and temperature input.
> >  v3: Delete chip data because it is unused.
> > ---
> >  Documentation/hwmon/hs3001.rst |  37 +++++
> >  MAINTAINERS                    |   6 +
> >  drivers/hwmon/Kconfig          |  10 ++
> >  drivers/hwmon/Makefile         |   1 +
> >  drivers/hwmon/hs3001.c         | 249 +++++++++++++++++++++++++++++++++
> >  5 files changed, 303 insertions(+)
> >  create mode 100644 Documentation/hwmon/hs3001.rst
> >  create mode 100644 drivers/hwmon/hs3001.c
> > 
> > diff --git a/Documentation/hwmon/hs3001.rst b/Documentation/hwmon/hs3001.rst
> > new file mode 100644
> > index 000000000000..703fb9c45313
> > --- /dev/null
> > +++ b/Documentation/hwmon/hs3001.rst
> > @@ -0,0 +1,37 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver HS3001
> > +===================
> > +
> > +Supported chips:
> > +
> > +  * Renesas HS3001, HS3002, HS3003, HS3004
> > +
> > +    Prefix: 'hs3001'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://www.renesas.com/us/en/document/dst/hs300x-datasheet?r=417401
> > +
> > +Author:
> > +
> > +  - Andre Werner <andre.werner@systec-electronic.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for the Renesas HS3001 chips, a humidity
> > +and temperature family. Temperature is measured in degrees celsius, relative
> > +humidity is expressed as a percentage. In the sysfs interface, all values are
> > +scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
> > +
> > +The device communicates with the I2C protocol. Sensors have the I2C
> > +address 0x44 by default.
> > +
> > +sysfs-Interface
> > +---------------
> > +
> > +===============================================================================
> > +temp1_input:        temperature input
> > +humidity1_input:    humidity input
> > +===============================================================================
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aee340630eca..25d5282b43aa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9494,6 +9494,12 @@ S:	Maintained
> >  W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
> >  F:	fs/hpfs/
> >  
> > +HS3001 Hardware Temperature and Humidity Sensor
> > +M:	Andre Werner <andre.werner@systec-electronic.com>
> > +L:	linux-hwmon@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/hwmon/hs3001.c
> > +
> >  HSI SUBSYSTEM
> >  M:	Sebastian Reichel <sre@kernel.org>
> >  S:	Maintained
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 307477b8a371..ca6be5a23271 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -734,6 +734,16 @@ config SENSORS_HIH6130
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called hih6130.
> >  
> > +config SENSORS_HS3001
> > +	tristate "Renesas HS3001 humidity and temperature sensors"
> > +	depends on I2C
> > +	help
> > +	  If you say yes here you get support for the Renesas HS3001,
> > +	  to HS3004 humidity and temperature sensors.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called hs3001.
> > +
> >  config SENSORS_IBMAEM
> >  	tristate "IBM Active Energy Manager temperature/power sensors and control"
> >  	select IPMI_SI
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 3f4b0fda0998..cdae4e1fc919 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -86,6 +86,7 @@ obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> >  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> >  obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
> >  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
> > +obj-$(CONFIG_SENSORS_HS3001)	+= hs3001.o
> >  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
> >  obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
> >  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
> > diff --git a/drivers/hwmon/hs3001.c b/drivers/hwmon/hs3001.c
> > new file mode 100644
> > index 000000000000..162466d35cc2
> > --- /dev/null
> > +++ b/drivers/hwmon/hs3001.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * This is a non-complete driver implementation for the
> > + * HS3001 humidity and temperature sensor and compatibles. It does not include
> > + * the configuration possibilities, where it needs to be set to 'programming mode'
> > + * during power-up.
> > + *
> > + *
> > + * Copyright (C) 2023 SYS TEC electronic AG
> > + * Author: Andre Werner <andre.werner@systec-electronic.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +/* Measurement times */
> > +#define HS3001_WAKEUP_TIME		100		/* us */
> > +#define HS3001_8BIT_RESOLUTION	550		/* us */
> > +#define HS3001_10BIT_RESOLUTION	1310	/* us */
> > +#define HS3001_12BIT_RESOLUTION	4500	/* us */
> > +#define HS3001_14BIT_RESOLUTION	16900	/* us */
> > +
> > +#define HS3001_RESPONSE_LENGTH	4
> > +
> > +#define HS3001_FIXPOINT_ARITH	1000
> > +#define HS3001_MIN_TEMPERATURE	(-40 * HS3001_FIXPOINT_ARITH)	/* milli degree */
> > +#define HS3001_MAX_TEMPERATURE	(125 * HS3001_FIXPOINT_ARITH)	/* milli degree */
> > +#define HS3001_MIN_HUMIDITY		(0 * HS3001_FIXPOINT_ARITH)	/* milli percent */
> > +#define HS3001_MAX_HUMIDITY		(100 * HS3001_FIXPOINT_ARITH)	/* milli percent */
> 
> MIN_ and MAX_ values are not used anywhere.
> 

Deleted.

> > +
> > +#define HS3001_MASK_HUMIDITY_0X3FFF		0x3FFF
> > +#define HS3001_MASK_TEMPERATURE_0XFFFC	0xFFFC
> > +#define HS3001_MASK_STATUS_0XC0			0xC0
> > +#define HS3001_STATUS_SHIFT				6
> 
> Please use GENMASK() and FIELD_GET().

ACK.

> 
> > +
> > +/* Definitions for Status Bits of A/D Data */
> > +#define HS3001_DATA_VALID	0x00	/* Valid Data */
> > +#define HS3001_DATA_STALE	0x01	/* Stale Data */
> > +
> > +#define LIMIT_MAX	0
> > +#define LIMIT_MIN	1
> 
> Unused

Deleted.

> 
> > +
> > +struct hs3001_data {
> > +	struct i2c_client *client;
> > +	u32 wait_time;		/* in us */
> > +	int temperature;	/* in milli degree */
> > +	u32 humidity;		/* in milli % */
> > +};
> > +
> > +static int hs3001_extract_temperature(u16 raw)
> > +{
> > +	/* fixpoint arithmetic 1 digit */
> > +	int temp = ((raw & HS3001_MASK_TEMPERATURE_0XFFFC) >> 2) *
> 
> That mask is unnecessary: The incoming value is 16 bit, and the lower two bit
> will be shifted out anyway.

I get your point. Deleted.

> 
> > +	    HS3001_FIXPOINT_ARITH;
> > +
> > +	temp /= (1 << 14) - 1;
> > +
> > +	return temp * 165 - 40 * HS3001_FIXPOINT_ARITH;
> 
> Why limit temperature values to multiples of 0.165 degrees C ?

I do not fully understand that question. I follow the equations from the
datasheet, except that I multiplied the input by 1000 to calculated in milli
degree celsius or in milli percent. The outputs are proven by sysfs-access and
libsensors using a heater / coolant spray in Linux. I also used a second external
thermometer at the sensor and measure the temperature in parallel. It all looks
reasonable. 

> 
> > +}
> > +
> > +static u32 hs3001_extract_humidity(u16 raw)
> > +{
> > +	int hum = (raw & HS3001_MASK_HUMIDITY_0X3FFF) * HS3001_FIXPOINT_ARITH;
> > +
> > +	hum /= (1 << 14) - 1;
> > +
> > +	return hum * 100;
> 
> I think I asked before: Why limit humidity value range to 0.1 % when
> the chip reports fractions ?

See my answer to the temperature values section.

> 
> > +}
> > +
> > +static int hs3001_data_fetch_command(struct i2c_client *client,
> > +				     struct hs3001_data *data)
> > +{
> > +	int ret;
> > +	u8 buf[HS3001_RESPONSE_LENGTH];
> > +	u8 hs3001_status;
> > +
> > +	ret = i2c_master_recv(client, buf, HS3001_RESPONSE_LENGTH);
> > +
> 
> Drop empty lines between assignments and value checks

Done.

> 
> > +	if (ret != HS3001_RESPONSE_LENGTH) {
> > +		ret = ret < 0 ? ret : -EIO;
> > +		dev_dbg(&client->dev,
> > +			"Error in i2c communication. Error code: %d.\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	hs3001_status = (buf[0] & HS3001_MASK_STATUS_0XC0) >>
> > +	    HS3001_STATUS_SHIFT;
> > +	if (hs3001_status == HS3001_DATA_STALE) {
> > +		dev_dbg(&client->dev, "Sensor busy.\n");
> > +		return -EBUSY;
> > +	} else if (hs3001_status != HS3001_DATA_VALID) {
> 
> No else after return

Done.

> 
> > +		dev_dbg(&client->dev, "Data invalid.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	data->humidity =
> > +	    hs3001_extract_humidity(be16_to_cpup((__be16 *)&buf[0]));
> > +	data->temperature =
> > +	    hs3001_extract_temperature(be16_to_cpup((__be16 *)&buf[2]));
> > +
> > +	return 0;
> > +}
> > +
> > +umode_t hs3001_is_visible(const void *data, enum hwmon_sensor_types type,
> 
> static

Done.

> 
> > +			  u32 attr, int channel)
> > +{
> > +	/* Both, humidity and temperature can only be read. */
> > +	return 0444;
> > +}
> > +
> > +int hs3001_read(struct device *dev, enum hwmon_sensor_types type,
> 
> static

Done.

> 
> > +		u32 attr, int channel, long *val)
> > +{
> > +	struct hs3001_data *data = dev_get_drvdata(dev);
> > +	struct i2c_client *client = data->client;
> > +	int ret;
> > +
> 
> The sequence from here
> 
> > +	ret = i2c_master_send(client, NULL, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Sensor needs some time to process measurement depending on
> > +	 * resolution
> > +	 */
> > +	fsleep(data->wait_time);
> > +
> > +	ret = hs3001_data_fetch_command(client, data);
> 
> to here needs to be mutex protected, or a second reader could step in
> and repeat the master send command before the data is ready.
> 

Done.

> The datasheet doesn't say what happens if a measurement request
> is sent before the previous measurement is complete. Even if that
> is safe, there would be a race condition where a second request is sent
> before the measurement after to the first request is complete and/or
> fetched. In that case, the chip might respond with "stale data"
> to the second fetch request.
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			*val = data->temperature;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case hwmon_humidity:
> > +		switch (attr) {
> > +		case hwmon_humidity_input:
> > +			*val = data->humidity;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_channel_info *hs3001_info[] = {
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > +	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_ops hs3001_hwmon_ops = {
> > +	.is_visible = hs3001_is_visible,
> > +	.read = hs3001_read,
> > +};
> > +
> > +static const struct hwmon_chip_info hs3001_chip_info = {
> > +	.ops = &hs3001_hwmon_ops,
> > +	.info = hs3001_info,
> > +};
> > +
> > +/* device ID table */
> > +static const struct i2c_device_id hs3001_ids[] = {
> > +	{ "hs3001", 0 },
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, hs3001_ids);
> > +
> > +static const struct of_device_id hs3001_of_match[] = {
> > +	{.compatible = "renesas,hs3001"},
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, hs3001_of_match);
> > +
> > +static int hs3001_probe(struct i2c_client *client)
> > +{
> > +	struct hs3001_data *data;
> > +	struct device *hwmon_dev;
> > +	struct device *dev = &client->dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return -EOPNOTSUPP;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->client = client;
> > +
> > +	/*
> > +	 * Measurement time = wake-up time + measurement time temperature
> > +	 * + measurment time humidity. This is currently static, because
> > +	 * enabling programming mode is not supported, yet.
> > +	 */
> 
> Unrelated, but that chip is weird. "... sequence of commands needed to
> enter the programming mode, which must be sent within 10ms after applying
> power to the sensor" - who can realistically guarantee that, taking
> the ramp rate of a power supply into account ?

Yes, of course. It looks that it is usually used with microcontrollers.

> 
> > +	data->wait_time = (HS3001_WAKEUP_TIME + HS3001_14BIT_RESOLUTION +
> > +			   HS3001_14BIT_RESOLUTION);
> > +
> > +	/* Test access to device */
> > +	ret = i2c_master_send(client, NULL, 0);
> > +	if (ret)
> > +		return ret;
> 
> I am wondering: Does that add any practical value ? As far as I can see
> it effectively just checks if a device is there, which doesn't mean
> anything except that it also triggers a conversion if this is indeed
> a HS3001/HS3003.

I wanted to guarantee that the device is present in probe, because
I thought that using the devicetree to define the chip for a platform,
the hwmon device get registered in probe function even the chip is
not available. I can drop that if you recommend it. Moreover, it
initializes the data registers in the device to overcome the issue:

(Datasheet chapter 4.7)
"If a data fetch is performed before or during the first measurement after power-on reset, then the stale
status will be returned, but this data is actually invalid since the first measurement has not been completed."

So it should prevent to get wrong data from chip if accessing the device the first time to get values.

In the first version I also add the measure delay, but it was recommended to delete
it to not increase boot timings when using that sensor.

> 
> On top of that, what happens if a user actually requests data (calls a
> read function) before the response to this measurement request is
> complete ? Does the chip handle this properly, or is it possible that
> it gets confused ?
> 

As far as I understand, if you request data to frequently, the status bits of
the chip signals stale that is the data is old thus a measurement may be
in progress.

> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> > +				client->name, data, &hs3001_chip_info, NULL);
> > +
> CHECK: Alignment should match open parenthesis
> #454: FILE: drivers/hwmon/hs3001.c:227:
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +				client->name, data, &hs3001_chip_info, NULL);
> 
> You can use up to 100 columns.

Done

> 
> > +	if (IS_ERR(hwmon_dev))
> > +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> > +				     "Unable to register hwmon device.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static struct i2c_driver hs3001_i2c_driver = {
> > +	.driver = {
> > +		   .name = "hs3001",
> > +		   .of_match_table = hs3001_of_match,
> > +	},
> > +	.probe_new = hs3001_probe,
> > +	.id_table = hs3001_ids,
> > +};
> > +
> > +module_i2c_driver(hs3001_i2c_driver);
> > +
> > +MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
> > +MODULE_DESCRIPTION("HS3001 humidity and temperature sensor base  driver");
> 

Done.

> s/  / / (double space between base and driver)
> > +MODULE_LICENSE("GPL");

Regards,
André
