Return-Path: <linux-kernel+bounces-87750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C47A86D883
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2508B21E23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E32AE90;
	Fri,  1 Mar 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHsQa3yS"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4972B9B9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254936; cv=none; b=M+t6ZcFHjAg/6XsUKVcTPT6SPMBMRZK4SsZhfqaN1O4RW5NBOrx6Na3lyPK0i1N88Tgr2v35JDOaLAVpgz4O9jJuRpXzUaTHSEJIVlRv3IWcQALVVFFuV4vRTi71kZRMB3MmqJaU/1TDv+Ynf2ZBKWgaCshcutuWSqetRrXH/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254936; c=relaxed/simple;
	bh=avbb1uT+lCjqlR3Vtb4dKd8TAjjBeVnovcFFYaHg+Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca6UJTNi6kB++8AjdSvrXJlN1c0pBgGIrRa/5lEX9QmrOAn+ULq9PgkUmx+Lhl3YMeHEhfVE1LkcZ1oFeq0ymj4DiJ9cw9IaOwbKI39Qdgw3S9fx7Vk/aQ3vT4ULhXkcdgeJWHl1y12gDfDpdZ6yYYS22zE3D4x03VUHl0qMXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHsQa3yS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ec9eb9aefso19321cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254933; x=1709859733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGi+DBKLmbpkuw51xKZeEFOZatSTb67qGD3fLAFzMHI=;
        b=BHsQa3ySKVupdcmCfEllblcdn5na7vKShmpnZ6j41xZWlwM7REbTOlPzuKZv6AlxIK
         x3801S8uXkoJ/a6DKYhTCG4+NMnyR+2dqUul6we4oRJ341Qjm8b29kQ9b1Ol8UYo0/Z2
         b7vej3T4Hs3X+zKxVJ/GViLG6A2JbB3dx1X6kNwdNrrgeAOCGN25FKuReTNJSyN14NuO
         bw6pe/D8eeqCMsLomyxu/BHcU9rCS2WiB+rRvskzyiHCfBy5SadVe3sRJxoP0xTL9ZTz
         yjQGXBKj5NZzREFeXisEUtE+ObbGcvW9+qEOy+VmZISSm14JHBlm/UijpC5nzSw20B5s
         Pp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254933; x=1709859733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGi+DBKLmbpkuw51xKZeEFOZatSTb67qGD3fLAFzMHI=;
        b=l2ASQ4cg4KrDOW98SyJ++3nl+HYT9mLvbDMMtIh8KdS+QgAE+MkH1FG7HkijOvE/jV
         s/oGDGtHkkSpMPWRnB2ae/3BbHnSB2GkCuawMPNPbh68HAa0CG0vaapQxW24Gvr9+YxT
         cNsQk4o3M/R4kS6HNgv7y6LUk4LUXQXYRFlzOKVxLoJWIVdgw6Ct1OZ6vWp1I5sdM0Jy
         mWApHvJrEzwn1WlJSRxGa+2mXPrl2UH6VsQVN8arVcvMgMkRQQfSzsF8bCLNi4mWfD4N
         zceEaGfXqPV8GvgRfbNIcttLzxNgXUcf9awIdb7O2dkYmYS/TtPtZo0V9MSRbTfuWvRY
         kdrA==
X-Forwarded-Encrypted: i=1; AJvYcCWqSNbpJKisXAIPhU6SS13igxOOe4K3ej+AgnJDLbPF45sFy6roA9wlfAUuJD3rVU5WBzHWj4LopbPKJpND+S2zXLLvLh/sgSIbWgqS
X-Gm-Message-State: AOJu0YxjsVUZ+Gg68aBHT1jxtbRwbedbcEAOqTS/If+k3xGsV0aIw68K
	IQYd0cemYGAheXloKLLGrpMAr+wjzKBfIQzMGh/D5N/im367Ke2z0NbhTbhR5MeSftlqBufEqYf
	za95/djJoEbcRJxGkZ0gv+CeT8lu0N/rtG3Lo
