Return-Path: <linux-kernel+bounces-99862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5D878E79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184261F225E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3D3984D;
	Tue, 12 Mar 2024 06:14:18 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824E2E3EF;
	Tue, 12 Mar 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224057; cv=none; b=VWZ5wx42sbhda3U64wVGnb3Q2I98Nj85AdrDZN5OIs1xjXKkyEcYUE8X77sbjG/jL6cc6DDDUmtbxVfxpCQqcztQkbY1HdgVOoppJFMcxqKskA9ASw5qIrqUKOwEmu2OvQfcTaR8DNDhSbsbWdRscZ5d8xcWjF5h5Mlx3vrtcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224057; c=relaxed/simple;
	bh=8rdKn5qNAExNjkXbTn10cc1Q2+Zo7aImTOmx+JryztI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb+Wd3DSY10+7LsyzdAYufTOZsRLhYPdFdN4MhJZ5kZ4TRuGR/NYg9vpEBboBW39Jv3BxitAZB/HvO5nlnHCMApbtfLOEtnNUvuiIGDZKMcA71n67uOD1WSEyRu9f4Z16aIfjwEvb6++zQdcgo7TrZE7oePMlGWsB342Sc4m6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so3373494a12.3;
        Mon, 11 Mar 2024 23:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710224055; x=1710828855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bKLlfKsDNs2d/W4ZG9d/7+1WGOXPO6kNhFqvy115PU=;
        b=Nhg4ymVHuNi+UtRzfpm+JtQ0jo1srPj5E428RakEpx8Dn5CHY7Oeia6qqTrd+VzsVa
         +Q1PcJLMBceqkhw9/EWmsJtGdJRKj1eKMQvDJ2zy74rlngGhte1m9HqOfPdyTjdIiZZJ
         NNxGY12B1vObk3W60v7Z45t1sLemIj23HyhgeLJ5Qo0YOtFer/SMIVHGY9EsPzG45pIv
         OCawefgqcNZUKoLYEdFM/2LFL0t7RkVxBxiUZd3xR/irUDVzOzr+kW3Y4dYDvxzIgnfl
         bbpTMJX1DOtwJQ0SWNnrXuH1xMaNHPZKFsT5+kD/kR3u6u+9oym3eiFbkMmJVHiFIOK3
         bfOw==
X-Forwarded-Encrypted: i=1; AJvYcCXB04w5TysgQF30Y10J9GuIM61Km/apOkgotUNMLfAMCekmOUcGs9XkzANRU2t5fbIA579wbYpwEoY98RnHrYtikfNbtrQ1REiQAZX7qLbiHtin7KOYMTnULCsWrBhEN+6oC9GRQJL1LnEN6QkENw==
X-Gm-Message-State: AOJu0YyNmGuo1RrxntddBp8EmKZcx5W3xG4/UbRTAuiCWl9mMkTwtJNf
	8GnxxqknWcPwKHPOXMnS+FYcOVZS1LDu6rVzjkeLb2UU4DNsz1nSdaMKzmmOup/GqjTH4Nx90PS
	+9F/4Q10C4C4DolxF0vaMT+EoQ3w=
X-Google-Smtp-Source: AGHT+IGz6hFN1HCMN2L6jNRTe2vy4IZ9XPp+cK/cZSI03A9WI4rDHt4g2XE2BfFJqs2bgtKiSNjxJJJVQyOSNrEBLoE=
X-Received: by 2002:a17:90b:4b52:b0:29c:67:115a with SMTP id
 mi18-20020a17090b4b5200b0029c0067115amr4521365pjb.42.1710224054819; Mon, 11
 Mar 2024 23:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-2-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-2-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 23:14:03 -0700
