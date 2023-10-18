Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72DC7CDDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjJRNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjJRNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46395
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697636897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R65gydlQdF9R/+VKsJDWYOd70u4Cmi42FtRr8YS8Qew=;
        b=Rv9pQ6528CI6tlR52lFn2HWEaU0BEWlu66NnY/c8FqOtA3YAqEUYFGrL/AUV7YqGwfMrEz
        ibqb1sQ3YNZPAaScvkSEMLbHchzvHNxxnyLv1qRRyEoHGXLimOGXsBSrxSCOpY85eGzHJk
        gMZgNnnj3RiyJI3GS3+3RxiK02ZOfPc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-s_9aMp5SMBGDac4-J99Hmw-1; Wed, 18 Oct 2023 09:48:06 -0400
X-MC-Unique: s_9aMp5SMBGDac4-J99Hmw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b97f1b493dso506517466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697636885; x=1698241685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R65gydlQdF9R/+VKsJDWYOd70u4Cmi42FtRr8YS8Qew=;
        b=Gz5ij0CeS81ntrcrTkvaiUBbYyfzefDKaC5fnVgE4xabeUDsTQwEuWi1+sCqc+RqA8
         o5dKi+EZrsEZuNJ+TWFdnuZdTT3Gamfa9+jdjX2Z+CwiyJuIRq6GtXFwH4KGL/bA3bXL
         mOt6Nae0YFsvQM9sp9HPV9GMxztsYBFKXTAfjvkAfk1w13R0BYg2V2fJrsQ1O2CmxhgO
         kzodXrA6vay/3bqJimwgtHtbQVj4FrQE536qMz8A8BJtJgfldUyXMej4Hhz8uUqBTRPs
         tJDCQtTEn+xZWtXQ5O5WMsBxxZVkg9OhvWO0nfVeidZKX2iTHfcAcXn5Dme0TjWsC9ZM
         Lmgw==
X-Gm-Message-State: AOJu0Yy2Mg8v5DsSimOJjYwH2n1Sav3KItjj12RrYTuUNYyTrQWRdaNJ
        0qSstjAyFz+ukz9Oie/Hh0hJzUteMV9UzZHlmkulGA2nOj4SH+L+CAbIyQ5VIyziafCsl59aDlw
        G/HQvEDRU+QuHCJfSOANBPTMb
X-Received: by 2002:a17:907:3608:b0:9be:e79e:c75f with SMTP id bk8-20020a170907360800b009bee79ec75fmr3694412ejc.18.1697636885192;
        Wed, 18 Oct 2023 06:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTPPMwLyJEf//v7l+6jx7oWBiUpH3ekamgpAmj1+2hujNXnugywcG0/m0q5djQe/x0LUuQ7A==
X-Received: by 2002:a17:907:3608:b0:9be:e79e:c75f with SMTP id bk8-20020a170907360800b009bee79ec75fmr3694378ejc.18.1697636884750;
        Wed, 18 Oct 2023 06:48:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906068900b009875a6d28b0sm1719200ejb.51.2023.10.18.06.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:48:04 -0700 (PDT)
Message-ID: <a5756243-3adc-b5c0-56c3-a053643775c5@redhat.com>
Date:   Wed, 18 Oct 2023 15:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] platform/x86: inspur-wmi: Add platform profile support
Content-Language: en-US, nl
To:     Ai Chao <aichao@kylinos.cn>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231018080014.536047-1-aichao@kylinos.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231018080014.536047-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/23 10:00, Ai Chao wrote:
> Add support for Inspur platforms to used the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
> 
> change for v3
> - Remove input device
> - Using the platform profile interface

Thanks this is much better.

Only remaining question I have is can the platform_profile
setting be changed by a hotkey (directly by the hotkey,
so upon pressing the hotkey the EC changes the platform_profile
itself).

If the answer to this is yes, is there then any event which
the driver could listen to and then use to notify userspace
about the change by calling platform_profile_notify() upon
receiving the event ?

Or maybe the event will be received by the discussed
hotkeys driver, so that can call platform_profile_notify()
instead. Note platform_profile_notify() does not require a
platform_profile_handler pointer, so it could indeed be
called from a separate driver if the events are received
elsewhere.

Regards,

Hans




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
> +MODULE_LICENSE("GPL");

