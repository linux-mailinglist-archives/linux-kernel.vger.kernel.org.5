Return-Path: <linux-kernel+bounces-87748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EB86D881
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F394B21F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0629409;
	Fri,  1 Mar 2024 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEeQCGDz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB7286AE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254907; cv=none; b=tA//YyfuWOzTD/yeMdfDQoypeAzf2BGBJP7R9SnzXANArQDzVy2d2ewQro76nwNSa2DICJWE2z79wAnCEml3GzO7GfwU3P6/EJFwDWOH5vLUPISijL7LmoL/MQdYt5j8cUorCeHRUxm037vYLFGkziYw0qEKTF02P08QyKrM6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254907; c=relaxed/simple;
	bh=h6CIhB4J9OkofWTtNse/4xKrB3Lc5Lud0M5YwGBjoJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfcDoDm9YvsgzKDCvxiI5s0EaY15MvpkgZ4vTarNO89MOwWsRHnjTi41uNGNn6rR5cmlauPtI7XDDjpFOFryP7hhoY61XweD3bxaJN+yDlHAhYgwVfhXiWBBh+DHjgExFsoYyxU8p04zl87xOaQP7AyL8k0pKrNgSPcdqNWGdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEeQCGDz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc744f54d0so89255ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254905; x=1709859705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAvWq2MgCPw1OiVm8yWhLOauOZunwMIWrFFzUSM0h+g=;
        b=GEeQCGDzEZ/6f7oQC4NvdFlF+1GOAjLgoAXxUoE3gYcyexGGDthLIQgtPWEc+qIeBS
         qTbKkrR8aEZiiuRmjA0/35PT9Cirz4qut0t7+0nwJOn9rutkVgvnz9SewDE6vP8jch8i
         3qsemuoO/qJ1hEn3g0PINzcwVYs89Ifuzz2DUZfOh3gjfi3X9mQpPwQpfn5ToOm+PUtD
         v1osHgWt0yYdZeW3Qc9L1jln5kxFsrt8K+1v6+j4ijMiETeXBnOgQk+DLXhqsenTmY6Q
         EZU6KBozbHNcZfCXcbYoUSyngn6/UOwb2FDpOoDplq5lEDxPionalwhGKS9DLhG0w6Xo
         OpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254905; x=1709859705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAvWq2MgCPw1OiVm8yWhLOauOZunwMIWrFFzUSM0h+g=;
        b=lm14Gs7qV6j+49Pd+FoNyNTr1yQWxnbrjlPDnvLwEnXP7S2DDuVWr0gf76i3aBecG6
         bQxKX7FTqGv50w0aYERgIC0I3f2wB55EF2wZy6S0jexBcCxDU2GX/J7pFPFYX7IgK8q0
         2dNEutqQ1VFN/WDLizw6ruC231+Jy4l+4c/UMyTMzzKZSMVwRCljYivSwb3y6rxw/Zq6
         1EvWfjWpgNCGK2lgAx8hbDJT5HyxabNuwekzjj2CPBNP657IKx7Z0ZrsObpUG7hYFEvC
         CHngUQvElShaetoIw8WzRSyoNl38K3GrJhko+z/8c73pBT6BdO5+UOi4hWA0C06VsUEd
         gM+w==
X-Forwarded-Encrypted: i=1; AJvYcCUX73gAAKV1lXq8U9+lQLSixeYkX1xTKMyXem0NS9PB1mpfqT0Lz0iCM20r+V5PaarbcTwziyjhAsSn6CvoQq9/93Oz02wcSAEBp9Fx
X-Gm-Message-State: AOJu0YyZxrr+NeVz7DA79IQmdRVpe18ypkTqFm3XVurFk6gBPEqNs5Wi
	wyHnbxKeWTeqoe+OTTN8mHvdajtzdrcE52HX8jA7NzYLDGB4SaZwy3zz9Lv4zID8+ymuLAdRFja
	ppGR27UadMLKKr6mtGQGNiVj2IwBrNhMT7OmZ
X-Google-Smtp-Source: AGHT+IFuovX+mPlo8GuYumhX5KhN8lmMUKMildylEVjPA9GQCg+diuk0IrgLOJCnPmSt0jj8WcLgKXB1VMpgtF4Vdcc=
X-Received: by 2002:a17:903:22c4:b0:1dc:a82e:23b4 with SMTP id
 y4-20020a17090322c400b001dca82e23b4mr89703plg.8.1709254905137; Thu, 29 Feb
 2024 17:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-5-irogers@google.com>
 <7aa2d2a2-b8f9-478f-9699-7b717d38a8ab@linux.intel.com>
