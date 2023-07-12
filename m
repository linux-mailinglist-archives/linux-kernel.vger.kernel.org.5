Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8B751032
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGLSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGLSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F719BC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689184964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7akjMyUHwN9vGsmA+DFD3q/5FAYq7rI0eED2DO07wo4=;
        b=GiSeLm4Me1I/IRHWm73nlAYvK4hTftyBKIArjsVC85ZYEk8iSK7zTpPKQgI3FZ/pWa4O98
        ghHRYAHiYp/i+YW9cfhtT/JcKG8cymFq74qJeJlV0zRdnkpLphcSaLrn3eOuY8LW42a67o
        +dPUzCy4ctf/2rccd/n6KlwjVlAUEX4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-OYQi4WrUOFiN3RacZNQBzw-1; Wed, 12 Jul 2023 14:02:42 -0400
X-MC-Unique: OYQi4WrUOFiN3RacZNQBzw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fbcdca8fb6so6072048e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184960; x=1691776960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7akjMyUHwN9vGsmA+DFD3q/5FAYq7rI0eED2DO07wo4=;
        b=l4g1v/0HmEiQB8XrISVo1xUsCzbH2p9pizxNLwtzy3Qw9O3ufWliNaWVEUAR2wKa2r
         M9ZqVCBanpKLqxI+qNvRyhflMzXdqYXOjJ4c8RYILbxD/AG4uLAkcT9RbUZ9cbaYXtyT
         7whRKRozYsmEDlfdm1hPzRy+7YUwgl8yVqlUKKxW6ysRMzNxy03taAggc4J9E4IJPvTh
         sJ3TL089zK9LnrswFJoisTO+mdqpLQLoFqeCLUNEQmPebw1+tTLECpIf70OLJ90m5ygU
         vwM7m7Gm2wmKM79zDlt2/vBp7U2IetF0n+e6DzHbvu3Ny3lOZUb9xDUXy6ueUvE9UsaB
         5n7g==
X-Gm-Message-State: ABy/qLYNPBAPXAgSJZ6aZp49GTKXYHVHTO8sKZsYXe1CguP1dKbnW9ai
        v6tEXh40uXVRUsybPHrfVNahPrxzNh023YuNfGGnOt7IheoxXnJjvZV2w3NqNduBLxJb7X5Fv2E
        qT10t6K9Rw+s5M8LVG9z+qAEe
X-Received: by 2002:a19:381e:0:b0:4f8:70b0:eec6 with SMTP id f30-20020a19381e000000b004f870b0eec6mr13859511lfa.28.1689184959778;
        Wed, 12 Jul 2023 11:02:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESOQQpORhn/acJKc4G/Ed56z0EcpH0+L8yRbErNs1RxGjEtVhDApRE+7doth7M2DdLlSAgUw==
X-Received: by 2002:a19:381e:0:b0:4f8:70b0:eec6 with SMTP id f30-20020a19381e000000b004f870b0eec6mr13859479lfa.28.1689184959145;
        Wed, 12 Jul 2023 11:02:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z26-20020a1709064e1a00b009937dbabbd5sm2836372eju.220.2023.07.12.11.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:02:38 -0700 (PDT)
Message-ID: <024d8246-bcc3-75fb-00be-9b611ae238f6@redhat.com>
Date:   Wed, 12 Jul 2023 20:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] platform/x86: add CMOS battery monitoring for simatic
 IPCs
Content-Language: en-US, nl
To:     Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20230706154831.19100-1-henning.schild@siemens.com>
 <20230706154831.19100-3-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230706154831.19100-3-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/23 17:48, Henning Schild wrote:
> Siemens Simatic Industrial PCs can monitor the voltage of the CMOS
> battery with two bits that indicate low or empty state. This can be GPIO
> or PortIO based.
> Here we model that as a hwmon voltage. The core driver does the PortIO
> and provides boilerplate for the GPIO versions. Which are split out to
> model runtime dependencies while allowing fine-grained kernel
> configuration.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

