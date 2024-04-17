Return-Path: <linux-kernel+bounces-147962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3898A7BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD91C2154D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27052F6B;
	Wed, 17 Apr 2024 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuGOtmH8"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFB4C3CD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332165; cv=none; b=Ct60wV5plRlQcHpq00KV2DcwDq+JI0wrbfHZ2EzyZm7rqy9TF6M+7/77xdExsHCN0GX8itmbNkoSUf35ZMJ0XNajPRWIS+TwjH/F0+kLeCkrITwo5Mja3c/TsZ2n3FxxcWF3Fra5AbavqWuFJF2Z5qxdhqwC1z4+px70SxtH7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332165; c=relaxed/simple;
	bh=jdAVmsrYkcgWF1g0NDjK8an0jNqUcDRJ4bbfsPb0+vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsXunNVBVSP0Iwd4exIRwPEg0h0WXX3Rks0NPhIkOkJdPmDT2ZVWfc9aeTrpy30/I77BTMzxyYQWaZ4+WrtgQrVyPW40zgPUlS99J4JA5/D2HwrmzYY1Wr+CO4QOAXZL0k5bCm0072uH7mBNMjeu/8G0+9GioEpinFh34HborG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuGOtmH8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4348110e888so192941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713332162; x=1713936962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9eKB3Ujqnvb3PJDU5T9l+75UEHa6QrJcsg9YjTE6PA=;
        b=WuGOtmH88T0Y9WeCfjDxPjEXsmzALtQNv0VrEkyUpJcOePUPkjvdu/f2gLlQV1bIp3
         KGJmB3sNglo/LxP60aeM6jTvI1PoR3eXZ2YUI5VGbyFN1I6oZOISzKSoxPft/loA/OUn
         dkoDE/Mb2nWuvayJSvC9/m2IsTUFmgjUluV/+50WsQuq2EOEJKd6y2YkpXylQ30fIdFo
         +upy9N2QcyfJQUPhnunKOxrNc64nrWabaXtrjq1bZf27/yo/rw1G67+HA6f6A+TqaCBm
         95uQCOIIL8/sHrQ5atwN4ZXwm45UTkv2y2lVgMhG7AuzAptms00c8bRVQe7y5e39lgvE
         xMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713332162; x=1713936962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9eKB3Ujqnvb3PJDU5T9l+75UEHa6QrJcsg9YjTE6PA=;
        b=KtIBDkZTM0h/bGsvRIJ2r4pbGjCPkJmgINNQyt+KkUoYJrlIVggknj6w/DyooavUSQ
         CPFI5vq0CHzQ2iF1ZS1jx9yxQqwLNJYo7DKbsSUEyfPP6g6RMAewtIBp2BAPGFW8Z9FK
         W6ApqMWB3K2hkh1CYRuZAwCVF9/aQbt8qXtuBLU27XR/3TnwLYPiBsBlpXzCtXzNik7p
         uCUhgKVcf147S5r3XrUXf2wwl6iaz1oMJXN3xTYZaeeaVyLWOh8/Z6ndywlm5Yo/IZ2y
         BjyNWEqaAVpTPMua/Tn7/xpHqI+rUSC+oVOHEe5HEBAk4DvOSO5/F63U8SBN1Tr0ibix
         6DpA==
X-Forwarded-Encrypted: i=1; AJvYcCXSsciLIq7qrEXikO3+ixGO9kG/IYFn9mZpbbFIgm8DEjyMUo5PUdq/xx24bJ/WhMrtN0GEDYFexVP40MD/DAJ9svKr+7fDi559O1Iv
X-Gm-Message-State: AOJu0Yw9l3GvgcsdSegRuOyyLkUgYsRlwpbw7HIeIWMu2MTLLQY3DZeE
	HqsTZiZsNZGMerfAfebRUxxT7Lmxany4tb8XQntH/NOUQo1KSVNG0QRylWFeFOpKQk0AhCNxsWa
	kp+tJFckSpfyOjwlnSKp903KjbrkMZpoP0i5r
X-Google-Smtp-Source: AGHT+IGvKjSv6zFuRNTSIMPA0maEcElgQ72YYipE6Hp3n3W18cH8rZM+Io8D7pjf6Baha7Gz7w8HBA/kTuPKvpEdOCk=
X-Received: by 2002:ac8:5dd4:0:b0:437:7a02:d66c with SMTP id
 e20-20020ac85dd4000000b004377a02d66cmr15251qtx.25.1713332161985; Tue, 16 Apr
 2024 22:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-6-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-6-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 22:35:48 -0700
Message-ID: <CAP-5=fWX9rttA5m4MtwzTEp-ocw=sdXw34L=PW7rdt+mOdesig@mail.gmail.com>
Subject: Re: [RFC PATCH v5 05/16] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
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
> Add metricgroup__event_info data structure to represent an event in the
> metric grouping context; the list of counters and the PMU name an event
> should be collected with.
>
> Add functions to parse event counter info from pmu-events and generate a
> list of metricgroup__event_info data to prepare grouping.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 219 +++++++++++++++++++++++++++++++++-
>  1 file changed, 216 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 8047f03b2b1f..1a7ac17f7ae1 100644
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
> @@ -159,6 +160,29 @@ struct metric {
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
> +       /** The event uses fixed counter. */
> +       bool fixed_counter;
> +       /**
> +        * The event uses special counters that we consider that as free =
counter
> +        * during the event grouping.
> +        */
> +       bool free_counter;
> +       /** The counters the event allowed to be collected on. */
> +       DECLARE_BITMAP(counters, NR_COUNTERS);
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> @@ -1440,6 +1464,181 @@ static int build_combined_expr_ctx(const struct l=
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
> +       /* TODO: this pattern maybe different on some other platforms */
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
> +       /* ret=3D=3D0 means matched with fixed counter */
> +       if (ret =3D=3D 0)
> +               return ret;
> +
> +       p =3D strdup(counter);
> +       if (!p)
> +               return -ENOMEM;
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
> +       e->name =3D strdup(name);
> +       e->pmu_name =3D strdup(pmu_name);
> +       if (!e->pmu_name || !e->name)
> +               return NULL;
> +       e->free_counter =3D free_counter;
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

I'm seeing a build error at this patch:
```
  CC      /tmp/perf/util/metricgroup.o
util/metricgroup.c: In function =E2=80=98metricgroup__add_metric_event_call=
back=E2=80=99:
util/metricgroup.c:1592:65: error: =E2=80=98const struct pmu_event=E2=80=99=
 has no
member named =E2=80=98counter=E2=80=99
 1592 |                 event =3D event_info__new(d->event_id, pe->pmu,
pe->counter, /*free_counter=3D*/false);
      |                                                                 ^~
util/metricgroup.c: In function =E2=80=98get_metricgroup_events=E2=80=99:
util/metricgroup.c:1633:23: error: implicit declaration of function
=E2=80=98pmu_events_table_for_each_event=E2=80=99; did you mean
=E2=80=98pmu_events_table__for_each_event=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 1633 |                 ret =3D pmu_events_table_for_each_event(table,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                       pmu_events_table__for_each_event
cc1: all warnings being treated as errors
```
it must be resolved by a later patch,

Thanks,
Ian

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
> +               if (!id) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
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
> @@ -1453,9 +1652,25 @@ static int hw_aware_build_grouping(struct expr_par=
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
> @@ -1529,8 +1744,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake=
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

