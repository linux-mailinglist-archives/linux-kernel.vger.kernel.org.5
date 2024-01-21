Return-Path: <linux-kernel+bounces-32072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E9835606
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E89B229CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC2374E4;
	Sun, 21 Jan 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbk0aL3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D7374CC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705846390; cv=none; b=JxAGgOe43O4orq1r+mfsEPAtLR7OPargnlS976SaHLQ1E4i+R26qQff3oHa6bThMytEfGvFX8MMaoZ3lbwNpEAsqgNJyUr+wq0Z4skxe8wfLkbchLXJ4hXM/XmGr25ozxBCImNNDUWjS20o6kthIm/tgyzdcp2pjC1+z4XtZAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705846390; c=relaxed/simple;
	bh=93nlBq01+/R25XO6WFV6nXv5nI6SYaa/g5F1Y7cEzng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGJuE+SgSa74Sm959ETR7xU1V7athuPccr5LGP+ickP6rKR8VkjMO7Tc2leo3asUQELI4YZkiU+ugg7RvvXBPOiO+IpTJnL6bZngsyGHi9B4PM45A9smTlmwPak+t6pc4wUo4jGup1OLmDNb15timMfxOFmDYll2MQX1E3Ri5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbk0aL3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B3AC43142
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705846389;
	bh=93nlBq01+/R25XO6WFV6nXv5nI6SYaa/g5F1Y7cEzng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cbk0aL3nUdkUhAL+1Wf1HilycWoHWRY9yDxRbRV5u19rf5FQH6w3n313+Tl06YI+o
	 m48AAiOrMNQuQR50OOvvVFr9ZOyuTsYQRXzitVBL/CjWEW37yoXaBKIgy5/9dFaZ7U
	 klkQic6Zl1YETFfqUZQfadwurtjPPqqmiU7aSwTSrjOCKc1p0f5vkxLGhw6VMg6bj7
	 ZSLnzUyY5Le70971gJVppcKLuaZkmfa7qM6TEHJvnvbLtrnCkqLji3h1pgT+LYxZPb
	 kLZ75r97jCCW5uZgMx504s9ius3sx7nSStdiJJLTS5pUuoCGP/kYoAOcMb8abYDx6e
	 oxAb+aH4B/cbA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso22105141fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 06:13:09 -0800 (PST)
X-Gm-Message-State: AOJu0YxEreQfaeN3hQllXL9ubXnoxIMWOxcBRVE82W+1t6Fmh95Bga0s
	lq2Qn7sd/WSCiVU4wcsmPcehQyYk4TrNljIg0ZhyP1voCzN4PfMWl6jy+ZuIlOugf5wn3krSE+N
	oItPEUrFzvai7QrC28ldBzSOVnAc=
X-Google-Smtp-Source: AGHT+IGrUGrnjbKM61VvfEhxcFAefz8MbgAJ03qJrEO4R2GdMx67v4+DOerGiUD93x+5IQksusbst8XkKXxOMo4T4oY=
X-Received: by 2002:a2e:701a:0:b0:2cd:9067:6bd2 with SMTP id
 l26-20020a2e701a000000b002cd90676bd2mr1452981ljc.7.1705846387577; Sun, 21 Jan
 2024 06:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local> <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local> <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
In-Reply-To: <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 21 Jan 2024 15:12:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com>
Message-ID: <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Borislav Petkov <bp@alien8.de>
Cc: Kevin Loughlin <kevinloughlin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Kelley <mikelley@microsoft.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 14:38, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Jan 2024 at 14:06, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Jan 17, 2024 at 11:59:14AM +0100, Ard Biesheuvel wrote:
> ...
> > > On arm64, we use a separate pseudo-namespace for code that can run
> > > safely at any offset, using the __pi_ prefix (for Position
> > > Independent). Using symbol prefixing at the linker level, we ensure
> > > that __pi_ code can only call other __pi_ code, or code that has been
> > > made available to it via an explicit __pi_ prefixed alias. (Happy to
> > > elaborate more but we should find a smaller audience - your cc list is
> > > a tad long). Perhaps this is something we should explore on x86 as
> > > well (note that the EFI stub does something similar for architectures
> > > that link the EFI stub into the core kernel rather than into the
> > > decompressor)
> >
> > Grepping through the tree, is __pi_memcpy one example for that?
> >
>
> That is an example of a function that is known to be callable from any
> context, and so it is emitted with an alias that makes it accessible
> to other code that is position independent.
>
> There is some linker foo in arch/arm64/kernel/pi/Makefile that builds
> a couple of objects in PIC mode. The source symbols have ordinary
> names (even the external imports), but will be renamed by the linker
> to have a __pi_ prefix. The result is that those objects can only call
> into each other, or out to ordinary code that has been marked as __pi_
> as well.
>
> The entry into this code is
>
> arch/arm64/kernel/head.S:885:   bl      __pi_kaslr_early_init
>
> which is called before relocations have been applied, as that requires
> knowing how the kernel base address is randomized.

