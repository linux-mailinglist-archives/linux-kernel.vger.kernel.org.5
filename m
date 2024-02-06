Return-Path: <linux-kernel+bounces-55622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168284BF22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91548B24BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFD1BF34;
	Tue,  6 Feb 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="igmnL6QU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD361BF24
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254280; cv=none; b=m/F7h76/GBHcV9HrqJtPi31V1CIzGLTanmyLUfvurvFFUp3y00kkx2NofYXvSfqANS12/ttbAvi/Wu2NSPn7LximeIn7TwyxxpsiniXJXZdRsL0MnH7uGD5hkl3nJfjECKQsqCRdELnQBEmmebVlLashvXjkBLPAM6nSvdChhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254280; c=relaxed/simple;
	bh=rDP/uvYFNR1ylgdVVfDWbmdIwIvKvPalMs99rEP2vmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DC/S1IVQcW/wlG+hBeFpa6nZJnidKuh2sMr2mOZf3LgAof/LcblRHU1XbopEvifGy+xvLgMO7NRMn7rHFTWiudaK+rhGz/57t9ZsYGvF3OFtImGLtOR+9ueTl+oCGH4CfbsAjYgtGlQxS8PRfyspJLQcpPT1H2yLwe5k4WYsYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=igmnL6QU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so845777966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707254275; x=1707859075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qfP1+TruJwtkPM3sgZDskiPx+MC9S8wIWMurDQtM4U=;
        b=igmnL6QUIhmJ3VeIv0W+ygzDtbJFcNJy/Ad8uXi5cT07niNlXkoivXAtW9p1qo107e
         n+iPL5ZjOE1BTpmDUMpjzdGBEp9adItzopqTAzmKH/eCt4ulYc+Q7nJiONExVKKl572P
         6bDVJapd/z3lKa+hT6UzZEnasQQRViWhy7gEpsYfKjBCx+AtjU71HPJnpRKf0Fyypzd9
         v9pFjzbFyBEc45vrSK3UEJdacgfS9u/7H4l0v+dYHRjikjDLhKmARi0TlGInDVocY74O
         9/EPqfgSrXgNHUVA2l62+mZtN6nVCjBwUGKOJREVno1vC+8rUhxubFjKTMCwXlFlW36q
         Os0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707254275; x=1707859075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qfP1+TruJwtkPM3sgZDskiPx+MC9S8wIWMurDQtM4U=;
        b=iMtp1UsKdUeaeCVrFBsAUHcfWm3tCoYfsg7pmMlxaYNhAy9YISMc27Ssd9OvPfhA4h
         z31PQR4gLQKHVQlRYRJX3Cgrb/ctJSgkI3IG8FVVzTDyI+5ktk7uqVIsmXK2Mh/KxSr/
         q9sjtKID0rUj0gV0CyBShpvwtlAZitw/G3qC8jJx5Shg3moNmw0UIoyczVFwDTiKMoaW
         ed+8YgmP4YzfdfViLewSj8LjmL3od+OcrJwuOaMH5/D1EVXa8ZMcnBpidkeVlVeMpLjq
         ax5wxl2+iaYuAmqmzSYV5oyo0oBcQhT4/j87Cp+nhaJV7jCXV5R38LwTm1NvBBRIjrUG
         KPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmUvSvHH99O+ogwKKG5rME3gEHuZZif8P9bhaSB4stLXZ3HTZHeAOhowDsxWF/eC6MbTQ6IdeqNDJqBulc+8iW90lLWsw6DDpIwG97
X-Gm-Message-State: AOJu0YwCkjr4AtJWHf2MgxN50Nrjs5AaKqx6AC6ERO5B+7GhgG0HbgaN
	FhNNSSk6aXV7YcnzqJ3mqnGRgNmOw5+9flD8RX03fKJWpjmZJ4RgispsymuZRXkw1CtvN3JVoGE
	wEV8ucvvFbyt2BOa+1ZDFpz0iE/Xk30bhiTk7I5LVkkSQvJLzXzA=
X-Google-Smtp-Source: AGHT+IFr5NmvcuIq34icz9u9x1LZK2ptayB0qUPTvToNGtcbZjTpPFn6lJ83eGqiuHxai0TJpi5xcH0aCutsUi+RdqI=
X-Received: by 2002:a17:906:3d3:b0:a36:95cd:5e5f with SMTP id
 c19-20020a17090603d300b00a3695cd5e5fmr2844084eja.62.1707254275596; Tue, 06
 Feb 2024 13:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202135030.42265-1-csd4492@csd.uoc.gr> <CAHVXubioUY=vvQrLrcb+5aWav5WUdpJ3i0fCKP_xx0ASU30g=A@mail.gmail.com>
In-Reply-To: <CAHVXubioUY=vvQrLrcb+5aWav5WUdpJ3i0fCKP_xx0ASU30g=A@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 6 Feb 2024 22:17:44 +0100
Message-ID: <CAHVXubjanrxkDrNTZMrPtmewjqyf3L4_TTtqXhjGV+k+qkynmA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sparsemem: warn on out-of-bounds initialization
To: Dimitris Vlachos <csd4492@csd.uoc.gr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org, arnd@arndb.de, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitris,

On Fri, Feb 2, 2024 at 2:59=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hi Dimitris,
>
> On Fri, Feb 2, 2024 at 2:50=E2=80=AFPM Dimitris Vlachos <csd4492@csd.uoc.=
gr> wrote:
> >
> > From: Dimitris Vlachos <dvlachos@ics.forth.gr>
> >
> > Hello all
> >
> > I am sending this email with regards to a bug that I discovered in the =
Sparse Memory Model configuration and more specifically, the Virtual Memory=
 Map optimization. Moreover, I would like to inquire about possible ways of=
 fixing it.
