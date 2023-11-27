Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359987F9F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjK0MPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjK0MPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0F1A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701087334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fI+C8/bX9e2YG+K+fSYEaSTwRfiC0DEcv0zKQARub9o=;
        b=jEqoDFBt7Kil4v9ngJ2V/elmgAKFTzfuTRwWMfExKyXpWX9TIJEnQr7+d/rPcH3J0XlAwI
        pxItu0HHMkHG8W/r3+iKKn+T6XwYWTSMTmxxvHSpEKzIXcp5BoF22S+6dgAzvVIlKSe/PG
        RkzJemLCmKgpzI0qWT/E/4ylshid730=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-yTMud907McaxPu2QLT0mmw-1; Mon, 27 Nov 2023 07:15:33 -0500
X-MC-Unique: yTMud907McaxPu2QLT0mmw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-543298e3cc8so2894286a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087332; x=1701692132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fI+C8/bX9e2YG+K+fSYEaSTwRfiC0DEcv0zKQARub9o=;
        b=dGnjghYyuvP84ux3KhlnM8W0gHUH/nCRm4shM2eheexcykuDxfUEt7JkqXz4bdqmS5
         EV/CMtMrYwdBG+BYw/B8DsLnvepH63NM4SXgOfhu/4DFwvspKldy9IvB/RexZtayW7tV
         n2Kl+vs8Loc7JoemwG67sEcgQhcRtw6s5ubHIYe/3JBMrHIfvPK1Hb3W3F7bJgPabwLy
         cyGU0D3Yr6xpmMpmTr4QWVPCW7XQVdV72iok+bjEDif659hifhVOgheWKaqHEDb9VniP
         gbEXXcP5VlSxjeMlo07bqJvgO2gcgcA/gG6yrIeRM5CK3Ka8Q1cqrYGVuIo2EB6LVvUe
         dy0w==
X-Gm-Message-State: AOJu0Yxg2AnFw2FrGx3ntAGOrXB/DkCgT0r58apbyeuBp3yL1GB3Zmv6
        KmMR5ZXUJKTvgqjrpV/5BOqQDWR9C4nrekhcccIUPidNbFJsVOCbC+TFq4p9GqZg9Jksaahi0uh
        Q2b+H6J3l+zJEosUUMCjgNs9Y
X-Received: by 2002:a05:6402:2219:b0:54a:f86f:669e with SMTP id cq25-20020a056402221900b0054af86f669emr7353952edb.18.1701087332024;
        Mon, 27 Nov 2023 04:15:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwcfpY06TcykQSkgFiIy2S0dzMfyIKToC9aYumGwhcH28dgXbKs+PgbTqDA6zw07uTQ7+thw==
X-Received: by 2002:a05:6402:2219:b0:54a:f86f:669e with SMTP id cq25-20020a056402221900b0054af86f669emr7353934edb.18.1701087331730;
        Mon, 27 Nov 2023 04:15:31 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g18-20020a50d0d2000000b0054b89583a2fsm376455edf.49.2023.11.27.04.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:15:31 -0800 (PST)
Message-ID: <13bee0fc-2a32-4f6d-ba5d-cac99882686a@redhat.com>
Date:   Mon, 27 Nov 2023 13:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] platform/x86: acer-wmi: add fan speed monitoring
 for Predator PHN16-71
Content-Language: en-US
To:     SungHwan Jung <onenowy@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231124094122.100707-1-onenowy@gmail.com>
 <20231124094122.100707-3-onenowy@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231124094122.100707-3-onenowy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your patch.

On 11/24/23 10:41, SungHwan Jung wrote:
> Support CPU and GPU fan speed monitoring through WMI for Predator
> PHN16-71.
> 
> This patch depends on patch "platform/x86: acer-wmi: Add platform
> profile and mode key support for Predator PHN16-71"
> 
> Signed-off-by: SungHwan Jung <onenowy@gmail.com>
> ---
>  drivers/platform/x86/Kconfig    |   1 +
>  drivers/platform/x86/acer-wmi.c | 104 +++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7e69fdacc..caf3f4c6b 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig

<snip>

> @@ -2505,6 +2535,9 @@ static int acer_platform_probe(struct platform_device *device)
>  			goto error_platform_profile;
>  	}
>  
> +	if (has_cap(ACER_CAP_FAN_SPEED_READ))
> +		err = acer_wmi_hwmon_init();
> +
>  	return err;
>  
>  error_rfkill:
This has the same error-handling problem as patch 1/3. I have fixed
this up in the same manner while merging this, resulting in:

        if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
                err = acer_platform_profile_setup();
                if (err)
                        goto error_platform_profile;
        }

        if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
                err = acer_wmi_hwmon_init();
                if (err)
                        goto error_hwmon;
        }

        return 0;

error_hwmon:
        if (platform_profile_support)
                platform_profile_remove();
error_platform_profile:
        acer_rfkill_exit();
error_rfkill:
        if (has_cap(ACER_CAP_BRIGHTNESS))
                acer_backlight_exit();

	...

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



