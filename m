Return-Path: <linux-kernel+bounces-61666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9533851523
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F5281337
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382B54BD2;
	Mon, 12 Feb 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUkunyN2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5655467C;
	Mon, 12 Feb 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743767; cv=none; b=nus7+om8b0u6483hk8k4sLEXbSA0dJyJM8GpTpyR9XresfIyUs2JE/ezMOZA2dPyEy1tqS5Esu16uHoMyD5XLNQsJUgqXc8p1thoj6kcfvGxWRE2aOvdFMPi721I0LZpRCmzK4vsmQOLyNYMGtor5j2uhXZny5rnNphscD09YrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743767; c=relaxed/simple;
	bh=PP6/AXI8N1ZB7uTahkyJ97Bokj8Vg9DEe3iPYyte3eE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udeHYmXufhsUM7HjzIh5FjCbYufJ75//dQoJOgDD/8nuRsnS0Qmm45UHcV88GSrelxYH4yk8DIZT8uymXfNUYQIXXoX4cZr9Xi0D68TCkgZ1z6cPQgll77D6vznVzLVDBrMI5ND0kbEr0QBwWBgyeEoAFLHGKHRgxD/pSk/a3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUkunyN2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707743764; x=1739279764;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PP6/AXI8N1ZB7uTahkyJ97Bokj8Vg9DEe3iPYyte3eE=;
  b=MUkunyN2sOSRhhjrc2mxlMgL/ET8FzZBx1ZGFI8prOAZeQ7IvcfYURAt
   /IBBjXuZ5EUFvfL7K0V8nGXcsHpFgMhMOfRhy0SiRTT1SYnu2FOQcAiaq
   5JGm8SeOjb5qbjE3kNKl7VNWdpmJbdl8frMDJaDi6HXcaAW+c8GkeW4Bu
   36CIj395WZOycWgPBFMrvMmADuviH6X3kuPwe0jDnLyC83LYSc0BLQBWY
   vqIis7hiRLV01XlSQnD/JCthDYbXoEEGjgh77VE19EHNDi04P0DgV3oCk
   JV7EZTN0Alkb89SMNyBO1NMv6dLmc93OjvAnwk8Z4SK2D8ZKRptTn6UsD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13092578"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13092578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2561132"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.91])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:15:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
 <daniel.vetter@ffwll.ch>
Cc: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Somalapuram
 Amaranath
 <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, zack.rusin@broadcom.com,
 tzimmermann@suse.de, thomas.hellstrom@linux.intel.com, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20240206152850.333f620d@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240206152850.333f620d@canb.auug.org.au>
Date: Mon, 12 Feb 2024 15:15:54 +0200
Message-ID: <87y1bp962d.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 06 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In function 'i915_ttm_placement_from_obj',
>     inlined from 'i915_ttm_get_pages' at drivers/gpu/drm/i915/gem/i915_gem_ttm.c:847:2:
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c:165:18: error: 'places[0].flags' is used uninitialized [-Werror=uninitialized]
>   165 |         places[0].flags |= TTM_PL_FLAG_DESIRED;
>       |         ~~~~~~~~~^~~~~~
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c: In function 'i915_ttm_get_pages':
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c:837:26: note: 'places' declared here
>   837 |         struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
>       |                          ^~~~~~
>
> Caused by commit
>
>   a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")

Cc: more people.

>
> I applied the following hack for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Feb 2024 15:17:54 +1100
> Subject: [PATCH] drm/ttm: initialise places
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 80c6cafc8887..34e699e67c25 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -834,7 +834,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_object *obj,
>  
>  static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
>  {
> -	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
> +	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1] = {};
>  	struct ttm_placement placement;
>  
>  	/* restricted by sg_alloc_table */
> -- 
> 2.43.0

-- 
Jani Nikula, Intel

