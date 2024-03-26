Return-Path: <linux-kernel+bounces-118592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8688BCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65F11F3BFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772E18B04;
	Tue, 26 Mar 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fefla831"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3F1C2BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443557; cv=none; b=Vai/lBU8cB+JBmsWwkaxRcNcagBX0JR0r/UkFWu0pU5J4Yy8ukFimIusXiIOW+xeRfiDgNxrb9fnh6NfSIsHmmm1W4AIzzH/i4rvBdhwQUrkFHBynAXCdw72kCBTJuJCbZz+IduBxJDi6VvhdG7LIQxUYj07XljR240jgvKBtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443557; c=relaxed/simple;
	bh=JQUcYa55YWe6URT24FF22nspI3258qVvV/c52rDJNis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyX4cgF37Z9mkfEGWcR2An5mo5nMaC2eMNufPGoPwUPnE3KutsWovwsM1XqA0yG25Co6ZQ2NkfhwrrcUzZG2FoRIzr4gOr/8YlWuFrZTLdseMtnPOnp8tSe9fEWBXuNV8iGgI784s2sIQ0ARWoT4AlFd7Ltd7khfWHUD0DRqw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fefla831; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE27DC43390
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711443556;
	bh=JQUcYa55YWe6URT24FF22nspI3258qVvV/c52rDJNis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fefla831+rH2LP7Fj8sBTWvyx0vjtgi7ZwYGDZL6vf7YoqJpKocOZ+6SkddpRF1kP
	 yLldb0mNEfpytdW/bFV8IO3PN/JzNxw3gjB5xXNJj9FzT9e2XuZBhIlb0NgLEDvJGY
	 92JiBh0bJ1oEBK/WTpvIXO5QdCQ0oAYB59nlW5e/8B4sCm0dKPKzv7HxnndVa2dbEi
	 nvEjSPJMwBGYFUUv2pTnRkyW+9DakDKMVNx0J+5folVtlik9byo/UQwncyOkvLDzqy
	 c95cdNiKp4n8evmoc8PYubJgbfZCNL5z/H6k2LQMfzfIbska6MsFMEkPgFz0lEcSwY
	 WlxPosPBgGnsg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so1079421fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV52S+jy292qcjcMS+DPZgJJJk6vwkf5viAd65qcNSzmsA68zu31+hND5Z8NTKuPVGPOq8jr1WFNSanvPESkUUKJ4HRIE5ziLmp9coB
X-Gm-Message-State: AOJu0YybCHAuY2+PQ0WrN9S15ef9ItMzqvCcqg5DAdk0Pm4wjL55NrUr
	/lXhCCRYsFybvdGeO8aPszHrevCQruUtZXa1N0uLc0kkNWjMBaJYc/rz+LRYdaEmXb0YLSKfEzk
	2EsnW+bVj0u2hE1X4hoGe2V0ib34=
X-Google-Smtp-Source: AGHT+IFfi/2Q8jfll0xvVyaGQD54qbE3f5lDe2sICSST5KdE28QD92QVbSCVl1hvUSwYKBa5Je9BNmg+9az1X4LLAg0=
X-Received: by 2002:a2e:998b:0:b0:2d4:973e:247f with SMTP id
 w11-20020a2e998b000000b002d4973e247fmr428618lji.23.1711443555065; Tue, 26 Mar
 2024 01:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403221630.2692c998-oliver.sang@intel.com> <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
 <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com> <ZgKH0LbdN0aDyvRe@xsang-OptiPlex-9020>
In-Reply-To: <ZgKH0LbdN0aDyvRe@xsang-OptiPlex-9020>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Mar 2024 10:59:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG2D8cwtXTqjepm30B9X9KQD_q2XMDAA522mv9z-5_-ug@mail.gmail.com>
Message-ID: <CAMj1kXG2D8cwtXTqjepm30B9X9KQD_q2XMDAA522mv9z-5_-ug@mail.gmail.com>
Subject: Re: [linus:master] [x86/sme] 48204aba80: BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
To: Oliver Sang <oliver.sang@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:31, Oliver Sang <oliver.sang@intel.com> wrote:
>
> hi, Ard Biesheuvel,
>
> On Mon, Mar 25, 2024 at 04:39:26PM +0200, Ard Biesheuvel wrote:
> > On Sun, 24 Mar 2024 at 16:26, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 05:03:18PM +0800, kernel test robot wrote:
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> > > >
> > > > commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME kernel encryption handling into .head.text")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > >
> > > > [test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
> > > > [test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]
> > > >
> > > > in testcase: boot
> > > >
> > > > compiler: gcc-12
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > >
> > > My guest boots with your .config and SNB as CPU model:
> > >
> > > ...
> > > [    0.373770][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
> > >
> > > Artefacts like:
> > >
> > > -initrd initrd-vm-meta-180.cgz
> > >
> > > or
> > >
> > > RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3
> > >
> > > I don't have and don't know how to generate here so I can't run your
> > > exact reproducer.
> > >
> >
> > I ran the reproducer using the instructions, and things seem to work fine.
> >
> > https://paste.debian.net/1311951/
> >
> > Could you provide any information regarding the QEMU version and its
> > BIOS implementation?
>
> for QEMU version:
>
> $ qemu-system-x86_64 --version
> QEMU emulator version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
> Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
>

I tested the exact same version.

Does it reproduce with -cpu host instead of -cpu SandyBridge? When
running under KVM, I suspect emulating the actual host uarch rather
than setting a different one is a more reliable strategy. What CPU
type does the host have?

>
> for BIOS:
>
> We don't specify bios option for qemu, my understanding is we just run with
> default bios for qemu (the seabios). Extra info of seabios
>

Today, legacy BIOS boot is only used by a minority of x86 systems in
the field, so for better coverage, it would make sense to at least
start testing UEFI as well.

On debian, just install the ovmf package, and pass -bios
/usr/share/ovmf/OVMF.fd on the QEMU command line.

And given that you are doing virt based boot testing, another very
important use case is TDX boot (as well as SEV-SNP, but that may be
more difficult for you to organize). But please explore internally at
Intel whether TDX can be added to your test matrix as well.

