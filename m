Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7C7B84B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjJDQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjJDQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:14:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33996A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:14:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-504427aae4fso1401390e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696436092; x=1697040892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onia9ZXddgiWIBxPSpKXotqhiL6maonD9M/TcIyvZv0=;
        b=gLj1CuJ5sLZXyTbgqcDC+L6Lj2pkUhzSogV3QUAd05HcCkF4TaN/ecLGEG9FwuVMkt
         uTwsmNz8FT7ZfjwknbSlOJwNuWHHFQknH1C8VSZHktPgdD3TTZLRBi7qHkSROifvTF+m
         oChyhnx7JrESb5zHVecR1fL+BRp1GFt55vtRcbqIAOdbQH59BnPlxx+59t1QzMqy1WJI
         gLaTSJ/uR2XyhXITzSqwHRMLVlnvAu8HXeer62dqoimrhjulsqLNGv5GWTbrFE7TPU9x
         F/bSXevKkrRSoi8cGRNL3rnzbzuTstUXcKZlmDkBWqhDRfxdkTMfie+hhhs6Fa0L0Yl8
         xWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436092; x=1697040892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onia9ZXddgiWIBxPSpKXotqhiL6maonD9M/TcIyvZv0=;
        b=t2ky212lmDxbJnmh1sTNhI0yRPt75aGkkwOzVPcXuxf0Y20Rrs1xeCsldStXraxU2R
         KgwqaIUp0nLd4GLJdHy4dLA4CcVsxXeFZ0YGgOJGg2FQigcEXQ2kscm3A5o2S/z1fr2F
         N/bJKF+hZol/aG+VJAijIouRDGSmN667HovwhBxaqTcUqYYG/AIHzbAIpXj1wUMxgE74
         LR7UKfZYbfnsMNUZJLC1G8ZdeuRp3kS4Cs/PUk9iUqwX2rH8f8Qz1Fx5euBDABc6IzUm
         2Gl/fP1k44BgLPT4DJ7qShe6PHbc48M0oPmuGIWZj5Y3NXwKGBJqqgVlU+Mol5/R/QoR
         7NYw==
X-Gm-Message-State: AOJu0YyRYOuGdR8m+CtEfPcAh31WqRFToq4DL0IMxkcE51JztrIJeKAp
        DyPIGXZkp7pbxXrbP2+65zrMOzJQzayD2ZFkK5vj5w==
X-Google-Smtp-Source: AGHT+IG9LgKXqBL/h279dvV7+1Ztkauqr1nwPs9lDJUghGJ/1CgLpTFxyA+qh/AfNI8SCCyrl11wTOjX92/97vINqk8=
X-Received: by 2002:ac2:4e8d:0:b0:505:7a65:ad5a with SMTP id
 o13-20020ac24e8d000000b005057a65ad5amr48328lfr.26.1696436092314; Wed, 04 Oct
 2023 09:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231004151405.521596-1-cleger@rivosinc.com> <20231004151405.521596-8-cleger@rivosinc.com>
