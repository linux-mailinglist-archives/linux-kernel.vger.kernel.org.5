Return-Path: <linux-kernel+bounces-44626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15671842545
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D53284BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DBA6A328;
	Tue, 30 Jan 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UoiAhKX1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71B679F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618921; cv=none; b=juKEAb8Wgfm7buf1FxX9O6gVaUwdtbnS6DhYM01FlEg0FxsYlNnkQnOcaFxAbKd17Du/hU5p5uARlseCJ6q4BArmoLAxFP+4XqhNNsYiygVG6C/uTGhht2kwwUiuF9fZylNEGT3bnyY3Dy8EJ+uOx1zW31SjWyiuvdyh8Pn4ggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618921; c=relaxed/simple;
	bh=7VwHUSMVB7tJB3T1NjipffOmlucmeWOP2SgE55gk384=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/wVyEsmSk5RdTUhIJgFznzAbuA/ZwRq0Pdyei44FAzqk9XJ35BUvcbmpVmJHw6piHn2umk3lDgYmnvsGS7mZRyH2Zpb6vwyeReFZtsj7oXnJ0IZqiqnGozfA7BtRMJ/Hr4P4PZ49k4RVLjtjgt+iDxpOWNa5jjKWNYIZ3/VtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UoiAhKX1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D40A940E01BB;
	Tue, 30 Jan 2024 12:48:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JZ9g6t8sfRuZ; Tue, 30 Jan 2024 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706618912; bh=6gdHYVPhKxJvSAFz4Dpfu8Iy9Q86+dYYmwzGBxOd/r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoiAhKX1WC4OnnrSI+d0Y5dPy8uzr3mdr3pKnAJaoOYI6Uu9Lhl1RZ4DinCCGfBgA
	 QvOjSvAYY5DOQbNUjaQgVRswN4E1XS2OerlqlkawxeAaqHo23gB9g4A+aG2yUO2cXC
	 nVIZWYi1KD0WlLbw08kX7/U6F2QlPFNrHtm8+pBkBlz2O3S1QdRDBnINpXOOPGaMn2
	 8HvQjJ8hYHx28xoDh9is8jd3DQj+lojqiDJGI6HY+67RyMNwu8A/Tqn4d9j4/ySvaQ
	 AVes9NOGB5lTY6f5KW/72h8cxpu/LwWBFoICkPBhuyhzzaB8nRtJBzYxLlWBgRSj7A
	 yiATQYvCJVTwItKMzQ/6/V63GkBZe2Q846qXJMIkMZCADav+Kyy0eeU3GxowevRNRq
	 71z/KUqZT5RR96rvtvVoX+XV686kyXdpnn/t+cbMFmhkzEHcHesIx8Li17LMk1jA7G
	 RiROYhDLW5MI+E8tOO969kCMdoKL1/RoywTSsOglEVNxbEnQjg/MK2hqy+EYbIo6c3
	 c29JO3dyAb+p0/roZ9t9BdNDRQijuk0DB/u3VVcKSEQVPtp686CcxwKxFUsVeSnjFv
	 BsSqoq9v0hgrpVlIYv+6L4RaE64CEgMYAZtf2A2P2fkqPoalcPUUZN9uGbv4nKLiBk
	 z0fkmmwghhCU0uuOsXczxC/E=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19A6140E0177;
	Tue, 30 Jan 2024 12:48:22 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:48:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, ravi.v.shankar@intel.com,
	andrew.cooper3@citrix.com
Subject: Re: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Message-ID: <20240130124816.GCZbjwEFrZS55FLxb8@fat_crate.local>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-3-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240127093728.1323-3-xin3.li@intel.com>

On Sat, Jan 27, 2024 at 01:37:28AM -0800, Xin Li wrote:
> When CONFIG_IA32_EMULATION=n, int80_emulation() is NOT defined, fix it.
> 
> Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
> Link: https://lore.kernel.org/lkml/20240126100519.GBZbOD3xFB0v3mp5B1@fat_crate.local/
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/entry/entry_fred.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index 06d00c60ea64..ac120cbdaaf2 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -62,11 +62,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
>  	case X86_TRAP_OF:
>  		return exc_overflow(regs);
>  
> +#ifdef CONFIG_IA32_EMULATION
>  	/* INT80 */
>  	case IA32_SYSCALL_VECTOR:
>  		if (ia32_enabled())
>  			return int80_emulation(regs);
>  		fallthrough;
> +#endif
>  
>  	default:
>  		return exc_general_protection(regs, 0);
> -- 

That .config is still not happy after this:

ld: vmlinux.o: in function `fred_entry_from_user':
(.noinstr.text+0x177a): undefined reference to `do_fast_syscall_32'
make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1158: vmlinux] Error 2
make: *** [Makefile:240: __sub-make] Error 2

I'm pushing the latest state I have here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-fred

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

