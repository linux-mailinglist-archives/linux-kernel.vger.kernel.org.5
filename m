Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309477F1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbjHQIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348743AbjHQIGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3962D77;
        Thu, 17 Aug 2023 01:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22BE6524A;
        Thu, 17 Aug 2023 08:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF7BC433CC;
        Thu, 17 Aug 2023 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692259590;
        bh=pmoGleVhd8MZ73JWrhPmJMhOV2uZdrh3BJkC59h6O3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uK5sXJhHdIiN3KII4z7IY95vt8enLDhsqpIFOIYx0N3xD0lL5t0oEQzLBTUswvkbv
         B/Z884GSXDMNcFWgtfVvE1RAkE5LL+P/q2ndBYK0Cs2iwJsBXUwT8W5G/DEIn3iMCh
         cKosDmok1D5ruq7SxKXiVsh60JmBEfOH+wDOEGjvP19AMai+pz60stltyD2lW5lwic
         Yf3zB4tIcE9iJGgUAII/HUQLPqjNxyokGKIw68v2U0cdwj9SeKYVoZXYNPE4JG1JAp
         mfUPPC/ur2tVsXJxQEiXDfNTWdmRsSCBM8lAfmAEVrD5cxhyN+eoFMF0bl7ce3oyuz
         mwJ7W4ZVzESHA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5254f9eda36so6267266a12.1;
        Thu, 17 Aug 2023 01:06:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwrRVrU21ResttOEkUAGjahfAURtHfoSf+/GNdgDZ8urbG6WGZ
        8uUg85Ae8/t7dSg1KmrEjSoo4BvLaATWa2cQmyE=
X-Google-Smtp-Source: AGHT+IGejQn44SoOokE8iZXEOHBXsByRl/rJPmnia71qLn8mK7CsGGVS+MioSfiBLIy+Dryhrs2Kcf9QPSWxacIMHhU=
X-Received: by 2002:a05:6402:712:b0:523:3ff6:dfc2 with SMTP id
 w18-20020a056402071200b005233ff6dfc2mr3146353edx.29.1692259588270; Thu, 17
 Aug 2023 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
In-Reply-To: <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 17 Aug 2023 16:06:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
Message-ID: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joel,

