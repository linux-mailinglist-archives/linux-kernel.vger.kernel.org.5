Return-Path: <linux-kernel+bounces-112592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B692887BC4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F94281FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6814016;
	Sun, 24 Mar 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RM410Uf0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516A1A38DE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711257887; cv=none; b=TYsWGT2DhWcjzNizGnFS7Fk/6jBi3Uadc+Bow4uqQLfZOw3IKgrsnEb1tW8J10T1zNt/y+iFwmE8KqmPtFtUSuZGfZ12Sqhv8unEHxqPqnc16fYr5lxodrqkFdMZLWfbjaQMjEW/gTGavG8DrptjhJZ+Ih9NMwY+zA56CoorBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711257887; c=relaxed/simple;
	bh=JX+oDdbRv0R2v1IYAefbVrNCF8D+0x1ug83g/J/1kzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAQXPuLMJIXVegsOKWBuLuBdJWW0KNGYG2l/YEZ/KJgy1WiCpng1hKK9J11oymX2cE8Yu8DQoQujx17cNultFt05rdOJjGYoQBUBKOiOMay2drIjcZ8QT+3dMqqem2IbjSMlRQlGNqgZaDlOD/4Yrqzxk/A7RJXx2zefau8nGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RM410Uf0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e062f3a47bso97605ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711257885; x=1711862685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFwHm9w+MuTz5G1OAkaeQ+lnQ6liJolQwcfKncG2IEI=;
        b=RM410Uf0ipGCe6XIWQj1LBaNE+KZC1OI4x+0fFzX5QMsx6VrCCHpMWbGRx+lNaZyED
         J5Otczam1roL3qTYNLcWx0f4xDHnGQTQ5t1mkisI/jGmUAr6JWnqV3/ZvHUGUUd3g1c0
         l5kBqSrr+NuC1fSL+TUuk9/NkvOaSf4j27qhjiUNj/yQeLoGH6eRF9bbRXJJI3eKAdz3
         TqllasDuZ/HMQe65tb3V02m72tNhWaMcQEG3v6AD2wNmtSFknX7ErEFiKSHncnCMWlM9
         Mwv50YARp7Xv741wvD5/4FqIJi0RYFAL+1q2h4zvmOk7gEopzlj8rYlYSh2i+6fVwg/A
         obZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711257885; x=1711862685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFwHm9w+MuTz5G1OAkaeQ+lnQ6liJolQwcfKncG2IEI=;
        b=Ra5cgh4XD4ej2dw5Ri1ZshIGe1IHiFcHtaAzZrO3QBkMbhrXkkqaW2JZr1NyMrVWEu
         mp3lng4HI4GuHGfRdxC8heeVM0rUBJqfonKr2qcPTD4COVEhHsMCMCwRqoXvNKPGjskS
         R3zceYjkl00lsaEWH5LNaQf999BODcuDG4yAUqjcf05gWr2q+O2bD5PC7N85h+nX4t58
         C8V0NKkugZwpfRoP3EYnIX8sjDr4GWMRyRmgFU+ljRNfUEaG0gNuhq2XsP/Aa9Rh3jy1
         UnbStGB4fFCzbsC6XRuRAUXRhCNIpYdA2yY8r2hiWXjogaO2R2mo7W3TnL6LxcoU2qh8
         /FLg==
X-Forwarded-Encrypted: i=1; AJvYcCW8fyMhqR9CPaH1v2ichm+tJ7eKHKTgp5d3qXssCw1PIqUyBENRxHRKTLiW48u3DESpZo6XjuDm0AWX2BlkmM1D+6If2r7Fd/cvg/ZB
X-Gm-Message-State: AOJu0Yyb255a/tLi746b+YTnKyxAfnT7mnM8uyZUTbS/CphCWLcgjetW
	WpmMXC5yVikaftj3Q0cgHZpNXbc4D0xn4ayJUjGVi6EMGDAw9oN0HlvoIZdUcN2vqDhakt/q58s
	1ho6w6dGwpKb2prSCsgmHL1A+GRwEKyYedt4K
X-Google-Smtp-Source: AGHT+IG/ypvtMd9SkyyJ5jW4bf26BEJt+Bt52L0K+3QoVHHTH54kbHfOFaD+QRqOYhCAJ7Q5Einc/Rsj8oHiBAI5pl8=
X-Received: by 2002:a17:903:2445:b0:1dc:dfd1:72e9 with SMTP id
 l5-20020a170903244500b001dcdfd172e9mr727173pls.29.1711257884720; Sat, 23 Mar
 2024 22:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-12-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-12-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:24:33 -0700
