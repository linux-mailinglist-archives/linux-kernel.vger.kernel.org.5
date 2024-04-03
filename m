Return-Path: <linux-kernel+bounces-130546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF538979C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED10E1C21811
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6E155A56;
	Wed,  3 Apr 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3+AZuqj"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2B1552E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176012; cv=none; b=MPlhoVTyjE6Zvdy6UE9qb7fNGn9dTndtXkucsy/fe6cgY+i3ioBD462H44yE0F9eAK8z5pP5KZ35V2aDPQm/PR7gqyhye6niA6Z/MkZI71fZlW5K8Vrs2YlVuw+fEh8sYxaO4IvPY/0nU4xPbqD44h1MA90a8Tlw0lqhCUidcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176012; c=relaxed/simple;
	bh=FBpLE1iiZfLzq2PgZFZDfGl4fcVL4tEXMWlXr8qXDs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji8zi5hjjJFlP1WrrtOXIceXAr62sYFeEJEsPATDs8tf02CJ+Q/4tyOMWKUldlIuri5SuitXgyQr537zexujcvyC89cAhXqVNhlPwCG+8wrPR8fOkkvCvV7d0yoryIe8J62341yoQvSfvm7xDRbvLEcUiHmJVNu/tiXSoXkT6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3+AZuqj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e277154d4cso11265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712176010; x=1712780810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFhYmzmWZcVM7eK0cRz8FdXnZiXwCUMIE3os1iAStEY=;
        b=E3+AZuqjXjd+FxKgjzE7dLxLq19QVZJzlwKjQmR8RSrEjA51KQJH9KCkpZmHwK6Arj
         fQKOS9CCTTfHRTlhkNeYcnYpbsP1LQIoIBdC8rkp+YLVbRKiCskkGrhDT99F0m0s0zn2
         eMJQtbmrnyKE4O1EnhlCjHbycJuSCty+XHGIcMd782/DWQzMGOHPKiBJjPzCf6+hEuzm
         B/P1TTf9m9d83ht4HDLVepUjIvwFCQfRjg0wJG11jUFBYtH/k+izLbyJpX57JlJF3ftp
         A7HWnL5V481+Rbcp+rBwIO1K8pIZWyoV2CVqlM/EQdJxbeL1mtEjeted+k39G7fV+OFb
         /s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176010; x=1712780810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFhYmzmWZcVM7eK0cRz8FdXnZiXwCUMIE3os1iAStEY=;
        b=Q+BqoV6gmBCZT5pMjEOq5wNjNsGcbusyU0qXjWt5XXebxti8XPPbHYeQtmZvvhjfyQ
         dlJ7riGzKzn7hMKXU08McasRSCGNCSpGst3btEQyDjurTbiuIaFLJ5yQKGVbIJofhbuz
         FGxgZJCpXxMbL6lYCqWdx7FhyQzIA9ZcoEMY4LG0ARqOoVBndar94148vKw9e2sZX7G9
         CHFIcn4J8ESnh00kJjJlz6uTsuIosFGrDiJnYOvrphJlDSSHVZzcwK6N0BlG09waa+0G
         BJgScZk5v8jv29Wv3QUhJ0YFs2nzC5VJc6rke+59UNuppN8Eyr19dbuNppD6BO/NimOv
         CgIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoYxGg1MGvUpWDKFTRR2WY5jBhx2Txwur5i4+WaBHk/EdoHYvITNnVDsqcEBR3bjNdUBfAmHLejw3TkWSEJqaxG8A7fHmCdiPqMa51
X-Gm-Message-State: AOJu0YwxaJ0KWqBuXPlyswK8Ogjl2JolQjdL6DRpZIdlbcwygUTHBsxK
	+tBtNE1w+HTXiHd5VIkliU1Dn0diilzO1c16rV55AVnvcKp/E4Z1rnZ9H2kDulzfXC0reKErqNC
	WJI3jM+fddNi6XtIDHn/DknZjsxxUy+CPqm1O
X-Google-Smtp-Source: AGHT+IGlZVVWRSaRx9yR2KM9XZ42+4Oxvf7icoyilN7Z97fSwtU7BQZQKwk9L6EJWgf9mQnTLuf4q02X3qebqJ4culY=
X-Received: by 2002:a17:902:c405:b0:1e2:1955:1b1c with SMTP id
 k5-20020a170902c40500b001e219551b1cmr303929plk.27.1712176010154; Wed, 03 Apr
 2024 13:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164636.3429091-1-irogers@google.com> <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
 <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com> <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com>
In-Reply-To: <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 13:26:35 -0700
Message-ID: <CAP-5=fX+YuEgD4pF-2YRcqgD2cwLw_7Z4ak+wszctvagPS+Xbw@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:57=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-03 2:31 p.m., Ian Rogers wrote:
> > On Wed, Apr 3, 2024 at 10:59=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
> >>> Rather than place metrics without a metric group in "No_group" place
> >>> them in a a metric group that is their name. Still allow such metrics
> >>> to be selected if "No_group" is passed, this change just impacts perf
> >>> list.
> >>
> >> So it looks like the "No_group" is not completely removed.
> >> They are just not seen in the perf list, but users can still use it vi=
a
> >> perf stat -M No_group, right?
> >>
> >> If so, why we want to remove it from perf list? Where can the end user
> >> know which metrics are included in the No_group?
> >>
> >> If the No_group is useless, why not completely remove it?
> >
> > Agreed. For command line argument deprecation we usually keep the
> > option but hide it from help with PARSE_OPT_HIDDEN, so I was trying to
> > follow that pattern albeit that a metric group isn't a command line
> > option it's an option to an option.
> >
>
> Perf list has a deprecated option to show the deprecated events.
> The "No_group" should be a deprecated metrics group.
>
> If so, to follow the same pattern, I think perf list should still
> display the "No_group" with the --deprecated option at least.

Such metrics would be shown twice, once under No_group and once under
a metric group of their name. With deprecated events this isn't the
case, you can only see them with --deprecated. Given we can see the
metric without the No_group grouping, what is being added by having a
No_group grouping? It feels entirely redundant and something we don't
need to advertise.

Thanks,
Ian

> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/metricgroup.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> >>> index 79ef6095ab28..6ec083af14a1 100644
> >>> --- a/tools/perf/util/metricgroup.c
> >>> +++ b/tools/perf/util/metricgroup.c
> >>> @@ -455,7 +455,7 @@ static int metricgroup__add_to_mep_groups(const s=
truct pmu_metric *pm,
> >>>       const char *g;
> >>>       char *omg, *mg;
> >>>
> >>> -     mg =3D strdup(pm->metric_group ?: "No_group");
> >>> +     mg =3D strdup(pm->metric_group ?: pm->metric_name);
> >>>       if (!mg)
> >>>               return -ENOMEM;
> >>>       omg =3D mg;
> >>> @@ -466,7 +466,7 @@ static int metricgroup__add_to_mep_groups(const s=
truct pmu_metric *pm,
> >>>               if (strlen(g))
> >>>                       me =3D mep_lookup(groups, g, pm->metric_name);
> >>>               else
> >>> -                     me =3D mep_lookup(groups, "No_group", pm->metri=
c_name);
> >>> +                     me =3D mep_lookup(groups, pm->metric_name, pm->=
metric_name);
> >>>
> >>>               if (me) {
> >>>                       me->metric_desc =3D pm->desc;

