Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90F753496
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjGNIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjGNIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:05:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B135BB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so24210401fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689321791; x=1691913791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W0mJqRd+TFAhVjrDLKGgb/GgAz4XBWoxvyD6sXJRhU=;
        b=uWqFhJqej+8tCoJCvz6HmT/L+2vSKE4vBiTfKGeXqU+oB1LvGzXG2XmndUCr9xAejP
         wGMR7wYA9IPir6vFan3N2HsFKBeAkkj94j80jLuLaPdimmTCM54Nkv6G4OjiyMjC7ujZ
         pVaPrrNVbtxLjBFhzK+0CW/kscR0Z0b23xHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321791; x=1691913791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W0mJqRd+TFAhVjrDLKGgb/GgAz4XBWoxvyD6sXJRhU=;
        b=a13EVEClZCluHNo5kCdO3vt+j1kyHJcOp8zcTc14Tg0kpO/bfcYoiR1/KEPtM3PrJr
         B9C3Qk7U6a5yJPqAsHUj4zUaqhF8mcr/80Uog+kFT85T9MKPChXK/mz4mNSH207J8TjO
         SxDPEWfLijn3CtKwWKqulvYrm8ICSodijW/46FkKl5FgsQgIIk+WoEaMq8xR+NnHKCKs
         LrKQf3YNvh1v4d5wb7d1yzQXSTVMy5BM0jMtoGRNDPYB474I5I9FcD8VWKi1ajRZP7IJ
         eYvzUVHAfy2FJzrtojLF7JxdefGVFOdvQElS03DmqN75RzLlbE/A1SaWArQ/sEBhosdE
         himA==
X-Gm-Message-State: ABy/qLYtYeflZeAEmUxF/MFy2jBeu5GsUGU1SQdbBPzGq8KcnVbjxJe7
        SHljQvlLXN+k9XyMqCboNrLTSvbyP1WLUNwei8Zs
X-Google-Smtp-Source: APBJJlEjmd0hfDgR2Zjxudlk+lDY6335DUgs3vy1DMGzfDpMjHgCr1hgCzlw70UmHDqfigiVllbYgWGyq7aR+A5SUDY=
X-Received: by 2002:a2e:900d:0:b0:2b6:f85a:20b0 with SMTP id
 h13-20020a2e900d000000b002b6f85a20b0mr3041414ljg.16.1689321791509; Fri, 14
 Jul 2023 01:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-6-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-6-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:03:00 -0700
