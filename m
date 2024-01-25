Return-Path: <linux-kernel+bounces-38748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96183C542
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A162957B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F36EB6B;
	Thu, 25 Jan 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvSn8rT8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B346EB58
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194211; cv=none; b=RgDrwH3cl4NHNzsFYcb8GsBykIfA0Fhu8+bRddX/lwzbK1BwR+d1EcyvFxWaJCKZ/a843WnZr8tZEGQtMkkBAmOIhWSL2ddmwcZk17q4ubMwNc9FXkXk6jEFNdtOKoVymYh0OY5e/aB0krn+M/CHvxWrNZABrdD+LViCW6dtsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194211; c=relaxed/simple;
	bh=vMiyI/wRBdkFwRPV4E9Wuo5tN9uCzX1dsDL3Ei771pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXaBV8o/Qea7Xxg1KQ7q2zXTzX9NjZNM0ye33esiHe/VOM3q10PJMvT0Wddtms3lwaq/t64jK8XM5r1jXZ/9OxNLavxcFF4XY9S7/7YgoGpsaamecrLzdEn55l5cGlQbv6DmvN2nl3u/s95sMNULL3l1CI2IFADob8JEj04+CV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvSn8rT8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706194210; x=1737730210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vMiyI/wRBdkFwRPV4E9Wuo5tN9uCzX1dsDL3Ei771pA=;
  b=QvSn8rT8DHn632NHC+esWyMADAAcidMLei1IuahJjD3F5dT2HNvhbigD
   oTTTl7eXmnNzhncT2ajjHspMX7kIZ9Kf24CoFv2cXBrWP8D2hAA+bG0UI
   suVkU/9G1BbmsDX43Uum6BRKUPRP1pORCucEB5hNujPVGAo10LRILC1TV
   E/ctTKJh9wiC9jiQvM8KOPGilht0nL+hTne5k8DXbHWeouu+zXy2cpt49
   oucf9fa18+S7ETOxHWwQgcMBElzY7rVvwXV3oafhgonnpSIkRd/YzITPt
   rJrKkQlNf1X3QIYlvBYL0DY6dskyxY8l0B+zpI1mVIm6JWUjTYVMl26Ak
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="2049593"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2049593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2380058"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:50:08 -0800
Date: Thu, 25 Jan 2024 06:50:07 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCHv3, RESEND] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <ZbJ1H77MtNkko02P@tassilo>
References: <20240124131510.496803-1-kirill.shutemov@linux.intel.com>
 <ZbIwfp-jOOlPNb1z@tassilo>
 <wo4wcvuhvqsqissocu7nz2urg5yt7mx65s5dxkjxqimgnxv3ax@qsa3lqlfsaxi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wo4wcvuhvqsqissocu7nz2urg5yt7mx65s5dxkjxqimgnxv3ax@qsa3lqlfsaxi>

> I think it is cleaner to switch to IRET here. Does this work for you?
> 
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index 608f108cba7d..14d9c7daf90f 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -243,7 +243,9 @@ SYM_CODE_START(trampoline_start64)
>  	movl	$pa_trampoline_pgd, %eax
>  	movq	%rax, %cr3
>  
> -	jmpq	*tr_start(%rip)
> +	pushq	$__KERNEL_CS
> +	pushq	tr_start(%rip)
> +	lretq

Looks good. Thanks.

-Andi

