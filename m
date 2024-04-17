Return-Path: <linux-kernel+bounces-148904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9F8A88C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AF81F21D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D4148849;
	Wed, 17 Apr 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBrhd4TY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F5146D59;
	Wed, 17 Apr 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371047; cv=none; b=qgWJakqePiHHsx+RyFcl56sbzSyFv+eWk9rQcJDPMi1VRjT7kD5a6NM4G9xlw7QwbzaOoMdSPQGx9m02nk50rR094ZOmf3tSy2BxuuLKRZyDUDrm53H0TfAbrs5XdvCtOfmGAZMDzrGEqowJRmY3JWTJdRSu7G0Z75x3e2tJ9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371047; c=relaxed/simple;
	bh=a2NoKEZW4gOQ7cOKT3KGh/17o8s+HV8uq5uRGWmqubI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duODRnujqIm1oFUD/fmVuDTzuCu/RpP4NADk8WguQYIFZbQq6Fxg5RuwENA6nop4g26wSgfgPoxC/5yPrPqYPJ6/v/EMZxrFI5FVr0NBBZIgtrIAZTJCLBA/WG/9nli6pGoLWPup2JqgwBJ4HKqC8U9mI6pvk96wIXIXe0wAbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBrhd4TY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F78C072AA;
	Wed, 17 Apr 2024 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713371047;
	bh=a2NoKEZW4gOQ7cOKT3KGh/17o8s+HV8uq5uRGWmqubI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBrhd4TYmwozuU636PVYsZrbocwfbcJ8Ja39gSRkSbcHLeP3VtB/KHf/u1+xOzC3T
	 5UGpqqyNyVKyYVEzFAZGHBAHfdcbnhD69rpoZtu93uhlnvp0FSMgnNZjHa4pA8r48h
	 cE338mrzm+1HBTNdrYnwzgs0uLUv8gGcNG9p00aHlrygriPsb3iOPGdSsf8nCTl/YU
	 ZrJN6QppJpsW4pOZ9IrwO6PTQG7jpGI0iDf5xlDbrGxHlgVnBuayFcZa3inqT7YO7n
	 vZIs+H0hB1cZ6HhP44BJKi6bBAZzfIqo1VuxrNYQfSw04j/4Y7N31+UUIlU3u36IQr
	 qukbhHNEX2a6w==
Date: Wed, 17 Apr 2024 13:24:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: weilin.wang@intel.com, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v5 02/16] perf stat: Add basic functions for the
 hardware aware grouping
Message-ID: <Zh_3pCLXfL-faTpx@x1>
References: <20240412210756.309828-1-weilin.wang@intel.com>
 <20240412210756.309828-3-weilin.wang@intel.com>
 <CAP-5=fUTHPu_vaNyeaq9uDwf7Hq79khFZymFJK2w39k-9RdutQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUTHPu_vaNyeaq9uDwf7Hq79khFZymFJK2w39k-9RdutQ@mail.gmail.com>

On Tue, Apr 16, 2024 at 09:56:38PM -0700, Ian Rogers wrote:
> On Fri, Apr 12, 2024 at 2:08 PM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Add the first set of functions for the hardware aware grouping method. Function
> > hw_aware_parse_groups() is the entry point of this metric grouping method.  It
> > does metric grouping on a combined list of events and will create a list of
> > grouping strings as final results of the grouping method. These grouping strings
> > will be used in the same manner as existing metric grouping process.
> >
> > This method will fall back to normal grouping when hardware aware grouping
> > return with err so that perf stat still executes and returns with correct
> > result.
> >
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

This one isn't applying:

⬢[acme@toolbox perf-tools-next]$ git log -10 --oneline tools/perf/util/metricgroup.c
b6226e7e6daa823d (HEAD -> perf-tools-next) perf stat: Add new field in stat_config to enable hardware aware grouping
4b5ee6db2d3cd624 perf metrics: Remove the "No_group" metric group
97b6b4ac1c5dd42a perf metrics: Fix segv for metrics with no events
d4be39cadef0dbba perf metrics: Fix metric matching
a59fb796a36bb6c2 perf metrics: Compute unmerged uncore metrics individually
7bbe8f0071dfa23f perf tools: Fix calloc() arguments to address error introduced in gcc-14
e2b005d6ec0e738d perf metrics: Avoid segv if default metricgroup isn't set
54409997d4b99ab6 perf metric: "Compat" supports regular expression matching identifiers
4000519eb0c66594 perf pmu-events: Add extra underscore to function names
1c0e47956a8e1109 perf metrics: Sort the Default metricgroup
⬢[acme@toolbox perf-tools-next]$

So just the first patch was applied so far, I'll push what I have to
tmp.perf-tools-next and then later to perf-tools-next so that this work
can be continued from there.

- Arnaldo
 
