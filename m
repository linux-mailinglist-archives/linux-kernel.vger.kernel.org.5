Return-Path: <linux-kernel+bounces-112587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35A887BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AA0282563
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E913FF6;
	Sun, 24 Mar 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Xqo8yzy"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E6134BE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711256302; cv=none; b=NHtC24WbOCQg+8S17qVkFK0IXw2yV+lG2RFHXKBfrbwN9kXHJpE79/coCBVFPfJ6NDSgjfvpgCumfb/fiFB8cPtWDRl6v2aVmudBu+WC8Yyf1JBYJFYFQv+BWt6DPSz917hdt2kj8/4oPFDSS3wZSjyOE2lPFzGyFn4pua1mtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711256302; c=relaxed/simple;
	bh=Gu6WmAVAclfnwbUUBsxi8oNc/q6lur63hnxYQBkX69M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNRrkwNxDZpWrCSSnk4w8VbaRSgcWsICa34sf9C6D5l7eFBVd3o8XF7/+5sJBUld7OMKFxWR3L6pS/b79od/gAY/NWxQTq9a3trO5OS5X8IsL+tvb/wMn3PTEt77P3SXfzJCRmD+ItSe3+P/07Xa8WMeQ5BqKGHeJspDuDNQgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Xqo8yzy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so200071cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711256299; x=1711861099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY//JH8+Rx3oZ3x/aWWGC7L77LyNr1dunyhwT54TMMI=;
        b=3Xqo8yzyu7AboN8rUdFa24jMTlwP1QfIitrvWr8HFXt/1fCsn+0uqAQQ8vkLSc63oe
         1Yozn94AfVLdYyhcNJlliFEfida7g5jzrfzefxfsKx4j8AGCLV45IGIdFR3wqgNQiEAS
         RsoblSkUkxFvEp6v2mmv5QQPJlf1bXIVwC5f5zXLK3k7Gc4+0ZbpI4ytsGXExDuAKu57
         sXKbHGUUOx93A5D3/HBxB7tZomRUeXFhqShcZ7h9CTGvf4+Q6lkuTS2Kzdl67Nw9oQJL
         ofCxsJ6puCG0Igb7UY6Qc57wzBdm4VcdQ4/Xif/yjONY2tSbw6nRHVKYVSAxFRyT8yKx
         tlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711256299; x=1711861099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY//JH8+Rx3oZ3x/aWWGC7L77LyNr1dunyhwT54TMMI=;
        b=Uc+OBpHJCUAY/cLHZOVNiNPbRUuyHbk0Y75vl9BXolVo5t/a4zSvvLDxNqcAeCT5Mr
         dgmVEBxJsS+Fi7OBxeJ25h1jZzMi2TwO7cp9Mnl+uXfMPG4oQI9HAuCdKthpd4C6xaBR
         eV3YqB1VYxY5zpORmJLEf0M/IeWcx2mNCGu4SUFCjzst6z4cCgUmLlls1IQIijnR0wYj
         btVEomBRRhL5kNVi7JPcGpjpX/DnjqbbIEMqJtWxSV+xXPdsgNbSt9ZHz4B7A4eF/Ysj
         MIMNoEL/MGS6c35OU9g7X6uzEaimpn0XmejLh7wOw/lYGvZxt8oJN7MXDwx1SEJ5KBLc
         EwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2lV0Ea0co5lAo7a/GIZQ7jsScSKuCD9MYafmahbdEM9MGLX19wv0MXkJPCSjTUddv9mOssAY7hLXGgv2wvMUBJjx/bCq0POuD5D5
X-Gm-Message-State: AOJu0Yx1abObDkCKcSdgO6fpdWZ7eYJ7EfeSBUMo13rayqL+cj3ROTGf
	WqaYAZSX9tWDwOov+cWGTIAi0YhoMMhqJDMvAyJeDp4N878LqAi/8MXmLEw8XWabBHS7r+lKbH3
	8vgDxXZhD1RskyZ+hLOvwrCWFnD588AKVbnud
X-Google-Smtp-Source: AGHT+IEh4lGd8nHzLHIi/RvfxCQ/XmqIhKb/J0p1RLSmdYaDboNf82KRHWSG68zD5PxR/7eMC2VXvwu08GORzEaOXKY=
X-Received: by 2002:a05:622a:3ce:b0:431:55a:57fa with SMTP id
 k14-20020a05622a03ce00b00431055a57famr909008qtx.16.1711256299136; Sat, 23 Mar
 2024 21:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-7-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-7-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:58:08 -0700
Message-ID: <CAP-5=fX1-oO-Q6Oj3G3FmpMunXv=ufUwCBK0-XHtEgvb1SescA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 06/15] perf stat: Add functions to get counter info
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 101 ++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 2a917220fb34..9061ed4ca015 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -179,6 +179,20 @@ struct metricgroup__event_info {
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
> +       /** The number of gp counters in the pmu. */
> +       size_t num_counters;
> +       size_t num_fixed_counters;
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> @@ -1530,6 +1544,27 @@ static int parse_counter(const char *counter,
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
> @@ -1548,7 +1583,7 @@ static struct metricgroup__event_info *event_info__=
new(const char *name,
>
>         e->name =3D name;
>         e->free_counter =3D free_counter;
> -       e->pmu_name =3D strdup(pmu_name);
> +       e->pmu_name =3D pmu_name;
>         if (free_counter) {
>                 ret =3D set_counter_bitmap(0, e->counters);
>                 if (ret)
> @@ -1583,7 +1618,9 @@ static int metricgroup__add_metric_event_callback(c=
onst struct pmu_event *pe,
>         struct metricgroup__add_metric_event_data *d =3D data;
>
>         if (!strcasecmp(pe->name, d->event_name)) {
> -               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
er, /*free_counter=3D*/false);
> +               if (!pe->counters)
> +                       return -EINVAL;
> +               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
ers, /*free_counter=3D*/false);
>                 if (!event)
>                         return -ENOMEM;
>                 list_add(&event->nd, d->list);
> @@ -1622,7 +1659,7 @@ static int get_metricgroup_events(const char *full_=
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
> @@ -1631,6 +1668,57 @@ static int get_metricgroup_events(const char *full=
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
> +       l->num_counters =3D pl->num_counters;
> +       l->num_fixed_counters =3D pl->num_fixed_counters;
> +       pr_debug("create new pmu_layout: [pmu]=3D%s, [gp_size]=3D%ld, [fi=
xed_size]=3D%ld\n",
> +               l->name, l->num_counters, l->num_fixed_counters);
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
> @@ -1649,6 +1737,7 @@ static int hw_aware_build_grouping(struct expr_pars=
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
> @@ -1658,9 +1747,13 @@ static int hw_aware_build_grouping(struct expr_par=
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
> --
> 2.42.0
>

