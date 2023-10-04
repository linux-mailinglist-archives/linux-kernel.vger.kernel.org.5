Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD87B7C30
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjJDJdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbjJDJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C9D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696411936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtIyfAOuitFC68Ri/h0kipARbcoU5koIfeG6YsBwoNI=;
        b=VmHtAZm4SKdx0lX7Q1Xy/BY//fAuyezKcPpzRffRm5TUYwfykuujtAMbRrHxyEZLXyrSI8
        INvCMwnbUmpc4abdsUlMed67MXkLYdycE1rj6DZ7WX0w2YH0N6n6skRJY7AfUdrIhZW8bI
        +7+DTUoEG9Czhy2a+GYwtheRSDSrzJk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-t3wtTIKSOfiDydPl-3WmxQ-1; Wed, 04 Oct 2023 05:32:15 -0400
X-MC-Unique: t3wtTIKSOfiDydPl-3WmxQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae7663e604so165632766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411933; x=1697016733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtIyfAOuitFC68Ri/h0kipARbcoU5koIfeG6YsBwoNI=;
        b=NKuMiIJDiZQFqmuoVFxot8+g0Fh85Prju2E7Tq2vK1nfzROlLROeTbubKRaLz74GrX
         JNqJwEOvbFJNark7xxxC3Rn6eImcZoHm66H+w22rvHa5LqyV1VDBKVGvNNYSSr1dyo40
         NWLpY/rxjHTO3578Ecigbbg/cpnC8R3HWOBXwRqcdzDe0RUGz3S8mtBi82cpkjaelkyM
         q/T2PyP/t5/GOi9ex8orjGctkGGTFn21zyBqlb/7raSQg6n/RH6LX0kybgTJnyVgklzy
         PbQoglXvWgVae78Ub6HFOwKlpVD6ELAvzyH9IoPmz/HNL6u6Ub6ifXAda6gcoY8fECbN
         J+Ng==
X-Gm-Message-State: AOJu0YxogTu7QRfYCQUABHzDet6AjmBkoI8MyJ292z+XH9vWBsyDoEOb
        1+Uv79HnpCF3HMU2iirRRAI32h+7+0fwtQEtnv4Gk16uszkOrgetGTfDp/k11CSDcrGD30nby8v
        81/WfQIq7hvRuNx0YYurnnh8eXQJ0AbJ9
X-Received: by 2002:a17:906:cc50:b0:9ae:50ec:bd88 with SMTP id mm16-20020a170906cc5000b009ae50ecbd88mr1556534ejb.55.1696411933412;
        Wed, 04 Oct 2023 02:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF1Roslr2NBIdYdFH5hYH+lBb2BxiehgkNjcST+3XjsQ2j3Zubn6Q4Oe14VqE+P+LjXtUmIA==
X-Received: by 2002:a17:906:cc50:b0:9ae:50ec:bd88 with SMTP id mm16-20020a170906cc5000b009ae50ecbd88mr1556504ejb.55.1696411932989;
        Wed, 04 Oct 2023 02:32:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lo25-20020a170906fa1900b009929ab17be0sm2467478ejb.162.2023.10.04.02.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:32:12 -0700 (PDT)
Message-ID: <7689997a-134b-6735-4a08-001ca62c46c8@redhat.com>
Date:   Wed, 4 Oct 2023 11:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: Add Silicom Platform Driver
Content-Language: en-US, nl
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20231003205439.8251-1-henryshi2018@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231003205439.8251-1-henryshi2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On 10/3/23 22:54, Henry Shi wrote:
> platform/x86: Add Silicom Platform Driver
> 
> Add Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products.
> 
> This platform driver provides support for various functions via
> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> and device attributes.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---

<snip>

> change from patch v7 to v8 (current patch)
> ===========================================
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Chnage commit message of this driver.
> .Adjust location of change log and signed-off-by.
> .Change "config SILICOM_PLATFORM" and help contents location,
> and put it to source "drivers/platform/x86/siemens/Kconfig".
> .Set editor tab to 8 and align the start of extra function
> parameters to directly after (. This should be applied for
> all function.
> .Do not manually create a sysfs dir and register sysfs attribute,
> instead define a platform_driver structure.
> .Move MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids) directly after
> table declaration.
> .Using pr_info() instead of dev_info() in function
> silicom_platform_info_init().
> .Made dmi_check_system() check the first thing to do in
> silicom_platform_init().
> .Instead of separate platform_device creation + driver registration,
> switched to using platform_create_bundle().
> .Removed mutex_destroy(&mec_io_mutex).
> 
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Too many GENMASK() within to code itself, need put them to
> #define. Removed all GENMASK() in c functions.

Thank you for the new version. At a quick look this looks much
better now wrt the probe / init / sysfs attr registration, great work!

2 quick remarks:

1. Please add a Documentation/ABI/testing/sysfs-platform-silicom
   file to document driver specific the sysfs attributes of this driver
   See: Documentation/ABI/testing/sysfs-platform-wilco-ec for an example
   (and other Documentation/ABI/testing/sysfs-platform-* files)

2. :

> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index b457de5abf7d..07efff8b24f7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
> +obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o
>  obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets/
>  
>  # Intel uncore drivers

Like with the Kconfig part, please group this together with
the other industrial PC drivers we have at the end of
the Makefile:

# Siemens Simatic Industrial PCs
obj-$(CONFIG_SIEMENS_SIMATIC_IPC)       += siemens/

# Silicom
obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o

# Winmate
obj-$(CONFIG_WINMATE_FM07_KEYS)         += winmate-fm07-keys.o

# SEL
obj-$(CONFIG_SEL3350_PLATFORM)          += sel3350-platform.o


Other then that please keep working with Ilpo to polish the code
a bit more and then hopefully this will be ready for merging soon.

Regards,

Hans



