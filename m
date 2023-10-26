Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A047D8931
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZTwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:52:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7B129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:52:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50797cf5b69so1842969e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1698349954; x=1698954754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3KsfHkdzJDVNyxq3KokMT4ddC9lWM8GJUe3nhZ+IyA=;
        b=eMBTYNq3VO11GSxG8vtq8xUjm+chI3GezfBnhhp/Se7ZdkDvbXo7QeScp3M1mtNiAL
         1ZKcgzP/IyHm7qmKUEpj4DYc9ejgGACOAUQ/R7jHXkX0Cau+1n/sf375iTOcq+mQ7obv
         1vljrUOGWSp5QfZb3H0hnjVInpYyv8lc5zVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349954; x=1698954754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3KsfHkdzJDVNyxq3KokMT4ddC9lWM8GJUe3nhZ+IyA=;
        b=J7KEhVZ6LTH1XLMN/kjxanWrY97ilUsGXq7MpMbp5GmPY8iXvgngGzrbysmovDmZIf
         hF7Ch5sN1i2zqlpkutOSjvDjbFGXTfChFEmPH9dOSRjQcurTM/eos5B7Z6uH3o22ebYj
         yxAjsYtk9kh6ns3pY/a/XxIR1Vcmii/8pI3cDVshknv79CbA7uc6sDYwbh0AaO+hlr7a
         HrsrJu8JsYDq24APJjbTky8DhnIXeDpeOM8iDBHa1JbqW2Kf7eLIZsbvGp+/Tza31yra
         U+MkjsRvgii0ELMfpJ+IbY+tmt8ix+7weKHFTIqJTlIAI+ZpprjiNaYhqItOGNWPOJme
         KOSA==
X-Gm-Message-State: AOJu0YwpnNUs5M57IkkrhdFG8qy+rtU7IEWzebcHRz/SVbnB9mbkwRL8
        QRW/NI210JRWOPdvO0fP3izlsKOOegnN3x9UkEYM
X-Google-Smtp-Source: AGHT+IH7mtZypvBsStNFtkv+bxn1JvEuV9wgT4ZKNjQFLaQ1vhqLVB/IobcqxAFWIdvE3S3ndeYp2IR4HyTDMdqTkJw=
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id
 x17-20020a19e011000000b005030fc2bfafmr283462lfg.33.1698349953734; Thu, 26 Oct
 2023 12:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231026143122.279437-1-cleger@rivosinc.com> <20231026143122.279437-4-cleger@rivosinc.com>
In-Reply-To: <20231026143122.279437-4-cleger@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 26 Oct 2023 12:52:22 -0700
Message-ID: <CAOnJCUKy9FqrWBqQRE8okjcKNZ1NZ1d1hm0sBK_QRQyziHMPew@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] perf: RISC-V: add support for SSE event
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Xu Lu <luxu.kernel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 7:31=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> In order to use SSE within PMU drivers, register a SSE handler for the
> local PMU event. There is not a lot of specific code needed to handle
> the SSE event, just reuse the existing overlflow IRQ handler and pass
> appropriate pt_regs.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h |  2 ++
>  drivers/perf/riscv_pmu_sbi.c | 51 +++++++++++++++++++++++++++++-------
>  2 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2e99cafe7fed..13b01cd3a814 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -121,6 +121,8 @@ enum sbi_ext_pmu_fid {
>         SBI_EXT_PMU_COUNTER_START,
>         SBI_EXT_PMU_COUNTER_STOP,
>         SBI_EXT_PMU_COUNTER_FW_READ,
> +       SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +       SBI_EXT_PMU_COUNTER_IRQ_CLEAR,

FWIW: This is not part of the SBI v2.0 or any proposed improvements.
As the SSE spec is in the draft state,
we need to evaluate if this is required or if there are better way to
request the M-mode to clear the interrupt pending bit.

With counter delegation extensions in place, this requires a bit more
thought as it won't use the SBI PMU at all.
In addition to that, there may be other use cases where irq needs to
be cleared first thing in the handler
There are few options which we are looking at :

1. Move the irq processing to the workqueue and call SSE complete
which can clear the irq
2. Define a generic irq clear function in the SSE extension itself to
achieve this if we have to rely on the SBI call.

>  };
>
>  union sbi_pmu_ctr_info {
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 96c7f670c8f0..3fca70b13304 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -17,6 +17,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/of_irq.h>
>  #include <linux/of.h>
> +#include <linux/riscv_sse.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/sched/clock.h>
>
> @@ -625,6 +626,12 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv=
_pmu *pmu)
>                   cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
>  }
>
> +static void pmu_sbi_irq_clear(void)
> +{
> +       /* No need to check the error here as we can't do anything about =
the error */
> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_IRQ_CLEAR, 0, 0, 0, 0,=
 0, 0);
