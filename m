Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22A77695F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHIUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHIUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA33E45
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691611171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1btU9N+flfBepGrbeDBkidThui9A+VviKVGjNtRmik=;
        b=F3i4I9DVjVtKkgLHPA2XpJj0xG5OMe+nWf0IK19rxvczbDDqNbpAmvhEMTFqP1aD7bR+jo
        S47bg1vXZ/VlPVU1T4/C0RwlGaCNDjvBUVOKXVrBZfwX8+IJ3nw/USWrh6jT/M3g+Mwnbw
        SEhIouCmWJgHjpJ8Q5Coc4vKyhzqcuM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Y6ViQM3SOYO7Af3Re0SQ8w-1; Wed, 09 Aug 2023 15:59:30 -0400
X-MC-Unique: Y6ViQM3SOYO7Af3Re0SQ8w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe5e67adc6so127067e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611168; x=1692215968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1btU9N+flfBepGrbeDBkidThui9A+VviKVGjNtRmik=;
        b=e/kll0ydaiyJzEolxCOym9zif8oAeIpyHwzWgp9/d6CY4g+WG4aMkWJBFld8TVAbju
         KWM7dNnSpXK5WH2CkyIqpGiJi+64Oh83cda0xiJTTtO4vGQPw+ftHc/3XHUj8whVw9sc
         R5Ib+z7hHDJ+g0xOiRTyeBwl1OctBTKiNX8l1K8cXNVxGBNn3yY7Uh3ASe2wzyqRQ2cf
         lSwjJd0nsZ67krhpliqorpdTOzMwE8bbD27U4wv+PKwdOkwWApHEHrNa5AKp8zCr9oms
         u+le6lKyDT4IYRQF+QIBGd4RpOKW5eUFnBIjs/2m0LoJ0hUQhB9Vcn2wdhlFMmEtcW+K
         pxnw==
X-Gm-Message-State: AOJu0Yyyp6Xbd0rjoXWCaMMrGzIv7tIuGwaRwXNZxF2Nu77Zcz/xqseN
        yzjHSN0ppooL5BbKjciZbBrdwAAEiNUtXnxSYLYRHWc2il7H+floLqucSmHZnoY6EfI8MVugioO
        GezqlN68tEbPZlBdGJvK4w3mE
X-Received: by 2002:a05:6512:e93:b0:4f8:e4e9:499e with SMTP id bi19-20020a0565120e9300b004f8e4e9499emr139075lfb.12.1691611168748;
        Wed, 09 Aug 2023 12:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhTdRCrTEoAr/L525XFk81vlAmpbzlO1IBoukC/kPxUsu6iu8v/eYX9HCtoWajQ01yWqeu3Q==
X-Received: by 2002:a05:6512:e93:b0:4f8:e4e9:499e with SMTP id bi19-20020a0565120e9300b004f8e4e9499emr139059lfb.12.1691611168359;
        Wed, 09 Aug 2023 12:59:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7dd05000000b005234011bb44sm3212652edv.11.2023.08.09.12.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:59:27 -0700 (PDT)
Message-ID: <e818c889-40f8-0318-e29d-372da57c33d8@redhat.com>
Date:   Wed, 9 Aug 2023 21:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: msi-ec: Fix the build
Content-Language: en-US, nl
To:     Jean Delvare <jdelvare@suse.de>,
        platform-driver-x86@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Nikita Kravets <teackot@gmail.com>
References: <20230805101010.54d49e91@endymion.delvare>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230805101010.54d49e91@endymion.delvare>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/5/23 10:10, Jean Delvare wrote:
> The msi-ec driver fails to build for me (gcc 7.5):
> 
>   CC [M]  drivers/platform/x86/msi-ec.o
> drivers/platform/x86/msi-ec.c:72:6: error: initializer element is not constant
>     { SM_ECO_NAME,     0xc2 },
>       ^~~~~~~~~~~
> drivers/platform/x86/msi-ec.c:72:6: note: (near initialization for ‘CONF0.shift_mode.modes[0].name’)
> drivers/platform/x86/msi-ec.c:73:6: error: initializer element is not constant
>     { SM_COMFORT_NAME, 0xc1 },
>       ^~~~~~~~~~~~~~~
> drivers/platform/x86/msi-ec.c:73:6: note: (near initialization for ‘CONF0.shift_mode.modes[1].name’)
> drivers/platform/x86/msi-ec.c:74:6: error: initializer element is not constant
>     { SM_SPORT_NAME,   0xc0 },
>       ^~~~~~~~~~~~~
> drivers/platform/x86/msi-ec.c:74:6: note: (near initialization for ‘CONF0.shift_mode.modes[2].name’)
> (...)
> 
> Don't try to be smart, just use defines for the constant strings. The
> compiler will recognize it's the same string and will store it only
> once in the data section anyway.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 392cacf2aa10 ("platform/x86: Add new msi-ec driver")
> Cc: stable@vger.kernel.org
> Cc: Nikita Kravets <teackot@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans







> ---
>  drivers/platform/x86/msi-ec.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-6.4.orig/drivers/platform/x86/msi-ec.c
> +++ linux-6.4/drivers/platform/x86/msi-ec.c
> @@ -27,15 +27,15 @@
>  #include <linux/seq_file.h>
>  #include <linux/string.h>
>  
> -static const char *const SM_ECO_NAME       = "eco";
> -static const char *const SM_COMFORT_NAME   = "comfort";
> -static const char *const SM_SPORT_NAME     = "sport";
> -static const char *const SM_TURBO_NAME     = "turbo";
> +#define SM_ECO_NAME		"eco"
> +#define SM_COMFORT_NAME		"comfort"
> +#define SM_SPORT_NAME		"sport"
> +#define SM_TURBO_NAME		"turbo"
>  
> -static const char *const FM_AUTO_NAME     = "auto";
> -static const char *const FM_SILENT_NAME   = "silent";
> -static const char *const FM_BASIC_NAME    = "basic";
> -static const char *const FM_ADVANCED_NAME = "advanced";
> +#define FM_AUTO_NAME		"auto"
> +#define FM_SILENT_NAME		"silent"
> +#define FM_BASIC_NAME		"basic"
> +#define FM_ADVANCED_NAME	"advanced"
>  
>  static const char * const ALLOWED_FW_0[] __initconst = {
>  	"14C1EMS1.012",
> 
> 

