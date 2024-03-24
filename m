Return-Path: <linux-kernel+bounces-112585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C70887BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E39B1C20DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E013AE2;
	Sun, 24 Mar 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLUY3mZ9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FC944F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711255933; cv=none; b=VLz/HQph5P1L3xYzxvpZEU28CQF88pwHWvuueMvpiikuz51wory1OehDWN9Rk/u2neC2HJEkCHKwsvPhYH7fwQ2Kqinm/Ek6KQfWDPQG3do1DgxFbEFAgaoI2b/xzizloL3NWvcx8V/iZjxvhDJp8RjIMvOoZlRbcxeTQkNfVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711255933; c=relaxed/simple;
	bh=2TzhJ+ohpStIBRRTmL29fxV+y9j54PyZF8FUOEVRKak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8OVnjuA1FlQWuQzRta0KlwF4EhTrCQsBxUYW8EK48OGMN9cG3wpoxm7Lm6rOOzfHgbV6Mo48+XXw6aKAhz9q92ddGhpiYlH8AvrbGR/7NPJ9Vrej/hNmwcpVbn7DNRjsgWcLeLGdw8hzoCNTSo3MIvJfax9UWv3cX6L/Ce+W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLUY3mZ9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e062f3a47bso96385ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711255931; x=1711860731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iR/YMAd653aJefBkELF3AxTlpDa+maIu2mSy0C+IGA=;
        b=GLUY3mZ9pTMynUR7trh/827Znn1p8stb7LYuhReqgl0ULSY/R8bHX89Pt9hEcMnZRo
         LdWjDbGYI4sSd3TQdV2FSf5EtieFcP/jc8JswV14RRAHYtwU4LPPn0/jHMUgic15YzkS
         vdtoaP8lDNTcrcrb1LIm8EQNqzUiYJzdNhPxP1xKM6xq+xYr9jKw6ZTcu9vPy95HGoIG
         1vfErqRW6ZkAGXzkK1OOIVg1cV2v+N8kksFQ8bFzYiRrKAIrOmaoVhmtvotLTRnLhJzz
         M8ezMqcyroieOC/yjMVgFzwqMzC+J3/FxvMvq93XNHkdhtm9E3BQ0BEhAk8MeOU7kI1u
         00Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711255931; x=1711860731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iR/YMAd653aJefBkELF3AxTlpDa+maIu2mSy0C+IGA=;
        b=judLcnl7rkM9W68tQGnk0HvVuhh6mT08CAaRG/ZP/fjsoHAnNmPrdykPJGQ5WFqbr0
         n2wCjAxnbgMDqU4WZnwAA92D6TXqxNjQkRzpvN4/dbgd4wlY3fyCyaGSDOMiqpW2xaUr
         IKvdB2uBjatcbZr9XKBnbPZFgX1wxVcoPsZtvQlIiPlEEWxN31QqV3UY4uFEyAFj8ZZS
         fhtDeLBvuDo1MdQUJ760ehTEUPsS7TzP1kIRkS3utzyLCVvdsYniMQO7zlOQM5eei8Ul
         wq6k6qFdVlXxqE52MeBEb2dwuxDrAGk1AhWgFiFWezAJTLY/eZhOrMvKWDzYwuQvqJW3
         WzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUxFGiu8YvkICzlkqeWZhwwjChaCWnmCPcgEGcwStcd9kxh9pQ0ulYHtcUkH/e8kGImI/e4T57H2iLANGEzRZJH8lJtDtEDo+Bd85Z9
X-Gm-Message-State: AOJu0YxpJ2+l+ijeyz2fBn/s4H6tKkanI139UPQLm6hsVwXy1vTjn8UI
	lpKkBRvHvghfUbfl9D5eaY8f+2LLFnzAOW3UHI2Y3SaKmt8laqv7F8+z+CxGR9ATByQ81ig7xGd
	/71HLgMQe/xozpzPy1je1JVACEFhxfetx3Cyy
X-Google-Smtp-Source: AGHT+IGoGnm7CXZ9g6n82HvTwUceeSYJ+Ltz8GwinKFKPjHi8xTp1bHMSCSZW71ecEQk5jOQki+BYxjxfS11yfgbkP0=
X-Received: by 2002:a17:902:c144:b0:1e0:4ec2:cbcd with SMTP id
 4-20020a170902c14400b001e04ec2cbcdmr768648plj.14.1711255930456; Sat, 23 Mar
 2024 21:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-6-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-6-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:51:59 -0700
Message-ID: <CAP-5=fVXoUhx0g3Z=DM6zd3vPgA_tAGN0wWc91mAM7QGVXgfow@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/15] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
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
> Add metricgroup__event_info data structure to represent an event in the
> metric grouping context; the list of counters and the PMU name an event
> should be collected with.
>
> Add functions to parse event counter info from pmu-events and generate a
> list of metricgroup__event_info data to prepare grouping.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 211 +++++++++++++++++++++++++++++++++-
>  1 file changed, 208 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index ee638578afdd..2a917220fb34 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -24,6 +24,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> +#include <linux/bitmap.h>
>  #include <perf/cpumap.h>
>  #include <subcmd/parse-options.h>
>  #include <api/fs/fs.h>
> @@ -157,6 +158,27 @@ struct metric {
>         struct evlist *evlist;
>  };
>
> +/* Maximum number of counters per PMU*/
> +#define NR_COUNTERS    16
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
> +       /** The event uses fixed counter*/
> +       bool fixed_counter;
> +       /** The event uses special counters that we consider that as free=
 counter
> +        *  during the event grouping*/
> +       bool free_counter;
> +       /** The counters the event allowed to be collected on. */
> +       DECLARE_BITMAP(counters, NR_COUNTERS);
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> @@ -1440,6 +1462,175 @@ static int build_combined_expr_ctx(const struct l=
ist_head *metric_list,
>         return ret;
>  }
>
> +/**
> + * set_counter_bitmap - The counter bitmap: [0-15].
> + */
> +static int set_counter_bitmap(int pos, unsigned long *bitmap)
> +{
> +       if (pos >=3D NR_COUNTERS || pos < 0)
> +               return -EINVAL;
> +       __set_bit(pos, bitmap);
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
> @@ -1453,9 +1644,25 @@ static int hw_aware_build_grouping(struct expr_par=
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
> @@ -1529,8 +1736,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake=
_pmu,
>         *out_evlist =3D parsed_evlist;
>         parsed_evlist =3D NULL;
>  err_out:
> -       parse_events_error__exit(&parse_error);
> -       evlist__delete(parsed_evlist);
>         metricgroup__free_grouping_strs(&groupings);
>         return ret;
>  }
> --
> 2.42.0
>

