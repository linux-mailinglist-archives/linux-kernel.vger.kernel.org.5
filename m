Return-Path: <linux-kernel+bounces-120492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9206488D84D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681481C26597
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FAF524A8;
	Wed, 27 Mar 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QAWFpI0o"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98B4F208
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526295; cv=none; b=ZlN3voAxW7trJDNHWwmduwpiNKhQ/le3fowFCTYcKBfIx07llJoG1FmpxQOkMR8IhOOaiNBcoVpLk55MVXGg5ziaeg9MDpzLonMotpdPDvk8W9POdI9m6ODadhfjdtYC0gFsWJ08oFkR1UgDzFBkoLje2g/EfJrIZBYvfn63XYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526295; c=relaxed/simple;
	bh=Z7snmgom99fzBfjaFYAT5LDhkFVi6TWaRlueQJZoqKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRvKK4wJ4f5PcyCEjrsD+0yNqc1iqP9WwjUC8qXA7rkU/UFP+CD64CVC5c1a7SRT03cN1S2AFV6HVvkpPUfVy+a1dJ30JytoFbiK1kf7e+1jbhEo5Lq87OWVcIYcrTCAWNBXtpdWwz5WLidcommlSISIhlBxSztT75F83x21XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QAWFpI0o; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22a5df0f789so697592fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711526293; x=1712131093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buArJPLlnPB5EIrSoptLXad98trwHBEhYaxknXdrCRM=;
        b=QAWFpI0otrALnuN8pXbzY+QaJn+P+kMRhvC0sRCWVmGyC4SAUshzUSRTSVDu56eiTD
         1y23RPo1jP29Kw7PdpNVDanO/gTtItditPM5ofkPpXeTqwWaHDqB08Js8N2NXAfq9Mic
         K2ZkW8O0SSice6bah1CETLVpVs5JiCc7QwHFMNHzyUeLGVguwNfNrtjKVhcf4hJuz9Os
         9Z5G1fjVuWIiVLsTTAFGBqHEkKaKk/qtAqnGH7mwUAlXQGw9H0tYu5dFmkg1hI12A9F5
         eGfE5ymicjuByeNV/J+jGagwOWm0fIgtm8/DQHM/Y/32VAFIXtYcmutAtPU3w+LWTYrd
         br5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526293; x=1712131093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buArJPLlnPB5EIrSoptLXad98trwHBEhYaxknXdrCRM=;
        b=nfTbZK3UNVL9PbptLd8XCSgy/tQ/aPzz8fvXRtsGoDaZVxLCyw5K/ihuqN4ZRiBxEV
         blk9S89EGet3B9OE7rTltBgO7bCpWqvnASRlx5brvZ/sPmNFDBiFZk9VOqglybsVSSE1
         EuusUZNxGsTgID8jt77Wg8PDdUrZWIrZp23mKxs85kRUir7btfg6sjYGAN2InGq5fWPv
         cOo8xy6NInVqelBxU5N4UGnCEvUsu5tOZGF+lmtuAyrGReUuSa4yL3uKGYdLa94md5BQ
         nYBmthI3Vg/KnWcaReBsxXvCXGuyWa680F4cJooVxWRf9ONESHQKkz+KddbHeIeXdmIj
         70Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWBb/Pxe18ZNR3UdvPaWek/YUw9W5xHQtRN++N289Vtw8EmV73JsbflmvX0jwU7JmzW65sgE+T+OsY78yBnU1g9UTcfqS4vNrTLbNjj
X-Gm-Message-State: AOJu0YzmTDI6HXtMBTZOPtZXDIW8kE/X6fl9mPnDPYVU0kyi7lJjRjN7
	eIF393J0xu2D1fmQKVAId5nAEl9TAyN1JCbSt9f3f4o1xxksakRKMuAzOauFStbobfej3Ob1MJd
	XmKi4R0mFuW2CsiI/tHBITSnflBSG/O9Q2mt+FA==
X-Google-Smtp-Source: AGHT+IFvJOK0KuWjR42wxMSa9dp2bPq3Ot/Nwj6HB+3ZV4WEBddR87Irr/dviDFOz0/CEBtTnttdt9WCRLoGI9IEIvc=
X-Received: by 2002:a05:6870:2194:b0:229:ef48:8c67 with SMTP id
 l20-20020a056870219400b00229ef488c67mr5276811oae.41.1711526292858; Wed, 27
 Mar 2024 00:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325164021.3229-1-jszhang@kernel.org> <20240325164021.3229-3-jszhang@kernel.org>
 <b063df9b-90b6-4f06-8be5-5a8c267e6c8d@sifive.com> <ZgL31BFWvaLwYQrN@xhacker>
