Return-Path: <linux-kernel+bounces-127075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2E894673
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DCE1C217BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10354BE8;
	Mon,  1 Apr 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kanlc2uj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E84683
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006379; cv=none; b=FLWSCWVE/CriR3eArRdf2BfX8WVvFtOgKjNQayH7dW1LvHUZBwf1tATw7x/fbZDaDf0X7cGfReB0S92uXS8yaxZYxSYxYGvKO/rhslWisDrufwfafHE7d6BcfnssfZK7JV9n7cPJ2PQORPuIg07Z+FCXhHf6uQtIwrLAN1rT+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006379; c=relaxed/simple;
	bh=Sed6xAsn78k76LRv6VgwRp2XxC0NFld9WJiCFKD4ZV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9j9tataZoDUC4xxJZbDGegC9DCA9+UV04kuN0J46LxXmu4kaUAsbtiXQERFOT+oZEYtCeWeLUW4Am+tEQFFMs0X3DnBUXdYdRwxjI32tsVp7AA+B6ZomJtwFeAAKTxkHB4MMXE9ASPeOrlXxOm+b45wHcl39gjwbybRrFYwnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kanlc2uj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712006378; x=1743542378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sed6xAsn78k76LRv6VgwRp2XxC0NFld9WJiCFKD4ZV8=;
  b=kanlc2ujh/y3PkI7UWYMdb1r7iQCjJRrs8mgPvIffsha/B2ZTtmM/934
   A7tn6+rOIH1E21WL/3nJmk2BUGY2DXXzAmvQp6AN/+F74fzMbOl47WxNc
   kzd+UkWnIhnoWBfJZFe+rm2y++ZxhsrLNpv3JUeR/Ftem6IBEKjSxZ3ly
   xl0hKudc2KfCb2V0GRg/RhFYsoNYAFVGqPutU1s1k1HRjIWQXm73b/5YH
   M8+UkmLiRSxJtfHUw70VG5hl/Q1RkXuuol97auJ14+lUmA7rfcoDoXMik
   b4rG5Om3ndiu2TqdlZ1/f6phG8ztpzLHy/7EdzwxnbPY0GhRaAOKApuKn
   w==;
X-CSE-ConnectionGUID: 4v4hG25RSCOIO15DQkm5cA==
X-CSE-MsgGUID: Cq4O3kXDRIeOWq3QcqEI3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10971191"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="10971191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17868828"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:19:37 -0700
Date: Mon, 1 Apr 2024 14:19:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PING] Re: [PATCH v3] x86/mtrr: Check if fixed MTRRs exist before
 saving them
Message-ID: <Zgsk51SlXLP7JJsJ@tassilo>
References: <20240229001952.325275-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229001952.325275-1-ak@linux.intel.com>

On Wed, Feb 28, 2024 at 04:19:52PM -0800, Andi Kleen wrote:
> MTRRs have a obsolete fixed variant for fine grained
> caching control of the 640K-1MB region. This fixed variant has a
> separate capability bit in the MTRR capability MSR. The MTRR code
> checks this capability bit before trying to access the fixed MTRR MSRs,
> except in one place. This patch fixes this place to also
> check the capability.
> 
> Otherwise there will be a WARN_ON when the respective MSRS don't exist.
> 
> Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Ping!

> 
> ---
> 
> v2: Add Fixes tag and expand description.
> v3: Expand description
> ---
>  arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 767bf1c71aad..2a2fc14955cd 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -609,7 +609,7 @@ void mtrr_save_state(void)
>  {
>  	int first_cpu;
>  
> -	if (!mtrr_enabled())
> +	if (!mtrr_enabled() || !mtrr_state.have_fixed)
>  		return;
>  
>  	first_cpu = cpumask_first(cpu_online_mask);
> -- 
> 2.43.0
> 

