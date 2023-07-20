Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84275B6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGTSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGTSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:36:11 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E95E44;
        Thu, 20 Jul 2023 11:36:07 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1689878166;
        bh=/1/B55OPbXOmGRqqlWE45gL8DqcUzSTS0PIDXR0+4kI=;
        h=Date:From:To:Subject:Message-ID:References:Mime-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=OfnDtgd9ul8GSBrh5Fu21gW6y6U8L5RcHha5/LlQP33uuUw8BLeMpb9+6croqybu6
         f7ah+hBn5QLvGC3XNU5Y5iMvBYwSsZvXpKMfvSVq+yeuJjFuvsy90lVkp26dBILUCs
         ZRAaWWeHIDzHuAM1xWZfELqZkZyIj4ZJic+1aTE0RiTbRU+qv/0Do8Nvyp4nCIcfLU
         uxLYNGb+4U6q8Cg6UG0GIPT+/O6ZUcqS88JQ/b07x+F7R9SUBmunB4QE/2PWG8CGOg
         t8R6R2VOvNb7o90ND2565cKG5uTY9uaGU0075Lydf1EIGEAt+K+DGl/W+l3niWH6IF
         K+B6X85gtNiVQ==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] hwmon: (pmbus) Add driver fpr Infineon IR35201
Message-ID: <axue7wmaxbj7vurapabuwtvqk3br3zt2g373d6ako4m24wzaxf@2uvgmasdd7dk>
References: <20230720115805.1510279-1-hanetzer@startmail.com>
 <b86e19ed-12af-e488-3c21-002be2ad5914@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86e19ed-12af-e488-3c21-002be2ad5914@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:00:39AM -0700, Guenter Roeck wrote:
