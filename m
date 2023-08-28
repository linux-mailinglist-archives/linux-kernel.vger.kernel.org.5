Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB778A84C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjH1Ix6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjH1Ixl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1AE5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693212773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TisNcUMK/nsjbDX7viLQ9gS569d1CqWEIJmRF5xbIHM=;
        b=Oav/1y92G1S8eV1TTPA+B0T04dsqQ5yde6aIqCHlx891OP9P1IhXfXu+ob47nxWw3pASg8
        GvCw8QplBqwkg735vUaL7ARiEIVanaRLgPcTpc6aSenaQ4EyT82XFS81gnzTS6HII1FHbW
        qmliHnTYjl1BGIo9hfoqlKinyZGYAlc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-E5PhSwRjMU62b58iZ6tRgg-1; Mon, 28 Aug 2023 04:52:51 -0400
X-MC-Unique: E5PhSwRjMU62b58iZ6tRgg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c8bbc902eso241758666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212770; x=1693817570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TisNcUMK/nsjbDX7viLQ9gS569d1CqWEIJmRF5xbIHM=;
        b=dGQIOhdxhohHPo/9Ji4WBuopBEZFHygsc/Z4/oIH+yJ1LCHKCxwiTPMdtPd1cuEgvZ
         zOr3Noj8NYTZQJP5BXiiqUeyWSkhFDMAXzleDQNFX1F9TSsVqarqacmib6MURaow/mSI
         cCWfe9oX0eXM0QUXfoMzlhTLGRvuERgIf6rkWIHPLb8IuxLW4Ncn+r7K2EJiNnSCAcnO
         Tj3VXeqMsGaXdJf5aUdaPlLOIshVqF+4gKzrrqPWbcXXWM0+dQVs1XqpTck1XFxPmVcf
         RaDMWIXFxOvhLBU/WkPQEDUtLv8+0U+/jJasMLdwloSpmRULbEJEGMYlCmRuDp6qPzY+
         464g==
X-Gm-Message-State: AOJu0YwvMOQCYrflt1wytHf6sktelHSNMwvHBq1+QTvXNX3ogiMOIjgH
        joLSafv7+JKlJBGjca6coBu//aGeRrLuI2VtqVdEPjCiWBgagVyoZTSKmXC30LGJFrqS+Pe7Jlp
        geRUGLfFZ4vAkc9ms6pEHRhz4
X-Received: by 2002:a17:907:77c4:b0:99c:6825:ca06 with SMTP id kz4-20020a17090777c400b0099c6825ca06mr17894475ejc.12.1693212770388;
        Mon, 28 Aug 2023 01:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUYVVGcjyNcIHw7TBzoms6NyoWy/c19RjLoaj60U1SPJiD2Js3OBBJi+AzDuSjGth+O7I5GA==
X-Received: by 2002:a17:907:77c4:b0:99c:6825:ca06 with SMTP id kz4-20020a17090777c400b0099c6825ca06mr17894462ejc.12.1693212770058;
        Mon, 28 Aug 2023 01:52:50 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709066bcb00b0099cb1a2cab0sm4441570ejs.28.2023.08.28.01.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:52:48 -0700 (PDT)
Message-ID: <23f0e2b5-ab0c-ea02-98a5-e3f9cbbba618@redhat.com>
Date:   Mon, 28 Aug 2023 10:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] platform/x86: ideapad-laptop: Add support for keyboard
 backlights using KBLC ACPI symbol
Content-Language: en-US
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        ilpo.jarvinen@linux.intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Ike Panhc <ike.pan@canonical.com>
References: <4aa2e668-aa50-202f-6ce-3d4cc1209b@linux.intel.com>
 <20230827161940.485200-1-stuart.a.hayhurst@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230827161940.485200-1-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

On 8/27/23 18:19, Stuart Hayhurst wrote:
> Newer Lenovo laptops seem to use the KBLC symbol to control the backlight
> Add support for handling the keyboard backlight on these devices
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Thank you for your patch and thank you Ilpo for the reviews.

