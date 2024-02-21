Return-Path: <linux-kernel+bounces-73948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADB85CDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C7283415
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65312FC03;
	Wed, 21 Feb 2024 02:21:28 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41091F9CC;
	Wed, 21 Feb 2024 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482087; cv=none; b=jDFJVyQ2IdqhLxt7l8cZrkKF5RjwqpLZHeIftnD+XwROEeXxhddTC/vePz8xCYJOrZObZMUPd5fD72ZLDU85u3t4eJj3mqRq7G+Pp1WNCAPAhlnkAzapxS4gQLf6emm04G/q52/1glGAbBx5ZSUuAi8Zb0hsy+isUGSmxE3BKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482087; c=relaxed/simple;
	bh=GbeTeMQU+fsxa1wTnzSHhOxbfRcqu2zwq+EzCfXvzZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzgoyJ4mZgm9tvRyjUbmxh9sZ7tRhvl4qbt74U/SmpIKrea04qvalCR+5C45sbDXhT9JF5TD7WPGzAVTDc1ypSNhR/eA+q752vG7DRQZ3gOWAbHMQLAYCRvPTKshyxZk0MovKohFzQZhZVuRR6iFPUhfLKe0W8yV0N8/lt1SNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so78711a12.1;
        Tue, 20 Feb 2024 18:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708482085; x=1709086885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xC8dPua6jltBvijNssC+1DhVrd7h9tYnME5/Mj9Qto=;
        b=Kt8p3eDcFOzdUW9i/co6yhpm8RG47yA0EE7Dw4COZzniHsNjmiFiQRZvJ29U0QZKHc
         mWVD603TyLBMWdlLG9pt4Q44m9iLn1xN4wFb+1BIgYB1LiPMvOjEPC9FLfEowOR6ysg0
         iGZ+SSqgB6oQc5pZ1tDGRUdZsiOBFzHAv2RpFcEp8UVpwcI//s89TwDMJEYtJbAYePGW
         itVJ7M8+wGzQQfT7iYKtLQ+TrdZrUaJVOaJYC6hYUoVvr+SpruXaysgz7g8v7/Mes/jY
         t/b74aQwLa47mXemp0Eytyp3AnQrZmIa/KTcDw264J5a523x9UITbu1MRDtUWWCukngA
         H3yA==
X-Forwarded-Encrypted: i=1; AJvYcCUaDv+8yW3lDAplZp2JqFm39W33AMiUOLcYuO9TCs+D3I9CklDwT314i/RYtt0+c5teovTYz3+FL0rECnmoolqHnETjEc5DAw4Z07+xU0zlvRE6/gZjg/m6AF37ZlCj8nUCuItxlzYDBqgQh/kkQA==
X-Gm-Message-State: AOJu0YxIG7AX5W74WiQfCfwfFJBIlY2R7tLuYdT30+gWRGDN9/EY9zuS
	Q044A2yKVtnP8429WCSUN8TQcK+OONSDXmloqpIV5Fpr/OV0ifXThK1FjNyIdYeD7EzPtbPhnAP
	NZMAbsg/jdk8TljkbmVuG90NHHdY=
X-Google-Smtp-Source: AGHT+IETLSc7AJKjNcmqB0L0RZNwZQFZ9KTejtP6W1uJfzpYX7W8EEjWi1qnQyUp6tWm1FrntU8canx9qZuTAfn9Jzw=
X-Received: by 2002:a17:90a:5916:b0:299:d5fa:3e18 with SMTP id
 k22-20020a17090a591600b00299d5fa3e18mr4676871pji.20.1708482085438; Tue, 20
 Feb 2024 18:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206043159.2539981-1-irogers@google.com>
