Return-Path: <linux-kernel+bounces-50629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE00847BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45404B249F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FB83A18;
	Fri,  2 Feb 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKOlwM2A"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC583A06
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911244; cv=none; b=dsNxSAQbEvsoe6+bUejpMHIoCCyKFD6/Nc6ROdX7NTQbo8ukqu/tB5UQyqIGz/KOkY8aTQIW8O9KQTczZGF1RV7PQI6GbeAE3ql+zMAgtsgKwo3RPsVuokGRybow2INrRRrXqKLwoOkAJR4g1B1N4IME71GxnbOXG9KQb3jq8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911244; c=relaxed/simple;
	bh=T1MXEQB746wrX62S7IpUJjq100rQ6d7kzLltQ5g3nRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD1+kOCm1iwG8qS5peRnOKX54/aj31uhYHt37e6JdM5b1Nrb/uRxoYcu25UqKD8eqUUPHYepIXC30F0Ku04sNuBJGtFkINJdDyBU8/RyH2J7SpVkLcVcr/hNqC4CmxkSMdNnIWuNGGjAMYNRrYYWCxbAo5aW85jsnxXMsiZgq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKOlwM2A; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4681b72f2f9so1069346137.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706911242; x=1707516042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hry1ZKGYXn0PLELk19zPrbAcJfAf3mQKU3XmGI8OhDs=;
        b=pKOlwM2AZDyxgSowALIIaIncYsHqDOrUj18iE21VT2vz7KT8tUQdZYQYpoiYl6tX6s
         b+HGs+GPHnaZYxHi7in+RR+jzxvublgsI43vpOmRNotd2LJN6lMkPuFLgvjnJaCZXeWl
         mxv0vrHk48bsaJMIf2qyrMpYAkSNhg9uATfAfngzRNQA6cALdPJBbODkYynkG62erHhh
         BuFi97na/axg/6T2STZSKwKjQeDZkwMQFTlWu2eRBOotRlRaMhvOYkSRI47sJt2tFvoQ
         oq5y5cNXAVqjVNOtGCPSsXHa1g6jkt/wcXJpxzfNFoWOb7Botn+EcaZyb2UbUEZFV9jd
         AWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911242; x=1707516042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hry1ZKGYXn0PLELk19zPrbAcJfAf3mQKU3XmGI8OhDs=;
        b=Im4h1JHdhtO9IE5n2tkKhU/CFEvr0nx2VxFlQJjEht0BicG4uEcFMKZ3uhbuo+s/6M
         WFElAWfwwXBpWZWEGBIXlFmJ1tgrxsADVHb4AT4ir3Ft7TiWc8T2/km+/yzOgZkaJ+iZ
         rrmWwU3XwBruLt0gLG5GA8NXCkQJW7sz4niOYtw6aS1ej3jkLX53yTOcpbaAlXwzWyIy
         1QN/IDii02RrD2t5GBfIk9qYtA4bhkuh68wXBYaR4XHF00qevZC9IMpSAqSnTtoDwHgd
         ykTGFwV6Loar3N6EMZmKbxa/4gJKIrJ6SIlfIDYrnBGafgNsV6vIepkAC8kCW8yK+FFX
         h3IQ==
X-Gm-Message-State: AOJu0YyWu0muvvpu9w6eNPKeCbZa6NqgGr7IP5zyNnWOOFPgO7033Sl2
	WmxWSDtfCgrShBTOEh9EaF9x92pbpv4tK8oulelgZJjKSoz0b1MZnfI3kuc+uAYcO2cGWS+bmtb
	3jC0TncyFxm0Ah/ur42VJ8ocBwQA4r0loRwlu
X-Google-Smtp-Source: AGHT+IFUXimzUG8NKidpgusFqnc2mrXenla7Rri5SA/FWuN+STma6oTZzhlhnm7yzn8Qgpm/liJq5PDpZqGjZbzCjFo=
X-Received: by 2002:a05:6102:a15:b0:46b:42f5:ae94 with SMTP id
 t21-20020a0561020a1500b0046b42f5ae94mr8595652vsa.22.1706911241549; Fri, 02
 Feb 2024 14:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-2-kevinloughlin@google.com> <4ljfvg7c23g2wx4hcqz6x6tx7uvp6fffayqvu4ptsmfqajlujr@zngokbd2awma>
In-Reply-To: <4ljfvg7c23g2wx4hcqz6x6tx7uvp6fffayqvu4ptsmfqajlujr@zngokbd2awma>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 2 Feb 2024 14:00:30 -0800
Message-ID: <CAGdbjm+dt2LMqsWkzME-Gya9F=pZMubTuW3Ad3dStj=L+MW+ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:20=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jan 30, 2024 at 10:08:44PM +0000, Kevin Loughlin wrote:
> > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/=
mem_encrypt.h
> > index 359ada486fa9..b65e66ee79c4 100644
> > --- a/arch/x86/include/asm/mem_encrypt.h
> > +++ b/arch/x86/include/asm/mem_encrypt.h
> > @@ -17,6 +17,20 @@
> >
> >  #include <asm/bootparam.h>
> >
> > +/*
> > + * Like the address operator "&", evaluates to the address of a LHS va=
riable
> > + * "var", but also enforces the use of RIP-relative logic. This macro =
can be
> > + * used to safely access global data variables prior to kernel relocat=
ion.
> > + */
> > +#define RIP_RELATIVE_ADDR(var)               \
> > +({                                   \
> > +     void *rip_rel_ptr;              \
> > +     asm ("lea "#var"(%%rip), %0"    \
> > +             : "=3Dr" (rip_rel_ptr)    \
> > +             : "p" (&var));          \
> > +     rip_rel_ptr;                    \
> > +})
> > +
>
> I don't think it is the right place for the macro. The next patch uses fo=
r
> things unrelated to memory encryption.

You're right; with the cleanup, I agree it becomes more general. We
can move it to arch/x86/include/asm/asm.h.

>
> > @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned long p=
hysaddr,
> >        */
> >
> >       next_pgt_ptr =3D fixup_pointer(&next_early_pgt, physaddr);
> > -     pud =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], phys=
addr);
> > -     pmd =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], phys=
addr);
> > +     early_dynamic_pgts_ptr =3D fixup_pointer(early_dynamic_pgts, phys=
addr);
> > +     pud =3D (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> > +     pmd =3D (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> >
>
> This change doesn't belong to this patch. Maybe move it into the next
> patch and combine with removing fixup_pointer().

I'll put it in a separate commit even preceding this one, as it's
actually a bug in the existing fixup pointer logic that I noticed when
transitioning to the use of the RIP-relative macro. Specifically,
early_dynamic_pgts is a global variable just like next_early_pgt and
thus also needs to be fixed up to guarantee the correct address is
used across toolchains.

