Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E578176B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 07:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbjHSFDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 01:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjHSFDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 01:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF353598;
        Fri, 18 Aug 2023 22:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A928624FB;
        Sat, 19 Aug 2023 05:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B07C433D9;
        Sat, 19 Aug 2023 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692421402;
        bh=zJHH3oSSZlW32cpLMCrsH2cgzDaK04ey1OWOAtmpGv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kT/b64GMu56VNtSPm+vyiGG0HK22+sWwfPdrIJ/l8swh32jrAYnaAdEwRraZWuU5p
         v1ldHxnC6nI5Nqr+mJMHCXrQamGDH/3DLtpfQ4QXPyC4AvOnVUo+PLpkdbeSuxvsnT
         fBXxvk77hc2H5HCpB11j/BCxU7BVnZR9QQFbrV9qJuNn0bCXkMfaqGKimPvgaZNGq+
         YreTkUikCJkWADvoaX/lSHWItOSQK460j+7vklobDuOd+Cd7aneZTU1KZngeLnhMN5
         9HAuoCdbnJ1eMGYeDoDpXyIV3yb51Xyo87JyYsrIl/w2ugtJdTzBRSSgTNqyfPxkzA
         Rqh5z2/UUr1fw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1894973a12.2;
        Fri, 18 Aug 2023 22:03:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzbhBMeDvxdAZhl2qFtwuEoBW26WCrStjle1QmQH5U8MuISxxyA
        N/RTKTXmy4FYCPFm99qyKxHE9NUnDQc6Wy6JBAs=
X-Google-Smtp-Source: AGHT+IEpcQFZ18PQn3Cyb+YEIbxLcHtQBeNkkiTxJmhVTVXqz4zOdjGYd2xXN8kvvusnuzaEF5Omn4gZ6pXV/lO0VoY=
X-Received: by 2002:a05:6402:204c:b0:522:2aba:bc3b with SMTP id
 bc12-20020a056402204c00b005222ababc3bmr780050edb.28.1692421400454; Fri, 18
 Aug 2023 22:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230817081345.1423-1-chenhuacai@loongson.cn> <CAEXW_YTM5sa15euDeQhEq0CQ=vqLis=pY-5PF00aKTk5y3J6jw@mail.gmail.com>
 <CAAhV-H71iVtpW8NN-v8WnbgUte4vp7D+82O8gdNvdkupcOauig@mail.gmail.com>
 <CAEXW_YTQucT9VkMwaLtyv2Ja7b1OG+UJX3w3GA3=ZbHeDq16tw@mail.gmail.com>
 <CAAhV-H632rGzu+T-GFjiy41r=QADASB91wuxnHvf-4sn5+psuQ@mail.gmail.com> <CAEXW_YQXMgoBjt_s1Et1Pi_A1oyFAu-hsTFJitamm1USAOGCHw@mail.gmail.com>
In-Reply-To: <CAEXW_YQXMgoBjt_s1Et1Pi_A1oyFAu-hsTFJitamm1USAOGCHw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 19 Aug 2023 13:02:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5brH8crw+aF90VhjPrZi86QaGvbnsFtN+J91fATuXmEA@mail.gmail.com>
Message-ID: <CAAhV-H5brH8crw+aF90VhjPrZi86QaGvbnsFtN+J91fATuXmEA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Update jiffies locally in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joel,

