Return-Path: <linux-kernel+bounces-47532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083D844F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8E41F25719
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59717C80;
	Thu,  1 Feb 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKK0PuSs"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A92EEBC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753580; cv=none; b=ThplL0FJCm0Lt2c8SbEXCnEkxll2WhThmXanSl7hzm8rw3s7g8sOpkWYVolQdzBBy94XwMrlSg9pEhriBO5FU3BRQ1Hs3qlHnXk0J52olGv6kqhWEKj05Qprh4BwwLCetHsPbfPvqu0ItiPEF8njQwrtG+fgI3oUxXq6rxVwEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753580; c=relaxed/simple;
	bh=zNQDt/Rn1q3aEGgA9q976rgWmhppDKSFZOPDcvkyYnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry7fF6r2YUHbfNy+8DGTy3lXPtsBmw5Mm87DanvVW+5MwL646UGL6U0A82nLX5jKB0Gn5JsJYBpWan2TKV72ziNzbfIfyUCzUcTdErmSUpnqXXFjQokXtcDSM37tCyO1vWRgvSd+JDJ/hZwHsJ6Xy/yEnXwofTHYEA1XNdI8sW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKK0PuSs; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3638bd37107so50415ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706753577; x=1707358377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QwOM3Udzc7VB8Osj9qIeTGsk0UZWwK2mnv/fJx+RfI=;
        b=LKK0PuSsQqqeKPelDD0vC6z7MVAeMaJBU10g3DDWEIj0rlFL1Vwl4M2AjYtdQ+l3u5
         QbWSC1+8/cWWGCHqXxPE960WCPj6C6xun3rMeG9M38XNUOJ4n3G0INn4Q5hpwGtUtvFW
         OeXdanxZmPwe2f579BgLw2/6RHyMIoZGZW5A9yk06o9jdrpGQML3h37+XcIfs1NeYmRm
         /5PyvPXUDnpRoHvDzEnGtXWfUU4hv92BkPuzmr5XiZuRbuffE4N+LfQHcUJOwmsV1Vu0
         UKomfdasB4Xx/8d2mGpe1a4FHPe+NHuJzhHqxIgwGXlXrgjaG6rUiqer0zicXrQN15Uz
         uhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706753577; x=1707358377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QwOM3Udzc7VB8Osj9qIeTGsk0UZWwK2mnv/fJx+RfI=;
        b=T124kIn+WOpx+C3oKBH1SbgHTnyDTtuwKZX7363BLB6yFNwSyYpbzazIQ3YOLPvesH
         HH9TOf0b5EAeewMgQp51v38tGc3gWhXHu6nIaDKdECox26K2osPF1SbKNY7fbT/UG8uH
         JCOlK+0hM7z51raJUsFOPOXayx0ReECIOVXt8NIVoPM6QILpqiHXP6la03oRdJJHFxl2
         J8ZGJRImJJoKfJQNyc45F8cSpQWCiaNcmJss71IztyrwDww1mUS3aGtCH+GWuDtb2XcA
         qXTfPLdksTdUeebMHAblmqrzW0wXGxe/w6+k7t6YkZ6Zb8OYTvjD4dYVKvP1c2JCKPOm
         Q7tg==
X-Gm-Message-State: AOJu0Ywj2BcVsN6yHMphUWISH2530tiSytaHQ9mcLp3zDb3LgcQjaw0k
	yTl1u4Li/7YKdxaaXwrjMil0aQgIwD8yU2ffSasN4k3ijYSDpY7nifzGPqA+jjmsXpvuhUyWi1/
	vC0je8B7m6u61xJ3oNrwZw1a4cuE3oS3ecCEf
X-Google-Smtp-Source: AGHT+IEwMO8xEvKHqWiIDPSHUAtoieh+TkSU2KTMVNKN9SPavhQEA6Oi29+++xaQjG8V01fnbiIrGdiVCPiy7OvEumk=
X-Received: by 2002:a05:6e02:339b:b0:363:8007:d7dd with SMTP id
 bn27-20020a056e02339b00b003638007d7ddmr94374ilb.3.1706753576934; Wed, 31 Jan
 2024 18:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com> <20231129060211.1890454-8-irogers@google.com>
 <e3a01313-ed03-bc54-0260-5445fb2c15ee@arm.com> <2adf8e9c-e08d-a772-bfe2-378d6759721f@arm.com>
