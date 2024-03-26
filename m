Return-Path: <linux-kernel+bounces-119906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C564488CEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E8327FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F713D8B5;
	Tue, 26 Mar 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZhv01Iv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA313D884;
	Tue, 26 Mar 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484710; cv=none; b=gdwLGzzsjtVbvxC8GQVJhC73R5wwErmbwmxxZK63GtSRNWqNTxTiEySrmLmPYYkhelioq4WCvHw0cPncc/jDxiAKqVJ4Wq2TCKXtRrj8xWjMd3kmGk4Z8/3It37yApfZYsVHf8GTCo2mrkGgPTOwgLNu9Vl1f2VEiBGCiIpPMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484710; c=relaxed/simple;
	bh=WKb/Rem+q45UacCFCZyCwdPQfAxbGriai4/va9sGbT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a8vDJbI6ug2Us6/ZqPQOAlCCkul/4UY2a48FMCIQc5bD+5UH79D7uuTlY3RXuI6mTur5nAcBK1FDQToO1+7j+iAtkgbSBRIV5AzjrJA57bnGcLuuuRR0RMBKMXmwg56Yb8hXsC63kQTh4B07EORxTmB0Eg3clKexgELXZKQ1mtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZhv01Iv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484708; x=1743020708;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WKb/Rem+q45UacCFCZyCwdPQfAxbGriai4/va9sGbT0=;
  b=eZhv01IvqK5o3TO6SV2inbylGEDga5EEtjioNIhJBOKo6gtWE10t9wEM
   YCpjNrWWWrHZS6QlIHI/WH36y0U0HwI5psXCNJRddArmE3Y3Ou1jzk6uf
   7dJNXEcfcTtjMfNlD6S5aimJ+Ipn3bHioLefvmnUAN9b6s6QVs+LMgW/v
   lxkdaOVb90PZ4k/N2WvHMHNN4CBJHDmfIQ6Mdk2vUumJw/3j8sK5+DJ1T
   GihES4wQJWXQiCZF7qdJ7ytP9QENwuzS8laRio/mcQiPy/qJsH/+kt2vi
   QhS3La70w6ow/sK9jeWwEpisEEsmBtchDrsI/OTIwSeoKIbzard8gzZ5x
   w==;
X-CSE-ConnectionGUID: WE1rGxAhQt6KYakS5sVGow==
X-CSE-MsgGUID: iGBTkGOTRNCHOGOT4RBzeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17288128"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="17288128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16509223"
Received: from eldobson-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.55.140])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:24:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org, Masahiro
 Yamada <masahiroy@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Linus Walleij <linus.walleij@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more
 consistent
In-Reply-To: <20240326144741.3094687-2-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326144741.3094687-2-arnd@kernel.org>
Date: Tue, 26 Mar 2024 22:24:55 +0200
Message-ID: <87jzlohhbc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 26 Mar 2024, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The -Woverride-init warn about code that may be intentional or not,
> but the inintentional ones tend to be real bugs, so there is a bit of
> disagreement on whether this warning option should be enabled by default
> and we have multiple settings in scripts/Makefile.extrawarn as well as
> individual subsystems.
>
> Older versions of clang only supported -Wno-initializer-overrides with
> the same meaning as gcc's -Woverride-init, though all supported versions
> now work with both. Because of this difference, an earlier cleanup of
> mine accidentally turned the clang warning off for W=1 builds and only
> left it on for W=2, while it's still enabled for gcc with W=1.
>
> There is also one driver that only turns the warning off for newer
> versions of gcc but not other compilers, and some but not all the
> Makefiles still use a cc-disable-warning conditional that is no
> longer needed with supported compilers here.
>
> Address all of the above by removing the special cases for clang
> and always turning the warning off unconditionally where it got
> in the way, using the syntax that is supported by both compilers.
>
> Fixes: 2cd3271b7a31 ("kbuild: avoid duplicate warning options")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce112/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce120/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce60/Makefile  |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce80/Makefile  |  2 +-
>  drivers/gpu/drm/i915/Makefile                  |  6 +++---
>  drivers/gpu/drm/xe/Makefile                    |  4 ++--
>  drivers/net/ethernet/renesas/sh_eth.c          |  2 +-
>  drivers/pinctrl/aspeed/Makefile                |  2 +-
>  fs/proc/Makefile                               |  2 +-
>  kernel/bpf/Makefile                            |  2 +-
>  mm/Makefile                                    |  3 +--
>  scripts/Makefile.extrawarn                     | 10 +++-------
>  13 files changed, 18 insertions(+), 23 deletions(-)
>

[snip]

> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 3ef6ed41e62b..4c2f85632391 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -33,9 +33,9 @@ endif
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>  # Fine grained warnings disable
> -CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
> -CFLAGS_display/intel_display_device.o = $(call cc-disable-warning, override-init)
> -CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
> +CFLAGS_i915_pci.o = -Wno-override-init
> +CFLAGS_display/intel_display_device.o = -Wno-override-init
> +CFLAGS_display/intel_fbdev.o = -Wno-override-init
>  
>  # Support compiling the display code separately for both i915 and xe
>  # drivers. Define I915 when building i915.
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 5a428ca00f10..c29a850859ad 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -172,8 +172,8 @@ subdir-ccflags-$(CONFIG_DRM_XE_DISPLAY) += \
>  	-Ddrm_i915_gem_object=xe_bo \
>  	-Ddrm_i915_private=xe_device
>  
> -CFLAGS_i915-display/intel_fbdev.o = $(call cc-disable-warning, override-init)
> -CFLAGS_i915-display/intel_display_device.o = $(call cc-disable-warning, override-init)
> +CFLAGS_i915-display/intel_fbdev.o = -Wno-override-init
> +CFLAGS_i915-display/intel_display_device.o = -Wno-override-init

For i915 and xe parts,

Acked-by: Jani Nikula <jani.nikula@intel.com>

>  # Rule to build SOC code shared with i915
>  $(obj)/i915-soc/%.o: $(srctree)/drivers/gpu/drm/i915/soc/%.c FORCE
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 475e1e8c1d35..0786eb0da391 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -50,7 +50,7 @@
>   * the macros available to do this only define GCC 8.
>   */
>  __diag_push();
> -__diag_ignore(GCC, 8, "-Woverride-init",
> +__diag_ignore_all("-Woverride-init",
>  	      "logic to initialize all and then override some is OK");

This is nice because it's more localized than the per-file
disable. However, we tried to do this in i915, but this doesn't work for
GCC versions < 8, and some defconfigs enabling -Werror forced us to
revert. See commit 290d16104575 ("Revert "drm/i915: use localized
__diag_ignore_all() instead of per file"").

BR,
Jani.


-- 
Jani Nikula, Intel

