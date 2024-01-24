Return-Path: <linux-kernel+bounces-36600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0583A3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ED21F23B53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C7C1754E;
	Wed, 24 Jan 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnnRLoV8"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A91754A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083138; cv=none; b=tsZFjV5fYNX6Y2VMVms2yMGZ1MekP+CNyo1lo2Mv5wwbf7W/JVWaHVcqlM1NTRujOP43Jo+1bm+C/NNWyRdeOyMrMP5UqUk2Bav2N70nUcLLvkBZnSZ6KyvQA0f4XqCx5veDWMPE3SrKe0yvlLA0Tb93bqVj38A49Qqu0ktygoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083138; c=relaxed/simple;
	bh=315CdLizWLGLXyaVNYVsttdv0aOnIMeQbKpRicgFKUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JmRZj1QnBxIIsaQghYog2MY8WE+6zgWzTeybVyoiFX5eo/6LRpCRDOzQis92J9UgW3f/U8f9KClQUJBEmimSFOwElCfsQ3zzFdCdQFU4hzYdpfQ53LiotqqyppJM5k6H4fA9ihhfX1ij0ONQqwDtB9JdfB5M4PZ4kZYSEpi3Ins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnnRLoV8; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706083135; x=1737619135;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=315CdLizWLGLXyaVNYVsttdv0aOnIMeQbKpRicgFKUQ=;
  b=VnnRLoV8kVcP1n4rC0b0idnor2QrfNfgaMsBMOo7mUvFsR8geI6kzRNO
   TloMEfHGaAVUgknDOWcu24ef3/xp2Rx3g8lctsiGHeWlRYhDZBbDZyEsT
   Cx2belT/WRAd2W/jcO27WAOJx3yixP+W0uwbGGTZHXFYI88fVsdllZRUH
   3s5WLaeEtyKfudRzv9ddHekfhsyFqb192jNXZaJ1vNOaQTw6WU3h+XIWs
   VuTC360E2do/TC41xPqgowY1+37Zu4Q89A07Qxoj/64LOFaBLq6CcTCJB
   mMmFbaJ5BcaDM/cw0wTH9aAB1ztB4XoJ+ckTHox8Nkq2ErUSsLAuqQQcD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="392188418"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392188418"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 23:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1926470"
Received: from komalav-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.41.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 23:58:29 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Yury Norov
 <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/3] bits: introduce fixed-type genmasks
In-Reply-To: <20240124050205.3646390-2-lucas.demarchi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-2-lucas.demarchi@intel.com>
Date: Wed, 24 Jan 2024 09:58:26 +0200
Message-ID: <87v87jkvrx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> From: Yury Norov <yury.norov@gmail.com>
>
> Generalize __GENMASK() to support different types, and implement
> fixed-types versions of GENMASK() based on it. The fixed-type version
> allows more strict checks to the min/max values accepted, which is
> useful for defining registers like implemented by i915 and xe drivers
> with their REG_GENMASK*() macros.

Mmh, the commit message says the fixed-type version allows more strict
checks, but none are actually added. GENMASK_INPUT_CHECK() remains the
same.

Compared to the i915 and xe versions, this is more lax now. You could
specify GENMASK_U32(63,32) without complaints.


BR,
Jani.

>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitops.h |  1 -
>  include/linux/bits.h   | 22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..1db50c69cfdb 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -15,7 +15,6 @@
>  #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
>  #endif
>  
> -#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
>  #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 7c0cf5031abe..cb94128171b2 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -6,6 +6,8 @@
>  #include <vdso/bits.h>
>  #include <asm/bitsperlong.h>
>  
> +#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
> +
>  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
>  #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>  #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
> @@ -30,16 +32,16 @@
>  #define GENMASK_INPUT_CHECK(h, l) 0
>  #endif
>  
> -#define __GENMASK(h, l) \
> -	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> -	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> -#define GENMASK(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> +#define __GENMASK(t, h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + \
> +	 (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> +	 ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
>  
> -#define __GENMASK_ULL(h, l) \
> -	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> -	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> -#define GENMASK_ULL(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> +#define GENMASK(h, l)		__GENMASK(unsigned long,  h, l)
> +#define GENMASK_ULL(h, l)	__GENMASK(unsigned long long, h, l)
> +#define GENMASK_U8(h, l)	__GENMASK(u8,  h, l)
> +#define GENMASK_U16(h, l)	__GENMASK(u16, h, l)
> +#define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
> +#define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
>  
>  #endif	/* __LINUX_BITS_H */

-- 
Jani Nikula, Intel