On Fri, Aug 18, 2023 at 11:32=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Fri, Aug 18, 2023 at 4:31=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Joel,
> >
> > On Fri, Aug 18, 2023 at 11:05=E2=80=AFAM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 10:36=E2=80=AFPM Huacai Chen <chenhuacai@kern=
el.org> wrote:
> > > >
> > > > Hi, Joel,
> > > >
> > > > On Fri, Aug 18, 2023 at 1:54=E2=80=AFAM Joel Fernandes <joel@joelfe=
rnandes.org> wrote:
> > > > >
> > > > > On Thu, Aug 17, 2023 at 4:14=E2=80=AFAM Huacai Chen <chenhuacai@l=
oongson.cn> wrote:
> > > > > >
> > > > > > The KGDB initial breakpoint gets an rcu stall warning after com=
mit
> > > > > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detecti=
on in
> > > > > > rcu_cpu_stall_reset()").
> > > > > >
> > > > > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CP=
U
> > > > > > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1=
/0x4000000000000000 softirq=3D375/375 fqs=3D8
> > > > > > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=
=3D4)
> > > > > > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-=
rc2+ #4848
> > > > > > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A200=
0-1w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-=
V2.0.05099-beta8 08
> > > > > > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000=
001000a0000 sp 90000001000a3710
> > > > > > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 00000=
00000000001 a3 0000000000000000
> > > > > > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 00000=
0000000002c a7 0000000000000000
> > > > > > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 90000=
0000131c9c0 t3 fffffffffffffffa
> > > > > > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 00000=
00000000004 t7 9000000001912d58
> > > > > > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 00000=
00000000028 s0 9000000001d512f0
> > > > > > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000=
000019fc410 s4 9000000001d4b488
> > > > > > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 00000=
00000000078 s8 9000000001d4b450
> > > > > > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x6=
40
> > > > > > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x6=
40
> > > > > > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=
=3DCC -WE)
> > > > > > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > > > > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > > > > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > > > > > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCod=
e=3D0)
> > > > > > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000=
-HV)
> > > > > > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-=
rc2+ #4848
> > > > > > [   54.430170] Stack : 0072617764726148 0000000000000000 900000=
0000223504 90000001000a0000
> > > > > > [   54.472308]         9000000100073a90 9000000100073a98 000000=
0000000000 9000000100073bd8
> > > > > > [   54.514413]         9000000100073bd0 9000000100073bd0 900000=
0100073a00 0000000000000001
> > > > > > [   54.556018]         0000000000000001 9000000100073a98 998282=
71f24e961a 90000001002810c0
> > > > > > [   54.596924]         0000000000000001 0000000000010003 000000=
0000000000 0000000000000001
> > > > > > [   54.637115]         ffff8000337cdb80 0000000000000001 000000=
0006360000 900000000131c9c0
> > > > > > [   54.677049]         0000000000000000 0000000000000000 900000=
00017b4c98 9000000001912000
> > > > > > [   54.716394]         9000000001912f68 9000000001913000 900000=
0001912f70 00000000000002b0
> > > > > > [   54.754880]         90000000014a8840 0000000000000000 900000=
000022351c 0000000000000000
> > > > > > [   54.792372]         00000000000002b0 000000000000000c 000000=
0000000000 0000000000071c1c
> > > > > > [   54.829302]         ...
> > > > > > [   54.859163] Call Trace:
> > > > > > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > > > > > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > > > > > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x=
148
> > > > > > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0=
xe60
> > > > > > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0=
xc0
> > > > > > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> > > > > > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/=
0x240
> > > > > > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2=
a0
> > > > > > [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x=
38/0x60
> > > > > > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0=
x50/0x160
> > > > > > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x1=
8/0x80
> > > > > > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> > > > > > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0=
x28/0x40
> > > > > > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > > > > > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0=
x60
> > > > > > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > > > > > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> > > > > > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104=
/0x180
> > > > > > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/=
0xa0
> > > > > > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > > > > > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > > > > > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x2=
8
> > > > > > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x1=
60/0x1c0
> > > > > > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c=
0
> > > > > > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > > > > > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > > > > > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > > > > > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/=
0x140
> > > > > > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x=
120
> > > > > > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc=
/0x160
> > > > > > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> > > > > > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> > > > > > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> > > > > > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > > > > > [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0=
x2c0
> > > > > > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > > > > > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> > > > > > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/=
0x2a0
> > > > > > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> > > > > >
> > > > > > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to =
one check
> > > > > > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). Bu=
t jiffies
> > > > > > is only updated in the timer interrupt, so when kgdb_cpu_enter(=
) begins
> > > > > > to run there may already be nearly one rcu check period after j=
iffies.
> > > > > > Since all interrupts are disabled during kgdb_cpu_enter(), jiff=
ies will
> > > > > > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffie=
s_stall
> > > > > > maybe already gets timeout.
> > > > > >
> > > > > > We can set rcu_state.jiffies_stall to two rcu check periods lat=
er, e.g.
> > > > > > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall=
_reset()
> > > > > > to avoid this problem. But this isn't a complete solution becau=
se kgdb
> > > > > > may take a very long time in irq disabled context.
> > > > > >
> > > > > > Instead, update jiffies at the beginning of rcu_cpu_stall_reset=
() can
> > > > > > solve all kinds of problems [1]. But this causes a new problem =
because
> > > > > > updating jiffies is not NMI safe while rcu_cpu_stall_reset() ma=
y be used
> > > > > > in NMI context.
> > > > > >
> > > > > > So we don't update the global jiffies, but only add the time 'd=
elta' to
> > > > > > jiffies locally at the beginning of rcu_cpu_stall_reset() which=
 has the
> > > > > > same effect.
> > > > > >
> > > > > > [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuac=
ai@loongson.cn/T/#t
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall =
detection in rcu_cpu_stall_reset()")
> > > > > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  kernel/rcu/tree_stall.h | 6 +++++-
> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > > > index b10b8349bb2a..1bf1306cae23 100644
> > > > > > --- a/kernel/rcu/tree_stall.h
> > > > > > +++ b/kernel/rcu/tree_stall.h
> > > > > > @@ -153,8 +153,12 @@ static void panic_on_rcu_stall(void)
> > > > > >   */
> > > > > >  void rcu_cpu_stall_reset(void)
> > > > > >  {
> > > > > > +       unsigned long delta;
> > > > > > +
> > > > > > +       delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_c=
oarse_ns());
> > > > > > +
> > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > -                  jiffies + rcu_jiffies_till_stall_check());
> > > > > > +                  jiffies + delta + rcu_jiffies_till_stall_che=
ck());
> > > > >
> > > > > This is certainly better than magic numbers, but I was still wond=
ering
> > > > > how the delta really works. What are typical values of delta, and=
 why
