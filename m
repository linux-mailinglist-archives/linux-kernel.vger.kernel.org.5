Return-Path: <linux-kernel+bounces-99437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E55878852
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F851F21253
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD05D733;
	Mon, 11 Mar 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sqFMMRjB"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9958226
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182802; cv=none; b=KCZ27M+TFrm07AZbw9PKb+h7jef8Cne3usSlNnznzF6nnyK7xfc2Ws/2jHduBdG0RVRrlnaZh9wW88OEPyv+Uf8rRpbl1mmwa2TWh07K92vpTFAo03vRMTS3CQKu5PtPZuRqzSnzlAcllCyacTs6Aixc+dKNQkJnyyBgjYf01ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182802; c=relaxed/simple;
	bh=4tnukOvt1JwFp+9tYJHauPDa8rFBUHDXgGWEbETxn9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQu/wZli8mZN4v+7MHDxMgKWhBtXxq8VZR+cBZivBaCg1tHIyImCPbzWk0TUUyb4PZ8tsNJBYhLl0rE1SLqp56SOiDj3PoIRA/9chOJJ/hlnmAszFEvDBfkGYXGdPqwQxA/BRQxAf38dhIiP9PwHQrULVq0l4NNtKSSGlzcMzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqFMMRjB; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36645c1169cso13525ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710182799; x=1710787599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okeaD/qeYIbeOhpxp6GW5j3JWeLxsb+oQ1MKTosIVPY=;
        b=sqFMMRjBYbBUTaMTc7mgAarl1E06hxoPLNUVToiWKXNeHjrxc+WryDOTnAlmMdc9BN
         BwPVryzW0iQif0yXoVUc7t1En2Cg/AC5932Jn7CyfUkh3eMDQt8R5Jd/3YOawlf5jblN
         RBhJnh33YgBHp+cjwoaIRd4BnwjgOzJ8flkWA/kvzwmdoHFWCG42kgVl3EHhyWLAhaI6
         gPTIoTbulLNhgn2DQL9pyeZjNVAHvjrZlB9UQNk67qwuzWHgys9VDx0ClPEKQ6BOefMP
         04ckgCI2gMGF6mWHtIShQ7yzpB22b5pkQglYL4Uo39cHR5dg0Q+rLCrTHVC1lbu3qb9m
         X3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182799; x=1710787599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okeaD/qeYIbeOhpxp6GW5j3JWeLxsb+oQ1MKTosIVPY=;
        b=tAglMIo8pQtrY8qTjRt4TJVvE3hceaeAyLbCbv5vT+kPIM363ObSNY5FCtT/Qd3NhH
         0Kmxq82iiBJi1gTFXpwABHvoCRUvRjxgXAlrxkUq32uDjj2XSLSyWCOjzxskvb70ZDCm
         oro5G0RH5Ign05Q9Y3IYjxnE4i3tbyp79cW/UsbEgzLDKiQfJxHusg+q6rTQv6aYtgk/
         oT+rU7Lhw4dHlfBYxWCCT4BMiRQHwTUVezhuuI5Fl65dwqv/1yPDUAoLvkqCbJ0gych8
         Loo7HCU70JtMJH7PlVqXoSdG4EYGVRTo9IjlKX7fP8TNQo5Sq+N3RhqJnoTbN7unx7Fv
         aJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWYu734yUYitHPkzTs0QrjP+nu/2FN65Ufr/VSbQVqsGeA0UEtWlv9EnLoDB/Nijdr9uy8XwVSV+8W8K7p0vnFY9T7JXWF5Rx2pC0+H
X-Gm-Message-State: AOJu0Yx9AK50mxCqcuKHFfqb1WdnWOfkLtGBmqjV9FqbBtyoHpYKf2kp
	AVCCw3Zn90xQnzFGp12stkmBKPkCu0k/njQ7s34ONdHRDksDZpcZoAWrprOKXpBw5Qc+NWp9cKJ
	USQJqftrPaBqHZPUp7yMvkpvzRXuM0USCnZ+UACCf6EYdoonfgYu1Jks=
