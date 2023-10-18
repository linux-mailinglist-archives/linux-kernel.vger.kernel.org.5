Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67457CDD74
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjJRNi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjJRNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:38:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A383;
        Wed, 18 Oct 2023 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1697636297; bh=SQXJHzlVCZ+kYWZT9Te9C7HnjRuEi2KGjc05EKQtFt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4w4+U2/E5DnywuoQH/FgnG6hZ5cKSMxuJT1k/SbkEmUJeifryHWCPIiGBR+sg4Q2
         AKpCw5gLzxb6jq0tay911J5qS8Gnq3KEuaxwJJQLwuvo+/G6c4AmrPQqmSBi2WmjMk
         eVuyaXQWVlZJVUbw9FXqpGCBXfuhEjLXvJuEtWng=
Date:   Wed, 18 Oct 2023 15:38:17 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Ai Chao <aichao@kylinos.cn>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: inspur-wmi: Add platform profile support
Message-ID: <1d2e147d-8d93-4467-ac7c-199bfd887348@t-8ch.de>
References: <20231018080014.536047-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018080014.536047-1-aichao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18 16:00:14+0800, Ai Chao wrote:
> Add support for Inspur platforms to used the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
> 
> change for v3
> - Remove input device
> - Using the platform profile interface
> 
> change for v2
> - Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> - Add more explanation.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/platform/x86/Kconfig      |  10 ++
>  drivers/platform/x86/Makefile     |   3 +
>  drivers/platform/x86/inspur-wmi.c | 215 ++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/platform/x86/inspur-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..d7bd27c53751 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,16 @@ config TOUCHSCREEN_DMI
>  	  the OS-image for the device. This option supplies the missing info.
>  	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>  
> +config INSPUR_WMI
> +	tristate "Inspur WMI platform profile driver"
> +	depends on ACPI_WMI
> +	help
> +	This will allow users to determine and control the platform modes
> +	between low-power, balanced and performance modes.
> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called inspur-wmi.
> +
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>  
>  config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index b457de5abf7d..9285c252757e 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
>  # before toshiba_acpi initializes
>  obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
>  
> +# Inspur
> +obj-$(CONFIG_INSPUR_WMI)	+= inspur-wmi.o
> +
>  # Laptop drivers
>  obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
>  obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
> diff --git a/drivers/platform/x86/inspur-wmi.c b/drivers/platform/x86/inspur-wmi.c
> new file mode 100644
> index 000000000000..d0c5ae2e3fcb
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Inspur WMI power mode
> + *
> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_profile.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493284F5D"
> +
> +enum inspur_wmi_method_ids {
> +	INSPUR_WMI_GET_POWERMODE = 0x02,
> +	INSPUR_WMI_SET_POWERMODE = 0x03,
> +};
> +
> +/**
> + * Power Mode:
> + *           0x0: Balance Mode
> + *           0x1: Performance Mode
> + *           0x2: Power Saver Mode
> + */
> +enum inspur_tmp_profile {
> +	INSPUR_TMP_PROFILE_BALANCE	= 0,
> +	INSPUR_TMP_PROFILE_PERFORMANCE	= 1,
> +	INSPUR_TMP_PROFILE_POWERSAVE	= 2,
> +};
> +
> +struct inspur_wmi_priv {
> +	struct wmi_device *wdev;
> +	struct platform_profile_handler handler;
> +};
> +
> +static int inspur_wmi_perform_query(struct wmi_device *wdev,
> +				    enum inspur_wmi_method_ids query_id,
> +				    void *buffer, size_t insize,
> +				    size_t outsize)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer input = { insize, buffer};
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	status = wmidev_evaluate_method(wdev, 0, query_id, &input, &output);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&wdev->dev, "EC Powermode control failed: %s\n",
> +			acpi_format_exception(status));
> +		return -EIO;
> +	}
> +
> +	obj = output.pointer;
> +	if (!obj)
> +		return -EINVAL;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER ||
> +	    obj->buffer.length != outsize) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	memcpy(buffer, obj->buffer.pointer, obj->buffer.length);
> +
> +out_free:
> +	kfree(obj);
> +	return ret;
> +}
> +
> +/**
> + * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x3
> + * Arg: 4 Bytes
> + * Byte [0]: Power Mode:
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + */
> +static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> +				       enum platform_profile_option profile)
> +{
> +	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> +						    handler);
> +	u8 ret_code[4] = {0, 0, 0, 0};
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		ret_code[0] = INSPUR_TMP_PROFILE_BALANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret_code[0] = INSPUR_TMP_PROFILE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		ret_code[0] = INSPUR_TMP_PROFILE_POWERSAVE;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_SET_POWERMODE,
> +				       ret_code, sizeof(ret_code),
> +				       sizeof(ret_code));
> +
> +	if (ret < 0)
> +		return ret;
> +	else if (ret_code[0])
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +/**
> + * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x2
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + * Byte [1]: Power Mode
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + */
> +static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> +				       enum platform_profile_option *profile)
> +{
> +	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> +						    handler);
> +	u8 ret_code[4] = {0, 0, 0, 0};
> +	int ret;
> +
> +	ret = inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_GET_POWERMODE,
> +				       &ret_code, sizeof(ret_code),
> +				       sizeof(ret_code));
> +	if (ret < 0)
> +		return ret;
> +	else if (ret_code[0])
> +		return -EBADRQC;
> +
> +	switch (ret_code[1]) {
> +	case INSPUR_TMP_PROFILE_BALANCE:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case INSPUR_TMP_PROFILE_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case INSPUR_TMP_PROFILE_POWERSAVE:
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct inspur_wmi_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdev = wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	priv->handler.profile_get = inspur_platform_profile_get;
> +	priv->handler.profile_set = inspur_platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> +
> +	platform_profile_register(&priv->handler);
> +	return 0;
> +}
> +
> +static void inspur_wmi_remove(struct wmi_device *wdev)
> +{
> +	platform_profile_remove();
> +}
> +
> +static const struct wmi_device_id inspur_wmi_id_table[] = {
> +	{ .guid_string = WMI_INSPUR_POWERMODE_BIOS_GUID },
> +	{  }
> +};
> +
> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
> +
> +static struct wmi_driver inspur_wmi_driver = {
> +	.driver = {
> +		.name = "inspur-wmi",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

Seems unnecessary.
The docs say this should be used for "slow" devices.
But the probe function here doesn't really do anything.

> +	},
> +	.id_table = inspur_wmi_id_table,
> +	.probe = inspur_wmi_probe,
> +	.remove = inspur_wmi_remove,
> +};
> +
> +module_wmi_driver(inspur_wmi_driver);
> +
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Inspur WMI hotkeys");

There is no more hotkey functionality left.
Kconfig says "Inspur WMI platform profile driver",
should also be used here.

If you are also going to submit the hotkey driver it may make sense to
call this one inspur-wmi-platform-profile, or something similar unique.

> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
