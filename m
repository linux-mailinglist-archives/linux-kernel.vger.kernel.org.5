Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D668577B839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjHNMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjHNMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:07:44 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07930DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:07:41 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RPY5N0dxFz9xHjf;
        Mon, 14 Aug 2023 20:06:00 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 14 Aug
 2023 20:07:17 +0800
Date:   Mon, 14 Aug 2023 20:07:17 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
CC:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [PATCH] drm/i915: Fix Kconfig error for CONFIG_DRM_I915
Message-ID: <ZNoY9bnpLlUwY8ai@fedora>
References: <ZNdOoHvIg7HXh7Gg@fedora>
 <87o7jaythm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87o7jaythm.fsf@intel.com>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:26:45AM +0300, Jani Nikula wrote:
> On Sat, 12 Aug 2023, Wang Jinchao <wangjinchao@xfusion.com> wrote:
> > When CONFIG_DRM_I915 is set to 'y' and CONFIG_BACKLIGHT_CLASS_DEVICE
> > is set to 'm', we encountered an ld.lld error during the build process:
> >
> > 	ld.lld: error: undefined symbol: backlight_device_get_by_name
> > 	>>> referenced by intel_backlight.c:955
> > 	>>>               vmlinux.o:(intel_backlight_device_register)
> >
> > 	ld.lld: error: undefined symbol: backlight_device_register
> > 	>>> referenced by intel_backlight.c:971
> > 	>>>               vmlinux.o:(intel_backlight_device_register)
> >
> > 	ld.lld: error: undefined symbol: backlight_device_unregister
> > 	>>> referenced by intel_backlight.c:999
> > 	>>>               vmlinux.o:(intel_backlight_device_unregister)
> >
> > This issue occurred because intel_backlight_device_register and
> > intel_backlight_device_unregister were enclosed within
> > However, according to Kconfig, CONFIG_DRM_I915 will select
> > BACKLIGHT_CLASS_DEVICE only if ACPI is enabled.
> > This led to an error, which can be resolved by removing the
> > conditional statements related to ACPI.
> 
> The real fix is to use
> 
> 	depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=n
it works.
> 
> but in order to do that, you need to change a lot of places to depend
Why, what are the other places?
> on, not select BACKLIGHT_CLASS_DEVICE, because otherwise you end up with
got it.
> other dependency issues.
> 
> BR,
> Jani.
> 
> >
> > Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> > ---
> >  drivers/gpu/drm/i915/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> > index 01b5a8272a27..5003de921bf7 100644
> > --- a/drivers/gpu/drm/i915/Kconfig
> > +++ b/drivers/gpu/drm/i915/Kconfig
> > @@ -24,7 +24,7 @@ config DRM_I915
> >  	select IRQ_WORK
> >  	# i915 depends on ACPI_VIDEO when ACPI is enabled
> >  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> > -	select BACKLIGHT_CLASS_DEVICE if ACPI
> > +	select BACKLIGHT_CLASS_DEVICE
> >  	select INPUT if ACPI
> >  	select X86_PLATFORM_DEVICES if ACPI
> >  	select ACPI_WMI if ACPI
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