In-Reply-To: <2adf8e9c-e08d-a772-bfe2-378d6759721f@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 18:12:45 -0800
Message-ID: <CAP-5=fVkwz4fb4hn=cg_RaEW-s_N-4t2nm4mX_oWOduP+0QdOA@mail.gmail.com>
Subject: Re: [PATCH v1 07/14] perf arm-spe/cs-etm: Directly iterate CPU maps
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 6:36=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 12/12/2023 14:17, James Clark wrote:
> >
> >
> > On 29/11/2023 06:02, Ian Rogers wrote:
> >> Rather than iterate all CPUs and see if they are in CPU maps, directly
> >> iterate the CPU map. Similarly make use of the intersect
> >> function. Switch perf_cpu_map__has_any_cpu_or_is_empty to more
> >> appropriate alternatives.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>  tools/perf/arch/arm/util/cs-etm.c    | 77 ++++++++++++---------------=
-
> >>  tools/perf/arch/arm64/util/arm-spe.c |  4 +-
> >>  2 files changed, 34 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/u=
til/cs-etm.c
> >> index 77e6663c1703..a68a72f2f668 100644
> >> --- a/tools/perf/arch/arm/util/cs-etm.c
> >> +++ b/tools/perf/arch/arm/util/cs-etm.c
> >> @@ -197,38 +197,32 @@ static int cs_etm_validate_timestamp(struct auxt=
race_record *itr,
> >>  static int cs_etm_validate_config(struct auxtrace_record *itr,
> >>                                struct evsel *evsel)
> >>  {
> >> -    int i, err =3D -EINVAL;
> >> +    int idx, err =3D -EINVAL;
> >>      struct perf_cpu_map *event_cpus =3D evsel->evlist->core.user_requ=
ested_cpus;
> >>      struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> >> +    struct perf_cpu_map *intersect_cpus =3D perf_cpu_map__intersect(e=
vent_cpus, online_cpus);
> >> +    struct perf_cpu cpu;
> >>
> >> -    /* Set option of each CPU we have */
> >> -    for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> >> -            struct perf_cpu cpu =3D { .cpu =3D i, };
> >> -
> >> -            /*
> >> -             * In per-cpu case, do the validation for CPUs to work wi=
th.
> >> -             * In per-thread case, the CPU map is empty.  Since the t=
raced
> >> -             * program can run on any CPUs in this case, thus don't s=
kip
> >> -             * validation.
> >> -             */
> >> -            if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
> >> -                !perf_cpu_map__has(event_cpus, cpu))
> >> -                    continue;
> >
> > This has broken validation for per-thread sessions.
> > perf_cpu_map__intersect() doesn't seem to be able to handle the case
> > where an 'any' map intersected with an online map should return the
> > online map. Or at least it should for this to work, and it seems to mak=
e
> > sense for it to work that way.
> >
> > At least that was my initial impression, but I only debugged it and saw
> > that the loop is now skipped entirely.
> >
> >> -
> >> -            if (!perf_cpu_map__has(online_cpus, cpu))
> >> -                    continue;
> >> +    perf_cpu_map__put(online_cpus);
> >>
> >> -            err =3D cs_etm_validate_context_id(itr, evsel, i);
> >> +    /*
> >> +     * Set option of each CPU we have. In per-cpu case, do the valida=
tion
> >> +     * for CPUs to work with.  In per-thread case, the CPU map is emp=
ty.
> >> +     * Since the traced program can run on any CPUs in this case, thu=
s don't
> >> +     * skip validation.
> >> +     */
> >> +    perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> >> +            err =3D cs_etm_validate_context_id(itr, evsel, cpu.cpu);
> >>              if (err)
> >>                      goto out;
> >> -            err =3D cs_etm_validate_timestamp(itr, evsel, i);
> >> +            err =3D cs_etm_validate_timestamp(itr, evsel, idx);

I think this is an error, idx shouldn't be used here, cpu.cpu should.

> >>              if (err)
> >>                      goto out;
> >>      }
> >>
> >>      err =3D 0;
> >>  out:
> >> -    perf_cpu_map__put(online_cpus);
> >> +    perf_cpu_map__put(intersect_cpus);
> >>      return err;
> >>  }
> >>
> >> @@ -435,7 +429,7 @@ static int cs_etm_recording_options(struct auxtrac=
e_record *itr,
> >>       * Also the case of per-cpu mmaps, need the contextID in order to=
 be notified
> >>       * when a context switch happened.
> >>       */
> >> -    if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> >> +    if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >>              evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> >>                                         "timestamp", 1);
> >>              evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> >> @@ -461,7 +455,7 @@ static int cs_etm_recording_options(struct auxtrac=
e_record *itr,
> >>      evsel->core.attr.sample_period =3D 1;
> >>
> >>      /* In per-cpu case, always need the time of mmap events etc */
> >> -    if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> >> +    if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
> >>              evsel__set_sample_bit(evsel, TIME);
> >>
> >>      err =3D cs_etm_validate_config(itr, cs_etm_evsel);
> >> @@ -533,38 +527,32 @@ static size_t
> >>  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> >>                    struct evlist *evlist __maybe_unused)
> >>  {
> >> -    int i;
> >> +    int idx;
> >>      int etmv3 =3D 0, etmv4 =3D 0, ete =3D 0;
> >>      struct perf_cpu_map *event_cpus =3D evlist->core.user_requested_c=
pus;
> >>      struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> >> +    struct perf_cpu cpu;
> >>
> >>      /* cpu map is not empty, we have specific CPUs to work with */
> >> -    if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> >> -            for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> >> -                    struct perf_cpu cpu =3D { .cpu =3D i, };
> >> -
> >> -                    if (!perf_cpu_map__has(event_cpus, cpu) ||
> >> -                        !perf_cpu_map__has(online_cpus, cpu))
> >> -                            continue;
> >> +    if (!perf_cpu_map__is_empty(event_cpus)) {
> >> +            struct perf_cpu_map *intersect_cpus =3D
> >> +                    perf_cpu_map__intersect(event_cpus, online_cpus);
> >>
> >> -                    if (cs_etm_is_ete(itr, i))
> >> +            perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_c=
pus) {
> >> +                    if (cs_etm_is_ete(itr, cpu.cpu))
>
> Similar problem here. For a per-thread session, the CPU map is not empty
> (it's an 'any' map, presumably length 1), so it comes into this first
> if, rather than the else below which is for the 'any' scenario.
>
> Then the intersect with online CPUs results in an empty map, so no CPU
> metadata is recorded, then the session fails.
>
> If you made the intersect work in the way I mentioned above we could
> also delete the else below, because that's just another way to convert
> from 'any' to 'all online'.

I don't think intersect of "all online" with an "any CPU" should
return "all online" as these would be quite different options to
perf_event_open. Let's see if the issue above fixes this change
otherwise I can revert it to a more mechanical translation of the
existing code into the new APIs.

Thanks,
Ian

> >>                              ete++;
> >> -                    else if (cs_etm_is_etmv4(itr, i))
> >> +                    else if (cs_etm_is_etmv4(itr, cpu.cpu))
> >>                              etmv4++;
> >>                      else
> >>                              etmv3++;
> >>              }
> >> +            perf_cpu_map__put(intersect_cpus);
> >>      } else {
> >>              /* get configuration for all CPUs in the system */
> >> -            for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> >> -                    struct perf_cpu cpu =3D { .cpu =3D i, };
> >> -
> >> -                    if (!perf_cpu_map__has(online_cpus, cpu))
> >> -                            continue;
> >> -
> >> -                    if (cs_etm_is_ete(itr, i))
> >> +            perf_cpu_map__for_each_cpu(cpu, idx, online_cpus) {
> >> +                    if (cs_etm_is_ete(itr, cpu.cpu))
> >>                              ete++;
> >> -                    else if (cs_etm_is_etmv4(itr, i))
> >> +                    else if (cs_etm_is_etmv4(itr, cpu.cpu))
> >>                              etmv4++;
> >>                      else
> >>                              etmv3++;
> >> @@ -814,15 +802,14 @@ static int cs_etm_info_fill(struct auxtrace_reco=
rd *itr,
> >>              return -EINVAL;
> >>
> >>      /* If the cpu_map is empty all online CPUs are involved */
> >> -    if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> >> +    if (perf_cpu_map__is_empty(event_cpus)) {
> >>              cpu_map =3D online_cpus;
> >>      } else {
> >>              /* Make sure all specified CPUs are online */
> >> -            for (i =3D 0; i < perf_cpu_map__nr(event_cpus); i++) {
> >> -                    struct perf_cpu cpu =3D { .cpu =3D i, };
> >> +            struct perf_cpu cpu;
> >>
> >> -                    if (perf_cpu_map__has(event_cpus, cpu) &&
> >> -                        !perf_cpu_map__has(online_cpus, cpu))
> >> +            perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
> >> +                    if (!perf_cpu_map__has(online_cpus, cpu))
> >>                              return -EINVAL;
> >>              }
> >>
> >> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/ar=
m64/util/arm-spe.c
> >> index 51ccbfd3d246..0b52e67edb3b 100644
> >> --- a/tools/perf/arch/arm64/util/arm-spe.c
> >> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> >> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtra=
ce_record *itr,
> >>       * In the case of per-cpu mmaps, sample CPU for AUX event;
> >>       * also enable the timestamp tracing for samples correlation.
> >>       */
> >> -    if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> >> +    if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >>              evsel__set_sample_bit(arm_spe_evsel, CPU);
> >>              evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
> >>                                         "ts_enable", 1);
> >> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtra=
ce_record *itr,
> >>      tracking_evsel->core.attr.sample_period =3D 1;
> >>
> >>      /* In per-cpu case, always need the time of mmap events etc */
> >> -    if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> >> +    if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >>              evsel__set_sample_bit(tracking_evsel, TIME);
> >>              evsel__set_sample_bit(tracking_evsel, CPU);
> >>

