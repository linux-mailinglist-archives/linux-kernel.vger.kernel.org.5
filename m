Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821DE7F6EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbjKXIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjKXIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DAD91
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700815290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uae6umIvihz9hD9eDNpHrM2v+MklsEpu9QPr6jgBbKo=;
        b=L/op+qLvyZCvgZHWF4ty+H5+xedOpyuiRd7LUqUacJXzOjymyiBPBfkmu7Sv/vpJXTamE5
        Doc8zx38mnUHqk+L4BZnBFSH70uVTUt/+PJcpRXKX3mSKXBGYCV1orcLf4PzP3VfD8S6/s
        Jq1tQOqfCLfwF7vp5OGNYPG4ccxvEJk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-rJQ0dHUbP3yq8gLe1UD0gw-1; Fri, 24 Nov 2023 03:41:29 -0500
X-MC-Unique: rJQ0dHUbP3yq8gLe1UD0gw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-543298e3cc8so1167149a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815288; x=1701420088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uae6umIvihz9hD9eDNpHrM2v+MklsEpu9QPr6jgBbKo=;
        b=wzgh9LRZG24OcRBneev27ZZ8bCatKiFxMSfXszoVErCzrW3mmzbFwwhwN3C/mpyiFX
         vs1MEY6C3whd/WaEotQHfqDG5onNGYJRz/U/GCJQyhVhx3V6XfHYzSB76Lg74tECxpCR
         9qHcvYSZ0Ex+mJwGpnv1w0Hxk968lMR+fh3UAHyT7obIPZKnCoecUR3uFNOeIWmycXoj
         4W4pnoMPr5/enJIrl/P6qAZEU+IV3bQCaRFTyYPnAi/FbADWpmfOM8qxVDTf/GgiNcYY
         fNZDrLNlIQWnByydIBB/2kj0nfkoR3Lt1xRvWvWxNz83g8fAJ/o96vlrlRfZc27qvR9D
         26nw==
X-Gm-Message-State: AOJu0YzaPUMF2RSuJsfAoAOmZ/L+phMwBKMmnaK77t2UKxumnXeavHRH
        +jjPnj14NtpvwllEFTLOEwGzNn/oaqw1lTgsFRlBw5R1CqHQK6RjPWw0RPVKpr+jODG3YagJxmD
        VdiBdQadjEtdTWJsI5b37TMla
X-Received: by 2002:a50:ab58:0:b0:540:118:e8f with SMTP id t24-20020a50ab58000000b0054001180e8fmr1539443edc.24.1700815288289;
        Fri, 24 Nov 2023 00:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELiUzhZFnbJ82OfiqMC5ixm/aul3tuw7FDsrJkBoJ1/2MyN0oeJBzjV6LRyahA3oVvVYOtRg==
X-Received: by 2002:a50:ab58:0:b0:540:118:e8f with SMTP id t24-20020a50ab58000000b0054001180e8fmr1539430edc.24.1700815287950;
        Fri, 24 Nov 2023 00:41:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e18-20020a056402089200b00548a408f662sm1548936edy.49.2023.11.24.00.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:41:27 -0800 (PST)
Message-ID: <1d0f5076-1c8b-49c6-a5d8-5796d829a368@redhat.com>
Date:   Fri, 24 Nov 2023 09:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: disable USB0 hub on ROG Ally
 before suspend
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231124082749.23353-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231124082749.23353-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

Thank you for the patch.

On 11/24/23 09:27, Luke D. Jones wrote:
> ASUS have worked around an issue in XINPUT in Windows by tweaking the MCU
> firmware to disable the USB0 hub on screen disable when suspending.

Can you please do s/XINPUT/XInput game controller emulation/ I had to duckduckgo
XINPUT to figure out what this was about :)

> The issue we have with this however is one of timing - the call the tells
> the MCU to this isn't able to complete before suspend is done so we call
> this in a prepare() and add a small msleep() to ensure it is done.
> 
> Without this the MCU is unable to initialise itself correctly on resume.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6a79f16233ab..c28829d45fb5 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/backlight.h>
>  #include <linux/debugfs.h>
> +#include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/fb.h>
>  #include <linux/hwmon.h>
> @@ -132,6 +133,9 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_SCREENPAD_BRIGHT_MAX 255
>  #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
>  
> +/* Controls the power state of the USB0 hub on ROG Ally which input is on */
> +#define ASUS_USB0_PWR_SB_PCI0_SBRG_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
> +
>  static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>  
>  static int throttle_thermal_policy_write(struct asus_wmi *);
> @@ -300,6 +304,9 @@ struct asus_wmi {
>  
>  	bool fnlock_locked;
>  
> +	/* The ROG Ally device requires the USB hub to be disabled before suspend */
> +	bool pre_suspend_ec0_csee_disable;
> +
>  	struct asus_wmi_debug debug;
>  
>  	struct asus_wmi_driver *driver;
> @@ -4488,6 +4495,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>  	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> +	asus->pre_suspend_ec0_csee_disable = acpi_has_method(NULL, ASUS_USB0_PWR_SB_PCI0_SBRG_EC0_CSEE)
> +						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>  
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
> @@ -4654,6 +4663,38 @@ static int asus_hotk_resume(struct device *device)
>  		asus_wmi_fnlock_update(asus);
>  
>  	asus_wmi_tablet_mode_get_state(asus);
> +
> +	return 0;
> +}
> +
> +static int asus_hotk_resume_early(struct device *device)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	acpi_status status;
> +
> +	if (asus->pre_suspend_ec0_csee_disable) {
> +		status = acpi_execute_simple_method(NULL, ASUS_USB0_PWR_SB_PCI0_SBRG_EC0_CSEE, 0xB8);
> +		if (ACPI_FAILURE(status)) {
> +			pr_warn("failed to set USB hub power on\n");
> +			return 1;

On an error this should return -ESOMETHING not 1,
or IMHO better, just only warn and continue with the return 0
below. When you change this to only warn please also
drop the {}

> +		}
> +	}
> +	return 0;
> +}
> +
> +static int asus_hotk_prepare(struct device *device)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	acpi_status status;
> +
> +	if (asus->pre_suspend_ec0_csee_disable) {
> +		status = acpi_execute_simple_method(NULL, ASUS_USB0_PWR_SB_PCI0_SBRG_EC0_CSEE, 0xB7);
> +		msleep(500); /* sleep required to ensure n-key is disabled before sleep continues */
> +		if (ACPI_FAILURE(status)) {
> +			pr_warn("failed to set USB hub power off\n");
> +			// return 1;
> +		}

Please drop the commented "return 1;" and the { } .

With these changes you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to v2 of the patch.

Regards,

Hans





> +	}
>  	return 0;
>  }
>  
> @@ -4701,6 +4742,8 @@ static const struct dev_pm_ops asus_pm_ops = {
>  	.thaw = asus_hotk_thaw,
>  	.restore = asus_hotk_restore,
>  	.resume = asus_hotk_resume,
> +	.resume_early = asus_hotk_resume_early,
> +	.prepare = asus_hotk_prepare,
>  };
>  
>  /* Registration ***************************************************************/

