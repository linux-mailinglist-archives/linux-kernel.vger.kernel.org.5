Return-Path: <linux-kernel+bounces-147095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8888A6F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780E0284332
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2503130A43;
	Tue, 16 Apr 2024 15:13:05 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BE12F5BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280385; cv=none; b=PUCkY1t9d1zkHkmjpe8wuxkb9kcgEhYGwTNrU65DOuQUZbMoprTSKgstFLvjxtx85Ejk+p+W9Cm10xjhNUt+AvRq9CroixqkQWKa66Ytr/fKY8yVltI7/Eic0JVwu7TpGCNZOkluOIg2/Y+EEyLynxgijAOu8PZMKvVPeeH3KxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280385; c=relaxed/simple;
	bh=IPx8CmpfXcKAFC2d2Ekg6iZ70z+J/jgyY6cewblWTmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIt6v52FcpdVkDKGDGo4w1OmLSoo8mMK039eBWoNjYcEPitv6jcgMxIzHCtsaeh+M6xj4KarGEFUzWUBCE97aw2bnjdlAzEPQQZ322nq6o6ySxFZZwEtmdDtNaabWuJ19T2C5o4NNySKM8VTOfkNCV93qZ907PiZPLyz7XQqFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A307E40E0187;
	Tue, 16 Apr 2024 15:13:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xFtK88hvB0ON; Tue, 16 Apr 2024 15:12:56 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DE7C40E0177;
	Tue, 16 Apr 2024 15:12:49 +0000 (UTC)
Date: Tue, 16 Apr 2024 17:12:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Robert Richter <rric@kernel.org>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>

On Wed, Apr 03, 2024 at 08:35:11AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> IBS details are enumerated in an extended CPUID leaf.  But
> the support has an open-coded CPUID region check.  Use the
> new helper to trim down the code.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> --
> 
> Note: this cleanup could take another form:
> 
>         if (boot_cpu_data->extended_cpuid_level >= IBS_CPUID_FEATURES)
>                 caps = cpuid_eax(IBS_CPUID_FEATURES);
> 
> that would be one fewer CPUID invocations, but one more
> line of code.
> ---
> 
>  b/arch/x86/events/amd/ibs.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff -puN arch/x86/events/amd/ibs.c~ibs-region-helpers arch/x86/events/amd/ibs.c
> --- a/arch/x86/events/amd/ibs.c~ibs-region-helpers	2024-04-02 15:22:59.262912595 -0700
> +++ b/arch/x86/events/amd/ibs.c	2024-04-02 15:22:59.262912595 -0700
> @@ -1278,18 +1278,13 @@ static __init int perf_event_ibs_init(vo
>  
>  static __init u32 __get_ibs_caps(void)
>  {
> -	u32 caps;
> -	unsigned int max_level;
> +	u32 caps = 0;
>  
>  	if (!boot_cpu_has(X86_FEATURE_IBS))
>  		return 0;
>  
> -	/* check IBS cpuid feature flags */
> -	max_level = cpuid_eax(0x80000000);
> -	if (max_level < IBS_CPUID_FEATURES)
> -		return IBS_CAPS_DEFAULT;
> +	get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps);

I wanna say all this checking of max level is worthless because if you
have X86_FEATURE_IBS, then it is a given that you also have that
0x8000001b CPUID leaf.

Right, Bob?

Unless there was some weird thing back then with the CPUID leafs...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

