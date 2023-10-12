Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF57C6E15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378752AbjJLM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347226AbjJLM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E84C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697113603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGTO2JDI9gVTrGaf/N1hlLG7PWVlfP1HHnwNnRJbxxw=;
        b=iinTGKQPrdQBrFM5xHiOCDc5wiOoL8Xz730hs4U0xUCWJoH/z0ttxdQODKkuCyU+RW7IKq
        bkAtEff3S7Ef1DqUVl3glLlWVCp27Q8OWWY5NldoqFRw0tJ7z5RmcWfzPhwoI3BODkaZ4H
        pj2STxum1LNiSRb7o9L+RBrLxIOsJNk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-0BTU_zgKNQWp8-4J1edLwA-1; Thu, 12 Oct 2023 08:26:42 -0400
X-MC-Unique: 0BTU_zgKNQWp8-4J1edLwA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ba247e03aeso63130466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697113600; x=1697718400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGTO2JDI9gVTrGaf/N1hlLG7PWVlfP1HHnwNnRJbxxw=;
        b=Wcqput4z96FOumIJIcxntpJ8d++7xPJbKDpSPFzg6AqIJZNKKmwgyrh2ZsWc/7sNjc
         cUIimmcb8Sddo8EoUl6YwgGjlr86pUovuCC5w55Y5WnBWWpARzv1VBHGF5LSooQMcirg
         OzTAwsHHDlEtJoVpDm/LzEaJR40BO1cg34U3XIT2w6EpU41PDXL9WGZXQvQfMYs9as3h
         raR1sI+WR1yCaY2+bpDBvVZMQx//ml7MAjcjdaGqeBxpQk59w6cDg0kHB7qZSy19tNKJ
         iMI1dg/yyqLJsVAZxK7M56C/xtSGTQyVUN79p7L/zijtUTday/URxfQ4hxIQ9E7cvX5X
         MBxg==
X-Gm-Message-State: AOJu0YzRdp6sjXtwqikdXsEoS3XU2l6DOQzzp/3TbrE3ki0igfQJmW+e
        MZf9iU8Jr0b5v90OxxXn30ME8x69hNlNQ//C5cjXs29t1CmjxexVr29QRfkvrrmXDYEnVNi5x8I
        P84T35UlspIdY3L5RoFgaIR5ECME5/Gf3
X-Received: by 2002:a17:906:32c8:b0:9ae:6ffd:be0d with SMTP id k8-20020a17090632c800b009ae6ffdbe0dmr21285517ejk.50.1697113600276;
        Thu, 12 Oct 2023 05:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV1J2J2+RNUmQ79ixoxfY+cJAKLcLCuY28Q9Y2eQn9hidaLEdIp/ikLhZy5wmmfjGOgXsGMQ==
X-Received: by 2002:a17:906:32c8:b0:9ae:6ffd:be0d with SMTP id k8-20020a17090632c800b009ae6ffdbe0dmr21285506ejk.50.1697113599978;
        Thu, 12 Oct 2023 05:26:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lu20-20020a170906fad400b0099297782aa9sm10911493ejb.49.2023.10.12.05.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 05:26:39 -0700 (PDT)
Message-ID: <ed41a536-1659-d835-93ef-d58e059b6789@redhat.com>
Date:   Thu, 12 Oct 2023 14:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: support to store/show powermode for Inspur
Content-Language: en-US, nl
To:     Ai Chao <aichao@kylinos.cn>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231008092149.967239-1-aichao@kylinos.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231008092149.967239-1-aichao@kylinos.cn>
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

Hi Ai,

On 10/8/23 11:21, Ai Chao wrote:
> Support to store/show powermode for Inspur.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Thank you for your patch.

Comments inline.

> ---
>  drivers/platform/x86/Kconfig      |  11 ++
>  drivers/platform/x86/Makefile     |   3 +
>  drivers/platform/x86/inspur-wmi.c | 180 ++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+)
>  create mode 100644 drivers/platform/x86/inspur-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..9e565ee01a9f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
>  	  the OS-image for the device. This option supplies the missing info.
>  	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>  
> +config INSPUR_WMI
> +	tristate "Inspur WMI hotkeys driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	This driver provides support for Inspur WMI hotkeys.
> +	It's support to store/show powermode.

