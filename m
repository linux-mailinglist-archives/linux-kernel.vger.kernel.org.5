Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797677A8FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjITW6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjITW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:58:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430FC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:57:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-503056c8195so676075e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695250677; x=1695855477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1cBIT5Yco0eHGaUNXSX4VGLYc2r6/KPjUSzBBXiGE8=;
        b=dyREEyVQdWkoRDYv4hMb95YoonXXixcbjQgD2+L2FIThMVG7TbsR6TVbWZ8T+sJOZj
         Ip9mA+Lz6Sv/wt4SsgXChofTXEGHNGCVEXp2UP2fAk9LgsI8S0XSLwLROY7ywD//m1K2
         7SAW8bZTZ/PBotC4stRrS0Ya9MQX9+n+KMIr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250677; x=1695855477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1cBIT5Yco0eHGaUNXSX4VGLYc2r6/KPjUSzBBXiGE8=;
        b=gm/e88zPuoipQR3SKC41j7uHRUVw8+ymB3oQQaOnfKcT3ZQnCOYiRJAaxZLPyMjQYI
         dNSjSNs+DYjRZyF1WSdE/VDYGLY+SpOs5IErake0wPP1tt09IgFGiJUjKT0eo3s7Ko/t
         YoebT5+BawXrBy4wbeFoACdhQLdkb3kUUxOpsWij12SoFXsoUcaHtNR1EL+ouzs0i0iQ
         uHxciuoTXpwKRtckRPFa4G4usIcvcY8XtMQYCbwIofuulCjYVB4PVZps8vb1fsTRJJmY
         ZUN7k1l9ORMfMFxWvx4KowmdymzXq+WEx/PX9MYVKnuJ93+IgcaEazAy3Mp6gjpWOKbA
         iAYg==
X-Gm-Message-State: AOJu0YwSc9FXXVRlJuvNXaOIr7swWr6uQ3thaDa0kM4o7kN1T/fsBzMQ
        hyD68jvHrxsr77MT5ys8Wc9x5kWwL7Uo9kvSXknB
X-Google-Smtp-Source: AGHT+IHMS5qJEXG4QOosLZfm7Qei6OXOcyhGsg2b5veFXMbwab1Qw9dyi0D1zgeQoXu0HJn66PVYbM+dDMy7t31PDVI=
X-Received: by 2002:a05:6512:34d2:b0:501:a5de:afed with SMTP id
 w18-20020a05651234d200b00501a5deafedmr2733833lfr.37.1695250676641; Wed, 20
 Sep 2023 15:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com> <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
In-Reply-To: <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 20 Sep 2023 15:57:43 -0700
Message-ID: <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:07=E2=80=AFPM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Wed, Sep 20, 2023 at 2:27=E2=80=AFPM Atish Patra <atishp@atishpatra.or=
g> wrote:
> >
> > On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > Yo,
> > >
> > > On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> > > > Probing for misaligned access speed takes about 0.06 seconds. On a
> > > > system with 64 cores, doing this in smp_callin() means it's done
> > > > serially, extending boot time by 3.8 seconds. That's a lot of boot =
time.
> > > >
> > > > Instead of measuring each CPU serially, let's do the measurements o=
n
> > > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > > except core 0, then 2) core 0.
> > > >
> > > > The measurement call in smp_callin() stays around, but is now
> > > > conditionalized to only run if a new CPU shows up after the round o=
f
> > > > in-parallel measurements has run. The goal is to have the measureme=
nt
> > > > call not run during boot or suspend/resume, but only on a hotplug
> > > > addition.
> > > >
> > > > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c9=
7debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > > > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > Tested-by: Andrew Jones <ajones@ventanamicro.com>
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > >  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING inst=
ead
> > > >    (Jisheng)
> > > >  - Added tags
> > > >
> > > >  arch/riscv/include/asm/cpufeature.h |  2 +-
> > > >  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
> > > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > > >  3 files changed, 28 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/inclu=
de/asm/cpufeature.h
> > > > index d0345bd659c9..b139796392d0 100644
> > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > > >  /* Per-cpu ISA extensions. */
> > > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > > >
> > > > -void check_unaligned_access(int cpu);
> > > > +int check_unaligned_access(void *unused);
> > > >
> > > >  #endif
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpu=
feature.c
> > > > index 1cfbba65d11a..40bb854fcb96 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > > >       return hwcap;
> > > >  }
> > > >
> > > > -void check_unaligned_access(int cpu)
> > > > +int check_unaligned_access(void *unused)
> > > >  {
> > > > +     int cpu =3D smp_processor_id();
> > > >       u64 start_cycles, end_cycles;
> > > >       u64 word_cycles;
> > > >       u64 byte_cycles;
> > > > @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
> > > >       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_=
SIZE));
> > > >       if (!page) {
> > > >               pr_warn("Can't alloc pages to measure memcpy performa=
nce");
> > > > -             return;
> > > > +             return 0;
> > >
> > > Dumb question maybe, but I am limited setup wise at the moment due to
> > > a hardware failure which makes checking stuff hard, why the signature
> > > change? Requirement for on_each_cpu()?
> > >
> >
> > Requirement for smp_call_on_cpu.
>
> Right.
>
> >
> > > >       }
> > > >
> > > >       /* Make an unaligned destination buffer. */
> > > > @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> > > >
> > > >  out:
> > > >       __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > > +{
> > > > +     if (smp_processor_id() !=3D 0)
> > > > +             check_unaligned_access(param);
> > > >  }
> > > >
> > > > -static int check_unaligned_access_boot_cpu(void)
> > > > +static int check_unaligned_access_all_cpus(void)
> > > >  {
> > > > -     check_unaligned_access(0);
> > > > +     /* Check everybody except 0, who stays behind to tend jiffies=
. */
> > > > +     on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > > +
> > > > +     /* Check core 0. */
> > > > +     smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > > >       return 0;
> > >
> > > Why does this function return an int if it can only return 0?
> > >
>
> This is a requirement on the initcall_t function pointer type.
>
> >
> > Should we define a check_unaligned_access_boot_cpu to avoid the return
> > type change ?
> > We can also get rid of the unused parameter in the
> > check_unaligned_access function.
>
> I don't think it matters too much either way. In my mind it sorta
> shifts the ballast around but doesn't really decrease it.
>

Yeah. But it is just a bit cleaner to avoid unused arguments if we can.

> >
> > I also noticed on_each_cpu invokes the function within preempt_disable/=
enable.
> > check_unaligned_access will invoke it again. It's probably harmless
> > but there is no need for non-boot cpus.
> >
> > We can just have preempt_disable/enable around check_unaligned_access
> > in the check_unaligned_access_boot_cpu function.
>
> It is harmless. I haven't walked fully through smp_call_on_cpu(), but
> I'd be intuitively quite surprised if preemption were enabled on those
> callbacks too (as you'd be saying "run my function on this cpu, but no
> guarantee it will stay there!"). So in theory I should be able to

I didn't see anything explicitly disable/enable preemption on smp_call_on_c=
pu.
As per my understanding, your queued function is guaranteed to run on that =
cpu
as it is queued on the cpu specific wq but it may be preempted by
something else.

For probing alignment speed, you just care about running it on that
cpu. Correct ?

> remove the preempt_disable/enable entirely. As a side note: I added
> the smp_call_on_cpu() because I couldn't convince myself the initcalls
> would stay on cpu 0. In practice they always seem to be.
>

I think that's the correct way to do it as the scheduler is active
now. There is no guarantee that
it will stay on cpu0 as you mentioned.

>
> -Evan



--=20
Regards,
Atish