This looks good to me now. The merge window for 6.6 opened yesterday,
so the timing of this is a bit unfortunate. Since I know that
various users have actually been asking about this functionality
and since this seems a reasonably isolated patch I've decided
to still merge this now (just in time for 6.6).

I hope I'm not going to regret this :)   In the worse case we
can always revert this and try again for 6.7 .

I've applied this patch to my review-hans  branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the current
merge-window.

Regards,

Hans





> ---
> 
> Thanks, applied your feedback
> 
> v1 -> v2:
>  - Replace keyboard identification hex literals with defines
>  - Use a helper macro for checking a keyboard type is tristate
>  - Reworked ideapad_kbd_bl_brightness_set
>  - Reworked ideapad_kbd_bl_brightness_get
>  - Clean up newlines and stray change
>  - Use GENMASK, FIELD_GET and FIELD_PUT instead of manual masking and shifting
>  - Correct format specifiers for new warnings
> 
> v2 -> v3:
>  - Use named define for keyboard brightness event
>  - Replaced CHECK_KBD_BL_TRISTATE macro with static function
>  - Dropped _MASK suffix for bit masking
>  - Use FIELD_PREP for the get command too
>  - Ignore least significant bit in KBD__BL_GET_BRIGHTNESS mask
> 
> ---
>  drivers/platform/x86/ideapad-laptop.c | 118 ++++++++++++++++++++++++--
>  1 file changed, 112 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index d2fee9a3e239..4a19a396fc3b 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/backlight.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
>  #include <linux/debugfs.h>
> @@ -85,6 +86,31 @@ enum {
>  	SALS_FNLOCK_OFF       = 0xf,
>  };
>  
> +/*
> + * These correspond to the number of supported states - 1
> + * Future keyboard types may need a new system, if there's a collision
> + * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
> + * so it effectively has 3 states, but needs to handle 4
> + */
> +enum {
> +	KBD_BL_STANDARD      = 1,
> +	KBD_BL_TRISTATE      = 2,
> +	KBD_BL_TRISTATE_AUTO = 3,
> +};
> +
> +#define KBD_BL_QUERY_TYPE		0x1
> +#define KBD_BL_TRISTATE_TYPE		0x5
> +#define KBD_BL_TRISTATE_AUTO_TYPE	0x7
> +
> +#define KBD_BL_COMMAND_GET		0x2
> +#define KBD_BL_COMMAND_SET		0x3
> +#define KBD_BL_COMMAND_TYPE		GENMASK(7, 4)
> +
> +#define KBD_BL_GET_BRIGHTNESS		GENMASK(15, 1)
> +#define KBD_BL_SET_BRIGHTNESS		GENMASK(19, 16)
> +
> +#define KBD_BL_KBLC_CHANGED_EVENT	12
> +
>  struct ideapad_dytc_priv {
>  	enum platform_profile_option current_profile;
>  	struct platform_profile_handler pprof;
> @@ -122,6 +148,7 @@ struct ideapad_private {
>  	} features;
>  	struct {
>  		bool initialized;
> +		int type;
>  		struct led_classdev led;
>  		unsigned int last_brightness;
>  	} kbd_bl;
> @@ -242,6 +269,16 @@ static int exec_sals(acpi_handle handle, unsigned long arg)
>  	return exec_simple_method(handle, "SALS", arg);
>  }
>  
> +static int exec_kblc(acpi_handle handle, unsigned long arg)
> +{
> +	return exec_simple_method(handle, "KBLC", arg);
> +}
> +
> +static int eval_kblc(acpi_handle handle, unsigned long cmd, unsigned long *res)
> +{
> +	return eval_int_with_arg(handle, "KBLC", cmd, res);
> +}
> +
>  static int eval_dytc(acpi_handle handle, unsigned long cmd, unsigned long *res)
>  {
>  	return eval_int_with_arg(handle, "DYTC", cmd, res);
> @@ -1270,16 +1307,47 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
>  /*
>   * keyboard backlight
>   */
> +static int ideapad_kbd_bl_check_tristate(int type)
> +{
> +	return (type == KBD_BL_TRISTATE) || (type == KBD_BL_TRISTATE_AUTO);
> +}
> +
>  static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
>  {
> -	unsigned long hals;
> +	unsigned long value;
>  	int err;
>  
> -	err = eval_hals(priv->adev->handle, &hals);
> +	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
> +		err = eval_kblc(priv->adev->handle,
> +				FIELD_PREP(KBD_BL_COMMAND_TYPE, priv->kbd_bl.type) |
> +				KBD_BL_COMMAND_GET,
> +				&value);
> +
> +		if (err)
> +			return err;
> +
> +		/* Convert returned value to brightness level */
> +		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
> +
> +		/* Off, low or high */
> +		if (value <= priv->kbd_bl.led.max_brightness)
> +			return value;
> +
> +		/* Auto, report as off */
> +		if (value == priv->kbd_bl.led.max_brightness + 1)
> +			return 0;
> +
> +		/* Unknown value */
> +		dev_warn(&priv->platform_device->dev,
> +			 "Unknown keyboard backlight value: %lu", value);
> +		return -EINVAL;
> +	}
> +
> +	err = eval_hals(priv->adev->handle, &value);
>  	if (err)
>  		return err;
>  
> -	return !!test_bit(HALS_KBD_BL_STATE_BIT, &hals);
> +	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
>  }
>  
>  static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
> @@ -1291,7 +1359,21 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
>  
>  static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
>  {
> -	int err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> +	int err;
> +	unsigned long value;
> +	int type = priv->kbd_bl.type;
> +
> +	if (ideapad_kbd_bl_check_tristate(type)) {
> +		if (brightness > priv->kbd_bl.led.max_brightness)
> +			return -EINVAL;
> +
> +		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, brightness) |
> +			FIELD_PREP(KBD_BL_COMMAND_TYPE, type) |
> +			KBD_BL_COMMAND_SET;
> +		err = exec_kblc(priv->adev->handle, value);
> +	} else {
> +		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> +	}
>  
>  	if (err)
>  		return err;
> @@ -1344,8 +1426,13 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
>  
>  	priv->kbd_bl.last_brightness = brightness;
>  
> +	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
> +		priv->kbd_bl.led.max_brightness = 2;
> +	} else {
> +		priv->kbd_bl.led.max_brightness = 1;
> +	}
> +
>  	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
> -	priv->kbd_bl.led.max_brightness          = 1;
>  	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
>  	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
>  	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
> @@ -1456,6 +1543,7 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
>  		case 2:
>  			ideapad_backlight_notify_power(priv);
>  			break;
> +		case KBD_BL_KBLC_CHANGED_EVENT:
>  		case 1:
>  			/*
>  			 * Some IdeaPads report event 1 every ~20
> @@ -1557,13 +1645,31 @@ static void ideapad_check_features(struct ideapad_private *priv)
>  			if (test_bit(HALS_FNLOCK_SUPPORT_BIT, &val))
>  				priv->features.fn_lock = true;
>  
> -			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val))
> +			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val)) {
>  				priv->features.kbd_bl = true;
> +				priv->kbd_bl.type = KBD_BL_STANDARD;
> +			}
>  
>  			if (test_bit(HALS_USB_CHARGING_SUPPORT_BIT, &val))
>  				priv->features.usb_charging = true;
>  		}
>  	}
> +
> +	if (acpi_has_method(handle, "KBLC")) {
> +		if (!eval_kblc(priv->adev->handle, KBD_BL_QUERY_TYPE, &val)) {
> +			if (val == KBD_BL_TRISTATE_TYPE) {
> +				priv->features.kbd_bl = true;
> +				priv->kbd_bl.type = KBD_BL_TRISTATE;
> +			} else if (val == KBD_BL_TRISTATE_AUTO_TYPE) {
> +				priv->features.kbd_bl = true;
> +				priv->kbd_bl.type = KBD_BL_TRISTATE_AUTO;
> +			} else {
> +				dev_warn(&priv->platform_device->dev,
> +					 "Unknown keyboard type: %lu",
> +					 val);
> +			}
> +		}
> +	}
>  }
>  
>  #if IS_ENABLED(CONFIG_ACPI_WMI)

