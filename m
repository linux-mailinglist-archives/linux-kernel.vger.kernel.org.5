Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0857AEA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjIZKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIZKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E45DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695723801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Ek1UrdMEHLq9FGXHe8r4i40LEX2oqVQ5arQmDYvfZY=;
        b=W3OGferR+jVu6s8c6L8R9OndZr5p98RQRRIBj8VvuJfWyGrtMAC+aaAVOjrFcQZiH1gvNi
        NSPpDTI0fzxQLtASRfh9I1sTQ/hOPt0Qx+g8qa3aQAdBuEhJ+PWJY3ZKdD/203E3TqyqbL
        HaiRXUNmo+tZioMIbHCMbz6hCwkMkak=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-JU90hqiyO9y9ftsapjZCkQ-1; Tue, 26 Sep 2023 06:23:19 -0400
X-MC-Unique: JU90hqiyO9y9ftsapjZCkQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b274cc9636so405349466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723798; x=1696328598;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ek1UrdMEHLq9FGXHe8r4i40LEX2oqVQ5arQmDYvfZY=;
        b=PQKqaPmky+J/sUpGUduG3iLCRa+S+QeElethY1BINRP4MTxu+JYyh+SXvQ0wNYX2Fz
         tjiz9B4mU/B1mjkuMqX6mQEM1X8Ax4c/0kH9xmGfpDXzr/HmBM7gBx31icDbGzdomOSe
         C9/TnZvZRdmtO/sfWZaKNlnCOHY0P/+CaNh50TvXkqjtSP51nqwfoloTU7DxO8/ldb97
         n4X046KUzhgfiPrmino1IKy4ggcopys00cHonpu+wOdv+YtJNBVBDev6IRHi6ch4Kdlp
         6XUjtzNu9l1MVYt8aeSLT3mruyabMStXlgGtV2BxAKGfzJv1xTVbgJndvfYO4cqOFW3e
         wp/g==
X-Gm-Message-State: AOJu0Yw1jvjGZdxGBaMGwO2Glg8T0lZlSZqtKHp/l1EEUNfpX76flmkJ
        n7YcH9jexTRyki8APXZQwd3Qho9vax76PcLNIdxM5GgxRjLTnXgxMi+XmbtDvTNzvOTCHsv0lnt
        BBPZ3zqIMa5h1Jwyfbx/HhH2F
X-Received: by 2002:a17:906:cc5c:b0:9aa:e08:9fb7 with SMTP id mm28-20020a170906cc5c00b009aa0e089fb7mr7681070ejb.76.1695723798589;
        Tue, 26 Sep 2023 03:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEACRNW5o33/C8Rkd8qlQfKI/z+daxeWJvvC/dnzrR9NDEqxWdDVb07c1V5wvprP9U+ywKq5w==
X-Received: by 2002:a17:906:cc5c:b0:9aa:e08:9fb7 with SMTP id mm28-20020a170906cc5c00b009aa0e089fb7mr7681055ejb.76.1695723798244;
        Tue, 26 Sep 2023 03:23:18 -0700 (PDT)
Received: from [192.168.1.217] ([109.37.154.108])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090778cb00b009ad8ba6976bsm3643715ejc.9.2023.09.26.03.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:23:17 -0700 (PDT)
Message-ID: <0efd719a-802d-1401-7cee-d3918b47441d@redhat.com>
Date:   Tue, 26 Sep 2023 12:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Language: en-US
To:     Fernando Eckhardt Valle <fevalle@ipt.br>,
        ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
        corbet@lwn.net, hmh@hmh.eng.br, markgross@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <20230925184133.6735-1-fevalle@ipt.br>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230925184133.6735-1-fevalle@ipt.br>
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

It looks like I just reviewed an old version, reviewing this version now ...

On 9/25/23 20:41, Fernando Eckhardt Valle wrote:
> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
> Changes in v5:
> - Repeated code deleted.
> - Adjusted offset of a strscpy().
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
>  drivers/platform/x86/thinkpad_acpi.c          | 81 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
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
> index d70c89d32..2324ebb46 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,82 @@ static struct ibm_struct dprc_driver_data = {
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

In this code path you don't initialize the "auxmac" buffer at all,
but your auxmac_attr_group does not have an is_visible callback,
so the auxmax sysfs attr will still show up.

Please add an is_visible callback and retuern 0 (not visible)
when auxmac[0] == 0; See existing is_visible code for some
examples.

> +
> +	obj = buffer.pointer;
> +
> +	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
> +		pr_info("Invalid buffer for MAC address pass-through.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
> +	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
> +		pr_info("Invalid header for MAC address pass-through.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0)
> +		strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN + 1);

Please use sizeof(auxmac) as last parameter to strscpy() here.

> +	else
> +		strscpy(auxmac, "disabled", AUXMAC_LEN);

Please use sizeof(auxmac) as last parameter to strscpy() here.

Also note how you pass 2 different dest-sizes for the same dest buffer before,
which looks weird ...


> +
> +free:
> +	kfree(obj);
> +	return 0;
> +
> +auxmacinvalid:
> +	strscpy(auxmac, "unavailable", AUXMAC_LEN);
> +	goto free;
> +}

I'm not liking the goto dance here, I would prefer:

	kfree(obj);
	return 0;

auxmacinvalid:
	strscpy(auxmac, "unavailable", AUXMAC_LEN);
	kfree(obj);
	return 0;

It is quite normal for an error-exit path to repeat a kfree().

Note this is just a preference you keen keep this as is
if you want, but to me the goto free which jumps up looks
pretty weird.

Regards,

Hans



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
> @@ -10843,6 +10919,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11491,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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


