Return-Path: <linux-kernel+bounces-48884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043378462B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE971F24E65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAED83E49B;
	Thu,  1 Feb 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK4+aGIe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37963D0A4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823609; cv=none; b=DwBvXyxN2/tY2IA8qPUAFZV8rys6eZa5uPjw0SwL+Mb7u3Xo1CMVI5WEjOxpHfGTIIkKt0gjBLNcE0i8R7gaUXP8qXnLXMGrfzerfTYjUPepMQ5U3EapLJxJXMqIvRrhLNsyR+wbGtqr3StC1/gd1H0Aecp6p8eEie8VsPFusjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823609; c=relaxed/simple;
	bh=aa8qqudzAcRaJ9jA54ZQfTPTNX34sPUeSh+nVg9hSIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkeNF4y+uk1vHn+c16bAG1ZHzs9RQeuLdiN9c5Ef6B/+IyjZRdSVdGYQrSSHrxrDPLNEuWtcFwEZEQlKRf4+uOsZY6/GMO1/Kj9B/A/0+nxn/9s2/o1DOToyL5ix5B6kiqrrn8z9O9TjeRO/8g1oDcllFGTUj4q82TV9bVqw/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK4+aGIe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so1885495a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706823605; x=1707428405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBpGaBwml2SdVt0N+9WC3g+6k2v4eZ/PIRStuVJ+7DM=;
        b=lK4+aGIe5DVycY6M+JnsjqGOInsPhNVv3twHk3G5YBzPNaZJFd0RzdioU3DTM7JXeT
         mcJW3DWll7d6XMyHwCi7FqhC9jjcZaJxG0ju/WH7GqowPwVBRRBIlbcJt4eVwZNGiEC8
         otex7XQbasA/pbjiWK+pMURZ1k+AdfgF7Ra4juG60XN3//s5lGNLHRVPz/xA5jf0PRsu
         m2SfFFsPaNSMzWXCCeVnHe39OgZV6oiwVr+0CWDmvQ+ny79H1hHOh6JYAzBPGpCg1Je3
         7vBj3j2KgZLbjkV1juMLw3cMTuRmGF6JgmgN+c3HQ3x8KVWpWTkPHLpom8SBJuGq3Rj2
         Ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823605; x=1707428405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBpGaBwml2SdVt0N+9WC3g+6k2v4eZ/PIRStuVJ+7DM=;
        b=h5rNCUlQPWI1sU0kvJvrnCT3k3mEXZZVd44hPpsbKWBe2ATcBfR6KeZjlyxkdZ6TUo
         V5HXYDPJ0JyCnEclNqDEXfyn3OvXDa5iHiWscL1Og4aRdeebYc9CE7KAgv4nAfGHMFf4
         7C0W2w2UjssDKAQ2B+L3F22Uui/eKCvTKxd4gQdhr8RuMJn0pFYLKViQDq39na1Gqqh9
         LYCUTzPk0Gabqg6li50cadg6J1MCbIjTcC52xkCPUR3E8y0tirYbFEymHRnXfbNIuTg6
         GKtijh4LeyU2IVEng3UuNL2PZBXQDvsqouWW8qns0ew7/OzzTI/YJ8WwluazloLPH1bz
         dFHA==
X-Gm-Message-State: AOJu0Yw9fLXObS4CgE6WVQ0RyH2KJ9kQtoHQ33CIMRx8iIvFvOPphQB/
	TLNXAl/f3w6vzh0ePSQIjIvt/GSmy2eQq0r5OZciy1/metrFAYocqECYEdtB873GfFCCXM0d03E
	znhCZqSPARXEEXK0uYTBD49lrpg4=
X-Google-Smtp-Source: AGHT+IEmig3IH8734IzouS7pBsOjPKZDvgslgdKV+cBKmrF1Ls6Ge1Vi5s8dd9ysFiAKSyzxNcX1pVs+KdmT64ztZt0=
X-Received: by 2002:a05:6402:b07:b0:55f:ecc0:c1a3 with SMTP id
 bm7-20020a0564020b0700b0055fecc0c1a3mr38606edb.13.1706823604773; Thu, 01 Feb
 2024 13:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
 <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com> <Zbvslcl7YTy38HNF@ghost>
 <CAGu26P85ZO1dY+qftMndKzwBpsA72x=KNWVyry=38uPhfuFweQ@mail.gmail.com> <ZbwDdLmO1l9WDLxF@ghost>
In-Reply-To: <ZbwDdLmO1l9WDLxF@ghost>
From: Charles Lohr <lohr85@gmail.com>
Date: Thu, 1 Feb 2024 13:39:53 -0800
Message-ID: <CAGu26P8j25EgeqCrVwxKgyeDKDrP4=tHVW-kRLcRQC8rk3Xqng@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am very sorry for wasting your time - I did have it patched out in
the build system here. I can't wait for this feature to land, so I can
enjoy faster boot times without a patch.

Charles