Message-ID: <CAM9d7cjvJgd0ZRnmX+8OYs2YHjDCyt25kHxHQ4yjmR+n9CiMDg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:11=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Metrics that use tpebs values would use the :retire_latency keyword in
> formulas. We put all these events into a list and pass the list to perf
> record to collect their retire latency value.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 38 +++++++++++++---
>  tools/perf/util/metricgroup.c | 81 +++++++++++++++++++++++++++++------
>  tools/perf/util/metricgroup.h | 10 ++++-
>  tools/perf/util/stat.h        |  2 +
>  4 files changed, 112 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6bba1a89d030..5a3093541cff 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -162,6 +162,7 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> +       .tpebs_event_size =3D 0,

Usually you don't need to add 0 initial value as it's the default.


>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -686,6 +687,12 @@ static enum counter_recovery stat_handle_error(struc=
t evsel *counter)
>         return COUNTER_FATAL;
>  }
>
> +static int __run_perf_record(void)
> +{
> +       pr_debug("Prepare perf record for retire_latency\n");
> +       return 0;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -703,6 +710,15 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>
> +       //Prepare perf record for sampling event retire_latency before fo=
rk and prepare workload

We prefer C style comments /* ... */.


> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               ret =3D __run_perf_record();
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (forks) {
>                 if (evlist__prepare_workload(evsel_list, &target, argv, i=
s_pipe, workload_exec_failed_signal) < 0) {
>                         perror("failed to prepare workload");
> @@ -2106,7 +2122,9 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);

Hmm.. the argument list is too long.  Maybe we need to think
about just passing a pointer to the stat_config instead.


>         }
>
>         if (smi_cost) {
> @@ -2139,7 +2157,9 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);
>         }
>
>         if (topdown_run) {
> @@ -2173,7 +2193,9 @@ static int add_default_attributes(void)
>                                                 /*metric_no_threshold=3D*=
/true,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s) < 0)
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size) < 0)
>                         return -1;
>         }
>
> @@ -2214,7 +2236,9 @@ static int add_default_attributes(void)
>                                                         /*metric_no_thres=
hold=3D*/true,
>                                                         stat_config.user_=
requested_cpu_list,
>                                                         stat_config.syste=
m_wide,
> -                                                       &stat_config.metr=
ic_events) < 0)
> +                                                       &stat_config.metr=
ic_events,
> +                                                       /*&stat_config.tp=
ebs_events=3D*/NULL,
> +                                                       /*stat_config.tpe=
bs_event_size=3D*/0) < 0)
>                                 return -1;
>
>                         evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> @@ -2736,6 +2760,8 @@ int cmd_stat(int argc, const char **argv)
>                 }
>         }
>
> +       INIT_LIST_HEAD(&stat_config.tpebs_events);

You can move it to the initializer using LIST_HEAD_INIT().