In-Reply-To: <7aa2d2a2-b8f9-478f-9699-7b717d38a8ab@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 17:01:34 -0800
Message-ID: <CAP-5=fWSidi1zjwn8Zr93dAQvRBtngKrkVwDxorTMmVSVc9FWg@mail.gmail.com>
Subject: Re: [PATCH v1 04/20] perf jevents: Add tsx metric group for Intel models
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

On Thu, Feb 29, 2024 at 1:15=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > Allow duplicated metric to be dropped from json files.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 20c25d142f24..1096accea2aa 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -7,6 +7,7 @@ import argparse
> >  import json
> >  import math
> >  import os
> > +from typing import Optional
> >
> >  parser =3D argparse.ArgumentParser(description=3D"Intel perf json gene=
rator")
> >  parser.add_argument("-metricgroups", help=3D"Generate metricgroups dat=
a", action=3D'store_true')
> > @@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
> >      ])
> >
> >
> > +def Tsx() -> Optional[MetricGroup]:
> > +    if args.model not in [
> > +        'alderlake',
> > +        'cascadelakex',
> > +        'icelake',
> > +        'icelakex',
> > +        'rocketlake',
> > +        'sapphirerapids',
> > +        'skylake',
> > +        'skylakex',
> > +        'tigerlake',> +    ]:
>
> Can we get ride of the model list? Otherwise, we have to keep updating
> the list.

Do we expect the list to update? :-) The issue is the events are in
sysfs and not the json. If we added the tsx events to json then this
list wouldn't be necessary, but it also would mean the events would be
present in "perf list" even when TSX is disabled.

> > +        return None
> > +> +    pmu =3D "cpu_core" if args.model =3D=3D "alderlake" else "cpu"
>
> Is it possible to change the check to the existence of the "cpu" PMU
> here? has_pmu("cpu") ? "cpu" : "cpu_core"

The "Unit" on "cpu" events in json always just blank. On hybrid it is
either "cpu_core" or "cpu_atom", so I can make this something like:

pmu =3D "cpu_core" if metrics.HasPmu("cpu_core") else "cpu"

which would be a build time test.


> > +    cycles =3D Event('cycles')
> > +    cycles_in_tx =3D Event(f'{pmu}/cycles\-t/')
> > +    transaction_start =3D Event(f'{pmu}/tx\-start/')
> > +    cycles_in_tx_cp =3D Event(f'{pmu}/cycles\-ct/')
> > +    metrics =3D [
> > +        Metric('tsx_transactional_cycles',
> > +                      'Percentage of cycles within a transaction regio=
n.',
> > +                      Select(cycles_in_tx / cycles, has_event(cycles_i=
n_tx), 0),
> > +                      '100%'),
> > +        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted =
transactions.',
> > +                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / =
cycles,
> > +                                    has_event(cycles_in_tx),
> > +                                    0),
> > +                      '100%'),
> > +        Metric('tsx_cycles_per_transaction',
> > +                      'Number of cycles within a transaction divided b=
y the number of transactions.',
> > +                      Select(cycles_in_tx / transaction_start,
> > +                                    has_event(cycles_in_tx),
> > +                                    0),
> > +                      "cycles / transaction"),
> > +    ]
> > +    if args.model !=3D 'sapphirerapids':
>
> Add the "tsx_cycles_per_elision" metric only if
> has_event(f'{pmu}/el\-start/')?

It's a sysfs event, so this wouldn't work :-(

Thanks,
Ian

> Thanks,
> Kan
>
> > +        elision_start =3D Event(f'{pmu}/el\-start/')
> > +        metrics +=3D [
> > +            Metric('tsx_cycles_per_elision',
> > +                          'Number of cycles within a transaction divid=
ed by the number of elisions.',
> > +                          Select(cycles_in_tx / elision_start,
> > +                                        has_event(elision_start),
> > +                                        0),
> > +                          "cycles / elision"),
> > +        ]
> > +    return MetricGroup('transaction', metrics)
> > +
> > +
> >  all_metrics =3D MetricGroup("", [
> >      Idle(),
> >      Rapl(),
> >      Smi(),
> > +    Tsx(),
> >  ])
> >
> >  if args.metricgroups:

