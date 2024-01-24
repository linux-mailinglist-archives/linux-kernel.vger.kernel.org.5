Return-Path: <linux-kernel+bounces-37293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933B383ADDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB05286A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD747CF08;
	Wed, 24 Jan 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uccq1EsL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57621E503
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111852; cv=none; b=XqOCkJbXgOMxn1pZLJGCOk4Q4Gcyw9fel2/DR3WQLPSWExW40Fe6Sd+Go7hHxZ2w0KnEEk/s1F0nKih26mrnay/CBIBn3Pf9lEu2a6T7lyJoD9tMPow15+g8XHj5uKEi3g9KcwGN0u7PC1BLkIRHxmhHFYz1zmcanKzUZX43H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111852; c=relaxed/simple;
	bh=59AdwdtgM5YTqYQccogZ5V6a4viQM3dqI7tLjQuTMpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYkiI9Pp7Q51rFO4OU8Qo0uTr3CyzCWEYxjajy7soIf0Ziyl3rwqTDuRpJQVcTXfuif8otQ2UaAhLUnvC+qcIJR5TEYnsubLHyjPs+VnL49FgIPVBlMyXcof27erLt0kDWzC1BCa0xASR3GsU3Q12gMbFaHQ4stpoYezdrmZoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uccq1EsL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d76f1e3e85so180395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706111850; x=1706716650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vHGUU7w7sxAywce6jeZBVR/SVXGvRMcD5jS2PLJAMw=;
        b=Uccq1EsLyhB02nQ2ov6fbLGZCQFhguyeaC83XnAHiOF7o8TmHixKFyLxcKnH8rv/7T
         29tAR77sQ2NMqpKX1J77dwhiVaJgjIil7tFqLHPIOWjmhRNNYzewtrmyoOW1/dXOvurz
         XU/S1wAj91KxxUcjvCpFFmff4Y6G8ld1hVXTBpU2hibA9Py4+kqAKHUzCqNIAUvEIsrM
         Tf5Y5G7gIPRLcA37+PPZpf34bWr4B/GrpxG8Y9xdua/1zRgmxE0xg3OMa5hcO6yAW1So
         e0NaaJtn59zln/NHZAyftvuxGxEuzCcZxEE+bj5nRcfemB6v9dc77mIYBy1syFfWVpIU
         jKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706111850; x=1706716650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vHGUU7w7sxAywce6jeZBVR/SVXGvRMcD5jS2PLJAMw=;
        b=IHUoqGMINQBZyBvTW8HKQ9l3eYTrGIVrTsz1r2WIO4E3rR5yVaJXDLwEhVHqPxG64w
         t806yDNqEJxqOeQJkttExwSXiP/c07BRrY4iEfNZQNyuWEwI6WsXTMNCipnrNo/49gO4
         r1WbQ+N/CVul5zCsjGfWp5OwztddinzvxFFn0+ttVHgl2WnfpE9RvoJ4m9d3Jyg0540/
         XXtSXFQmZmLMA+IIoZoOvTAEqZcnvcPEqiYOovPz4qh35mIL1QjErq9d7+DpHdNol0Qf
         hvX7d7x78FdG2DKwdLa9zMse9Q5OkHpN/6gCw69Vj2TvbHTLwEZCP6b841X6nHaQj37v
         xO5g==
X-Gm-Message-State: AOJu0YwCLGOyeH2tISS6vUgsgxr1hjlNHMeSD5mZXNxJEfKGqsVqi6jE
	aZIMoAAF48dxgeJ9Zwh8b38FT8Tyuwc6g8Wl6Cc+5g84s69fEOUoibn2RyZ42akFg+TQKCaKYyD
	f06zs/P33s+VCQ10IlgVROq866fVQ9jEDfBjZ
X-Google-Smtp-Source: AGHT+IGdE9QIRm2sUO1r5wdqFl6c82ykxyOdQcNoIP/SVh28sPm5D/FWoe68WC9DpPiwFbAEBMRTDNRjmTdsr8yupuY=
X-Received: by 2002:a17:902:d4c3:b0:1d4:d451:b439 with SMTP id
 o3-20020a170902d4c300b001d4d451b439mr152655plg.5.1706111849630; Wed, 24 Jan
 2024 07:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-10-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-10-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 07:57:18 -0800
