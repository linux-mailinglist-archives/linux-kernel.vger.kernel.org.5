Return-Path: <linux-kernel+bounces-112589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090A887BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494A91C20C61
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AB13FFC;
	Sun, 24 Mar 2024 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1aT446R"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2C134BE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711256463; cv=none; b=diLxpaR3WGC+6xGAASoFL8AmcsvxZm5cHoSO29MRytfhjxZY8YsnZlQj76vGdGr1wr/cdSMumPhtoQ9LrOJC4hmUcWvycUqA8+CzPaNYWKdxoQ2gruWdRAuoWgUfqxlyHxNcxgpWibyTowzPmL0YR0UwFuQWBqSFywEgACqlCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711256463; c=relaxed/simple;
	bh=ODFwLX9Fn2KMSx7qcNbVg/+GM1fR7v524i6YHGil1hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNXZErwvYaGg8mHNs1NlLS45xTw4sB1COTrEaU2pT2ljv8ChQt3nwiqw9YhoKBkkFVybW1lI6mKVuWcftkNUg04cVnIYLelkwA+LCAwAedzwdpvVH8bEh+c0okwLM4Mwnkh5q/fgsJHkBeJ5z2gJLq5kcVqWLUXpuRb5PVVbgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1aT446R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dee917abd5so91865ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711256461; x=1711861261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InmmgUILAkTU/zdBr9e+023lOFWPccpL4BLezUKiyvA=;
        b=U1aT446RpmUxwUd5u0l5jIkY2oORBAbnW/OKA/jDukhzDCXGGEk7UW00PH/OmZgXWy
         RJUidYw2+Z0ZtaCaFUHIQ2EblkquLcKfrajVQC/jFyoUtgEcT88UroxjlrBhfgupnPTO
         j1ZF5FHt/REYyIJOOHuYSID/3NV858GXyMSApzOKkAZ4FlSxdn8IOS+nShcg51B/cMh1
         Y2Ua/WL3svcs7sFiX4+IHSBIsBfOhA2tMbBfwEWjZsKZou9oP5sC9XQMbCk/O3aSvyAf
         BSNQ0V+UUqo/fPKSH3qgDoVtzX/+9RTUDo69nEdJNi4nWIqkDgVWaKtvoHahGkZwiktE
         mmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711256461; x=1711861261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InmmgUILAkTU/zdBr9e+023lOFWPccpL4BLezUKiyvA=;
        b=i4XYkj+eM4HPQXm/SPijVHSaXL9HHhRxSaiFX9EDJRqNpUjx2rEZPhiRd1ugKxROAg
         mNTJbQozEMtQuSuLE1dShKeIrABH8TtUmCVn5AVwSTeaKuR5B1vSn5yglj5L/3cQ0t93
         cxKPX830OSSPVBvdGPD92Z8x12KDhOQ09Mht7DKgTpB7PeFtrej/RNQhI2pTCXtYJrNL
         A8sjR6O2rMF07rwxNIPFv8RFW9WeEoMatnUOH225dPxfWdWPV0xvVVRa8TUQT1sNYI+V
         XSFMC8g9PTFecjoYBTmHXpvNILt2lyJIsLEcF9IdqRLaudhJO6FBXmOu9p6K6Ua7xXoO
         ZQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs6amjl06Yf+NrJLcorYuzd/6miMKNeYCPLNhH92l3aNJocM1X6A46I8pTvmNA4d434tp3aIg+U1m8y64bTYsnc4ixV0a9MhH3enai
X-Gm-Message-State: AOJu0YzQlHNC1q0yD7Dd+l+Qr2HUxuPQFi6OyUTF1QEgVMkWUswVEgH4
	3fkGpyp5PabRKf57Gv5GtE3csNwJ/JTqBq0pL7NXdmV85s3DfZxhpOEavRooxaeSa7eLPT9E8Me
	Zr9a3uwCStpAVC7/Cf5egG1+V/xQmU6Q01ZVj
X-Google-Smtp-Source: AGHT+IFRLtzYeikYDJRd6r6mtzRnkIWaNwWpiU9m9dgliaVL1vqbm/fYNe8JudivriIfNA5c4ImfwpaxT+oslt7yUoI=
X-Received: by 2002:a17:902:ea01:b0:1e0:b622:4e24 with SMTP id
 s1-20020a170902ea0100b001e0b6224e24mr16770plg.20.1711256460308; Sat, 23 Mar
 2024 22:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-8-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-8-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:00:49 -0700
Message-ID: <CAP-5=fU-JoD20zLVBgjDfR8bDqdb_s+pJqXZqJdSdgFnsfbiTg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/15] perf stat: Add functions to create new group
 and assign events into groups
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 296 ++++++++++++++++++++++++++++++++++
>  1 file changed, 296 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 9061ed4ca015..f86e9a0b0d65 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -192,6 +192,41 @@ struct metricgroup__pmu_counters {
>         size_t num_counters;
>         size_t num_fixed_counters;
>  };
> +/**
> + * A list of event groups for this pmu.
> + * This is updated during the grouping.
> + */
> +struct metricgroup__pmu_group_list {
> +       struct list_head nd;
> +       /** The name of the pmu(/core) the events collected on. */
> +       const char *pmu_name;
> +       /** The number of gp counters in the pmu(/core). */
> +       size_t num_counters;
> +       /** The number of fixed counters in the pmu(/core) if applicable.=
 */
> +       size_t num_fixed_counters;
> +       /** Head to the list of groups using this pmu(/core)*/
> +       struct list_head group_head;
> +};
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
>
>  /**
>   * Each group is one node in the group string list.
> @@ -1487,6 +1522,34 @@ static int set_counter_bitmap(int pos, unsigned lo=
ng *bitmap)
>         return 0;
>  }
>
> +/**
> + * Returns 0 on success. Finds the last counter that is not used in pmu_=
counters
> + * and supports the event, included in event_counters.
> + */
> +static int find_counter_bitmap(const unsigned long *pmu_counters,
> +                             const unsigned long *event_counters,
> +                             unsigned long *bit)
> +{
> +       /*It is helpful to assign from the highest bit because some event=
s can
> +        *only be collected using GP0-3.
> +        */
> +       unsigned long find_bit =3D find_last_and_bit(pmu_counters, event_=
counters, NR_COUNTERS);
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
> +       __clear_bit(find_bit, bitmap);
> +       return 0;
> +}
> +
>  static int parse_fixed_counter(const char *counter,
>                               unsigned long *bitmap,
>                               bool *fixed)
> @@ -1544,6 +1607,38 @@ static int parse_counter(const char *counter,
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
> @@ -1719,6 +1814,203 @@ static int get_pmu_counter_layouts(struct list_he=
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
> + * counter is available, use this counter by filling the bit in the corr=
ect
> + * counter bitmap. Otherwise, return error (-ERANGE).
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
> +                          size_t num_counters,
> +                          size_t num_fixed_counters)
> +{
> +       INIT_LIST_HEAD(&new_group->event_head);
> +       fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
> +       fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_count=
ers);
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
ead->num_counters,
> +                                     pmu_group_head->num_fixed_counters)=
;
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
> +                               pmu_group_head->num_counters =3D p->num_c=
ounters;
> +                               pmu_group_head->num_fixed_counters =3D p-=
>num_fixed_counters;
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
> @@ -1750,6 +2042,10 @@ static int hw_aware_build_grouping(struct expr_par=
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
> --
> 2.42.0
>

