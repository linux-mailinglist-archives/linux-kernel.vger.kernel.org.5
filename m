Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529EB76E493
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjHCJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjHCJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:35:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79463ABA;
        Thu,  3 Aug 2023 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691055355; x=1722591355;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=N5jGfZQ8A78DMSVEz0/KZZUx/pejQfPJtpi3xQENQBE=;
  b=ag5NWUCTxvo0KsTNEcexyZhuGyKd5Q9hczQDqb2kxMAT6m+GaMXttymq
   /pPCy1EShT896NHVGOooXdPoRuh6FrD1mtgpzefilE/+RODtjG8owBG0S
   xYecKTEq4VBhjKsLjkKyZb5n4q/cJPaMButY7Uh+7B/t60MrZGEFn4tXt
   flNj0rLiFg9hyd5qdmG2cM5uyhmjQctn48pxnci/hwi+JJK2AQjOCrfM0
   wWFoun/S5TK2FdRQVODrwu+yl57m4JZpf46dv6ZhLCFdZwzjE+QA5KMER
   vJ9vhe8jat5a87PozeVlhezNIVUhfIBCEnRfOPFU9q7mrQs9LFCDWHenB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433664741"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="433664741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 02:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729502060"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="729502060"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 02:35:49 -0700
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
Subject: Re: [PATCH v3] drm/modes: Fix division by zero due to overflow
In-Reply-To: <20230802174746.2256-1-astrajoan@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <00000000000034cf5d05fea52dd4@google.com>
 <20230802174746.2256-1-astrajoan@yahoo.com>
Date:   Thu, 03 Aug 2023 12:35:47 +0300
Message-ID: <87bkfov570.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023, Ziqi Zhao <astrajoan@yahoo.com> wrote:
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

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> V1 -> V2: address style comments suggested by Jani Nikula
> <jani.nikula@linux.intel.com>
> V2 -> V3: change title to include context on overflow causing the
> division by zero
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
