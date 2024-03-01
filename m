Return-Path: <linux-kernel+bounces-87747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156C86D87C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F251F22145
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E921118E;
	Fri,  1 Mar 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgBYQMSY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3502FB6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254460; cv=none; b=kU8DV9+r2cchw9eLr0aMuzVKfJJ4uNQAeTAZvWEgTsuvsslCjwx6QGkTcjn3pzxNZlO7oUWIzRCKmyepKEKMkYOoDTXrqW2fKK5uQZDeSf4VtZyWmZ9bvxCI/miXKFGwjnPt6ZlqMwQS1TNGDk1sy10iNE2Man0VhECDpqQ3T4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254460; c=relaxed/simple;
	bh=+upbwOwPoo8Bow3xcmEk27AbSn6dIIFXUaLfgqKiY/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJoatFvgMpVT7hyKql8d9KJd1iI7kH/gF87zZyMjIYNIr1ugIWLIacOOo0bLMxXy2UXRaJ+RQ/SVhU4D2g/A6kEKQyCDWzv8Ct38aALPzf3QgRo/IKNdXbu2GNyU5J5Yhg4+H5pDgL5AWH04uagh78OGT4/fw/qJ8a8Qokk0uDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgBYQMSY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcd07252d9so30155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254459; x=1709859259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tftcmnntcbV6/bHuFB1XAMaQpSPTXIzs4LXNnedmduY=;
        b=VgBYQMSY5Iy0x/UJxcFmOIayQwdMGQlkDwa3jW4S+USEWN4VPpWwfK9hja0HifFyza
         S9sguXdTMVubsynec15nZTUEMpW6IdLBx+nfeh90QN2O1KAQ9BPTLlKTKq5qjQi1ukDw
         MKd+hzSGM2jcMZTX69jCqui8Zrp3leUrM2u4K54ZgEyYiJPL7eShnRL1knrHklddQRLR
         V9CjqzFQN1swu9PDMn0BQp01JbtIzDoPwmBsiXNJqZFjovKkM4pdPCRwJ9LksB2ENDhT
         ErMPRzfmLmBxSvqP0KZNcpbN/US87jDIoOd9cwIjqNu16I3WycZ6FryvxmAAeplWlW/o
         mS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254459; x=1709859259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tftcmnntcbV6/bHuFB1XAMaQpSPTXIzs4LXNnedmduY=;
        b=mXO5x6YpXbnd1FKehkl76mLVGvpd6dtWBOOyaxaIQayDD0sYuXOPRa1adjw6ZhVd7b
         16nVPSZTMUb+QzC3K4+DARsXEFUJ6PK1Vlw5YPuEGyDmiPcw7i2laklkTf3qmoiJ9Kau
         pjclULKpnMOw0Dh2QV3TbAtaOQXV6BFdZHyjz1RvXiKdX9RwlJKbsM29S4Jw4VXzdfzD
         ONr4t8Xf2ylkZS0L+wJBta4FnUp96l58oSn+tIzUll0+Dvr2yDo0/DCdJEoGzxRDEuxP
         MQuyALFJFqIU+wL3ByhcRZJUMSs89MlvUKNM21VrJYJr3KDcX9aIacko5uQFNpcPPWqy
         YSQA==
X-Forwarded-Encrypted: i=1; AJvYcCXkzlUAljg/RMGBb+3X59VDKxiA1MIKJOolXsUq8LIT7n63IOnAQ5aqFsG+nJ2WsROmt7AhMgw3Dg37oHEg2CO3aqBcnXpgicLD3hkL
X-Gm-Message-State: AOJu0YzEF0Y7/M1xgrjUpwryzdlMNLMVfjE4VCuRWw42KfVIvdtBifn3
	n+TOHn/GDGespdmeNNqRv6W/4BKzMvlRoYmeGSH9S8Mdsg+0Cz0UnPOd3sP8voFj7z+VObij3wt
	u5HHEjjwki663lSG4cf5X5rWMr+vjykYZb1we
X-Google-Smtp-Source: AGHT+IECU1x2BlbA5ofq5tnUe2Wmr0p7lJq3QWNqZvPo8O/3HTA97WarwKjKD2N0k3teyJKqYgROeT781/NiT3MJLiY=
X-Received: by 2002:a17:902:e74a:b0:1dc:2f51:b120 with SMTP id
 p10-20020a170902e74a00b001dc2f51b120mr87629plf.14.1709254458494; Thu, 29 Feb
 2024 16:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-4-irogers@google.com>
 <f2e34072-542a-4055-b8fd-20171e6783a1@linux.intel.com>
In-Reply-To: <f2e34072-542a-4055-b8fd-20171e6783a1@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 16:54:07 -0800
Message-ID: <CAP-5=fVzb4rnS1Ckx96wE=K-69_cosxqsbU2BBX0AXShs1iqYA@mail.gmail.com>
Subject: Re: [PATCH v1 03/20] perf jevents: Add smi metric group for Intel models
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

On Thu, Feb 29, 2024 at 1:09=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > Allow duplicated metric to be dropped from json files.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 46866a25b166..20c25d142f24 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -2,7 +2,7 @@
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> >                      JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> > -                    MetricGroup, Select)
> > +                    MetricGroup, MetricRef, Select)
> >  import argparse
> >  import json
> >  import math
> > @@ -62,9 +62,25 @@ def Rapl() -> MetricGroup:
> >                       description=3D"Processor socket power consumption=
 estimates")
> >
> >
> > +def Smi() -> MetricGroup:
> > +    aperf =3D Event('msr/aperf/')
>
> There are CPUID enumeration for the aperf and mperf. I believe they
> should be always available for a newer bare metal. But they may not be
> enumerated in an virtualization env. Should we add a has_event() check
> before using it?

It would make sense to have the has_event so that the metric doesn't
fail in perf test. I'll add it.

Thanks,
Ian

> Thanks,
> Kan
>
> > +    cycles =3D Event('cycles')
> > +    smi_num =3D Event('msr/smi/')
> > +    smi_cycles =3D Select((aperf - cycles) / aperf, smi_num > 0, 0)
> > +    return MetricGroup('smi', [
> > +        Metric('smi_num', 'Number of SMI interrupts.',
> > +               smi_num, 'SMI#'),
> > +        # Note, the smi_cycles "Event" is really a reference to the me=
tric.
> > +        Metric('smi_cycles',
> > +               'Percentage of cycles spent in System Management Interr=
upts.',
> > +               smi_cycles, '100%', threshold=3D(MetricRef('smi_cycles'=
) > 0.10))
> > +    ])
> > +
> > +
> >  all_metrics =3D MetricGroup("", [
> >      Idle(),
> >      Rapl(),
> > +    Smi(),
> >  ])
> >
> >  if args.metricgroups:

