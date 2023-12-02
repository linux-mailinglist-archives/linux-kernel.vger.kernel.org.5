Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E604801C72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjLBLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjLBLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5AFF0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701516739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xt2SJB3OEyXkH+gdUma+ns8reFuyKzbtvZneat4NxE4=;
        b=i56ARLIk0Sk67yph9IDy0QRddpNwOHc4Q+MG6rVpfQV6mlq/S4oue563cSK0qrhukvB18D
        v0ieWf9HJkmdLLqX6BOez7aAvgcm9dJNJXVnPaugvzcIqIODbClNMhKL+zme1xtuL7Hssf
        xtp8yf4hgP+xxjozYpeEDG4gjlNjtqI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-e5t15NhlN-2RK_MZIxFJqw-1; Sat, 02 Dec 2023 06:32:17 -0500
X-MC-Unique: e5t15NhlN-2RK_MZIxFJqw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9b9837ce8so34247421fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 03:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701516735; x=1702121535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt2SJB3OEyXkH+gdUma+ns8reFuyKzbtvZneat4NxE4=;
        b=NMi1OItzQPyx1KUyCBlSZGiVUrzdGIsbMXXunOipNDv1sTpnK9KhydJTlTCVqZwZxM
         ZMg82n05rORfIT3tixNdDXz32b7omHM5r943iFdYhLzfJxP/xgJT9DptOHJ40Clc9ull
         cmjB0WiYetoMzN0DwIqKE35bRiEziOCEn10I1v8KOmlm9NVw0mndjnAMG054XL5IrQTq
         b/Q73trlyQlxx08NkSdXHVbgc86alhd9ahL1a2S0wJySDuomkydeyaWWkLNv2qQGhMzA
         g1cf3xxPKO9KE5rXDTWMlkCAGPlnIgDKX5+qHz722KVOKQAJJbYU77it6rgelVbZlCP3
         z6JA==
X-Gm-Message-State: AOJu0Yw+XdZ/6ruTqqZL0xOkfck4Ave72nKp7rqpuCzXGqNHMRSmg1AE
        oRPl5NNKV/2JRMgLELfnve6RVrLNre8geIDichFB2MysAGka+t6fCskiHiHdewRlM39QLY6c5AV
        BhKDMbpy0jjPAZmjqGH/Q4BAF
X-Received: by 2002:a2e:381a:0:b0:2c9:caf4:18b0 with SMTP id f26-20020a2e381a000000b002c9caf418b0mr1464760lja.41.1701516735762;
        Sat, 02 Dec 2023 03:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4QhYhxIdH1bNNlbjq78o8Is9EW7Z3oPOwGwWPajwBN/LhgHcYYJLEsP75hTJr90U5m2gpOQ==
X-Received: by 2002:a2e:381a:0:b0:2c9:caf4:18b0 with SMTP id f26-20020a2e381a000000b002c9caf418b0mr1464757lja.41.1701516735423;
        Sat, 02 Dec 2023 03:32:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b009e776cc92dcsm2928411ejd.181.2023.12.02.03.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 03:32:14 -0800 (PST)
Message-ID: <083d318a-48b2-47f0-aed0-8788e25138f4@redhat.com>
Date:   Sat, 2 Dec 2023 12:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: acer-wmi: select ACPI_PLATFORM_PROFILE
Content-Language: en-US, nl
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        SungHwan Jung <onenowy@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231130124452.3460-1-onenowy@gmail.com>
 <c13f1666-33a1-2df2-649-c7d32e64c70@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c13f1666-33a1-2df2-649-c7d32e64c70@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/23 14:00, Ilpo Järvinen wrote:
> On Thu, 30 Nov 2023, SungHwan Jung wrote:
> 
>> select ACPI_PLATFORM_PROFILE to fix the dependency problem for acer-wmi
>> to support platform profile.
>>
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311301842.ppdT4zWK-lkp@intel.com/
>>
>> Signed-off-by: SungHwan Jung <onenowy@gmail.com>
>>
>> ---
>> I apologize that I missed dependency in kconfig.
>> I have submitted a single patch because the series of patches were alreay
>> merged to linux-next.
>> Is this enough or should I re-submit the patch-series including this patch?
>> (or modify this to apply before "platform/x86: acer-wmi: Add platform
>> profile and modekey support for Predator PHN16-71" commit?)
>> ---
>>  drivers/platform/x86/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 8e99a2f10147..81e6cd62a533 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -182,6 +182,7 @@ config ACER_WMI
>>  	select INPUT_SPARSEKMAP
>>  	select LEDS_CLASS
>>  	select NEW_LEDS
>> +	select ACPI_PLATFORM_PROFILE
>>  	help
>>  	  This is a driver for newer Acer (and Wistron) laptops. It adds
>>  	  wireless radio and bluetooth control, and on some laptops,
>>
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I suspect Hans will just included that into the original patch so this 
> patch will not appear in the history at all.

Right.

Thank you both for the patch and the review.

I have squashed this change into the original patch introducing
the platform_profile support.

You can find the new version in my pdx86/review-hans branch and the
pdx86/for-next branch now.

Regards,

Hans


