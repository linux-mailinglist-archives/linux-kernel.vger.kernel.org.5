Return-Path: <linux-kernel+bounces-85721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711586B9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1283628C236
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1747002B;
	Wed, 28 Feb 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K48JC7CR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B725E090
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155698; cv=none; b=s+m4unNvLkgu431QVWqFoG5UGyTklcjYBhVUKiVU6rehWt/dBkmKRYwHPBKjjcuOvqhLWesGQXuvcU0HC0WND2udIZKIuPHMIkGg7SQ2lv6VipvBycI9YUFxOiRmVHk3EJyDhSkilyI1qNIlctOsMVtBl1NmRmix8oIOwJNf/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155698; c=relaxed/simple;
	bh=3dIDQaoreVsP35DeuugHsbaowwopUIcEnpCBbtzEuHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkjOT6l3qrAr8nMxLgHVWBs6kLkBlLBH5d1WnwRZmYV7XeNmDTjqh6oK3x9fkayf6K1Q7tlakbXj1dAwpJvYny8rGuF2mXGPiUzRkn5FovHTu9SudJLfTpD+aH//aPkqzLJ3cCRvevyEg0e316BqIW1eOqpf8R33O4etPnuBYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K48JC7CR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E0B640E0196;
	Wed, 28 Feb 2024 21:28:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bbTlr61piUQS; Wed, 28 Feb 2024 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709155689; bh=mrtpMMMU+QRtgwBx9egaOKNLCVfOo1AaACfEyVQY6VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K48JC7CR/usfoAa3axmhZ3mOp/zplA3Dgjc10boxoaAlrDD83Y4PPEt/88TmIh4k8
	 BAPotG/lS0ZQUy2dANdKKLq0ZpHISOc3gRqIjkZaDvKz5+lEEtoEPP8ztYM/2cES8q
	 0oitf+xVw3w2kI2lL1GULX/DZlg8XOkeen9tawwmxB/9cfC2CVZVyoj/JYOUMzXlSE
	 trOFY/bVR8XVK6WNyL3m4m4jvaVraokt7fMLpo2ACJPpuF2WYcwyVLqd+x3XRgUoQo
	 GwfouMWiG17+r4QcOg3IaHjbeARZ/Z0gxsd+kRdAr8MVik9xct6fcxD3NbQp2syaxY
	 TlTHnmUEuEXmC7f6C5XtbqGZgLJ6NpjMrVPdarkJ0GkLkxgd9wi2I76ZPwDIONbjuA
	 Q6tp3gaRqPrhwG2Bt+hbv6xjG2UmdFHOmY6UvwlGSyShzOHdUjLGXIpjPI8pku7PSg
	 o4qJ5h7OGTE17xyEn3JpAjmP8nfJq7C8yHZbux+8Qx+Z9lV1EsYurtZQin6chfCCdc
	 lcCg+GWoE5WPc8HJ38chE9+w+CFiAMPR0M/5DOIxBEDB9K4oSHTqgi8FxinzvMNOAb
	 mWZ+n6Gn0BTbrf21r3M3WXj+dTz6VEih+5JXfduuO2OuzMpD93TbJA1w4MQkdIAaKR
	 e92WW8waCQUlQ9lRoHsoigZk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3140240E019B;
	Wed, 28 Feb 2024 21:27:58 +0000 (UTC)
Date: Wed, 28 Feb 2024 22:27:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 3/9] x86/startup_64: Simplify calculation of initial
 page table address
Message-ID: <20240228212751.GJZd-lVzA6B9yIe0Zk@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-14-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:11PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Determining the address of the initial page table to program into CR3
> involves:
> - taking the physical address
> - adding the SME encryption mask
> 
> On the primary entry path, the code is mapped using a 1:1 virtual to
> physical translation, so the physical address can be taken directly
> using a RIP-relative LEA instruction.
> 
> On the secondary entry path, the address can be obtained by taking the
> offset from the virtual kernel base (__START_kernel_map) and adding the
> physical kernel base.
> 
> This is implemented in a slightly confusing way, so clean this up.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 25 ++++++--------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

