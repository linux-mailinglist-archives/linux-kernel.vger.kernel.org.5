Return-Path: <linux-kernel+bounces-152278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487998ABBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F385A281529
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805C20309;
	Sat, 20 Apr 2024 13:36:53 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02361CD25
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620213; cv=none; b=Drb0PdcYDh4nSOAerXdrL392VQLzypN2xqPZ0NB4x6eLg084m2N1HcbI7t4/btP7ZHBRfVrLnUcH1eXreoojFSrNdQD7H+zgdq7SHTJC3i/BcA/yN6cZI8CgexQZwDIc1s+7PLKlUqFVzrcp4awhj7d2zPnWKhsjLMcrhztYQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620213; c=relaxed/simple;
	bh=0SjfUwaAeoxQoQv29i+xVwe6pgaFMFpnDXCH28PPGzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmFVzbZIHFvUw/9Hva03ngZER8nSn+TW2sUZaHFAMwgUv5x11WtFnR3EWVJ6HhdxJvbYE0wv/DJs5RiB6l6IgpimHSXxmU9sz6lCap14XHxJYtXUqfvKQFx3zAMd0UndwGrJrEI2Z4k53L3dxx7aw3mxgIqpZF3JJYieiPrgnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 936FD40E00B2;
	Sat, 20 Apr 2024 13:36:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u4SVQZwpEBce; Sat, 20 Apr 2024 13:36:45 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D950240E016C;
	Sat, 20 Apr 2024 13:36:31 +0000 (UTC)
Date: Sat, 20 Apr 2024 15:36:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] cpu: Ignore "mitigations" kernel parameter if
 CPU_MITIGATIONS=n
Message-ID: <20240420133630.GCZiPE3lZ3m-M1CqG_@fat_crate.local>
References: <20240420000556.2645001-1-seanjc@google.com>
 <20240420000556.2645001-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240420000556.2645001-3-seanjc@google.com>

On Fri, Apr 19, 2024 at 05:05:55PM -0700, Sean Christopherson wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 619a04d5c131..928820e61cb5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2495,9 +2495,13 @@ menuconfig CPU_MITIGATIONS
>  	help
>  	  Say Y here to enable options which enable mitigations for hardware
>  	  vulnerabilities (usually related to speculative execution).
> +	  Mitigations can be disabled or restricted to SMT systems at runtime
> +	  via the "mitigations" kernel parameter.
>  
> -	  If you say N, all mitigations will be disabled. You really
> -	  should know what you are doing to say so.
> +	  If you say N, all mitigations will be disabled.  This CANNOT be
> +	  overridden at runtime.

You probably wanna highlight the fact here that saying N means it'll
simply not even build in the mitigations code, leading to the physical
inability :) to enable them later, at run time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