> > > > > is that equivalent to updating jiffies?
> > > > >
> > > > > Can you provide more technical details about why it turns out to =
be
> > > > > effectively the number of jiffies that the jiffies are off by?
> > > > >
> > > > > Also, how often do you see that an NMI is required to prevent a K=
GDB
> > > > > stall? If not, just do:
> > > > >
> > > > > void rcu_cpu_stall_reset(void) {
> > > > > [...]
> > > > >     if (!in_nmi) {
> > > > >       do_jiffies_update();
> > > > >    }
> > > > >    WRITE_ONCE(rcu_state.jiffies_stall, ..);
> > > > > [...]
> > > > > }
> > > > >
> > > > > ?
> > > > >
> > > > > But if your solution provides accurate results, that's fine with =
me. I
> > > > > just don't understand coarse ktime that much and how it differs f=
rom
> > > > > regular ktime, so I appreciate the education ;-)
> > > > ktime_get() get the accurate current time from clocksource,
> > > > ktime_get_coarse() get the coarse current time from jiffies. Below =
is
> > > > from Documentation/core-api/timekeeping.rst:
> > > >
> > > >         "The time returned here corresponds to the last timer tick,=
 which
> > > >         may be as much as 10ms in the past (for CONFIG_HZ=3D100), s=
ame as
> > > >         reading the 'jiffies' variable.  These are only useful when=
 called
> > > >         in a fast path and one still expects better than second acc=
uracy,
> > > >         but can't easily use 'jiffies', e.g. for inode timestamps."
> > > >
> > > > So, the delta between ktime_get() and ktime_get_coarse() is accurat=
ely
> > > > the delta when we update jiffies.
> > > >
> > >
> > > That sounds good to me then! I see you added Thomas so let us see if
> > > he yells back.
> > >
> > > But in the meanwhile, maybe you could also do some testing (if you
> > > want to) something like:
> > > =3D=3D=3D=3D=3D
> > > old_jiffies =3D jiffies;
> > > delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> > >
> > > /* do the jiffies update here */
> > >
> > > WARN_ON_ONCE(jiffies - old_jiffies !=3D delta);
> > > =3D=3D=3D=3D=3D
> > Thank you for your advice, I do an experiment with the code below:
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >         u64 old =3D jiffies;
> >         u64 now =3D ktime_get_ns();
> >
> >         delta =3D nsecs_to_jiffies(now - ktime_get_coarse_ns());
> >         tick_do_update_jiffies64(now);
> >         printk("jiffies - old =3D %lld, delta =3D %ld\n", jiffies - old=
, delta);
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > My machine has a quad-core cpu. I try 2 times, and I get:
> >
> > [   56.178011] jiffies - old =3D 13028, delta =3D 13028   #HZ=3D250, ~5=
0s
> > [   56.178010] jiffies - old =3D 13028, delta =3D 13028
> > [   56.178010] jiffies - old =3D 13028, delta =3D 13028
> > [   56.178012] jiffies - old =3D 13028, delta =3D 13028
> >
> > [   84.722304] jiffies - old =3D 6955, delta =3D 6955      #HZ=3D250, ~=
27s
> > [   84.722304] jiffies - old =3D 6955, delta =3D 6955
> > [   84.722304] jiffies - old =3D 6955, delta =3D 6955
> > [   84.722306] jiffies - old =3D 6955, delta =3D 6955
>
> Looks good and my testing went good as well. However, since we were
> worried about rcu_cpu_stall_reset() called from the NMI context, isn't
> ktime_get_mono_fast_ns() supposed to be the NMI safe version, which
> implies the others may not be? I am happy to be corrected on that...
> but the last thing we want is rcu_cpu_stall_reset() deadlocking in the
> timekeeping seq latch during a timekeeping update.
When Z. qiang first talks about the NMI issue, he means the update
code will acquire jiffies_lock raw spinlock, which causes deadlock.

ktime_get() is another story, when we say it is not NMI safe, we don't
mean deadlock because it doesn't acquire spinlock. We just mean that
it may get a wrong value because jiffies update is not an atomic
operation. But in practise this is also not a problem, because the
only caller of rcu_cpu_stall_reset() in NMI context is in
arch/x86/platform/uv/uv_nmi.c, and X86_UV depends on X86_64 so the
jiffies update is atomic in this case.

Huacai

>
> Can you not do a jiffies update safely at a point before the stall
> detector warns? That stall detection happened here in the
> scheduling-clock interrupt.
>
>  - Joel
