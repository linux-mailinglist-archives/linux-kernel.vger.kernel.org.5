Return-Path: <linux-kernel+bounces-138729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C289F9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65601F30554
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B115F409;
	Wed, 10 Apr 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFpX+ZMO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC715F403
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758377; cv=none; b=apg257jOevyPEZJ3et3Y+2ehSpvuCzsU2AARio2jesY0fy92RczTLw1Y+c9t1CyOCsf5mbjAEBVqoQNSAMGOmJLUd2uTqo2AQ3xJjfoi/7ye7sCyIWbmBKPtwNysPPG9dx3NoUPNSkaOu1yCDIRds88X//3F0Nb7j3XeXNxjbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758377; c=relaxed/simple;
	bh=o5Xl6KLUlyJc9ziXPk/AZSDc/htjvPYVBAcZVf4ZKjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuwWIcK/n8b73lHrcFQyv2kHQa0Qdo5TeCWAFE69oyjdI+Ze6Vg7/NnN/bDkJHv7rxZw5kvlPap+c4r1FQf42G77U5YKr92oylu/nhjZv19+doJL0XZQQl0mfH1zklO+22J3PdOu5YsML8oCYIPTjxDpRS6hMS1kRGmTYRxA8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFpX+ZMO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712758376; x=1744294376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o5Xl6KLUlyJc9ziXPk/AZSDc/htjvPYVBAcZVf4ZKjM=;
  b=FFpX+ZMOsgWBWXJWUila7Qz3Ye7W/9MyLrmzvWF4NAUywEXNinkRVusg
   8adFzSw7WvFNm4SPGthBie8xnIPDuquXEPB8OrqrdV5uzD658t8Srlqtp
   UfrzXhpSFyGwzOwoTExpGqNFUrpI7qTH6gpqG0obyc+IB+DO9olepPTbr
   hNa2auIFHSFlskaOisH7yBL7HazjcaHSLGskIojvWxq1e96vnzO+gYbzd
   gDVqXRMpOk6N4qkKIAegp1hsq0u/jZudm59C13aoFEFMyhNZGwvcl3+TO
   0xs75QR0NlAJrQwYsi61fzaLWZ0E5q1jnwom6Xauc7qpC+c3aPu2lNlJf
   g==;
X-CSE-ConnectionGUID: 00gE0pxPS9KoQuotIyoK2Q==
X-CSE-MsgGUID: rFyvLNP1Tm2mSKIYy9g+kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19548706"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19548706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095148"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937095148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 07:12:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0BBF3161; Wed, 10 Apr 2024 17:12:49 +0300 (EEST)
Date: Wed, 10 Apr 2024 17:12:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Message-ID: <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>

On Mon, Apr 08, 2024 at 12:44:54AM +1200, Kai Huang wrote:
> TL;DR:

The commit message is waaay too verbose for no good reason. You don't
really need to repeat all the history around this code.

> ---
>  arch/x86/kernel/process.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b8441147eb5e..5ba8a9c1e47a 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>  	mcheck_cpu_clear(c);
>  
>  	/*
> -	 * Use wbinvd on processors that support SME. This provides support
> -	 * for performing a successful kexec when going from SME inactive
> -	 * to SME active (or vice-versa). The cache must be cleared so that
> -	 * if there are entries with the same physical address, both with and
> -	 * without the encryption bit, they don't race each other when flushed
> -	 * and potentially end up with the wrong entry being committed to
> -	 * memory.
> +	 * The kernel could leave caches in incoherent state on SME/TDX
> +	 * capable platforms.  Flush cache to avoid silent memory
> +	 * corruption for these platforms.
>  	 *
> -	 * Test the CPUID bit directly because the machine might've cleared
> -	 * X86_FEATURE_SME due to cmdline options.
> +	 * stop_this_cpu() is not a fast path, just do unconditional
> +	 * WBINVD for simplicity.  But only do WBINVD for bare-metal
> +	 * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
> +	 * (and unnecessary) #VE and may unable to handle.

s/#VE/exception/

On SEV it is #VC, not #VE.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

