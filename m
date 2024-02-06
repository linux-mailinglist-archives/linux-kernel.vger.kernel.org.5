Return-Path: <linux-kernel+bounces-54201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC684AC28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3AA2872E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625156B72;
	Tue,  6 Feb 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giB9SrjI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7E57306
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186245; cv=none; b=Tmzni7kOr3Oc2jT+Bb0uJdzccnRBzSuUya52hk5hV1RLbjqFRhJj2Pj4/y4MQWwSFE4BVgndrbw+FpAYrEwfS4ZOHtAPdTDiD0D97Vkj8vOpQ8kEWA45UC1QF4ppZFL6gPmju0g2w4bWw4lGZlDLzL0BRH303PGiLeZOLJrIrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186245; c=relaxed/simple;
	bh=JKM8I/B9eZxA1Vio29biL99BhsIYac/6T/kgJg3ZjjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmKhCskZlHgxtHItZiu5wLeODpP4oz6yGrBPv9k6cvnK/KXLrCgk5/2YnDRz/3bmT1qjHxg8SdXBtDvW8ldFxh1KnatpTjztC5E85gdaQ+1YAdVobQhMqBjO53Po/0XfF5PRKNgVCuNWPDiLgxJ/8xLK50dBKMlGWZuANQPqaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giB9SrjI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5ce88b51cso135785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 18:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707186243; x=1707791043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwXaroUJpTq8nvA/AngMuPCnuxdA2L8+vgWMQG7xp8s=;
        b=giB9SrjI9khDHbGsH6Qka+8uAkw5sEMb8tZ/mgKCx6xjrVDFu5e08uQL7v4MNdu/Zn
         Ye2fRE2mx+9MwiAo0JkH5hHULoQ64k1H58aLbDzOiIVILn2kEvptWv6+yH2YirMefuvl
         kSsWG9uNe3nbK4So4a04oLBJDPnDRRbGCDMBdFfXZ75/iYifLypWhUruOPiuGJJUQ6ti
         czMBYdpzX52sky4/hxC6FgEihdHtvN+cbploN2horgYnzKk1gmdiZ7fdyy6VL8pgsEwD
         4vhNqi4D8BbDGaJdHw/Ki+tsR/22aYKWrlyT0dnAXVW6aEZzNTlUBFKtQ6QFTCkDbOVb
         c8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186243; x=1707791043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwXaroUJpTq8nvA/AngMuPCnuxdA2L8+vgWMQG7xp8s=;
        b=KlmmLn2vcK4m4Y5fcyDW/WCXaS6ISBQk2jhSx4GjhN9h/IEVBzE3gyRmqlG5U2NZl7
         ZvyJJD/HwPafxoEL/kW5bh635cuo4XVBJYkvqSM5xbYuhFA7Lajqz7pTqoHkcUmsvXyG
         MlEYhNWB12SP4XUBaHryYRkFeBB0Hu+7X+8QhyZAKplcA2wYTpLtqCUHgsHt7aATt0rH
         eTNW7qe/tv/X/zCCBW2Gqf6ev3kfzDPhX3KhY6tj/rW+TJ0qg3YWGeoJOok/po0Baqr/
         U+W7tGc6F8PdAAhd4DKrx0aP/lan6V9fIPO+Nze6nD2Nav9+NPUIje3zMZUeECjks+9k
         rEdQ==
X-Gm-Message-State: AOJu0YyxMkXOmU2CeHkMGtz8rC+w/LoHh/7uhroztF0NCRjMGurJjXgt
	w4cggybldC4VNcOIkxDO/7GGy+fQuEHRHfL6YTKxZrJduBavNzI7MrvsYksKW6OKlcUu5AiyQWi
	nL79D0BbsMBhMHOmSuM+z7KONNNZGp+lMSyRd
X-Google-Smtp-Source: AGHT+IF6XoNxUMheAr8q/n03EYvc0sHJUQDXl6NBTTIJeUS8hTnYpViEkLIZgJJ3SZ+4/2OXUTehhuWGGVIgb+9GvQ8=
X-Received: by 2002:a17:902:cec2:b0:1d9:34c8:f88 with SMTP id
 d2-20020a170902cec200b001d934c80f88mr87604plg.19.1707186242653; Mon, 05 Feb
 2024 18:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com> <CAM9d7chAU=arK2y7RDHtxfRcQ80Az6dzGB0_+01iZ346tSob3w@mail.gmail.com>
In-Reply-To: <CAM9d7chAU=arK2y7RDHtxfRcQ80Az6dzGB0_+01iZ346tSob3w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Feb 2024 18:23:51 -0800
Message-ID: <CAP-5=fXqi05ohSe7fH=7zo=DMCjBR1OcjdHETHZJPNAMvsmJaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf stat: Pass fewer metric arguments
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