X-Google-Smtp-Source: AGHT+IH9V6zXFkH2eIcaEf6hb7GOj/t5Kz3yRY4fZ+YxUfZVuT/kDFTVTu1nQNq7B5Q34+6Z4JM7XREgt6qzrUbmkcw=
X-Received: by 2002:a05:6e02:260b:b0:366:222d:6625 with SMTP id
 by11-20020a056e02260b00b00366222d6625mr11644ilb.1.1710182798920; Mon, 11 Mar
 2024 11:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710133771.git.sandipan.das@amd.com> <017b0abebc24535e3e96fa9f9cc4ba4c11fffb57.1710133771.git.sandipan.das@amd.com>
In-Reply-To: <017b0abebc24535e3e96fa9f9cc4ba4c11fffb57.1710133771.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 11:46:24 -0700
Message-ID: <CAP-5=fWc5ZJaiR_tS8RHPxcdAPST61CYUS_9Qvc2ztzBUETQbg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf vendor events amd: Add Zen 5 metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:24=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add metrics taken from Section 1.2 "Performance Measurement" of the
> Performance Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors
> document available at the link below.
>
> The recommended metrics are sourced from Table 1 "Guidance for Common
> Performance Statistics with Complex Event Selects".
>
> The pipeline utilization metrics are sourced from Table 2 "Guidance
> for Pipeline Utilization Analysis Statistics". These are useful for
> finding performance bottlenecks by analyzing activity at different
> stages of the pipeline. There are metric groups available for Level 1
> and Level 2 analysis.
>
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D305974
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Could you consider reviewing:
https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/

> ---
>  .../pmu-events/arch/x86/amdzen5/pipeline.json |  98 +++++
>  .../arch/x86/amdzen5/recommended.json         | 357 ++++++++++++++++++
>  2 files changed, 455 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.js=
on
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json b/tools=
/perf/pmu-events/arch/x86/amdzen5/pipeline.json
> new file mode 100644
> index 000000000000..36dc76b793ae
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "MetricName": "total_dispatch_slots",
> +    "BriefDescription": "Total dispatch slots (up to 8 instructions can =
be dispatched in each cycle).",
> +    "MetricExpr": "8 * ls_not_halted_cyc"

Should the unit be slots?

> +  },
> +  {
> +    "MetricName": "frontend_bound",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because the frontend did not supply enough instructions/ops.",

Given the output is in percent, is fraction an accurate description?
Wouldn't "percentage" be better? This issue repeats below, but I'll
just highlight the first instance.

> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend,=
 total_dispatch_slots)",
> +    "MetricGroup": "PipelineL1",
> +    "ScaleUnit": "100%"

Perhaps "100% slots" ?

> +  },
> +  {
> +    "MetricName": "bad_speculation",
> +    "BriefDescription": "Fraction of dispatched ops that did not retire.=
",
> +    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispat=
ch_slots)",
> +    "MetricGroup": "PipelineL1",
> +    "ScaleUnit": "100%"

Perhaps "100% ops"

> +  },
> +  {
> +    "MetricName": "backend_bound",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of backend stalls.",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total=
_dispatch_slots)",
> +    "MetricGroup": "PipelineL1",
> +    "ScaleUnit": "100%"

Perhaps "100% slots"

> +  },
> +  {
> +    "MetricName": "smt_contention",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because the other thread was selected.",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total=
_dispatch_slots)",
> +    "MetricGroup": "PipelineL1",
> +    "ScaleUnit": "100%"

Perhaps "100% slots"

