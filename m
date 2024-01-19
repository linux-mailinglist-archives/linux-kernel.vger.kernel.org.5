Return-Path: <linux-kernel+bounces-31512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341A832F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBF91C23CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618656454;
	Fri, 19 Jan 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMDi64N0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972B1E520
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692587; cv=none; b=k9DWSlqwDyQEkt4g2dsazzyzRYYlfq5erCA8XQfJR4e2Yc2raLVOGUPJW+0/rSvwDHEPW+lQpk77dtcbstLPoyxv4bjRg6+1hTwrNr0P14B4RahSexYeCZuZ6/vIWrjMKf8gRoES8GoeG6+zG22jyxHhuT5vcIcavizOBHSkKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692587; c=relaxed/simple;
	bh=FEcAsUZWPrO8gUGoSTTntTr0QKjxJXyVj/rDXuZnSC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1C3TUhlw8fabpgVetYC3vZgaO8mF2GExYMtaSEPiQtmJ58C37RG93mVuj3hmRRVrJ+NEKBLjO1CdAsMfcysQcC1gpvOI/giF7b7a1bpaHAR1ckai32Cv7Xakjq21O+K3/V1m8n7s2MhEV0YPfLg+D2MGLpaFXPm8SwM9i8P9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMDi64N0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705692585; x=1737228585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEcAsUZWPrO8gUGoSTTntTr0QKjxJXyVj/rDXuZnSC8=;
  b=mMDi64N08Mm/jUCLkHoE89Gj1CruUztibfO7zX30EITgcqB3uUthHOKF
   yTjTBybzzj0HV+gTmNmlVrOlttPuzrNFQ2BC3e5HLkjnpJWSoyRw+M44v
   Gk2MgYKCG5td0BJ+W/ftP9uupzGQgDY22krF55rhFeG1uhcx+UT8I9lUi
   ghcEZSoFMJYKgG57016+Fm1UJJeVBZMKra7pTzyU2IsR4il/1FYcVMv/G
   SC1IauzVKtHl9ifrwF0N1c0PLPNqNqCk0UhN06G9kvkSmUi/Aq1XrdLQf
   X6ilyl8tWoL6Xc8bFu/wX7Aew3hfvxoCPctjQooL7F68JbvtFg+FqhR6H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="705486"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="705486"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 11:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="742731"
Received: from guptapa-mobl1.amr.corp.intel.com (HELO windy) ([10.125.112.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 11:29:42 -0800
Date: Fri, 19 Jan 2024 08:21:04 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	alexander.shishkin@intel.com
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <20240119162104.4ehgnj4ptjrfwyhf@windy>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
 <8936e2c6-93b8-417e-9151-041c5f2e1102@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8936e2c6-93b8-417e-9151-041c5f2e1102@intel.com>

On Fri, Jan 19, 2024 at 09:48:14AM -0800, Sohil Mehta wrote:
> Hi Pawan,
> 
> On 1/18/2024 6:35 PM, Pawan Gupta wrote:
> >  arch/x86/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1566748f16c4..794517df8068 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2270,6 +2270,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
> >  config ADDRESS_MASKING
> >  	bool "Linear Address Masking support"
> >  	depends on X86_64
> > +	depends on COMPILE_TEST || !SPECULATION_MITIGATIONS # wait for LASS
> 
> I was wondering if the COMPILE_TEST dependency here is a bit redundant.
> 
> Having ADDRESS_MASKING depend on just !SPECULATION_MITIGATIONS might be
> enough to get the LAM code compile tested through various configurations.
>
> I don't have a strong preference here. Mainly looking to understand the
> reasoning. Other than that the patch looks fine to me.

The goal is to compile test it whenever possible. As
SPECULATION_MITIGATIONS are ON by default, it wont get tested for most
configuration.

