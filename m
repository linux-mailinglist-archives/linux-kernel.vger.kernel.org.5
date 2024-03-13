Return-Path: <linux-kernel+bounces-101304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22687A54A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975122823B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BD383BA;
	Wed, 13 Mar 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2CGP3/z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88030381D5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323603; cv=none; b=UT5Wr9/Wwv4yECMVaRtM0PSfgsoec/z9l/MV0rYmg4tnqTPQFsWBUAjlWsf6U+pD5awUeF6kNel3+S63gcqt6Nn+dvgbAVeg7nAkrN09Vz9CYqzmIG3Dr6TAJz9J/u76z+Tx3H3G/8xVEQhMqbXBCu5Yw+u8PsCFnobxxUMP/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323603; c=relaxed/simple;
	bh=MHm9FFtBz7Eh6MOhx4kKxazsP44RUIvwo8+ERZRUVmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUWlmCfDFsC4SOq9NWqduG7Ia9esEGU9IZEwKI1J7z/CpoFNT7mCrs9QaBYq9GdEieaW+P+XDOA8yPSu7wb7YFQ5mxdoKyR5Y+E1KO5Fqv9SGM/mZF9wE73UBxiAqzIMclBYgTW3+JVcFG3c5CRxC0r/XS+1g6A3p2Gg7cG6rSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2CGP3/z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710323601; x=1741859601;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MHm9FFtBz7Eh6MOhx4kKxazsP44RUIvwo8+ERZRUVmw=;
  b=i2CGP3/za5AN29FxTCKQDSok160K3hdnzH/TpyBi9oJNTQ9Yz2Iz+Tg4
   ZmLXD6ImT/PsLRGMMmNntIV26TCC2d1O7sy2lEaXxgnXipP34U71ibNPc
   R2CBIIlyLTbbZqctgazNDIZwqul3QWGomko4cIvi51GTkHk+DYxWgsya+
   aYDH1tZTPse5mh9qcKezWd/udaRhbTq391qFe7CM2JXh4CqPakPEtbMm1
   iJpIoH7aG1LPUFmFX+XgT+7Z62bRaLLWd8skn9/HEz6LVXCAw8t4EsSn/
   vO/txO/Zcs0T4nO+uUTd2CSm1gFLc1jlGS3Zqq2/KpawbudZilLV3EEHK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5201263"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5201263"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16436868"
Received: from jbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.28])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:53:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Imre Deak <imre.deak@intel.com>, Nirmoy
 Das <nirmoy.das@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: add intel_opregion_vbt_present() stub function
In-Reply-To: <20240313084735.3305424-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240313084735.3305424-1-arnd@kernel.org>
Date: Wed, 13 Mar 2024 11:53:14 +0200
Message-ID: <87bk7isbjp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 13 Mar 2024, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added function is not available without CONFIG_ACPI, causing
> a build failure:
>
> drivers/gpu/drm/i915/display/intel_bios.c:3424:24: error: implicit declaration of function 'intel_opregion_vbt_present'; did you mean 'intel_opregion_asle_present'? [-Werror=implicit-function-declaration]
>
> Add an empty stub in the same place as the other stubs.
>
> Fixes: 9d9bb71f3e11 ("drm/i915: Extract opregion vbt presence check")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, but just applied the identical [1].

BR,
Jani.


[1] https://lore.kernel.org/r/20240312115757.683584-1-jani.nikula@intel.com

> ---
>  drivers/gpu/drm/i915/display/intel_opregion.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_opregion.h b/drivers/gpu/drm/i915/display/intel_opregion.h
> index 63573c38d735..4b2b8e752632 100644
> --- a/drivers/gpu/drm/i915/display/intel_opregion.h
> +++ b/drivers/gpu/drm/i915/display/intel_opregion.h
> @@ -120,6 +120,11 @@ intel_opregion_get_edid(struct intel_connector *connector)
>  	return NULL;
>  }
>  
> +static inline bool intel_opregion_vbt_present(struct drm_i915_private *i915)
> +{
> +	return false;
> +}
> +
>  static inline const void *
>  intel_opregion_get_vbt(struct drm_i915_private *i915, size_t *size)
>  {

-- 
Jani Nikula, Intel

