Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC47A8E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjITV1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjITV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:27:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC99E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:27:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-503065c4b25so527147e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695245263; x=1695850063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pb9mXoaFph7aPdXI6eoCGEpX70AMX5vAVkIeLXySE0=;
        b=UGzJqNvccMmCv42XB3jEVcbTupYUznH/aJtg+JcD1EpWpwHiDPNZQRs+WgATGzF14j
         rIpbKwhT1Wa55sjas5x2URgpAUIFA6+262prdx4j8HFqnkqr/3ZGcKs1xof4uATKcVB3
         kc+zzPL35Leb662E+Wy6JL6Ln++HljxvvBtAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245263; x=1695850063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pb9mXoaFph7aPdXI6eoCGEpX70AMX5vAVkIeLXySE0=;
        b=YEfstHy30zU7ATlNhlWH6Nw1K4J8H/qG7i/4H3XGy5buk4oZkIfYVonEZLxnCMFhWW
         KH+X08E0GSYkK+g5LYTWobouitI13UZKDSJU1TOqbNjmm2B9Lb/9DCNZwRcYgjGluDyT
         XoGLBO2mhJdEkO17S03rrtUUjvB706bXgWxNacUP+ocDqcG7DXjnLR4ixy2/Skxp0kRC
         38sfHgwVM0IJlpOSN9h6XnspIPfMrm6ppXeeZZ9M/9He6P51TfgKnbYPbjDMOAks0tAq
         ZMv8YI404gVTQaDAkyCRd6JXxdQQ3nS+VWEYqlDVnX7t4e37TyzaeeMr8Ckhe5cmHqNI
         /0bA==
X-Gm-Message-State: AOJu0YygSK9RM9Lh5Naowm2RLMLGuEhkAhUJDZaXdMNI6AbLBomIwd1R
        Fo7EnzjLvPShRCGO4JzOU5cIo8c8Ol9AWwYlso7b
X-Google-Smtp-Source: AGHT+IFEaRbmjfJtUpnQ68ueuBDG+X8BkhgE/jvvcMZ2xRXdTdzvZEUeNF0+l8Cye9IMAqToU6iALsHrP8tQ2tU2CZA=
X-Received: by 2002:a05:6512:3292:b0:503:9eb:d277 with SMTP id
 p18-20020a056512329200b0050309ebd277mr2721640lfe.49.1695245262821; Wed, 20
 Sep 2023 14:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
In-Reply-To: <20230920-98a392b40f88c69e852e2c88@fedora>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 20 Sep 2023 14:27:31 -0700
Message-ID: <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Yo,
>
> On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> > Probing for misaligned access speed takes about 0.06 seconds. On a
> > system with 64 cores, doing this in smp_callin() means it's done
> > serially, extending boot time by 3.8 seconds. That's a lot of boot time=
.
> >
> > Instead of measuring each CPU serially, let's do the measurements on
> > all CPUs in parallel. If we disable preemption on all CPUs, the
> > jiffies stop ticking, so we can do this in stages of 1) everybody
> > except core 0, then 2) core 0.
> >
> > The measurement call in smp_callin() stays around, but is now
> > conditionalized to only run if a new CPU shows up after the round of
> > in-parallel measurements has run. The goal is to have the measurement
> > call not run during boot or suspend/resume, but only on a hotplug
> > addition.
> >
> > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97deb=
e1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Tested-by: Andrew Jones <ajones@ventanamicro.com>
> >
> > ---
> >
> > Changes in v2:
> >  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING instead
> >    (Jisheng)
> >  - Added tags
> >
> >  arch/riscv/include/asm/cpufeature.h |  2 +-
> >  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
> >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index d0345bd659c9..b139796392d0 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> >  /* Per-cpu ISA extensions. */
> >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> >
> > -void check_unaligned_access(int cpu);
> > +int check_unaligned_access(void *unused);
> >
> >  #endif
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 1cfbba65d11a..40bb854fcb96 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
> >       return hwcap;
> >  }
> >
> > -void check_unaligned_access(int cpu)
> > +int check_unaligned_access(void *unused)
> >  {
> > +     int cpu =3D smp_processor_id();
> >       u64 start_cycles, end_cycles;
> >       u64 word_cycles;
> >       u64 byte_cycles;
> > @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
> >       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
> >       if (!page) {
> >               pr_warn("Can't alloc pages to measure memcpy performance"=
);
> > -             return;
> > +             return 0;
>
> Dumb question maybe, but I am limited setup wise at the moment due to
> a hardware failure which makes checking stuff hard, why the signature
> change? Requirement for on_each_cpu()?
>

Requirement for smp_call_on_cpu.

> >       }
> >
> >       /* Make an unaligned destination buffer. */
> > @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> >
> >  out:
> >       __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > +     return 0;
> > +}
> > +
> > +static void check_unaligned_access_nonboot_cpu(void *param)
> > +{
> > +     if (smp_processor_id() !=3D 0)
> > +             check_unaligned_access(param);
> >  }
> >
> > -static int check_unaligned_access_boot_cpu(void)
> > +static int check_unaligned_access_all_cpus(void)
> >  {
> > -     check_unaligned_access(0);
> > +     /* Check everybody except 0, who stays behind to tend jiffies. */
> > +     on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > +
> > +     /* Check core 0. */
> > +     smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> >       return 0;
>
> Why does this function return an int if it can only return 0?
>

Should we define a check_unaligned_access_boot_cpu to avoid the return
type change ?
We can also get rid of the unused parameter in the
check_unaligned_access function.

I also noticed on_each_cpu invokes the function within preempt_disable/enab=
le.
check_unaligned_access will invoke it again. It's probably harmless
but there is no need for non-boot cpus.

We can just have preempt_disable/enable around check_unaligned_access
in the check_unaligned_access_boot_cpu function.

> Cheers,
> Conor.
>
> >  }
> >
> > -arch_initcall(check_unaligned_access_boot_cpu);
> > +arch_initcall(check_unaligned_access_all_cpus);
> >
> >  #ifdef CONFIG_RISCV_ALTERNATIVE
> >  /*
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 1b8da4e40a4d..a014955b8699 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/hwprobe.h>
> >  #include <asm/irq.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/numa.h>
> > @@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
> >
> >       numa_add_cpu(curr_cpuid);
> >       set_cpu_online(curr_cpuid, 1);
> > -     check_unaligned_access(curr_cpuid);
> > +
> > +     /*
> > +      * Boot-time misaligned access speed measurements are done in par=
allel
> > +      * in an initcall. Only measure here for hotplug.
> > +      */
> > +     if ((system_state =3D=3D SYSTEM_RUNNING) &&
> > +         (per_cpu(misaligned_access_speed, curr_cpuid) =3D=3D RISCV_HW=
PROBE_MISALIGNED_UNKNOWN)) {
> > +             check_unaligned_access(NULL);
> > +     }
> >
> >       if (has_vector()) {
> >               if (riscv_v_setup_vsize())
> > --
> > 2.34.1
> >
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
