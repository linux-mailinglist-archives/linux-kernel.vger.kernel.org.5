Return-Path: <linux-kernel+bounces-88895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0C86E818
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD02C1F23809
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17527701;
	Fri,  1 Mar 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+whfIv5"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA883A1C5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317040; cv=none; b=PhXbVaeFmHnv5rBHpMRBCvYYXjbR1Ar0qDOvihwOV0shIdBpOHvM4w+63pUisnsIx51IUNGNUQkhjyiaItkCL77HWpHXuwi0bsFoEe9/sd0/AUToUU1O+rN91hHqZ8S00kwxBEhFihy43nJKk83+ZZERUOIcOiJIt6KjtwAJXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317040; c=relaxed/simple;
	bh=ORNRTXO5tve5Nbc9/dvCua1upVjXHlRaDwslfC29pOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOQGkfbT7Nj92GP7hOtHxrAvcfJ0ARYOOqqt7UB0q5rZ8YmFAK2RKtjKeO8t5k2XWj4yS+/dvrSfOfQm3s3Rz4qTFWlqt9DRZI30lqpJ02MN1Cz8k9YtcFBWxw8ZDsFYb/1dfbgqMQUJkbAzazw4x+KfmXUKC16d0sLOjemR1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+whfIv5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so343411cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709317038; x=1709921838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/XpCAVrNR7f3usUyCsnp/6VufeVu2JOUWJrzYbrmGQ=;
        b=E+whfIv5HtsOENwRwBFdE0T2vskCsJAZtnt8OHrddv5xurWapjck55iYJm+LcLeJyW
         /sNWfZtPsOHODuNej02qgvEHpf9/cs655CX7b2yWHNJVgia8JZEk1ZGRAlauRoJXJCrx
         dxH/6paFv+z3N/w6SvS5BCPOGgFnlB03t0X8PEGQm3y7Zy7Z3b1dtjNmWMM5LhI3+9uZ
         9s8WrmfnpIg4PtBtTl9/ZA5xVdFalB9OKpTqT33a5oiE6D+KG0euUxj/rpsRSxyulWTm
         CVJkZY5md48Htfrwpfqqr/M4t870M/DeZDJT3c/su4vSJjTLBf+IwJDKgaEZUUsP9Rlg
         Rtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709317038; x=1709921838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/XpCAVrNR7f3usUyCsnp/6VufeVu2JOUWJrzYbrmGQ=;
        b=shXs7tciGMUolKrl7bCHzDyfAvkVR5PFS6rep47oExkRMYrmyMdy9kmiKCrCDfYikV
         l+UqfhnO4wx8786DsQhNRS5zvi5b1g4CMYeS0usk6HXVbpBCX/7kzzK7VUsfFdCoe4fw
         Is3i8En8B7lr7C4Qv/yNGSfLhxXNVw2Nh0lE/B7B7jQBJ7HIFiX/iRf6tDUH8IAY20MV
         l0iiK19VK5Us8AdwIQsFzOXN0Q8xAzI725BZBAEzkabYom+y4aqnWb3bm0iv2Ls3erEf
         bxXuWLQSj4AWj0qSzDsFDS1t1yzEV25AfdyELof8zm5KkOzltFNOk2T4fBJdpt73tTNG
         IbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGIqn2PfAxMRCPN3NDsbYPkfJyyWB3pk9mDvz4mDVdxC++1SC7DFrV6HMzBoKi2+lePWlP6jdpH1dbSxY1cui7WnfBh9ZqjRYPxqdm
X-Gm-Message-State: AOJu0YxVEzVV0fD4jnRtZWR8Rm8tSxTC18Pbq2u2nVb8FW5NIVcusPV7
	A6M3BmMnSpo1OPp2yuJxFgK3FvS8aTd6Lybb663eanldc/z0U0wxLTdHmDDgL4QXJSPugS5RbWF
	CTLZQO/U3thaLaRUCSCEYqtcepd3y1yXq4YpZ
