Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5F76CA6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHBKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjHBKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:04:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5919B9;
        Wed,  2 Aug 2023 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690970688; x=1722506688;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PzZF7rmesK94EuU0OFUxjXjzDJ2Wb9i4El3T2lkjt20=;
  b=OcBDq3yaG6IfKHn/iFhm/lYjfncbHCnIs3LLtDXI53dqr3CC+zuz2s47
   mNNQQzIaz63Rt+LOGqZDQ4jYhFPYKB4f5GvFWgG7MWKVP2Xixw6qYdmVc
   GVs/BCSCjw3rL9eSg7bRPkzZoD2FfqdWKGSwJCwhBOJZGOgPlr3elBIH0
   82/fwavfaP4NUAXzOzR981WLxcSreVc/B565zQGYfbcGogI8Crf5buM54
   9xRU9BAMN+tTaX2VXPteJ2z9SWfCxnffgMtvh/uHw2oNDseHVmHHfu5hl
   Tj5bNBIL1ngMdnAcEsGdWoXO0tNYq+dtekuwk8g7eSlU7WP2x0riwSaRk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="367001579"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="367001579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="679014600"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="679014600"
Received: from osalyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.215])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:04:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ziqi Zhao <astrajoan@yahoo.com>,
        syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com,
        astrajoan@yahoo.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ivan.orlov0322@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        skhan@linuxfoundation.org, tzimmermann@suse.de
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        jacob.e.keller@intel.com, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] drm/modes: Fix division by zero error
In-Reply-To: <20230801215538.105255-1-astrajoan@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <00000000000034cf5d05fea52dd4@google.com>
 <20230801215538.105255-1-astrajoan@yahoo.com>
Date:   Wed, 02 Aug 2023 13:04:39 +0300
Message-ID: <87sf91vjyg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023, Ziqi Zhao <astrajoan@yahoo.com> wrote:
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

Come to think of it, maybe the subject should mention "fix overflow"
instead, but no biggie.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
> V1 -> V2: address style comments suggested by Jani Nikula
> <jani.nikula@linux.intel.com>
>
>  drivers/gpu/drm/drm_modes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index ac9a406250c5..137101960690 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1285,13 +1285,13 @@ EXPORT_SYMBOL(drm_mode_set_name);
>   */
>  int drm_mode_vrefresh(const struct drm_display_mode *mode)
>  {
> -	unsigned int num, den;
> +	u64 num, den;
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
> +	if (unlikely(den > UINT_MAX))
> +		return DIV64_U64_ROUND_CLOSEST(num, den);
> +
> +	return DIV_ROUND_CLOSEST_ULL(num, (u32) den);
>  }
>  EXPORT_SYMBOL(drm_mode_vrefresh);

-- 
Jani Nikula, Intel Open Source Graphics Center