In-Reply-To: <ZgL31BFWvaLwYQrN@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 27 Mar 2024 15:58:01 +0800
Message-ID: <CAEEQ3w=NZ5YR8bsOKdhLfeGk7u-7rUHGYA2mvcoO1o-ZaZT-jQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/5] riscv: nommu: use CSR_TIME* for
 get_cycles* implementation
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Wed, Mar 27, 2024 at 12:43=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org>=
 wrote:
>
> On Mon, Mar 25, 2024 at 09:39:26PM -0500, Samuel Holland wrote:
> > Hi Jisheng,
> >
> > On 2024-03-25 11:40 AM, Jisheng Zhang wrote:
> > > Per riscv privileged spec, "The time CSR is a read-only shadow of the
> > > memory-mapped mtime register", "On RV32I the timeh CSR is a read-only
> > > shadow of the upper 32 bits of the memory-mapped mtime register, whil=
e
> > > time shadows only the lower 32 bits of mtime." Since get_cycles() onl=
y
> > > reads the timer, it's fine to use CSR_TIME to implement get_cycles().
> >
> > Unfortunately there are various implementations (e.g. FU740/Unmatched, =
probably
> > K210 which this code was originally used for) which do not implement th=
e time
> > CSR, relying on M-mode software to emulate the CSR so S-mode software d=
oesn't
> > notice. So this code is needed to support those platforms when running =
Linux in
> > M-mode.
>
> OOPS, I knew this for the first time there are such implementations
> which doesn't implement the TIME CSR :(
>
> >
> > Maybe there should be an option to assume the time CSR is/is not implem=
ented,
> > like there is for misaligned access?
>
> Yep, this seems the only solution. Then which should be the default
> choice? I.E
>
> Assume all NOMMU goes through TIME CSR, and provide an option for
> platform lacking of TIME CSR. This prefers TIME CSR.
>
> VS.
>
> By default, MTIME is used, and provide one Kconfig option for TIME CSR
> usage. This prefers MTIME
>
> which choice is better? Any suggestion?
>
> Thanks in advance
>
> >
> > Regards,
> > Samuel
> >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/timex.h | 40 --------------------------------=
--
> > >  1 file changed, 40 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/=
timex.h
> > > index a06697846e69..a3fb85d505d4 100644
> > > --- a/arch/riscv/include/asm/timex.h
> > > +++ b/arch/riscv/include/asm/timex.h
> > > @@ -10,44 +10,6 @@
> > >
> > >  typedef unsigned long cycles_t;
> > >
> > > -#ifdef CONFIG_RISCV_M_MODE
> > > -
> > > -#include <asm/clint.h>
> > > -
> > > -#ifdef CONFIG_64BIT
> > > -static inline cycles_t get_cycles(void)
> > > -{
> > > -   return readq_relaxed(clint_time_val);
> > > -}
> > > -#else /* !CONFIG_64BIT */
> > > -static inline u32 get_cycles(void)
> > > -{
> > > -   return readl_relaxed(((u32 *)clint_time_val));
> > > -}
> > > -#define get_cycles get_cycles
> > > -
> > > -static inline u32 get_cycles_hi(void)
> > > -{
> > > -   return readl_relaxed(((u32 *)clint_time_val) + 1);
> > > -}
> > > -#define get_cycles_hi get_cycles_hi
> > > -#endif /* CONFIG_64BIT */
> > > -
> > > -/*
> > > - * Much like MIPS, we may not have a viable counter to use at an ear=
ly point
> > > - * in the boot process. Unfortunately we don't have a fallback, so i=
nstead
> > > - * we just return 0.
> > > - */
> > > -static inline unsigned long random_get_entropy(void)
> > > -{
> > > -   if (unlikely(clint_time_val =3D=3D NULL))
> > > -           return random_get_entropy_fallback();
> > > -   return get_cycles();
> > > -}
> > > -#define random_get_entropy()       random_get_entropy()
> > > -
> > > -#else /* CONFIG_RISCV_M_MODE */
> > > -
> > >  static inline cycles_t get_cycles(void)
> > >  {
> > >     return csr_read(CSR_TIME);
> > > @@ -60,8 +22,6 @@ static inline u32 get_cycles_hi(void)
> > >  }
> > >  #define get_cycles_hi get_cycles_hi
> > >
> > > -#endif /* !CONFIG_RISCV_M_MODE */
> > > -
> > >  #ifdef CONFIG_64BIT
> > >  static inline u64 get_cycles64(void)
> > >  {
> >
>

I'd like to take this thread to ask:
csr_read(CSR_TIME) returns a timestamp, right? So why is the function
name get_cycles()? Instead of get_timestamp()?

Thanks,
Yunhui