> +  },
> +  {
> +    "MetricName": "retiring",
> +    "BriefDescription": "Fraction of dispatch slots used by ops that ret=
ired.",
> +    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
> +    "MetricGroup": "PipelineL1",
> +    "ScaleUnit": "100%"

Perhaps "100% slots"

> +  },
> +  {
> +    "MetricName": "frontend_bound_latency",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of a latency bottleneck in the frontend (such as instruction cache=
 or TLB misses).",
> +    "MetricExpr": "d_ratio((8 * cpu@de_no_dispatch_per_slot.no_ops_from_=
frontend\\,cmask\\=3D0x8@), total_dispatch_slots)",
> +    "MetricGroup": "PipelineL2;frontend_bound_group",
> +    "ScaleUnit": "100%"

Perhaps "100% slots"

> +  },
> +  {
> +    "MetricName": "frontend_bound_bandwidth",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of a bandwidth bottleneck in the frontend (such as decode or op ca=
che fetch bandwidth).",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend =
- (8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=3D0x8@), =
total_dispatch_slots)",
> +    "MetricGroup": "PipelineL2;frontend_bound_group",
> +    "ScaleUnit": "100%"

Perhaps "100% slots"

It seems unexpected that a latency (above) and  bandwidth metric would
be reporting a percentage, perhaps this needs capturing in the metric
name.

Same issues repeat below...

> +  },
> +  {
> +    "MetricName": "bad_speculation_mispredicts",
> +    "BriefDescription": "Fraction of dispatched ops that were flushed du=
e to branch mispredicts.",
> +    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn=
_misp + bp_redirects.resync)",
> +    "MetricGroup": "PipelineL2;bad_speculation_group",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "bad_speculation_pipeline_restarts",
> +    "BriefDescription": "Fraction of dispatched ops that were flushed du=
e to pipeline restarts (resyncs).",
> +    "MetricExpr": "d_ratio(bad_speculation * bp_redirects.resync, ex_ret=
_brn_misp + bp_redirects.resync)",
> +    "MetricGroup": "PipelineL2;bad_speculation_group",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "backend_bound_memory",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of stalls due to the memory subsystem.",
> +    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complet=
e, ex_no_retire.not_complete)",
> +    "MetricGroup": "PipelineL2;backend_bound_group",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "backend_bound_cpu",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of stalls not related to the memory subsystem.",
> +    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_co=
mplete, ex_no_retire.not_complete))",
> +    "MetricGroup": "PipelineL2;backend_bound_group",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "retiring_fastpath",
> +    "BriefDescription": "Fraction of dispatch slots used by fastpath ops=
 that retired.",
> +    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops)=
)",
> +    "MetricGroup": "PipelineL2;retiring_group",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "retiring_microcode",
> +    "BriefDescription": "Fraction of dispatch slots used by microcode op=
s that retired.",
> +    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
> +    "MetricGroup": "PipelineL2;retiring_group",
> +    "ScaleUnit": "100%"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen5/recommended.json
> new file mode 100644
> index 000000000000..986f8b2b2d5b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
> @@ -0,0 +1,357 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-time branch misprediction ratio (non-=
speculative).",

Is ratio or rate better?
```
$ grep -r MetricName tools/perf/pmu-events/arch/| grep _rate |wc -l
246
$ grep -r MetricName tools/perf/pmu-events/arch/| grep _ratio |wc -l
135
```

> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "all_data_cache_accesses_pti",
> +    "BriefDescription": "All data cache accesses per thousand instructio=
ns.",
> +    "MetricExpr": "ls_dispatch.all / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"

Perhaps "1e3instructions", and below.

> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses_pti",
> +    "BriefDescription": "All L2 cache accesses per thousand instructions=
",
> +    "MetricExpr": "(l2_request_g1.all_no_prefetch + l2_pf_hit_l2.l2_hwpf=
 + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions"=
