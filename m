Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331D77E9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjHPT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjHPT1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:27:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B61FCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:27:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76c8dd2ce79so593776985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692214057; x=1692818857;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPX5FeaZTzY86uCFDPJ271a8bs8NVoHQxjk1lGJJaGA=;
        b=R5a7Aab61WrLGF87vPrKwrlCKS7YymOpX1C/nQDfl2LF2T+J9eG5aB0nPzpKI9JL3T
         LuGr4VST4LQyq6uMKBsGSWOunGP0JXAUUmIJL+iSakKIj/QcjWoQyc/pz5T1NPdpDyou
         lw69fmwRq+EhaxGcsilIf5/WYcoCd79LzwG7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214057; x=1692818857;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPX5FeaZTzY86uCFDPJ271a8bs8NVoHQxjk1lGJJaGA=;
        b=gH4eLQ/Ax2qPm9g9f0SA8CWE1nZ/fcZzCgKMU0xEPHx8J9CpzoZ1Cps6ORZ2PGxQU+
         LHUQRj1eOEcXcBKg4iUDCHg1zxerOQ2TPBoZxR/1ZGaaid1Wy+LfIABXtErl5JIx6eFk
         3fcn7O7kVnUeM6GdD7jBe/zC4TvQI4l3CMCS12cRx3BvxQ32vgCYFgaA3fKWxQegQMQJ
         MZVUgOQDvuiWbK3XiH6xMcZkhECXpCIJLOpAAaUk75P1oNPdi8pqKQwFPHqX6VvxD4/c
         7Slm2Jy+WL4wX/I2cbZ9bgixtcsPyHH1KtY58cexrTyqy+ZhdcMJp0/vs4syOwVJuJm7
         m+7w==
X-Gm-Message-State: AOJu0Yznffw+LaBN5PA/5Vn31HfsV9xyG5qWfRfJS6yKHqmyGNE8Jh+7
        rUCwTQwBVp9qIS0K6B8jNrsmqw==
X-Google-Smtp-Source: AGHT+IHoIXzJ2/nT8CkLYHruk1DrrW+O03zUFqOBlqf8oUhqcNTPNnyvnObnGxs/mZF6N6x6pPCN4A==
X-Received: by 2002:a05:620a:404f:b0:767:464e:c529 with SMTP id i15-20020a05620a404f00b00767464ec529mr3407169qko.2.1692214057291;
        Wed, 16 Aug 2023 12:27:37 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.67])
        by smtp.gmail.com with ESMTPSA id c1-20020ae9e201000000b0076ca9269de7sm4610345qkc.124.2023.08.16.12.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 12:27:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Date:   Wed, 16 Aug 2023 15:27:25 -0400
Message-Id: <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
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
In-Reply-To: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2023, at 8:29 AM, Huacai Chen <chenhuacai@kernel.org> wrote:
>=20
> =EF=BB=BFHi, Qiang,
>=20
>> On Wed, Aug 16, 2023 at 6:06=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
>>=20
>>>=20
>>> Hi, Qiang,
>>>=20
>>> On Wed, Aug 16, 2023 at 1:09=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.c=
om> wrote:
>>>>=20
>>>>>=20
>>>>> Hi, Qiang,
>>>>>=20
>>>>> On Wed, Aug 16, 2023 at 11:16=E2=80=AFAM Z qiang <qiang.zhang1211@gmai=
l.com> wrote:
>>>>>>=20
>>>>>>>=20
>>>>>>> Hi, Paul,
>>>>>>>=20
>>>>>>> On Tue, Aug 15, 2023 at 12:15=E2=80=AFAM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
>>>>>>>>=20
>>>>>>>> On Mon, Aug 14, 2023 at 10:00:45AM +0800, Huacai Chen wrote:
>>>>>>>>> The KGDB initial breakpoint gets an rcu stall warning after commit=

