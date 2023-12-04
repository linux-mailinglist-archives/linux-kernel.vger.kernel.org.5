Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D776803786
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbjLDOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjLDOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E9B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701701494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpHZcDHjpU4mfBG41n94eQLmc8/ZuBEaOjwl4e/nn80=;
        b=gyqlsHdFT7C4KyuqHr1q7thQEEEkWFyjV3vjpijLE0H+xTTSl1vkh079mdUygJic1F4uo6
        ufy53sVNSUd8XtWgm2JmSgGGp72nSv4Hkcy8QEt3aGfY643ElBbzzTahAXEemRT5waf0Aa
        cilm1zN375Az2mWgvxBmcl7j/1MGEag=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-BGFg_t6cOViXMm0sNag4_w-1; Mon, 04 Dec 2023 09:51:33 -0500
X-MC-Unique: BGFg_t6cOViXMm0sNag4_w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bfbba86e0so636335e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701492; x=1702306292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpHZcDHjpU4mfBG41n94eQLmc8/ZuBEaOjwl4e/nn80=;
        b=Ci/kvpIwqUw9rEACjY/+0dhJ57wpRaiS9JxxzJdlwleAMPp3zvIR2kwPFgM4S8wmYI
         xbIzkyBV8mt0dw5SkofEW+/joKbZZo8jZ4ylmnl4vjkKNU179qtOOgMKQovOU9neM9LN
         5fjF2K0rpsn85/FjbGDnxNCbLfQeBRV6rEWxPByrg+uAOcvPX+lXYcM3ma3O68CQ8hjZ
         XJdRWgAMbnivoEhp/o5CiyMlLeUj/wQhJCO3AeHITbkErpGF1QeuuMsrGWVBDneKXbnR
         u26oLKEC6rsb61qsXfb5g+uhvv1Cvc81xRysQmyG+vYJcpFbKlF4JitGGeIBAId3Be6S
         VJig==
X-Gm-Message-State: AOJu0YwCi6xZMtnK9LRmUG9ZmvbJYxnzc1WVGXzAvPl/VnR+cJM/6T3P
        6QtL1kyjlBGmQH/RvIGeiLpMnOIuogWSNEVJqA8ma8eK1oUgdtNvAlAEmQYxH5OfCIK05dpjYxY
        f5tRLZz1hiG3Tk6oZ9FBWULK6
X-Received: by 2002:a05:6512:39ca:b0:50c:e:171e with SMTP id k10-20020a05651239ca00b0050c000e171emr100255lfu.5.1701701491825;
        Mon, 04 Dec 2023 06:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs1GCa0CgDvN1RhA5ymImqbjGWQhbplO/YgAFsWjKv5h53RCw3xx96+O9cDczJFQ7M1yeRQw==
X-Received: by 2002:a05:6512:39ca:b0:50c:e:171e with SMTP id k10-20020a05651239ca00b0050c000e171emr100247lfu.5.1701701491510;
        Mon, 04 Dec 2023 06:51:31 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cy18-20020a0564021c9200b0054cc61f0412sm1509632edb.24.2023.12.04.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:51:30 -0800 (PST)
Message-ID: <898ebe87-6376-4385-b42a-25ecc08772f6@redhat.com>
Date:   Mon, 4 Dec 2023 15:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: x86-android-tablets: Fix an IS_ERR() vs
 NULL check in probe
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <4b1b2395-c7c5-44a4-b0b0-6d091c7f46a2@moroto.mountain>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4b1b2395-c7c5-44a4-b0b0-6d091c7f46a2@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 	 	 	

On 12/4/23 13:29, Dan Carpenter wrote:
> The spi_new_device() function returns NULL on error, it doesn't return
> error pointers.
> 
> Fixes: 70505ea6de24 ("platform/x86: x86-android-tablets: Add support for SPI device instantiation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/x86-android-tablets/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> index 6a5975ac3286..f8221a15575b 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -220,8 +220,8 @@ static __init int x86_instantiate_spi_dev(const struct x86_dev_info *dev_info, i
>  
>  	spi_devs[idx] = spi_new_device(controller, &board_info);
>  	put_device(&controller->dev);
> -	if (IS_ERR(spi_devs[idx]))
> -		return dev_err_probe(&controller->dev, PTR_ERR(spi_devs[idx]),
> +	if (!spi_devs[idx])
> +		return dev_err_probe(&controller->dev, -ENOMEM,
>  				     "creating SPI-device %d\n", idx);
>  
>  	return 0;

