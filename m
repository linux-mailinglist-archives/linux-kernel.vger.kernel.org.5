Return-Path: <linux-kernel+bounces-37360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E680783AEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9506B28542B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAE7E786;
	Wed, 24 Jan 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ifin/1P0"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199897E57B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115140; cv=none; b=VIoTE5BUsm/6d+4mdJcetdAOGMBOR9eSQ+qngKTtW9WOZWtVKE1VGWaNUTC9haG5ULA4X6OGzXobPw9ScMdj72ng2SoyPBAOYgq0snnGn7J+h1lvQq6ad9N5kpDANWVaIS5X3x3ShFb46MTqxHA4K9zmwzKSAj0eilqexVrmxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115140; c=relaxed/simple;
	bh=aE3T4LlX5qTO7nSGeyjDhMYGW++pKisp2hl3a9rvC6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYCBPi6THv2oqO0xv+Lj6dQ5I4jhI00+CO/VuqBIJvWEeo85C4vAPu6IwsY2zIoxGouW1yglxfDoT1vpxo+zhCYr7r/BwEEe1jUOqagB8kREBhdKJz9lNiEodjgXQiTNWLQ4KtwFvhqOuDrm2261rYXpJ5Pk6YSHDPxOagr651Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ifin/1P0; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so190065ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706115138; x=1706719938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDtIV+rHtklp+efkT4we/c4HSzBE97Y/8RPGQmOM0nA=;
        b=Ifin/1P0TtGwI6srSu4uG+7OQfWpfuJSK1k0dIydES49xFG8uqoOU9X9p1ayAGbGmJ
         La277GE3jCVzn6KDvE40JYVWciLdxJJEVDcSDZLV2FjEUlW9r1Slsq6HEzYSaYi7L+nw
         yubnw+O0qlPWT61S1b4a9yN90Zg3tnVzZna6U0le+QXxoCbvvOFILTHpfIafz3KbgC0z
         GnWqBcPZMuuD78TXnzmxEaHU8aIEvWpw1IC91Rdxbi9EMrouKtzjBGALvbL/ERjBriMs
         gW1YbfNbIrkhCM5xzHrDDZEZVeXyXPnz6a5bQvzRdTrB99dkJFjfvjJEiG2N5j5uvewq
         MFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115138; x=1706719938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDtIV+rHtklp+efkT4we/c4HSzBE97Y/8RPGQmOM0nA=;
        b=F8tMQNy3IjbiXYgl96zWLEM2eGlq0aaFz9BRpDVi+BnSOKKl07/zAU9de9Ing5Kkil
         hoovKkGDEIpItNnkiphVFM0HLasgrMXzB7RhW9ErbUFBAQOqVE4Q6qG368rv8VovMRbt
         3xQnNQWz4J4AeHn6FmStIWRBtbDsTS7nIa0Q3ZOhPiBWDeAkR412XS/EAcGhzwgIAvKK
         Ze0262u9yzhwH8eDrvRwlPF+A6QLjW/hGnLUZUbdLYIwCs+6G/Hp1ELRROHCowf/roLN
         Ws8w+6ELQpMZqWiMkZR4tFkM15T4OyDgF/HATie8I0UTo49EpEjdcEA/t0lWnE5dYlUD
         M97g==
X-Gm-Message-State: AOJu0YxwCxSNdQtucBw4fobi5RX35UM0CLbiPH8FO4YA624mtoUKYEEN
	5LntHBdrNid6h8Jx3WuquLPMgD3J4VgHcexT/AmifiAz7gm/HJ3rnWGKrL7Ytt/REeI9QsTgTzi
	wd9kIZFxwd/N/kWLr4wtvYcUHGXDtRw6ZpvbG
X-Google-Smtp-Source: AGHT+IFtKSkHdgW1nXA6Q5gUqL3TRTNzbOGvHq4nQHuLEqNAFD7htQM2dP+DZGvbNgadgmXlDTX9u8Mo6K7OIMfkaNs=
X-Received: by 2002:a92:c84b:0:b0:360:7a5c:16a3 with SMTP id
 b11-20020a92c84b000000b003607a5c16a3mr123620ilq.29.1706115137897; Wed, 24 Jan
 2024 08:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-11-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-11-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 08:52:06 -0800
