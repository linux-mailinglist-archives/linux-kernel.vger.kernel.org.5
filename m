Return-Path: <linux-kernel+bounces-36605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052E83A3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD19C294299
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE8171DD;
	Wed, 24 Jan 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7ywL5M+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04035171AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083501; cv=none; b=rPHeV13NEH3ZZBowRySKR9Q+kabwRx/7I2oSt+NG8e/Zr4vM2VLiTKph3wiUCWcnAw4UH3+o1br6eNIPh/J8ESe+eLB9ffzh3TqixqGKPQoaF5D1EdgECh5A+juM7VArCO79mHfghBlv4wRNVJGNcWWzme56B7x7zcxdI/Fu1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083501; c=relaxed/simple;
	bh=LFjrW/3gncxzl/A3TUIYstXciGL965aXTzTWUjho538=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFClTvQX/EcguWLn8NWulsr7bsxYEMeCHYHoTbEozvoK53HOFM4YQCZ5kErzavdF3VSceD6PiA34v/fJjCOrTno+QHRoUCjBXFcM+fra5TNOSvRWULzxTSRW87epTBLtbSUPf/5TZnE+G4T8cINwjqah44WTu63mjuqDXlG39AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7ywL5M+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706083499; x=1737619499;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LFjrW/3gncxzl/A3TUIYstXciGL965aXTzTWUjho538=;
  b=g7ywL5M+noTxdVisTpQfBO/tXBKHxYf6CoOo1VLCHphb529YohVqxf3M
   BgIlapwrmhMYM1TkUnvLc7yE2Bb0qTqnmJLLTU8aqZeA88O4qg4xywMsk
   KUGlexa9TtXW0WKitINhCT6L6P07KYy9RvGp1L1tM1STT+DVkJpHA7x+5
   T9Mb9/jYeni6rX91AXDUh/eQFh7FH67f6hFwpDMPsUbNUdWewbuJQhqrb
   tYQ7GFjca2Vqe58p2ihO63cqpTN7kRX/lGvWadDnfukIgc8nIDUsJQb76
   zY3ITbEfIPLnOVY3XhYtnxXUbUWQLBNI0cynCl92ug9M7RgQFTiungc7l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8425190"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8425190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1928230"
Received: from komalav-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.41.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:04:55 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Yury Norov
 <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Lucas De
 Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 3/3] drm/i915: Convert REG_GENMASK* to fixed-width
 GENMASK_*
In-Reply-To: <20240124050205.3646390-4-lucas.demarchi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-4-lucas.demarchi@intel.com>
Date: Wed, 24 Jan 2024 10:04:52 +0200
Message-ID: <87r0i7kvh7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> Now that include/linux/bits.h implements fixed-width GENMASK_*, use them
> to implement the i915/xe specific macros. Converting each driver to use
> the generic macros are left for later, when/if other driver-specific
> macros are also generalized.

With the type-specific max checks added to GENMASK_*, this would be
great.

BR,
Jani.

