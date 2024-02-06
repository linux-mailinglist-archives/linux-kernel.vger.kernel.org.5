Return-Path: <linux-kernel+bounces-54196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA94284AC20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D0A1C23122
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE356B73;
	Tue,  6 Feb 2024 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ak2B+YmH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662C56B61
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186076; cv=none; b=rhSyvPz7Y5Yj5Jx9HI+rI0Ut8ybPhxnwHP0o3Vykph0PedPkVNAEIViH6Bs+mjlCdxFvrmn8KxomBra+zIvg9vxb44AiISr8eK6tnegWeEKGanyQOfUzRHqDh0buQuFjPfgEyMEUamdVf2s/1+4+/f8BgnF89aHTCLjCobRBOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186076; c=relaxed/simple;
	bh=DxnQTilcs1frMDhQEAdkQa2L2CZaUmwfBE+sReQ2Dqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wte7OI/60wa/VrGRSrIWa1jFKGGWQDoZYThB84/pSMTL7fDOCHergKTOHsT2q76DjVZxLZ9yMXgcuiGYZu3+PYL/k7FxbS7ETXHGwLUxl0q3Z9TVIzlJxmk9/Lb/CWIOOVkKWaYdUb5jfG1Yq6xKWIq4e4KyhfGcC9fgnrgWwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ak2B+YmH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d9daf74f41so14965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707186074; x=1707790874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXrRAW8vvaakZvPZQQxowEWbRXWQ7xa7h/19RmdI5Cc=;
        b=ak2B+YmH1DbT+aaG7UYxbDrDvoLuAMI+ji5wJgyMilCvEOY7UPs6nqm+4Y46MZsWmM
         jFWDE6RvZd90PSmUcoKbau5XpS73gAgsgfZ2JPw6O+ALttQVibz/pzbD300ZaCJxQREq
         n9QZNX+NGi7wPNE9VUcXRU7pB29JaEOhg4Nj+Jm4huxFac470ZjHE0b2kvXp2rQVP7Jp
         X5O4hdoEKNt1SqYul7YPVMO/u2yXJScbGCwp32CxefR4Jyxbvwr5Uk4LAlIce49o8BGN
         eOXmQqMRGCxwb39DOCixv619u7LKX2xkwpmbDUbJQzSCOU7shfEp6P2qUx70K9rT7HYu
         yY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186074; x=1707790874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXrRAW8vvaakZvPZQQxowEWbRXWQ7xa7h/19RmdI5Cc=;
        b=VkY8gLHGHhPg3yNkplpfblAEeh5p3tTd5r+jHWHi0o/4GCXkgYuIp4dSYiPjKZfh7E
         l4DTdDSnKAZrXExfUMVO5Ud/aJf55N0/O2BR382EDswl4aH8ZOG0NFmpupHsov+3Ykum
         2WNqM5TulXEEvZb5l8qs0JnzzJy4sLAoysdfFj3z8jy1FTR2nYHzCSBt0Kosc3F3oHGW
         vVNiwZ3MrtyPSGIBNSpmCCw75nTrzy7NGHCZBjLanwjouBFof+LeSqjbl+2VwZoN/0Uc
         z+iXULclxj2P4ktt00RvgXfIXuW+HXu25G1qRyMST8PXjIp6uLFIE1gm4+iZR5hr1bSG
         n0VQ==
X-Gm-Message-State: AOJu0Yy3uTp3UMZWbi517PzFzBKnBsUL1p7tuK6AG+5RIzRFN8zAtG+v
	aYmX5Bd+6Q/OcjdtxXF/Va/U4nnGhZMBE3WudMN7qTKK9qcFqJOWuDtOZ+zhnPgLL95TULFM54z
	m6VGA8zZRGKFG+Es+gN6PMeLy3upOXZL3YaPg