On Mon, Feb 5, 2024 at 5:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Feb 1, 2024 at 6:25=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Pass metric_expr and evsel rather than specific variables from the
> > struct, thereby reducing the number of arguments. This will enable
> > later fixes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 75 +++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index e31426167852..f6c9d2f98835 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -355,23 +355,22 @@ static void print_nsecs(struct perf_stat_config *=
config,
> >                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized",=
 0);
> >  }
> >
> > -static int prepare_metric(struct evsel **metric_events,
> > -                         struct metric_ref *metric_refs,
> > +static int prepare_metric(const struct metric_expr *mexp,
> >                           struct expr_parse_ctx *pctx,
> >                           int aggr_idx)
> >  {
> >         int i;
>
> You may add local variables with the same name to reduce
> the amount of diff.

I'll see what I can do in v2.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > -       for (i =3D 0; metric_events[i]; i++) {
> > +       for (i =3D 0; mexp->metric_events[i]; i++) {
> >                 char *n;
> >                 double val;
> >                 int source_count =3D 0;
> >
> > -               if (evsel__is_tool(metric_events[i])) {
> > +               if (evsel__is_tool(mexp->metric_events[i])) {
> >                         struct stats *stats;
> >                         double scale;
> >
> > -                       switch (metric_events[i]->tool_event) {
> > +                       switch (mexp->metric_events[i]->tool_event) {
> >                         case PERF_TOOL_DURATION_TIME:
> >                                 stats =3D &walltime_nsecs_stats;
> >                                 scale =3D 1e-9;
> > @@ -391,19 +390,20 @@ static int prepare_metric(struct evsel **metric_e=
vents,
> >                                 pr_err("Invalid tool event 'max'");
> >                                 abort();
> >                         default:
> > -                               pr_err("Unknown tool event '%s'", evsel=
__name(metric_events[i]));
> > +                               pr_err("Unknown tool event '%s'",
> > +                                      evsel__name(mexp->metric_events[=
i]));
> >                                 abort();
> >                         }
> >                         val =3D avg_stats(stats) * scale;
> >                         source_count =3D 1;
> >                 } else {
> > -                       struct perf_stat_evsel *ps =3D metric_events[i]=
->stats;
> > +                       struct perf_stat_evsel *ps =3D mexp->metric_eve=
nts[i]->stats;
> >                         struct perf_stat_aggr *aggr =3D &ps->aggr[aggr_=
idx];
> >
> >                         if (!aggr)
> >                                 break;
> >
> > -                        if (!metric_events[i]->supported) {
> > +                       if (!mexp->metric_events[i]->supported) {
> >                                 /*
> >                                  * Not supported events will have a cou=
nt of 0,
> >                                  * which can be confusing in a
> > @@ -419,19 +419,19 @@ static int prepare_metric(struct evsel **metric_e=
vents,
> >                                  * reverse the scale before computing t=
he
> >                                  * metric.
> >                                  */
> > -                               val =3D aggr->counts.val * (1.0 / metri=
c_events[i]->scale);
> > -                               source_count =3D evsel__source_count(me=
tric_events[i]);
> > +                               val =3D aggr->counts.val * (1.0 / mexp-=
>metric_events[i]->scale);
> > +                               source_count =3D evsel__source_count(me=
xp->metric_events[i]);
> >                         }
> >                 }
> > -               n =3D strdup(evsel__metric_id(metric_events[i]));
> > +               n =3D strdup(evsel__metric_id(mexp->metric_events[i]));
> >                 if (!n)
> >                         return -ENOMEM;
> >
> >                 expr__add_id_val_source_count(pctx, n, val, source_coun=
t);
> >         }
> >
> > -       for (int j =3D 0; metric_refs && metric_refs[j].metric_name; j+=
+) {
> > -               int ret =3D expr__add_ref(pctx, &metric_refs[j]);
> > +       for (int j =3D 0; mexp->metric_refs && mexp->metric_refs[j].met=
ric_name; j++) {
> > +               int ret =3D expr__add_ref(pctx, &mexp->metric_refs[j]);
> >
> >                 if (ret)
> >                         return ret;
> > @@ -441,14 +441,8 @@ static int prepare_metric(struct evsel **metric_ev=
ents,
> >  }
> >
> >  static void generic_metric(struct perf_stat_config *config,
> > -                          const char *metric_expr,
> > -                          const char *metric_threshold,
> > -                          struct evsel **metric_events,
> > -                          struct metric_ref *metric_refs,
> > -                          char *name,
> > -                          const char *metric_name,
> > -                          const char *metric_unit,
> > -                          int runtime,
> > +                       struct metric_expr *mexp,
> > +                       struct evsel *evsel,
> >                            int aggr_idx,
> >                            struct perf_stat_output_ctx *out)
> >  {
> > @@ -465,55 +459,55 @@ static void generic_metric(struct perf_stat_confi=
g *config,
> >
> >         if (config->user_requested_cpu_list)
> >                 pctx->sctx.user_requested_cpu_list =3D strdup(config->u=
ser_requested_cpu_list);
> > -       pctx->sctx.runtime =3D runtime;
> > +       pctx->sctx.runtime =3D mexp->runtime;
> >         pctx->sctx.system_wide =3D config->system_wide;
> > -       i =3D prepare_metric(metric_events, metric_refs, pctx, aggr_idx=
);
> > +       i =3D prepare_metric(mexp, pctx, aggr_idx);
> >         if (i < 0) {
> >                 expr__ctx_free(pctx);
> >                 return;
> >         }
> > -       if (!metric_events[i]) {
> > -               if (expr__parse(&ratio, pctx, metric_expr) =3D=3D 0) {
> > +       if (!mexp->metric_events[i]) {
> > +               if (expr__parse(&ratio, pctx, mexp->metric_expr) =3D=3D=
 0) {
> >                         char *unit;
> >                         char metric_bf[64];
> >
> > -                       if (metric_threshold &&
> > -                           expr__parse(&threshold, pctx, metric_thresh=
old) =3D=3D 0 &&
> > +                       if (mexp->metric_threshold &&
> > +                           expr__parse(&threshold, pctx, mexp->metric_=
threshold) =3D=3D 0 &&
> >                             !isnan(threshold)) {
> >                                 color =3D fpclassify(threshold) =3D=3D =
FP_ZERO
> >                                         ? PERF_COLOR_GREEN : PERF_COLOR=
_RED;
> >                         }
> >
> > -                       if (metric_unit && metric_name) {
> > -                               if (perf_pmu__convert_scale(metric_unit=
,
> > +                       if (mexp->metric_unit && mexp->metric_name) {
> > +                               if (perf_pmu__convert_scale(mexp->metri=
c_unit,
> >                                         &unit, &scale) >=3D 0) {
> >                                         ratio *=3D scale;
> >                                 }
> > -                               if (strstr(metric_expr, "?"))
> > +                               if (strstr(mexp->metric_expr, "?"))
> >                                         scnprintf(metric_bf, sizeof(met=
ric_bf),
> > -                                         "%s  %s_%d", unit, metric_nam=
e, runtime);
> > +                                         "%s  %s_%d", unit, mexp->metr=
ic_name, mexp->runtime);
> >                                 else
> >                                         scnprintf(metric_bf, sizeof(met=
ric_bf),
> > -                                         "%s  %s", unit, metric_name);
> > +                                         "%s  %s", unit, mexp->metric_=
name);
> >
> >                                 print_metric(config, ctxp, color, "%8.1=
f",
> >                                              metric_bf, ratio);
> >                         } else {
> >                                 print_metric(config, ctxp, color, "%8.2=
f",
> > -                                       metric_name ?
> > -                                       metric_name :
> > -                                       out->force_header ?  name : "",
> > +                                       mexp->metric_name ?
> > +                                       mexp->metric_name :
> > +                                       out->force_header ?  evsel->nam=
e : "",
> >                                         ratio);
> >                         }
> >                 } else {
> >                         print_metric(config, ctxp, color, /*unit=3D*/NU=
LL,
> >                                      out->force_header ?
> > -                                    (metric_name ? metric_name : name)=
 : "", 0);
> > +                                    (mexp->metric_name ?: evsel->name)=
 : "", 0);
> >                 }
> >         } else {
> >                 print_metric(config, ctxp, color, /*unit=3D*/NULL,
> >                              out->force_header ?
> > -                            (metric_name ? metric_name : name) : "", 0=
);
> > +                            (mexp->metric_name ?: evsel->name) : "", 0=
);
> >         }
> >
> >         expr__ctx_free(pctx);
> > @@ -528,7 +522,7 @@ double test_generic_metric(struct metric_expr *mexp=
, int aggr_idx)
> >         if (!pctx)
> >                 return NAN;
> >
> > -       if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx=
, aggr_idx) < 0)
> > +       if (prepare_metric(mexp, pctx, aggr_idx) < 0)
> >                 goto out;
> >
> >         if (expr__parse(&ratio, pctx, mexp->metric_expr))
> > @@ -630,10 +624,7 @@ void *perf_stat__print_shadow_stats_metricgroup(st=
ruct perf_stat_config *config,
> >
> >                 if ((*num)++ > 0)
> >                         out->new_line(config, ctxp);
> > -               generic_metric(config, mexp->metric_expr, mexp->metric_=
threshold,
> > -                              mexp->metric_events, mexp->metric_refs, =
evsel->name,
> > -                              mexp->metric_name, mexp->metric_unit, me=
xp->runtime,
> > -                              aggr_idx, out);
> > +               generic_metric(config, mexp, evsel, aggr_idx, out);
> >         }
> >
> >         return NULL;
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

