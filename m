Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBC7F4153
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjKVJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:15:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87720D50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700644507; x=1732180507;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RrwEo1VDHhlnf+Pa2Ly1JESTxjciztMmCHm/k/NWo+I=;
  b=IljyKAstK43LvtP3ihmH3gkFd9kZgSd220EieD2c1uV3u3TeDqbPLDeP
   EkdXpDwYuFrhA2aAgBfW5mRfa8H60jcarjXXdC/EwQyJjg15e+8vZRDdK
   e2mlC+GyqxK9GhM2BUCqbXLtsIzmK9PIrhcJgYqyhZgRwCbuDvC3RXxEe
   3rQ/U9hnr8DoUBtPt6GHeGeuzY1swdnX+U5LRfcvJG/AGMtfSZEzkBO76
   8ZEUiJiVdJYoyKhSApVAyujyWawagQheI4+8m65v4F/yLJBz5U2ZhDer/
   0cuZb3qj9Wztsabn0JL1WoZXsaHxAmSwnevQ4NTQeN7R738QgTmU7fIGK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5158989"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5158989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098335938"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1098335938"
Received: from tjquresh-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:14:59 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Mika Kahola <mika.kahola@intel.com>
Subject: Re: [PATCH] drm/i915/psr: Fix unsigned expression compared with zero
In-Reply-To: <20231122085239.89046-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231122085239.89046-1-jiapeng.chong@linux.alibaba.com>
Date:   Wed, 22 Nov 2023 11:14:57 +0200
Message-ID: <87y1eqm9ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> The entry_setup_frames is defined as u8 type, else(entry_setup_frames < 0)
> is invalid. At the same time, the return value of function
> intel_psr_entry_setup_frames is also of type int. so modified
> its type to int.
>
> ./drivers/gpu/drm/i915/display/intel_psr.c:1336:5-23: WARNING: Unsigned expression compared with zero: entry_setup_frames >= 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7610
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

There's already a patch. Mika, please follow up with it.

https://patchwork.freedesktop.org/patch/msgid/20231116090512.480373-1-mika.kahola@intel.com

> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 8d180132a74b..204da50e3f28 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -1319,7 +1319,7 @@ static bool _psr_compute_config(struct intel_dp *intel_dp,
>  {
>  	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
>  	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
> -	u8 entry_setup_frames;
> +	int entry_setup_frames;
>  
>  	/*
>  	 * Current PSR panels don't work reliably with VRR enabled

-- 
Jani Nikula, Intel
