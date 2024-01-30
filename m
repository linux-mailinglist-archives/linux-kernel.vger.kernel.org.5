Return-Path: <linux-kernel+bounces-45029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D45842AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258FC1C24EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023541292DB;
	Tue, 30 Jan 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a7s2um2L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F5128388
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635094; cv=none; b=r0utei1IfQOQJxeztOesn1jb84fyMA3+d6DAXEw77UVdoBGpsTC2a2J3xOI4qwhWY+n47iGmn8lseWkfPBhAlv741CZRWI/y4QoMTPTDIhgfpR4oltDMc5pWdPeenJOWrxVxvvKoVO7R6i/Rn4rn5M8u0GC1VazZ0ChP9Sz++6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635094; c=relaxed/simple;
	bh=bSH0ASnXZjcDVpolqCxHH09VljozYJWnQ2GDWK1l+uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXLWhYpwvIrdaF1mko2U6fOX6902xh3ErtA15ULAs+22Bqsnt6asV5JsKcrL3yG9YDkDqgq4C8R7ef5DkvUVFfw/X31wiJ5W8pSKqC3a5boHUSFGEaLGi8pIc9iLSQHjvpHTz5srI7Aq4S+hVgMnq/3wKyMTbJu+Ewjdf+6Y29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a7s2um2L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D099E40E01BB;
	Tue, 30 Jan 2024 17:18:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E5CUda0pWPF4; Tue, 30 Jan 2024 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706635086; bh=NNImHxXmQ5ulkndnBxd7GFovliEMcYjuVkrw8tLfCA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7s2um2Lj/MjtzcHX/h/ESf2v8CerKa0Vof+l0TCEJCdU72vUnNGcEUyclENaMLUJ
	 EPGW2aIFQBWPEeCEsd2qF47kh+V6gPJb2Kwjal+DqBa9b0KMR2LbGfvSmZahyWFw1e
	 Vwu9AkMN2UDLY1DyOFHNOl94lwRgrghJC+YauyeOTJXImVDB/tXxfNuB3TsIpKjVDv
	 4NthZ6csJ9lEAcUNpT8wLf1Fvxn+O8IpPLJi4FsVtxfefdDEzyKpqzoW4kMeysHv8Y
	 3I2kk2WTyGcNM3sqsHPoxtb6eBLii71++Ch7jcnOErsAZ2AWDgDOgnJ4zl7KTjnh8D
	 wwlCCKkTg6X9JiA3Zj+gqMUUP5L024YGZLMSZqg6qxJcdtMSJVAW6HMvaI9hfjK+Z0
	 Gl4ROyZIAb0YMtqSxcGRG+c8w80ynytYzAaTB/JtdXBQXW/RhoHrSpfHaqcxHoOIEu
	 2jgcVVPLQsuzRdfBBNEWKcslqbEIES/2OVCDVxeKeIeMWiqzSG4KMzv+KhyUda3O/C
	 bG0cKJMk/hMuq+4lCSXxcMGH9NLN9n0LxLbkKX2NVjyQv903+hhUpv3goAmNUhyQn5
	 MEYoewbgesGdkEkrKjDkxp6SdIy4jN+V42SFpJ/DmtWVjG0ilx7Kc2mbwH7jnPlSXc
	 nZSftqWeglhEmzUDJEQSev40=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B529040E0177;
	Tue, 30 Jan 2024 17:17:56 +0000 (UTC)
Date: Tue, 30 Jan 2024 18:17:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Message-ID: <20240130171751.GIZbkvP2yfHF4vBt4g@fat_crate.local>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-3-xin3.li@intel.com>
 <20240130124816.GCZbjwEFrZS55FLxb8@fat_crate.local>
 <SA1PR11MB6734A226858F6030C86AE2E5A87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734A226858F6030C86AE2E5A87D2@SA1PR11MB6734.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 03:22:01PM +0000, Li, Xin3 wrote:
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index c7ef6ea2fa99..01342d343c19 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -81,7 +81,7 @@ static inline void ia32_disable(void)
> 
>  #else /* !CONFIG_IA32_EMULATION */
> 
> -static inline bool ia32_enabled(void)
> +static __always_inline bool ia32_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_X86_32);

So I always-inlined both versions since they're small enough, see diff
below. That works with this .config, I'll run some more overnight to
make sure...

Thx.

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index c7ef6ea2fa99..4212c00c9708 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -69,7 +69,7 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 extern bool __ia32_enabled;
 
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return __ia32_enabled;
 }
@@ -81,7 +81,7 @@ static inline void ia32_disable(void)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return IS_ENABLED(CONFIG_X86_32);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

