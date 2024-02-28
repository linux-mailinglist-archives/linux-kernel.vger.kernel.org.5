Return-Path: <linux-kernel+bounces-85391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93186B550
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802791C2212F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F24C208D7;
	Wed, 28 Feb 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImFmEvfu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF306EEFD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139125; cv=none; b=D413h1leh8b07+CX/oSeq0h7mCpPssKrgr5cmX80aRrtNsn4VYvZOkEzyOVUJMjd2T7GcdS/4dwhw8Qb7O1eUirw6X8LU9PcAte0xuWddOQSAr+++QgYgmweOJ5JaEQQxu6kRkZMFmdLNehmnFytGZhX9a1sGKdULEfn2drWf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139125; c=relaxed/simple;
	bh=28hkZfuWTn//HFgwcHpplqGFW5/zHwh1epJEYwglMhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxNIf9GX3CDPR5tbD4GYQg7U4vc8JsCgkFMYEgyAN3exrNJ6o2WoNON7eke/KPmryS56/mtMvjkBG1EB+vwbf+3KLHRUtzQ3RFLuPJHojAZCiB4wZwHfNvgticZ685gqmTrN4zO1ajSxTaM9ZSY/IB/LZlJgPkMIehf6EeHV58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImFmEvfu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709139124; x=1740675124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28hkZfuWTn//HFgwcHpplqGFW5/zHwh1epJEYwglMhY=;
  b=ImFmEvfuZULr29T+B6Uroq+vCjTWLsFGpKm9g99KVRkbtJyY/SNnPWOT
   U0g99h++nW4JeyK9OEDKvVWupPKjavcK8mSavaSf2Oe65vpkt8FdYy8tN
   d3lfuxDrtzWeXYkM1HxahvMAmWllQ3JsVp8FLb+/Qj6K28AlHqZAiVxdj
   L7Mv1wNDiUbr0SR01rNGYQAcZQ6MFMyTbURCVxXXg5dIKdT+R9f6dHNvL
   GbEIOVed2DidEET9LpUchfYMHKqvywzb5AshBtHyXrod6u8a6g/duvd75
   tveCny9fL/cWuHwtiydmciQLjK2v7An5v4/+Oh5Yb6nG6pyTTdidkKMqi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3716690"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3716690"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7442687"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:52:03 -0800
Date: Wed, 28 Feb 2024 08:52:01 -0800
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed MTRRs exist before saving
 them
Message-ID: <Zd9ksYnxm8UFJVH1@tassilo>
References: <20240110150806.22531-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110150806.22531-1-ak@linux.intel.com>

On Wed, Jan 10, 2024 at 07:08:06AM -0800, Andi Kleen wrote:
> This one place forgot to check the fixed capability. Otherwise there
> will a harmless but ugly WARN_ON for the failed WRMSR when the MSR
> doesn't exist. Noticed when testing X86S support.
> 
> Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> 
> v2: Add Fixes tag and expand description.

Just wanted to ping the patch. Thanks.

-Andi


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

