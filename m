Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31C476ADB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjHAJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHAJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:31:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260330FC;
        Tue,  1 Aug 2023 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690882209; x=1722418209;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+ZeJP/xkyI2kTZxoz/E3PvGR0Hq4tjVxJSVN6RH3DV8=;
  b=naRWqOLqdQwUa+Xp6A2dfSC8+UUimTc+StMR/A/RyWErR+h2gxTyTNIV
   tHqOxQajXPeLKbsvXo05PnmMp6k9WWb7SCMo1nxxdpGvUtL920SrEZ/Mn
   ARXdS0g6/KOhFV44tW37z4G5NwmMGWBC3WmBPwM7bAzXki0cqzDDpFkf2
   266fQdxRFu93SH6U7KODTMTLa781rT9dPaN/lyjFInPq/C5TJGhVyPGwj
   n7oCNjpG0AcV7zCLcU7FgQN34yukkESfZPsGQxSTe1+Ep7FgPPX35vYxr
   P4uX35dXi0/a56adLu4iPNTXWhV8f6G74KX858vfKQ+Ii4DybhznA7Rru
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371961912"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="371961912"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 02:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798596374"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798596374"
Received: from igorban-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.36.188])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 02:30:02 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ziqi Zhao <astrajoan@yahoo.com>, astrajoan@yahoo.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ivan.orlov0322@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        skhan@linuxfoundation.org, tzimmermann@suse.de
Cc:     netdev@vger.kernel.org, dsahern@kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, jiri@nvidia.com, jacob.e.keller@intel.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/modes: Fix division by zero error
In-Reply-To: <20230721160749.8489-1-astrajoan@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230709011213.17890-1-astrajoan@yahoo.com>
 <20230721160749.8489-1-astrajoan@yahoo.com>
Date:   Tue, 01 Aug 2023 12:30:00 +0300
Message-ID: <87o7jrw1nr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023, Ziqi Zhao <astrajoan@yahoo.com> wrote:
> In the bug reported by Syzbot, the variable `den == (1 << 22)` and
> `mode->vscan == (1 << 10)`, causing the multiplication to overflow and
> accidentally make `den == 0`. To prevent any chance of overflow, we
> replace `num` and `den` with 64-bit unsigned integers, and explicitly
> check if the divisor `den` will overflow. If so, we employ full 64-bit
> division with rounding; otherwise we keep the 64-bit to 32-bit division
> that could potentially be better optimized.
>
> In order to minimize the performance overhead, the overflow check for
> `den` is wrapped with an `unlikely` condition. Please let me know if
> this usage is appropriate.
>
> Reported-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---
>  drivers/gpu/drm/drm_modes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index ac9a406250c5..aa98bd7b8bc9 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1285,13 +1285,13 @@ EXPORT_SYMBOL(drm_mode_set_name);
>   */
>  int drm_mode_vrefresh(const struct drm_display_mode *mode)
>  {
> -	unsigned int num, den;
> +	unsigned long long num, den;

I think making them u64 would be more clear.

>  
>  	if (mode->htotal == 0 || mode->vtotal == 0)
>  		return 0;
>  
> -	num = mode->clock;
> -	den = mode->htotal * mode->vtotal;
> +	num = mul_u32_u32(mode->clock, 1000);
> +	den = mul_u32_u32(mode->htotal, mode->vtotal);
>  
>  	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>  		num *= 2;
> @@ -1300,7 +1300,10 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
>  	if (mode->vscan > 1)
>  		den *= mode->vscan;
>  
> -	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
> +	if (unlikely(den >> 32))

More intuitively, den > UINT_MAX.

> +		return div64_u64(num + (den >> 1), den);

More intuitively, DIV64_U64_ROUND_CLOSEST(num, den).

> +	else

The else after a branch with return is unnecessary. Someone's going to
send a patch to remove it later if you leave it in.

BR,
Jani.

> +		return DIV_ROUND_CLOSEST_ULL(num, (unsigned int) den);
>  }
>  EXPORT_SYMBOL(drm_mode_vrefresh);

-- 
Jani Nikula, Intel Open Source Graphics Center