> > ---
> >  tools/perf/util/metricgroup.c | 217 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 216 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 11613450725a..8047f03b2b1f 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -159,6 +159,14 @@ struct metric {
> >         struct evlist *evlist;
> >  };
> >
> > +/**
> > + * Each group is one node in the group string list.
> > + */
> > +struct metricgroup__group_strs {
> > +       struct list_head nd;
> > +       struct strbuf grouping_str;
> > +};
> > +
> >  static void metric__watchdog_constraint_hint(const char *name, bool foot)
> >  {
> >         static bool violate_nmi_constraint;
> > @@ -1432,6 +1440,101 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
> >         return ret;
> >  }
> >
> > +/**
> > + * hw_aware_build_grouping - Build event groupings by reading counter
> > + * requirement of the events and counter available on the system from
> > + * pmu-events.
> > + * @ctx: the event identifiers parsed from metrics.
> > + * @groupings: header to the list of final event grouping.
> > + * @modifier: any modifiers added to the events.
> > + */
> > +static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
> > +                                 struct list_head *groupings __maybe_unused,
> > +                                 const char *modifier __maybe_unused)
> > +{
> > +       int ret = 0;
> > +
> > +       pr_debug("This is a placeholder\n");
> > +       return ret;
> > +}
> > +
> > +static void group_str_free(struct metricgroup__group_strs *g)
> > +{
> > +       if (!g)
> > +               return;
> > +
> > +       strbuf_release(&g->grouping_str);
> > +       free(g);
> > +}
> > +
> > +static void metricgroup__free_grouping_strs(struct list_head
> > +                                          *grouping_strs)
> > +{
> > +       struct metricgroup__group_strs *g, *tmp;
> > +
> > +       list_for_each_entry_safe(g, tmp, grouping_strs, nd) {
> > +               list_del_init(&g->nd);
> > +               group_str_free(g);
> > +       }
> > +}
> > +
> > +/**
> > + * hw_aware_parse_ids - Build the event string for the ids and parse them
> > + * creating an evlist. The encoded metric_ids are decoded. Events are placed
> > + * into groups based on event counter requirements and counter availabilities of
> > + * the system.
> > + * @metric_no_merge: is metric sharing explicitly disabled.
> > + * @fake_pmu: used when testing metrics not supported by the current CPU.
> > + * @ids: the event identifiers parsed from a metric.
> > + * @modifier: any modifiers added to the events.
> > + * @out_evlist: the created list of events.
> > + */
> > +static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
> > +                            struct expr_parse_ctx *ids, const char *modifier,
> > +                            struct evlist **out_evlist)
> > +{
> > +       struct parse_events_error parse_error;
> > +       struct evlist *parsed_evlist;
> > +       LIST_HEAD(groupings);
> > +       struct metricgroup__group_strs *group;
> > +       int ret;
> > +
> > +       *out_evlist = NULL;
> > +       ret = hw_aware_build_grouping(ids, &groupings, modifier);
> > +       if (ret) {
> > +               metricgroup__free_grouping_strs(&groupings);
> > +               return ret;
> > +       }
> > +
> > +       parsed_evlist = evlist__new();
> > +       if (!parsed_evlist) {
> > +               ret = -ENOMEM;
> > +               goto err_out;
> > +       }
> > +       list_for_each_entry(group, &groupings, nd) {
> > +               struct strbuf *events = &group->grouping_str;
> > +
> > +               pr_debug("Parsing metric events '%s'\n", events->buf);
> > +               parse_events_error__init(&parse_error);
> > +               ret = __parse_events(parsed_evlist, events->buf, /*pmu_filter=*/NULL,
> > +                                   &parse_error, fake_pmu, /*warn_if_reordered=*/false);
> > +               if (ret) {
> > +                       parse_events_error__print(&parse_error, events->buf);
> > +                       goto err_out;
> > +               }
> > +               ret = decode_all_metric_ids(parsed_evlist, modifier);
> > +               if (ret)
> > +                       goto err_out;
> > +       }
> > +       *out_evlist = parsed_evlist;
> > +       parsed_evlist = NULL;
> > +err_out:
> > +       parse_events_error__exit(&parse_error);
> > +       evlist__delete(parsed_evlist);
> > +       metricgroup__free_grouping_strs(&groupings);
> > +       return ret;
> > +}
> > +
> >  /**
> >   * parse_ids - Build the event string for the ids and parse them creating an
> >   *             evlist. The encoded metric_ids are decoded.
> > @@ -1520,6 +1623,113 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> >         return ret;
> >  }
> >
> > +static int hw_aware_parse_groups(struct evlist *perf_evlist,
> > +                               const char *pmu, const char *str,
> > +                               bool metric_no_threshold,
> > +                               const char *user_requested_cpu_list,
> > +                               bool system_wide,
> > +                               struct perf_pmu *fake_pmu,
> > +                               struct rblist *metric_events_list,
> > +                               const struct pmu_metrics_table *table)
> > +{
> > +       struct evlist *combined_evlist = NULL;
> > +       LIST_HEAD(metric_list);
> > +       struct metric *m;
> > +       int ret;
> > +       bool metric_no_group = false;
> > +       bool metric_no_merge = false;
> > +
> > +       if (metric_events_list->nr_entries == 0)
> > +               metricgroup__rblist_init(metric_events_list);
> > +       ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
> > +                                          user_requested_cpu_list,
> > +                                          system_wide, &metric_list, table);
> > +       if (ret)
> > +               goto out;
> > +
> > +       /* Sort metrics from largest to smallest. */
> > +       list_sort(NULL, &metric_list, metric_list_cmp);
> > +
> > +       if (!metric_no_merge) {
> > +               struct expr_parse_ctx *combined = NULL;
> > +
> > +               ret = build_combined_expr_ctx(&metric_list, &combined);
> > +
> > +               if (!ret && combined && hashmap__size(combined->ids)) {
> > +                       ret = hw_aware_parse_ids(fake_pmu, combined,
> > +                                               /*modifier=*/NULL,
> > +                                               &combined_evlist);
> > +               }
> > +
> > +               if (combined)
> > +                       expr__ctx_free(combined);
> > +               if (ret)
> > +                       goto out;
> > +       }
> > +
> > +       list_for_each_entry(m, &metric_list, nd) {
> > +               struct metric_expr *expr;
> > +               struct metric_event *me;
> > +               struct evsel **metric_events;
> > +
> > +               ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
> > +                                        combined_evlist, &metric_events);
> > +               if (ret) {
> > +                       pr_debug("Cannot resolve IDs for %s: %s\n",
> > +                               m->metric_name, m->metric_expr);
> > +                       goto out;
> > +               }
> > +
> > +               me = metricgroup__lookup(metric_events_list, metric_events[0], true);
> > +
> > +               expr = malloc(sizeof(struct metric_expr));
> > +               if (!expr) {
> > +                       ret = -ENOMEM;
> > +                       free(metric_events);
> > +                       goto out;
> > +               }
> > +
> > +               expr->metric_refs = m->metric_refs;
> > +               m->metric_refs = NULL;
> > +               expr->metric_expr = m->metric_expr;
> > +               if (m->modifier) {
> > +                       char *tmp;
> > +
> > +                       if (asprintf(&tmp, "%s:%s", m->metric_name, m->modifier) < 0)
> > +                               expr->metric_name = NULL;
> > +                       else
> > +                               expr->metric_name = tmp;
> > +               } else {
> > +                       expr->metric_name = strdup(m->metric_name);
> > +               }
> > +
> > +               if (!expr->metric_name) {
> > +                       ret = -ENOMEM;
> > +                       free(metric_events);
> > +                       goto out;
> > +               }
> > +               expr->metric_threshold = m->metric_threshold;
> > +               expr->metric_unit = m->metric_unit;
> > +               expr->metric_events = metric_events;
> > +               expr->runtime = m->pctx->sctx.runtime;
> > +               list_add(&expr->nd, &me->head);
> > +       }
> > +
> > +       if (combined_evlist) {
> > +               evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
> > +               evlist__delete(combined_evlist);
> > +       }
> > +
> > +       list_for_each_entry(m, &metric_list, nd) {
> > +               if (m->evlist)
> > +                       evlist__splice_list_tail(perf_evlist, &m->evlist->core.entries);
> > +       }
> > +
> > +out:
> > +       metricgroup__free_metrics(&metric_list);
> > +       return ret;
> > +}
> > +
> >  static int parse_groups(struct evlist *perf_evlist,
> >                         const char *pmu, const char *str,
> >                         bool metric_no_group,
> > @@ -1698,10 +1908,15 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >         if (!table)
> >                 return -EINVAL;
> >         if (hardware_aware_grouping) {
> > +               int ret;
> 
> nit: there should be a '\n' between variables and code,
> scripts/checkpatch.pl sould catch this.
> 
> >                 pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
> > +               ret = hw_aware_parse_groups(perf_evlist, pmu, str,
> > +                           metric_no_threshold, user_requested_cpu_list, system_wide,
> > +                           /*fake_pmu=*/NULL, metric_events, table);
> > +               if (!ret)
> > +                       return 0;
> >         }
> >
> > -
> 
> nit: unneeded whitespace change.
> 
> Thanks,
> Ian
> 
> >         return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
> >                             metric_no_threshold, user_requested_cpu_list, system_wide,
> >                             /*fake_pmu=*/NULL, metric_events, table);
> > --
> > 2.42.0
> >