Message-ID: <CAP-5=fW_8qsxxjh+vhunVALuqqgXhDZzZSWUnJYV0OhmTHm7rA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 11/15] perf stat: Handle taken alone in hardware-grouping
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
> Add taken alone into consideration when grouping. Only one taken
> alone event is supported per group.

Is there an example of this?

> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py   |  7 ++++++-
>  tools/perf/pmu-events/pmu-events.h |  1 +
>  tools/perf/util/metricgroup.c      | 20 +++++++++++++++-----
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index bc91b7efa49a..4fbb367a3228 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -56,7 +56,9 @@ _json_event_attributes =3D [
>      # The list of counter(s) this event could use
>      'counters',
>      # Longer things (the last won't be iterated over during decompress).
> -    'long_desc'
> +    'long_desc',
> +    # Taken alone event could not be collected in the same group with ot=
her taken alone event
> +    'taken_alone'
>  ]
>
>  # Attributes that are in pmu_unit_layout.
> @@ -355,6 +357,9 @@ class JsonEvent:
>      self.num_counters =3D jd.get('NumCounters')
>      # Number of fixed counter
>      self.num_fixed_counters =3D jd.get('NumFixedCounters')
> +    # If the event is taken alone event, which cannot be grouped with an=
y other
> +    # taken alone event.
> +    self.taken_alone =3D jd.get('TakenAlone')
>      filter =3D jd.get('Filter')
>      self.unit =3D jd.get('ScaleUnit')
>      self.perpkg =3D jd.get('PerPkg')
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index e245e4738970..837edfeb676a 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -54,6 +54,7 @@ struct pmu_event {
>         const char *unit;
>         bool perpkg;
>         bool deprecated;
> +       bool taken_alone;
>  };
>
>  struct pmu_metric {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index fe115f0880f9..95d3868819e3 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -189,6 +189,7 @@ struct metricgroup__event_info {
>         /** The event uses special counters that we consider that as free=
 counter
>          *  during the event grouping*/
>         bool free_counter;
> +       bool taken_alone;
>         /** The counters the event allowed to be collected on. */
>         DECLARE_BITMAP(counters, NR_COUNTERS);
>  };
> @@ -235,6 +236,7 @@ struct metricgroup__group {
>         DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
>         /** Head to the list of event names in this group*/
>         struct list_head event_head;
> +       bool taken_alone;
>  };
>
>  struct metricgroup__group_events {
> @@ -1717,6 +1719,7 @@ static void metricgroup__free_pmu_info(struct list_=
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
> @@ -1731,6 +1734,7 @@ static struct metricgroup__event_info *event_info__=
new(const char *name,
>                 pmu_name =3D "core";
>
>         e->name =3D name;
> +       e->taken_alone =3D taken_alone;
>         e->free_counter =3D free_counter;
>         e->pmu_name =3D pmu_name;
>         if (free_counter) {
> @@ -1769,7 +1773,8 @@ static int metricgroup__add_metric_event_callback(c=
onst struct pmu_event *pe,
>         if (!strcasecmp(pe->name, d->event_name)) {
>                 if (!pe->counters)
>                         return -EINVAL;
> -               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
ers, /*free_counter=3D*/false);
> +               event =3D event_info__new(d->event_id, pe->pmu, pe->count=
ers,
> +                                       pe->taken_alone, /*free_counter=
=3D*/false);
>                 if (!event)
>                         return -ENOMEM;
>                 list_add(&event->nd, d->list);
> @@ -1892,6 +1897,8 @@ static int find_and_set_counters(struct metricgroup=
__event_info *e,
>         int ret;
>         unsigned long find_bit =3D 0;
>
> +       if (e->taken_alone && current_group->taken_alone)
> +               return -ENOSPC;
>         if (e->free_counter)
>                 return 0;
>         if (e->fixed_counter) {
> @@ -1926,11 +1933,13 @@ static int _insert_event(struct metricgroup__even=
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
> @@ -1940,6 +1949,7 @@ static int insert_new_group(struct list_head *head,
>         INIT_LIST_HEAD(&new_group->event_head);
>         fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
>         fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_count=
ers);
> +       new_group->taken_alone =3D false;
>         list_add_tail(&new_group->nd, head);
>         return 0;
>  }
> @@ -2143,8 +2153,8 @@ static int create_grouping(struct list_head *pmu_in=
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
> @@ -2191,7 +2201,7 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>                 if (is_special_event(id)) {
>                         struct metricgroup__event_info *event;
>
> -                       event =3D event_info__new(id, "default_core", "0"=
,
> +                       event =3D event_info__new(id, "default_core", "0"=
, false,

nit: document constant arguments, so "/*taken_alone=3D*/false,"

Thanks,
Ian

>                                                 /*free_counter=3D*/true);
>                         if (!event)
>                                 goto err_out;
> --
> 2.42.0
>

