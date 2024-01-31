Return-Path: <linux-kernel+bounces-46506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666B8440B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD0292753
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88147D41E;
	Wed, 31 Jan 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hBEjrfOZ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B67D3F2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708126; cv=none; b=MTMHPwUaMfuw8sOiI5sxR+DDedNiIyd8Qg05Yoj7XgyUAzTAvtOKtDy3wAuZBbZT5WWmAevsybzKsZSbCLk2XY5kUOkbARvkJsmBzyiVAsV6TrUB+SDdALcRFrpc8rnME4Qfrk6iIDNefxRgAk0DBzU0UH0S4H/xlFJ9Yqjeh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708126; c=relaxed/simple;
	bh=ydzLkdCnFVzoPB32RrVVo8uHZg97gf4+x7uw+fQjei4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P80PHbvBEqEKCxtqc7t/9nt8VQAbXodcGl743wQElLzvkxYAzfhGKXIAvxbeHFYJvGUyMgy5xs/aY2xUnNxpGygfG/erHlHTI6RZZbAmJ3j+jSGaV7LWfUoFFkZocPc5dnmya9bXjd5bDc13GIB3LQvucDbWIH680jpl6VQP/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBEjrfOZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93b982761so39825ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706708123; x=1707312923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gvo+nk/86/TyM2cTbiYpO1g/G/U4L+hxaJg0S82coo=;
        b=hBEjrfOZyiPgqHSamfg4gbWFDv6hjjHDkPKWkA//gw7eE0xnfQgjMYPX8ARIDusTGk
         XlDitri2w4KN1qRXIikTxP+P34Ao1Xr0ufcEagN0U7xVaQ4180UrJR6qbL1CTX1OSlsf
         N/NkMrQU4JSATZtf4Sy0OUtmuKaMEvh8vpR8hh55ebOh6AV1X/VnebXL1rZB0woc+SNp
         lGLNX6kb+pffrQ52sVgXkLnb6tsrcgO3H6syi1rX45dNl8V0kBemfJzOMaJmJEggeMwl
         UFvj6Rutk2yxZzK5O1fmFO8vypXsbpqCOwQsKFj9GCBlWhtYx+tCXBYYOMmA9+Ddk1Zn
         HcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708123; x=1707312923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gvo+nk/86/TyM2cTbiYpO1g/G/U4L+hxaJg0S82coo=;
        b=PXV3Y9BOAEuuiogZZcgsYDFbHSziTO3ijIl7Hkfymmm7Ll14yqAz0PZfMGXgPkyxqz
         SYF3tsJ9pIPuY/1nAw4S5/JlgTjHqHWPDlBuDVEMYpRNWeEE+BCljbqf8Ezv39nRHxUh
         yUx330PmMIVBmYN+dB0mQLaK3+GXzA2tQVQ12Gx6d2WsrmZWfekCFr2ZRHnPO3xXyzOl
         DjdDSr1mKSr3CqMQ8hDN33cdXyr+/nrvD02Gtqwv5zMExoM/S44vflBAtBBQ7VwzrUvJ
         XQ1lP0gd5BNbEYDKPx7sdQiNa61Nzpo48GPNuBouYxhbGsRlpbIW46LDJZKg67gKOQxQ
         dPMw==
X-Gm-Message-State: AOJu0YxeTTLprgt5V0aISD4PqiM1NcKgT+6d2l98Wvp/aGEG1smD8raA
	oOpa76EgSrKGBsG5uD3NTH37Dt17Mc6+PeRW9aFJDxzSAqI83Tj+KvUzGBcNwsqkzdbqM6k3B9G
	P6tnWfz9T6u487aIsWyDIVM+KQ3BBb2hS6RSw
X-Google-Smtp-Source: AGHT+IHzGTOIPw9NU+VRVoMpGQnQSYFloJTi32mGv8LOCNj1zHIl37h9twrU72XSLcL1QqihGrmcbv2460+rytXDV1c=
X-Received: by 2002:a17:903:d4:b0:1d8:cc74:b11e with SMTP id
 x20-20020a17090300d400b001d8cc74b11emr543640plc.6.1706708123038; Wed, 31 Jan
 2024 05:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131063048.492010-1-irogers@google.com> <20240131063048.492010-2-irogers@google.com>
 <9dd303cb-0455-d8ac-ce0c-f4a8320b787b@arm.com>
