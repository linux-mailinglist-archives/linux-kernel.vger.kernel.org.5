Return-Path: <linux-kernel+bounces-87751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16F86D884
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506DC28498A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF472AE91;
	Fri,  1 Mar 2024 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O+ubgZUp"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989B2AF1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254961; cv=none; b=gXlOTvY2ze/MfWLLWzPaDN0GFP6AY3uI1EUhMX+59L4fCUl1nsv2DvLuWB8gYe/KsqlN8jBNFkw7EFYFoIQfkbrHdk8StSfcaVYlKlu30M+ARuihKSEwdB3+n3F198GXnIWUwihLyrRbeuCoEPBTG44RPLzry7ogGBsvVXUxhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254961; c=relaxed/simple;
	bh=U+jHS2PunKxlRK3QdGi/HqmwOX6E5pGajTxpk2flEbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0I4lsRQ0E6RESMGW2t+pUZJAZc7bLQh2nxPWXcR8rfzmPVEVLS3lqDZddbtXEiOCqOZqaLa5kQpSlEYnRM5AiU/fmpoqcBKZIydK3DNCkrvNTAXLD/ABHrfbedEOvktF83AelPp8luOSGN5AozqFY0Z2IfxaolH/Q/qxqC4EwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+ubgZUp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ecb40dc07so7611cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254958; x=1709859758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVZpDDjOG9tFqVs0tYA5gDweMLPCuh+jIrg2FxoiREs=;
        b=O+ubgZUphldv2/j8e3jEBR0mEipFtSQoZx4MVMcg9ZHhfj06xhMhG2sN8ZQRokXtfJ
         DMxQUEhypIiwz058p2l1Y8uvlNGqkuCB4f2GEacw/i9DadlLy8DAaDsuq5XGQys4Md/9
         UpvXkhXRu8ipay+Q3j+KIJfxV8ggaQpt6zG/iNSFjSFWi5bpfFQwirbgohhjQ6t3Ud/1
         +26gLWlMueUqx768Sh0/IUifsMZnwnMsfiVhZBp/aoroMlyZ0NtC8K08lWNZICBWOqCF
         mf2w5mCJ7m7jAIp4iFk0odv8JtJkhjh3q5X8IVZ+ID4RcfS9+eD+kyxEcvHlu32RPU4i
         V7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254958; x=1709859758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVZpDDjOG9tFqVs0tYA5gDweMLPCuh+jIrg2FxoiREs=;
        b=vINaeb8M3vBk1HXe71VmfBvVdCSC5h+8QSBhVlv7yX8F0CNtOOiqYNcWLD69iyYV28
         isQ02hi1YNt9Agij4iQ921GAiUtC7HYdarKXKQcbj3IYc3Se6p1XkQ67rqOEI3XfAhDx
         IMUJMlJXf8Y2KCdiT8XqEbMVtV+SCFBzvWenNeyg96uDpsowghW0BUflOgNIhAdxTgRf
         9VjePFDQWI8SXXkBNcg9u/sVXiTd/7EQ0GWmeXeCEBgI0tEOUi9HbcKCvkfQSYSHGXFr
         tbK4uoqugL+/8J7m3+R2y8gcxbb8DjiLS2JmsknadjaAP1ulapCOTrIt752thHugD4Sy
         u0dg==
X-Forwarded-Encrypted: i=1; AJvYcCUff2vD9iVRb5IH8HSz7ivfocq+LwBFdIfOPIA7n4+ZmL53vnjxwqRcpb5em8f+UMdsK3NqAV4WSl15QIcyu3/5MglmmmYDW9JUhLd6
X-Gm-Message-State: AOJu0Yz6lA9AmpTngMvvVa6URZW7rN6SDsGQ8lOTqNs3GYMhLj35y/vh
	x1VkPuB5bmY+7twUvfEtxMNBKPkBqpaPOuMHybhjHhj67LPXkTTDnw22ARZrH0yrTtK2xaJo36J
	305XqHFK5oqKet4jqjBNRccVnVmk9rQJa0w7N
X-Google-Smtp-Source: AGHT+IE3XkMWqqoTOW6Jc3RaKgMJptjXxizztP17HV/YrsbXEqzRk25HPLUOzt2ueRdFN28Vel/WakZGmDw1IDKQCeA=
X-Received: by 2002:a05:622a:130b:b0:42e:2931:13df with SMTP id
 v11-20020a05622a130b00b0042e293113dfmr57740qtk.11.1709254957924; Thu, 29 Feb
 2024 17:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-6-irogers@google.com>
 <7ec53a59-10d7-4a85-90b7-1337a0a42815@linux.intel.com>
In-Reply-To: <7ec53a59-10d7-4a85-90b7-1337a0a42815@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 17:02:26 -0800
Message-ID: <CAP-5=fUHUUSyah-fc+iigy0XPvnuZZKW59MhOZcXcfwx7Ecrew@mail.gmail.com>
Subject: Re: [PATCH v1 05/20] perf jevents: Add br metric group for branch
 statistics on Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:17=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > The br metric group for branches itself comprises metric groups for
> > total, taken, conditional, fused and far metric groups using json
> > events. Condtional taken and not taken metrics are specific to Icelake
> > and later generations, so a model to generation look up is added.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 139 +++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 1096accea2aa..bee5da19d19d 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -19,6 +19,7 @@ LoadEvents(directory)
> >
> >  interval_sec =3D Event("duration_time")
> >
> > +
>
> Unnecessary empty line.

Ack. Will fix in v2.

Thanks,
Ian

