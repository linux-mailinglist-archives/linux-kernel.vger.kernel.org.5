Return-Path: <linux-kernel+bounces-152062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74B8AB83B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EEF281E03
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099B6FB5;
	Sat, 20 Apr 2024 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TP8g5oyW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A238B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575308; cv=none; b=PAAHH2cyA9ZOR2IXZolocCDxiqc9FqE9JOaK4u7wAf6S7gDB0vkJpxiLr0WnYOw8/lu/fL2i3czPAy6H6EoESrYw+Rh7L9GkLlG3F3bvxbr3XmGeuKrGhgdOkVjUoH9EpUOAlc0nD2AsPxMIY+A4c4fkm7mCZ1kib9fDrVzxX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575308; c=relaxed/simple;
	bh=/v5DF/yr70RSo2cPlpFendzuWaxo1OWbch7DeiC/1po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1oPF95KH1hSfn0ObhOsHvKmX6uwf5xeqatV/gTm+S7cPV8Xv43ByusSNpSwOEdo2sVcjOT5nOwLV42lAvVvNwQ+8mrLW7kdDots2HDjQqNRj5V5KSlqjNejEHI+pEj3QH0I1BynO0BE+Z5P3CchS9VlFJBIKo1c42VT044vja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TP8g5oyW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so3396760e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713575304; x=1714180104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FopOoJVqlKLyitM+vV+llThPHlvMlGI12SmtWJmmk/0=;
        b=TP8g5oyWZGaFY+FIx/xBLkzBYg5ipxmpMLGeLn7b3e392q0X+8vNxbgjwMYY0nKo5W
         RGzxXUXagCcv9Tm0VObNwoWVH34aKqX93CNzj9TiVsOcxzxGFZff0cLVYH2KXy8xWvli
         qYXhw7wnmnD2hX4DZg/Oi9o1tDNWH2Mbj4n3eE5T9RgXZUlgWdsEyjn4uhhpfPPhSqfQ
         HOJ/LxTGHpWUn8EqI+lC3/XxNuM3VBjUBVKVnSt8Sx6DdL3R5DESIMq4Uh/SmHuLNY0o
         +OPwBx1Gc4N6jPc0aABYWybC8EG01gW/O8sOAw/ZnHleMfMJHUzAYdML1J/c5SBygoNX
         v8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713575304; x=1714180104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FopOoJVqlKLyitM+vV+llThPHlvMlGI12SmtWJmmk/0=;
        b=LHkYTGOpfW5PJEaL0scQzAZt729dVwJtsCmgN1NmMeHdkq0+z/9DZj/D0jvU3FIrIp
         698e5F2VnurDzw8/a1+S2En6pyjXMNv0Y7baC3ON+wcPYYaz0c83QyhvAnV141ZLQyUg
         AQU1Cag/q06+OAWJ+PGRR+0Edb+Q/4esAwTINR+ow81AzNBUR2QENgC0UVBO76xhTpMp
         2Ft5uoWvhTfdY59FazZcBD9r54V8SAVhAVpDpXLxs1hcj+nlsaMsy6sxUiNEvT4JnKkW
         GvnpNkqAQubLr+E8qvq5U3qTLrEMWj0V+d32vb7g/mEJF2SxI/mFTALWEUzkU47h3CeH
         jbGg==
X-Gm-Message-State: AOJu0Yww/3MWI4TuXbF3O2cB/FvgQ5jH02jrsDJcZZEufIEbfwTRVRF2
	hTpAICQGBbgbAbusBEcAFCXo2tDjUu3IVUo2uNYx2yOB7uAXM+w20rC7zckW5diI8bRiZIRI2NE
	fPRtWqR0VUvEklzyV7jyJjkj0/HIDAYaaJsnNgw==
X-Google-Smtp-Source: AGHT+IEogPfnlgAs9tR0qh0PAukDsFCglg4IjcLIKZzaVYr+8YdRMjPXcvRvV/A0KI3X5O1GyN/90pSnjyS/BTYsdl8=
X-Received: by 2002:ac2:5a1e:0:b0:519:296e:2c80 with SMTP id
 q30-20020ac25a1e000000b00519296e2c80mr1893557lfn.15.1713575303793; Fri, 19
 Apr 2024 18:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-9-atishp@rivosinc.com>
 <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
In-Reply-To: <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 19 Apr 2024 18:08:12 -0700
Message-ID: <CAHBxVyHZ81G7yaMkV25RBwS=ric=MA92MePaPtQaOXuR+C70YA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration
 for RV32
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:37=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Atish,
>
> On 2024-04-20 10:17 AM, Atish Patra wrote:
> > For RV32, used_hw_ctrs can have more than 1 word if the firmware choose=
s
> > to interleave firmware/hardware counters indicies. Even though it's a
> > unlikely scenario, handle that case by iterating over all the words
> > instead of just using the first word.
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index f23501898657..4eacd89141a9 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_=
pmu *pmu)
> >  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >  {
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     int i;
> >
> > -     /* No need to check the error here as we can't do anything about =
the error */
> > -     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> > -               cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> > +     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> > +             /* No need to check the error here as we can't do anythin=
g about the error */
> > +             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS=
_PER_LONG,
> > +                       cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
> >  }
> >
> >  /*
> > @@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct risc=
v_pmu *pmu)
> >  static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> >                                              unsigned long ctr_ovf_mask=
)
> >  {
> > -     int idx =3D 0;
> > +     int idx =3D 0, i;
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >       struct perf_event *event;
> >       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> > @@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(st=
ruct riscv_pmu *pmu,
> >       struct hw_perf_event *hwc;
> >       u64 init_val =3D 0;
> >
> > -     ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> > -
> > -     /* Start all the counters that did not overflow in a single shot =
*/
> > -     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_ma=
sk,
> > -               0, 0, 0, 0);
> > +     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> > +             ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf=
_mask;
>
> This is applying the mask for the first 32 logical counters to the both s=
ets of
> 32 logical counters. ctr_ovf_mask needs to be 64 bits wide here, so each =
loop
> iteration can apply the correct half of the mask.
>

The 64bit wide support for ctr_ovf_mask is added in the next patch.

> Regards,
> Samuel
>
> > +             /* Start all the counters that did not overflow in a sing=
le shot */
> > +             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BIT=
S_PER_LONG, ctr_start_mask,
> > +                     0, 0, 0, 0);
> > +     }
> >
> >       /* Reinitialize and start all the counter that overflowed */
> >       while (ctr_ovf_mask) {
>