The use of the work "hotkeys" here seems wrong since this
only supports the powermode WMI interface.


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
> index 000000000000..6c4d722e98dc
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Inspur WMI hotkeys
> + *
> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_INSPUR_POWERMODE_EVENT_GUID "854FA5AC-58C7-451D-AAB1-57D6F4E6DDD4"
> +#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493284F5D"
> +
> +enum inspur_wmi_method_ids {
> +	INSPUR_WMI_GET_POWERMODE = 0x02,
> +	INSPUR_WMI_SET_POWERMODE = 0x03,
> +};
> +
> +struct inspur_wmi_priv {
> +	struct input_dev *idev;
> +};
> +
> +static int inspur_wmi_perform_query(char *guid,
> +		enum inspur_wmi_method_ids query_id,
> +		void *buffer, size_t insize, size_t outsize)
> +{
> +	union acpi_object *obj;
> +	int ret = 0;
> +	u32 wmi_outsize;
> +	struct acpi_buffer input = { insize, buffer};
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	wmi_evaluate_method(guid, 0, query_id, &input, &output);
> +
> +	obj = output.pointer;
> +	if (!obj)
> +		return -EINVAL;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	/* Ignore output data of zero size */
> +	if (!outsize)
> +		goto out_free;
> +
> +	wmi_outsize = min_t(size_t, outsize, obj->buffer.length);
> +	memcpy(buffer, obj->buffer.pointer, wmi_outsize);
> +
> +out_free:
> +	kfree(obj);
> +	return ret;
> +}
> +
> +static ssize_t powermode_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	int ret, mode;
> +
> +	ret = kstrtoint(buf, 0, &mode);
> +	if (ret)
> +		return ret;

So this allows sending any value of
-2^31 to +2^31 to the WMI interface
I have a hard time believing that that entire
range is valid ?

Do you know which values are valid and do you know
what the meaning of the valid values are ?

Typically these values have meanings like:

low-power / balanced / high-performance

and assuming that is the case then this really
should be using the drivers/acpi/platform_profile.c
userspace API instead of registering a custom
sysfs attribute for this.

Regards,

Hans




> +
> +	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
> +			INSPUR_WMI_SET_POWERMODE,
> +			&mode, sizeof(mode), sizeof(mode));
> +
> +	return count;
> +}
> +
> +
> +static ssize_t powermode_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int mode = 0;
> +	u8 ret;
> +	u8 *ret_code;
> +
> +	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
> +			INSPUR_WMI_GET_POWERMODE,
> +			&mode, sizeof(mode), sizeof(mode));
> +	/*
> +	 *Byte [0]: Return code, 0x0 No error, 0x01 Error
> +	 *Byte [1]: Power Mode
> +	 */
> +	ret_code = (u8 *)(&mode);
> +	ret = ret_code[1];
> +
> +	return sprintf(buf, "%u\n", ret);
> +}
> +
> +DEVICE_ATTR_RW(powermode);
> +
> +static struct attribute *inspur_wmi_attrs[] = {
> +	&dev_attr_powermode.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group inspur_wmi_group = {
> +	.attrs = inspur_wmi_attrs,
> +};
> +
> +const struct attribute_group *inspur_wmi_groups[] = {
> +	&inspur_wmi_group,
> +	NULL,
> +};
> +
> +static void inspur_wmi_notify(struct wmi_device *wdev,
> +		union acpi_object *obj)
> +{
> +	//to do
> +}
> +
> +static int inspur_wmi_input_setup(struct wmi_device *wdev)
> +{
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	priv->idev = devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name = "Inspur WMI hotkeys";
> +	priv->idev->phys = "wmi/input0";
> +	priv->idev->id.bustype = BUS_HOST;
> +	priv->idev->dev.parent = &wdev->dev;
> +
> +	return input_register_device(priv->idev);
> +}
> +
> +static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct inspur_wmi_priv *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(struct inspur_wmi_priv),
> +			GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	err = inspur_wmi_input_setup(wdev);
> +	return err;
> +}
> +
> +static void inspur_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	input_unregister_device(priv->idev);
> +}
> +
> +static const struct wmi_device_id inspur_wmi_id_table[] = {
> +	{ .guid_string = WMI_INSPUR_POWERMODE_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver inspur_wmi_driver = {
> +	.driver = {
> +		.name = "inspur-wmi",
> +		.dev_groups = inspur_wmi_groups,
> +	},
> +	.id_table = inspur_wmi_id_table,
> +	.probe = inspur_wmi_probe,
> +	.notify = inspur_wmi_notify,
> +	.remove = inspur_wmi_remove,
> +};
> +
> +module_wmi_driver(inspur_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Inspur WMI hotkeys");
> +MODULE_LICENSE("GPL");