X-Google-Smtp-Source: AGHT+IGRK89OBpbXk7bzbVc4mw4dYz52ilhFfZmJAOg4fNKvO87Hz3ISEC3H2Po9mvjiBxmijdH1rJzihju5eaeea5g=
X-Received: by 2002:a05:622a:188c:b0:42e:4f31:c488 with SMTP id
 v12-20020a05622a188c00b0042e4f31c488mr100939qtc.20.1709254933185; Thu, 29 Feb
 2024 17:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-2-irogers@google.com>
 <28bc7ea0-ff3e-48a5-a8b3-20cc52728a5f@linux.intel.com>
In-Reply-To: <28bc7ea0-ff3e-48a5-a8b3-20cc52728a5f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 17:02:02 -0800
Message-ID: <CAP-5=fVQD91HjfhJ+iX_nhMUJX91ZgJ_havGg=Ya+dMZ67C4yQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/20] perf jevents: Add RAPL metrics for all Intel models
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

On Thu, Feb 29, 2024 at 12:59=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > Add a 'cpu_power' metric group that computes the power consumption
> > from RAPL events if they are present.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
> >  1 file changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 4fbb31c9eccd..5827f555005f 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -1,9 +1,10 @@
> >  #!/usr/bin/env python3
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescription=
s, LoadEvents,
> > -                    MetricGroup)
> > +from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonE=
ncodeMetricGroupDescriptions,
> > +                    LoadEvents, Metric, MetricGroup, Select)
> >  import argparse
> >  import json
> > +import math
> >  import os
> >
> >  parser =3D argparse.ArgumentParser(description=3D"Intel perf json gene=
rator")
> > @@ -14,7 +15,45 @@ args =3D parser.parse_args()
> >  directory =3D f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86=
/{args.model}/"
> >  LoadEvents(directory)
> >
> > -all_metrics =3D MetricGroup("",[])
> > +interval_sec =3D Event("duration_time")
> > +
> > +def Rapl() -> MetricGroup:
> > +  """Processor socket power consumption estimate.
> > +
> > +  Use events from the running average power limit (RAPL) driver.
> > +  """
> > +  # Watts =3D joules/second
> > +  pkg =3D Event("power/energy\-pkg/")
> > +  cond_pkg =3D Select(pkg, has_event(pkg), math.nan)
> > +  cores =3D Event("power/energy\-cores/")
> > +  cond_cores =3D Select(cores, has_event(cores), math.nan)
> > +  ram =3D Event("power/energy\-ram/")
> > +  cond_ram =3D Select(ram, has_event(ram), math.nan)
> > +  gpu =3D Event("power/energy\-gpu/")
> > +  cond_gpu =3D Select(gpu, has_event(gpu), math.nan)
> > +  psys =3D Event("power/energy\-psys/")
> > +  cond_psys =3D Select(psys, has_event(psys), math.nan)
> > +  scale =3D 2.3283064365386962890625e-10
> > +  metrics =3D [
> > +      Metric("cpu_power_pkg", "",
> > +             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
> > +      Metric("cpu_power_cores", "",
> > +             d_ratio(cond_cores * scale, interval_sec), "Watts"),
> > +      Metric("cpu_power_ram", "",
> > +             d_ratio(cond_ram * scale, interval_sec), "Watts"),
> > +      Metric("cpu_power_gpu", "",
> > +             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
> > +      Metric("cpu_power_psys", "",
> > +             d_ratio(cond_psys * scale, interval_sec), "Watts"),
> > +  ]
> > +
> > +  return MetricGroup("cpu_power", metrics,
> > +                     description=3D"Processor socket power consumption=
 estimates")
>
> As far as I know, the RAPL counters are to monitor energy consumption
> across different domains. The scope may not always be a socket. I think
> the description may brings confusions.
> Maybe we just call it "RAPL power consumption estimates", or "Running
> Average Power Limit (RAPL) power consumption estimates".

Ack. Will fix in v2.

Thanks,
Ian

> Thanks,
> Kan
> > +
> > +
> > +all_metrics =3D MetricGroup("", [
> > +    Rapl(),
> > +])
> >
> >  if args.metricgroups:
> >    print(JsonEncodeMetricGroupDescriptions(all_metrics))

