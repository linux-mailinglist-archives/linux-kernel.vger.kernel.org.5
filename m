Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042327AEA13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjIZKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjIZKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8597
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695723083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HDo01TkaoeQ/nKb+m9TpBeIQ9htrGbC6iNDoVvDu3A=;
        b=UWzXU//EBQqhot/82b+OISJneUSj4pssI2+ZL6UjHcsVAFEyICaM7yXTLNGlnjoRj3TnIZ
        mjIOJmy606PT2ObYfC0kh0lVfAr6rwpNceu8llikxb7nJIRy1+5DKSoNGsEIJT9n2d4rbJ
        wgXkFrdOHk9qLxuVTMpIyTAIVgzcm+o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-9cUQAiOdOVyZ3P9VB4KoVg-1; Tue, 26 Sep 2023 06:11:21 -0400
X-MC-Unique: 9cUQAiOdOVyZ3P9VB4KoVg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b282c72954so325446666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723080; x=1696327880;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HDo01TkaoeQ/nKb+m9TpBeIQ9htrGbC6iNDoVvDu3A=;
        b=JYtrLZxVJUyNbFE8UhtLBxu+kYaAYpdZj9yimzMSi2YYZ12uAvSo2qqSwAJ02WADkG
         G+mQHICoRR9cbaVJrr2ZLbxeXOtE5fYDggbU/1B8PH3nX+kflZ6ZboW5B+N3JTwTPy6L
         xV+wlDoJcEshWuczMr4Bw9+2dhAvyqtCWHERsu5fQh7+1K+yAmyStsUl+1M9W5uLYZAl
         3lzhaFLUWc0paz5wBbPyVl3NoNi7AaOSAaqt/ipDuyUy+EfUmxjObETVPUZbyKbZcenD
         FbZt/S0aLLrhUApMuroBz7i93wo0jKlpVnHLMTosW9J4U+83O/vj8+gpo3X4X9RUh3S+
         9omw==
X-Gm-Message-State: AOJu0Yz5q/96p1aXj+9p/AVbVCjTOvGZJAIDP7VAu+SzXN5iMt2GahKD
        WxCqN+qxGrp0rgKZtBHyRl1w6AhtrhyzhVYq3sIbhEkF9AqxvZFjncot0w/FxUYlXHc6cDcg0W4
        ycC8IsJnHk9tttFCJ+eqH1BCj
X-Received: by 2002:a17:907:2709:b0:9a1:f21e:cdff with SMTP id w9-20020a170907270900b009a1f21ecdffmr8325785ejk.23.1695723080521;
        Tue, 26 Sep 2023 03:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEbMgfypCifz4bZIXRkDJ/urgBdwhoZJZfcgXhgqJFOSEABIqgQsOcDN2+Bcmij0Vs1hAqug==
X-Received: by 2002:a17:907:2709:b0:9a1:f21e:cdff with SMTP id w9-20020a170907270900b009a1f21ecdffmr8325775ejk.23.1695723080178;
        Tue, 26 Sep 2023 03:11:20 -0700 (PDT)
Received: from [192.168.1.217] ([109.37.154.108])
        by smtp.gmail.com with ESMTPSA id kt22-20020a170906aad600b0099cf9bf4c98sm7520711ejb.8.2023.09.26.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:11:19 -0700 (PDT)
Message-ID: <5755a77f-dc99-e297-b926-5651977b6525@redhat.com>
Date:   Tue, 26 Sep 2023 12:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Language: en-US
To:     Fernando Eckhardt Valle <fevalle@ipt.br>,
        mpearson-lenovo@squebb.ca, corbet@lwn.net, hmh@hmh.eng.br,
        markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <20230921143622.72387-1-fevalle@ipt.br>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230921143622.72387-1-fevalle@ipt.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/23 16:36, Fernando Eckhardt Valle wrote:
> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
> Changes in v4:
> - strscpy() in all string copies.
> Changes in v3:
> - Added null terminator to auxmac string when copying auxiliary
> mac address value.
> Changes in v2:
> - Added documentation.
> - All handling of the auxmac value is done in the _init function.
> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 79 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> index e27a1c3f6..98d304010 100644
> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> @@ -53,6 +53,7 @@ detailed description):
>  	- Lap mode sensor
>  	- Setting keyboard language
>  	- WWAN Antenna type
> +	- Auxmac
>  
>  A compatibility table by model and feature is maintained on the web
>  site, http://ibm-acpi.sf.net/. I appreciate any success or failure
> @@ -1511,6 +1512,25 @@ Currently 2 antenna types are supported as mentioned below:
>  The property is read-only. If the platform doesn't have support the sysfs
>  class is not created.
>  
> +Auxmac
> +------
> +
> +sysfs: auxmac
> +
> +Some newer Thinkpads have a feature called MAC Address Pass-through. This
> +feature is implemented by the system firmware to provide a system unique MAC,
> +that can override a dock or USB ethernet dongle MAC, when connected to a
> +network. This property enables user-space to easily determine the MAC address
> +if the feature is enabled.
> +
> +The values of this auxiliary MAC are:
> +
> +        cat /sys/devices/platform/thinkpad_acpi/auxmac
> +
> +If the feature is disabled, the value will be 'disabled'.
> +
> +This property is read-only.
> +
>  Adaptive keyboard
>  -----------------
>  
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d70c89d32..f430cc9ed 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,80 @@ static struct ibm_struct dprc_driver_data = {
>  	.name = "dprc",
>  };
>  
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * MAC Address Pass-through feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +#define AUXMAC_BEGIN_MARKER 8
> +#define AUXMAC_END_MARKER 21
> +
> +static char auxmac[AUXMAC_LEN + 1];
> +
> +static int auxmac_init(struct ibm_init_struct *iibm)
> +{
> +	acpi_status status;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +
> +	status = acpi_evaluate_object(NULL, "\\MACA", NULL, &buffer);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	obj = buffer.pointer;
> +
> +	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
> +		pr_info("Invalid buffer for MAC address pass-through.\n");
> +		strscpy(auxmac, "unavailable", AUXMAC_LEN);

Please use sizeof(auxmac) as last parameter to strscpy() here.

> +		goto auxmacinvalid;
> +	}
> +
> +	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
> +	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
> +		pr_info("Invalid header for MAC address pass-through.\n");
> +		strscpy(auxmac, "unavailable", AUXMAC_LEN);

Please use sizeof(auxmac) as last parameter to strscpy() here.


> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0)
> +		strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN + 1);

Please use sizeof(auxmac) as last parameter to strscpy() here.

> +	else
> +		strscpy(auxmac, "disabled", AUXMAC_START);

Please use sizeof(auxmac) as last parameter to strscpy() here.

(using AUXMAC_START here really makes no sense at all)

Regards,

Hans



> +
> +auxmacinvalid:
> +	kfree(obj);
> +	return 0;
> +}
> +
> +static struct ibm_struct auxmac_data = {
> +	.name = "auxmac",
> +};
> +
> +static ssize_t auxmac_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", auxmac);
> +}
> +static DEVICE_ATTR_RO(auxmac);
> +
> +static struct attribute *auxmac_attributes[] = {
> +	&dev_attr_auxmac.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group auxmac_attr_group = {
> +	.attrs = auxmac_attributes,
> +};
> +
>  /* --------------------------------------------------------------------- */
>  
>  static struct attribute *tpacpi_driver_attributes[] = {
> @@ -10843,6 +10917,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11489,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
>  		.init = tpacpi_dprc_init,
>  		.data = &dprc_driver_data,
>  	},
> +	{
> +		.init = auxmac_init,
> +		.data = &auxmac_data,
> +	},
>  };
>  
>  static int __init set_ibm_param(const char *val, const struct kernel_param *kp)

