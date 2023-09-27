Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE57AFE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjI0IWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjI0IV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B58173F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695802823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nh0BWH1XX7JQsmjVNfOjalMhaCob29LiZjHUox/R18A=;
        b=YREgZUdWLQQKJ5scd3jsHAcTe1M3vbTuDwt1K4gUmHZnDe3d245k1dLOYPxQknGbO++GnX
        BmTcCBAyMGi8RvL3WBDGYt3BjNoszmhdxdLPpJ26Lww3/810kgOC1dk6KC+AFYuVyJb/ET
        r5S66VmiAxTc4plks2ZdXawSdKjmADM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-WiNPlo-cNf6k7RjuaXYCNg-1; Wed, 27 Sep 2023 04:20:19 -0400
X-MC-Unique: WiNPlo-cNf6k7RjuaXYCNg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae12311183so899739166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802818; x=1696407618;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh0BWH1XX7JQsmjVNfOjalMhaCob29LiZjHUox/R18A=;
        b=U9xmwqzxBJafFavE5PGai4LXmCsEd2f0jaRP0cO+0JXRYYgJP6Q6hYqs7mCHeLCDMh
         EDlrX3TNNJWYAWMkiTYWHbgELeqM7na5EmDMD516dlb38Gaps15zjyhGP1Bfd6eLHtes
         nFBGy3hXgByB8k8ixMrE37QnfKIX37r/p5gSt44nSFeNNuPKsXNaabJtX7ACzsMaONrF
         QJ24+lPajLVQUb3WKRPi83I6ccAZO4aaNDnTCPevUfuHOCTc0csHMrQTKG4gTyaxeeG8
         HblXGM7GkIbVw39csH1Hj79gebnsvelec1lY0vp87X2xRUO0k8gjW3RV3VOahQcr7JcD
         YLdQ==
X-Gm-Message-State: AOJu0YxEr5fGdA/nOe9eiu40DAg3YwRYZ9m71hsI3J5eBLIhEH/ZXAFI
        u8PfEXkFs2p2uUjkp6MMhQDHggLqceICmfyQLCseTVxBUocpeLK0Zy7m3ScNXywUU5FZCK0N3Iz
        y4JX7nkqfq7N4E9gv+aThoBb5
X-Received: by 2002:a17:906:c146:b0:99c:f47a:2354 with SMTP id dp6-20020a170906c14600b0099cf47a2354mr1654123ejc.70.1695802818412;
        Wed, 27 Sep 2023 01:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRaX85SW7v6jhyJbH1wJL8pktImvOz6Hwr6M7Pe/t0MYC/z282lBUQYLjuZtY3mowLCltWLQ==
X-Received: by 2002:a17:906:c146:b0:99c:f47a:2354 with SMTP id dp6-20020a170906c14600b0099cf47a2354mr1654105ejc.70.1695802818095;
        Wed, 27 Sep 2023 01:20:18 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0099caf5bed64sm8916651ejb.57.2023.09.27.01.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:20:17 -0700 (PDT)
Message-ID: <28e32f47-76c6-c28c-5da8-37e2202c2594@redhat.com>
Date:   Wed, 27 Sep 2023 10:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Language: en-US
To:     Fernando Eckhardt Valle <fevalle@ipt.br>,
        ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
        corbet@lwn.net, hmh@hmh.eng.br, markgross@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <20230926202144.5906-1-fevalle@ipt.br>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230926202144.5906-1-fevalle@ipt.br>
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

On 9/26/23 22:21, Fernando Eckhardt Valle wrote:
> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
> Changes in v6:
> - New adjustment to the strcpy() offset.
> - Added is_visible attribute.
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

Thanks, this looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 88 +++++++++++++++++++
>  2 files changed, 108 insertions(+)
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
> index d70c89d32..9c19624a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,89 @@ static struct ibm_struct dprc_driver_data = {
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
> +		strscpy(auxmac, obj->string.pointer + AUXMAC_START, sizeof(auxmac));
> +	else
> +		strscpy(auxmac, "disabled", sizeof(auxmac));
> +
> +free:
> +	kfree(obj);
> +	return 0;
> +
> +auxmacinvalid:
> +	strscpy(auxmac, "unavailable", sizeof(auxmac));
> +	goto free;
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
> +static umode_t auxmac_attr_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
> +{
> +	return auxmac[0] == 0 ? 0 : attr->mode;
> +}
> +
> +static struct attribute *auxmac_attributes[] = {
> +	&dev_attr_auxmac.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group auxmac_attr_group = {
> +	.is_visible = auxmac_attr_is_visible,
> +	.attrs = auxmac_attributes,
> +};
> +
>  /* --------------------------------------------------------------------- */
>  
>  static struct attribute *tpacpi_driver_attributes[] = {
> @@ -10843,6 +10926,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11498,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

