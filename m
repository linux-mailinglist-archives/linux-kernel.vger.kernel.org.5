Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57D79BB03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358956AbjIKWO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjIKLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D60ACEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694433259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVWw9bbXHSqs2F0ua9xeHB5+WGrOjtmrDi8P4B+JbbQ=;
        b=V8UoQ5bohhkEwS/rTOXzdN9KnH5sSol4/o98JjogMpmT2YCHilTpQyBO+PDhnUiyaOEVUC
        /Waqslc9KmudubS7Hucwi81j5R2rih3ddpkARwuK3xW7D2EVfA5cUDIiwIGDQgbH46qikQ
        V4xelV35x2CR1qLmYmuOGp2jihUfN0g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-TF8NrJ3gNXup9UIHnqLR5Q-1; Mon, 11 Sep 2023 07:54:18 -0400
X-MC-Unique: TF8NrJ3gNXup9UIHnqLR5Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9aa05c1934aso327306366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694433257; x=1695038057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVWw9bbXHSqs2F0ua9xeHB5+WGrOjtmrDi8P4B+JbbQ=;
        b=qazc43E970zRVcw0hKGIHfOPEswoUX+iNcS7qidhUxmFN2e189+dceIQwM0t4kn18b
         6dxxGdQBsKVBVvX62jDCwblEAJ+cJhAHLY/AMLXxqrafau0bov/X2IlSL6GZAlG+p6pa
         e8v7pRRATxikkg/ICZzwOZzHsqJNinfvBRTV4OrqrWTOOkz0nXtKzxYU7D4b4WivJEgv
         Dv2D+sUg9ykeFPpDGKAg21EOtWM1nupEc5N4+yPOeXkI/Dm/vTx9gpqdAipae1ArpiDC
         x5flbG95UoGlu1GE4sjjhXouSjY1D6j0x59Or1T/UE8eSPEKD/wgeulCSaa78jfnwEXG
         RW3Q==
X-Gm-Message-State: AOJu0YxXYYi6M6gEaC/PrnbYmrw/7Iro8VIFHK07TAyg0wHht7yY4KM6
        ov9Zsaa88xAJt7fJuYyefwBAhW5stKZ1x/n3pfy8UFVVzKPbJqtpt8dnF0xOnYotrtd+pbfEmUh
        hvndezGvrQVuiWgXbvYac4IQF
X-Received: by 2002:a17:907:1c94:b0:982:a022:a540 with SMTP id nb20-20020a1709071c9400b00982a022a540mr21214326ejc.11.1694433257564;
        Mon, 11 Sep 2023 04:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaCxqMst8t2NSozjlJg8HUSqfxw9xDFoywmO9mjxgfLOWCnedevs+7wFPN2zkIXenoYbN0TQ==
X-Received: by 2002:a17:907:1c94:b0:982:a022:a540 with SMTP id nb20-20020a1709071c9400b00982a022a540mr21214294ejc.11.1694433257165;
        Mon, 11 Sep 2023 04:54:17 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709066d4b00b0099cb0a7098dsm5285867ejt.19.2023.09.11.04.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:54:16 -0700 (PDT)
Message-ID: <26abd722-4daa-bc9e-3a5d-a8c8765b5ff7@redhat.com>
Date:   Mon, 11 Sep 2023 13:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230830032237.42987-1-luke@ljones.dev>
 <20230830032237.42987-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230830032237.42987-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

Thank you for the updated patch.