> >
> > I work as a pre-graduate research assistant at ICS-FORTH in the Compute=
r Architecture and VLSI Systems laboratory.
> > We were running some tests in our prototype hardware (RISC-V), where we=
 noticed that the Kernel crashes early in the boot process with the followi=
ng setup:
> >
> > We are using the default Kconfig configurations (defconfig) that includ=
es Sparse Memory + Virtual Memory Map.
> > The DRAM base address of our system is : 0x800000000000
> > A 3-level page table is used (Sv39).
> >
> > When the vmemmap optimization is enabled the macro pfn_to_page() is cal=
led, which offsets the vmemmap with the pfn argument to acquire a struct pa=
ge pointer.
> >
> > As our DRAM starts at 0x800000000000, the initial pfn will be 0x8000000=
00000 divided by PAGE_SIZE. The calculation result will be:
> > 0xffffffcf00000000 (vmemmap start) +  (0x800000000 (pfn) * 64 (sizeof(s=
truct page))
> >
> > This causes an overflow as the number is very large, the resulting addr=
ess is 0x1c700000000 which is not a valid Sv39 address (all bits above bit =
38 should be set) and does not belong to the kernel=E2=80=99s virtual addre=
ss space.
> >
> > The same will happen with all valid pfns as the memory is being initial=
ized. When the Kernel will try to access a page using pfn_to_page, a page f=
ault will occur crashing the system.
> > It should be noted that when the vmemmap is disabled the system boots n=
ormally.
> >
> > However, I would like to emphasize another important detail. When the D=
RAM base is small enough to avoid an overflow, the virtual memory map mappi=
ngs will be initialized out of bounds with regard to the vmemmap address sp=
ace which is 4GiB in Sv39.
> > The system will not crash, but the address space used for this purpose =
will be outside of the designated range.
> >
> > Everything mentioned above holds true when Sv48 is used as well. Given =
a high enough DRAM base the system will either crash or perform false initi=
alizations. Given the fact that virtual memory map is not only used by RISC=
-V systems, this could be an issue for other architectures as well.
> >
> > The kernel already contains mminit_validate_memmodel_limits() that chec=
ks memory limits.
> > However, it only checks physical memory ranges. I added a few checks, p=
rovided that virtual memory map is enabled, to determine whether offset sta=
rt and offset end fall inside the range of virtual memory map. Otherwise, a=
 warning will be printed.
> >
> > Finally, I would like to ask you for any information/advice that could =
help me fix/prevent the issues that I mentioned (if it=E2=80=99s possible) =
or recover from them at runtime by disabling the optimization and reverting=
 back to the non-vmemmap mappings.
> >
> > Thank you in advance.
> > Best regards,
> > Dimitris Vlachos
> > ---
> >  mm/sparse.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 338cf946d..33b57758e 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -149,6 +149,26 @@ static void __meminit mminit_validate_memmodel_lim=
its(unsigned long *start_pfn,
> >                 WARN_ON_ONCE(1);
> >                 *end_pfn =3D max_sparsemem_pfn;
> >         }
> > +
> > +       /*check vmemmap limits*/
> > +       #ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +
> > +       unsigned long vmemmap_offset_start =3D (unsigned long) pfn_to_p=
age(*start_pfn);
> > +       unsigned long vmemmap_offset_end   =3D (unsigned long) pfn_to_p=
age(*end_pfn);
> > +
> > +       if (vmemmap_offset_start < VMEMMAP_START) {
> > +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> > +                       "Start of range %lu -> %lu exceeds bounds of SP=
ARSEMEM virtual memory map address range %lu -> %lu\n",
> > +                       vmemmap_offset_start, vmemmap_offset_end, VMEMM=
AP_START,VMEMMAP_END);
> > +               WARN_ON_ONCE(1);
> > +
> > +       } else if (vmemmap_offset_end > VMEMMAP_END ) {
> > +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> > +                       "End of range %lu -> %lu exceeds bounds of SPAR=
SEMEM virtual memory map address range %lu -> %lu\n",
> > +                       vmemmap_offset_start, vmemmap_offset_end, VMEMM=
AP_START,VMEMMAP_END);
> > +               WARN_ON_ONCE(1);
> > +       }
> > +       #endif
> >  }
> >
> >  /*
> > --
> > 2.39.2
> >
>
> Since struct pages are only available for memory,  we could offset
> vmemmap so that VMEMMAP_START actually points to the first pfn?

> Hello Alexandre,
> My first thought was to use a "better" offset for vmemmap as well.Since p=
fn is essential for pfn_to_page and page_to_pfn i think that maybe we could=
 get a smaller number out of pfn to offset the vmemmap and ensure that it's=
  bounds are respected for pfn_to_page operation.
> If we use only a part of the pfn for the offset we could get the  pfn fro=
m page_to_pfn by adding PAGE-VMEMMAP_START
> to the DRAM base/PAGE_SIZE which is the first pfn.

Let's keep the discussion here.

IIUC you propose to change pfn_to_page()/page_to_pfn() but what I
proposed was to directly offset vmemmap like this:

#define vmemmap         ((struct page *)VMEMMAP_START - phys_ram_base
>> PAGE_SHIFT)

So that the first page in vmemmap corresponds to the first page of
physical memory, that avoids the burden of changing the conversion
macros, WDYT?

Thanks,

Alex

