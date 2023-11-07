Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED147E36B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjKGIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjKGIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:34:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20FBD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:34:15 -0800 (PST)
Date:   Tue, 7 Nov 2023 09:34:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699346053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWJk9nL8xlrcEUZ19TjgnfyXI3oFOA97vzHt9B/TpHU=;
        b=2BAOVEM2MkhWFzYNhU0L0NWAgz71dhhwB/EyqNU3aPKvT/3kM5Xr7bz9jweX0fuVrm++Cl
        jJrRF3OH0M0pdXlr2jEbXyWMtJ4xZk4OoqBgPwYz1qkkkbKJ7aX05Fq8dmCZgEu/pb7YZH
        ZSMq3m5BetHLlW9LU2z7Q5hnPDzInWJKnRdTBRBvn0usqMgO7Mdrf65DdKEX67yoVboafl
        556MILwGAOPrnSgzHOcIKzkHipW7rRJODJSl5dbgo/AiIukwnLfV3dydZWzZ29eQcGwvPe
        Z2fAHCLqOq/ihgFQuWwk+Bnkh5T98+AmQSdQaCzVXwuLd3D6D0biXSAiBOsojw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699346053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWJk9nL8xlrcEUZ19TjgnfyXI3oFOA97vzHt9B/TpHU=;
        b=l8ekf5952TYSX13DM2PgLJGVKnksuDGDa4y/Hi+ZLOejIQVBdacpg1hHI+cGLPnzdyXPtB
        9HNl1WjpJDpY0hCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20231107083411.J3ga0YmA@linutronix.de>
References: <20231106225855.3121724-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231106225855.3121724-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06 14:58:55 [-0800], Evan Green wrote:
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
>=20
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0. The allocations are all done outside of
> on_each_cpu() to avoid calling alloc_pages() with interrupts disabled.
>=20
> For hotplugged CPUs that come in after the boot time measurement,
> register CPU hotplug callbacks, and do the measurement there. Interrupts
> are enabled in those callbacks, so they're fine to do alloc_pages() in.

I think this is dragged out of proportion. I would do this (if needed
can can't be identified by CPU-ID or so) on boot CPU only. If there is
evidence/ proof/ blessing from the high RiscV council that different
types of CPU cores are mixed together then this could be extended.
You brought Big-Little up in the other thread. This is actually known.
Same as with hyper-threads on x86, you know which CPU is the core and
which hyper thread (CPU) belongs to it.
So in terms of BigLittle you _could_ limit this to one Big and one
Little core instead running it on all.

But this is just my few on this. From PREEMPT_RT's point of view, the
way you restructured the memory allocation should work now.

> Reported-by: Jisheng Zhang <jszhang@kernel.org>
> Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97debe1=
cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 6a01ded615cd..fe59e18dbd5b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
=E2=80=A6
> =20
> -static int __init check_unaligned_access_boot_cpu(void)
> +/* Measure unaligned access on all CPUs present at boot in parallel. */
> +static int check_unaligned_access_all_cpus(void)
>  {
> -	check_unaligned_access(0);
> +	unsigned int cpu;
> +	unsigned int cpu_count =3D num_possible_cpus();
> +	struct page **bufs =3D kzalloc(cpu_count * sizeof(struct page *),
> +				     GFP_KERNEL);

kcalloc(). For beauty reasons you could try a reverse xmas tree.=20

> +
> +	if (!bufs) {
> +		pr_warn("Allocation failure, not measuring misaligned performance\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate separate buffers for each CPU so there's no fighting over
> +	 * cache lines.
> +	 */
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		bufs[cpu] =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +		if (!bufs[cpu]) {
> +			pr_warn("Allocation failure, not measuring misaligned performance\n");
> +			goto out;
> +		}
> +	}
> +
> +	/* Check everybody except 0, who stays behind to tend jiffies. */
> +	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);

comments! _HOW_ do you ensure that CPU0 is left out? You don't. CPU0
does this and the leaves which is a waste. Using on_each_cpu_cond()
could deal with this. And you have the check within the wrapper
(check_unaligned_access_nonboot_cpu()) anyway.

> +	/* Check core 0. */
> +	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);

Now that comment is obvious. If you want to add a comment, why not state
why CPU0 has to be done last?

> +
> +	/* Setup hotplug callback for any new CPUs that come online. */
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +				  riscv_online_cpu, NULL);
Instead riscv:online you could use riscv:unaliged_check or something
that pin points the callback to something obvious. This is exported via
sysfs.

Again, comment is obvious. For that to make sense would require RiscV to
support physical-hotplug. For KVM like environment (where you can plug in
CPUs later) this probably doesn't make sense at all. Why not? Because

- without explicit CPU pinning your slow/ fast CPU mapping (host <->
  guest) could change if the scheduler on the host moves the threads
  around.

- without explicit task offload and resource partitioning on the host
  your guest thread might get interrupt during the measurement. This is
  done during boot so chances are high that it runs 100% of its time
  slice and will be preempted once other tasks on the host ask for CPU
  run time.

Both points mean, that the results may not be accurate over time. Maybe
a KVM-hint if this is so important (along with other restrictions).

> +
> +out:
>  	unaligned_emulation_finish();
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		if (bufs[cpu])
> +			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> +	}
> +
> +	kfree(bufs);
>  	return 0;
>  }
> =20
> -arch_initcall(check_unaligned_access_boot_cpu);
> +arch_initcall(check_unaligned_access_all_cpus);
> =20
>  void riscv_user_isa_enable(void)
>  {

Sebastian
