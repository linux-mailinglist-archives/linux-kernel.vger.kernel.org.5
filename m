Return-Path: <linux-kernel+bounces-102293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A771987B040
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2C1F2E2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16065E03;
	Wed, 13 Mar 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTzFQs0Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44A65BD2;
	Wed, 13 Mar 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351894; cv=none; b=CJtsaT1F1Mce312vX9EpcGNkHJqJruvHLOdkhNaHlIgWZ7GmIlIkVAWoW3USAb6RRgbgd/JDxsoclbyxyzXTFm7Ls0ROv5Q01dQahzr6qJiltkzU64vZXNgPTFYQ6rHC2B/vRF2VFvXmVt2ZS0/na9mp0g5fD/ZPN92LNQDeZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351894; c=relaxed/simple;
	bh=snurulzlDN4Ny/Eh/TcrzMw8nBsgd68TmZEwbHjyupM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kx8RKtyK8cItE17HKpbcpQ+NZy9WBIIBA2l9GwAmA+bumK19VVhvER7PlPwIN9MdrXPLfow8yXo+5vuF6MqvNsQOTjPaTk3N8dH6Dm8ffKuTPh5fsGdxEGDYOk5A1fUXq9opT7XDchILPckLs+lWPUgsnIQc+q09lUbNY6jkKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTzFQs0Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710351893; x=1741887893;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=snurulzlDN4Ny/Eh/TcrzMw8nBsgd68TmZEwbHjyupM=;
  b=eTzFQs0Z47E2L6/lG4OkuPJwjxYlpjEOP9wKQFG9nnuXROSoloYrJMI4
   Sr23WV7lARBQ9Y7S7G7UC/7ajbtJv/LrCtj+8sbH/QtOYF3I/F6/vetZe
   D60zOYigbKjnEJVCendAAIvONUX06dHYHVi047B1/CADfsbE8X+SCA8K6
   WNB6azF1fpWJnTtD7y+4SbV8T+W6bthCdwEM+97Z1bPhUEsnUZowjRq4S
   FQsrnN382g2eCCOP+YKKfIOh2/9CR/whHywPZfOPi/swE4k/JCVXi+qti
   2CGFyROSgEiYHPPQgOMWyfHtkP5gGLZJe8upjcYKLyKtXRActDAYGdKjA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="27614271"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="27614271"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="49432678"
Received: from jbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:44:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathon Hall <jonathon.hall@puri.sm>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 rodrigo.viv@intel.com, tursulin@ursulin.net
Cc: Jonathon Hall <jonathon.hall@puri.sm>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Do not match JSL in
 ehl_combo_pll_div_frac_wa_needed()
In-Reply-To: <20240313135424.3731410-1-jonathon.hall@puri.sm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240313135424.3731410-1-jonathon.hall@puri.sm>
Date: Wed, 13 Mar 2024 19:44:46 +0200
Message-ID: <8734surppt.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 13 Mar 2024, Jonathon Hall <jonathon.hall@puri.sm> wrote:
> Since commit 0c65dc062611 ("drm/i915/jsl: s/JSL/JASPERLAKE for
> platform/subplatform defines"), boot freezes on a Jasper Lake tablet
> (Librem 11), usually with graphical corruption on the eDP display,
> but sometimes just a black screen.  This commit was included in 6.6 and
> later.
>
> That commit was intended to refactor EHL and JSL macros, but the change
> to ehl_combo_pll_div_frac_wa_needed() started matching JSL incorrectly
> when it was only intended to match EHL.
>
> It replaced:
> 	return ((IS_PLATFORM(i915, INTEL_ELKHARTLAKE) &&
> 		 IS_JSL_EHL_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
> with:
> 	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
> 		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
>
> Remove IS_JASPERLAKE() to fix the regression.
>
> Signed-off-by: Jonathon Hall <jonathon.hall@puri.sm>
> Cc: stable@vger.kernel.org

Thanks for the patch!

Fixes: 0c65dc062611 ("drm/i915/jsl: s/JSL/JASPERLAKE for platform/subplatform defines")
Cc: <stable@vger.kernel.org> # v6.6+
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index ef57dad1a9cb..57a97880dcb3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -2509,7 +2509,7 @@ static void icl_wrpll_params_populate(struct skl_wrpll_params *params,
>  static bool
>  ehl_combo_pll_div_frac_wa_needed(struct drm_i915_private *i915)
>  {
> -	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
> +	return ((IS_ELKHARTLAKE(i915) &&
>  		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
>  		 IS_TIGERLAKE(i915) || IS_ALDERLAKE_S(i915) || IS_ALDERLAKE_P(i915)) &&
>  		 i915->display.dpll.ref_clks.nssc == 38400;

-- 
Jani Nikula, Intel

