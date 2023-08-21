Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A5782435
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHUHNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHUHNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:13:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4CB1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692602011; x=1724138011;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=av4oCu9sjI/1tXAcnOs+Fnjxj3bZRnRW6Vu6VY0dHhA=;
  b=Xv98Ole8Ak09pG71wF9lFpPnOduy90+01jkUlaTc08wz9sWoSxQr+ODY
   6tmTJoMhUCq6O5vmvFsG3glr/51KRFUPUNwdqiPtHdOYh/qVLU/0EbHpc
   pxhxfK1fmdVVsxuOisUTjG/icdynPug57ZHbODnauJNN/ltRZrFJKSJbN
   IUOD1SESzSXkrNPnvurtaQHamH/lD+NdcAH+sRuxgFfu4XWaHQP5UaAJz
   MFDkP6PA6sgOdZZLtJ3SUqWjUrNd1e1J7eLXEKhoGfe39htWQ1TAzevG2
   iKg00HWvR7xHq0n50nIP3LFi30BEIdWqBDHvbpnpMbm/BMvOsasn381k4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="437437554"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="437437554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 00:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738801231"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="738801231"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 00:13:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     ZNdOoHvIg7HXh7Gg@fedora,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     stone.xulei@xfusion.com
Subject: Re: [Intel-gfx] [PATCH v3] drm/i915: Fix Kconfig error for
 CONFIG_DRM_I915
In-Reply-To: <ZOII3e9nsnmRjTN+@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ZOII3e9nsnmRjTN+@fedora>
Date:   Mon, 21 Aug 2023 10:13:15 +0300
Message-ID: <87wmxo7tro.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023, Wang Jinchao <wangjinchao@xfusion.com> wrote:
> When CONFIG_DRM_I915 is set to 'y' and CONFIG_BACKLIGHT_CLASS_DEVICE
> is set to 'm', we encountered an ld.lld error during the build process:
>
> 	ld.lld: error: undefined symbol: backlight_device_get_by_name
> 	>>> referenced by intel_backlight.c:955
> 	>>>               vmlinux.o:(intel_backlight_device_register)
>
> 	ld.lld: error: undefined symbol: backlight_device_register
> 	>>> referenced by intel_backlight.c:971
> 	>>>               vmlinux.o:(intel_backlight_device_register)
>
> 	ld.lld: error: undefined symbol: backlight_device_unregister
> 	>>> referenced by intel_backlight.c:999
> 	>>>               vmlinux.o:(intel_backlight_device_unregister)
>
> This issue occurred because intel_backlight_device_register and
> intel_backlight_device_unregister were enclosed within
> \#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) and #endif directives.
> However, according to Kconfig, CONFIG_DRM_I915 will select
> BACKLIGHT_CLASS_DEVICE only if ACPI is enabled.
> This led to an error when ACPI is not enabled.
> Change IS_ENABLED to IS_REACHABLE and use IS_REACHABLE to encompass
> the implementation of intel_connector_register() to solve this issue.

I told you in [1] what the real fix is.

The IS_REACHABLE() solution has been suggested a number of times, but I
think it's creating an unexpected and silent failure configuration. I
think IS_REACHABLE() is the wrong thing to do in most cases.

BR,
Jani.


[1] https://lore.kernel.org/r/87o7jaythm.fsf@intel.com


>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 2e8f17c04522..d812cdc74a84 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -795,7 +795,7 @@ void intel_backlight_enable(const struct intel_crtc_state *crtc_state,
>  	mutex_unlock(&i915->display.backlight.lock);
>  }
>  
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  static u32 intel_panel_get_backlight(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *i915 = to_i915(connector->base.dev);
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
> index 339643f63897..207fe1c613d8 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.h
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.h
> @@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 leve
>  u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
>  u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
>  
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  int intel_backlight_device_register(struct intel_connector *connector);
>  void intel_backlight_device_unregister(struct intel_connector *connector);
>  #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */

-- 
Jani Nikula, Intel Open Source Graphics Center
