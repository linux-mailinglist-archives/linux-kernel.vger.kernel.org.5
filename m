Return-Path: <linux-kernel+bounces-37963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDB83B8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FFC2863E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF079F9;
	Thu, 25 Jan 2024 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPd0Tl0T"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF879E2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158981; cv=none; b=imIvzFWYVFRLTU9AwfS5L3QkEoSCpdaAuC4zRZH2jQrVnU4b5FHWzhukcMQ81TxGFEVs5nthiHwehIM6Ll2+UtTG4Cj38BiMmPhJCV9ZnDeCD5PEQY/P4pgwVLaMVVBaHQH0uVJSdmEPc+R6GS02LxwbWWydafdH3jp4RgLxakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158981; c=relaxed/simple;
	bh=yTBxAtNAlvrRrXbqqbEnwj1k8Nfg8dzee4sOknZfLx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAwtNUSkx0sgt2iaE+8h5GCKxtIft+ziAaxtMesfnLa3cNR0G5BXlzbEGnh5xFlYjoFJt3dm+NggKxZ2N2OHFe+xJoMw0KZVBvaIeTDEE/sXaeorih/g52RxjkyiKasvuJvBq7FDz2g5nFCMbnDO+Zdxh9G5Sn/T6KzV3jebfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPd0Tl0T; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so97105ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706158979; x=1706763779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur2qqL2Es+nWoI5h1PMfL0sOBCl4L69zJ184CV5RlLY=;
        b=OPd0Tl0TUdnYkz8RVfA6/4fu7qrt9cNgUdq9Jx93x3bhVIizvv+8fkG9Z31hfcApZh
         wZ/AaAmJgzTWL8Ge2+OeLKDS61qaMx16xb0vIEWwuvpuZsOpQAbwxeCf9HWCMWqjY0qk
         ErDY5U1U3T5SGO54l0fJP4EaNbD429dodo+V//Uqu3mn4nuGGBh7UcMJmjmBtd3ORrDI
         rAICnDo44g8EvyxxVwy1fHbxzIqbMjGi1xEny+1zD/8Sn8UYP/IZu9ayQ9dkeHo2MIHi
         2U/w6q2lpf7Jrmnei5k5D4E9utQ0VmDOxKonMe8rhJOYoJ+CwdbHuEKLKxlDC8ZxELBA
         RXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158979; x=1706763779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur2qqL2Es+nWoI5h1PMfL0sOBCl4L69zJ184CV5RlLY=;
        b=VrG0YzSt5nO0WGwexItiJP79JYJ9rMwIzHsCv/zVoaLY+u/yqJpW2p9UsfiELW8v9a
         1d1mkuDPLIKlQn0nysvkh5UXc04tF4DeQaXbwoC14ELMxf5UHbg+NypBCcVX7Pv0jjTB
         OGpVMkCJQ6z0+fhvqt/JTF4a7JlcdZREVKeliHyBC+AuYmkFCxwf+p5M2ygQyCx+4YPq
         IbUAVxpPkP5ZvqurtoEwHDu9PINyZEVbUf/gXdSPS0YCjC9O3xk1Si7Hg40Et2QVoyO/
         4PUekt5Ek1ZGcKL5UFjXeOEiz6O1XyVoNBleVJKEMqPu0u8J/HaasZRdX6FC3jaY1g9F
         khFA==
X-Gm-Message-State: AOJu0YwcReIvmNyjCudwcDQBSAe+RZays6eIEmFaT8jdIaDpc+oel8Zs
	+veEL/HDBiPbB6XGatc8YYSkXQbAioWJK8Ks/0Zxe0OKdw9l9V0nCj58QrUUQIjUOVoc1f7qRhc
	8rEE4WNb+lexXo1pe9HUBMMzQQlkX7tSY/XQR
X-Google-Smtp-Source: AGHT+IHPyGcGj5jZf6bgCbSGqVdUxaQs8+5U+0wBvnaRCVoFQePFQ44IuOviDKQWe9kJu0KjrJMy2qAcaZW2WCpmlNk=
X-Received: by 2002:a05:6e02:dc2:b0:361:8f09:f6d9 with SMTP id
 l2-20020a056e020dc200b003618f09f6d9mr93503ilj.9.1706158978556; Wed, 24 Jan
 2024 21:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-15-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-15-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 21:02:47 -0800
Message-ID: <CAP-5=fU4k-V7+bq7evP4Kr6ng5eSTmYQKp9cqsRX6KRZWiRVFw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 13/18] perf stat: Handle taken alone in hardware-grouping
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
> Add taken alone into consideration when grouping. Only one taken
> alone event is supported per group.

This seems to be a deficiency also in parse_events__sort_events_and_fix_gro=
ups:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2025
Is there an example of events that must be taken alone? Perhaps
because they share a fixed counter?

Thanks,
Ian

> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py   |  7 +++++--
>  tools/perf/pmu-events/pmu-events.h |  1 +
>  tools/perf/util/metricgroup.c      | 18 +++++++++++++-----
>  tools/perf/util/metricgroup.h      |  2 ++
>  4 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 16f17d335f8e..e5919e5e6d4a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -55,7 +55,9 @@ _json_event_attributes =3D [
>      # Counter this event could use
>      'counter',
>      # Longer things (the last won't be iterated over during decompress).
> -    'long_desc'
> +    'long_desc',
> +    # Taken alone event could not be collected in the same group with ot=
her taken alone event
> +    'taken_alone'
>  ]
>
>  # Attributes that are in pmu_unit_layout.
> @@ -71,7 +73,7 @@ _json_metric_attributes =3D [
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
>  _json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg',
> -    'size', 'fixed_size'
> +    'size', 'fixed_size', 'taken_alone'
>  ]
>
>  def removesuffix(s: str, suffix: str) -> str:
> @@ -331,6 +333,7 @@ class JsonEvent:
>        extra_desc +=3D '  Spec update: ' + jd['Errata']
>      self.pmu =3D unit_to_pmu(jd.get('Unit'))
>      self.counter =3D jd.get('Counter')
> +    self.taken_alone =3D jd.get('TakenAlone')
>      self.size =3D jd.get('Size')
>      self.fixed_size =3D jd.get('FixedSize')
>      filter =3D jd.get('Filter')
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index 65e0c5dd8bb4..ce10356e9665 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -50,6 +50,7 @@ struct pmu_event {
>         const char *unit;
>         bool perpkg;
>         bool deprecated;
> +       bool taken_alone;
>  };
>
>  struct pmu_metric {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 016ea949ba5d..78e607f3ad56 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1624,6 +1624,7 @@ static void metricgroup__free_pmu_info(struct list_=
head *pmu_info_list)
>  static struct metricgroup__event_info *event_info__new(const char *name,
>                                                       const char *pmu_nam=
e,
>                                                       const char *counter=
,
> +                                                     bool taken_alone,
>                                                       bool free_counter)
>  {
>         int ret =3D 0;
> @@ -1638,6 +1639,7 @@ static struct metricgroup__event_info *event_info__=
new(const char *name,
>                 pmu_name =3D "core";
>
>         e->name =3D name;
> +       e->taken_alone =3D taken_alone;
>         e->free_counter =3D free_counter;
>         e->pmu_name =3D pmu_name;
>         if (free_counter) {
> @@ -1676,7 +1678,8 @@ static int metricgroup__add_metric_event_callback(c=
onst struct pmu_event *pe,
>         if (!strcasecmp(pe->name, d->event_name)) {
>                 if (!pe->counter)
>                         return -EINVAL;
> -               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
er, /*free_counter=3D*/false);
> +               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
er,
> +                                       pe->taken_alone, /*free_counter=
=3D*/false);
>                 if (!event)
>                         return -ENOMEM;
>                 list_add(&event->nd, d->list);
> @@ -1799,6 +1802,8 @@ static int find_and_set_counters(struct metricgroup=
__event_info *e,
>         int ret;
>         unsigned long find_bit =3D 0;
>
> +       if (e->taken_alone && current_group->taken_alone)
> +               return -ENOSPC;
>         if (e->free_counter)
>                 return 0;
>         if (e->fixed_counter) {
> @@ -1833,11 +1838,13 @@ static int _insert_event(struct metricgroup__even=
t_info *e,
>                 list_add(&event->nd, &group->event_head);
>         else
>                 list_add_tail(&event->nd, &group->event_head);
> +       if (e->taken_alone)
> +               group->taken_alone =3D true;
>         return 0;
>  }
>
>  /**
> - * Insert the new_group node at the end of the group list.
> + * Initialize the new group and insert it to the end of the group list.
>   */
>  static int insert_new_group(struct list_head *head,
>                            struct metricgroup__group *new_group,
> @@ -1847,6 +1854,7 @@ static int insert_new_group(struct list_head *head,
>         INIT_LIST_HEAD(&new_group->event_head);
>         fill_counter_bitmap(new_group->gp_counters, 0, size);
>         fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
> +       new_group->taken_alone =3D false;
>         list_add_tail(&new_group->nd, head);
>         return 0;
>  }
> @@ -2050,8 +2058,8 @@ static int create_grouping(struct list_head *pmu_in=
fo_list,
>         //TODO: for each new core group, we should consider to add events=
 that uses fixed counters
>         list_for_each_entry(e, event_info_list, nd) {
>                 bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_CO=
UNTERS);
> -               pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s\n", =
e->name,
> -                       e->pmu_name, bit_buf);
> +               pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s, [ta=
ken_alone]=3D%d\n",
> +                       e->name, e->pmu_name, bit_buf, e->taken_alone);
>                 ret =3D assign_event_grouping(e, pmu_info_list, &groups);
>                 if (ret)
>                         goto out;
> @@ -2098,7 +2106,7 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>                 if (is_special_event(id)) {
>                         struct metricgroup__event_info *event;
>
> -                       event =3D event_info__new(id, "default_core", "0"=
,
> +                       event =3D event_info__new(id, "default_core", "0"=
, false,
>                                                 /*free_counter=3D*/true);
>                         if (!event)
>                                 goto err_out;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 37fdf8c5ba77..8f6a1bb9d1ad 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -105,6 +105,7 @@ struct metricgroup__event_info {
>         const char *pmu_name;
>         bool fixed_counter;
>         bool free_counter;
> +       bool taken_alone;
>         /** The counters the event allowed to be collected on. */
>         DECLARE_BITMAP(counters, NR_COUNTERS);
>  };
> @@ -154,6 +155,7 @@ struct metricgroup__group {
>         DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
>         /** Head to the list of event names in this group*/
>         struct list_head event_head;
> +       bool taken_alone;
>  };
>
>  struct metricgroup__group_events {
> --
> 2.39.3
>