>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 +++------------------------
>  1 file changed, 11 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
> index a685db1e815d..52f99eb96f86 100644
> --- a/drivers/gpu/drm/i915/i915_reg_defs.h
> +++ b/drivers/gpu/drm/i915/i915_reg_defs.h
> @@ -9,76 +9,19 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  
> -/**
> - * REG_BIT() - Prepare a u32 bit value
> - * @__n: 0-based bit number
> - *
> - * Local wrapper for BIT() to force u32, with compile time checks.
> - *
> - * @return: Value with bit @__n set.
> - */
> -#define REG_BIT(__n)							\
> -	((u32)(BIT(__n) +						\
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
> -				 ((__n) < 0 || (__n) > 31))))
> -
> -/**
> - * REG_BIT8() - Prepare a u8 bit value
> - * @__n: 0-based bit number
> - *
> - * Local wrapper for BIT() to force u8, with compile time checks.
> - *
> - * @return: Value with bit @__n set.
> - */
> -#define REG_BIT8(__n)                                                   \
> -	((u8)(BIT(__n) +                                                \
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
> -				 ((__n) < 0 || (__n) > 7))))
> -
> -/**
> - * REG_GENMASK() - Prepare a continuous u32 bitmask
> - * @__high: 0-based high bit
> - * @__low: 0-based low bit
> - *
> - * Local wrapper for GENMASK() to force u32, with compile time checks.
> - *
> - * @return: Continuous bitmask from @__high to @__low, inclusive.
> - */
> -#define REG_GENMASK(__high, __low)					\
> -	((u32)(GENMASK(__high, __low) +					\
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&	\
> -				 __is_constexpr(__low) &&		\
> -				 ((__low) < 0 || (__high) > 31 || (__low) > (__high)))))
> -
> -/**
> - * REG_GENMASK64() - Prepare a continuous u64 bitmask
> - * @__high: 0-based high bit
> - * @__low: 0-based low bit
> - *
> - * Local wrapper for GENMASK_ULL() to force u64, with compile time checks.
> - *
> - * @return: Continuous bitmask from @__high to @__low, inclusive.
> +/*
> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
> + * for compatibility reasons with previous implementation
>   */
> -#define REG_GENMASK64(__high, __low)					\
> -	((u64)(GENMASK_ULL(__high, __low) +				\
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&		\
> -				 __is_constexpr(__low) &&		\
> -				 ((__low) < 0 || (__high) > 63 || (__low) > (__high)))))
> +#define REG_GENMASK(__high, __low)	GENMASK_U32(__high, __low)
> +#define REG_GENMASK64(__high, __low)	GENMASK_U64(__high, __low)
> +#define REG_GENMASK16(__high, __low)	GENMASK_U16(__high, __low)
> +#define REG_GENMASK8(__high, __low)	GENMASK_U8(__high, __low)
>  
> -/**
> - * REG_GENMASK8() - Prepare a continuous u8 bitmask
> - * @__high: 0-based high bit
> - * @__low: 0-based low bit
> - *
> - * Local wrapper for GENMASK() to force u8, with compile time checks.
> - *
> - * @return: Continuous bitmask from @__high to @__low, inclusive.
> - */
> -#define REG_GENMASK8(__high, __low)                                     \
> -	((u8)(GENMASK(__high, __low) +                                  \
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
> -				 __is_constexpr(__low) &&               \
> -				 ((__low) < 0 || (__high) > 7 || (__low) > (__high)))))
> +#define REG_BIT(__n)			BIT_U32(__n)
> +#define REG_BIT64(__n)			BIT_U64(__n)
> +#define REG_BIT16(__n)			BIT_U16(__n)
> +#define REG_BIT8(__n)			BIT_U8(__n)
>  
>  /*
>   * Local integer constant expression version of is_power_of_2().
> @@ -143,35 +86,6 @@
>   */
>  #define REG_FIELD_GET64(__mask, __val)	((u64)FIELD_GET(__mask, __val))
>  
> -/**
> - * REG_BIT16() - Prepare a u16 bit value
> - * @__n: 0-based bit number
> - *
> - * Local wrapper for BIT() to force u16, with compile time
> - * checks.
> - *
> - * @return: Value with bit @__n set.
> - */
> -#define REG_BIT16(__n)                                                   \
> -	((u16)(BIT(__n) +                                                \
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
> -				 ((__n) < 0 || (__n) > 15))))
> -
> -/**
> - * REG_GENMASK16() - Prepare a continuous u8 bitmask
> - * @__high: 0-based high bit
> - * @__low: 0-based low bit
> - *
> - * Local wrapper for GENMASK() to force u16, with compile time
> - * checks.
> - *
> - * @return: Continuous bitmask from @__high to @__low, inclusive.
> - */
> -#define REG_GENMASK16(__high, __low)                                     \
> -	((u16)(GENMASK(__high, __low) +                                  \
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
> -				 __is_constexpr(__low) &&               \
> -				 ((__low) < 0 || (__high) > 15 || (__low) > (__high)))))
>  
>  /**
>   * REG_FIELD_PREP16() - Prepare a u16 bitfield value

-- 
Jani Nikula, Intel