> +}
> +
>  /*
>   * This function starts all the used counters in two step approach.
>   * Any counter that did not overflow can be start in a single step
> @@ -670,10 +677,10 @@ static inline void pmu_sbi_start_overflow_mask(stru=
ct riscv_pmu *pmu,
>         }
>  }
>
> -static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> +static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
> +                                      struct pt_regs *regs, bool from_ss=
e)
>  {
>         struct perf_sample_data data;
> -       struct pt_regs *regs;
>         struct hw_perf_event *hw_evt;
>         union sbi_pmu_ctr_info *info;
>         int lidx, hidx, fidx;
> @@ -681,7 +688,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void =
*dev)
>         struct perf_event *event;
>         unsigned long overflow;
>         unsigned long overflowed_ctrs =3D 0;
> -       struct cpu_hw_events *cpu_hw_evt =3D dev;
>         u64 start_clock =3D sched_clock();
>
>         if (WARN_ON_ONCE(!cpu_hw_evt))
> @@ -691,7 +697,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void=
 *dev)
>         fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNT=
ERS);
>         event =3D cpu_hw_evt->events[fidx];
>         if (!event) {
> -               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +               if (from_sse)
> +                       pmu_sbi_irq_clear();
> +               else
> +                       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>                 return IRQ_NONE;
>         }
>
> @@ -703,16 +712,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, voi=
d *dev)
>
>         /*
>          * Overflow interrupt pending bit should only be cleared after st=
opping
> -        * all the counters to avoid any race condition.
> +        * all the counters to avoid any race condition. When using SSE,
> +        * interrupt is cleared when stopping counters.
>          */
> -       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +       if (!from_sse)
> +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>
>         /* No overflow bit is set */
>         if (!overflow)
>                 return IRQ_NONE;
>
> -       regs =3D get_irq_regs();
> -
>         for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTE=
RS) {
>                 struct perf_event *event =3D cpu_hw_evt->events[lidx];
>
> @@ -758,6 +767,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void=
 *dev)
>         return IRQ_HANDLED;
>  }
>
> +static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
> +{
> +       return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
> +}
> +
> +static int pmu_sbi_ovf_sse_handler(uint32_t evt, void *arg,
> +                                  struct pt_regs *regs)
> +{
> +       struct cpu_hw_events __percpu *hw_events =3D arg;
> +       struct cpu_hw_events *hw_event =3D raw_cpu_ptr(hw_events);
> +
> +       pmu_sbi_ovf_handler(hw_event, regs, true);
> +
> +       return 0;
> +}
> +
>  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *nod=
e)
>  {
>         struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct riscv_pmu=
, node);
> @@ -801,9 +826,17 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struc=
t hlist_node *node)
>  static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_dev=
ice *pdev)
>  {
>         int ret;
> +       struct sse_event *evt;
>         struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
>         struct irq_domain *domain =3D NULL;
>
> +       evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_PMU, 0,
> +                                pmu_sbi_ovf_sse_handler, hw_events);
> +       if (!IS_ERR(evt)) {
> +               sse_event_enable(evt);
> +               return 0;
> +       }
> +
>         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>                 riscv_pmu_irq_num =3D RV_IRQ_PMU;
>                 riscv_pmu_use_irq =3D true;
> @@ -831,7 +864,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, =
struct platform_device *pde
>                 return -ENODEV;
>         }
>
> -       ret =3D request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "r=
iscv-pmu", hw_events);
> +       ret =3D request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler=
, "riscv-pmu", hw_events);
>         if (ret) {
>                 pr_err("registering percpu irq failed [%d]\n", ret);
>                 return ret;
> --
> 2.42.0
>


--
Regards,
Atish
