Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCE7FD1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjK2JIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjK2JIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:08:52 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0385;
        Wed, 29 Nov 2023 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1701248932; bh=Xv3LVDjykwD/IOkFuRPxIVNxFelutLAZSXS7jeSQqIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAZ/6qGNguReQ4NFwPXT8Bi2uaQNZ0Q93gRgXJPFRYxINiE+0NAHwqYEo8gcRktTI
         g5OWo09C5jJHok3S1c3vfX72MgTtnOlRCfK/TqM9Rhw5IHY9zlrMU0Lm6ESMeYefR5
         o0o+IWUBwaImm3Ew7Uz5W7jNB5PpjVR/Xzp9G3VEMAH3MPFJnFwTN5A/JF0jvSM53H
         TD72MGqWdop+SC6I4X83nrxxAJKPcPymeSSvEn8ptLrmEICedV7+oDpdhH/aFgVPau
         +Aaz/bRn6yA421udzBxvVtiTPtc21WHM3jUynkqXosp+xZ5HbIh4FPd2hzKqYs08uU
         fPTAj/lk7FXSA==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id CB5B0100100; Wed, 29 Nov 2023 09:08:52 +0000 (GMT)
Date:   Wed, 29 Nov 2023 09:08:52 +0000
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
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
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
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
Message-ID: <ZWb_pEixK07cRlnr@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
 <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
 <ZWClpnMRg_vjuI_R@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWClpnMRg_vjuI_R@orome.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:31:18PM +0100, Thierry Reding wrote:
> On Sat, Nov 18, 2023 at 04:16:17PM +0000, Sean Young wrote:
> > In order to introduce a pwm api which can be used from atomic context,
> > we will need two functions for applying pwm changes:
> > 
> > 	int pwm_apply_cansleep(struct pwm *, struct pwm_state *);
> > 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
> > 
> > This commit just deals with renaming pwm_apply_state(), a following
> > commit will introduce the pwm_apply_atomic() function.
> 
> Sorry, I still don't agree with that _cansleep suffix. I think it's the
> wrong terminology. Just because something can sleep doesn't mean that it
> ever will. "Might sleep" is much more accurate because it says exactly
> what might happen and indicates what we're guarding against.

Sorry, I forgot about this in the last round. I've renamed it _might_sleep
in v6 which I'll post shortly.


Sean
