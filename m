Return-Path: <linux-kernel+bounces-147938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383998A7B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB79D1F22045
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A924084E;
	Wed, 17 Apr 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C5m9b/Q0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EF23D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329815; cv=none; b=gja9FfyfDZhioHzMR0yjr4JAFRgYT9e378AwR0ApbH73H85K3cRibKSnZdTibNA5EvY7OugDjR43H2jQzza290KUawWXTTFkqJvV+4rq7ja1rfrsMYclEyl2ieEGbIrKDnKP04zaI4KEWLVxLius6VgsC+L5B1KQeJ4wvsCOldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329815; c=relaxed/simple;
	bh=HVJ30EI2F2FVi6Vbxg1qzWyTIMq4I7etSIzQ9CPMTMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n98u576XFkQk7ZEMumAAicSOSz13nOtgNEeXamFCcHCvtyC8MoM3Xhbw0Zd8rUkQlnVWtidlK+EMg7wWyAoeoneupIk38cJxydVRl48Sr3gb9CLPpX2+xTWZpsgufr9sMM938CTyJxSccxKaXzYSeg53tMKo4/kdCZS2EoUHGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5m9b/Q0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-436ed871225so143921cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713329812; x=1713934612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuiJNOjgRGEpyv3czbw2vs/NzvxTDjs1htLv2AkhpOE=;
        b=C5m9b/Q0g6ENzBsjbZeHR4mPH7q6t22QCuXv+9f07fcL6B4MmIkTMmCBFP5SThsWuY
         ZMsp4SBuKfhwwIjxdVnqm5Hj7hi5f44lqFZrmZ5hIWwFADSDuWeTjCPirOgOalEjkJDY
         xH3ebOs82Dk+O0u1hPot+o6BortFmcFobcw/JIXOq2/k2YT8o7zJV5bUCyB5+hFoEXA5
         fYT1VW7ZwQL375W3qa9H6MZN/JU0nSOM+ugeqOAItOENKPnOcCQtSR0mS3MeOcnUTcQK
         85X1TcJxCuSTmmRRH40Dnzp298to5ho+QmgloWnKGPIrxn3xIqKRl89HZw50D316kHvV
         VBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713329812; x=1713934612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuiJNOjgRGEpyv3czbw2vs/NzvxTDjs1htLv2AkhpOE=;
        b=QR15P7nzPecGp26TF/44Lt0qkaC8zlctH1mfMV3rbam5ZO1zQREX1DnyD8ZfOxN4eh
         BC4sZ76KvUVgAP6xDTkbyM6AkaRKo+4yZO/8HL4ckX2HJQaimAxFGnprogNG1VYGjl7+
         06KQf9ePfs8GZ9kRExdae0U+NhCZihIoL0zoflgySARSp2hbDCptaTC4Gt3J9wpWd90E
         vA0v7mvCejsvTzRcs1f1T30JVIcYkIfp2XxYKcM+Ye8OhfVc1XAw3MYiSBxgGHrBFVgD
         0uqgCHK7FaKBeLFMOZL0t6LLPmsbS6q552eyfPxzXC60K4lOL65qu/OcqKjTB41/3gjk
         puJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG1qQYGqcPX4XJ4ECd2VORtDBEAMb2LEP8Yf1wQFq7uYpyiaBxkbPyG9A+EUY8xlkTMY8bhUIYFoASJzPdquJ3T1Vqh2IQmHHJ4xhM
X-Gm-Message-State: AOJu0Yyah49OO2Ipnkp6Co+0dPA3mtdN6h19bf8i9yvY1DbkeANZk4lK
	qTP43McW6KRnwXTFHJtS1C+7ta/NUsegN0DMOkxy+bU5+RvCVNtA1rIiVv3bqfGY3A6KC1s6Bbv
	UJn3BUM/vsZwG0kylpZE/MtLP1o4bdBs3nWbT
X-Google-Smtp-Source: AGHT+IGnRohLq08HBxYlkAcNsoCp3wqsuWwi3PRRN/pKQiuda3vNQAu3niMMmVCCH9TEhG/URfOxqwgtg+YcNvvNA+c=
X-Received: by 2002:ac8:46d0:0:b0:437:6a96:e519 with SMTP id
 h16-20020ac846d0000000b004376a96e519mr105989qto.0.1713329812081; Tue, 16 Apr
 2024 21:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-3-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-3-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 21:56:38 -0700
Message-ID: <CAP-5=fUTHPu_vaNyeaq9uDwf7Hq79khFZymFJK2w39k-9RdutQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 02/16] perf stat: Add basic functions for the
 hardware aware grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add the first set of functions for the hardware aware grouping method. Fu=
nction
> hw_aware_parse_groups() is the entry point of this metric grouping method=
  It
