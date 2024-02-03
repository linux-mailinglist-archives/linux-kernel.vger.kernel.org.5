Return-Path: <linux-kernel+bounces-50758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7E847DA1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AE81F27893
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAD643;
	Sat,  3 Feb 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTaWMhq8"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB016FB2
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919111; cv=none; b=GMj141QrxpB5rG/1TiMRwPGYcLw7UI77f1dQgDcH1Lo3R1Ex2rIUIgnUDTr1FKfGcARMMJj6WFzTuncmfFSJAX0fvgXEWwbKEjXOfHVQsoyf0hUPXYR7ZL+N05LsdcQq/A+fg+l9ahWX0Vm5lvH+gOiJi7Wl0kvXlwgZNOOy2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919111; c=relaxed/simple;
	bh=Fw5yc3KwqIkUpRbUG5IvtK1nJa179n0/6LQurRMjCCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1tiXbqy1xNYYASJuRaAdZPMpZ1zcHHBWOfojDHQpCyaDt1W3O2gnm8+4MRfjtMCLW8qb5hpbuHPZmx7ejU+xUe92qArlrgx2sMdqSEMIFO7nQKkMOVUJGQ7XP42fGGSjXzG+Hpp5gwqWJNWENE5KhQ+BgbgVKWMksVurUmNWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTaWMhq8; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so1220876241.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919109; x=1707523909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPxmyRdExJEvcPRl0CWuqoDDXvPz9lLHrgamSw5zf9Y=;
        b=WTaWMhq89HeEvXUsmLkjFJnqcsjFt3CuaW2hTkic2In+l2QXYZ7QsvOz/6HlI89oW3
         k6bzeDfC9X4wwCl6AX7SuARWwj7F3b6kOnVHYAC7FAzzXN+sO0EzBwz4fgnHDuXmG6qT
         HcoGW0GMXQSZGcnJJ/B3vljQyLMoWRWlqlxuvXsTnMXiy3FSBivljiM/yLVZDlYYVZJ4
         UjiNykYyRpbe7yqsdAYFgyl+vl+Y26ugly+zw055MLmdLWlDSK8L7YLotQc/Kk/ytNzM
         9yAhctSEtJt/3uJ6quhlQCKDiLD93meCIjFYJT6xsew894TODCDVpTWVJ1sKYH35FxNU
         gWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919109; x=1707523909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPxmyRdExJEvcPRl0CWuqoDDXvPz9lLHrgamSw5zf9Y=;
        b=VIiakI6TkGA5NN1sMEEFcA/uT+QzOKxfvVG30PP/bKA6Y7ti7a3mcK3e+MMKK6KnO6
         ejreqWdt8m6GKr/zJPSwD3xlIigoCIgPoev6jhjIuOxIjiqkeURB2Ef8pVpx9unpzUmf
         ZGBLn5IZ6VIOrPBRHnu7AugCqOwMKqz6+5jW6dpFAxmFH/jgsx8SOLlmlNqqV+phIdOg
         llgnQdeUb10nWb6J8WRWXOcY2ldm7OHvSuOVokBfyYuwzkxuNnNmRSzsEXXRViYIQoIx
         1fQsoJnHyDQQf0F//G/YbRV+X/VUfb/eIz8NumTYPqqRzt3coS0OOF2N1sVxacYUGGJV
         vS3g==
X-Gm-Message-State: AOJu0YzX/1lYMOa3w5iwxKotkC/sj82e+vhMujaHJRa9Yb2g/Urx6wGI
	XXG6xsoOIjrhQyt2KPt8GmR/v0IdRirvSdbSOJmMxMB4DYEZfQcJg+xQ0KuGdGGAWc589z3pstv
	XEfdEej4JSf3kOC78JtJEE8CO6NSGBHBFxRQX