Message-ID: <CAP-5=fU9hPcGjdip6QBjqwsKBaw-D0mfnZP932KqwJGg_+uG8A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/18] perf stat: Add functions to create new group
 and assign events into groups for hardware-grouping method
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
> Add struct metricgroup__pmu_group_list to hold the lists of groups from
> different PMUs. Each PMU has one separate list.
>
> Add struct metricgroup__group as one node (one group in the grouping
> result) of the metricgroup__pmu_group_list. It uses two bitmaps to log
> counter availabilities(gp counters and fixed counters).
>
> Add functions to create group and assign event into the groups based on t=
he
> event restrictions (struct metricgroup__event_info) and counter
> availability (pmu_info_list and bitmaps). New group is inserted into the
> list of groups.
>
> Add functions to handle counter bitmaps. Add functions do find and insert
> operations to handle inserting event into groups.
>
> Add function to fill all bits of one counter bitmap. Add functions to
> create new groups when no counter is available in all the existing groups=
.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/lib/bitmap.c            |  20 +++
>  tools/perf/util/metricgroup.c | 254 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  37 +++++
>  3 files changed, 311 insertions(+)
>
> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index c3e4871967bc..a96dbf001244 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap=
1,
>                         return true;
>         return false;
>  }
> +
> +void bitmap_clear(unsigned long *map, unsigned int start, int len)
> +{
> +       unsigned long *p =3D map + BIT_WORD(start);
> +       const unsigned int size =3D start + len;
> +       int bits_to_clear =3D BITS_PER_LONG - (start % BITS_PER_LONG);
> +       unsigned long mask_to_clear =3D BITMAP_FIRST_WORD_MASK(start);
> +
> +       while (len - bits_to_clear >=3D 0) {
> +               *p &=3D ~mask_to_clear;
> +               len -=3D bits_to_clear;
> +               bits_to_clear =3D BITS_PER_LONG;
> +               mask_to_clear =3D ~0UL;
> +               p++;
> +       }
> +       if (len) {
> +               mask_to_clear &=3D BITMAP_LAST_WORD_MASK(size);
> +               *p &=3D ~mask_to_clear;
> +       }
> +}

This is worth having its own commit. This looks derived from the kernel ver=
sion:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/lib/bitmap.c?h=3Dperf-tools-next#n372
How can we sync these better? Generally we check things are kept in
sync as part of the build:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/check-headers.sh?h=3Dperf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n250

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index a393584c7a73..9d06fe4488dc 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1450,6 +1450,27 @@ static int set_counter_bitmap(int pos, unsigned lo=
ng *bitmap)
>         return 0;
>  }
>
> +static int find_counter_bitmap(unsigned long *addr1,
> +                             unsigned long *addr2,
> +                             unsigned long *bit)

Presumably addr1 and addr2 can be const here, could we have more
intention revealing variable names. A comment like:
/** Returns 0 on success. finds the first counter that is in use by
both <better name for addr1> and <better name for addr2>. */

