Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7E7F9ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjK0Lne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjK0Lnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75A133
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701085418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkOpbKWU2mA/hyWylJke4xZIKkSX936DZIZ1I7bnNmk=;
        b=Xc4+zMbylf9zcRMu6cdWjCvRlwcIoqUT0KcNDqzf9q5rdnqvB7hW+49GZQGBq1nuxQybno
        ttDFGo726DgLqONzauFXP4f4rC8yMNy+s0SxdGBVud7Ss2vQexDRbpZkYN5UndbzxjErj1
        xX05X1QQ8zkfzYHxsn4eQsXhG2k12yg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-uYY2QvfTNv2XhiR2tgrCWw-1; Mon, 27 Nov 2023 06:43:36 -0500
X-MC-Unique: uYY2QvfTNv2XhiR2tgrCWw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a00dd93a5f1so330930966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701085415; x=1701690215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkOpbKWU2mA/hyWylJke4xZIKkSX936DZIZ1I7bnNmk=;
        b=hx2gHuEzdsscfvM1SHEq2af1OA+PlTCQhPeJ7v5tc1idJry+hEpOM8HWMB+1rBOryg
         wvGlXQX+5kA6Lx5nBvtrBmtohpZukofiGUCG+I8s7eJHGQsI0un2j0nyrfzuJUxzfY+R
         vhvf+6rMj3UCuq1bbOO33CgTeBrj2Wdl/Qci61aM23p/FfzThunJvUX7JZJJNK9ENa2h
         JK1Qku0pcgq2YqMu4n1Okwc25LApPA+Ez28agYVdEvmVafF/m7hv8Tm2IPlBbWvS2RdV
         kDY9WG+ZFDWbfVdziDGdVcmEi8BujMgDbI8piMW2KlAKOWURtwsxoqXqPfHqkL5egzQL
         cpDA==
X-Gm-Message-State: AOJu0YyP0h4nT+esqQJ/P/u0cbkcj28q8URvJhB3jgBrP7yFvCynQPuk
        ci7x41S/rvfvf+I8BKsmbVaPFBCDdY/1pjEUI5tiV1ESLA0dY/xzYZjS8HC4KKZcoW0MSzX9AvN
        NjkCUcYlfIc0cmN45YUzLqRbw
X-Received: by 2002:a17:906:2201:b0:9de:32bb:fa96 with SMTP id s1-20020a170906220100b009de32bbfa96mr7127946ejs.9.1701085415418;
        Mon, 27 Nov 2023 03:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmKUrycQqNYa+3j0Nw4B7Z518q5PzsL8c61NkF9I5E9+gV3sIGxXsJuD4vcv1c2jUrQRcfRQ==
X-Received: by 2002:a17:906:2201:b0:9de:32bb:fa96 with SMTP id s1-20020a170906220100b009de32bbfa96mr7127928ejs.9.1701085415024;
        Mon, 27 Nov 2023 03:43:35 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090668d600b00a029145bbb9sm5581623ejr.3.2023.11.27.03.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 03:43:34 -0800 (PST)
Message-ID: <adba7928-1ca7-4076-ba8f-32276b8fea5c@redhat.com>
Date:   Mon, 27 Nov 2023 12:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] platform/x86: acer-wmi: Add platform profile and
 mode key support for Predator PHN16-71
Content-Language: en-US
To:     SungHwan Jung <onenowy@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231124094122.100707-1-onenowy@gmail.com>
 <20231124094122.100707-2-onenowy@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231124094122.100707-2-onenowy@gmail.com>
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
>  The Acer Predator PHN16-71 has the mode key that is used to rotate
> thermal modes or toggle turbo mode with predator sense app (ver. 4) on
> windows.
> This patch includes platform profile and the mode key support for the
> device and also includes a small fix for "WMI_gaming_execute_u64"
> function.
> 
> Signed-off-by: SungHwan Jung <onenowy@gmail.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 268 +++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 0e472aa9b..e3650dce0 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -20,6 +20,7 @@
>  #include <linux/backlight.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/acpi.h>
>  #include <linux/i8042.h>
>  #include <linux/rfkill.h>
> @@ -62,9 +63,12 @@ MODULE_LICENSE("GPL");
>  
>  #define ACER_WMID_SET_GAMING_LED_METHODID 2
>  #define ACER_WMID_GET_GAMING_LED_METHODID 4
> +#define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>  #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>  #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>  
> +#define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
> +
>  /*
>   * Acer ACPI method GUIDs
>   */
> @@ -90,6 +94,10 @@ enum acer_wmi_event_ids {
>  	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
>  };
>  
> +enum acer_wmi_predator_v4_sys_info_command {
> +	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
> +};
> +
>  static const struct key_entry acer_wmi_keymap[] __initconst = {
>  	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
>  	{KE_KEY, 0x03, {KEY_WLAN} },     /* WiFi */
> @@ -232,6 +240,7 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_TURBO_OC     BIT(7)
>  #define ACER_CAP_TURBO_LED     BIT(8)
>  #define ACER_CAP_TURBO_FAN     BIT(9)
> +#define ACER_CAP_PLATFORM_PROFILE BIT(10)

When Ilpo set to use tabs for indent here, he meant to do
this in this patch too, I have fixed this up while merging the patch.

I have also found several places where you separate blocks
by multiple empty lines instead of just 1 empty line,
I have also fixed this (reducing things to 1 empty line)
while applying this.

<snip>


> @@ -2245,6 +2499,12 @@ static int acer_platform_probe(struct platform_device *device)
>  	if (err)
>  		goto error_rfkill;
>  
> +	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
> +		err = acer_platform_profile_setup();
> +		if (err)
> +			goto error_platform_profile;
> +	}
> +
>  	return err;
>  
>  error_rfkill:

The error handling here is wrong, on error you need to undo all previous steps,
so your error handling needs to add a label above the first (error_rfkill)
label and then undo the last step before the platform-profile-setup,
specifically call acer_rfkill_exit(); from the new label. IOW the code here
should look like this:

        if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
                err = acer_platform_profile_setup();
                if (err)
                        goto error_platform_profile;
        }

        return err;

error_platform_profile:
        acer_rfkill_exit();
error_rfkill:
        if (has_cap(ACER_CAP_BRIGHTNESS))
                acer_backlight_exit();
	...

I have also fixed this up while merging this patch:

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

