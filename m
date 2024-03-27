Return-Path: <linux-kernel+bounces-121637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91288EB69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460C129FFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FB14C5A2;
	Wed, 27 Mar 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnEx1ess"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FE1C06;
	Wed, 27 Mar 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557395; cv=none; b=DPQNreeh7fhhMdt2WSFZRmOYgoHmBJPjF8ZW6h+88xQ4epxPImj+LnAI37GKUf5kSo6+lknknC0RcxcyWptUd/xjgJtycAenfZ+GF2wNwphO0QddpChlhzJa3TzuUbYgPMqnpkGh2S8wFZ0YEu5uEt2gPOrkrJA+ZQGlpOWOFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557395; c=relaxed/simple;
	bh=HqiRu3SYREOhymYa/hR3Wf83dH1tEf0VefjSrIFzls4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfMED70qRbnwtn0h73mRVViaAOgq443IqnHYS1A8QvmRJWQeCQXEz/Mb63QKxCp9rUH0P1Yak/yQmLfy/YzIe0R+felN9UToDTnbH1f9Bzkj6IAu3wgOprAWYbT3wBhSeQknBpAhUZJTiEjo+aTvWigrgcTvDa81gOGrpWU/lTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnEx1ess; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29de2dd22d8so41123a91.2;
        Wed, 27 Mar 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557393; x=1712162193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujXcIoihqRAijNBVHvtIzTbe8np009lwVGiKDFG6Ar4=;
        b=nnEx1esskLZnVup2MQv2Z86o7IScHyUxRLS8WBwCmtyfgJPCa6bJKK5r3IL3Bc+tZ9
         d1C14ONYTzCUxAoXVFrzwUOGXUZfjwN+MgMeGgFSDVg84RLNGag8aZIvQf+rjF/vPbx+
         Jff2TS0XTefaAhfv5SNEieBu6CMe2hspUkejCLTWoJ4vnXFJQkSqbUtSWvxWmu8NF4q6
         VwpCzTs1iCAMV+4iJXfU9J4NGUJqVci6KbqmHQfnhYNhdcNSI9dKQRWWBbPAjG3Mvq8j
         RE66m3OHLtg2mZ6cDmaJDEqsfbYy7uVTl+80tpZnSVqUPuVnU9s3ggV8MnSkMKfi0PF+
         xuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557393; x=1712162193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujXcIoihqRAijNBVHvtIzTbe8np009lwVGiKDFG6Ar4=;
        b=nhbWYf3Qvpgi+q3g2XSR6h2Ky8SOxY+kCIX9bDiLA33k8lIn8Sk9sY1kSo+i6YLwCm
         SIR8qV+rMPX+JuhUQ0c2QRzz+QuAPBY0bvf2h+X8uhzQX5JkvrQCU20dKugURxC21iTC
         6JEjyr9qP9coQAdW7cW1314hAiCz3Kk7aZG0IlJh1cwjrgEad602w9Mdvm6CPqkqPq0I
         BqeJERTCmnOR6dbB3mj1NotirN7wRybcq97CCq2hx7HbMzwXt8ewki6nyW7cqWh0yKs9
         hihMKVn6NCe26CNrAEvejPE8vjCA+DAmp2AiVSTCjBzXx9n0TPH0to1xDRgtEaAvHzPX
         DzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYyFqaX1uimhNSkpGdm1fbxde8R/oyPltSzfhMhrrb8k0qseYJyMquhej0exLJhpdmMLubUiB+Sh9KteA2m3IQ0mvlV6qWbTNtwqaB
X-Gm-Message-State: AOJu0YyRa3Cppz4WL+58nSI14qoOQXh/LJ5RgWYmuqNgkHp+y5yqQOHE
	dHHz4vV7K1lu8/OMpBuha6ythGlxM2f/DDTNXipYm1HzpKRzK87Oo6hbyj2phr5Zi7VDc3kJrfl
	y9xcf7FBwoZYC0e//xt98c0DnkDLxEiRmA4o=
X-Google-Smtp-Source: AGHT+IEw582UE2EELt2LQvN0c8QW4wa7nmlyn/Cw3kpOm9UUqoPY6087kTei5jLAxyKE6qGFPL3P53+UhJeW6UoAzQk=
X-Received: by 2002:a17:90a:be14:b0:29f:b8e1:1dfc with SMTP id
 a20-20020a17090abe1400b0029fb8e11dfcmr166227pjs.25.1711557392961; Wed, 27 Mar
 2024 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319224206.1612000-1-andrii@kernel.org>
