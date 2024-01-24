Return-Path: <linux-kernel+bounces-36464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1583A137
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C8C1C20A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C5D27F;
	Wed, 24 Jan 2024 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxdkHBGl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF676DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073475; cv=none; b=CAnm5CUyZCzqIXMJOuadNZtEUqZRra39B3f7uPwpHZcQDHiD5lIzaPZmsI03Vt8Z0wKic3nOOsEGqCYhgVxR7iJDe2mvFEys7xiAynrSqnV1V4sAXpoLWDfiUtN2vwJNYVTOQ3itKM44ht5q+yvehdAjpm4HvY8oEg3ciU6X8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073475; c=relaxed/simple;
	bh=Fjcc+5N6u6Oo8RhwYUPXJcP7GR7I9RTOaFaqoVwvT/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYvB0me4stCZnXCOhVY5zUXs/WGGWByzoSDo7CPaKNQaYFLQzKLxpXYR/22p6wZXkSX+oBH7Nu932R6WuTOd9sfswFn9NNt8FTxaSdrq+sGbJ3Tmmj3o114eaR0Pr66QUPsSXurc0UYqFcyj7l3EV/3QEu2I7M1AIZ73iwoWOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxdkHBGl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d72043fa06so48195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706073473; x=1706678273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h1jgOr5+Xh2NY4AzoO8uEaBBEk7vdZMCpbgjfuhJWw=;
        b=xxdkHBGlPToqELBtyeENx5xVAl8MmGbu3GZ/kCaW8cgUG3Ylmgd6vQRLCL4yIakqsb
         V9x/gIicA7y2dX1u9YA8xc4Ul0Y0q2M6IZnSw4De7Xox/7DBfXpxebNVhVpLe6S6fgyn
         EjtW1+VSmQ3svg3QduNcXRuiWznIrUSq9BhfToEmDVSwN0UNK+47g/V9/qwtHsJMeEKc
         RNMgUk/n/CPqPMwx215jxnnY5HxAQUlv8JrGtltINj4N0HBE8FHqY4+VR+rq/QDQar6W
         9mwjUTUTe/rQEyZUeSVruckDQatc/10eIfq9SO39tD25MbkLOlEO+4bUivx5NOmTDCS3
         Jx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706073473; x=1706678273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h1jgOr5+Xh2NY4AzoO8uEaBBEk7vdZMCpbgjfuhJWw=;
        b=oTjoO1vDmJWEQBhCnmB7Tfjy8n4FxT+FkuK1USLW+TKxfyNl+w6PpDAPyHQot38GKR
         HlFglEXlljqHEtURk9tVcqVIgPBc7FP2HRg9gkkaQ/k7wEb0Qc7yLqcjIGgf4ic2hKjy
         HTuVX6Y+UNZpswX5jksm/ON+06zcy4j38BS0ObIh4FXjLBbypX5UC7gOgj3+b1leO5Qr
         mK7dyYwvnC1AW9cL4o8O7IhZZuPzNBgq5QdHqB9lmt4i+MzxpkyjFZ18W2vmpWhv+Tb9
         8LbjKjZEeFri4ttb6xhTuDZjrxquKhaet5FHDrPfBLw8HmToPsbrjOlj7UU/OjQtt0qn
         jldw==
X-Gm-Message-State: AOJu0Yxes4U0wUp7XL7Ct89al+jXbdB3Ewejw1LJnluyEoE72USBRfVl
	c+YgL9qO+GK+jE5q8neX8T9wl2TeAiKZPmMjiUvlrx090NL9shAnndDngWSQADpyoD870cVDUuA
	POB5PjEGxlaGCPI+POBByjOjCLR8d+hCLhwVO
X-Google-Smtp-Source: AGHT+IGeE4Xq7LjtEWLQrymxCAASnjq56PuhRhpkD8qBdhdsYIV77T2vf/igvxNrg5VX+9B/8CwmHxW7V11539xU8b4=
X-Received: by 2002:a17:902:d185:b0:1d7:7a5a:61ab with SMTP id
 m5-20020a170902d18500b001d77a5a61abmr30640plb.3.1706073472952; Tue, 23 Jan
 2024 21:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-9-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-9-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 21:17:41 -0800
