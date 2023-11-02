Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFE7DF892
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377119AbjKBRTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKBRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:19:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032B133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:19:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BD0C433C8;
        Thu,  2 Nov 2023 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698945586;
        bh=n+S+t7+vM++09bRcLKQTdzCHYzyyukgdAaA1NUGk7DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hS4exQ1oSK4wq3ggSrI/cGuN6EKPhVG0k8VaIrYPvj11ydqIFTnMPGgleLWxgspOD
         b7xBxdcZp1P8PcYyzv6jjobKN3sfT91J99mIAXD2q8cBj1y0HbIIyFjAaprozBYxEf
         rQKH70m0VOUg4Ty6Thv9kt/HNSLiZKubiSEZ7Nn+da2cCV0AK3kLV01GtWA2z+/7dF
         KAM3KOjcMexrB8Aalp22VbhuQl7WxxDVn6QlxXjE6p0te5oa5ADPfYcrBv2KseAoHt
         rXNVNJ6Ddpb7vpkkL52N/yH9JillBzcsX0Bfq46PcCUwoA+4UiSEB9JRRLtsZzPByq
         77F49BqxZrePw==
Date:   Fri, 3 Nov 2023 01:07:29 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
Message-ID: <ZUPXUXWM41wZOunA@xhacker>
References: <20230915184904.1976183-1-evan@rivosinc.com>
 <ZQVp1PJb+HuEdu4L@xhacker>
 <ZUI3JKff9SgsA3Z/@xhacker>
 <CALs-HsvA8xW01UrS08MmeRSBb+eic9KX_=jKDZvf59LASnm=Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsvA8xW01UrS08MmeRSBb+eic9KX_=jKDZvf59LASnm=Zw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:28:53AM -0700, Evan Green wrote:
> On Wed, Nov 1, 2023 at 4:44 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Sat, Sep 16, 2023 at 04:39:54PM +0800, Jisheng Zhang wrote:
> > > On Fri, Sep 15, 2023 at 11:49:03AM -0700, Evan Green wrote:
> > > > Probing for misaligned access speed takes about 0.06 seconds. On a
> > > > system with 64 cores, doing this in smp_callin() means it's done
> > > > serially, extending boot time by 3.8 seconds. That's a lot of boot time.
> > > >
> > > > Instead of measuring each CPU serially, let's do the measurements on
> > > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > > except core 0, then 2) core 0.
> > > >
> > > > The measurement call in smp_callin() stays around, but is now
> > > > conditionalized to only run if a new CPU shows up after the round of
> > > > in-parallel measurements has run. The goal is to have the measurement
> > > > call not run during boot or suspend/resume, but only on a hotplug
> > > > addition.
> > > >
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > >
> > > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> >
> > Hi Evan, Palmer,
> >
> > This patch seems missing in v6.6, I dunno what happened.
> >
> > And this patch doesn't fix the boot time regression but also fix a real
> > bug during cpu hotplug on and off.
> 
> Hi Jisheng,
> Just to clarify, you're saying this both fixes the boot regression,
> and fixes a hotplug crash? I was slightly thrown off by the "doesn't
> fix the boot time regression", holler if there's still something wrong

typo: should be "not only fix the boot time regression but also ..."

> with boot time.
> 
> The splat you pasted suggests the CPU isn't coming back online. Off
> the top of my head I can't think of what that might be or why this
> patch would fix it. I tried this on an old palmer/for-next and didn't
> repro the issue:
> 
> # echo 0 > online
> [   31.777280] CPU3: off
> [   31.777740] CPU3 may not have stopped: 3
> # echo 1 > online
> [   36.236313] cpu3: Ratio of byte access time to unaligned word
> access is 7.26, unaligned accesses are fast

you need to run the script for some time, 3 ~ 5 minutes for example.

Only hotplug cpu off then on for once isn't enough
> 
> FWIW, Palmer's for-next branch now has the v2 of this patch. I

I want v2 patch be merged
> verified that branch is booting, and hotplug seems to work as well.

can you try stress cpu hotplug without your patch? I.E try on v6.6 