In-Reply-To: <9dd303cb-0455-d8ac-ce0c-f4a8320b787b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 05:35:11 -0800
Message-ID: <CAP-5=fX1fPc_GpY0UG0=GgnUrex0tNLfSxEqcJjro=SZdtYB9A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf parse-events: Improve error location of terms
 cloned from an event
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:49=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 31/01/2024 06:30, Ian Rogers wrote:
> > A PMU event/alias will have a set of format terms that replace it when
> > an event is parsed. The location of the terms is their position when
> > parsed for the event/alias either from sysfs or json. This location is
> > of little use when an event fails to parse as the error will be given
> > in terms of the location in the string of events parsed not the json
> > or sysfs string. Fix this by making the cloned terms location that of
> > the event/alias.
> >
> > If a cloned term from an event/alias is invalid the bad format is hard
> > to determine from the error string. Add the name of the bad format
> > into the error string.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > These fixes were inspired by the poor error output in:
> > https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.=
11354@Diego/
> > ---
> >  tools/perf/util/pmu.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 355f813f960d..437386dedd5c 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -657,7 +657,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
> >       return 0;
> >  }
> >
> > -static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_h=
ead *terms)
> > +static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, =
struct list_head *terms)
> >  {
> >       struct parse_events_term *term, *cloned;
> >       struct parse_events_terms clone_terms;
> > @@ -675,6 +675,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *a=
lias, struct list_head *terms
> >                * which we don't want for implicit terms in aliases.
> >                */
> >               cloned->weak =3D true;
> > +             cloned->err_term =3D cloned->err_val =3D err_loc;
> >               list_add_tail(&cloned->list, &clone_terms.terms);
> >       }
> >       list_splice_init(&clone_terms.terms, terms);
> > @@ -1363,8 +1364,8 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
> >
> >                       parse_events_error__handle(err, term->err_val,
> >                               asprintf(&err_str,
> > -                                 "value too big for format, maximum is=
 %llu",
> > -                                 (unsigned long long)max_val) < 0
> > +                                 "value too big for format (%s), maxim=
um is %llu",
> > +                                 format->name, (unsigned long long)max=
_val) < 0
> >                                   ? strdup("value too big for format")
> >                                   : err_str,
> >                                   NULL);
>
> Hi Ian,
>
> I went to test this, but since b30d4f0b6954 ("perf parse-events:
> Additional error reporting") I don't get this size error message
> anymore, just a "bad event/PMU not found" type error. I'm not sure if
> this is something Arm specific, or you're seeing the same thing?
>
> Before b30d4f0b6954:
>
>   $ perf record -e bus_access_rd/long=3D2
>   event syntax error: '..ss_rd/long=3D2/'
>                                   \___ value too big for format, maximum
>                                        is 1
>
>   Initial error:
>   event syntax error: 'bus_access_rd/long=3D2/'
>                      \___ Cannot find PMU `bus_access_rd'. Missing
>                           kernel support?
>   Run 'perf list' for a list of valid events
>
>    Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>     -e, --event <event>   event selector. use 'perf list' to list
>       available events
>
> After b30d4f0b6954:
>
>   $ perf record -e bus_access_rd/long=3D2
>   event syntax error: '..ss_rd/long=3D2/'
>                                   \___ Bad event or PMU
>
>   Unabled to find PMU or event on a PMU of 'bus_access_rd'
>
>   Initial error:
>   event syntax error: 'bus_access_rd/long=3D2/'
>                      \___ Cannot find PMU `bus_access_rd'. Missing
>                           kernel support?
>
>   Run 'perf list' for a list of valid events
>
>    Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>     -e, --event <event>   event selector. use 'perf list' to list
>       available events
>

Hi James, this is a different case. Here you have bus_access_rd being
matched as a wildcard event or PMU. This is done here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.y?h=3Dperf-tools-next#n318
The "long=3D2" is a term to be applied to that event, its index is
passed through from the yacc code and not cloned from the original
sysfs/json event (which this patch modifies). Doing something similar
to your test on x86 I see:

```
$ perf stat -e 'slots/edge=3D2/' true
event syntax error: 'slots/edge=3D2/'
                               \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'slots'

Initial error:
event syntax error: 'slots/edge=3D2/'
                    \___ Cannot find PMU `slots'. Missing kernel support?
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

The string indexes look correct, but in the mail here they look wonky
due to not having a fixed width font. The error message isn't the best
and -vv reveals why:

```
$ perf stat -vv -e 'slots/edge=3D2/' true
Using CPUID GenuineIntel-6-8D-1
Attempt to add: cpu/edge=3D0x2,slots/
.after resolving event: cpu/edge=3D0x2,event=3D0,umask=3D0x4/
Multiple errors dropping message: value too big for format (edge),
maximum is 1 (<no help>)
event syntax error: 'slots/edge=3D2/'
                               \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'slots'

Initial error:
event syntax error: 'slots/edge=3D2/'
                    \___ Cannot find PMU `slots'. Missing kernel support?
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

The dropped help message is the most useful. I've written a patch to
keep all errors in a list and dump them all on failure. I'll send a v2
patch with that added. The output looks like:

```
$ perf stat -e 'slots/edge=3D2/' true
event syntax error: 'slots/edge=3D2/'
                    \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'slots'
event syntax error: 'slots/edge=3D2/'
                               \___ value too big for format (edge),
maximum is 1
event syntax error: 'slots/edge=3D2/'
                    \___ Cannot find PMU `slots'. Missing kernel support?
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

Thanks,
Ian