In-Reply-To: <20231004151405.521596-8-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 4 Oct 2023 09:14:16 -0700
Message-ID: <CALs-HstxNBag7g74XSMJ-qu_ihp4WzA+PV2mf0MDkaRF3gV33w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] riscv: report misaligned accesses emulation to hwprobe
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:14=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
> hwprobe provides a way to report if misaligned access are emulated. In
> order to correctly populate that feature, we can check if it actually
> traps when doing a misaligned access. This can be checked using an
> exception table entry which will actually be used when a misaligned
> access is done from kernel mode.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h  | 18 +++++++++
>  arch/riscv/kernel/cpufeature.c       |  4 ++
>  arch/riscv/kernel/smpboot.c          |  2 +-
>  arch/riscv/kernel/traps_misaligned.c | 56 ++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index d0345bd659c9..e4ae6af51876 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -32,4 +32,22 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>  void check_unaligned_access(int cpu);
>
> +#ifdef CONFIG_RISCV_MISALIGNED
> +bool unaligned_ctl_available(void);
> +bool check_unaligned_access_emulated(int cpu);
> +void unaligned_emulation_finish(void);
> +#else
> +static inline bool unaligned_ctl_available(void)
> +{
> +       return false;
> +}
> +
> +static inline bool check_unaligned_access_emulated(int cpu)
> +{
> +       return false;
> +}
> +
> +static inline void unaligned_emulation_finish(void) {}
> +#endif
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 356e5677eeb1..fbbde800bc21 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
>         void *src;
>         long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
>
> +       if (check_unaligned_access_emulated(cpu))
> +               return;
> +
>         page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
>         if (!page) {
>                 pr_warn("Can't alloc pages to measure memcpy performance"=
);
> @@ -648,6 +651,7 @@ void check_unaligned_access(int cpu)
>  static int __init check_unaligned_access_boot_cpu(void)
>  {
>         check_unaligned_access(0);
> +       unaligned_emulation_finish();
>         return 0;
>  }
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 1b8da4e40a4d..5d9858d6ad26 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -245,8 +245,8 @@ asmlinkage __visible void smp_callin(void)
>         riscv_ipi_enable();
>
>         numa_add_cpu(curr_cpuid);
> -       set_cpu_online(curr_cpuid, 1);
>         check_unaligned_access(curr_cpuid);
> +       set_cpu_online(curr_cpuid, 1);
>
>         if (has_vector()) {
>                 if (riscv_v_setup_vsize())
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index b5fb1ff078e3..d99b95084b6c 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -14,6 +14,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
>  #include <asm/entry-common.h>
> +#include <asm/hwprobe.h>
> +#include <asm/cpufeature.h>
>
>  #define INSN_MATCH_LB                  0x3
>  #define INSN_MASK_LB                   0x707f
> @@ -396,6 +398,8 @@ union reg_data {
>         u64 data_u64;
>  };
>
> +static bool unaligned_ctl __read_mostly;
> +
>  /* sysctl hooks */
>  int unaligned_enabled __read_mostly =3D 1;       /* Enabled by default *=
/
>
> @@ -409,6 +413,8 @@ int handle_misaligned_load(struct pt_regs *regs)
>
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>
> +       *this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIG=
NED_EMULATED;
> +
>         if (!unaligned_enabled)
>                 return -1;
>
> @@ -585,3 +591,53 @@ int handle_misaligned_store(struct pt_regs *regs)
>
>         return 0;
>  }
> +
> +bool check_unaligned_access_emulated(int cpu)
> +{
> +       long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
> +       unsigned long tmp_var, tmp_val;
> +       bool misaligned_emu_detected;
> +
> +       *mas_ptr =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +
> +       __asm__ __volatile__ (
> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
> +               : [tmp] "=3Dr" (tmp_val) : [ptr] "r" (&tmp_var) : "memory=
");
> +
> +       misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALI=
GNED_EMULATED);
> +       /*
> +        * If unaligned_ctl is already set, this means that we detected t=
hat all
> +        * CPUS uses emulated misaligned access at boot time. If that cha=
nged
> +        * when hotplugging the new cpu, this is something we don't handl=
e.
> +        */
> +       if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> +               pr_crit("CPU misaligned accesses non homogeneous (expecte=
d all emulated)\n");
> +               while (true)
> +                       cpu_relax();

So the idea is to spin long enough that the
wait_for_completion(&cpu_running, 1000ms) times out? Maybe there
should be a wfi() in here as well so we're not just burning white hot.
Have you verified that if we get here, the CPU will also get taken
back down after the timeout? I wonder if __cpu_up() also needs a call
to stop the CPU, in the case where that wait_for_completion_timeout()
times out.

It also might be more intuitive to reorganize this such that the death
loop happens in smp_callin(), as check_unaligned_access_emulated() is
not a function you'd expect might sometimes never return.

-Evan