Message-ID: <CAOnJCULGBpwb1ATtg8jdteoy9KKE_=f2HktvqrmqzWY2KNvi=g@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] riscv: Prepare for user-space perf event mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:51=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Provide all the necessary bits in the generic riscv pmu driver to be
> able to mmap perf events in userspace: the heavy lifting lies in the
> driver backend, namely the legacy and sbi implementations.
>
> Note that arch_perf_update_userpage is almost a copy of arm64 code.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu.c       | 105 +++++++++++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |   4 ++
>  2 files changed, 109 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index ebca5eab9c9b..432ad2e80ce3 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -14,9 +14,73 @@
>  #include <linux/perf/riscv_pmu.h>
>  #include <linux/printk.h>
>  #include <linux/smp.h>
> +#include <linux/sched_clock.h>
>
>  #include <asm/sbi.h>
>
> +static bool riscv_perf_user_access(struct perf_event *event)
> +{
> +       return ((event->attr.type =3D=3D PERF_TYPE_HARDWARE) ||
> +               (event->attr.type =3D=3D PERF_TYPE_HW_CACHE) ||
> +               (event->attr.type =3D=3D PERF_TYPE_RAW)) &&
> +               !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +}
> +
> +void arch_perf_update_userpage(struct perf_event *event,
> +                              struct perf_event_mmap_page *userpg, u64 n=
ow)
> +{
> +       struct clock_read_data *rd;
> +       unsigned int seq;
> +       u64 ns;
> +
> +       userpg->cap_user_time =3D 0;
> +       userpg->cap_user_time_zero =3D 0;
> +       userpg->cap_user_time_short =3D 0;
> +       userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> +
> +       userpg->pmc_width =3D 64;
> +
> +       do {
> +               rd =3D sched_clock_read_begin(&seq);
> +
> +               userpg->time_mult =3D rd->mult;
> +               userpg->time_shift =3D rd->shift;
> +               userpg->time_zero =3D rd->epoch_ns;
> +               userpg->time_cycles =3D rd->epoch_cyc;
> +               userpg->time_mask =3D rd->sched_clock_mask;
> +
> +               /*
> +                * Subtract the cycle base, such that software that
> +                * doesn't know about cap_user_time_short still 'works'
> +                * assuming no wraps.
> +                */
> +               ns =3D mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift=
);
> +               userpg->time_zero -=3D ns;
> +
> +       } while (sched_clock_read_retry(seq));
> +
> +       userpg->time_offset =3D userpg->time_zero - now;
> +
> +       /*
> +        * time_shift is not expected to be greater than 31 due to
> +        * the original published conversion algorithm shifting a
> +        * 32-bit value (now specifies a 64-bit value) - refer
> +        * perf_event_mmap_page documentation in perf_event.h.
> +        */
> +       if (userpg->time_shift =3D=3D 32) {
> +               userpg->time_shift =3D 31;
> +               userpg->time_mult >>=3D 1;
> +       }
> +
> +       /*
> +        * Internal timekeeping for enabled/running/stopped times
> +        * is always computed with the sched_clock.
> +        */
> +       userpg->cap_user_time =3D 1;
> +       userpg->cap_user_time_zero =3D 1;
> +       userpg->cap_user_time_short =3D 1;
> +}
> +
>  static unsigned long csr_read_num(int csr_num)
>  {
>  #define switchcase_csr_read(__csr_num, __val)          {\
> @@ -171,6 +235,8 @@ int riscv_pmu_event_set_period(struct perf_event *eve=
nt)
>
>         local64_set(&hwc->prev_count, (u64)-left);
>
> +       perf_event_update_userpage(event);
> +
>         return overflow;
>  }
>
> @@ -267,6 +333,9 @@ static int riscv_pmu_event_init(struct perf_event *ev=
ent)
>         hwc->idx =3D -1;
>         hwc->event_base =3D mapped_event;
>
> +       if (rvpmu->event_init)
> +               rvpmu->event_init(event);
> +
>         if (!is_sampling_event(event)) {
>                 /*
>                  * For non-sampling runs, limit the sample_period to half
> @@ -283,6 +352,39 @@ static int riscv_pmu_event_init(struct perf_event *e=
vent)
>         return 0;
>  }
>
> +static int riscv_pmu_event_idx(struct perf_event *event)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +               return 0;
> +
> +       if (rvpmu->csr_index)
> +               return rvpmu->csr_index(event) + 1;
> +
> +       return 0;
> +}
> +
> +static void riscv_pmu_event_mapped(struct perf_event *event, struct mm_s=
truct *mm)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (rvpmu->event_mapped) {
> +               rvpmu->event_mapped(event, mm);
> +               perf_event_update_userpage(event);
> +       }
> +}
> +
> +static void riscv_pmu_event_unmapped(struct perf_event *event, struct mm=
_struct *mm)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (rvpmu->event_unmapped) {
> +               rvpmu->event_unmapped(event, mm);
> +               perf_event_update_userpage(event);
> +       }
> +}
> +
>  struct riscv_pmu *riscv_pmu_alloc(void)
>  {
>         struct riscv_pmu *pmu;
> @@ -307,6 +409,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>         }
>         pmu->pmu =3D (struct pmu) {
>                 .event_init     =3D riscv_pmu_event_init,
> +               .event_mapped   =3D riscv_pmu_event_mapped,
> +               .event_unmapped =3D riscv_pmu_event_unmapped,
> +               .event_idx      =3D riscv_pmu_event_idx,
>                 .add            =3D riscv_pmu_add,
>                 .del            =3D riscv_pmu_del,
>                 .start          =3D riscv_pmu_start,
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 5deeea0be7cb..43282e22ebe1 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -55,6 +55,10 @@ struct riscv_pmu {
>         void            (*ctr_start)(struct perf_event *event, u64 init_v=
al);
>         void            (*ctr_stop)(struct perf_event *event, unsigned lo=
ng flag);
>         int             (*event_map)(struct perf_event *event, u64 *confi=
g);
> +       void            (*event_init)(struct perf_event *event);
> +       void            (*event_mapped)(struct perf_event *event, struct =
mm_struct *mm);
> +       void            (*event_unmapped)(struct perf_event *event, struc=
t mm_struct *mm);
> +       uint8_t         (*csr_index)(struct perf_event *event);
>
>         struct cpu_hw_events    __percpu *hw_events;
>         struct hlist_node       node;
> --
> 2.39.2
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
