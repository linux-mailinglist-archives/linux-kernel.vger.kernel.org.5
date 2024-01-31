Return-Path: <linux-kernel+bounces-46938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71984469A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB61C22AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B844112FF6E;
	Wed, 31 Jan 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DE9yTACk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874184A3A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723882; cv=none; b=fzRVbdegPcWBJIshHcZ33yUxOoF7z4Iu2M4WmsPwiFMZ4rtaxUrCSlKgL+3+Ztn2dTRHXcjWcnO8XhMEQhkZ8iQ3IqNpf6bE8yMKnvZrF5cIzYpp+s4NVfgV8AFQSqzmOvtbBOG25lRXuUUoQ7S7NNSzJjqOVGZfzeaV7QyZ0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723882; c=relaxed/simple;
	bh=f8Twyr1rbist4v3G70PUahjy6OFpMvB53YtTVT8KDfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIGetBtAPBTcPFG7fChfsCuK8lf1Z4exoGFH0zlGuJqh355H+lWA8kyst+DfD0gk3omSp4JjRTP9HRsVRNdVf5Y3xmLm9lKdS6ssX5cVVito9HY8dW5WJeBhXezfx947qv4rvdWToM8lHFM8iD3MTE8O2fv1gl498f6JvILWOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DE9yTACk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4416340E016C;
	Wed, 31 Jan 2024 17:57:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qD_F4Et-REoJ; Wed, 31 Jan 2024 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706723873; bh=EPJnPIMccZ2oA4HteLyIihqkM2FOWyuGl/1xfuontCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DE9yTACkZG4+WRQV2OVzGa2G7gSIgRaNkgz93z/9gfAdg4ygqFrY+51og/FYWfUIf
	 M56BFK/jhF71IHN62W8osFRF5ZsN10CXpD01b5tXndzUPw7OfuUKElOtto8avG1KTZ
	 uWpjeTfHFBSqGoVzhf9AKd/6xPFEOpwTyHbAzOQCitwT7oU2jho52eJls8ZZe+H7nv
	 4thVcbrehR32A8n5lMp1+Xm2f3rXX6YyVHr6bwE496yp7olFfyQ45kxJMnCUU1kcjp
	 czovImNMYdHRYNT9KhgyV1Ln/Y0ngXAVq3+vD7TfVJ8jbyrWDRR4+RnE28rUp884vU
	 IT9hYiFVq0KNaCNEwmnRFGJOlN20OcS1eJVKMzwkJcyK1sjEnshd0YJDJPVivWWhIk
	 j2QxcuWTnuDca85Q6aF+OXjYJ4gnpU5EUnd73BNmGVPTaGJXTkORbwdsMpnKEpoUuj
	 jlPYEpb1F3kU873wqG+C/Mds+3uZdAfwDIsNIeh0L907144pOgwKgA7pNKbAO1oivg
	 Tom/RbDCr9DW+YsEeJ1QjkrhrgbNi0iRB51lpop7gS7hiMEBYwBcwshb/PI+XWxVgV
	 yA1r3tqAobqhOu0TkHtWkEzSn+XZXmxgV+9mQ1Rju069hgCZzcMuSgxouyufSJaQlB
	 hnt/VzLsji/iw5XHAdgpocCc=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E546F40E00C5;
	Wed, 31 Jan 2024 17:57:44 +0000 (UTC)
Date: Wed, 31 Jan 2024 18:57:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>

On Wed, Jan 24, 2024 at 03:06:50PM +0200, Kirill A. Shutemov wrote:
> The programming protocol for the PAT MSR follows the MTRR programming
> protocol. However, this protocol is cumbersome and requires disabling
> caching (CR0.CD=1), which is not possible on some platforms.
> 
> Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
> a #VE exception.
> 
> Turned out the requirement to follow the MTRR programming protocol for
> PAT programming is unnecessarily strict. The new Intel Software
> Developer Manual[1] (December 2023) relaxes this requirement. Please
> refer to the section titled "Programming the PAT" for more information.

How about you state that requirement here instead of referring to that
doc which is hard to read and changes constantly?

I'd prefer to have that programming requirement spelled out here to know
in the future what that requirement was and what "variant" was added to
the kernel in case someone decides to relax it even more.

> 
> The AMD documentation does not link PAT programming to MTRR.
> 
> The kernel only needs to flush the TLB after updating the PAT MSR. The
> set_memory code already takes care of flushing the TLB and cache when
> changing the memory type of a page.

So far so good. However, what guarantees that this relaxing of the
protocol doesn't break any existing machines?

If anything, this patch needs to be tested on everything possible. I can
do that on AMD hw and some old Intels, just to be sure.

> @@ -296,13 +298,8 @@ void __init pat_bp_init(void)
>  	/*
>  	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
>  	 * supported.
> -	 * When running as TDX guest setting the PAT MSR won't work either
> -	 * due to the requirement to set CR0.CD when doing so. Rely on
> -	 * firmware to have set the PAT MSR correctly.
>  	 */
> -	if (pat_disabled ||
> -	    cpu_feature_enabled(X86_FEATURE_XENPV) ||
> -	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
>  		init_cache_modes(pat_msr_val);
>  		return;

What does that mean, now, practically?

That TDX guests virtualize the PAT MSR just like with any other guest or
what is going on there?

This should be explicitly stated in the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