On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
>
>
> > On Aug 16, 2023, at 8:29 AM, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > =EF=BB=BFHi, Qiang,
> >
> >> On Wed, Aug 16, 2023 at 6:06=E2=80=AFPM Z qiang <qiang.zhang1211@gmail=
.com> wrote:
> >>
> >>>
> >>> Hi, Qiang,
> >>>
> >>> On Wed, Aug 16, 2023 at 1:09=E2=80=AFPM Z qiang <qiang.zhang1211@gmai=
l.com> wrote:
> >>>>
> >>>>>
> >>>>> Hi, Qiang,
> >>>>>
> >>>>> On Wed, Aug 16, 2023 at 11:16=E2=80=AFAM Z qiang <qiang.zhang1211@g=
mail.com> wrote:
> >>>>>>
> >>>>>>>
> >>>>>>> Hi, Paul,
> >>>>>>>
> >>>>>>> On Tue, Aug 15, 2023 at 12:15=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Aug 14, 2023 at 10:00:45AM +0800, Huacai Chen wrote:
> >>>>>>>>> The KGDB initial breakpoint gets an rcu stall warning after com=
mit
> >>>>>>>>> a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detecti=
on in
> >>>>>>>>> rcu_cpu_stall_reset()").
> >>>>>>>>>
> >>>>>>>>> [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CP=
U
> >>>>>>>>> [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1=
/0x4000000000000000 softirq=3D375/375 fqs=3D8
> >>>>>>>>> [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=
=3D4)
> >>>>>>>>> [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-=
rc2+ #4848
> >>>>>>>>> [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A200=
0-1w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-=
V2.0.05099-beta8 08
> >>>>>>>>> [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000=
001000a0000 sp 90000001000a3710
> >>>>>>>>> [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 00000=
00000000001 a3 0000000000000000
> >>>>>>>>> [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 00000=
0000000002c a7 0000000000000000
> >>>>>>>>> [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 90000=
0000131c9c0 t3 fffffffffffffffa
> >>>>>>>>> [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 00000=
00000000004 t7 9000000001912d58
> >>>>>>>>> [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 00000=
00000000028 s0 9000000001d512f0
> >>>>>>>>> [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000=
000019fc410 s4 9000000001d4b488
> >>>>>>>>> [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 00000=
00000000078 s8 9000000001d4b450
> >>>>>>>>> [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x6=
40
> >>>>>>>>> [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x6=
40
> >>>>>>>>> [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=
=3DCC -WE)
> >>>>>>>>> [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> >>>>>>>>> [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> >>>>>>>>> [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> >>>>>>>>> [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCod=
e=3D0)
> >>>>>>>>> [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000=
-HV)
> >>>>>>>>> [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-=
rc2+ #4848
> >>>>>>>>> [   54.430170] Stack : 0072617764726148 0000000000000000 900000=
0000223504 90000001000a0000
> >>>>>>>>> [   54.472308]         9000000100073a90 9000000100073a98 000000=
0000000000 9000000100073bd8
> >>>>>>>>> [   54.514413]         9000000100073bd0 9000000100073bd0 900000=
0100073a00 0000000000000001
> >>>>>>>>> [   54.556018]         0000000000000001 9000000100073a98 998282=
71f24e961a 90000001002810c0
> >>>>>>>>> [   54.596924]         0000000000000001 0000000000010003 000000=
0000000000 0000000000000001
> >>>>>>>>> [   54.637115]         ffff8000337cdb80 0000000000000001 000000=
0006360000 900000000131c9c0
> >>>>>>>>> [   54.677049]         0000000000000000 0000000000000000 900000=
00017b4c98 9000000001912000
> >>>>>>>>> [   54.716394]         9000000001912f68 9000000001913000 900000=
0001912f70 00000000000002b0
> >>>>>>>>> [   54.754880]         90000000014a8840 0000000000000000 900000=
000022351c 0000000000000000
> >>>>>>>>> [   54.792372]         00000000000002b0 000000000000000c 000000=
0000000000 0000000000071c1c
> >>>>>>>>> [   54.829302]         ...
> >>>>>>>>> [   54.859163] Call Trace:
> >>>>>>>>> [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> >>>>>>>>> [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> >>>>>>>>> [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x=
148
> >>>>>>>>> [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0=
xe60
> >>>>>>>>> [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0=
xc0
> >>>>>>>>> [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> >>>>>>>>> [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/=
0x240
> >>>>>>>>> [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2=
a0
> >>>>>>>>> [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x=
38/0x60
> >>>>>>>>> [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0=
x50/0x160
> >>>>>>>>> [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x1=
8/0x80
> >>>>>>>>> [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> >>>>>>>>> [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0=
x28/0x40
> >>>>>>>>> [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> >>>>>>>>> [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0=
x60
> >>>>>>>>> [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> >>>>>>>>> [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> >>>>>>>>> [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104=
/0x180
> >>>>>>>>> [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/=
0xa0
> >>>>>>>>> [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> >>>>>>>>> [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> >>>>>>>>> [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x2=
8
> >>>>>>>>> [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x1=
60/0x1c0
> >>>>>>>>> [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c=
0
> >>>>>>>>> [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> >>>>>>>>> [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> >>>>>>>>> [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> >>>>>>>>> [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/=
0x140
> >>>>>>>>> [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x=
120
> >>>>>>>>> [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc=
/0x160
> >>>>>>>>> [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> >>>>>>>>> [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> >>>>>>>>> [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> >>>>>>>>> [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> >>>>>>>>> [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0=
x2c0
> >>>>>>>>> [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> >>>>>>>>> [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> >>>>>>>>> [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/=
0x2a0
> >>>>>>>>> [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> >>>>>>>>>
> >>>>>>>>> Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to =
one check
> >>>>>>>>> period later, i.e. jiffies + rcu_jiffies_till_stall_check(). Bu=
t jiffies
> >>>>>>>>> is only updated in the timer interrupt, so when kgdb_cpu_enter(=
) begins
> >>>>>>>>> to run there may already be nearly one rcu check period after j=
iffies.
> >>>>>>>>> Since all interrupts are disabled during kgdb_cpu_enter(), jiff=
ies will
> >>>>>>>>> not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffie=
s_stall
> >>>>>>>>> maybe already gets timeout.
> >>>>>>>>>
> >>>>>>>>> We can set rcu_state.jiffies_stall to two rcu check periods lat=
er, e.g.
> >>>>>>>>> jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall=
_reset()
> >>>>>>>>> to avoid this problem. But this isn't a complete solution becau=
se kgdb
> >>>>>>>>> may take a very long time in irq disabled context.
> >>>>>>>>>
> >>>>>>>>> Instead, update jiffies at the beginning of rcu_cpu_stall_reset=
() can
> >>>>>>>>> solve all kinds of problems.
> >>>>>>>>
> >>>>>>>> Would it make sense for there to be a kgdb_cpu_exit()?  In that =
case,
> >>>>>>>> the stalls could simply be suppressed at the beginning of the de=
bug
> >>>>>>>> session and re-enabled upon exit, as is currently done for sysrq=
 output
> >>>>>>>> via rcu_sysrq_start() and rcu_sysrq_end().
> >>>>>>> Thank you for your advice, but that doesn't help. Because
> >>>>>>> rcu_sysrq_start() and rcu_sysrq_end() try to suppress the warning=
s
> >>>>>>> during sysrq, but kgdb already has no warnings during kgdb_cpu_en=
ter()
> >>>>>>> since it is executed in irq disabled context. Instead, this patch
> >>>>>>> wants to suppress the warnings *after* kgdb_cpu_enter() due to a =
very
> >>>>>>> old jiffies value.
> >>>>>>>
> >>>>>>
> >>>>>> Hello, Huacai
> >>>>>>
> >>>>>> Is it possible to set  the rcu_cpu_stall_suppress is true in
> >>>>>> dbg_touch_watchdogs()
> >>>>>> and reset the rcu_cpu_stall_suppress at the beginning and end of t=
he
> >>>>>> RCU grace period?
> >>>>> This is possible but not the best: 1, kgdb is not the only caller o=
f
> >>>>> rcu_cpu_stall_reset(); 2, it is difficult to find the "end" to rese=
t
> >>>>> rcu_cpu_stall_suppress.
> >>>>>
> >>>>
> >>>> You can replace rcu_state.jiffies_stall update by setting rcu_cpu_st=
all_suppress
> >>>> in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in rcu_g=
p_init() and
> >>>> rcu_gp_cleanup().
> >>> What's the advantage compared with updating jiffies? Updating jiffies
> >>> seems more straight forward.
> >>>
> >>
> >> In do_update_jiffies_64(), need to acquire jiffies_lock raw spinlock,
> >> like you said, kgdb is not the only caller of rcu_cpu_stall_reset(),
> >> the rcu_cpu_stall_reset() maybe invoke in NMI  (arch/x86/platform/uv/u=
v_nmi.c)
> > Reset rcu_cpu_stall_suppress in rcu_gp_init()/rcu_gp_cleanup() is
> > still not so good to me, because it does a useless operation in most
> > cases. Moreover, the rcu core is refactored again and again, something
> > may be changed in future.
> >
> > If  do_update_jiffies_64() cannot be used in NMI context,
>
> Can you not make the jiffies update conditional on whether it is called w=
ithin NMI context?
>
> > can we
> > consider my old method [1]?
> > https://lore.kernel.org/rcu/CAAhV-H7j9Y=3DVvRLm8thLw-EX1PGqBA9YfT4G1AN7=
ucYS=3DiP+DQ@mail.gmail.com/T/#t
> >
> > Of course we should set rcu_state.jiffies_stall large enough, so we
> > can do like this:
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >  WRITE_ONCE(rcu_state.jiffies_stall,
> > -   jiffies + rcu_jiffies_till_stall_check());
> > +   jiffies + 300 * HZ);
> > }
> >
> > 300s is the largest timeout value, and I think 300s is enough here in p=
ractice.
>
> I dislike that..
Is this acceptable?

void rcu_cpu_stall_reset(void)
{
        unsigned long delta;

        delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());

        WRITE_ONCE(rcu_state.jiffies_stall,
                   jiffies + delta + rcu_jiffies_till_stall_check());
}

This can update jiffies_stall without updating jiffies (but has the
same effect).



Huacai
>
> Thanks,
>
>  - Joel
>
>
>
> >
> > Huacai
> >
> >>
> >> Thanks
> >> Zqiang
> >>
> >>
> >>> Huacai
> >>>
> >>>>
> >>>> Thanks
> >>>> Zqiang
> >>>>
> >>>>>
> >>>>>> or set rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 in bootargs can
> >>>>>> suppress RCU stall
> >>>>>> in booting.
> >>>>> This is also possible, but it suppresses all kinds of stall warning=
s,
> >>>>> which is not what we want.
> >>>>>
> >>>>> Huacai
> >>>>>>
> >>>>>>
> >>>>>> Thanks
> >>>>>> Zqiang
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>>
> >>>>>>>>                                                        Thanx, Pa=
ul
> >>>>>>>>
> >>>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>>> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall =
detection in rcu_cpu_stall_reset()")
> >>>>>>>>> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>>>>>>> ---
> >>>>>>>>> kernel/rcu/tree_stall.h | 1 +
> >>>>>>>>> 1 file changed, 1 insertion(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >>>>>>>>> index b10b8349bb2a..1c7b540985bf 100644
> >>>>>>>>> --- a/kernel/rcu/tree_stall.h
> >>>>>>>>> +++ b/kernel/rcu/tree_stall.h
> >>>>>>>>> @@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
> >>>>>>>>>  */
> >>>>>>>>> void rcu_cpu_stall_reset(void)
> >>>>>>>>> {
> >>>>>>>>> +     do_update_jiffies_64(ktime_get());
> >>>>>>>>>      WRITE_ONCE(rcu_state.jiffies_stall,
> >>>>>>>>>                 jiffies + rcu_jiffies_till_stall_check());
> >>>>>>>>> }
> >>>>>>>>> --
> >>>>>>>>> 2.39.3
> >>>>>>>>>
