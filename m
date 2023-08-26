Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC747895DE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjHZKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHZKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:15:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0691FC3;
        Sat, 26 Aug 2023 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1693044950; bh=PnvzGxtclCb9TxkP/3PB4DGO6+FyzrMczE9z63c14OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8YfexUMXelmyffaROif3m7Hs/CoMOPtfjOxzp/pvJ2H4SDV1NESIuOa1LWwJK0p7
         BvrwbwmYpOWXzMmN7/dMIkXZpyi/nVE8gZjffUtJmF0gIlfDQhzn8JxQVislnikCNU
         ylclk5xx3BYNGm2fmkxs5ElXZtfaSBDodqJcCWOs=
Date:   Sat, 26 Aug 2023 12:15:49 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Julius Zint <julius@zint.sh>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/1] backlight: hid_bl: Add VESA VCP HID backlight
 driver
Message-ID: <9f7475eb-7e57-45cf-9854-90fb4e8da8a0@t-8ch.de>
References: <20230820094118.20521-1-julius@zint.sh>
 <20230820094118.20521-2-julius@zint.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820094118.20521-2-julius@zint.sh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-20 11:41:18+0200, Julius Zint wrote:
> [..]

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 51387b1ef012..b964a820956d 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -472,6 +472,14 @@ config BACKLIGHT_LED
>  	  If you have a LCD backlight adjustable by LED class driver, say Y
>  	  to enable this driver.
>  
> +config BACKLIGHT_HID
> +	tristate "VESA VCP HID Backlight Driver"
> +	depends on HID
> +	help
> +	  If you have an external display with VESA compliant HID brightness
> +	  controls then say Y to enable this backlight driver. Currently the
> +	  only supported device is the Apple Studio Display.

Is the last sentence needed?
It will go out of date soon, requiring updates to the Kconfig.

> +
>  endif # BACKLIGHT_CLASS_DEVICE
>  
>  endmenu

> [..]

> diff --git a/drivers/video/backlight/hid_bl.c b/drivers/video/backlight/hid_bl.c
> new file mode 100644
> index 000000000000..b40f8f412ee2
> --- /dev/null
> +++ b/drivers/video/backlight/hid_bl.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/backlight.h>
> +
> +#define APPLE_STUDIO_DISPLAY_VENDOR_ID  0x05ac
> +#define APPLE_STUDIO_DISPLAY_PRODUCT_ID 0x1114

Use hid-ids.h.  The vendor ID already has an entry.

> +
> +#define HID_USAGE_MONITOR_CTRL			0x800001
> +#define HID_USAGE_VESA_VCP_BRIGHTNESS		0x820010

> [..]

> +static int hid_bl_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{

> [..]

> +
> +	memset(&props, 0, sizeof(props));
> +	props.type = BACKLIGHT_RAW;

Wouldn't this be more a BACKLIGHT_FIRMWARE?

> +	props.max_brightness = data->max_brightness - data->min_brightness;
> +
> +	bl = devm_backlight_device_register(&hdev->dev, "vesa_vcp",

It's non-obvious that the "vesa_vcp" backlight comes from the
"hid_backlight" driver. Maybe align the names.

What happens when multiple compatible devices are used?
That seems to be possible with external monitors.

Can existing userspace figure out which display the backlight device
belongs to?
(I don't know either)

> +					    &hdev->dev, data,
> +					    &hid_bl_ops,
> +					    &props);

> [..]
