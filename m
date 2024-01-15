Return-Path: <linux-kernel+bounces-25906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200A82D7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984F1B21272
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79C1E86D;
	Mon, 15 Jan 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T8RytRwW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9C2C683;
	Mon, 15 Jan 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C9C340E01B0;
	Mon, 15 Jan 2024 10:57:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CT0U0ryi_cwl; Mon, 15 Jan 2024 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705316221; bh=dBLz6sHRTRwRzMhz1RnAxa5woAu6m0QqdNFPLlvlckg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8RytRwWb4406iHrxFvcsDwWYNL/Ych+TUHeFTixndVm9ncfjPwSTFtz2kJKTpMAf
	 ok/GU/iAXjyXTERCD+dscHgqCMRCIVhqSA6AhSpg7plWuZn0NzsNWu7DJj1ODtMRBw
	 Z3pfX5bDah8VsMhivMkwO5WBKzBRlPKFNYM0Fq1krhxFvd24BNC0j3ZPYKESMnv+1V
	 gz8bTrJszlrh9ax2/VVDNt9IGEp46/EiZ2s4f55+D1zWnr3DrPI+efx3oWSvlNZm41
	 rQ8pGhBmOhFUNfjILMO3pXNPyYDbyBPKCkqR+LjcFhz2Xo8mRRg9AjVzc6q+ZXXMNN
	 d6pEHYda/Ev+ybTwjXVEK/o048umMEYl9s6TcBuLuZlAnG9JaNBpzNqSLB6M3/u8QP
	 QtIK2RrNzl7jpoHKqghXID+N1jPo2hlnKYpWzgy3ZfwhbnfZ8yr3ccESId2puR8V+1
	 S3d2tkVFbNkr4f4uRaSVfRBe7js62JeGvuYF+0umuBP0FFD/mD6ZxzTSuhYrb9rp4h
	 GpNqYcQKoVzljA5t+i/Yg2BLbM0rvD1fKK4fOry+4DGvLGWaSYH9yzcicV6fRDMjhB
	 PKcSGWr9O0po1PTh7M52fKZtCQJtO7/Bif9WXc8BEr15TcRZn4EKgxdD3Ns5XP4dj1
	 tZ5WTuONm6w3mj1c528XInlo=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F9D540E00C5;
	Mon, 15 Jan 2024 10:56:55 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:56:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
Message-ID: <20240115105650.GDZaUPcgv2rkWI921b@fat_crate.local>
References: <20240115102202.1321115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115102202.1321115-1-pbonzini@redhat.com>

On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
> 
> Builtin/initrd microcode will not be used the ucode loader is disabled.
> But currently, save_microcode_in_initrd is always performed and it
> accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
> particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does not
> implement the MSR and the result is a call trace at boot for TDX guests.
> 
> Mainline Linux fixed this as part of a more complex rework of microcode
> caching that went into 6.7 (see in particular commits dd5e3e3ca6,
> "x86/microcode/intel: Simplify early loading"; and a7939f0167203,
> "x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bare
> minimum in stable kernels, setting initrd_gone just like mainline Linux
> does in mark_initrd_gone().
> 
> Note that save_microcode_in_initrd() is not in the microcode application
> path, which runs with paging disabled on 32-bit systems, so it can (and
> has to) use dis_ucode_ldr instead of check_loader_disabled_ap().

.. simply because save_microcode_in_initrd() is a fs_initcall and by
then 32-bit has managed to enable paging.

> Cc: stable@vger.kernel.org # v6.6+
> Cc: x86@kernel.org # v6.6+
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 35d39a13dc90..503b5da56685 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -214,6 +214,11 @@ static int __init save_microcode_in_initrd(void)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  	int ret = -EINVAL;
>  
> +	if (dis_ucode_ldr) {
> +		ret = 0;
> +		goto out;
> +	}
> +
>  	switch (c->x86_vendor) {
>  	case X86_VENDOR_INTEL:
>  		if (c->x86 >= 6)
> @@ -227,6 +230,7 @@ static int __init save_microcode_in_initrd(void)
>  		break;
>  	}
>  
> +out:
>  	initrd_gone = true;
>  
>  	return ret;
> -- 

Makes sense to me.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

