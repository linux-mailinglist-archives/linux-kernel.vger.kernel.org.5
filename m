Return-Path: <linux-kernel+bounces-9313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FE81C3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD054282114
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACD23D8;
	Fri, 22 Dec 2023 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSvc8gAW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3B8F57;
	Fri, 22 Dec 2023 04:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B1C433D9;
	Fri, 22 Dec 2023 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703219193;
	bh=Xam1GJeef2fOSjd6JgqSIsumboLq0wgjV6F4XP7JXoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FSvc8gAWrXlLXQGMPmJMVypKgyr2ONphlZWDi+tJR4XMK+FjYMzr3MuA9c5Q9/PnQ
	 hJXh1Wuemri6hQVFxlSd9zVMvhlRVPMuUpWqze4Ji4Qf1FvZfqtHt/jj+WatvIIuMn
	 5huvrz7x3hO2u5Mouc1bd1R8AxibSWReWqloDmfs/D4fjQC2PD/ikeqsoFZ+PXbsX+
	 zUPDt5CUinARyhsXBrlhOaRaTP2LG0z8Wo+bhvtLeW5leXRX+q/fI1uNb3ptkBEyCa
	 /FMvNmmqxK9MRVtZuZVs5xQKhpCv8FZndauyQma0bSz794fyTQNvzEpQzzbMhfayVk
	 hY0Zbaso2MIEQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cca5d81826so10404051fa.2;
        Thu, 21 Dec 2023 20:26:33 -0800 (PST)
X-Gm-Message-State: AOJu0YwJGpJYWG1tls2KW8j4Ph/T1Erz1GzPhcexKYo7J6l0JXjzcyYq
	CEmf074zow4qyUHuXraJnTTjuR2MpPhh9I4OO10=
X-Google-Smtp-Source: AGHT+IFwBTkKLKt1AO/kzaZ3GDS0ipHgf6dEISGW/09EWnGBoq8u2MiCTIb4MjckfGx3jXXnUwnQZusz65B9pbeB3W8=
X-Received: by 2002:a2e:bb93:0:b0:2cc:695b:a12b with SMTP id
 y19-20020a2ebb93000000b002cc695ba12bmr242244lje.85.1703219191414; Thu, 21 Dec
 2023 20:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras>
In-Reply-To: <ZYUD4C1aXWt2oFJo@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 12:26:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
Message-ID: <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:35=E2=80=AFAM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > directly.
>
> ok
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,=
sv57")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index f19f861cda54..1f538fc4448d 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -16,15 +16,13 @@
> >
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > -#define STACK_TOP_MAX                TASK_SIZE_64
> > +#define STACK_TOP_MAX                TASK_SIZE
>
> It means STACK_TOP_MAX will be in 64BIT:
> - TASK_SIZE_32 if compat_mode=3Dy
> - TASK_SIZE_64 if compat_mode=3Dn
>
> Makes sense for me.
>
> >
> >  #define arch_get_mmap_end(addr, len, flags)                  \
> >  ({                                                           \
> >       unsigned long mmap_end;                                 \
> >       typeof(addr) _addr =3D (addr);                            \
> > -     if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_t=
ask())) \
> > -             mmap_end =3D STACK_TOP_MAX;                       \
> > -     else if ((_addr) >=3D VA_USER_SV57)                       \
> > +     if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)            \
> >               mmap_end =3D STACK_TOP_MAX;                       \
> >       else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_S=
V48)) \
> >               mmap_end =3D VA_USER_SV48;                        \
>
>
> I don't think I got this change, or how it's connected to the commit msg.
The above is just code simplification; if STACK_TOP_MAX is TASK_SIZE, then

     if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()=
)) \
             mmap_end =3D STACK_TOP_MAX;                       \
    else if ((_addr) >=3D VA_USER_SV57)                       \

is equal to:

     if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)            \

>
> Before:
> - addr =3D=3D 0, or addr > 2^57, or compat: mmap_end =3D STACK_TOP_MAX
> - 2^48 < addr < 2^57: mmap_end =3D 2^48
> - 0 < addr < 2^48 : mmap_end =3D 2^39
>
> Now:
> - addr =3D=3D 0, or addr > 2^57: mmap_end =3D STACK_TOP_MAX
> - 2^48 < addr < 2^57: mmap_end =3D 2^48
> - 0 < addr < 2^48 : mmap_end =3D 2^39
>
> IIUC compat mode addr will be < 2^32, so will always have mmap_end =3D 2^=
39
> if addr !=3D 0. Is that desireable?
> (if not, above change is unneeded)
>
> Also, unrelated to the change:
> - 2^48 < addr < 2^57: mmap_end =3D 2^48
> Is the above correct?
> It looks like it should be 2^57 instead, and a new if clause for
> 2^32 < addr < 2^48 should have mmap_end =3D 2^48.
>
> Do I get it wrong?
Maybe I should move this into the optimization part.

>
> (I will send an RFC 'fixing' the code the way I am whinking it should loo=
k
> like)
>
> Thanks,
> Leo
>
>
>
>
>
> > --
> > 2.40.1
> >
>


--=20
Best Regards
 Guo Ren

