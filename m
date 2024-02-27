Return-Path: <linux-kernel+bounces-83438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B270886993D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C9F1C2183B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F14145B2A;
	Tue, 27 Feb 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUfmyHML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23D1419A0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045735; cv=none; b=OG/fyZbtYDEiGRmFArUPVN7Th3y1CMG7ZpCLhD2QBkmTTxkQ8oAzVLB+VyM5indvsEfma5qoiLz3h8lEcrY14FlaljtvXi78iTh2pQSBtmFh63pkF3wKYymHx4aK+QVzESgbWF3yrapm5FJFljL+yqd4sYpSDFFmVMS00TQ4xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045735; c=relaxed/simple;
	bh=ds8/9433ZYz3tmpn+R2cXzGsm5jsDoRzmZrqieGcGd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbhwlOLMNwbv2D7WuIRH+fylNCsavVthqC7Q+u4SDjxhRjBh3G8pBdAmPsLu1kkIB88ShUw2/1P6AwRRkPYH6ILxeSI7tzzAWYzV/y6bpTjAL0IfnGcDhei8QcYZU5cbFqb1HMLm6VvCF2KSHFYVVP63UH2YySFhpLJCpdTzMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUfmyHML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB63C43609
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045734;
	bh=ds8/9433ZYz3tmpn+R2cXzGsm5jsDoRzmZrqieGcGd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mUfmyHML1CDFZyyw9O6ENeNgLt8jXIwqQiNC1Fb+IMwk2gL11ZJwroCbhfrIoCex1
	 wziGyFp5yTg39LFBC+AeReTdDUZJKv7ejmiZo2oR5R4g/FEeNe0/AGUosumSUxk6rb
	 6ZxkylFRn8H0lZ3reC17AhrpuADxgRaNs9xOFhn9xmiYbZj/0XsbGlni0NjGnk/kuT
	 4EBJNZo6VnUrq9iZaEoCkyIQmZlrjZNP50CqDrBkffG1AG08CrJpXm5rW4tm+rd7b0
	 DR6bEV6vacqLjSHJxe+jfcigbmQGYD2RNiFTam87MkKsF560n5mMjA79b/UCp6QNzg
	 OHnruzh1v02zw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so4537451e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVE+daA4zEw8GLbc6zzR/Q2QlHjxtsx4R2qNcalMnYV+7YN+l9497kUtos8oVbYFo36spCLYNCLWvct47pQnpC98q8DjLXSq6Ns/oTK
X-Gm-Message-State: AOJu0YzHbnmWLZnKtaLca7s4akOXFseaottBO5teCbXi2vN2ytY50yTx
	umMx7vMpitvcN3r4sSUUb1H8twC112rHlEkgwcaAXL4YSuzBJDnIFDrLT0e71ix7w6fZ6Hnl1dv
	4c9WnHUKXQPJbCIlPX6YmUJDCIm0=
X-Google-Smtp-Source: AGHT+IFFivXC04IrthwNf/B6kmRqj3Y+E406GsG0DFdyric4Qksl/jWQr9a52gO7g35IkgOfAc87/rQ3XueK6D5g57U=
X-Received: by 2002:a05:6512:308a:b0:512:e57d:c9c9 with SMTP id
 z10-20020a056512308a00b00512e57dc9c9mr7931763lfd.13.1709045732557; Tue, 27
 Feb 2024 06:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com> <20240226142952.64769-17-ardb+git@google.com>
 <229aaa22-5e69-4f18-b5f7-fec83109bb53@amd.com>
In-Reply-To: <229aaa22-5e69-4f18-b5f7-fec83109bb53@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Feb 2024 15:55:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGRTO=HupSKtGhpCpMt4nNpQLzuAUzRj8Qvdfnc2E=W5g@mail.gmail.com>
Message-ID: <CAMj1kXGRTO=HupSKtGhpCpMt4nNpQLzuAUzRj8Qvdfnc2E=W5g@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] x86/sme: Avoid SME/SVE related checks on
 non-SME/SVE platforms
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 22:38, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/26/24 08:29, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Reorganize the early SME/SVE init code so that SME/SVE related calls are
>
> I'm assuming you mean SEV here and in the subject line.
>

Yes.

> > deferred until it has been determined that the platform actually
> > supports this, and so those calls could actually make sense.
> >
> > This removes logic from the early boot path that executes from the 1:1
> > mapping when booting a CONFIG_AMD_MEM_ENCRYPT=y kernel on a system that
> > does not implement that (i.e., 99% of distro kernels)
>
> Maybe I'm missing something but I don't see how this has changed anything
> other than moving the call to sme_encrypt_kernel() within the if statement
> (which means the check at the beginning of sme_encrypt_kernel() could be
> changed do just check for SEV now).
>

The idea of this change is to avoid calls into SME/SEV related code,
in a way that can easily be backported to -stable kernels.

The reason is that the SME/SEV code has changed much more than the
rest of the code, and so backporting this entire series is going to be
messy, as well as unnecessary given that those kernels are not
expected to get all the latest SEV related changes anyway. We do tend
to try and keep those -stable kernels building with recent Clang
versions, and so keeping the SME/SEV code out of the boot path
entirely would help running into codegen issues such as the ones this
series is working around in code that is substantially different from
the latest revision.

However, I decided to drop this patch anyway. The mainline code should
be obviously correct, and introducing potential problems this way does
not justify the goal of easier -stable backports.

..
> > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > index 0166ab1780cc..7ddcf960e92a 100644
> > --- a/arch/x86/mm/mem_encrypt_identity.c
> > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > @@ -45,6 +45,7 @@
> >   #include <asm/sections.h>
> >   #include <asm/cmdline.h>
> >   #include <asm/coco.h>
> > +#include <asm/init.h>
> >   #include <asm/sev.h>
> >
> >   #include "mm_internal.h"
> > @@ -502,18 +503,15 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
> >       native_write_cr3(__native_read_cr3());
> >   }
> >
> > -void __init sme_enable(struct boot_params *bp)
> > +void __head sme_enable(struct boot_params *bp)
> >   {
> >       const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
> >       unsigned int eax, ebx, ecx, edx;
> >       unsigned long feature_mask;
> >       unsigned long me_mask;
> >       char buffer[16];
> > -     bool snp;
> >       u64 msr;
> >
> > -     snp = snp_init(bp);
>
> The snp_init() call is here because the SNP CPUID table needs to be
> established before the below CPUID instruction is executed. This can't be
> moved.
>

Yeah, good point. I didn't spot this in my SEV-SNP boot testing,
presumably because the firmware's VC handler is still active in my
case, but this isn't guaranteed, e.g., when booting via the
decompressor, or when using 5-level paging.

Thanks for the review.