Message-ID: <CAP-5=fUK9YtvhiZjkkBAxHJ=jenrKMQJ-HdK+qj8k+3b7T6OqA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/18] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
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
> Add metricgroup__event_info data structure to represent an event in the
> metric grouping context; the list of counters and the PMU name an event
> should be collected with.
>
> Add functions to parse event counter info from pmu-events and generate a
> list of metricgroup__event_info data to prepare grouping.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 196 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/metricgroup.h |  27 +++++
>  2 files changed, 220 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 8d1143ee898c..24268882d355 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1432,6 +1432,182 @@ static int build_combined_expr_ctx(const struct l=
ist_head *metric_list,
>         return ret;
>  }
>
> +/**
> + * set_counter_bitmap - The counter bit mapping: [8-15,0-7], e.g. the GP=
0 is the
> + * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. It is helpful =
for
> + * assigning GP4-7 before GP0-3 because some events can be collected usi=
ng GP0-3
> + * only on some platforms.
> + */
> +static int set_counter_bitmap(int pos, unsigned long *bitmap)
> +{
> +       if (pos >=3D NR_COUNTERS || pos < 0)
> +               return -EINVAL;
> +       if (pos <=3D 7)
> +               pos =3D TRANSFER_FIRST_BYTE(pos);
> +       else
> +               pos =3D TRANSFER_SEC_BYTE(pos);
> +       *bitmap |=3D 1ul << pos;

__set_bit may be more canonical here, in case we ever had more than 64 coun=
ters.

> +       return 0;
> +}
> +
> +static int parse_fixed_counter(const char *counter,
> +                             unsigned long *bitmap,
> +                             bool *fixed)
> +{
> +       int ret =3D -ENOENT;
> +       //TODO: this pattern is different on some other platforms
> +       const char *pattern =3D "Fixed counter ";
> +       int pos =3D 0;
> +
> +       if (!strncmp(counter, pattern, strlen(pattern))) {
> +               pos =3D atoi(counter + strlen(pattern));
> +               ret =3D set_counter_bitmap(pos, bitmap);
> +               if (ret)
> +                       return ret;
> +               *fixed =3D true;
> +               return 0;
> +       }
> +       return ret;
> +}

It'd be nice if the counter APIs that are specific to a PMU could be
part of the struct pmu API.

