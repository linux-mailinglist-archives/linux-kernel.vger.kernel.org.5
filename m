Return-Path: <linux-kernel+bounces-112599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CED887BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2353A1F21AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9D15491;
	Sun, 24 Mar 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzwB6ftE"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AE14A8B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259794; cv=none; b=dIA3EaRZg48LW98NjT9MjkChP0arpZ7AOKx4cM8ABblXmqZk/p+wWwASHdpU25VylH1FnndIp68N5F4DTfUUMHgK/KOFOlrh3zcQt1OWALFREWjMiBEilsBiLM8zWUcf4MleOuNP517/gq5MV3PV5HS6IfOxQRaZleNTDjvlmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259794; c=relaxed/simple;
	bh=CglfzhccKRRVNOdN9WE+R4L8/3qXn8fiXVfcJRfWP/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbZszWIMRUo5YXrECVaij9i9PZzRq+2eK5YvaGDi3C6UoDDX4f8gokZcD2coYka3+KcQYPV6kC49I+rHxWB0cav5Fs2z+rRO81+VLjLCgxiftmqbCd8x2EoiPUjYN/gu2zw9t/TkL92ihcnAQsg8HCfYExm/OYC10kDAYvP6LPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzwB6ftE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366abfd7b09so182265ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711259792; x=1711864592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw8D1j2/4hkLnvjGIi5NWG+l0k25+0Ejq7ssYfT7e2o=;
        b=LzwB6ftEEh+s9XjwVAtj515vRAzMGd+gwc1KRqEe2yNcXIRhXo4GTS5xJvjiP0hfpj
         LtHgX3etPT2V7Litvz2y6Fvl2xvIBUlO/BUFPXSCsZCxQnEtu8VOV7MDNCYyQPv1E3lL
         dUR+fXN50Jo1lM7/QOF37BuE14Zkc5Pt+Dbz4Gpt7IYe5vQ6tinglBk66vZMlG4yhRwz
         kDI7w1dTgRyzyo7tQKwngpN1ljg1+fQn4TmmQNBwrYsjtqxxcMFNedi5YyBpZ7Hnu/1H
         XbjhzguU3f0X+jlt91zEpenMMszJ40fq8Xdw61d/DAw1L8IdbnXCHYQqMzffu6ibfwni
         JPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711259792; x=1711864592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw8D1j2/4hkLnvjGIi5NWG+l0k25+0Ejq7ssYfT7e2o=;
        b=ALBdPhsn6a+IW7lbcXBYo/e/VogKCwDg4oEKqvKBHlFvxtl/LUl0Yruz5i4Itsx4CG
         xBgVRC543DuaaQ7sP4GQPuW64s04YgpRs7kV21EiC+cjlHwwF3G+du+ABs+0YEH7NMNE
         OFyhE43wIpybdo22SYwDItl3ADLHL31z5TQIoedRGNxePKAt9vJXoP5AOFjbBek0G1hb
         SUuMBtNupyaJQj5auvf7/6kUA1XRt/fZ3zEn+gZQe7TBIeHyV4WOUijJwvtiY4i2fCoZ
         SG9kr6nSuYm4HWT5sIJ0wxLKl6sGCj51dtPXJ5+YpDPNR7WKPE90nZ7vR39LBI72jiLI
         gJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVrvmA+U0i2AW8jr2raBg8sAWL2t9fSVN0jHItm/2oQSQLMb1GcoMZNNjHBPN8EttrSQH/ToCmg3rqY+6Y/XhUsozl7KpyyecCeb5uB
X-Gm-Message-State: AOJu0YwJrifivAMhro+O6qAFgGqTBhofsCTVvdFjAJKDOAmlvEbCipOo
	Q1CiW7Np1mEKvKppm+uFvShHFXqoFQhg8a7Y34gy3yaBV1GdhkH6HUxsEvIAu0App3a/2DbAuAo
	L7cbbt4NeARPhWylgSh4oV+Iwe3xvtTIucRBV
X-Google-Smtp-Source: AGHT+IFjwhGTJq1dU3Oc60J9o9lR4R/6m2aZZGZOKsZJzaJkC6YPBIm48eTuy3yyOjgZJZECYkfdMeyyMPiAUc9dJS0=
X-Received: by 2002:a92:c24c:0:b0:368:7b7b:5233 with SMTP id
 k12-20020a92c24c000000b003687b7b5233mr224271ilo.15.1711259792125; Sat, 23 Mar
 2024 22:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-15-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-15-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:56:21 -0700