>>>>>>>>> a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection i=
n
>>>>>>>>> rcu_cpu_stall_reset()").
>>>>>>>>>=20
>>>>>>>>> [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
>>>>>>>>> [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1/0x=
4000000000000000 softirq=3D375/375 fqs=3D8
>>>>>>>>> [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=3D=
4)
>>>>>>>>> [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2=
+ #4848
>>>>>>>>> [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1=
w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2.0=
.05099-beta8 08
>>>>>>>>> [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000001=
000a0000 sp 90000001000a3710
>>>>>>>>> [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 00000000=
00000001 a3 0000000000000000
>>>>>>>>> [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 00000000=
0000002c a7 0000000000000000
>>>>>>>>> [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 90000000=
0131c9c0 t3 fffffffffffffffa
>>>>>>>>> [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 00000000=
00000004 t7 9000000001912d58
>>>>>>>>> [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 00000000=
00000028 s0 9000000001d512f0
>>>>>>>>> [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000000=
019fc410 s4 9000000001d4b488
>>>>>>>>> [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 00000000=
00000078 s8 9000000001d4b450
>>>>>>>>> [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
>>>>>>>>> [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
>>>>>>>>> [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3D=
CC -WE)
>>>>>>>>> [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
>>>>>>>>> [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>>>>>>>>> [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
>>>>>>>>> [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCode=3D=
0)
>>>>>>>>> [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-HV=
)
>>>>>>>>> [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2=
+ #4848
>>>>>>>>> [   54.430170] Stack : 0072617764726148 0000000000000000 900000000=
0223504 90000001000a0000
>>>>>>>>> [   54.472308]         9000000100073a90 9000000100073a98 000000000=
0000000 9000000100073bd8
>>>>>>>>> [   54.514413]         9000000100073bd0 9000000100073bd0 900000010=
0073a00 0000000000000001
>>>>>>>>> [   54.556018]         0000000000000001 9000000100073a98 99828271f=
24e961a 90000001002810c0
>>>>>>>>> [   54.596924]         0000000000000001 0000000000010003 000000000=
0000000 0000000000000001
>>>>>>>>> [   54.637115]         ffff8000337cdb80 0000000000000001 000000000=
6360000 900000000131c9c0
>>>>>>>>> [   54.677049]         0000000000000000 0000000000000000 900000000=
17b4c98 9000000001912000
>>>>>>>>> [   54.716394]         9000000001912f68 9000000001913000 900000000=
1912f70 00000000000002b0
>>>>>>>>> [   54.754880]         90000000014a8840 0000000000000000 900000000=
022351c 0000000000000000
>>>>>>>>> [   54.792372]         00000000000002b0 000000000000000c 000000000=
0000000 0000000000071c1c
>>>>>>>>> [   54.829302]         ...
>>>>>>>>> [   54.859163] Call Trace:
>>>>>>>>> [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
>>>>>>>>> [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
>>>>>>>>> [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x148=

>>>>>>>>> [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe6=
0
>>>>>>>>> [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc0=

>>>>>>>>> [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
>>>>>>>>> [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x2=
40
>>>>>>>>> [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
>>>>>>>>> [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38/=
0x60
>>>>>>>>> [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x50=
/0x160
>>>>>>>>> [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/0=
x80
>>>>>>>>> [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
>>>>>>>>> [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x28=
/0x40
>>>>>>>>> [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
>>>>>>>>> [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x60=

>>>>>>>>> [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
>>>>>>>>> [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
>>>>>>>>> [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0x=
180
>>>>>>>>> [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0xa=
0
>>>>>>>>> [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
>>>>>>>>> [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
>>>>>>>>> [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
>>>>>>>>> [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160/=
0x1c0
>>>>>>>>> [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
>>>>>>>>> [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
>>>>>>>>> [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
>>>>>>>>> [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
>>>>>>>>> [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x1=
40
>>>>>>>>> [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x120=

>>>>>>>>> [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0x=
160
>>>>>>>>> [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
>>>>>>>>> [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
>>>>>>>>> [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
>>>>>>>>> [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
>>>>>>>>> [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2c=
0
>>>>>>>>> [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
>>>>>>>>> [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
>>>>>>>>> [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x2=
a0
>>>>>>>>> [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
>>>>>>>>>=20
>>>>>>>>> Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to one=
 check
>>>>>>>>> period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But j=
iffies
>>>>>>>>> is only updated in the timer interrupt, so when kgdb_cpu_enter() b=
egins
>>>>>>>>> to run there may already be nearly one rcu check period after jiff=
ies.
>>>>>>>>> Since all interrupts are disabled during kgdb_cpu_enter(), jiffies=
 will
>>>>>>>>> not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_s=
tall
>>>>>>>>> maybe already gets timeout.
>>>>>>>>>=20
>>>>>>>>> We can set rcu_state.jiffies_stall to two rcu check periods later,=
 e.g.
>>>>>>>>> jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_re=
set()
>>>>>>>>> to avoid this problem. But this isn't a complete solution because k=
gdb
>>>>>>>>> may take a very long time in irq disabled context.
>>>>>>>>>=20
>>>>>>>>> Instead, update jiffies at the beginning of rcu_cpu_stall_reset() c=
an
>>>>>>>>> solve all kinds of problems.
>>>>>>>>=20
>>>>>>>> Would it make sense for there to be a kgdb_cpu_exit()?  In that cas=
e,
>>>>>>>> the stalls could simply be suppressed at the beginning of the debug=

>>>>>>>> session and re-enabled upon exit, as is currently done for sysrq ou=
tput
>>>>>>>> via rcu_sysrq_start() and rcu_sysrq_end().
>>>>>>> Thank you for your advice, but that doesn't help. Because
>>>>>>> rcu_sysrq_start() and rcu_sysrq_end() try to suppress the warnings
>>>>>>> during sysrq, but kgdb already has no warnings during kgdb_cpu_enter=
()
>>>>>>> since it is executed in irq disabled context. Instead, this patch
>>>>>>> wants to suppress the warnings *after* kgdb_cpu_enter() due to a ver=
y
>>>>>>> old jiffies value.
>>>>>>>=20
>>>>>>=20
>>>>>> Hello, Huacai
>>>>>>=20
>>>>>> Is it possible to set  the rcu_cpu_stall_suppress is true in
>>>>>> dbg_touch_watchdogs()
>>>>>> and reset the rcu_cpu_stall_suppress at the beginning and end of the
>>>>>> RCU grace period?
>>>>> This is possible but not the best: 1, kgdb is not the only caller of
>>>>> rcu_cpu_stall_reset(); 2, it is difficult to find the "end" to reset
>>>>> rcu_cpu_stall_suppress.
>>>>>=20
>>>>=20
>>>> You can replace rcu_state.jiffies_stall update by setting rcu_cpu_stall=
_suppress
>>>> in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in rcu_gp_i=
nit() and
>>>> rcu_gp_cleanup().
>>> What's the advantage compared with updating jiffies? Updating jiffies
>>> seems more straight forward.
>>>=20
>>=20
>> In do_update_jiffies_64(), need to acquire jiffies_lock raw spinlock,
>> like you said, kgdb is not the only caller of rcu_cpu_stall_reset(),
>> the rcu_cpu_stall_reset() maybe invoke in NMI  (arch/x86/platform/uv/uv_n=
mi.c)
> Reset rcu_cpu_stall_suppress in rcu_gp_init()/rcu_gp_cleanup() is
> still not so good to me, because it does a useless operation in most
> cases. Moreover, the rcu core is refactored again and again, something
> may be changed in future.
>=20
> If  do_update_jiffies_64() cannot be used in NMI context,

Can you not make the jiffies update conditional on whether it is called with=
in NMI context?

> can we
> consider my old method [1]?
> https://lore.kernel.org/rcu/CAAhV-H7j9Y=3DVvRLm8thLw-EX1PGqBA9YfT4G1AN7ucY=
S=3DiP+DQ@mail.gmail.com/T/#t
>=20
> Of course we should set rcu_state.jiffies_stall large enough, so we
> can do like this:
>=20
> void rcu_cpu_stall_reset(void)
> {
>  WRITE_ONCE(rcu_state.jiffies_stall,
> -   jiffies + rcu_jiffies_till_stall_check());
> +   jiffies + 300 * HZ);
> }
>=20
> 300s is the largest timeout value, and I think 300s is enough here in prac=
tice.

I dislike that..

Thanks,

 - Joel



>=20
> Huacai
>=20
>>=20
>> Thanks
>> Zqiang
>>=20
>>=20
>>> Huacai
>>>=20
>>>>=20
>>>> Thanks
>>>> Zqiang
>>>>=20
>>>>>=20
>>>>>> or set rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 in bootargs can
>>>>>> suppress RCU stall
>>>>>> in booting.
>>>>> This is also possible, but it suppresses all kinds of stall warnings,
>>>>> which is not what we want.
>>>>>=20
>>>>> Huacai
>>>>>>=20
>>>>>>=20
>>>>>> Thanks
>>>>>> Zqiang
>>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> Huacai
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>                                                        Thanx, Paul
>>>>>>>>=20
>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall det=
ection in rcu_cpu_stall_reset()")
>>>>>>>>> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>>>>> ---
>>>>>>>>> kernel/rcu/tree_stall.h | 1 +
>>>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>>>=20
>>>>>>>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>>>>>>>>> index b10b8349bb2a..1c7b540985bf 100644
>>>>>>>>> --- a/kernel/rcu/tree_stall.h
>>>>>>>>> +++ b/kernel/rcu/tree_stall.h
>>>>>>>>> @@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
>>>>>>>>>  */
>>>>>>>>> void rcu_cpu_stall_reset(void)
>>>>>>>>> {
>>>>>>>>> +     do_update_jiffies_64(ktime_get());
>>>>>>>>>      WRITE_ONCE(rcu_state.jiffies_stall,
>>>>>>>>>                 jiffies + rcu_jiffies_till_stall_check());
>>>>>>>>> }
>>>>>>>>> --
>>>>>>>>> 2.39.3
>>>>>>>>>=20