Message-ID: <CAP-5=fVc6UwFKezDKQuwe7yLhL5vofSKWthwLRByTEeqoeUs9w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/18] perf stat: Add functions to get counter info
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:03=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add data structure metricgroup__pmu_counters to represent hardware counte=
rs
> available in the system.
>
> Add functions to parse pmu-events and create the list of pmu_info_list to
> hold the counter information of the system.
>
> Add functions to free pmu_info_list and event_info_list before exit
> grouping for hardware-grouping method
>
> This method would fall back to normal grouping when event json files do n=
ot
> support hardware aware grouping.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 85 +++++++++++++++++++++++++++++++++--
>  tools/perf/util/metricgroup.h | 15 +++++++
>  2 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 24268882d355..a393584c7a73 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1507,6 +1507,27 @@ static int parse_counter(const char *counter,
>         return 0;
>  }
>
> +static void metricgroup__free_event_info(struct list_head
> +                                       *event_info_list)
> +{
> +       struct metricgroup__event_info *e, *tmp;
> +
> +       list_for_each_entry_safe(e, tmp, event_info_list, nd) {
> +               list_del_init(&e->nd);
> +               free(e);
> +       }
> +}
> +
> +static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
> +{
> +       struct metricgroup__pmu_counters *p, *tmp;
> +
> +       list_for_each_entry_safe(p, tmp, pmu_info_list, nd) {
> +               list_del_init(&p->nd);
> +               free(p);
> +       }
> +}
> +
>  static struct metricgroup__event_info *event_info__new(const char *name,
>                                                       const char *pmu_nam=
e,
>                                                       const char *counter=
,
> @@ -1525,7 +1546,7 @@ static struct metricgroup__event_info *event_info__=
new(const char *name,
>
>         e->name =3D name;
>         e->free_counter =3D free_counter;
> -       e->pmu_name =3D strdup(pmu_name);
> +       e->pmu_name =3D pmu_name;
>         if (free_counter) {
>                 ret =3D set_counter_bitmap(0, e->counters);
>                 if (ret)
> @@ -1560,6 +1581,8 @@ static int metricgroup__add_metric_event_callback(c=
onst struct pmu_event *pe,
>         struct metricgroup__add_metric_event_data *d =3D data;
>
>         if (!strcasecmp(pe->name, d->event_name)) {
> +               if (!pe->counter)
> +                       return -EINVAL;
>                 event =3D event_info__new(d->event_id, pe->pmu, pe->count=
er, /*free_counter=3D*/false);
>                 if (!event)
>                         return -ENOMEM;
> @@ -1599,7 +1622,7 @@ static int get_metricgroup_events(const char *full_=
id,
>                         .event_name =3D id,
>                         .event_id =3D full_id,
>                 };
> -               ret =3D pmu_events_table_for_each_event(table,
> +               ret =3D pmu_events_table__for_each_event(table, /*pmu=3D*=
/NULL,
>                                 metricgroup__add_metric_event_callback, &=
data);
>         }
>
> @@ -1608,6 +1631,57 @@ static int get_metricgroup_events(const char *full=
_id,
>         return ret;
>  }
>
> +static struct metricgroup__pmu_counters *pmu_layout__new(const struct pm=
u_layout *pl)
> +{
> +       struct metricgroup__pmu_counters *l;
> +
> +       l =3D zalloc(sizeof(*l));
> +
> +       if (!l)
> +               return NULL;
> +
> +       l->name =3D pl->pmu;
> +       l->size =3D pl->size;
> +       l->fixed_size =3D pl->fixed_size;
> +       pr_debug("create new pmu_layout: [pmu]=3D%s, [gp_size]=3D%ld, [fi=
xed_size]=3D%ld\n",
> +               l->name, l->size, l->fixed_size);
> +       return l;
> +}
> +
> +static int metricgroup__add_pmu_layout_callback(const struct pmu_layout =
*pl,
> +                                               void *data)
> +{
> +       struct metricgroup__pmu_counters *pmu;
> +       struct list_head *d =3D data;
> +       int ret =3D 0;
> +
> +       pmu =3D pmu_layout__new(pl);
> +       if (!pmu)
> +               return -ENOMEM;
> +       list_add(&pmu->nd, d);
> +       return ret;
> +}
> +
> +/**
> + * get_pmu_counter_layouts - Find counter info of the architecture from
> + * the pmu_layouts table
> + * @pmu_info_list: the list that the new counter info of a pmu is added =
to.
> + * @table: pmu_layouts table that is searched for counter info.
> + */
> +static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
> +                                  const struct pmu_layouts_table
> +                                  *table)
> +{
> +       LIST_HEAD(list);
> +       int ret;
> +
> +       ret =3D pmu_layouts_table__for_each_layout(table,
> +                                               metricgroup__add_pmu_layo=
ut_callback, &list);
> +
> +       list_splice(&list, pmu_info_list);
> +       return ret;
> +}
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1626,6 +1700,7 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>         LIST_HEAD(event_info_list);
>         size_t bkt;
>         const struct pmu_events_table *etable =3D perf_pmu__find_events_t=
able(NULL);
> +       const struct pmu_layouts_table *ltable =3D perf_pmu__find_layouts=
_table(NULL);
>
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
> @@ -1635,9 +1710,13 @@ static int hw_aware_build_grouping(struct expr_par=
se_ctx *ctx __maybe_unused,
>
>                 ret =3D get_metricgroup_events(id, etable, &event_info_li=
st);
>                 if (ret)
> -                       return ret;
> +                       goto err_out;
>         }
> +       ret =3D get_pmu_counter_layouts(&pmu_info_list, ltable);
>
> +err_out:
> +       metricgroup__free_event_info(&event_info_list);
> +       metricgroup__free_pmu_info(&pmu_info_list);
>         return ret;
>  #undef RETURN_IF_NON_ZERO
>  }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 3704545c9a11..802ca15e7c6b 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -94,6 +94,21 @@ struct metricgroup__event_info {
>         DECLARE_BITMAP(counters, NR_COUNTERS);
>  };
>
> +/**
> + * A node is the counter availability of a pmu.
> + * This info is built up at the beginning from JSON file and
> + * used as a reference in metric grouping process.
> + */
> +struct metricgroup__pmu_counters {
> +       struct list_head nd;
> +       /** The name of the pmu the event collected on. */
> +       const char *name;
> +       //DECLARE_BITMAP(counter_bits, NR_COUNTERS);

nit: this can go.

> +       /** The number of gp counters in the pmu. */
> +       size_t size;
> +       size_t fixed_size;

nit: same naming concern.

Thanks,
Ian

> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> --
> 2.39.3
>

