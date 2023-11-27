Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2B7FAD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjK0WjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0WjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE73BA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701124754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kKUg/fXvYS5tkHqvXRuy+VfqnqaztEk7AoiO6in+nk=;
        b=fBLtTm53UrzH2/m1e+VnBWaDR1b1sIKhsnj1tMrmQ/ElZ0QhyDI9/qORVb5Udgr9gY894Y
        TqeCUgqA0gEoqBQKrAGwSrORJ+ObN6JTmPLVw/DRun3URHj6w7hRNcVvHBC7yTlMnmQJkV
        sjnSYHMo5ddJ6u762v/M+2t2kxS/Kgk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-2n7Nl62RO5mJ-mbi_0zIww-1; Mon, 27 Nov 2023 17:39:13 -0500
X-MC-Unique: 2n7Nl62RO5mJ-mbi_0zIww-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54b17cf3dcfso1574155a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124751; x=1701729551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kKUg/fXvYS5tkHqvXRuy+VfqnqaztEk7AoiO6in+nk=;
        b=L8H+bLaH8rChXhKzw7ihTsY9+9QGJfRgtfcSHbdAVLUmeJXhlh8itAXz0OBcXz/rU2
         jYdWsAT5vbW3Z5H1O7A60c9c56Q1ah/BvuDDX20Gd3f6Hv5Idu/1vCmrIUga6BooJQ5d
         PNBcNI72025NxZl16N4kN9acEKTWVMh27ap0HLk2wtBU9qaI2zITeAH2p6TukRnZgJ/P
         8L/SQR6lcOvRSqfsCAZdnlYwkM0ZOwTX8yr3y4aw6BqW4hp5qN51uFHeCFiH17Bf0pNR
         dnHIez4REiBcvYkfnAltt9T2AXo1XyjPa6hwpyDCMR5frB7DvsED6iczMx6Gf8vKLzuP
         7Ugg==
X-Gm-Message-State: AOJu0YxlU/blA3L3Miu4DXqlid0NeOxrJBffjIVH4WkEv7sDQN/AW0Fl
        +LNyDdykxQTZLz25UwlvzSIeKvTmpzPikZl7G3uBy62tXE8KCajoVM7lXMlssAKSBBGvdiNAsjF
        wvmAwNmaOE8UCTPDifyfGh1hCT0k7sfm/
X-Received: by 2002:a50:d55e:0:b0:542:eb1f:c70a with SMTP id f30-20020a50d55e000000b00542eb1fc70amr9828693edj.29.1701124751304;
        Mon, 27 Nov 2023 14:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaMz4xpYJ1zfVf9EBzF/oR82WnnTyfsu2cVqgWjvDHpeFVDXzwZwXszLhG2SmCp4g9Gh50bw==
X-Received: by 2002:a50:d55e:0:b0:542:eb1f:c70a with SMTP id f30-20020a50d55e000000b00542eb1fc70amr9828680edj.29.1701124750978;
        Mon, 27 Nov 2023 14:39:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b005401a4184ddsm5621599edt.27.2023.11.27.14.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 14:39:10 -0800 (PST)
Message-ID: <a62eb1df-2cf9-41cd-a64c-303f73549ce5@redhat.com>
Date:   Mon, 27 Nov 2023 23:39:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
Content-Language: en-US, nl
To:     Luke Jones <luke@ljones.dev>
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
 <1c5f3bd2-9f10-4e5d-8c6d-76441b2da850@redhat.com>
 <ZOTS4S.OUOP1DLTNVXP3@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZOTS4S.OUOP1DLTNVXP3@ljones.dev>
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

On 11/27/23 21:17, Luke Jones wrote:
> 
> 
> On Mon, Nov 27 2023 at 09:53:13 AM +01:00:00, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11/27/23 00:05, Luke D. Jones wrote:
>>>  ASUS have worked around an issue in XInput where it doesn't support USB
>>>  selective suspend, which causes suspend issues in Windows. They worked
>>>  around this by adjusting the MCU firmware to disable the USB0 hub when
>>>  the screen is switched off during the Microsoft DSM suspend path in ACPI.
>>>
>>>  The issue we have with this however is one of timing - the call the tells
>>>  the MCU to this isn't able to complete before suspend is done so we call
>>>  this in a prepare() and add a small msleep() to ensure it is done. This
>>>  must be done before the screen is switched off to prevent a variety of
>>>  possible races.
>>>
>>>  Further to this the MCU powersave option must also be disabled as it can
>>>  cause a number of issues such as:
>>>  - unreliable resume connection of N-Key
>>>  - complete loss of N-Key if the power is plugged in while suspended
>>>  Disabling the powersave option prevents this.
>>>
>>>  Without this the MCU is unable to initialise itself correctly on resume.
>>>
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>
>> Thanks, patch looks good to me, except that all the new lines
>> seem to use 4 spaces rather then a tab char as indent.
> 
> Apologies for the previous HTML email.
> I must be going mad... are you sure? I've checked the patch file I submitted. Run checkpatch on it. Checked my email copy, and checked in lore... I can't see where space chars are?