> +{
> +       unsigned long find_bit =3D find_next_and_bit(addr1, addr2, NR_COU=
NTERS, 0);

Why find_next and not find_first?

> +
> +       if (find_bit =3D=3D NR_COUNTERS)
> +               return -ERANGE;
> +       *bit =3D find_bit;
> +       return 0;
> +}
> +
> +static int use_counter_bitmap(unsigned long *bitmap,
> +                            unsigned long find_bit)
> +{
> +       if (find_bit >=3D NR_COUNTERS)
> +               return -EINVAL;
> +       bitmap_clear(bitmap, find_bit, 1);
> +       return 0;
> +}
> +
>  static int parse_fixed_counter(const char *counter,
>                               unsigned long *bitmap,
>                               bool *fixed)
> @@ -1507,6 +1528,38 @@ static int parse_counter(const char *counter,
>         return 0;
>  }
>
> +static void group_event_list_free(struct metricgroup__group *groups)
> +{
> +       struct metricgroup__group_events *e, *tmp;
> +
> +       list_for_each_entry_safe(e, tmp, &groups->event_head, nd) {
> +               list_del_init(&e->nd);
> +               free(e);
> +       }
> +}
> +
> +static void group_list_free(struct metricgroup__pmu_group_list *groups)
> +{
> +       struct metricgroup__group *g, *tmp;
> +
> +       list_for_each_entry_safe(g, tmp, &groups->group_head, nd) {
> +               list_del_init(&g->nd);
> +               group_event_list_free(g);
> +               free(g);
> +       }
> +}
> +
> +static void metricgroup__free_group_list(struct list_head *groups)
> +{
> +       struct metricgroup__pmu_group_list *g, *tmp;
> +
> +       list_for_each_entry_safe(g, tmp, groups, nd) {
> +               list_del_init(&g->nd);
> +               group_list_free(g);
> +               free(g);
> +       }
> +}
> +
>  static void metricgroup__free_event_info(struct list_head
>                                         *event_info_list)
>  {
> @@ -1682,6 +1735,203 @@ static int get_pmu_counter_layouts(struct list_he=
ad *pmu_info_list,
>         return ret;
>  }
>
> +static int fill_counter_bitmap(unsigned long *bitmap, int start, int siz=
e)
> +{
> +       int ret;
> +
> +       bitmap_zero(bitmap, NR_COUNTERS);
> +
> +       for (int pos =3D start; pos < start + size; pos++) {
> +               ret =3D set_counter_bitmap(pos, bitmap);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +
> +/**
> + * Find if there is a counter available for event e in current_group. If=
 a
> + * counter is available, use this counter by fill the bit in the correct=
 counter

nit: s/fill/filling/

> + * bitmap. Otherwise, return error (-ERANGE).
> + */
> +static int find_and_set_counters(struct metricgroup__event_info *e,
> +                               struct metricgroup__group *current_group)
> +{
> +       int ret;
> +       unsigned long find_bit =3D 0;
> +
> +       if (e->free_counter)
> +               return 0;
> +       if (e->fixed_counter) {
> +               ret =3D find_counter_bitmap(current_group->fixed_counters=
, e->counters,
> +                                        &find_bit);
> +               if (ret)
> +                       return ret;
> +               pr_debug("found counter for [event]=3D%s [e->fixed_counte=
rs]=3D%lu\n",
> +                       e->name, *current_group->fixed_counters);
> +               ret =3D use_counter_bitmap(current_group->fixed_counters,=
 find_bit);
> +       } else {
> +               ret =3D find_counter_bitmap(current_group->gp_counters, e=
->counters,
> +                                        &find_bit);
> +               if (ret)
> +                       return ret;
> +               pr_debug("found counter for [event]=3D%s [e->gp_counters]=
=3D%lu\n",
> +                       e->name, *current_group->gp_counters);
> +               ret =3D use_counter_bitmap(current_group->gp_counters, fi=
nd_bit);
> +       }
> +       return ret;
> +}
> +
> +static int _insert_event(struct metricgroup__event_info *e,
> +                       struct metricgroup__group *group)
> +{
> +       struct metricgroup__group_events *event =3D malloc(sizeof(struct =
metricgroup__group_events));
> +
> +       if (!event)
> +               return -ENOMEM;
> +       event->event_name =3D e->name;
> +       if (e->fixed_counter)
> +               list_add(&event->nd, &group->event_head);
> +       else
> +               list_add_tail(&event->nd, &group->event_head);
> +       return 0;
> +}
> +
> +/**
> + * Insert the new_group node at the end of the group list.
> + */
> +static int insert_new_group(struct list_head *head,
> +                          struct metricgroup__group *new_group,
> +                          size_t size,
> +                          size_t fixed_size)
> +{
> +       INIT_LIST_HEAD(&new_group->event_head);
> +       fill_counter_bitmap(new_group->gp_counters, 0, size);
> +       fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
> +       list_add_tail(&new_group->nd, head);
> +       return 0;
> +}
> +
> +/**
> + * Insert event e into a group capable to include it
> + *
> + */
> +static int insert_event_to_group(struct metricgroup__event_info *e,
> +                               struct metricgroup__pmu_group_list *pmu_g=
roup_head)
> +{
> +       struct metricgroup__group *g;
> +       int ret;
> +       struct list_head *head;
> +
> +       list_for_each_entry(g, &pmu_group_head->group_head, nd) {
> +               ret =3D find_and_set_counters(e, g);
> +               if (!ret) { /* return if successfully find and set counte=
r*/
> +                       ret =3D _insert_event(e, g);
> +                       return ret;
> +               }
> +       }
> +       /*
> +        * We were not able to find an existing group to insert this even=
t.
> +        * Continue to create a new group and insert the event in it.
> +        */
> +       {
> +               struct metricgroup__group *current_group =3D
> +                               malloc(sizeof(struct metricgroup__group))=
;
> +
> +               if (!current_group)
> +                       return -ENOMEM;
> +               pr_debug("create_new_group for [event] %s\n", e->name);
> +
> +               head =3D &pmu_group_head->group_head;
> +               ret =3D insert_new_group(head, current_group, pmu_group_h=
ead->size,
> +                                     pmu_group_head->fixed_size);
> +               if (ret)
> +                       return ret;
> +               ret =3D find_and_set_counters(e, current_group);
> +               if (ret)
> +                       return ret;
> +               ret =3D _insert_event(e, current_group);
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * assign_event_grouping - Assign an event into a group. If existing gro=
up
> + * cannot include it, create a new group and insert the event to it.
> + */
> +static int assign_event_grouping(struct metricgroup__event_info *e,
> +                               struct list_head *pmu_info_list,
> +                               struct list_head *groups)
> +{
> +       int ret =3D 0;
> +
> +       struct metricgroup__pmu_group_list *g =3D NULL;
> +       struct metricgroup__pmu_group_list *pmu_group_head =3D NULL;
> +
> +       list_for_each_entry(g, groups, nd) {
> +               if (!strcasecmp(g->pmu_name, e->pmu_name)) {
> +                       pr_debug("found group for event %s in pmu %s\n", =
e->name, g->pmu_name);
> +                       pmu_group_head =3D g;
> +                       break;
> +               }
> +       }
> +       if (!pmu_group_head) {
> +               struct metricgroup__pmu_counters *p;
> +
> +               pmu_group_head =3D malloc(sizeof(struct metricgroup__pmu_=
group_list));
> +               if (!pmu_group_head)
> +                       return -ENOMEM;
> +               INIT_LIST_HEAD(&pmu_group_head->group_head);
> +               pr_debug("create new group for event %s in pmu %s\n", e->=
name, e->pmu_name);
> +               pmu_group_head->pmu_name =3D e->pmu_name;
> +               list_for_each_entry(p, pmu_info_list, nd) {
> +                       if (!strcasecmp(p->name, e->pmu_name)) {
> +                               pmu_group_head->size =3D p->size;
> +                               pmu_group_head->fixed_size =3D p->fixed_s=
ize;
> +                               break;
> +                       }
> +               }
> +               list_add_tail(&pmu_group_head->nd, groups);
> +       }
> +
> +       ret =3D insert_event_to_group(e, pmu_group_head);
> +       return ret;
> +}
> +
> +/**
> + * create_grouping - Create a list of groups and place all the events of
> + * event_info_list into these groups.
> + * @pmu_info_list: the list of PMU units info based on pmu-events data, =
used for
> + * creating new groups.
> + * @event_info_list: the list of events to be grouped.
> + * @groupings: the list of groups with events placed in.
> + * @modifier: any modifiers added to the events.
> + */
> +static int create_grouping(struct list_head *pmu_info_list,
> +                         struct list_head *event_info_list,
> +                         struct list_head *groupings __maybe_unused,
> +                         const char *modifier __maybe_unused)
> +{
> +       int ret =3D 0;
> +       struct metricgroup__event_info *e;
> +       LIST_HEAD(groups);
> +       char *bit_buf =3D malloc(NR_COUNTERS);
> +
> +       //TODO: for each new core group, we should consider to add events=
 that uses fixed counters
> +       list_for_each_entry(e, event_info_list, nd) {
> +               bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_CO=
UNTERS);
> +               pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s\n", =
e->name,
> +                       e->pmu_name, bit_buf);
> +               ret =3D assign_event_grouping(e, pmu_info_list, &groups);
> +               if (ret)
> +                       goto out;
> +       }
> +out:
> +       metricgroup__free_group_list(&groups);
> +       return ret;
> +};
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1713,6 +1963,10 @@ static int hw_aware_build_grouping(struct expr_par=
se_ctx *ctx __maybe_unused,
>                         goto err_out;
>         }
>         ret =3D get_pmu_counter_layouts(&pmu_info_list, ltable);
> +       if (ret)
> +               goto err_out;
> +       ret =3D create_grouping(&pmu_info_list, &event_info_list, groupin=
gs,
> +                            modifier);
>
>  err_out:
>         metricgroup__free_event_info(&event_info_list);
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 802ca15e7c6b..51596e4b4341 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -109,6 +109,43 @@ struct metricgroup__pmu_counters {
>         size_t fixed_size;
>  };
>

Could we narrow the scope of these declarations to metricgroup.c?

> +/**
> + * A list of groups for this pmu.

Groups of what?

Thanks,
Ian

> + * This is updated during the grouping.
> + */
> +struct metricgroup__pmu_group_list {
> +       struct list_head nd;
> +       /** The name of the pmu(/core) the events collected on. */
> +       const char *pmu_name;
> +       /** The number of gp counters in the pmu(/core). */
> +       size_t size;
> +       /** The number of fixed counters in the pmu(/core) if applicable.=
 */
> +       size_t fixed_size;
> +       /** Head to the list of groups using this pmu(/core)*/
> +       struct list_head group_head;
> +};
> +
> +/**
> + * This is one node in the metricgroup__pmu_group_list.
> + * It represents on group.
> + */
> +struct metricgroup__group {
> +       struct list_head nd;
> +       /** The bitmaps represent availability of the counters.
> +        *  They are updated once the corresponding counter is used by
> +        *  an event (event inserted into the group).
> +        */
> +       DECLARE_BITMAP(gp_counters, NR_COUNTERS);
> +       DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
> +       /** Head to the list of event names in this group*/
> +       struct list_head event_head;
> +};
> +
> +struct metricgroup__group_events {
> +       struct list_head nd;
> +       const char *event_name;
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> --
> 2.39.3
>

