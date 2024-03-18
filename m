Return-Path: <linux-kernel+bounces-105974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173C87E703
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57A41F2236A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6C2E657;
	Mon, 18 Mar 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2LACVw0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF52E645;
	Mon, 18 Mar 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756810; cv=none; b=on6lHRbSH/qYsuW7nSex42wgScwX2ou8+kK94IfVWYWpVIZqQ0UH1Bt7DJMF0GPaQv/fX0yQNP8s+7/dNvmcquCGfDIAYQagFTt0z+Q2DEN2ZraUrnmi6Z0Rih45HYByss3r6ntarK6IbhcX0goQ3o+1Igh9v1iqSjav3VUOmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756810; c=relaxed/simple;
	bh=YuBokLpt2t+vNks6qSZcV6BYmfskihW1wCZc6NHW73I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTgPrQRLgVtlsgS62rhUlb2xw370tlmD765GLMAalMcGj25RJi0oXY5t+V6TaOnjXrQ1xbxQuAKJ8MRi7Qw7lrleJUJDfwwHUR92akGGx35TWBtqhqKJiKuXpPptiUjbkgUJFQgJa3Jcfbh51HxPObUeHxgor2YL8eFMiZEhTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2LACVw0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710756808; x=1742292808;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YuBokLpt2t+vNks6qSZcV6BYmfskihW1wCZc6NHW73I=;
  b=j2LACVw0e52EsPQvtFKCQ0gp6uckxtX81CuV+mqAI55Nm+tyhhKOiK0e
   98S7fViVG6DfHMQMmQEtUlj+Vp/pIeYv+++C9lvDbCG8BTd+zOvEMkTC2
   1gPHEL3FOOFDOnP2aqPsH9UhwHHHm9frUjePAm1aKX7WNnEMiWz+sdtNS
   K0lqXh+gA/tKKqnyq5E29Rk9UEw2+q6S+f/fChdQmzlj7tQCGDa37aotN
   EW9kdYyme4z9Rfl7yrokHdP/ie5yVa0bj7vQ2LyXolZL6FwXPZjP1kllz
   nA+QQ6mBvuWqdd640VrCNM4vnum2rntfOKsLELS3ZRD1/XrOgUO98cBa+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16281768"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16281768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17911351"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:13:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathon Hall <jonathon.hall@puri.sm>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net
Cc: Jonathon Hall <jonathon.hall@puri.sm>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Do not match JSL in
 ehl_combo_pll_div_frac_wa_needed()
In-Reply-To: <8734surppt.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240313135424.3731410-1-jonathon.hall@puri.sm>
 <8734surppt.fsf@intel.com>
Date: Mon, 18 Mar 2024 12:13:22 +0200
Message-ID: <87zfuvq24d.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 13 Mar 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 13 Mar 2024, Jonathon Hall <jonathon.hall@puri.sm> wrote:
>> Since commit 0c65dc062611 ("drm/i915/jsl: s/JSL/JASPERLAKE for
>> platform/subplatform defines"), boot freezes on a Jasper Lake tablet
>> (Librem 11), usually with graphical corruption on the eDP display,
>> but sometimes just a black screen.  This commit was included in 6.6 and
>> later.
>>
>> That commit was intended to refactor EHL and JSL macros, but the change
>> to ehl_combo_pll_div_frac_wa_needed() started matching JSL incorrectly
>> when it was only intended to match EHL.
>>
>> It replaced:
>> 	return ((IS_PLATFORM(i915, INTEL_ELKHARTLAKE) &&
>> 		 IS_JSL_EHL_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
>> with:
>> 	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
>> 		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
>>
>> Remove IS_JASPERLAKE() to fix the regression.
>>
>> Signed-off-by: Jonathon Hall <jonathon.hall@puri.sm>
>> Cc: stable@vger.kernel.org
>
> Thanks for the patch!
>
> Fixes: 0c65dc062611 ("drm/i915/jsl: s/JSL/JASPERLAKE for platform/subplatform defines")
> Cc: <stable@vger.kernel.org> # v6.6+
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-intel-next.

BR,
Jani.


>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> index ef57dad1a9cb..57a97880dcb3 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> @@ -2509,7 +2509,7 @@ static void icl_wrpll_params_populate(struct skl_wrpll_params *params,
>>  static bool
>>  ehl_combo_pll_div_frac_wa_needed(struct drm_i915_private *i915)
>>  {
>> -	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
>> +	return ((IS_ELKHARTLAKE(i915) &&
>>  		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
>>  		 IS_TIGERLAKE(i915) || IS_ALDERLAKE_S(i915) || IS_ALDERLAKE_P(i915)) &&
>>  		 i915->display.dpll.ref_clks.nssc == 38400;

-- 
Jani Nikula, Intel