Thanks
> 
> 
> >
> > Here is the reproduce script:
> >
> > while true
> > do
> > echo 0 > /sys/devices/system/cpu/cpu1/online
> > echo 1 > /sys/devices/system/cpu/cpu1/online
> > done
> >
> >
> > Here is the BUG log on qemu:
> >
> > [   20.950753] CPU1: failed to come online
> > [   20.951875] ------------[ cut here ]------------
> > [   20.952070] kernel BUG at kernel/time/hrtimer.c:2227!
> > [   20.952341] Kernel BUG [#1]
> > [   20.952366] Modules linked in:
> > [   20.952515] CPU: 0 PID: 46 Comm: sh Not tainted 6.6.0 #3
> > [   20.952607] Hardware name: riscv-virtio,qemu (DT)
> > [   20.952695] epc : hrtimers_dead_cpu+0x22e/0x230
> > [   20.952808]  ra : cpuhp_invoke_callback+0xe4/0x54e
> > [   20.952844] epc : ffffffff8007d6c0 ra : ffffffff8000f904 sp : ff600000011ebb30
> > [   20.952863]  gp : ffffffff80d081d0 tp : ff6000000134da00 t0 : 0000000000000040
> > [   20.952880]  t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff600000011ebbb0
> > [   20.952895]  s1 : 0000000000000001 a0 : 0000000000000001 a1 : 000000000000002c
> > [   20.952911]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> > [   20.952926]  a5 : 0000000000000001 a6 : 0000000000000538 a7 : 0000000000000000
> > [   20.952941]  s2 : 000000000000002c s3 : 0000000000000000 s4 : ff6000003ffd4390
> > [   20.952957]  s5 : ffffffff80d0a1f8 s6 : 0000000000000000 s7 : ffffffff8007d492
> > [   20.952972]  s8 : 0000000000000001 s9 : fffffffffffffffb s10: 0000000000000000
> > [   20.952987]  s11: 00005555820dc708 t3 : 0000000000000002 t4 : 0000000000000402
> > [   20.953002]  t5 : ff600000010f0710 t6 : ff600000010f0718
> > [   20.953016] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> > [   20.953124] [<ffffffff8007d6c0>] hrtimers_dead_cpu+0x22e/0x230
> > [   20.953226] [<ffffffff8000f904>] cpuhp_invoke_callback+0xe4/0x54e
> > [   20.953241] [<ffffffff80010fb8>] _cpu_up+0x200/0x2a2
> > [   20.953254] [<ffffffff800110ac>] cpu_up+0x52/0x8a
> > [   20.953266] [<ffffffff80011654>] cpu_device_up+0x14/0x1c
> > [   20.953279] [<ffffffff8029abb6>] cpu_subsys_online+0x1e/0x68
> > [   20.953296] [<ffffffff802957de>] device_online+0x3c/0x70
> > [   20.953306] [<ffffffff8029587a>] online_store+0x68/0x8c
> > [   20.953317] [<ffffffff802909ba>] dev_attr_store+0xe/0x1a
> > [   20.953330] [<ffffffff801df8aa>] sysfs_kf_write+0x2a/0x34
> > [   20.953346] [<ffffffff801def06>] kernfs_fop_write_iter+0xde/0x162
> > [   20.953360] [<ffffffff8018154a>] vfs_write+0x136/0x320
> > [   20.953372] [<ffffffff801818e4>] ksys_write+0x4a/0xb4
> > [   20.953383] [<ffffffff80181962>] __riscv_sys_write+0x14/0x1c
> > [   20.953394] [<ffffffff803dec7e>] do_trap_ecall_u+0x4a/0x110
> > [   20.953420] [<ffffffff80003666>] ret_from_exception+0x0/0x66
> > [   20.953648] Code: 7c42 7ca2 7d02 6de2 4501 6109 8082 c0ef 7463 bd1d (9002) 1141
> > [   20.953897] ---[ end trace 0000000000000000 ]---
> > [   20.954068] Kernel panic - not syncing: Fatal exception in interrupt
> > [   20.954128] SMP: stopping secondary CPUs
> > [   22.749953] SMP: failed to stop secondary CPUs 0-1
> > [   22.803768] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> >
> >
> > > >
> > > > ---
> > > >
> > > > Jisheng, I didn't add your Tested-by tag since the patch evolved from
> > > > the one you tested. Hopefully this one brings you the same result.
> > > >
> > > > ---
> > > >  arch/riscv/include/asm/cpufeature.h |  3 ++-
> > > >  arch/riscv/kernel/cpufeature.c      | 28 +++++++++++++++++++++++-----
> > > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > > >  3 files changed, 35 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > > index d0345bd659c9..19e7817eba10 100644
> > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > @@ -30,6 +30,7 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > > >  /* Per-cpu ISA extensions. */
> > > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > > >
> > > > -void check_unaligned_access(int cpu);
> > > > +extern bool misaligned_speed_measured;
> > > > +int check_unaligned_access(void *unused);
> > > >
> > > >  #endif
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index 1cfbba65d11a..8eb36e1dfb95 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -42,6 +42,9 @@ struct riscv_isainfo hart_isa[NR_CPUS];
> > > >  /* Performance information */
> > > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > > >
> > > > +/* Boot-time in-parallel unaligned access measurement has occurred. */
> > > > +bool misaligned_speed_measured;
> > >
> > > This var can be avoided, see below.
> > >
> > > > +
> > > >  /**
> > > >   * riscv_isa_extension_base() - Get base extension word
> > > >   *
> > > > @@ -556,8 +559,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > > >     return hwcap;
> > > >  }
> > > >
> > > > -void check_unaligned_access(int cpu)
> > > > +int check_unaligned_access(void *unused)
> > > >  {
> > > > +   int cpu = smp_processor_id();
> > > >     u64 start_cycles, end_cycles;
> > > >     u64 word_cycles;
> > > >     u64 byte_cycles;
> > > > @@ -571,7 +575,7 @@ void check_unaligned_access(int cpu)
> > > >     page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
> > > >     if (!page) {
> > > >             pr_warn("Can't alloc pages to measure memcpy performance");
> > > > -           return;
> > > > +           return 0;
> > > >     }
> > > >
> > > >     /* Make an unaligned destination buffer. */
> > > > @@ -643,15 +647,29 @@ void check_unaligned_access(int cpu)
> > > >
> > > >  out:
> > > >     __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > > +{
> > > > +   if (smp_processor_id() != 0)
> > > > +           check_unaligned_access(param);
> > > >  }
> > > >
> > > > -static int check_unaligned_access_boot_cpu(void)
> > > > +static int check_unaligned_access_all_cpus(void)
> > > >  {
> > > > -   check_unaligned_access(0);
> > > > +   /* Check everybody except 0, who stays behind to tend jiffies. */
> > > > +   on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > > +
> > > > +   /* Check core 0. */
> > > > +   smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > > > +
> > > > +   /* Boot-time measurements are complete. */
> > > > +   misaligned_speed_measured = true;
> > > >     return 0;
> > > >  }
> > > >
> > > > -arch_initcall(check_unaligned_access_boot_cpu);
> > > > +arch_initcall(check_unaligned_access_all_cpus);
> > > >
> > > >  #ifdef CONFIG_RISCV_ALTERNATIVE
> > > >  /*
> > > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > > index 1b8da4e40a4d..39322ae20a75 100644
> > > > --- a/arch/riscv/kernel/smpboot.c
> > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/sched/mm.h>
> > > >  #include <asm/cpu_ops.h>
> > > >  #include <asm/cpufeature.h>
> > > > +#include <asm/hwprobe.h>
> > > >  #include <asm/irq.h>
> > > >  #include <asm/mmu_context.h>
> > > >  #include <asm/numa.h>
> > > > @@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
> > > >
> > > >     numa_add_cpu(curr_cpuid);
> > > >     set_cpu_online(curr_cpuid, 1);
> > > > -   check_unaligned_access(curr_cpuid);
> > > > +
> > > > +   /*
> > > > +    * Boot-time misaligned access speed measurements are done in parallel
> > > > +    * in an initcall. Only measure here for hotplug.
> > > > +    */
> > > > +   if (misaligned_speed_measured &&
> > > > +       (per_cpu(misaligned_access_speed, curr_cpuid) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)) {
> > >
> > > I believe this check is for cpu not-booted during boot time but hotplug in
> > > after that, if so I'm not sure whether
> > > misaligned_speed_measured can be replaced with
> > > (system_state == SYSTEM_RUNNING)
> > > then we don't need misaligned_speed_measured at all.
> > >
> > > > +           check_unaligned_access(NULL);
> > > > +   }
> > > >
> > > >     if (has_vector()) {
> > > >             if (riscv_v_setup_vsize())
> > > > --
> > > > 2.34.1
> > > >
