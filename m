Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92F789EF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjH0NcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjH0Nbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:31:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBEECA;
        Sun, 27 Aug 2023 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693143110; x=1724679110;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TEgKYbWYaB/CNEUZS6Ec+JOIfOuT36Ln/zpuEWhOacI=;
  b=cYwZD+2tr9QJyCIc5QPDIMEysFvJgLfv9v+qmtJD9kOFJB/+CkG6sq4P
   BE5xigTnn2nCtcwr3oQAPARo+QoYNhH+JZnW322Oss1hm+Coik/WJMT13
   BOjlCH5OPm+fIrM965q3XoKEvqIZDYYO6nJ/aD6eY3aXdSjD/TTNTUCvb
   9OkcqbYrdrF5EBVcCMC0XHFlAWGMxKEpYFvDdBiwiYQ6bJW7bsp99GZtg
   j3rRqnUPnsuLJDTHjz5Xc5W+ERQ3OdaFt8KxbrpjVipQm8r25kGsVDZrg
   kX5MSOtEzRNa+YBoAib5E7ht7o8Mzr9w3efwsj0m9v7evne83ySf4F7at
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="438897715"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="438897715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="852526181"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="852526181"
Received: from dplotkin-mobl.ger.corp.intel.com ([10.249.41.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:31:46 -0700
Date:   Sun, 27 Aug 2023 16:31:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH v2] platform/x86: ideapad-laptop: Add support for keyboard
 backlights using KBLC ACPI symbol
In-Reply-To: <20230826103530.9641-1-stuart.a.hayhurst@gmail.com>
Message-ID: <4aa2e668-aa50-202f-6ce-3d4cc1209b@linux.intel.com>
References:  <20230826103530.9641-1-stuart.a.hayhurst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023, Stuart Hayhurst wrote:

> Newer Lenovo laptops seem to use the KBLC symbol to control the backlight
> Add support for handling the keyboard backlight on these devices
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> ---
> 
> v1 -> v2:
>  - Replace keyboard identification hex literals with defines
>  - Use a helper macro for checking a keyboard type is tristate
>  - Reworked ideapad_kbd_bl_brightness_set
>  - Reworked ideapad_kbd_bl_brightness_get
>  - Clean up newlines and stray change
>  - Use GENMASK, FIELD_GET and FIELD_PUT instead of manual masking and shifting
>  - Correct format specifiers for new warnings

Thanks, looks better already. A few follow up comments still below.

> ---
>  drivers/platform/x86/ideapad-laptop.c | 113 ++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index d2fee9a3e239..6149852bf27f 100644
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
> @@ -85,6 +86,32 @@ enum {
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
> +
> +#define KBD_BL_GET_BRIGHTNESS_MASK	GENMASK(15, 0)
> +#define KBD_BL_SET_BRIGHTNESS_MASK	GENMASK(19, 16)
> +#define KBD_BL_SET_TYPE_MASK		GENMASK(7, 4)

You can use _MASK if you want but it usually adds little to no value only 
increasing the line numbers.

> +#define CHECK_KBD_BL_TRISTATE(TYPE)	(TYPE == KBD_BL_TRISTATE || \
> +					TYPE == KBD_BL_TRISTATE_AUTO)

Do a static function instead, there's nothing that requires macro for 
this.

> +
>  struct ideapad_dytc_priv {
>  	enum platform_profile_option current_profile;
>  	struct platform_profile_handler pprof;
> @@ -122,6 +149,7 @@ struct ideapad_private {
>  	} features;
>  	struct {
>  		bool initialized;
> +		int type;
>  		struct led_classdev led;
>  		unsigned int last_brightness;
>  	} kbd_bl;
> @@ -242,6 +270,16 @@ static int exec_sals(acpi_handle handle, unsigned long arg)
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
> @@ -1272,14 +1310,39 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
>   */
>  static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
>  {
> -	unsigned long hals;
> +	unsigned long value;
>  	int err;
>  
> -	err = eval_hals(priv->adev->handle, &hals);
> +	if (CHECK_KBD_BL_TRISTATE(priv->kbd_bl.type)) {
> +		err = eval_kblc(priv->adev->handle,
> +				(priv->kbd_bl.type << 4) | KBD_BL_COMMAND_GET,

Use FIELD_PREP(KBL_BL_GET_TYPE, priv->kbd_bl.type) here too.

Or ... Do GET and SET happen to share the field structure here in which 
case you could name it as KBD_BL_COMMAND_TYPE and not one for set and get?

> +				&value);
> +
> +		if (err)
> +			return err;
> +
> +		/* Convert returned value to brightness level */
> +		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS_MASK, value) >> 1;

Why is this >> 1 here? Is it that the least-significant bit is not part of 
the field? (In which case you want take that into account in the field's 
GENMASK()).


-- 
 i.


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
> @@ -1291,7 +1354,21 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
>  
>  static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
>  {
> -	int err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> +	int err;
> +	unsigned long value;
> +	int type = priv->kbd_bl.type;
> +
> +	if (CHECK_KBD_BL_TRISTATE(type)) {
> +		if (brightness > priv->kbd_bl.led.max_brightness)
> +			return -EINVAL;
> +
> +		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS_MASK, brightness) |
> +			FIELD_PREP(KBD_BL_SET_TYPE_MASK, type) |
> +			KBD_BL_COMMAND_SET;
> +		err = exec_kblc(priv->adev->handle, value);
> +	} else {
> +		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> +	}
>  
>  	if (err)
>  		return err;
> @@ -1344,8 +1421,13 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
>  
>  	priv->kbd_bl.last_brightness = brightness;
>  
> +	if (CHECK_KBD_BL_TRISTATE(priv->kbd_bl.type)) {
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
> @@ -1456,6 +1538,7 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
>  		case 2:
>  			ideapad_backlight_notify_power(priv);
>  			break;
> +		case 12:
>  		case 1:
>  			/*
>  			 * Some IdeaPads report event 1 every ~20
> @@ -1557,13 +1640,31 @@ static void ideapad_check_features(struct ideapad_private *priv)
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
> 