> does metric grouping on a combined list of events and will create a list =
of
> grouping strings as final results of the grouping method. These grouping =
strings
> will be used in the same manner as existing metric grouping process.
>
> This method will fall back to normal grouping when hardware aware groupin=
g
> return with err so that perf stat still executes and returns with correct
> result.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/metricgroup.c | 217 +++++++++++++++++++++++++++++++++-
>  1 file changed, 216 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 11613450725a..8047f03b2b1f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -159,6 +159,14 @@ struct metric {
>         struct evlist *evlist;
>  };
>
> +/**
> + * Each group is one node in the group string list.
> + */
> +struct metricgroup__group_strs {
> +       struct list_head nd;
> +       struct strbuf grouping_str;
> +};
> +
>  static void metric__watchdog_constraint_hint(const char *name, bool foot=
)
>  {
>         static bool violate_nmi_constraint;
> @@ -1432,6 +1440,101 @@ static int build_combined_expr_ctx(const struct l=
ist_head *metric_list,
>         return ret;
>  }
>
> +/**
> + * hw_aware_build_grouping - Build event groupings by reading counter
> + * requirement of the events and counter available on the system from
> + * pmu-events.
> + * @ctx: the event identifiers parsed from metrics.
> + * @groupings: header to the list of final event grouping.
> + * @modifier: any modifiers added to the events.
> + */
> +static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_un=
used,
> +                                 struct list_head *groupings __maybe_unu=
sed,
> +                                 const char *modifier __maybe_unused)
> +{
> +       int ret =3D 0;
> +
> +       pr_debug("This is a placeholder\n");
> +       return ret;
> +}
> +
> +static void group_str_free(struct metricgroup__group_strs *g)
> +{
> +       if (!g)
> +               return;
> +
> +       strbuf_release(&g->grouping_str);
> +       free(g);
> +}
> +
> +static void metricgroup__free_grouping_strs(struct list_head
> +                                          *grouping_strs)
> +{
> +       struct metricgroup__group_strs *g, *tmp;
> +
> +       list_for_each_entry_safe(g, tmp, grouping_strs, nd) {
> +               list_del_init(&g->nd);
> +               group_str_free(g);
> +       }
> +}
> +
> +/**
> + * hw_aware_parse_ids - Build the event string for the ids and parse the=
m
> + * creating an evlist. The encoded metric_ids are decoded. Events are pl=
aced
> + * into groups based on event counter requirements and counter availabil=
ities of
> + * the system.
> + * @metric_no_merge: is metric sharing explicitly disabled.
> + * @fake_pmu: used when testing metrics not supported by the current CPU=
.
> + * @ids: the event identifiers parsed from a metric.
> + * @modifier: any modifiers added to the events.
> + * @out_evlist: the created list of events.
> + */
> +static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
> +                            struct expr_parse_ctx *ids, const char *modi=
fier,
> +                            struct evlist **out_evlist)
> +{
> +       struct parse_events_error parse_error;
> +       struct evlist *parsed_evlist;
> +       LIST_HEAD(groupings);
> +       struct metricgroup__group_strs *group;
> +       int ret;
> +
> +       *out_evlist =3D NULL;
> +       ret =3D hw_aware_build_grouping(ids, &groupings, modifier);
> +       if (ret) {
> +               metricgroup__free_grouping_strs(&groupings);
> +               return ret;
> +       }
> +
> +       parsed_evlist =3D evlist__new();
> +       if (!parsed_evlist) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       list_for_each_entry(group, &groupings, nd) {
> +               struct strbuf *events =3D &group->grouping_str;
> +
> +               pr_debug("Parsing metric events '%s'\n", events->buf);
> +               parse_events_error__init(&parse_error);
> +               ret =3D __parse_events(parsed_evlist, events->buf, /*pmu_=
filter=3D*/NULL,
> +                                   &parse_error, fake_pmu, /*warn_if_reo=
rdered=3D*/false);
> +               if (ret) {
> +                       parse_events_error__print(&parse_error, events->b=
uf);
> +                       goto err_out;
> +               }
> +               ret =3D decode_all_metric_ids(parsed_evlist, modifier);
> +               if (ret)
> +                       goto err_out;
> +       }
> +       *out_evlist =3D parsed_evlist;
> +       parsed_evlist =3D NULL;
> +err_out:
> +       parse_events_error__exit(&parse_error);
> +       evlist__delete(parsed_evlist);
> +       metricgroup__free_grouping_strs(&groupings);
> +       return ret;
> +}
> +
>  /**
>   * parse_ids - Build the event string for the ids and parse them creatin=
g an
>   *             evlist. The encoded metric_ids are decoded.
> @@ -1520,6 +1623,113 @@ static int parse_ids(bool metric_no_merge, struct=
 perf_pmu *fake_pmu,
>         return ret;
>  }
>
> +static int hw_aware_parse_groups(struct evlist *perf_evlist,
> +                               const char *pmu, const char *str,
> +                               bool metric_no_threshold,
> +                               const char *user_requested_cpu_list,
> +                               bool system_wide,
> +                               struct perf_pmu *fake_pmu,
> +                               struct rblist *metric_events_list,
> +                               const struct pmu_metrics_table *table)
> +{
> +       struct evlist *combined_evlist =3D NULL;
> +       LIST_HEAD(metric_list);
> +       struct metric *m;
> +       int ret;
> +       bool metric_no_group =3D false;
> +       bool metric_no_merge =3D false;
> +
> +       if (metric_events_list->nr_entries =3D=3D 0)
> +               metricgroup__rblist_init(metric_events_list);
> +       ret =3D metricgroup__add_metric_list(pmu, str, metric_no_group, m=
etric_no_threshold,
> +                                          user_requested_cpu_list,
> +                                          system_wide, &metric_list, tab=
le);
> +       if (ret)
> +               goto out;
> +
> +       /* Sort metrics from largest to smallest. */
> +       list_sort(NULL, &metric_list, metric_list_cmp);
> +
> +       if (!metric_no_merge) {
> +               struct expr_parse_ctx *combined =3D NULL;
> +
> +               ret =3D build_combined_expr_ctx(&metric_list, &combined);
> +
> +               if (!ret && combined && hashmap__size(combined->ids)) {
> +                       ret =3D hw_aware_parse_ids(fake_pmu, combined,
> +                                               /*modifier=3D*/NULL,
> +                                               &combined_evlist);
> +               }
> +
> +               if (combined)
> +                       expr__ctx_free(combined);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       list_for_each_entry(m, &metric_list, nd) {
> +               struct metric_expr *expr;
> +               struct metric_event *me;
> +               struct evsel **metric_events;
> +
> +               ret =3D setup_metric_events(fake_pmu ? "all" : m->pmu, m-=
>pctx->ids,
> +                                        combined_evlist, &metric_events)=
;
> +               if (ret) {
> +                       pr_debug("Cannot resolve IDs for %s: %s\n",
> +                               m->metric_name, m->metric_expr);
> +                       goto out;
> +               }
> +
> +               me =3D metricgroup__lookup(metric_events_list, metric_eve=
nts[0], true);
> +
> +               expr =3D malloc(sizeof(struct metric_expr));
> +               if (!expr) {
> +                       ret =3D -ENOMEM;
> +                       free(metric_events);
> +                       goto out;
> +               }
> +
> +               expr->metric_refs =3D m->metric_refs;
> +               m->metric_refs =3D NULL;
> +               expr->metric_expr =3D m->metric_expr;
> +               if (m->modifier) {
> +                       char *tmp;
> +
> +                       if (asprintf(&tmp, "%s:%s", m->metric_name, m->mo=
difier) < 0)
> +                               expr->metric_name =3D NULL;
> +                       else
> +                               expr->metric_name =3D tmp;
> +               } else {
> +                       expr->metric_name =3D strdup(m->metric_name);
> +               }
> +
> +               if (!expr->metric_name) {
> +                       ret =3D -ENOMEM;
> +                       free(metric_events);
> +                       goto out;
> +               }
> +               expr->metric_threshold =3D m->metric_threshold;
> +               expr->metric_unit =3D m->metric_unit;
> +               expr->metric_events =3D metric_events;
> +               expr->runtime =3D m->pctx->sctx.runtime;
> +               list_add(&expr->nd, &me->head);
> +       }
> +
> +       if (combined_evlist) {
> +               evlist__splice_list_tail(perf_evlist, &combined_evlist->c=
ore.entries);
> +               evlist__delete(combined_evlist);
> +       }
> +
> +       list_for_each_entry(m, &metric_list, nd) {
> +               if (m->evlist)
> +                       evlist__splice_list_tail(perf_evlist, &m->evlist-=
>core.entries);
> +       }
> +
> +out:
> +       metricgroup__free_metrics(&metric_list);
> +       return ret;
> +}
> +
>  static int parse_groups(struct evlist *perf_evlist,
>                         const char *pmu, const char *str,
>                         bool metric_no_group,
> @@ -1698,10 +1908,15 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>         if (!table)
>                 return -EINVAL;
>         if (hardware_aware_grouping) {
> +               int ret;

nit: there should be a '\n' between variables and code,
scripts/checkpatch.pl sould catch this.

>                 pr_debug("Use hardware aware grouping instead of traditio=
nal metric grouping method\n");
> +               ret =3D hw_aware_parse_groups(perf_evlist, pmu, str,
> +                           metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> +                           /*fake_pmu=3D*/NULL, metric_events, table);
> +               if (!ret)
> +                       return 0;
>         }
>
> -

nit: unneeded whitespace change.

Thanks,
Ian

>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
>                             /*fake_pmu=3D*/NULL, metric_events, table);
> --
> 2.42.0
>