> +
> +/**
> + * parse_counter - Parse event counter info from pmu-events and set up b=
itmap
> + * accordingly.
> + *
> + * @counter: counter info string to be parsed.
> + * @bitmap: bitmap to set based on counter info parsed.
> + * @fixed: is set to true if the event uses fixed counter.
> + */
> +static int parse_counter(const char *counter,
> +                       unsigned long *bitmap,
> +                       bool *fixed)
> +{
> +       int ret =3D 0;
> +       char *p;
> +       char *tok;
> +       int pos =3D 0;
> +
> +       ret =3D parse_fixed_counter(counter, bitmap, fixed);
> +       // ret=3D=3D0 means matched with fixed counter
> +       if (ret =3D=3D 0)
> +               return ret;
> +
> +       p =3D strdup(counter);
> +       tok =3D strtok(p, ",");
> +       if (!tok)
> +               return -ENOENT;
> +
> +       while (tok) {
> +               pos =3D atoi(tok);
> +               ret =3D set_counter_bitmap(pos, bitmap);
> +               if (ret)
> +                       return ret;
> +               tok =3D strtok(NULL, ",");
> +       }
> +       return 0;
> +}
> +
> +static struct metricgroup__event_info *event_info__new(const char *name,
> +                                                     const char *pmu_nam=
e,
> +                                                     const char *counter=
,
> +                                                     bool free_counter)
> +{
> +       int ret =3D 0;
> +       char *bit_buf =3D malloc(NR_COUNTERS);
> +       bool fixed_counter =3D false;
> +       struct metricgroup__event_info *e;
> +
> +       e =3D zalloc(sizeof(*e));
> +       if (!e)
> +               return NULL;
> +       if (!pmu_name)
> +               pmu_name =3D "core";
> +
> +       e->name =3D name;
> +       e->free_counter =3D free_counter;
> +       e->pmu_name =3D strdup(pmu_name);
> +       if (free_counter) {
> +               ret =3D set_counter_bitmap(0, e->counters);
> +               if (ret)
> +                       return NULL;
> +       } else {
> +               ret =3D parse_counter(counter, e->counters, &fixed_counte=
r);
> +               if (ret)
> +                       return NULL;
> +               e->fixed_counter =3D fixed_counter;
> +       }
> +
> +       bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
> +       pr_debug("Event %s requires pmu %s counter: %s bitmap %s, [pmu=3D=
%s]\n",
> +               e->name, e->pmu_name, counter, bit_buf, pmu_name);
> +
> +       return e;
> +}
> +
> +struct metricgroup__add_metric_event_data {
> +       struct list_head *list;
> +       /* pure event name, exclude umask and other info*/
> +       const char *event_name;
> +       /* event name and umask if applicable*/
> +       const char *event_id;
> +};
> +
> +static int metricgroup__add_metric_event_callback(const struct pmu_event=
 *pe,
> +                                                const struct pmu_events_=
table *table __maybe_unused,
> +                                                void *data)
> +{
> +       struct metricgroup__event_info *event;
> +       struct metricgroup__add_metric_event_data *d =3D data;
> +
> +       if (!strcasecmp(pe->name, d->event_name)) {
> +               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
er, /*free_counter=3D*/false);
> +               if (!event)
> +                       return -ENOMEM;
> +               list_add(&event->nd, d->list);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * get_metricgroup_events - Find counter requirement of events from the
> + * pmu_events table
> + * @full_id: the full event identifiers.
> + * @table: pmu_events table that is searched for event data.
> + * @event_info_list: the list that the new event counter info added to.
> + */
> +static int get_metricgroup_events(const char *full_id,
> +                                const struct pmu_events_table *table,
> +                                struct list_head *event_info_list)
> +{
> +       LIST_HEAD(list);
> +       int ret =3D 0;
> +       const char *id;
> +       const char *rsep, *sep =3D strchr(full_id, '@');
> +
> +       if (sep) {
> +               rsep =3D strchr(full_id, ',');
> +               id =3D strndup(sep + 1, rsep - sep - 1);
> +               if (ret)
> +                       goto out;
> +       } else {
> +               id =3D full_id;
> +       }
> +       {
> +               struct metricgroup__add_metric_event_data data =3D {
> +                       .list =3D &list,
> +                       .event_name =3D id,
> +                       .event_id =3D full_id,
> +               };
> +               ret =3D pmu_events_table_for_each_event(table,
> +                               metricgroup__add_metric_event_callback, &=
data);
> +       }
> +
> +out:
> +       list_splice(&list, event_info_list);
> +       return ret;
> +}
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1445,9 +1621,25 @@ static int hw_aware_build_grouping(struct expr_par=
se_ctx *ctx __maybe_unused,
>                                   const char *modifier __maybe_unused)
>  {
>         int ret =3D 0;
> +       struct hashmap_entry *cur;
> +       LIST_HEAD(pmu_info_list);
> +       LIST_HEAD(event_info_list);
> +       size_t bkt;
> +       const struct pmu_events_table *etable =3D perf_pmu__find_events_t=
able(NULL);
> +
> +#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +       hashmap__for_each_entry(ctx->ids, cur, bkt) {
> +               const char *id =3D cur->pkey;
> +
> +               pr_debug("found event %s\n", id);
> +
> +               ret =3D get_metricgroup_events(id, etable, &event_info_li=
st);
> +               if (ret)
> +                       return ret;
> +       }
>
> -       pr_debug("This is a placeholder\n");
>         return ret;
> +#undef RETURN_IF_NON_ZERO
>  }
>
>  static void group_str_free(struct metricgroup__group_strs *g)
> @@ -1521,8 +1713,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake=
_pmu,
>         *out_evlist =3D parsed_evlist;
>         parsed_evlist =3D NULL;
>  err_out:
> -       parse_events_error__exit(&parse_error);
> -       evlist__delete(parsed_evlist);
>         metricgroup__free_grouping_strs(&groupings);
>         return ret;
>  }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 89809df85644..3704545c9a11 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -5,6 +5,7 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <stdbool.h>
> +#include <linux/bitmap.h>
>  #include "pmu-events/pmu-events.h"
>  #include "strbuf.h"
>
> @@ -67,6 +68,32 @@ struct metric_expr {
>         int runtime;
>  };
>

If this is just used in metricgroup.c then it'd be better to keep the
definitions there for the sake of encapsulation.

> +/* Maximum number of counters per PMU*/
> +#define NR_COUNTERS    16

Fixed and/or generic?

> +/*
> + * Transfer bit position in the bitmap to ensure start assigning counter=
 from
> + * the last GP counter to the first.
> + * bit15 <---> bit0
> + * [GP8-GP15] [GP0-GP7]
> + */
> +#define TRANSFER_FIRST_BYTE(pos) (7 - pos)
> +#define TRANSFER_SEC_BYTE(pos) (23 - pos)

Not sure why this bit flipping is necessary, if fixed counters are
separated out to their own bitmap does it help?

> +
> +/**
> + * An event used in a metric. This info is for metric grouping.
> + */
> +struct metricgroup__event_info {
> +       struct list_head nd;
> +       /** The name of the event. */
> +       const char *name;
> +       /** The name of the pmu the event be collected on. */
> +       const char *pmu_name;

Could we use the "struct pmu*" here?

> +       bool fixed_counter;
> +       bool free_counter;

Missing comment for *_counter.

Thanks,
Ian

> +       /** The counters the event allowed to be collected on. */
> +       DECLARE_BITMAP(counters, NR_COUNTERS);
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> --
> 2.39.3
>

