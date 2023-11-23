Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D57F6279
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbjKWPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjKWPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF23D47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:16:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0C6C433C9;
        Thu, 23 Nov 2023 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700752567;
        bh=lzVZxJXSuVlg5TJP4dPDommHt63YQoouP8CMSO2x+6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHqy9roYY5/JVAeimPivoDsCudYKtwdFnGpoLH3m76OeL8P0BDyL5Sc/3miQr2PmL
         hRZDRRGAm1Uye0c+yqVpFAK/beZ5hDj70CfWngjrStrTzTvXtSc8NSYhr3ldpsQfaY
         r0YfI3xAzbQ5IZOXus3baO9WeGtvVe+D4X7QQ1qjU3B6uwub042jUFn6y80DWhT82k
         MTX1bTMLehElqjnjKV5oO01PHxy/Uz+zYAXPf8w7C1cEIoT3gWUSjO5jdkHK4u5/SP
         VhJvtTHQuu7E5vz/fTds/fpgnXUPXA1bUvRWNF23KUPZaqQcD2SqRGBwVcGpofXsbE
         B/Co9nS6vBIOA==
Date:   Thu, 23 Nov 2023 15:15:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 1/4] pwm: rename pwm_apply_state() to
 pwm_apply_cansleep()
Message-ID: <20231123151556.GC1354538@google.com>
References: <cover.1700323916.git.sean@mess.org>
 <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023, Sean Young wrote:

> In order to introduce a pwm api which can be used from atomic context,
> we will need two functions for applying pwm changes:
> 
> 	int pwm_apply_cansleep(struct pwm *, struct pwm_state *);
> 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
> 
> This commit just deals with renaming pwm_apply_state(), a following
> commit will introduce the pwm_apply_atomic() function.
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  Documentation/driver-api/pwm.rst              |  8 +++---
>  .../gpu/drm/i915/display/intel_backlight.c    |  6 ++--
>  drivers/gpu/drm/solomon/ssd130x.c             |  2 +-
>  drivers/hwmon/pwm-fan.c                       |  8 +++---
>  drivers/input/misc/da7280.c                   |  4 +--
>  drivers/input/misc/pwm-beeper.c               |  4 +--
>  drivers/input/misc/pwm-vibra.c                |  8 +++---

>  drivers/leds/leds-pwm.c                       |  2 +-
>  drivers/leds/rgb/leds-pwm-multicolor.c        |  4 +--

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/media/rc/pwm-ir-tx.c                  |  4 +--
>  drivers/platform/x86/lenovo-yogabook.c        |  2 +-
>  drivers/pwm/core.c                            | 18 ++++++------
>  drivers/pwm/pwm-twl-led.c                     |  2 +-
>  drivers/pwm/pwm-vt8500.c                      |  2 +-
>  drivers/pwm/sysfs.c                           | 10 +++----
>  drivers/regulator/pwm-regulator.c             |  4 +--

>  drivers/video/backlight/lm3630a_bl.c          |  2 +-
>  drivers/video/backlight/lp855x_bl.c           |  2 +-
>  drivers/video/backlight/pwm_bl.c              | 12 ++++----

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/video/fbdev/ssd1307fb.c               |  2 +-
>  include/linux/pwm.h                           | 28 +++++++++----------
>  21 files changed, 67 insertions(+), 67 deletions(-)

[...]

-- 
Lee Jones [李琼斯]