> Thanks,
> Kan
>
> >  def Idle() -> Metric:
> >    cyc =3D Event("msr/mperf/")
> >    tsc =3D Event("msr/tsc/")
> > @@ -127,11 +128,149 @@ def Tsx() -> Optional[MetricGroup]:
> >      return MetricGroup('transaction', metrics)
> >
> >
> > +def IntelBr():
> > +  ins =3D Event("instructions")
> > +
> > +  def Total() -> MetricGroup:
> > +    br_all =3D Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED=
ANY")
> > +    br_m_all =3D Event("BR_MISP_RETIRED.ALL_BRANCHES",
> > +                     "BR_INST_RETIRED.MISPRED",
> > +                     "BR_MISP_EXEC.ANY")
> > +    br_clr =3D None
> > +    try:
> > +      br_clr =3D Event("BACLEARS.ANY", "BACLEARS.ALL")
> > +    except:
> > +      pass
> > +
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_all, br_all)
> > +    clr_r =3D d_ratio(br_clr, interval_sec) if br_clr else None
> > +
> > +    return MetricGroup("br_total", [
> > +        Metric("br_total_retired",
> > +               "The number of branch instructions retired per second."=
, br_r,
> > +               "insn/s"),
> > +        Metric(
> > +            "br_total_mispred",
> > +            "The number of branch instructions retired, of any type, t=
hat were "
> > +            "not correctly predicted as a percentage of all branch ins=
trucions.",
> > +            misp_r, "100%"),
> > +        Metric("br_total_insn_between_branches",
> > +               "The number of instructions divided by the number of br=
anches.",
> > +               ins_r, "insn"),
> > +        Metric("br_total_insn_fe_resteers",
> > +               "The number of resync branches per second.", clr_r, "re=
q/s"
> > +               ) if clr_r else None
> > +    ])
> > +
> > +  def Taken() -> MetricGroup:
> > +    br_all =3D Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.=
ANY")
> > +    br_m_tk =3D None
> > +    try:
> > +      br_m_tk =3D Event("BR_MISP_RETIRED.NEAR_TAKEN",
> > +                      "BR_MISP_RETIRED.TAKEN_JCC",
> > +                      "BR_INST_RETIRED.MISPRED_TAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_tk, br_all) if br_m_tk else None
> > +    return MetricGroup("br_taken", [
> > +        Metric("br_taken_retired",
> > +               "The number of taken branches that were retired per sec=
ond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_taken_mispred",
> > +            "The number of retired taken branch instructions that were=
 "
> > +            "mispredicted as a percentage of all taken branches.", mis=
p_r,
> > +            "100%") if misp_r else None,
> > +        Metric(
> > +            "br_taken_insn_between_branches",
> > +            "The number of instructions divided by the number of taken=
 branches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  def Conditional() -> Optional[MetricGroup]:
> > +    try:
> > +      br_cond =3D Event("BR_INST_RETIRED.COND",
> > +                      "BR_INST_RETIRED.CONDITIONAL",
> > +                      "BR_INST_RETIRED.TAKEN_JCC")
> > +      br_m_cond =3D Event("BR_MISP_RETIRED.COND",
> > +                        "BR_MISP_RETIRED.CONDITIONAL",
> > +                        "BR_MISP_RETIRED.TAKEN_JCC")
> > +    except:
> > +      return None
> > +
> > +    br_cond_nt =3D None
> > +    br_m_cond_nt =3D None
> > +    try:
> > +      br_cond_nt =3D Event("BR_INST_RETIRED.COND_NTAKEN")
> > +      br_m_cond_nt =3D Event("BR_MISP_RETIRED.COND_NTAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_cond, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond)
> > +    misp_r =3D d_ratio(br_m_cond, br_cond)
> > +    taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional branch instruct=
ions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of co=
nditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired conditional branch instructions mispredicted a=
s a "
> > +               "percentage of all conditional branches.", misp_r, "100=
%"),
> > +    ]
> > +    if not br_m_cond_nt:
> > +      return MetricGroup("br_cond", taken_metrics)
> > +
> > +    br_r =3D d_ratio(br_cond_nt, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond_nt)
> > +    misp_r =3D d_ratio(br_m_cond_nt, br_cond_nt)
> > +
> > +    not_taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional not taken branc=
h instructions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of no=
t taken conditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired not taken conditional branch instructions misp=
redicted as a "
> > +               "percentage of all not taken conditional branches.", mi=
sp_r, "100%"),
> > +    ]
> > +    return MetricGroup("br_cond", [
> > +        MetricGroup("br_cond_nt", not_taken_metrics),
> > +        MetricGroup("br_cond_tkn", taken_metrics),
> > +    ])
> > +
> > +  def Far() -> Optional[MetricGroup]:
> > +    try:
> > +      br_far =3D Event("BR_INST_RETIRED.FAR_BRANCH")
> > +    except:
> > +      return None
> > +
> > +    br_r =3D d_ratio(br_far, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_far)
> > +    return MetricGroup("br_far", [
> > +        Metric("br_far_retired", "Retired far control transfers per se=
cond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_far_insn_between_branches",
> > +            "The number of instructions divided by the number of far b=
ranches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
> > +                     description=3D"breakdown of retired branch instru=
ctions")
> > +
> > +
> >  all_metrics =3D MetricGroup("", [
> >      Idle(),
> >      Rapl(),
> >      Smi(),
> >      Tsx(),
> > +    IntelBr(),
> >  ])
> >
> >  if args.metricgroups:

