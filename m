Return-Path: <linux-kernel+bounces-44846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F8842817
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5CC1F2648A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46D82D94;
	Tue, 30 Jan 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HPpvSE07"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C182D85
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628724; cv=none; b=CYbD5xDKxUBqzhkc4KOJqMhDZJ9Z09IQdy2x6cPx14QrsCfjLHWemytCFgVEdlmGWMvfycK0+a/JAWLpcuuFUOKfqCmjOUShM/vP20Hvfp+UZ2RfvyqCCuzGAl6tOyJAC/ln9IAcJEgE8FFJrrbJVNohSs9IOW4Ri1lKf4v86Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628724; c=relaxed/simple;
	bh=/mb0FlNJsasGY09t2fVBMH3IJJ17htS6caWYWfCl6nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxVrJY6ANaalwkbCmPUQEIaSdZ/fcNEFgZEFtryIJEDY7rQ63WZfDqIBqYirvFv7mqVRmNhJZ6AHKq1vPrW7X4MMNu8WUz/WCzSsjH07vxDRQxXoK6EQ/MjLyCd2rOaywxtrFNjDjNe9/EnnREr2jEf/q5L0L6r5ccoF3rg5D44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HPpvSE07; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CAD740E016C;
	Tue, 30 Jan 2024 15:31:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gPMgD9ziwYsG; Tue, 30 Jan 2024 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706628716; bh=QBO0DN0ipIKH7sKZQJ7hGPJ0BINXkDod39T7fhCWYlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPpvSE07XxIN+63fjfGCnA4yTxw27SQoLz1KMeIYbyYSzL4ZB0RLpy1Odj6b+pxHD
	 p4YKH6wb4t76jCHVRyOisLbzvHkD3hTvsBPH5GhHQSkfo/RBDuVlLyxe1ty9I7bTiY
	 pbrnMUZj0zYAqp4inRN91mp6jRWGOEhNJWAvWcEanByIBAojcxP6fpxdQTpl1zuP7Y
	 JERt2A4s9kdoR5SqKNnCY78Qy+oesLxGGb98hQAxUkLOLYTy74Yv6LhX9D2lu9bGHV
	 ZKvs/K6jBumTZtpJox6dxM3lAiF5OJqe4aCot19fpE7rLN6fZqwBFStecyKG0oy6Ip
	 l0iN3KHxpYAVH0eLyFPhUbPXQKzmIIQIpE2b3IfZ2gAflulAnQ7GXK0prhASL1cNip
	 vbNd8YbF8DDiDJ4RCejLwYArKzlDLfSbl5j5yEoYwIpv8693DXbGfRBCiYid4QzZp+
	 oKNwcBmetiS1rPCAHoEfJm3WhnJQVGmeObujwsSN+dpo84nUnDX/qkQiYlNwl+XZNc
	 XpOlLIjuKlO6KdKJEYBsAAf62Uk9L0FbXY/OndOoakgyj6GfZ34uh/tPFOsmLdtIVZ
	 TW/ygqrgxNaRH1eVwEA2/1F/LO5CuVEHv45s2iiDdCyOP7KhNdA+hY2LDu9EVv9vgq
	 AoAgcPpjXCoj+QtjKnNbOOmA=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6146640E00C5;
	Tue, 30 Jan 2024 15:31:46 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:31:41 +0100
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
Message-ID: <20240130153141.GEZbkWXQt2H3JHHGHx@fat_crate.local>
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
> How do you think?

Interesting. For some reason gcc doesn't constant-fold it away like
clang does.

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
>  }

Looks good to me. Lemme try it here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