>
Maybe.On 7/20/23 04:58, Marty E. Plummer wrote:
> > The IR35201 is a dual-loop digital multi-phase buck controller designed for CPU voltage regulation.
> > 
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > ---
> >   Documentation/hwmon/index.rst   |  1 +
> >   Documentation/hwmon/ir35201.rst | 63 +++++++++++++++++++++++
> >   drivers/hwmon/pmbus/Kconfig     |  9 ++++
> >   drivers/hwmon/pmbus/Makefile    |  1 +
> >   drivers/hwmon/pmbus/ir35201.c   | 89 +++++++++++++++++++++++++++++++++
> >   5 files changed, 163 insertions(+)
> >   create mode 100644 Documentation/hwmon/ir35201.rst
> >   create mode 100644 drivers/hwmon/pmbus/ir35201.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 042e1cf9501b..5b44a268de0d 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -87,6 +87,7 @@ Hardware Monitoring Kernel Drivers
> >      ina3221
> >      inspur-ipsps1
> >      intel-m10-bmc-hwmon
> > +   ir35201
> >      ir35221
> >      ir38064
> >      ir36021
> > diff --git a/Documentation/hwmon/ir35201.rst b/Documentation/hwmon/ir35201.rst
> > new file mode 100644
> > index 000000000000..6ca34d4b02a3
> > --- /dev/null
> > +++ b/Documentation/hwmon/ir35201.rst
> > @@ -0,0 +1,63 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver ir35201
> > +=====================
> > +
> > +Supported chips:
> > +
> > +  * Infineon IR35201
> > +
> > +    Prefix: ir35201
> > +    Addresses scanned: -
> > +
> > +    Datasheet: Publicly available at the Infineon website
> > +      https://www.infineon.com/dgdl/Infineon-IR35201MTRPBF-DS-v01_00-EN.pdf?fileId=5546d462576f347501579c95d19772b5
> > +
> > +Authors:
> > +      - Marty E. Plummer <hanetzer@startmail.com>
> > +
> > +Description
> > +-----------
> > +
> > +The IR35201 is a dual-loop digital multi-phase buck controller designed for
> > +CPU voltage regulation.
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not probe for PMBus devices. You will have to instantiate
> > +devices explicitly.
> > +
> > +Sysfs attributes
> > +----------------
> > +
> > +======================= ===========================
> > +curr1_label             "iin"
> > +curr1_input             Measured input current
> > +curr1_alarm             Input fault alarm
> > +
> > +curr2_label             "iout1"
> > +curr2_input             Measured output current
> > +curr2_alarm             Output over-current alarm
> > +
> > +in1_label               "vin"
> > +in1_input               Measured input voltage
> > +in1_alarm               Input under-voltage alarm
> > +
> > +in2_label               "vout1"
> > +in2_input               Measured output voltage
> > +in2_alarm               Output over-voltage alarm
> > +
> > +power1_label            "pin"
> > +power1_input            Measured input power
> > +power1_alarm            Input under-voltage alarm
> > +
> > +power2_label            "pout1"
> > +power2_input            Measured output power
> > +
> > +temp1_input             Measured temperature
> > +temp1_alarm             Temperature alarm
> > +
> > +temp2_input             Measured other loop temperature
> > +temp2_alarm             Temperature alarm
> > +======================= ===========================
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 270b6336b76d..7180823b15bb 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
> >   	  This driver can also be built as a module. If so, the module will
> >   	  be called inspur-ipsps.
> > +config SENSORS_IR35201
> > +	tristate "Infineon IR35201"
> > +	help
> > +	  If you say yes here you get hardware monitoring support for the
> > +	  Infineon IR35201 controller.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called ir35201.
> > +
> >   config SENSORS_IR35221
> >   	tristate "Infineon IR35221"
> >   	help
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index 84ee960a6c2d..40729dd14e7a 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
> >   obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> >   obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
> >   obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> > +obj-$(CONFIG_SENSORS_IR35201)	+= ir35201.o
> >   obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> >   obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
> >   obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> > diff --git a/drivers/hwmon/pmbus/ir35201.c b/drivers/hwmon/pmbus/ir35201.c
> > new file mode 100644
> > index 000000000000..77f77057175a
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/ir35201.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hardware monitoring driver for Infineon IR35201
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include "pmbus.h"
> > +
> > +static struct pmbus_driver_info ir35201_info = {
> > +	.pages = 1,
> > +	.format[PSC_VOLTAGE_IN] = linear,
> > +	.format[PSC_VOLTAGE_OUT] = linear,
> > +	.format[PSC_CURRENT_IN] = linear,
> > +	.format[PSC_CURRENT_OUT] = linear,
> > +	.format[PSC_POWER] = linear,
> > +	.format[PSC_TEMPERATURE] = linear,
> > +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> > +		| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> > +		| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> > +		| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> > +		| PMBUS_HAVE_STATUS_TEMP,
> 
> Several supported status registers are missing.
> 
Maybe. Did the best I could with this and another datasheet (ir36* iirc)
open at the same time and both source files open for comparison, and the
output from sensors with this patch, with allowances for variations
in temps, matches more or less what HWINFO64 outputs on a windows pe
based build of hiren's boot cd.
> > +};
> > +
> > +static int ir35201_probe(struct i2c_client *client)
> > +{
> > +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> > +					 | I2C_FUNC_SMBUS_READ_WORD_DATA
> > +					 | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> > +		return -ENODEV;
> > +
> > +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> > +		return ret;
> > +	}
> > +	if (ret != 2 || strncmp(buf, "IR", strlen("IR"))) {
> > +		dev_err(&client->dev, "MFR_ID unrecognized\n");
> > +		return -ENODEV;
> > +	}
> > +
> 
> Did you actually test this ? Datasheet says it is "ASCII 52 49" which
> would make it "RI" like IR35221, not "IR". Problem though is that it
> seems like the register is writeable via some USER programming,
> making it unreliable.
> 
Yes, I did. And strangely enough, it reads 'backwards' or so, relative
to the 35221. I almost sent this along without removing the debugging
pr_infos I had in this area to check that. drove me bonkers a bit.
> > +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> > +		return ret;
> > +	}
> > +	if (ret != 1 || buf[0] != 0x50) {
> > +		dev_err(&client->dev, "MFR_MODEL unrecognized\n");
> > +		return -ENODEV;
> > +	}
> > +
> 
> The datasheet suggests that PMBUS_MFR_ID and PMBUS_MFR_MODEL can differ based
> on some USER register programming. I would suggest to read IC_DEVICE_ID instead
> and compare against that (which s supposed to be 0x4d).
> 
Somehow I missed that, but it was on my 'to-check' list. I think the
issue may have arose from my datasheet comparison, as the ir36* doesn't
have such a register listed.
> On a higher level, I don't see anything special in this chip. Would it be possible
> to just add it to pmbus.c ? Something like
> 
> 	{"ir35201", (kernel_ulong_t)&pmbus_info_one},
> 
Honestly, I was wondering about folding this and the other very similar
IR3* chips into one driver. Should be doable? But I guess this approach
works as well; in fact, during my investigation phase I stuck the pmbus
driver onto the correct i2c address to get an easy way to read stuff
from the chip (tbh I'm surprised that this far along in linux we don't
have anything other than pmbus_peek to poke for info; maybe i2c-tools
can do it but I can't seem to make it work like I'd expect).
> should do.
> 
> Thanks,
> Guenter
> 
> > +	return pmbus_do_probe(client, &ir35201_info);
> > +}
> > +
> > +static const struct i2c_device_id ir35201_id[] = {
> > +	{ "ir35201", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ir35201_id);
> > +
> > +static const struct of_device_id __maybe_unused ir35201_of_id[] = {
> > +	{ .compatible = "infineon,ir35201" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, ir35201_of_id);
> > +
> > +static struct i2c_driver ir35201_driver = {
> > +	.class = I2C_CLASS_HWMON,
> > +	.driver = {
> > +		.name = "ir35201",
> > +		.of_match_table = of_match_ptr(ir35201_of_id),
> > +	},
> > +	.probe_new = ir35201_probe,
> > +	.id_table = ir35201_id,
> > +};
> > +
> > +module_i2c_driver(ir35201_driver);
> > +
> > +MODULE_AUTHOR("Marty E. Plummer <hanetzer@startmail.com>");
> > +MODULE_DESCRIPTION("PMBus driver for Infineon IR35201");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS(PMBUS);
> 