,
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l1_ic_misses_pti",
> +    "BriefDescription": "L2 cache accesses from L1 instruction cache mis=
ses (including prefetch) per thousand instructions.",
> +    "MetricExpr": "l2_request_g1.cacheable_ic_read / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l1_dc_misses_pti",
> +    "BriefDescription": "L2 cache accesses from L1 data cache misses (in=
cluding prefetch) per thousand instructions.",
> +    "MetricExpr": "l2_request_g1.all_dc / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf_pti",
> +    "BriefDescription": "L2 cache accesses from L2 cache hardware prefet=
cher per thousand instructions.",
> +    "MetricExpr": "(l2_pf_hit_l2.l1_dc_l2_hwpf + l2_pf_miss_l2_hit_l3.l1=
_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses_pti",
> +    "BriefDescription": "All L2 cache misses per thousand instructions."=
,
> +    "MetricExpr": "(l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_h=
it_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l1_ic_miss_pti",
> +    "BriefDescription": "L2 cache misses from L1 instruction cache misse=
s per thousand instructions.",
> +    "MetricExpr": "l2_cache_req_stat.ic_fill_miss / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l1_dc_miss_pti",
> +    "BriefDescription": "L2 cache misses from L1 data cache misses per t=
housand instructions.",
> +    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf_pti",
> +    "BriefDescription": "L2 cache misses from L2 cache hardware prefetch=
er per thousand instructions.",
> +    "MetricExpr": "(l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l=
3.l1_dc_l2_hwpf) / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits_pti",
> +    "BriefDescription": "All L2 cache hits per thousand instructions.",
> +    "MetricExpr": "(l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.l2_=
hwpf) / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l1_ic_miss_pti",
> +    "BriefDescription": "L2 cache hits from L1 instruction cache misses =
per thousand instructions.",
> +    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2 / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l1_dc_miss_pti",
> +    "BriefDescription": "L2 cache hits from L1 data cache misses per tho=
usand instructions.",
> +    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2 / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf_pti",
> +    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher=
 per thousand instructions.",
> +    "MetricExpr": "l2_pf_hit_l2.l1_dc_l2_hwpf / instructions",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l3_cache_accesses",
> +    "BriefDescription": "L3 cache accesses.",
> +    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
> +    "MetricGroup": "l3_cache"
> +  },
> +  {
> +    "MetricName": "l3_misses",
> +    "BriefDescription": "L3 misses (including cacheline state change req=
uests).",

local vs remote?

> +    "MetricExpr": "l3_lookup_state.l3_miss",
> +    "MetricGroup": "l3_cache"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 read miss latency (in core clocks)."=
,
> +    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_late=
ncy_requests.all",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency_for_local_dram",
> +    "BriefDescription": "Average L3 read miss latency (in core clocks) f=
or local DRAM.",
> +    "MetricExpr": "(l3_xi_sampled_latency.dram_near * 10) / l3_xi_sample=
d_latency_requests.dram_near",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"

"core clocks" isn't defined in the attached documentation. How can one
look up the different clock types? If "core" is basically all clock
types in the metrics then consider dropping "core" here.

> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency_for_remote_dram",
> +    "BriefDescription": "Average L3 read miss latency (in core clocks) f=
or remote DRAM.",
> +    "MetricExpr": "(l3_xi_sampled_latency.dram_far * 10) / l3_xi_sampled=
_latency_requests.dram_far",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "op_cache_fetch_miss_ratio",
> +    "BriefDescription": "Op cache miss ratio for all fetches.",
> +    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit=
_miss.all_op_cache_accesses)",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "Instruction cache miss ratio for all fetches. A=
n instruction cache miss will not be counted by this metric if it is an OC =
hit.",
> +    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_ta=
g_hit_miss.all_instruction_cache_accesses)",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_memory_pti",
> +    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NU=
MA node per thousand instructions.",
> +    "MetricExpr": "ls_any_fills_from_sys.dram_io_all / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_remote_node_pti",
> +    "BriefDescription": "L1 data cache fills from a different NUMA node =
per thousand instructions.",
> +    "MetricExpr": "ls_any_fills_from_sys.far_all / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_same_ccx_pti",
> +    "BriefDescription": "L1 data cache fills from within the same CCX pe=
r thousand instructions.",
> +    "MetricExpr": "ls_any_fills_from_sys.local_all / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_different_ccx_pti",
> +    "BriefDescription": "L1 data cache fills from another CCX cache in a=
ny NUMA node per thousand instructions.",
> +    "MetricExpr": "ls_any_fills_from_sys.remote_cache / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "all_l1_data_cache_fills_pti",
> +    "BriefDescription": "All L1 data cache fills per thousand instructio=
ns.",
> +    "MetricExpr": "ls_any_fills_from_sys.all / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_local_l2_pti",
> +    "BriefDescription": "L1 demand data cache fills from local L2 cache =
per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2 / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_same_ccx_pti",
> +    "BriefDescription": "L1 demand data cache fills from within the same=
 CCX per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_near_cache_pti",
