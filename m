Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01D7D372E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjJWMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:49:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5141CC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698065389; x=1729601389;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/06vn1FESH5ehRnRfIJp0ycCvwF0E4N5zV1BYkmcMd4=;
  b=CJJVLVyjaTpj4HilA1vY97URbnmZ4YaCpmzNmvqBHGPtzwFbJ1DQGa9v
   jX9bBWiZmUhsM90fNB+SgcutaUeNU59GNtR/0OMDSCTPP1MlY/+8xxB8W
   9/1O3tgjK7lnr+peywHmLoAn5Kcw+QyJekhc4qMKwNrusHcwlGCzdB3t7
   D6rvcTlqI/TN2aRNtUs8GgVvA5ZWrfMIZuxpv0eEo761LlahrGNVfJyc+
   N14GwjeXOzXsWsgiZcPRDhvwz/D+OT6r4SCMb5wIy7QSAGHBX0BJhJQMa
   byeCrrqFohpVz42TEy/x/xfPwj4bTKuesIkyZBjHa0OyVCU3dEfkqhqrR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385715728"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="385715728"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="761731237"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="761731237"
Received: from evlad-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.180])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:49:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matt Roper <matthew.d.roper@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/mtl: avoid stringop-overflow warning
In-Reply-To: <20231016201012.1022812-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231016201012.1022812-1-arnd@kernel.org>
Date:   Mon, 23 Oct 2023 15:49:41 +0300
Message-ID: <87edhlbj16.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added memset() causes a warning for some reason I could not figure out:
>
> In file included from arch/x86/include/asm/string.h:3,
>                  from drivers/gpu/drm/i915/gt/intel_rc6.c:6:
> In function 'rc6_res_reg_init',
>     inlined from 'intel_rc6_init' at drivers/gpu/drm/i915/gt/intel_rc6.c:610:2:
> arch/x86/include/asm/string_32.h:195:29: error: '__builtin_memset' writing 16 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
>   195 | #define memset(s, c, count) __builtin_memset(s, c, count)
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gt/intel_rc6.c:584:9: note: in expansion of macro 'memset'
>   584 |         memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
>       |         ^~~~~~
> In function 'intel_rc6_init':
>
> Change it to an normal initializer and an added memcpy() that does not have
> this problem.
>
> Fixes: 4bb9ca7ee0745 ("drm/i915/mtl: C6 residency and C state type for MTL SAMedia")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/gt/intel_rc6.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
> index 8b67abd720be8..7090e4be29cb6 100644
> --- a/drivers/gpu/drm/i915/gt/intel_rc6.c
> +++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
> @@ -581,19 +581,23 @@ static void __intel_rc6_disable(struct intel_rc6 *rc6)
>  
>  static void rc6_res_reg_init(struct intel_rc6 *rc6)
>  {
> -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));

That's just bollocks. memset() is byte granularity, while
INVALID_MMIO_REG.reg is u32. If the value was anything other than 0,
this would break.

And you're not supposed to look at the guts of i915_reg_t to begin with,
that's why it's a typedef. Basically any code that accesses the members
of i915_reg_t outside of its implementation are doing it wrong.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> +	i915_reg_t res_reg[INTEL_RC6_RES_MAX] = {
> +		[0 ... INTEL_RC6_RES_MAX - 1] = INVALID_MMIO_REG,
> +	};
>  
>  	switch (rc6_to_gt(rc6)->type) {
>  	case GT_MEDIA:
> -		rc6->res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
> +		res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
>  		break;
>  	default:
> -		rc6->res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
> -		rc6->res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
> -		rc6->res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
> -		rc6->res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
> +		res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
> +		res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
> +		res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
> +		res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
>  		break;
>  	}
> +
> +	memcpy(rc6->res_reg, res_reg, sizeof(res_reg));
>  }
>  
>  void intel_rc6_init(struct intel_rc6 *rc6)

-- 
Jani Nikula, Intel