X-Google-Smtp-Source: AGHT+IG5YGYD/SvWKixRXTjsDK5srI/exvF5e/PZdXyguzPkATWPAwx4LtVWEHkt5wEgNBmX7AEbMCjq7BycjpF5Hzg=
X-Received: by 2002:a67:fb52:0:b0:46d:5b7:f618 with SMTP id
 e18-20020a67fb52000000b0046d05b7f618mr2584782vsr.24.1706919108610; Fri, 02
 Feb 2024 16:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-2-kevinloughlin@google.com> <4ljfvg7c23g2wx4hcqz6x6tx7uvp6fffayqvu4ptsmfqajlujr@zngokbd2awma>
 <CAGdbjm+dt2LMqsWkzME-Gya9F=pZMubTuW3Ad3dStj=L+MW+ng@mail.gmail.com> <CAMj1kXGSZkJ-1opx9mrpfhzyreCM+P616xM+MhPOaR+EgP5NNg@mail.gmail.com>
In-Reply-To: <CAMj1kXGSZkJ-1opx9mrpfhzyreCM+P616xM+MhPOaR+EgP5NNg@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 2 Feb 2024 16:11:37 -0800
Message-ID: <CAGdbjmKO-XDmm-0kw0xm=58TFYdK8t6Yp8OfXCrXVAwWEh3m-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Ard Biesheuvel <ardb@kernel.org>
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

On Fri, Feb 2, 2024 at 2:47=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 2 Feb 2024 at 23:00, Kevin Loughlin <kevinloughlin@google.com> wr=
ote:
> >
> > On Wed, Jan 31, 2024 at 12:20=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Tue, Jan 30, 2024 at 10:08:44PM +0000, Kevin Loughlin wrote:
> > > > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/=
asm/mem_encrypt.h
> > > > index 359ada486fa9..b65e66ee79c4 100644
> > > > --- a/arch/x86/include/asm/mem_encrypt.h
> > > > +++ b/arch/x86/include/asm/mem_encrypt.h
> > > > @@ -17,6 +17,20 @@
> > > >
> > > >  #include <asm/bootparam.h>
> > > >
> > > > +/*
> > > > + * Like the address operator "&", evaluates to the address of a LH=
S variable
> > > > + * "var", but also enforces the use of RIP-relative logic. This ma=
cro can be
> > > > + * used to safely access global data variables prior to kernel rel=
ocation.
> > > > + */
> > > > +#define RIP_RELATIVE_ADDR(var)               \
> > > > +({                                   \
> > > > +     void *rip_rel_ptr;              \
> > > > +     asm ("lea "#var"(%%rip), %0"    \
> > > > +             : "=3Dr" (rip_rel_ptr)    \
> > > > +             : "p" (&var));          \
> > > > +     rip_rel_ptr;                    \
> > > > +})
> > > > +
> > >
> > > I don't think it is the right place for the macro. The next patch use=
s for
> > > things unrelated to memory encryption.
> >
> > You're right; with the cleanup, I agree it becomes more general. We
> > can move it to arch/x86/include/asm/asm.h.
> >
> > >
> > > > @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned lo=
ng physaddr,
> > > >        */
> > > >
> > > >       next_pgt_ptr =3D fixup_pointer(&next_early_pgt, physaddr);
> > > > -     pud =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], =
physaddr);
> > > > -     pmd =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], =
physaddr);
> > > > +     early_dynamic_pgts_ptr =3D fixup_pointer(early_dynamic_pgts, =
physaddr);
> > > > +     pud =3D (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++=
];
> > > > +     pmd =3D (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++=
];
> > > >
> > >
> > > This change doesn't belong to this patch. Maybe move it into the next
> > > patch and combine with removing fixup_pointer().
> >
> > I'll put it in a separate commit even preceding this one, as it's
> > actually a bug in the existing fixup pointer logic that I noticed when
> > transitioning to the use of the RIP-relative macro. Specifically,
> > early_dynamic_pgts is a global variable just like next_early_pgt and
> > thus also needs to be fixed up to guarantee the correct address is
> > used across toolchains.
>
> No, this is not a bug.
>
> early_dynamic_pgts is a two dimensional array
>
> extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
>
> and so this expression
>
> early_dynamic_pgts[(*next_pgt_ptr)++]
>
> produces the kernel virtual address of one of the top level elements,
> which itself is an array, and so this can be fixed up as usual.
> IOW, the [] operation does not result in pointer dereference here,
> only in pointer arithmetic.

Ah, yes, you're right. Thanks for the correction! I will just drop it then.