> +    "BriefDescription": "L1 demand data cache fills from another CCX cac=
he in the same NUMA node per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_near_memory_pti",
> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in=
 the same NUMA node per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_far_cache_pti",
> +    "BriefDescription": "L1 demand data cache fills from another CCX cac=
he in a different NUMA node per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_far_memory_pti",
> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in=
 a different NUMA node per thousand instructions.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far / instructions",
> +    "MetricGroup": "l1_dcache",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses_pti",
> +    "BriefDescription": "L1 instruction TLB misses per thousand instruct=
ions.",
> +    "MetricExpr": "(bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_mi=
ss.all) / instructions",
> +    "MetricGroup": "tlb",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_itlb_misses_pti",
> +    "BriefDescription": "L2 instruction TLB misses and instruction page =
walks per thousand instructions.",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all / instructions",
> +    "MetricGroup": "tlb",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l1_dtlb_misses_pti",
> +    "BriefDescription": "L1 data TLB misses per thousand instructions.",
> +    "MetricExpr": "ls_l1_d_tlb_miss.all / instructions",
> +    "MetricGroup": "tlb",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "l2_dtlb_misses_pti",
> +    "BriefDescription": "L2 data TLB misses and data page walks per thou=
sand instructions.",
> +    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss / instructions",
> +    "MetricGroup": "tlb",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "all_tlbs_flushed_pti",
> +    "BriefDescription": "All TLBs flushed per thousand instructions.",
> +    "MetricExpr": "ls_tlb_flush.all / instructions",
> +    "MetricGroup": "tlb",
> +    "ScaleUnit": "1e3"
> +  },
> +  {
> +    "MetricName": "macro_ops_dispatched",
> +    "BriefDescription": "Macro-ops dispatched.",
> +    "MetricExpr": "de_src_op_disp.all",
> +    "MetricGroup": "decoder"
> +  },
> +  {
> +    "MetricName": "sse_avx_stalls",
> +    "BriefDescription": "Mixed SSE/AVX stalls.",
> +    "MetricExpr": "fp_disp_faults.sse_avx_all"
> +  },
> +  {
> +    "MetricName": "macro_ops_retired",
> +    "BriefDescription": "Macro-ops retired.",
> +    "MetricExpr": "ex_ret_ops"
> +  },
> +  {
> +    "MetricName": "umc_data_bus_utilization",
> +    "BriefDescription": "Memory controller data bus utilization.",
> +    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for rea=
ds.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_write_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for wri=
tes.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_mem_read_bandwidth",
> +    "BriefDescription": "Estimated memory read bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_write_bandwidth",
> +    "BriefDescription": "Estimated memory write bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_bandwidth",
> +    "BriefDescription": "Estimated combined memory bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for rea=
ds.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_activate_cmd_rate",
> +    "BriefDescription": "Memory controller ACTIVATE command rate.",
> +    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_precharge_cmd_rate",
> +    "BriefDescription": "Memory controller PRECHARGE command rate.",
> +    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"

Units of umc_mem_clk?

Thanks,
Ian

> +  }
> +]
> --
> 2.34.1
>

