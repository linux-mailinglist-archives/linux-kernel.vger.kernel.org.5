Return-Path: <linux-kernel+bounces-50682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF90847C86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D18E1F27373
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE9126F13;
	Fri,  2 Feb 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0DPef5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B25FF01
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914058; cv=none; b=tHrdk6rb5MxSEDXjSr8PSx/UG13GTYCW6Y5+g5I06abXh9EZPRHRaEx7Pp/uAiuE764mODid3mMOgV3rT/kYukel84lTrE02a3MAcrVbNDqV1fzi7HNyzDpuvEQEZQQBWVrzHxEtRUzXDajFvTG4dAlVRn92R7c98WtaukZMcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914058; c=relaxed/simple;
	bh=FRA7NClfGuH+mvD0ef76LKG3VhCS7wCAZ28qMHUqieI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvvPsi2bQ4Go6Yjsb/ExIcDDE1D+izUMNqrwsd8i/vmN2FwiVQS8MfTwtv+5ivlTb3bkmoyXO3GSfsInoVZcuf2XnQ5jR4x8uSkvuUKRSpKi9zkotTcwIsfHwZIbpYK830fMqj8Hy5L+XPfJ7aybQ2KCmLABWCK6ISxmCpjp9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0DPef5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E98C433C7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706914058;
	bh=FRA7NClfGuH+mvD0ef76LKG3VhCS7wCAZ28qMHUqieI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n0DPef5gSNxToXTohsSeZcihSpMaSpUKBj1kmxQ8Ovo7ep11yIBePTRjz5D+Lwryz
	 a0vbIvbGQGl8DzLy4D7sA9GTwhVxhN7fxbEVxyJtmR18bQF5zWJOUPO7ylgibJRtAM
	 bOtiZIJJBs34wQGc0i+FUULk+gksBFUAUOwmrNfxCWX7rHeYYXOqyyp3ZAS+mA9apz
	 oXFAh7ANei2JCeeujyMqZdbkMUjmSkVysc3OrQ7AMRUI1H2hj7pAcHhex2qHptN+WB
	 h2+zOnv4OsTzsGTmZ5llFqSWL4MrFD4611phCPcz2wUtUuY8R3vYqHw38nG7O9fhIx
	 rW+caqU/Yuc/g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eac018059so3183198e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:47:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yyn6c6n+7Ou+/TAvLRQqcVkOJ/CK0u4zYzc24L06neGG3ljgfcy
	9fEZ/iSaPPEyt0zeQo7gYfEaUXiV9bhpq6G7o6agLTZzz9DCRKCSn85wIZjBp/Q8uAgeTkgEK3t
	mcT3j8/BTSpTjd9XFPIVzIpYyDRw=
X-Google-Smtp-Source: AGHT+IGAzmBgx5AlqOdWC/vDn6AUUi/qQxt6yaKcueUyhjFL6OzyVjxU3IlOHtv5MDQph0qKWSywZKeI5DIYd67c5jM=
X-Received: by 2002:a05:6512:62:b0:511:1ed7:61bd with SMTP id
 i2-20020a056512006200b005111ed761bdmr2339301lfo.54.1706914056299; Fri, 02 Feb
 2024 14:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-2-kevinloughlin@google.com> <4ljfvg7c23g2wx4hcqz6x6tx7uvp6fffayqvu4ptsmfqajlujr@zngokbd2awma>
 <CAGdbjm+dt2LMqsWkzME-Gya9F=pZMubTuW3Ad3dStj=L+MW+ng@mail.gmail.com>
In-Reply-To: <CAGdbjm+dt2LMqsWkzME-Gya9F=pZMubTuW3Ad3dStj=L+MW+ng@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 23:47:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGSZkJ-1opx9mrpfhzyreCM+P616xM+MhPOaR+EgP5NNg@mail.gmail.com>
Message-ID: <CAMj1kXGSZkJ-1opx9mrpfhzyreCM+P616xM+MhPOaR+EgP5NNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 at 23:00, Kevin Loughlin <kevinloughlin@google.com> wrot=
e:
>
> On Wed, Jan 31, 2024 at 12:20=E2=80=AFAM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Tue, Jan 30, 2024 at 10:08:44PM +0000, Kevin Loughlin wrote:
> > > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/as=
m/mem_encrypt.h
> > > index 359ada486fa9..b65e66ee79c4 100644
> > > --- a/arch/x86/include/asm/mem_encrypt.h
> > > +++ b/arch/x86/include/asm/mem_encrypt.h
> > > @@ -17,6 +17,20 @@
> > >
> > >  #include <asm/bootparam.h>
> > >
> > > +/*
> > > + * Like the address operator "&", evaluates to the address of a LHS =
variable
> > > + * "var", but also enforces the use of RIP-relative logic. This macr=
o can be
> > > + * used to safely access global data variables prior to kernel reloc=
ation.
> > > + */
> > > +#define RIP_RELATIVE_ADDR(var)               \
> > > +({                                   \
> > > +     void *rip_rel_ptr;              \
> > > +     asm ("lea "#var"(%%rip), %0"    \
> > > +             : "=3Dr" (rip_rel_ptr)    \
> > > +             : "p" (&var));          \
> > > +     rip_rel_ptr;                    \
> > > +})
> > > +
> >
> > I don't think it is the right place for the macro. The next patch uses =
for
> > things unrelated to memory encryption.
>
> You're right; with the cleanup, I agree it becomes more general. We
> can move it to arch/x86/include/asm/asm.h.
>
> >
> > > @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned long=
 physaddr,
> > >        */
> > >
> > >       next_pgt_ptr =3D fixup_pointer(&next_early_pgt, physaddr);
> > > -     pud =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], ph=
ysaddr);
> > > -     pmd =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], ph=
ysaddr);
> > > +     early_dynamic_pgts_ptr =3D fixup_pointer(early_dynamic_pgts, ph=
ysaddr);
> > > +     pud =3D (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> > > +     pmd =3D (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> > >
> >
> > This change doesn't belong to this patch. Maybe move it into the next
> > patch and combine with removing fixup_pointer().
>
> I'll put it in a separate commit even preceding this one, as it's
> actually a bug in the existing fixup pointer logic that I noticed when
> transitioning to the use of the RIP-relative macro. Specifically,
> early_dynamic_pgts is a global variable just like next_early_pgt and
> thus also needs to be fixed up to guarantee the correct address is
> used across toolchains.

No, this is not a bug.

early_dynamic_pgts is a two dimensional array

extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];

and so this expression

early_dynamic_pgts[(*next_pgt_ptr)++]

produces the kernel virtual address of one of the top level elements,
which itself is an array, and so this can be fixed up as usual.
IOW, the [] operation does not result in pointer dereference here,
only in pointer arithmetic.