> +
>         /*
>          * Metric parsing needs to be delayed as metrics may optimize eve=
nts
>          * knowing the target is system-wide.
> @@ -2748,7 +2774,9 @@ int cmd_stat(int argc, const char **argv)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);
>
>                 zfree(&metrics);
>                 if (ret) {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index b24a1c177a80..5ee96d2f16c9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -277,7 +277,8 @@ static bool contains_metric_id(struct evsel **metric_=
events, int num_events,
>   */
>  static int setup_metric_events(const char *pmu, struct hashmap *ids,
>                                struct evlist *metric_evlist,
> -                              struct evsel ***out_metric_events)
> +                              struct evsel ***out_metric_events,
> +                              size_t tpebs_event_size)
>  {
>         struct evsel **metric_events;
>         const char *metric_id;
> @@ -286,7 +287,7 @@ static int setup_metric_events(const char *pmu, struc=
t hashmap *ids,
>         bool all_pmus =3D !strcmp(pmu, "all") || perf_pmus__num_core_pmus=
() =3D=3D 1 || !is_pmu_core(pmu);
>
>         *out_metric_events =3D NULL;
> -       ids_size =3D hashmap__size(ids);
> +       ids_size =3D hashmap__size(ids) - tpebs_event_size;
>
>         metric_events =3D calloc(ids_size + 1, sizeof(void *));
>         if (!metric_events)
> @@ -323,6 +324,7 @@ static int setup_metric_events(const char *pmu, struc=
t hashmap *ids,
>                 }
>         }
>         if (matched_events < ids_size) {
> +               pr_debug("Error: matched_events =3D %lu, ids_size =3D %lu=
\n", matched_events, ids_size);
>                 free(metric_events);
>                 return -EINVAL;
>         }
> @@ -670,7 +672,9 @@ static int decode_all_metric_ids(struct evlist *perf_=
evlist, const char *modifie
>  static int metricgroup__build_event_string(struct strbuf *events,
>                                            const struct expr_parse_ctx *c=
tx,
>                                            const char *modifier,
> -                                          bool group_events)
> +                                          bool group_events,
> +                                          struct list_head *tpebs_events=
 __maybe_unused,
> +                                          size_t *tpebs_event_size)
>  {
>         struct hashmap_entry *cur;
>         size_t bkt;
> @@ -683,8 +687,47 @@ static int metricgroup__build_event_string(struct st=
rbuf *events,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *sep, *rsep, *id =3D cur->pkey;
>                 enum perf_tool_event ev;
> +               char *p =3D strstr(id, ":R");
> +               char *p1 =3D strstr(id, "@R");

Can you please add a comment on what you are doing here?

> +
> +               if (p =3D=3D NULL && p1) {
> +                       p =3D strstr(p1+1, "@R");
> +                       if (p =3D=3D NULL)
> +                               p =3D p1;
> +                       p =3D p+1;
> +               }
> +
> +               if (p) {
> +                       struct tpebs_event *new_event =3D malloc(sizeof(s=
truct tpebs_event));
> +                       char *name;
> +                       char *at;
>
> -               pr_debug("found event %s\n", id);
> +                       pr_debug("event name %s\n", id);
> +                       new_event->tpebs_name =3D strdup(id);
> +                       *p =3D '\0';
> +                       name =3D malloc(strlen(id) + 2);
> +                       if (!name)
> +                               return -ENOMEM;

Note the previous two allocations can also fail. :)

> +
> +                       at =3D strchr(id, '@');
> +                       if (at !=3D NULL) {
> +                               pr_debug("tpebs name %s\n", id);
> +                               *at =3D '/';
> +                               at =3D strchr(id, '@');
> +                               *at =3D '/';
> +                               strcpy(name, id);
> +                               strcat(name, "p");
> +                       } else {
> +                               strcpy(name, id);
> +                               strcat(name, ":p");
> +                       }
> +                       new_event->name =3D name;
> +                       *tpebs_event_size +=3D 1;
> +                       pr_debug("retire_latency required, tpebs_event_si=
ze=3D%lu, new_event=3D%s\n",
> +                       *tpebs_event_size, new_event->name);

Broken indentation.


> +                       list_add_tail(&new_event->nd, tpebs_events);
> +                       continue;
> +               }
>
>                 /* Always move tool events outside of the group. */
>                 ev =3D perf_tool_event__from_str(id);
> @@ -1449,7 +1492,8 @@ static int build_combined_expr_ctx(const struct lis=
t_head *metric_list,
>  static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
>                      struct expr_parse_ctx *ids, const char *modifier,
>                      bool group_events, const bool tool_events[PERF_TOOL_=
MAX],
> -                    struct evlist **out_evlist)
> +                    struct evlist **out_evlist, struct list_head *tpebs_=
events,
> +                    size_t *tpebs_event_size)
>  {
>         struct parse_events_error parse_error;
>         struct evlist *parsed_evlist;
> @@ -1492,7 +1536,7 @@ static int parse_ids(bool metric_no_merge, struct p=
erf_pmu *fake_pmu,
>                 }
>         }
>         ret =3D metricgroup__build_event_string(&events, ids, modifier,
> -                                             group_events);
> +                                             group_events, tpebs_events,=
 tpebs_event_size);
>         if (ret)
>                 return ret;
>
> @@ -1531,7 +1575,9 @@ static int parse_groups(struct evlist *perf_evlist,
>                         bool system_wide,
>                         struct perf_pmu *fake_pmu,
>                         struct rblist *metric_events_list,
> -                       const struct pmu_metrics_table *table)
> +                       const struct pmu_metrics_table *table,
> +                       struct list_head *tpebs_events,
> +                       size_t *tpebs_event_size)
>  {
>         struct evlist *combined_evlist =3D NULL;
>         LIST_HEAD(metric_list);
> @@ -1563,7 +1609,8 @@ static int parse_groups(struct evlist *perf_evlist,
>                                         /*modifier=3D*/NULL,
>                                         /*group_events=3D*/false,
>                                         tool_events,
> -                                       &combined_evlist);
> +                                       &combined_evlist,
> +                                       tpebs_events, tpebs_event_size);
>                 }
>                 if (combined)
>                         expr__ctx_free(combined);
> @@ -1618,14 +1665,15 @@ static int parse_groups(struct evlist *perf_evlis=
t,
>                 }
>                 if (!metric_evlist) {
>                         ret =3D parse_ids(metric_no_merge, fake_pmu, m->p=
ctx, m->modifier,
> -                                       m->group_events, tool_events, &m-=
>evlist);
> +                                       m->group_events, tool_events, &m-=
>evlist,
> +                                       tpebs_events, tpebs_event_size);
>                         if (ret)
>                                 goto out;
>
>                         metric_evlist =3D m->evlist;
>                 }
>                 ret =3D setup_metric_events(fake_pmu ? "all" : m->pmu, m-=
>pctx->ids,
> -                                         metric_evlist, &metric_events);
> +                                         metric_evlist, &metric_events, =
*tpebs_event_size);
>                 if (ret) {
>                         pr_err("Cannot resolve IDs for %s: %s\n",
>                                 m->metric_name, m->metric_expr);
> @@ -1692,16 +1740,21 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> -                             struct rblist *metric_events)
> +                             struct rblist *metric_events,
> +                             struct list_head *tpebs_events,
> +                             size_t *tpebs_event_size)
>  {
>         const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
>
> +       pr_debug("Test debugging\n");
> +

Can you please remove these debug messages before submitting?

Thanks,
Namhyung


>         if (!table)
>                 return -EINVAL;
>
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> -                           /*fake_pmu=3D*/NULL, metric_events, table);
> +                           /*fake_pmu=3D*/NULL, metric_events, table, tp=
ebs_events,
> +                           tpebs_event_size);
>  }
>
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> @@ -1715,7 +1768,9 @@ int metricgroup__parse_groups_test(struct evlist *e=
vlist,
>                             /*metric_no_threshold=3D*/false,
>                             /*user_requested_cpu_list=3D*/NULL,
>                             /*system_wide=3D*/false,
> -                           &perf_pmu__fake, metric_events, table);
> +                           &perf_pmu__fake, metric_events, table,
> +                           /*tpebs_events=3D*/NULL,
> +                           /*tpebs_event_size=3D*/0);
>  }
>
>  struct metricgroup__has_metric_data {
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index d5325c6ec8e1..7c24ed768ff3 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -66,6 +66,12 @@ struct metric_expr {
>         int runtime;
>  };
>
> +struct tpebs_event {
> +       struct list_head nd;
> +       const char *name;
> +       const char *tpebs_name;
> +};
> +
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
>                                          bool create);
> @@ -77,7 +83,9 @@ int metricgroup__parse_groups(struct evlist *perf_evlis=
t,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> -                             struct rblist *metric_events);
> +                             struct rblist *metric_events,
> +                             struct list_head *tpebs_events,
> +                             size_t *tpebs_event_size);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    const struct pmu_metrics_table *table,
>                                    const char *str,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index d6e5c8787ba2..b987960df3c5 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -109,6 +109,8 @@ struct perf_stat_config {
>         struct cpu_aggr_map     *cpus_aggr_map;
>         u64                     *walltime_run;
>         struct rblist            metric_events;
> +       struct list_head         tpebs_events;
> +       size_t                   tpebs_event_size;
>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>