X-Google-Smtp-Source: AGHT+IH64w3XM2tu4oMulQS5R0gtlaWwhUlwTSJvlTxAqKqMt8U0FgeFMcjORD/zd3TbgUq/mHHUYeh6xc3tPY4Rnnc=
X-Received: by 2002:a05:622a:170b:b0:42e:d51e:c718 with SMTP id
 h11-20020a05622a170b00b0042ed51ec718mr46389qtk.9.1709317037508; Fri, 01 Mar
 2024 10:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-3-irogers@google.com>
 <ZeIVQhfDMP7_bSJ8@tassilo>
In-Reply-To: <ZeIVQhfDMP7_bSJ8@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 10:17:03 -0800
Message-ID: <CAP-5=fWpXHXd8Dd39o_KEcVaBkQKk=aXjYSVTWCitaY6Xm-T4A@mail.gmail.com>
Subject: Re: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
To: Andi Kleen <ak@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:49=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > +def Idle() -> Metric:
> > +  cyc =3D Event("msr/mperf/")
> > +  tsc =3D Event("msr/tsc/")
> > +  low =3D max(tsc - cyc, 0)
> > +  return Metric(
> > +      "idle",
> > +      "Percentage of total wallclock cycles where CPUs are in low powe=
r state (C1 or deeper sleep state)",
> > +      d_ratio(low, tsc), "100%")
>
> TBH I fail to see the advantage over the JSON. That's much more verbose
> and we don't expect to have really complex metrics anyways.

Are you saying this is more verbose or the json? Here is an example of
a json metric:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=3Dperf-tools-=
next#n652
```
    {
        "BriefDescription": "Probability of Core Bound bottleneck
hidden by SMT-profiling artifacts",
        "MetricExpr": "(100 * (1 - tma_core_bound /
(((EXE_ACTIVITY.EXE_BOUND_0_PORTS + tma_core_bound *
RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTED.THREAD *
(CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) /
CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD +
(EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring *
EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL -
CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL +
tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD)
if tma_core_bound < (((EXE_ACTIVITY.EXE_BOUND_0_PORTS + tma_core_bound
* RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTED.THREAD *
(CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) /
CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD +
(EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring *
EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL -
CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL +
tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD)
else 1) if tma_info_system_smt_2t_utilization > 0.5 else 0)",
        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
        "MetricName": "tma_info_botlnk_core_bound_likely",
        "MetricgroupNoGroup": "TopdownL1"
    },
```

Even with common metrics like tma_core_bound, tma_retiring and
tma_info_system_smt_2t_utilization replacing sections of the metric, I
think anyone has to admit the expression is pretty unintelligible
because of its size/verbosity. To understand the metric would at a
first step involve adding newlines. Comments would be nice, etc.

> And then we have a gigantic patch kit for what gain?

I see some of the gains as:
 - metrics that are human intelligible,
 - metrics for models that are no longer being updated,
 - removing copy-paste of metrics like tsx and smi across each model's
metric json (less lines-of-code),
 - validation of events in a metric expression being in the event json
for a model,
 - removal of forward porting metrics to a new model if the event
names of the new model line up with those of previous,
 - in this patch kit there are metrics added that don't currently
exist (more metrics should be better for users - yes there can always
be bugs).

I also hope the metric grouping is clearer, etc, etc.

> The motivation was the lack of comments in JSON? We could just add some
> to the parser (e.g. with /* */ ).  And we could allow an JSON array for t=
he
> expression to get multiple lines.

Imo, a non-json variant of json would just be taking on a tech debt
burden for something that is inferior to this approach and a wasted
effort. We already generate the json from other more intelligible
sources using python - so I don't find the approach controversial:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

The goal here has been to make a bunch of inhouse metrics public. It
also gives a foundation for vendors and other concerned people to add
metrics in a concise, with documentation and safe (broken events cause
compile time failures) way. There are some similar things like common
events/metrics on ARM:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/arm64/arm/cmn/sys?h=3Dperf-tools-next
but this lacks the structure, validation, documentation, etc. that's
present here so my preference would be for more of the common things
to be done in the python way started here.

Thanks,
Ian

> -Andi

