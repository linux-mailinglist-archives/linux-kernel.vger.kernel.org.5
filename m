Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B67AF9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjI0FOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjI0FN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:13:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA4F59C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:48:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-418157e979eso148761cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695790090; x=1696394890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5XS7Z2HYwT7+bKR8ejv05mrlibvnmC+jgh8eL0fAPo=;
        b=JkIUtQsbd7zRgA7jdptbDYPywpO1CMQ5rNycomxYkbnLlkRcVISGVlXEY22RrB4kx4
         /fjhA9vV4M0J5LFaWM1xUOXxEvzGDbZ3WRJCDMKmhWaE7mJHgZ3RbxlSQL51dtXiSKrR
         6JWL44CIscDERQwJX4YdO/UbWjN1UpcsNlcTYiPi8kA5+/nqmiPvHES1CaIAK/lMqC4w
         3pwoEr4SXRpk55SSlwSGVDmvZfD25yfL9hVKub+JK8AJXGCVLVQrHfyaudblh+oSQiLh
         jgKqyKznOKfkRcowSMYxJlnyidmGb19vScwrMOC1kt5qvVUKQJ0E6tOv99LTpF00XaQT
         X5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695790090; x=1696394890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5XS7Z2HYwT7+bKR8ejv05mrlibvnmC+jgh8eL0fAPo=;
        b=SN2htA2xOqUnUq5wsiWlirAAOUQSbT2fq93ElcL3ddpL89MSDQXssYMiXgKGMlr7Hz
         rAVkUCx6v3n1m9vjbBa9dhV7dhlgQWfQY9HgDcvcl45Zxtlh+/YTXKd/dTCtSfv+XKz5
         Y5G4AKmU8wS7F7R8XgEi5x5rojDRukP7TH+e+uO89WZCbq7IsDuxUBAb5DJqQTPt2Yh6
         7leaOUavhySHqvp1bGOpdzS5zCxEpbZynN8VQffr441PjeyGANNIvSHgQeyLfwcpqkDc
         CrjCmveqj35c8Kg+FgB6HsiErIyuEb9sv4aJ2rmvzI2z59Lc17QVswsCzz0qClKKdgxx
         KYqg==
X-Gm-Message-State: AOJu0YweXpXpJ8/asIHO7hDl7lQG3m+hlAPzb+pDHMX4UqeFqF6ItYr+
        Mk4iol/nMWcj8jaW3GyK3UwO748eWZXgBp9ivNeVRNVwUUpMWdEWap8=
X-Google-Smtp-Source: AGHT+IERfSFuDjwyCdv+pYv7zxwg+m/k60xJh5HF2gkZB2tIwPOYuEB2L9y/f6uP82bTWri22fwfc6jCtPV4mjE3kRI=
X-Received: by 2002:ac8:5b01:0:b0:410:958a:465f with SMTP id
 m1-20020ac85b01000000b00410958a465fmr450066qtw.11.1695790090076; Tue, 26 Sep
 2023 21:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230911144139.2354015-1-kan.liang@linux.intel.com>
In-Reply-To: <20230911144139.2354015-1-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 26 Sep 2023 21:47:57 -0700
Message-ID: <CABPqkBQ1R9K_2L6pNp1dLmHnjwzcSiWeAhJ+J701_cojpVzwFw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Extend the ref-cycles event to GP counters
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 7:41=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The current ref-cycles event is only available on the fixed counter 2.
> Starting from the GLC and GRT core, the architectural UnHalted Reference
> Cycles event (0x013c) which is available on general-purpose counters
> can collect the exact same events as the fixed counter 2.
>
> Update the mapping of ref-cycles to 0x013c. So the ref-cycles can be
> available on both fixed counter 2 and general-purpose counters.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e1543d6dc48a..a08f794a0e79 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -211,6 +211,14 @@ static struct event_constraint intel_slm_event_const=
raints[] __read_mostly =3D
>         EVENT_CONSTRAINT_END
>  };
>
> +static struct event_constraint intel_grt_event_constraints[] __read_most=
ly =3D {
> +       FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
> +       FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
> +       FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF=
 */
> +       FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P =
*/
> +       EVENT_CONSTRAINT_END
> +};
> +
>  static struct event_constraint intel_skl_event_constraints[] =3D {
>         FIXED_EVENT_CONSTRAINT(0x00c0, 0),      /* INST_RETIRED.ANY */
>         FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE =
*/
> @@ -314,6 +322,7 @@ static struct event_constraint intel_glc_event_constr=
aints[] =3D {
>         FIXED_EVENT_CONSTRAINT(0x0100, 0),      /* INST_RETIRED.PREC_DIST=
 */
>         FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE =
*/
>         FIXED_EVENT_CONSTRAINT(0x0300, 2),      /* CPU_CLK_UNHALTED.REF *=
/
> +       FIXED_EVENT_CONSTRAINT(0x013c, 2),      /* CPU_CLK_UNHALTED.REF_T=
SC_P */

I don't think that on SKL there is a REF_TSC_P. It only appears on
SPR. The encoding exists on SKL
but it counts REF_XCLK which I think counts something different. Please che=
ck.

>         FIXED_EVENT_CONSTRAINT(0x0400, 3),      /* SLOTS */
>         METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>         METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
> @@ -5983,6 +5992,12 @@ static __always_inline int intel_pmu_init_hybrid(e=
num hybrid_pmu_type pmus)
>         return 0;
>  }
>
> +static __always_inline void intel_pmu_ref_cycles_ext(void)
> +{
> +       if (!(x86_pmu.events_maskl & (INTEL_PMC_MSK_FIXED_REF_CYCLES >> I=
NTEL_PMC_IDX_FIXED)))
> +               intel_perfmon_event_map[PERF_COUNT_HW_REF_CPU_CYCLES] =3D=
 0x013c;
> +}
> +
>  static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
>  {
>         x86_pmu.late_ack =3D true;
> @@ -6005,6 +6020,8 @@ static __always_inline void intel_pmu_init_glc(stru=
ct pmu *pmu)
>         memcpy(hybrid_var(pmu, hw_cache_extra_regs), glc_hw_cache_extra_r=
egs, sizeof(hw_cache_extra_regs));
>         hybrid(pmu, event_constraints) =3D intel_glc_event_constraints;
>         hybrid(pmu, pebs_constraints) =3D intel_glc_pebs_event_constraint=
s;
> +
> +       intel_pmu_ref_cycles_ext();
>  }
>
>  static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
> @@ -6021,9 +6038,11 @@ static __always_inline void intel_pmu_init_grt(str=
uct pmu *pmu)
>         memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_id=
s, sizeof(hw_cache_event_ids));
>         memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_r=
egs, sizeof(hw_cache_extra_regs));
>         hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT=
_ACCESS)] =3D -1;
> -       hybrid(pmu, event_constraints) =3D intel_slm_event_constraints;
> +       hybrid(pmu, event_constraints) =3D intel_grt_event_constraints;
>         hybrid(pmu, pebs_constraints) =3D intel_grt_pebs_event_constraint=
s;
>         hybrid(pmu, extra_regs) =3D intel_grt_extra_regs;
> +
> +       intel_pmu_ref_cycles_ext();
>  }
>
>  __init int intel_pmu_init(void)
> --
> 2.35.1
>