I've done a quick experiment with moving the early code that runs from
the 1:1 mapping into .pi.text, and getting modpost to warn about calls
from this section into other text sections.

My preliminary conclusion confirms that the SEV code is quite
problematic in this regard (which is the reason for this patch, so we
already knew that, of course).
Below are a couple of examples of how these calls fan out.

TL;DR I think we will need a way to build certain objects with -fPIC
(as we do in other places and on other architectures), but we should
add instrumentation to ensure that these issues can be detected at
build time. The SEV boot code is especially tricky here as very few
people can even test it, so applying this patch and hoping that the
compiler will never generate reachable code paths that only work
correctly when executed via the ordinary kernel virtual mapping is not
sufficient.





1)
WARNING: modpost: vmlinux: section mismatch in reference:
startup_64_pi+0x33 (section: .pi.text) -> sme_enable (section:
init.text)

leads to

WARNING: modpost: vmlinux: section mismatch in reference:
sme_enable+0x21 (section: .pi.text) -> snp_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference:
sme_enable+0x99 (section: .pi.text) -> cc_set_mask (section:
init.text)
WARNING: modpost: vmlinux: section mismatch in reference:
sme_enable+0xf8 (section: .pi.text) -> cmdline_find_option (section:
text)
WARNING: modpost: vmlinux: section mismatch in reference:
sme_enable+0x10c (section: .pi.text) -> strncmp (section: .text)
WARNING: modpost: vmlinux: section mismatch in reference:
sme_enable+0x129 (section: .pi.text) -> snp_abort (section:
init.text)

2)
WARNING: modpost: vmlinux: section mismatch in reference:
startup_64_setup_env+0x27 (section: .pi.text) -> vc_no_ghcb (section:
init.text)

leads to

WARNING: modpost: vmlinux: section mismatch in reference:
vc_no_ghcb+0x46 (section: .pi.text) -> do_vc_no_ghcb (section:
init.text)

leads to

WARNING: modpost: vmlinux: section mismatch in reference:
do_vc_no_ghcb+0x55 (section: .pi.text) -> snp_cpuid (section: .text)
WARNING: modpost: vmlinux: section mismatch in reference:
do_vc_no_ghcb+0x66 (section: .pi.text) -> __sev_cpuid_hv_msr (section:
text)
WARNING: modpost: vmlinux: section mismatch in reference:
do_vc_no_ghcb+0xc1 (section: .pi.text) -> __x86_return_thunk (section:
text..__x86.return_thunk)
WARNING: modpost: vmlinux: section mismatch in reference:
do_vc_no_ghcb+0xd4 (section: .pi.text) -> sev_es_terminate (section:
text)
WARNING: modpost: vmlinux: section mismatch in reference:
do_vc_no_ghcb+0xd9 (section: .pi.text) -> __stack_chk_fail (section:
noinstr.text)

3)
WARNING: modpost: vmlinux: section mismatch in reference:
__startup_64+0x39d (section: .pi.text) -> early_snp_set_memory_shared
(section: .init.text)

leads to

WARNING: modpost: vmlinux: section mismatch in reference:
early_snp_set_memory_shared+0x18 (section: .pi.text) ->
early_set_pages_state (section: .text)

leads to

WARNING: modpost: vmlinux: section mismatch in reference:
early_set_pages_state+0x151 (section: .pi.text) -> __warn_printk
(section: .text)