So I tried to merge this, but it does not apply because:

"[PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A"
https://lore.kernel.org/platform-driver-x86/20230531155457.31632-2-henning.schild@siemens.com/

has not been merged yet.

I think it would be best to split the:

drivers/platform/x86/simatic-ipc.c
include/linux/platform_data/x86/simatic-ipc-base.h
include/linux/platform_data/x86/simatic-ipc.h

bits of https://lore.kernel.org/platform-driver-x86/20230531155457.31632-2-henning.schild@siemens.com/

out into its own prep patch named e.g. :
"platform/x86: simatic-ipc: add BX-21A model"

And then post a new v2 series for
"leds: simatic-ipc-leds-gpio: add new model BX-21A"
consisting of the prep patch + the actual new LED driver.

Then I can do an immutable branch based on 6.5-rc1 with
the prep patch in there and send a pull-req to Lee Jones
for that, so that he can apply the LED driver patch on
top of the immutable branch.

This way we can continue with merging all the pending
simatic IPC work without being dependent on Lee having
time to review the LED driver.

Regards,

Hans







> ---
>  drivers/platform/x86/Kconfig                  |  48 ++++
>  drivers/platform/x86/Makefile                 |   6 +-
>  .../x86/simatic-ipc-batt-apollolake.c         |  51 ++++
>  .../x86/simatic-ipc-batt-elkhartlake.c        |  51 ++++
>  .../platform/x86/simatic-ipc-batt-f7188x.c    |  70 +++++
>  drivers/platform/x86/simatic-ipc-batt.c       | 250 ++++++++++++++++++
>  drivers/platform/x86/simatic-ipc-batt.h       |  20 ++
>  drivers/platform/x86/simatic-ipc.c            |  65 ++++-
>  .../platform_data/x86/simatic-ipc-base.h      |   1 +
>  9 files changed, 547 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/platform/x86/simatic-ipc-batt-apollolake.c
>  create mode 100644 drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
>  create mode 100644 drivers/platform/x86/simatic-ipc-batt-f7188x.c
>  create mode 100644 drivers/platform/x86/simatic-ipc-batt.c
>  create mode 100644 drivers/platform/x86/simatic-ipc-batt.h
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 49c2c4cd8d00..ad15063e1178 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1086,6 +1086,54 @@ config SIEMENS_SIMATIC_IPC
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called simatic-ipc.
>  
> +config SIEMENS_SIMATIC_IPC_BATT
> +	tristate "CMOS battery driver for Siemens Simatic IPCs"
> +	depends on HWMON
> +	depends on SIEMENS_SIMATIC_IPC
> +	default SIEMENS_SIMATIC_IPC
> +	help
> +	  This option enables support for monitoring the voltage of the CMOS
> +	  batteries of several Industrial PCs from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-batt.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO"
> +	depends on PINCTRL_BROXTON
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic Industrial PCs
> +	  from Siemens based on Apollo Lake GPIO.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-batt-apollolake.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO"
> +	depends on PINCTRL_ELKHARTLAKE
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic Industrial PCs
> +	  from Siemens based on Elkhart Lake GPIO.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-batt-elkhartlake.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_F7188X
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO"
> +	depends on GPIO_F7188X
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic Industrial PCs
> +	  from Siemens based on Nuvoton GPIO.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-batt-elkhartlake.
> +
>  config WINMATE_FM07_KEYS
>  	tristate "Winmate FM07/FM07P front-panel keys driver"
>  	depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 52dfdf574ac2..522da0d1584d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -131,7 +131,11 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
>  obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
>  
>  # Siemens Simatic Industrial PCs
> -obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+= simatic-ipc.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)			+= simatic-ipc-batt.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+= simatic-ipc-batt-apollolake.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+= simatic-ipc-batt-elkhartlake.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+= simatic-ipc-batt-f7188x.o
>  
>  # Winmate
>  obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
> diff --git a/drivers/platform/x86/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/simatic-ipc-batt-apollolake.c
> new file mode 100644
> index 000000000000..0503cb89d8f8
> --- /dev/null
> +++ b/drivers/platform/x86/simatic-ipc-batt-apollolake.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "simatic-ipc-batt.h"
> +
> +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_127e = {
> +	.table = {
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 55, NULL, 0, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 61, NULL, 1, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.1", 41, NULL, 2, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
> +	},
> +};
> +
> +static int simatic_ipc_batt_apollolake_remove(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_127e);
> +}
> +
> +static int simatic_ipc_batt_apollolake_probe(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_127e);
> +}
> +
> +static struct platform_driver simatic_ipc_batt_driver = {
> +	.probe = simatic_ipc_batt_apollolake_probe,
> +	.remove = simatic_ipc_batt_apollolake_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_platform_driver(simatic_ipc_batt_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: simatic-ipc-batt platform:apollolake-pinctrl");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
> new file mode 100644
> index 000000000000..ecf5ceb167f9
> --- /dev/null
> +++ b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "simatic-ipc-batt.h"
> +
> +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_21a = {
> +	.table = {
> +		GPIO_LOOKUP_IDX("INTC1020:04", 18, NULL, 0, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 19, NULL, 1, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:01", 66, NULL, 2, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
> +	},
> +};
> +
> +static int simatic_ipc_batt_elkhartlake_remove(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
> +}
> +
> +static int simatic_ipc_batt_elkhartlake_probe(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
> +}
> +
> +static struct platform_driver simatic_ipc_batt_driver = {
> +	.probe = simatic_ipc_batt_elkhartlake_probe,
> +	.remove = simatic_ipc_batt_elkhartlake_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_platform_driver(simatic_ipc_batt_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: simatic-ipc-batt platform:elkhartlake-pinctrl");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/simatic-ipc-batt-f7188x.c
> new file mode 100644
> index 000000000000..a0189b9289f6
> --- /dev/null
> +++ b/drivers/platform/x86/simatic-ipc-batt-f7188x.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
> +
> +#include "simatic-ipc-batt.h"
> +
> +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_227g = {
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 6, NULL, 0, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 5, NULL, 1, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:01",  66, NULL, 2, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
> +	},
> +};
> +
> +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_39a = {
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-f7188x-6", 4, NULL, 0, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-6", 3, NULL, 1, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
> +	},
> +};
> +
> +static int simatic_ipc_batt_f7188x_remove(struct platform_device *pdev)
> +{
> +	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
> +
> +	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
> +		return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_227g);
> +
> +	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
> +}
> +
> +static int simatic_ipc_batt_f7188x_probe(struct platform_device *pdev)
> +{
> +	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
> +
> +	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
> +		return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_227g);
> +
> +	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
> +}
> +
> +static struct platform_driver simatic_ipc_batt_driver = {
> +	.probe = simatic_ipc_batt_f7188x_probe,
> +	.remove = simatic_ipc_batt_f7188x_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_platform_driver(simatic_ipc_batt_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/simatic-ipc-batt.c b/drivers/platform/x86/simatic-ipc-batt.c
> new file mode 100644
> index 000000000000..a83272475b9d
> --- /dev/null
> +++ b/drivers/platform/x86/simatic-ipc-batt.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Authors:
> + *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
> +#include <linux/sizes.h>
> +
> +#define BATT_DELAY_MS	(1000 * 60 * 60 * 24)	/* 24 h delay */
> +
> +#define SIMATIC_IPC_BATT_LEVEL_FULL	3000
> +#define SIMATIC_IPC_BATT_LEVEL_CRIT	2750
> +#define SIMATIC_IPC_BATT_LEVEL_EMPTY	   0
> +
> +static struct simatic_ipc_batt {
> +	u8 devmode;
> +	long current_state;
> +	struct gpio_desc *gpios[3];
> +	unsigned long last_updated_jiffies;
> +} priv;
> +
> +static long simatic_ipc_batt_read_gpio(void)
> +{
> +	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
> +
> +	if (priv.gpios[2]) {
> +		gpiod_set_value(priv.gpios[2], 1);
> +		msleep(150);
> +	}
> +
> +	if (gpiod_get_value_cansleep(priv.gpios[0]))
> +		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
> +	else if (gpiod_get_value_cansleep(priv.gpios[1]))
> +		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
> +
> +	if (priv.gpios[2])
> +		gpiod_set_value(priv.gpios[2], 0);
> +
> +	return r;
> +}
> +
> +#define SIMATIC_IPC_BATT_PORT_BASE	0x404D
> +static struct resource simatic_ipc_batt_io_res =
> +	DEFINE_RES_IO_NAMED(SIMATIC_IPC_BATT_PORT_BASE, SZ_1, KBUILD_MODNAME);
> +
> +static long simatic_ipc_batt_read_io(struct device *dev)
> +{
> +	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
> +	struct resource *res = &simatic_ipc_batt_io_res;
> +	u8 val;
> +
> +	if (!request_muxed_region(res->start, resource_size(res), res->name)) {
> +		dev_err(dev, "Unable to register IO resource at %pR\n", res);
> +		return -EBUSY;
> +	}
> +
> +	val = inb(SIMATIC_IPC_BATT_PORT_BASE);
> +	release_region(simatic_ipc_batt_io_res.start, resource_size(&simatic_ipc_batt_io_res));
> +
> +	if (val & (1 << 7))
> +		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
> +	else if (val & (1 << 6))
> +		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
> +
> +	return r;
> +}
> +
> +static long simatic_ipc_batt_read_value(struct device *dev)
> +{
> +	unsigned long next_update;
> +
> +	next_update = priv.last_updated_jiffies + msecs_to_jiffies(BATT_DELAY_MS);
> +	if (time_after(jiffies, next_update) || !priv.last_updated_jiffies) {
> +		switch (priv.devmode) {
> +		case SIMATIC_IPC_DEVICE_127E:
> +		case SIMATIC_IPC_DEVICE_227G:
> +		case SIMATIC_IPC_DEVICE_BX_39A:
> +			priv.current_state = simatic_ipc_batt_read_gpio();
> +			break;
> +		case SIMATIC_IPC_DEVICE_227E:
> +			priv.current_state = simatic_ipc_batt_read_io(dev);
> +			break;
> +		}
> +		priv.last_updated_jiffies = jiffies;
> +		if (priv.current_state < SIMATIC_IPC_BATT_LEVEL_FULL)
> +			dev_warn(dev, "CMOS battery needs to be replaced.");
> +	}
> +
> +	return priv.current_state;
> +}
> +
> +static int simatic_ipc_batt_read(struct device *dev, enum hwmon_sensor_types type,
> +				 u32 attr, int channel, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_in_input:
> +		*val = simatic_ipc_batt_read_value(dev);
> +		break;
> +	case hwmon_in_lcrit:
> +		*val = SIMATIC_IPC_BATT_LEVEL_CRIT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t simatic_ipc_batt_is_visible(const void *data, enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	if (attr == hwmon_in_input || attr == hwmon_in_lcrit)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops simatic_ipc_batt_ops = {
> +	.is_visible = simatic_ipc_batt_is_visible,
> +	.read = simatic_ipc_batt_read,
> +};
> +
> +static const struct hwmon_channel_info *simatic_ipc_batt_info[] = {
> +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LCRIT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info simatic_ipc_batt_chip_info = {
> +	.ops = &simatic_ipc_batt_ops,
> +	.info = simatic_ipc_batt_info,
> +};
> +
> +int simatic_ipc_batt_remove(struct platform_device *pdev, struct gpiod_lookup_table *table)
> +{
> +	gpiod_remove_lookup_table(table);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(simatic_ipc_batt_remove);
> +
> +int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_table *table)
> +{
> +	struct simatic_ipc_platform *plat;
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	plat = pdev->dev.platform_data;
> +	priv.devmode = plat->devmode;
> +
> +	switch (priv.devmode) {
> +	case SIMATIC_IPC_DEVICE_127E:
> +	case SIMATIC_IPC_DEVICE_227G:
> +	case SIMATIC_IPC_DEVICE_BX_39A:
> +	case SIMATIC_IPC_DEVICE_BX_21A:
> +		table->dev_id = dev_name(dev);
> +		gpiod_add_lookup_table(table);
> +		break;
> +	case SIMATIC_IPC_DEVICE_227E:
> +		goto nogpio;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	priv.gpios[0] = devm_gpiod_get_index(dev, "CMOSBattery empty", 0, GPIOD_IN);
> +	if (IS_ERR(priv.gpios[0])) {
> +		err = PTR_ERR(priv.gpios[0]);
> +		priv.gpios[0] = NULL;
> +		goto out;
> +	}
> +	priv.gpios[1] = devm_gpiod_get_index(dev, "CMOSBattery low", 1, GPIOD_IN);
> +	if (IS_ERR(priv.gpios[1])) {
> +		err = PTR_ERR(priv.gpios[1]);
> +		priv.gpios[1] = NULL;
> +		goto out;
> +	}
> +
> +	if (table->table[2].key) {
> +		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, GPIOD_OUT_HIGH);
> +		if (IS_ERR(priv.gpios[2])) {
> +			err = PTR_ERR(priv.gpios[1]);
> +			priv.gpios[2] = NULL;
> +			goto out;
> +		}
> +	} else {
> +		priv.gpios[2] = NULL;
> +	}
> +
> +nogpio:
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, KBUILD_MODNAME,
> +							 &priv,
> +							 &simatic_ipc_batt_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		goto out;
> +	}
> +
> +	/* warn about aging battery even if userspace never reads hwmon */
> +	simatic_ipc_batt_read_value(dev);
> +
> +	return 0;
> +out:
> +	simatic_ipc_batt_remove(pdev, table);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(simatic_ipc_batt_probe);
> +
> +static int simatic_ipc_batt_io_remove(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_remove(pdev, NULL);
> +}
> +
> +static int simatic_ipc_batt_io_probe(struct platform_device *pdev)
> +{
> +	return simatic_ipc_batt_probe(pdev, NULL);
> +}
> +
> +static struct platform_driver simatic_ipc_batt_driver = {
> +	.probe = simatic_ipc_batt_io_probe,
> +	.remove = simatic_ipc_batt_io_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_platform_driver(simatic_ipc_batt_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/simatic-ipc-batt.h b/drivers/platform/x86/simatic-ipc-batt.h
> new file mode 100644
> index 000000000000..4545cd3e3026
> --- /dev/null
> +++ b/drivers/platform/x86/simatic-ipc-batt.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Author:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#ifndef _SIMATIC_IPC_BATT_H
> +#define _SIMATIC_IPC_BATT_H
> +
> +int simatic_ipc_batt_probe(struct platform_device *pdev,
> +			   struct gpiod_lookup_table *table);
> +
> +int simatic_ipc_batt_remove(struct platform_device *pdev,
> +			    struct gpiod_lookup_table *table);
> +
> +#endif /* _SIMATIC_IPC_BATT_H */
> diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
> index 4402cd354104..6d2c94c17414 100644
> --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -21,6 +21,7 @@
>  
>  static struct platform_device *ipc_led_platform_device;
>  static struct platform_device *ipc_wdt_platform_device;
> +static struct platform_device *ipc_batt_platform_device;
>  
>  static const struct dmi_system_id simatic_ipc_whitelist[] = {
>  	{
> @@ -37,38 +38,71 @@ static struct {
>  	u32 station_id;
>  	u8 led_mode;
>  	u8 wdt_mode;
> +	u8 batt_mode;
>  } device_modes[] = {
> -	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
> -	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
> -	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
> -	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
> -	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
> -	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
> -	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
> -	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
> -	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
> -	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G},
> -	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE},
> +	{SIMATIC_IPC_IPC127E,
> +		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_127E},
> +	{SIMATIC_IPC_IPC227D,
> +		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
> +	{SIMATIC_IPC_IPC227E,
> +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
> +	{SIMATIC_IPC_IPC227G,
> +		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
> +	{SIMATIC_IPC_IPC277E,
> +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
> +	{SIMATIC_IPC_IPC427D,
> +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
> +	{SIMATIC_IPC_IPC427E,
> +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
> +	{SIMATIC_IPC_IPC477E,
> +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
> +	{SIMATIC_IPC_IPCBX_39A,
> +		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
> +	{SIMATIC_IPC_IPCPX_39A,
> +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
> +	{SIMATIC_IPC_IPCBX_21A,
> +		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A},
>  };
>  
>  static int register_platform_devices(u32 station_id)
>  {
>  	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
>  	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
> -	char *pdevname = KBUILD_MODNAME "_leds";
> +	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
> +	char *pdevname;
>  	int i;
>  
> -	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
> -
>  	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
>  		if (device_modes[i].station_id == station_id) {
>  			ledmode = device_modes[i].led_mode;
>  			wdtmode = device_modes[i].wdt_mode;
> +			battmode = device_modes[i].batt_mode;
>  			break;
>  		}
>  	}
>  
> +	if (battmode != SIMATIC_IPC_DEVICE_NONE) {
> +		pdevname = KBUILD_MODNAME "_batt";
> +		if (battmode == SIMATIC_IPC_DEVICE_127E)
> +			pdevname = KBUILD_MODNAME "_batt_apollolake";
> +		if (battmode == SIMATIC_IPC_DEVICE_BX_21A)
> +			pdevname = KBUILD_MODNAME "_batt_elkhartlake";
> +		if (battmode == SIMATIC_IPC_DEVICE_227G || battmode == SIMATIC_IPC_DEVICE_BX_39A)
> +			pdevname = KBUILD_MODNAME "_batt_f7188x";
> +		platform_data.devmode = battmode;
> +		ipc_batt_platform_device =
> +			platform_device_register_data(NULL, pdevname,
> +				PLATFORM_DEVID_NONE, &platform_data,
> +				sizeof(struct simatic_ipc_platform));
> +		if (IS_ERR(ipc_batt_platform_device))
> +			return PTR_ERR(ipc_batt_platform_device);
> +
> +		pr_debug("device=%s created\n",
> +			 ipc_batt_platform_device->name);
> +	}
> +
>  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> +		pdevname = KBUILD_MODNAME "_leds";
>  		if (ledmode == SIMATIC_IPC_DEVICE_127E)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
>  		if (ledmode == SIMATIC_IPC_DEVICE_227G)
> @@ -144,6 +178,9 @@ static void __exit simatic_ipc_exit_module(void)
>  
>  	platform_device_unregister(ipc_wdt_platform_device);
>  	ipc_wdt_platform_device = NULL;
> +
> +	platform_device_unregister(ipc_batt_platform_device);
> +	ipc_batt_platform_device = NULL;
>  }
>  
>  module_init(simatic_ipc_init_module);
> diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
> index 00bf18ecb160..1ba47dd6939e 100644
> --- a/include/linux/platform_data/x86/simatic-ipc-base.h
> +++ b/include/linux/platform_data/x86/simatic-ipc-base.h
> @@ -21,6 +21,7 @@
>  #define SIMATIC_IPC_DEVICE_227E 4
>  #define SIMATIC_IPC_DEVICE_227G 5
>  #define SIMATIC_IPC_DEVICE_BX_21A 6
> +#define SIMATIC_IPC_DEVICE_BX_39A 7
>  
>  struct simatic_ipc_platform {
>  	u8	devmode;