In-Reply-To: <20240206043159.2539981-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Feb 2024 18:21:14 -0800
Message-ID: <CAM9d7ciPkwwWkGQX9nNN=XFmtf=Wg-9uSdF_OrAh1==Re=dbgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf stat: Pass fewer metric arguments
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Pass metric_expr and evsel rather than specific variables from the
> struct, thereby reducing the number of arguments. This will enable
> later fixes.
>
> To reduce the size of the diff, local variables are added to match the
> previous parameter names. This isn't done in the case of "name" as
> evsel->name is more intention revealing. A whitespace issue is also
> addressed.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This doesn't apply to perf-tools-next anymore.  Can you please refresh?
Anyway the change looks good to me now.  For the series:

  Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/stat-shadow.c | 38 +++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index e31426167852..b3a25659b9e6 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -355,11 +355,12 @@ static void print_nsecs(struct perf_stat_config *co=
nfig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> -static int prepare_metric(struct evsel **metric_events,
> -                         struct metric_ref *metric_refs,
> +static int prepare_metric(const struct metric_expr *mexp,
>                           struct expr_parse_ctx *pctx,
>                           int aggr_idx)
>  {
> +       struct evsel * const *metric_events =3D mexp->metric_events;
> +       struct metric_ref *metric_refs =3D mexp->metric_refs;
>         int i;
>
>         for (i =3D 0; metric_events[i]; i++) {
> @@ -403,7 +404,7 @@ static int prepare_metric(struct evsel **metric_event=
s,
>                         if (!aggr)
>                                 break;
>
> -                        if (!metric_events[i]->supported) {
> +                       if (!metric_events[i]->supported) {
>                                 /*
>                                  * Not supported events will have a count=
 of 0,
>                                  * which can be confusing in a
> @@ -441,18 +442,18 @@ static int prepare_metric(struct evsel **metric_eve=
nts,
>  }
>
>  static void generic_metric(struct perf_stat_config *config,
> -                          const char *metric_expr,
> -                          const char *metric_threshold,
> -                          struct evsel **metric_events,
> -                          struct metric_ref *metric_refs,
> -                          char *name,
> -                          const char *metric_name,
> -                          const char *metric_unit,
> -                          int runtime,
> +                          struct metric_expr *mexp,
> +                          struct evsel *evsel,
>                            int aggr_idx,
>                            struct perf_stat_output_ctx *out)
>  {
>         print_metric_t print_metric =3D out->print_metric;
> +       const char *metric_name =3D mexp->metric_name;
> +       const char *metric_expr =3D mexp->metric_expr;
> +       const char *metric_threshold =3D mexp->metric_threshold;
> +       const char *metric_unit =3D mexp->metric_unit;
> +       struct evsel * const *metric_events =3D mexp->metric_events;
> +       int runtime =3D mexp->runtime;
>         struct expr_parse_ctx *pctx;
>         double ratio, scale, threshold;
>         int i;
> @@ -467,7 +468,7 @@ static void generic_metric(struct perf_stat_config *c=
onfig,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> -       i =3D prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
> +       i =3D prepare_metric(mexp, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
>                 return;
> @@ -502,18 +503,18 @@ static void generic_metric(struct perf_stat_config =
*config,
>                                 print_metric(config, ctxp, color, "%8.2f"=
,
>                                         metric_name ?
>                                         metric_name :
> -                                       out->force_header ?  name : "",
> +                                       out->force_header ?  evsel->name =
: "",
>                                         ratio);
>                         }
>                 } else {
>                         print_metric(config, ctxp, color, /*unit=3D*/NULL=
,
>                                      out->force_header ?
> -                                    (metric_name ? metric_name : name) :=
 "", 0);
> +                                    (metric_name ?: evsel->name) : "", 0=
);
>                 }
>         } else {
>                 print_metric(config, ctxp, color, /*unit=3D*/NULL,
>                              out->force_header ?
> -                            (metric_name ? metric_name : name) : "", 0);
> +                            (metric_name ?: evsel->name) : "", 0);
>         }
>
>         expr__ctx_free(pctx);
> @@ -528,7 +529,7 @@ double test_generic_metric(struct metric_expr *mexp, =
int aggr_idx)
>         if (!pctx)
>                 return NAN;
>
> -       if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, =
aggr_idx) < 0)
> +       if (prepare_metric(mexp, pctx, aggr_idx) < 0)
>                 goto out;
>
>         if (expr__parse(&ratio, pctx, mexp->metric_expr))
> @@ -630,10 +631,7 @@ void *perf_stat__print_shadow_stats_metricgroup(stru=
ct perf_stat_config *config,
>
>                 if ((*num)++ > 0)
>                         out->new_line(config, ctxp);
> -               generic_metric(config, mexp->metric_expr, mexp->metric_th=
reshold,
> -                              mexp->metric_events, mexp->metric_refs, ev=
sel->name,
> -                              mexp->metric_name, mexp->metric_unit, mexp=
->runtime,
> -                              aggr_idx, out);
> +               generic_metric(config, mexp, evsel, aggr_idx, out);
>         }
>
>         return NULL;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