On 8/30/23 05:22, Luke D. Jones wrote:
> Add support for the WMI methods used to turn off and adjust the
> brightness of the secondary "screenpad" device found on some high-end
> ASUS laptops like the GX650P series and others.
> 
> There are some small quirks with this device when considering only the
> raw WMI methods:
> 1. The Off method can only switch the device off
> 2. Changing the brightness turns the device back on
> 3. To turn the device back on the brightness must be > 1
> 4. When the device is off the brightness can't be changed (so it is
>    stored by the driver if device is off).
> 5. Booting with a value of 0 brightness (retained by bios) means the bios
>    will set a value of >0 <15
> 6. When the device is off it is "unplugged"
> 
> asus_wmi sets the minimum brightness as 20 in general use, and 60 for
> booting with values <= min.
> 
> The ACPI methods are used in a new backlight device named asus_screenpad.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 133 +++++++++++++++++++++
>  drivers/platform/x86/asus-wmi.h            |   1 +
>  include/linux/platform_data/x86/asus-wmi.h |   4 +
>  3 files changed, 138 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index f54178d6f780..0b13be703856 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -25,6 +25,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> @@ -127,6 +128,10 @@ module_param(fnlock_default, bool, 0444);
>  #define NVIDIA_TEMP_MIN		75
>  #define NVIDIA_TEMP_MAX		87
>  
> +#define ASUS_SCREENPAD_BRIGHT_MIN 20
> +#define ASUS_SCREENPAD_BRIGHT_MAX 255
> +#define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
> +
>  static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>  
>  static int throttle_thermal_policy_write(struct asus_wmi *);
> @@ -212,6 +217,7 @@ struct asus_wmi {
>  
>  	struct input_dev *inputdev;
>  	struct backlight_device *backlight_device;
> +	struct backlight_device *screenpad_backlight_device;
>  	struct platform_device *platform_device;
>  
>  	struct led_classdev wlan_led;
> @@ -3776,6 +3782,124 @@ static int is_display_toggle(int code)
>  	return 0;
>  }
>  
> +/* Screenpad backlight *******************************************************/
> +
> +static int read_screenpad_backlight_power(struct asus_wmi *asus)
> +{
> +	int ret;
> +
> +	ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
> +	if (ret < 0)
> +		return ret;
> +	/* 1 == powered */
> +	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> +}
> +
> +static int read_screenpad_brightness(struct backlight_device *bd)
> +{
> +	struct asus_wmi *asus = bl_get_data(bd);
> +	u32 retval;
> +	int err;
> +
> +	err = read_screenpad_backlight_power(asus);
> +	if (err < 0)
> +		return err;
> +	/* The device brightness can only be read if powered, so return stored */
> +	if (err == FB_BLANK_POWERDOWN)
> +		return asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
> +	if (err < 0)
> +		return err;
> +
> +	return (retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK) - ASUS_SCREENPAD_BRIGHT_MIN;
> +}
> +
> +static int update_screenpad_bl_status(struct backlight_device *bd)
> +{
> +	struct asus_wmi *asus = bl_get_data(bd);
> +	int power, err = 0;
> +	u32 ctrl_param;
> +
> +	power = read_screenpad_backlight_power(asus);
> +	if (power < 0)
> +		return power;
> +
> +	if (bd->props.power != power) {
> +		if (power != FB_BLANK_UNBLANK) {
> +			/* Only brightness > 0 can power it back on */
> +			ctrl_param = asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
> +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
> +						    ctrl_param, NULL);
> +		} else {
> +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
> +		}
> +	} else if (power == FB_BLANK_UNBLANK) {
> +		/* Only set brightness if powered on or we get invalid/unsync state */
> +		ctrl_param = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
> +		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
> +	}
> +
> +	/* Ensure brightness is stored to turn back on with */
> +	if (err == 0)
> +		asus->driver->screenpad_brightness = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
> +
> +	return err;
> +}
> +
> +static const struct backlight_ops asus_screenpad_bl_ops = {
> +	.get_brightness = read_screenpad_brightness,
> +	.update_status = update_screenpad_bl_status,
> +	.options = BL_CORE_SUSPENDRESUME,
> +};
> +
> +static int asus_screenpad_init(struct asus_wmi *asus)
> +{
> +	struct backlight_device *bd;
> +	struct backlight_properties props;
> +	int err, power;
> +	int brightness = 0;
> +
> +	power = read_screenpad_backlight_power(asus);
> +	if (power < 0)
> +		return power;
> +
> +	if (power != FB_BLANK_POWERDOWN) {
> +		err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
> +		if (err < 0)
> +			return err;
> +	}
> +	/* default to an acceptable min brightness on boot if too low */
> +	if (brightness < ASUS_SCREENPAD_BRIGHT_MIN)
> +		brightness = ASUS_SCREENPAD_BRIGHT_DEFAULT;
> +
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
> +	props.max_brightness = ASUS_SCREENPAD_BRIGHT_MAX - ASUS_SCREENPAD_BRIGHT_MIN;
> +	bd = backlight_device_register("asus_screenpad",
> +				       &asus->platform_device->dev, asus,
> +				       &asus_screenpad_bl_ops, &props);
> +	if (IS_ERR(bd)) {
> +		pr_err("Could not register backlight device\n");
> +		return PTR_ERR(bd);
> +	}
> +
> +	asus->screenpad_backlight_device = bd;
> +	asus->driver->screenpad_brightness = brightness;
> +	bd->props.brightness = brightness;

This should be:

	bd->props.brightness = brightness - ASUS_SCREENPAD_BRIGHT_MIN;

Since this is the value exported to userspace which is down-shited
by ASUS_SCREENPAD_BRIGHT_MIN to start at 0.

I have fixed this up while merging this:

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


> +	bd->props.power = power;
> +	backlight_update_status(bd);
> +
> +	return 0;
> +}
> +
> +static void asus_screenpad_exit(struct asus_wmi *asus)
> +{
> +	backlight_device_unregister(asus->screenpad_backlight_device);
> +
> +	asus->screenpad_backlight_device = NULL;
> +}
> +
>  /* Fn-lock ********************************************************************/
>  
>  static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
> @@ -4431,6 +4555,12 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	} else if (asus->driver->quirks->wmi_backlight_set_devstate)
>  		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT)) {
> +		err = asus_screenpad_init(asus);
> +		if (err && err != -ENODEV)
> +			goto fail_screenpad;
> +	}
> +
>  	if (asus_wmi_has_fnlock_key(asus)) {
>  		asus->fnlock_locked = fnlock_default;
>  		asus_wmi_fnlock_update(asus);
> @@ -4454,6 +4584,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus_wmi_backlight_exit(asus);
>  fail_backlight:
>  	asus_wmi_rfkill_exit(asus);
> +fail_screenpad:
> +	asus_screenpad_exit(asus);
>  fail_rfkill:
>  	asus_wmi_led_exit(asus);
>  fail_leds:
> @@ -4480,6 +4612,7 @@ static int asus_wmi_remove(struct platform_device *device)
>  	asus = platform_get_drvdata(device);
>  	wmi_remove_notify_handler(asus->driver->event_guid);
>  	asus_wmi_backlight_exit(asus);
> +	asus_screenpad_exit(asus);
>  	asus_wmi_input_exit(asus);
>  	asus_wmi_led_exit(asus);
>  	asus_wmi_rfkill_exit(asus);
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index a478ebfd34df..5fbdd0eafa02 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -57,6 +57,7 @@ struct quirk_entry {
>  struct asus_wmi_driver {
>  	int			brightness;
>  	int			panel_power;
> +	int			screenpad_brightness;
>  	int			wlan_ctrl_by_user;
>  
>  	const char		*name;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 16e99a1c37fc..63e630276499 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -58,6 +58,10 @@
>  #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
>  #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
>  #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
> +/* This can only be used to disable the screen, not re-enable */
> +#define ASUS_WMI_DEVID_SCREENPAD_POWER	0x00050031
> +/* Writing a brightness re-enables the screen if disabled */
> +#define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
>  #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
>  