So I just checked the copy in patchwork:

https://patchwork.kernel.org/project/platform-driver-x86/patch/20231126230521.125708-2-luke@ljones.dev/

and you are rights, no 4 spaces there.

Where as if you look further down in this reply, where the original
patch is quoted the 4 spaces are right there, so now I'm wondering
if maybe my mail client introduced the problem when I was replying ?

(replies to other patches preserve the tabs just fine).

So this is weird, but lets just forget about it, just some weird
glitch ...

Regards,

Hans




> 
>>
>> With that fixed you can add my:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> to the next version.
>>
>> Regards,
>>
>> Hans
>>
>>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c            | 50 ++++++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h |  3 ++
>>>   2 files changed, 53 insertions(+)
>>>
>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>  index 6a79f16233ab..4ba33dfebfd4 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -16,6 +16,7 @@
>>>   #include <linux/acpi.h>
>>>   #include <linux/backlight.h>
>>>   #include <linux/debugfs.h>
>>>  +#include <linux/delay.h>
>>>   #include <linux/dmi.h>
>>>   #include <linux/fb.h>
>>>   #include <linux/hwmon.h>
>>>  @@ -132,6 +133,11 @@ module_param(fnlock_default, bool, 0444);
>>>   #define ASUS_SCREENPAD_BRIGHT_MAX 255
>>>   #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
>>>
>>>  +/* Controls the power state of the USB0 hub on ROG Ally which input is on */
>>>  +#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
>>>  +/* 300ms so far seems to produce a reliable result on AC and battery */
>>>  +#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
>>>  +
>>>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>>>
>>>   static int throttle_thermal_policy_write(struct asus_wmi *);
>>>  @@ -300,6 +306,9 @@ struct asus_wmi {
>>>
>>>       bool fnlock_locked;
>>>
>>>  +    /* The ROG Ally device requires the MCU USB device be disconnected before suspend */
>>>  +    bool ally_mcu_usb_switch;
>>>  +
>>>       struct asus_wmi_debug debug;
>>>
>>>       struct asus_wmi_driver *driver;
>>>  @@ -4488,6 +4497,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>       asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
>>>       asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>>>       asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
>>>  +    asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>>>  +                        && dmi_match(DMI_BOARD_NAME, "RC71L");
>>>
>>>       err = fan_boost_mode_check_present(asus);
>>>       if (err)
>>>  @@ -4654,6 +4665,43 @@ static int asus_hotk_resume(struct device *device)
>>>           asus_wmi_fnlock_update(asus);
>>>
>>>       asus_wmi_tablet_mode_get_state(asus);
>>>  +
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static int asus_hotk_resume_early(struct device *device)
>>>  +{
>>>  +    struct asus_wmi *asus = dev_get_drvdata(device);
>>>  +
>>>  +    if (asus->ally_mcu_usb_switch) {
>>>  +        if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
>>>  +            dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
>>>  +        else
>>>  +            msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
>>>  +    }
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static int asus_hotk_prepare(struct device *device)
>>>  +{
>>>  +    struct asus_wmi *asus = dev_get_drvdata(device);
>>>  +    int result, err;
>>>  +
>>>  +    if (asus->ally_mcu_usb_switch) {
>>>  +        /* When powersave is enabled it causes many issues with resume of USB hub */
>>>  +        result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
>>>  +        if (result == 1) {
>>>  +            dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
>>>  +            err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
>>>  +            if (err || result != 1)
>>>  +                dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
>>>  +        }
>>>  +        /* sleep required to ensure USB0 is disabled before sleep continues */
>>>  +        if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
>>>  +            dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
>>>  +        else
>>>  +            msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
>>>  +    }
>>>       return 0;
>>>   }
>>>
>>>  @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops = {
>>>       .thaw = asus_hotk_thaw,
>>>       .restore = asus_hotk_restore,
>>>       .resume = asus_hotk_resume,
>>>  +    .resume_early = asus_hotk_resume_early,
>>>  +    .prepare = asus_hotk_prepare,
>>>   };
>>>
>>>   /* Registration ***************************************************************/
>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>  index 63e630276499..ab1c7deff118 100644
>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>  @@ -114,6 +114,9 @@
>>>   /* Charging mode - 1=Barrel, 2=USB */
>>>   #define ASUS_WMI_DEVID_CHARGE_MODE    0x0012006C
>>>
>>>  +/* MCU powersave mode */
>>>  +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>>>  +
>>>   /* epu is connected? 1 == true */
>>>   #define ASUS_WMI_DEVID_EGPU_CONNECTED    0x00090018
>>>   /* egpu on/off */
>>
> 
> 

