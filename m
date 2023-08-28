Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A378A9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjH1KQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjH1KQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70572B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693217758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UDRJi+Us13eQNcsdNoL16FRlNPmURBlCRFMRZwnle4=;
        b=I5NwvSvwzg+oFNXxzabnj9GmIRhBU+kom4G+N2bX3BhK4lICPECeCvpP9ttV0ElPvFhVtO
        sgmnImxy7dbeJ30UDpR99rdg9nFxZnPibpB+RFjRuMLtxL2djWZAWl7F9Z/Z0GjnvXhFz7
        JQwQWFEIi9Ool6wffjXhiBmV9qjxgSc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-NEy7m49DPE2vGNvjTNJLKA-1; Mon, 28 Aug 2023 06:15:57 -0400
X-MC-Unique: NEy7m49DPE2vGNvjTNJLKA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355cf318so247535366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217756; x=1693822556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UDRJi+Us13eQNcsdNoL16FRlNPmURBlCRFMRZwnle4=;
        b=L1FSDhfE17ZiDMrNmn9GthhUieVOBrVdecy1PmVrOE7dpaNBkLKybochRTwAUANE/a
         h+NEcaKLZ3VIjafX8gimlDVLjKiZfLXzA3z4+1M2JeiUrUunzKoHeClyL9CkH5owoh46
         nLZGWi6ZccFfolrH82ZWF96EckH2wF8789LMRhOQyayemh9LKILpZON1xqync+PszNoD
         oy+E/lUUIvl0aXMPzlzz6AJk8WRBxpW8SZo0tR+1+EIXGwlsQeMDrWzLp5u0bAWZOjb2
         yjvi9naBSbWKctgB0ZDargXi+VHCNlhAWt3gGXQKpYd7iiY9281qJCnbhKJFmmR1rqaw
         PKug==
X-Gm-Message-State: AOJu0YySWCslwVdccLBg7Tf7LvKt8ul6p1ryZe7TM4tWWzVjIkz0Thnb
        2+wucK9TJElNsIYDUYixBYBtzW07PxzPFUESzn3eWs4TXgh6Q2GL/iDJ0z1Sm+lqmsUWRWa0lJt
        6irMueHr0PS65CUMH1Pviyqua
X-Received: by 2002:a17:907:2c48:b0:99d:6b3c:3d40 with SMTP id hf8-20020a1709072c4800b0099d6b3c3d40mr18280045ejc.6.1693217756071;
        Mon, 28 Aug 2023 03:15:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF867WGM0kQGBrcSH9ynKW92cBd+NL/+tw6CGitJ0h1k4pScu6DhP8XxHOwMcefaMMZb7j06Q==
X-Received: by 2002:a17:907:2c48:b0:99d:6b3c:3d40 with SMTP id hf8-20020a1709072c4800b0099d6b3c3d40mr18280033ejc.6.1693217755639;
        Mon, 28 Aug 2023 03:15:55 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090655c100b0098cf565d98asm4473226ejp.22.2023.08.28.03.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:15:55 -0700 (PDT)
Message-ID: <c51c4159-c5d5-8fc1-58d2-b02bc1eb731d@redhat.com>
Date:   Mon, 28 Aug 2023 12:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20230827232358.80512-1-luke@ljones.dev>
 <20230827232358.80512-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230827232358.80512-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

Thank you for your patch.

For the next version please don't forget to
Cc: platform-driver-x86@vger.kernel.org

On 8/28/23 01:23, Luke D. Jones wrote:
> Add support for the WMI methods used to turn off and adjust the
> brightness of the secondary "screenpad" device found on some high-end
> ASUS laptops like the GX650P series and others.
> 
> These methods are utilised in a new backlight device named asus_screenpad.

You have quite a bit of useful extra info in your cover-letter,
for the next version please add a copy of that info to your
commit message.

> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 131 +++++++++++++++++++++
>  drivers/platform/x86/asus-wmi.h            |   1 +
>  include/linux/platform_data/x86/asus-wmi.h |   4 +
>  3 files changed, 136 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 13547e55ae82..2801c691133a 100644
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
> @@ -127,6 +128,9 @@ module_param(fnlock_default, bool, 0444);
>  #define NVIDIA_TEMP_MIN		75
>  #define NVIDIA_TEMP_MAX		87
>  
> +#define ASUS_SCREENPAD_BRIGHT_MIN 20

Hmm, in the coverletter you talk about 15 as min value
and 60 as default value when the value read back from
the hw at probe() time is < min.

I'm fine with using 20 instead of 15, but the whole
"The compromise was to set the brightness to 60 which is
a usable brightness if the module init brightness was under 15."
thing from your cover letter seems to be missing.

> +#define ASUS_SCREENPAD_BRIGHT_MAX 255
> +
>  static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>  
>  static int throttle_thermal_policy_write(struct asus_wmi *);
> @@ -212,6 +216,7 @@ struct asus_wmi {
>  
>  	struct input_dev *inputdev;
>  	struct backlight_device *backlight_device;
> +	struct backlight_device *screenpad_backlight_device;
>  	struct platform_device *platform_device;
>  
>  	struct led_classdev wlan_led;
> @@ -3776,6 +3781,123 @@ static int is_display_toggle(int code)
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
> +		return asus->driver->screenpad_brightness;

You are missing a " - ASUS_SCREENPAD_BRIGHT_MIN" here (you do add
it when storing values to asus->driver->screenpad_brightness
in update_screenpad_bl_status()).

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
> +			ctrl_param = max(ASUS_SCREENPAD_BRIGHT_MIN, asus->driver->screenpad_brightness);

Not sure you need the max() here, I don't think you ever store a value
below ASUS_SCREENPAD_BRIGHT_MIN in driver->screenpad_brightness ?

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

Not sure if you should update screenpad_brightness here on errors ?
Maybe add a "if (err == 0)" as condition ?

> +	/* Ensure brightness is stored to turn back on with */
> +	asus->driver->screenpad_brightness = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;

So screenpad_brightness is never below ASUS_SCREENPAD_BRIGHT_MIN here.

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
> +		brightness = ASUS_SCREENPAD_BRIGHT_MIN;

		brightness = ASUS_SCREENPAD_BRIGHT_DEFAULT;

Instead (new define for "60") ?

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

And you've checked brightness against ASUS_SCREENPAD_BRIGHT_MIN above,
so screenpad_brightness is never below ASUS_SCREENPAD_BRIGHT_MIN here either.

Otherwise this looks good to me.

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
> @@ -4431,6 +4553,12 @@ static int asus_wmi_add(struct platform_device *pdev)
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
> @@ -4454,6 +4582,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus_wmi_backlight_exit(asus);
>  fail_backlight:
>  	asus_wmi_rfkill_exit(asus);
> +fail_screenpad:
> +	asus_screenpad_exit(asus);
>  fail_rfkill:
>  	asus_wmi_led_exit(asus);
>  fail_leds:
> @@ -4480,6 +4610,7 @@ static int asus_wmi_remove(struct platform_device *device)
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