Message-ID: <CAP-5=fU1R7QYKCWPrrZ_wA1RCfat+BqiA12=UG2a-GrBLPL0BA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 14/15] perf stat: Add tool events support in hardware-grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add tool events into default_core grouping strings if find tool events so
> that metrics use tool events could be correctly calculated. Need this ste=
p
> to support TopdownL4-L5.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index cfdbb5f7fb77..e5b8456d0405 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1486,6 +1486,35 @@ static void find_tool_events(const struct list_hea=
d *metric_list,
>         }
>  }
>
> +/**
> + * get_tool_event_str - Generate and return a string with all the used t=
ool
> + * event names.
> + */
> +static int get_tool_event_str(struct strbuf *events,
> +                             const bool tool_events[PERF_TOOL_MAX],
> +                             bool *has_tool_event)
> +{
> +       int i =3D 0;
> +       int ret;
> +
> +       perf_tool_event__for_each_event(i) {
> +               if (tool_events[i]) {
> +                       const char *tmp =3D strdup(perf_tool_event__to_st=
r(i));
> +
> +                       if (!tmp)
> +                               return -ENOMEM;
> +                       *has_tool_event =3D true;
> +                       ret =3D strbuf_addstr(events, ",");
> +                       if (ret)
> +                               return ret;
> +                       ret =3D strbuf_addstr(events, tmp);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
>  /**
>   * build_combined_expr_ctx - Make an expr_parse_ctx with all !group_even=
ts
>   *                           metric IDs, as the IDs are held in a set,
> @@ -2049,6 +2078,7 @@ static int assign_event_grouping(struct metricgroup=
__event_info *e,
>
>  static int hw_aware_metricgroup__build_event_string(struct list_head *gr=
oup_strs,
>                                            const char *modifier,
> +                                          const bool tool_events[PERF_TO=
OL_MAX],
>                                            struct list_head *groups)
>  {
>         struct metricgroup__pmu_group_list *p;
> @@ -2056,8 +2086,12 @@ static int hw_aware_metricgroup__build_event_strin=
g(struct list_head *group_strs
>         struct metricgroup__group_events *ge;
>         bool no_group =3D true;
>         int ret =3D 0;
> +       struct strbuf tool_event_str =3D STRBUF_INIT;
> +       bool has_tool_event =3D false;
>
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +       ret =3D get_tool_event_str(&tool_event_str, tool_events, &has_too=
l_event);

Does metricgroup__build_event_string need updating to use this helper
function too?

Thanks,
Ian

> +       RETURN_IF_NON_ZERO(ret);
>
>         list_for_each_entry(p, groups, nd) {
>                 list_for_each_entry(g, &p->group_head, nd) {
> @@ -2129,6 +2163,12 @@ static int hw_aware_metricgroup__build_event_strin=
g(struct list_head *group_strs
>                         }
>                         ret =3D strbuf_addf(events, "}:W");
>                         RETURN_IF_NON_ZERO(ret);
> +
> +                       if (!strcmp(p->pmu_name, "default_core") && has_t=
ool_event) {
> +                               ret =3D strbuf_addstr(events, tool_event_=
str.buf);
> +                               RETURN_IF_NON_ZERO(ret);
> +                       }
> +
>                         pr_debug("events-buf: %s\n", events->buf);
>                         list_add_tail(&new_group_str->nd, group_strs);
>                 }
> @@ -2214,6 +2254,7 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx,
>                 if (ret)
>                         goto err_out;
>         }
> +
>         ret =3D get_pmu_counter_layouts(&pmu_info_list, ltable);
>         if (ret)
>                 goto err_out;
> @@ -2259,6 +2300,7 @@ static void metricgroup__free_grouping_strs(struct =
list_head
>   */
>  static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
>                              struct expr_parse_ctx *ids, const char *modi=
fier,
> +                            const bool tool_events[PERF_TOOL_MAX],
>                              struct evlist **out_evlist)
>  {
>         struct parse_events_error parse_error;
> @@ -2272,7 +2314,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake=
_pmu,
>         ret =3D hw_aware_build_grouping(ids, &grouping);
>         if (ret)
>                 goto out;
> -       ret =3D hw_aware_metricgroup__build_event_string(&grouping_str, m=
odifier, &grouping);
> +       ret =3D hw_aware_metricgroup__build_event_string(&grouping_str, m=
odifier,
> +                                                     tool_events, &group=
ing);
>         if (ret)
>                 goto out;
>
> @@ -2407,6 +2450,7 @@ static int hw_aware_parse_groups(struct evlist *per=
f_evlist,
>         struct evlist *combined_evlist =3D NULL;
>         LIST_HEAD(metric_list);
>         struct metric *m;
> +       bool tool_events[PERF_TOOL_MAX] =3D {false};
>         int ret;
>         bool metric_no_group =3D false;
>         bool metric_no_merge =3D false;
> @@ -2425,11 +2469,14 @@ static int hw_aware_parse_groups(struct evlist *p=
erf_evlist,
>         if (!metric_no_merge) {
>                 struct expr_parse_ctx *combined =3D NULL;
>
> +               find_tool_events(&metric_list, tool_events);
> +
>                 ret =3D hw_aware_build_combined_expr_ctx(&metric_list, &c=
ombined);
>
>                 if (!ret && combined && hashmap__size(combined->ids)) {
>                         ret =3D hw_aware_parse_ids(fake_pmu, combined,
>                                                 /*modifier=3D*/NULL,
> +                                               tool_events,
>                                                 &combined_evlist);
>                 }
>
> --
> 2.42.0
>

