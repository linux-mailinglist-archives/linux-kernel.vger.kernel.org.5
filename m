Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2250479EDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjIMP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjIMP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D720CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oFlWNsBoPiP27e6QLLTn7WyeRku9K4oycwIoawQoLA=;
        b=gZ1Qjuo2rcmLWcbNoUVTVfrYy+1YmwNyl6A2+VnGJeHeUVPUzxpaaVFrA5shGh4pdh3Jh7
        9yFbKkvGmrUg9PYkuVGF0pK8vDCzftvf89aCPSNC703yzdFSWB+DfLfZBuMC2qiH4X6dTd
        CVaCgxpchY2PZaoNzlU3oPi4ElyPBmw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-X_4_YaQoOq2SDaphS8e5Xg-1; Wed, 13 Sep 2023 11:58:04 -0400
X-MC-Unique: X_4_YaQoOq2SDaphS8e5Xg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51d981149b5so4645556a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620683; x=1695225483;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oFlWNsBoPiP27e6QLLTn7WyeRku9K4oycwIoawQoLA=;
        b=joh13HmanqTYGN/DE+4y7tj0YTxJxPrd6rP43m8Nd2UMpBrzweUjDyvyMVxJkXBJnm
         PbYvInlPH9+x7ZAuqAIzuaN3p6wXXjBVeOtoAC/mgyYHq7ZhZvq5amBiWpm7FAHCyujI
         jXXkD0Qo08Am+xsX2RKmuSHbVccFE3bZjNDnLMo2UK9iqUc+omu0PQLyC+Ecr98DFfK1
         k/9po0HW+eNr9isIZLoMIEHVWe9iS5JVxBylcqRmmccDKWi0mtg0Wnrj9S576RQFj5GB
         inwmXdByw7KN9/MccgcePzw2K5qKlgLP53Fc6jb4ea+R9nDhMcgWvPTuwPPEa1FI5VE/
         KtCg==
X-Gm-Message-State: AOJu0YxywOupjWOq8/EXdNfYwijHW3KSGGr+xlxcApYGkg5LO36akI5v
        jGYc8ogr266ZNNF4ac6KBCoEm76scAnA8TXu+Vdb6WLYth4UsHWHxYwhaB8uq1OlDkH9emwgqXI
        3w9QyU7hm/D5IJrjKIe48zERF
X-Received: by 2002:a05:6402:1484:b0:52f:b00a:99be with SMTP id e4-20020a056402148400b0052fb00a99bemr2638847edv.33.1694620683026;
        Wed, 13 Sep 2023 08:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWdV0KLFyUcrOIrlW9A4stCQfGP5LxWC94fX/K6+RReONlj26k4SqNBtFWTgx5SelVrWKEsg==
X-Received: by 2002:a05:6402:1484:b0:52f:b00a:99be with SMTP id e4-20020a056402148400b0052fb00a99bemr2638832edv.33.1694620682667;
        Wed, 13 Sep 2023 08:58:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o1-20020a056402444100b0052ff9bae873sm336955edb.5.2023.09.13.08.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:58:02 -0700 (PDT)
Message-ID: <d26d4b15-765b-a444-b740-97f95f2db58d@redhat.com>
Date:   Wed, 13 Sep 2023 17:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Language: en-US, nl
To:     Fernando Eckhardt Valle <fevalle@ipt.br>, hmh@hmh.eng.br,
        markgross@kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpearson-lenovo@squebb.ca
References: <20230906195204.4478-1-fevalle@ipt.br>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230906195204.4478-1-fevalle@ipt.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fernando,

On 9/6/23 21:52, Fernando Eckhardt Valle wrote:
> Newer Thinkpads have a feature called Mac Address Passthrough.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>

Thank you for your patch. 

At a minimum for this patch to be accepted you will need
to document the new sysfs interface in:

Documentation/admin-guide/laptops/thinkpad-acpi.rst

But I wonder if we should export this information to
userspace in this way ?

The reason why I'm wondering is because mac-address passthrough
in case of using e.g. Lenovo Thunderbolt docks is already
supported by the kernel by code for this in drivers/net/usb/r8152.c :

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/usb/r8152.c#n1613

So I'm wondering if we really need this, is there a planned
userspace API consumer of the new sysfs interface ?

Or is this only intended as a way for a user to query this, iow
is this purely intended for informational purposes ?

Regards,

Hans






> ---
>  drivers/platform/x86/thinkpad_acpi.c | 77 ++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d70c89d32..0b1c36b0d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,78 @@ static struct ibm_struct dprc_driver_data = {
>  	.name = "dprc",
>  };
>  
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * Mac Address Passthrough feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +static char auxmac[AUXMAC_LEN];
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
> +	obj = (union acpi_object *)buffer.pointer;
> +
> +	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
> +		pr_info("Invalid buffer for mac addr passthrough.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + 0x8, "#", 1) != 0 ||
> +	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
> +		pr_info("Invalid header for mac addr passthrough.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);
> +	kfree(obj);
> +	return 0;
> +
> +auxmacinvalid:
> +	kfree(obj);
> +	memcpy(auxmac, "unavailable", 11);
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
> +	if (strncmp(auxmac, "XXXXXXXXXXXX", AUXMAC_LEN) == 0)
> +		memcpy(auxmac, "disabled", 9);
> +
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
> @@ -10843,6 +10915,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11487,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