X-Google-Smtp-Source: AGHT+IHFymfV2ud5X4sz138eYjRHmqyWpO+aaL/wS276ngJV2iqLJAnNZU1LskdGk+gP6go/aRv4xuC+OwO9msrdBNA=
X-Received: by 2002:a17:902:fd10:b0:1d7:7e3c:59ce with SMTP id
 mp16-20020a170902fd1000b001d77e3c59cemr88444plb.29.1707186074029; Mon, 05 Feb
 2024 18:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com> <20240202022512.467636-2-irogers@google.com>
 <CAM9d7cgv3zPNohz6eWwH7qaQyY0QMRK_sqtJdumeGrD5tMW9Yg@mail.gmail.com>
In-Reply-To: <CAM9d7cgv3zPNohz6eWwH7qaQyY0QMRK_sqtJdumeGrD5tMW9Yg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Feb 2024 18:21:02 -0800
Message-ID: <CAP-5=fUThAUD6yJ+iDBbKvw4mFWbN3-j=bcBHwu-aY3_tMnQnQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf metrics: Compute unmerged uncore metrics individually
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Feb 1, 2024 at 6:25=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > When merging counts from multiple uncore PMUs the metric is only
> > computed for the metric leader. When merging/aggregation is disabled,
> > prior to this patch just the leader's metric would be computed. Fix
> > this by computing the metric for each PMU.
> >
> > On a SkylakeX:
> > Before:
> > ```
> > $ perf stat -A -M memory_bandwidth_total -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0               82,217      UNC_M_CAS_COUNT.RD [uncore_imc_0] #     =
 9.2 MB/s  memory_bandwidth_total
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU0               61,395      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> > CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
> > CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> > CPU0               81,570      UNC_M_CAS_COUNT.RD [uncore_imc_2]
> > CPU18             113,886      UNC_M_CAS_COUNT.RD [uncore_imc_2]
> > CPU0               62,330      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> > CPU18              66,942      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> > CPU0               75,489      UNC_M_CAS_COUNT.RD [uncore_imc_3]
> > CPU18              27,958      UNC_M_CAS_COUNT.RD [uncore_imc_3]
> > CPU0               55,864      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> > CPU18              38,727      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> > CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
> > CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> > CPU0               75,423      UNC_M_CAS_COUNT.RD [uncore_imc_5]
> > CPU18             104,527      UNC_M_CAS_COUNT.RD [uncore_imc_5]
> > CPU0               57,596      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> > CPU18              56,777      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> > CPU0        1,003,440,851 ns   duration_time
> >
> >        1.003440851 seconds time elapsed
> > ```
> >
> > After:
> > ```
> > $ perf stat -A -M memory_bandwidth_total -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0               88,968      UNC_M_CAS_COUNT.RD [uncore_imc_0] #     =
 9.5 MB/s  memory_bandwidth_total
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU0               59,498      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> > CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> > CPU0               88,635      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     =
 9.5 MB/s  memory_bandwidth_total
> > CPU18             117,975      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     =
11.5 MB/s  memory_bandwidth_total
> > CPU0               60,829      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> > CPU18              62,105      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> > CPU0               82,238      UNC_M_CAS_COUNT.RD [uncore_imc_3] #     =
 8.7 MB/s  memory_bandwidth_total
> > CPU18              22,906      UNC_M_CAS_COUNT.RD [uncore_imc_3] #     =
 3.6 MB/s  memory_bandwidth_total
> > CPU0               53,959      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> > CPU18              32,990      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> > CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #     =
 0.0 MB/s  memory_bandwidth_total
> > CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> > CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> > CPU0               83,595      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     =
 8.9 MB/s  memory_bandwidth_total
> > CPU18             110,151      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     =
10.5 MB/s  memory_bandwidth_total
> > CPU0               56,540      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> > CPU18              53,816      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> > CPU0        1,003,353,416 ns   duration_time
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c |  2 ++
> >  tools/perf/util/stat-shadow.c | 31 +++++++++++++++++++++++++++----
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index ca3e0404f187..c33ffee837ca 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -44,6 +44,8 @@ struct metric_event *metricgroup__lookup(struct rblis=
t *metric_events,
> >         if (!metric_events)
> >                 return NULL;
> >
> > +       if (evsel->metric_leader)
> > +               me.evsel =3D evsel->metric_leader;
> >         nd =3D rblist__find(metric_events, &me);
> >         if (nd)
> >                 return container_of(nd, struct metric_event, nd);
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index f6c9d2f98835..1be23b0eee2f 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -356,6 +356,7 @@ static void print_nsecs(struct perf_stat_config *co=
nfig,
> >  }
> >
> >  static int prepare_metric(const struct metric_expr *mexp,
> > +                         const struct evsel *evsel,
> >                           struct expr_parse_ctx *pctx,
> >                           int aggr_idx)
> >  {
> > @@ -398,8 +399,29 @@ static int prepare_metric(const struct metric_expr=
 *mexp,
> >                         source_count =3D 1;
> >                 } else {
> >                         struct perf_stat_evsel *ps =3D mexp->metric_eve=
nts[i]->stats;
> > -                       struct perf_stat_aggr *aggr =3D &ps->aggr[aggr_=
idx];
> > +                       struct perf_stat_aggr *aggr;
> >
> > +                       /*
> > +                        * If there are multiple uncore PMUs and we're =
not
> > +                        * reading the leader's stats, determine the st=
ats for
> > +                        * the appropriate uncore PMU.
> > +                        */
> > +                       if (evsel && evsel->metric_leader &&
> > +                           evsel->pmu !=3D evsel->metric_leader->pmu &=
&
> > +                           mexp->metric_events[i]->pmu =3D=3D evsel->m=
etric_leader->pmu) {
>
> Is it just to check we're in --no-aggr (or --no-merge)?
> Then it'd be simpler to use stat_config->aggr_mode.

For most metrics the events will be on the same PMU, but there is
nothing stopping mixing events from different PMUs (grouping can be
disabled). There may also be software and tool evsels.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                               struct evsel *pos;
> > +
> > +                               evlist__for_each_entry(evsel->evlist, p=
os) {
> > +                                       if (pos->pmu !=3D evsel->pmu)
> > +                                               continue;
> > +                                       if (pos->metric_leader !=3D mex=
p->metric_events[i])
> > +                                               continue;
> > +                                       ps =3D pos->stats;
> > +                                       source_count =3D 1;
> > +                                       break;
> > +                               }
> > +                       }
> > +                       aggr =3D &ps->aggr[aggr_idx];
> >                         if (!aggr)
> >                                 break;
> >
> > @@ -420,7 +442,8 @@ static int prepare_metric(const struct metric_expr =
*mexp,
> >                                  * metric.
> >                                  */
> >                                 val =3D aggr->counts.val * (1.0 / mexp-=
>metric_events[i]->scale);
> > -                               source_count =3D evsel__source_count(me=
xp->metric_events[i]);
> > +                               if (!source_count)
> > +                                       source_count =3D evsel__source_=
count(mexp->metric_events[i]);
> >                         }
> >                 }
> >                 n =3D strdup(evsel__metric_id(mexp->metric_events[i]));
> > @@ -461,7 +484,7 @@ static void generic_metric(struct perf_stat_config =
*config,
> >                 pctx->sctx.user_requested_cpu_list =3D strdup(config->u=
ser_requested_cpu_list);
> >         pctx->sctx.runtime =3D mexp->runtime;
> >         pctx->sctx.system_wide =3D config->system_wide;
> > -       i =3D prepare_metric(mexp, pctx, aggr_idx);
> > +       i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
> >         if (i < 0) {
> >                 expr__ctx_free(pctx);
> >                 return;
> > @@ -522,7 +545,7 @@ double test_generic_metric(struct metric_expr *mexp=
, int aggr_idx)
> >         if (!pctx)
> >                 return NAN;
> >
> > -       if (prepare_metric(mexp, pctx, aggr_idx) < 0)
> > +       if (prepare_metric(mexp, /*evsel=3D*/NULL, pctx, aggr_idx) < 0)
> >                 goto out;
> >
> >         if (expr__parse(&ratio, pctx, mexp->metric_expr))
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