In-Reply-To: <20240319224206.1612000-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 09:36:20 -0700
Message-ID: <CAEf4BzZtzJnLW3XychM3qEo5nqP9CH8vv3OAPAi3SdK_AuQE=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] perf, amd: support capturing LBR from software events
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 3:42=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> from inside BPF program at pretty much any arbitrary point. This is
> extremely useful capability that allows to figure out otherwise
> hard-to-debug problems, because LBR is now available based on some
> application-defined conditions, not just hardware-supported events.
>
> retsnoop ([1]) is one such tool that takes a huge advantage of this
> functionality and has proved to be an extremely useful tool in
> practice.
>
> Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> necessary wiring inside the kernel is not yet setup. This patch seeks to
> rectify this and follows a similar approach to the original patch [0]
> for Intel CPUs.
>
> Given LBR can be set up to capture any indirect jumps, it's critical to
> minimize indirect jumps on the way to requesting LBR from BPF program,
> so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> from BPF subsystem (through perf_snapshot_branch_stack static call).
>
> Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> point, there is no reason to artificially limit this feature to sampling
> events. So corresponding check is removed. AFAIU, there is no
> correctness implications of doing this (and it was possible to bypass
> this check by just setting perf_event's sample_period to 1 anyways, so
> it doesn't guard all that much).
>
> This was tested on AMD Bergamo CPU and worked well when utilized from
> the aforementioned retsnoop tool.
>
>   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving=
@fb.com/
>   [1] https://github.com/anakryiko/retsnoop
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    | 11 +----------
>  arch/x86/events/perf_event.h | 11 +++++++++++
>  3 files changed, 40 insertions(+), 11 deletions(-)
>

Adding Thomas and x86@kernel.org to cc as well. This patch adds
AMD-specific wiring for the feature that was added for Intel CPUs a
while ago. I'd really appreciate a review, thank you!

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 69a3b02e50bb..fef661230acc 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -619,7 +619,7 @@ static void amd_pmu_cpu_dead(int cpu)
>         }
>  }
>
> -static inline void amd_pmu_set_global_ctl(u64 ctl)
> +static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
>  {
>         wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
>  }
> @@ -879,6 +879,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
>         return amd_pmu_adjust_nmi_window(handled);
>  }
>
> +static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *en=
tries, unsigned int cnt)
> +{
> +       struct cpu_hw_events *cpuc;
> +       unsigned long flags;
> +
> +       /* must not have branches... */
> +       local_irq_save(flags);
> +       amd_pmu_core_disable_all();
> +       __amd_pmu_lbr_disable();
> +       /*            ... until here */
> +
> +       cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +
> +       amd_pmu_lbr_read();
> +       cnt =3D min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +       memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entr=
y) * cnt);
> +
> +       amd_pmu_v2_enable_all(0);
> +       local_irq_restore(flags);
> +
> +       return cnt;
> +}
> +
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> @@ -1415,6 +1438,10 @@ static int __init amd_core_pmu_init(void)
>                 static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_rese=
t);
>                 static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
>                 static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
> +
> +               /* only support branch_stack snapshot on perfmon v2 */
> +               if (x86_pmu.handle_irq =3D=3D amd_pmu_v2_handle_irq)
> +                       static_call_update(perf_snapshot_branch_stack, am=
d_pmu_v2_snapshot_branch_stack);
>         } else if (!amd_brs_init()) {
>                 /*
>                  * BRS requires special event constraints and flushing on=
 ctxsw.
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index eb31f850841a..c34f8d0048e0 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -308,10 +308,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>  {
>         int ret =3D 0;
>
> -       /* LBR is not recommended in counting mode */
> -       if (!is_sampling_event(event))
> -               return -EINVAL;
> -
>         ret =3D amd_pmu_lbr_setup_filter(event);
>         if (!ret)
>                 event->attach_state |=3D PERF_ATTACH_SCHED_CB;
> @@ -410,16 +406,11 @@ void amd_pmu_lbr_enable_all(void)
>  void amd_pmu_lbr_disable_all(void)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -       u64 dbg_ctl, dbg_extn_cfg;
>
>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>                 return;
>
> -       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> -       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -
> -       wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN=
);
> -       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_O=
N_PMI);
> +       __amd_pmu_lbr_disable();
>  }
>
>  __init int amd_pmu_lbr_init(void)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fb56518356ec..4dddf0a7e81e 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1329,6 +1329,17 @@ void amd_pmu_lbr_enable_all(void);
>  void amd_pmu_lbr_disable_all(void);
>  int amd_pmu_lbr_hw_config(struct perf_event *event);
>
> +static __always_inline void __amd_pmu_lbr_disable(void)
> +{
> +       u64 dbg_ctl, dbg_extn_cfg;
> +
> +       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> +       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> +
> +       wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN=
);
> +       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_O=
N_PMI);
> +}
> +
>  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
>
>  #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS *=
/
> --
> 2.43.0
>