On Thu, Feb 1, 2024 at 12:47=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Thu, Feb 01, 2024 at 11:57:04AM -0800, Charles Lohr wrote:
> > I am a little confused here - I was testing with 6.8-rc1 and it didn't
> > seem to have the behavior of performing the probe (The probe kills
> > boot performance in my application and I've had to patch out the probe
> > in mid-6.x kernels).
> >
> > Did something get reverted to bring back the probe even when
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3DY between rc1 and trunk?  Or a=
m
> > I misremembering/accidentally patched?
>
> After pulling a clean version of 6.8-rc1 and setting
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS I still see the probe happen.
> Before sending this I looked for a patch that disabled the probe but was
> unable to find one, if there exists a patch can you point me to it?
>
> - Charlie
>
> >
> > On Thu, Feb 1, 2024 at 11:10=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Thu, Feb 01, 2024 at 02:43:43PM +0100, Cl=C3=A9ment L=C3=A9ger wro=
te:
> > > >
> > > >
> > > > On 01/02/2024 07:40, Charlie Jenkins wrote:
> > > > > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus=
 can be
> > > > > set to have fast misaligned access without needing to probe.
> > > > >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
> > > > >  arch/riscv/kernel/cpufeature.c       | 4 ++++
> > > > >  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
> > > > >  arch/riscv/kernel/traps_misaligned.c | 4 ++++
> > > > >  4 files changed, 19 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/inc=
lude/asm/cpufeature.h
> > > > > index dfdcca229174..7d8d64783e38 100644
> > > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > > @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_e=
xtension_unlikely(int cpu, const unsi
> > > > >     return __riscv_isa_extension_available(hart_isa[cpu].isa, ext=
);
> > > > >  }
> > > > >
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > > > >
> > > > >  static __always_inline bool has_fast_misaligned_accesses(void)
> > > > >  {
> > > > >     return static_branch_likely(&fast_misaligned_access_speed_key=
);
> > > > >  }
> > > > > +#else
> > > > > +static __always_inline bool has_fast_misaligned_accesses(void)
> > > > > +{
> > > > > +   return true;
> > > > > +}
> > > > > +#endif
> > > > >  #endif
> > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/c=
pufeature.c
> > > > > index 89920f84d0a3..d787846c0b68 100644
> > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EX=
T_MAX) __read_mostly;
> > > > >  /* Per-cpu ISA extensions. */
> > > > >  struct riscv_isainfo hart_isa[NR_CPUS];
> > > > >
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >  /* Performance information */
> > > > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > > > >
> > > > >  static cpumask_t fast_misaligned_access;
> > > > > +#endif
> > > > >
> > > > >  /**
> > > > >   * riscv_isa_extension_base() - Get base extension word
> > > > > @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
> > > > >     return hwcap;
> > > > >  }
> > > > >
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >  static int check_unaligned_access(void *param)
> > > > >  {
> > > > >     int cpu =3D smp_processor_id();
> > > > > @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(vo=
id)
> > > > >  }
> > > > >
> > > > >  arch_initcall(check_unaligned_access_all_cpus);
> > > > > +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> > > > >
> > > > >  void riscv_user_isa_enable(void)
> > > > >  {
> > > >
> > > > Hi Charlie,
> > > >
> > > > Generally, having so much ifdef in various pieces of code is probab=
ly
> > > > not a good idea.
> > > >
> > > > AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the w=
hole
> > > > misaligned access speed checking could be opt-out. which means that
> > > > probably everything related to misaligned accesses should be moved =
in
> > > > it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACC=
ESS=3Dn
> > > > only.
> > >
> > > I will look into doing something more clever here! I agree it is not
> > > very nice to have so many ifdefs scattered.
> > >
> > > >
> > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/=
sys_hwprobe.c
> > > > > index a7c56b41efd2..3f1a6edfdb08 100644
> > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpu=
mask *cpus, unsigned long ext)
> > > > >
> > > > >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > > >  {
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >     int cpu;
> > > > >     u64 perf =3D -1ULL;
> > > > >
> > > > > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cp=
umask *cpus)
> > > > >             return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > > > >
> > > > >     return perf;
> > > > > +#else
> > > > > +   return RISCV_HWPROBE_MISALIGNED_FAST;
> > > > > +#endif
> > > > >  }
> > > > >
> > > > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/ke=
rnel/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> > > > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > > > @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *re=
gs)
> > > > >
> > > > >     perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > > > >
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >     *this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MIS=
ALIGNED_EMULATED;
> > > > > +#endif
> > > >
> > > > I think that rather using ifdefery inside this file (traps_misalign=
ed.c)
> > > >  it can be totally opt-out in case we have
> > > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misali=
gned
> > > > accesses are not emulated (at least that is my understanding).
> > > >
> > >
> > > That's a great idea, I believe that is correct.
> > >
> > > - Charlie
> > >
> > > > Thanks,
> > > >
> > > > Cl=C3=A9ment
> > > >
> > > >
> > > > >
> > > > >     if (!unaligned_enabled)
> > > > >             return -1;
> > > > > @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *r=
egs)
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > >  bool check_unaligned_access_emulated(int cpu)
> > > > >  {
> > > > >     long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
> > > > > @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
> > > > >     }
> > > > >     unaligned_ctl =3D true;
> > > > >  }
> > > > > +#endif
> > > > >
> > > > >  bool unaligned_ctl_available(void)
> > > > >  {
> > > > >
> > > >
> > > >
> > > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

