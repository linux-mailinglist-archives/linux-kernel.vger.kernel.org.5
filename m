Return-Path: <linux-kernel+bounces-32096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E027B835668
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4863FB21F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A5376F1;
	Sun, 21 Jan 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A8KQKEVm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10938F83
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851480; cv=none; b=oA7ejzXtO1I5YQdb1HXF/r1IVbBM/W3vRCFkik1LAP1508vOyHIOwLNpimueQcWfd6lNH1Zs9ihbHlCDRZ7CnTjnVb6pJvT6LcXjTATkautMPe4wbrSYrmKoT8rnCokqSiUHChuZZnCMWCTUGaKu5Qwrq178qr1DjZ6hkZNeV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851480; c=relaxed/simple;
	bh=sk89c5wAA9T/eEk0jssFTcZ1m2eTx2B+mBNMYr5joLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQYTDKemioj9o1cAU940HrFq/3IO0ASYqEKd46wjXpnz9mLuAt5if52kE+mbV8LMjg6eSfH1JRlpgexFxoQj6GH93/AfUzKlYwOLNsYUIdAtswCUQVdSrhV5bOe94v7HonWjvG+I6FaFkZUqL/2LxWLRDARC05ak346aVPnmo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A8KQKEVm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7163540E01B2;
	Sun, 21 Jan 2024 15:37:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QxjcWj3ZGZWC; Sun, 21 Jan 2024 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705851473; bh=zSxrQvmiuFKpwroAA+fwUMokTVMV35wjeMP3GTqLHvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8KQKEVmmfyozyZtGrC0TCKQrRzZb0/O9wkh6sHG5V/j9vKmeBCQFYlhnqeKRyYgG
	 ejyEAD6OD5tnuUhB7rzAGLwh9wR0r/4l6rd/I5RM9J8TWcFEcRNOk/HAzd2LGFm3SI
	 5TvRGICkNYeSIJSb3xREMYYmTRfOMUUfdPSHxLjr3hiCi6L3WQ8SpV7LA+fxM6t+k8
	 PVZ6GZr8zuVxsJCunRWtfIQ2zFZJtTs9BRWKtsmQNPCJ8Cg7froQPHW6SRMv4I7w7b
	 niUX1q9UE6SfBW+gkvgBdOiMnBjNHWYaQwMAhX3a5kDmgqA+GseckbVgS3gGmDMAqF
	 nY8OnUK4SpUq5dcVIjLWxKI3TDreLLL+P02n3TO4PumL/1q9lkZTWwJKs6yBvvcTuE
	 3dWeIuoCi5xT8NE2QSR2wXQQQJWcQ3brKMZaR91n/y1ZeODaaAEiSy/w3TCZ0f7Ub9
	 Dkv0Iutx6IrbjvW9NNiQligRVhFIH8ClnpLEwyz6kn/uU2TnbxW43r8Sh0U0Bm6KFu
	 ZEOJJUIdne7C6PSXaTdqDnS8c9zBH/+oAmGcb4d0sy0AQ2RIcNdaymtltcM60I8UaA
	 bliFNoNOl7f312tOpybQ3I530lF3TqHP2/Z3byBRpmq4/DqWjW8gULDqDudT9nPFQu
	 BGtkzzAUp2OnQ5X0wrszQRcE=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D96C740E0196;
	Sun, 21 Jan 2024 15:37:08 +0000 (UTC)
Date: Sun, 21 Jan 2024 16:37:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Steve Rutherford <srutherford@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>,
	Joerg Roedel <jroedel@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240121153702.GAZa06Hvt8b0hQ4LjR@fat_crate.local>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
 <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local>
 <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
 <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com>

On Sun, Jan 21, 2024 at 03:12:56PM +0100, Ard Biesheuvel wrote:
> My preliminary conclusion confirms that the SEV code is quite
> problematic in this regard (which is the reason for this patch, so we
> already knew that, of course).

So we can try to improve the situation gradually so that we don't
break current usages.

> TL;DR I think we will need a way to build certain objects with -fPIC
> (as we do in other places and on other architectures), but we should
> add instrumentation to ensure that these issues can be detected at
> build time. The SEV boot code is especially tricky here as very few
> people can even test it,

No worries about that - us, the Google cloud folks, AWS and a bunch of
others are people I could think of who could help out. :-)

> so applying this patch and hoping that the compiler will never
> generate reachable code paths that only work correctly when executed
> via the ordinary kernel virtual mapping is not sufficient.

..

> 1)
> WARNING: modpost: vmlinux: section mismatch in reference:
> startup_64_pi+0x33 (section: .pi.text) -> sme_enable (section:
> .init.text)

sme_enable() is in the 1:1 mapping TU
arch/x86/mm/mem_encrypt_identity.c, see

  1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")

so might as well move it to .pi.text

The rest below look like they'd need more serious untangling.

Btw, I just had another idea: we could remove -mcmodel=kernel from the
build flags of the whole kernel once -fPIC is enabled so that gcc can be
forced to do rIP-relative addressing.

I'm being told the reason it doesn't allow mcmodel=kernel with -fPIC is
only a matter of removing that check and that it *should* otherwise work
but someone needs to try that. And then there are older gccs which we
cannot fix.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

