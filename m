Return-Path: <linux-kernel+bounces-120152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453188D309
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB82B22541
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F0800;
	Wed, 27 Mar 2024 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwxWrbzw"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E581F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497928; cv=none; b=We08rGs9pWbl4Xwyo5RDM4pi93OxKPK+Jg6EvB9A/QfZYbx8/FK3YZy2QvDuN0lCGxDxkf+/C19kTt2K5fyKYPqIpXwHyjbWoRuey2JJNwWEBqz/4bO+XQXGDNwvqtJJG2PldYzI8NXi9d7RPDpzK519vI2G7hygLjZbcDcpR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497928; c=relaxed/simple;
	bh=zR8QLu0QSwsSNTj4N7J2TprJTtajYQbsM8gt4TH1syg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+N9JNwZf2SRr2u6V7aXuPTroPxsDl6cSgQD14iVkS4ZecWPEXERX9xXy3YBMzCtPUaERwUth5r1p8ZICrxDuDv0gd9McPyZtQ+MPKRbKxD9FBfqO/ZBuwTExGnF1leLQ80WgY4V+zUtzh3Nbo5iAYs4kGHlwF2VcEMko7perlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwxWrbzw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so88351cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711497925; x=1712102725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC6ucHpMXy6+HlV7gHCHrl9D3jyXBg2KCAOLNLRKMnc=;
        b=PwxWrbzwIyl7KGrKrxunQhb46U5+M0TDipuHpxJb44xl5uMh0qJ2+jTbA5seYzHWip
         8+AAmgb/1Gd5tjnJzQWea5ZycPJeVTkcCqx6hg1s/cEVaUyXdF1XCVxQmJWstKl21fJk
         dz2Gf2iylWOOhCpc5knqv9HjeWwVGgVlmKouNspm+UFeJaa9vY7FvwYs1/ZbWLmJCF+v
         PXb9hIG7AyTa/iKbyoS9vnpGnrJ0b048Udvo/CgxElcD/ZNdtLoInMpCLG9x0a3cCpcb
         rbsAL3bx/PdGATQOtyDZhkmGw+RU1Jx1rfxQv8+jy33UaByw+OcmYBWwQKDzeMdXDltl
         Pthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711497925; x=1712102725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kC6ucHpMXy6+HlV7gHCHrl9D3jyXBg2KCAOLNLRKMnc=;
        b=AyPlGlMIXVykf7Cm1+g/SMZSiqzFPSdD1l5+T+hAnhnnZWzZwUDnoJ5BGs3mH1Wdg/
         f7ypXVXYFgJad0aXz0UwvOaBjXUTMzbWrHih3TorJjcRfNX5KoEO35HacAfsjJp3hSFq
         Fi34vm00nfWuNjjs03BtZ18bh72ZTjSxlNqxToSj2r/+LdFf9ansP9OFZuqRTZEFihyZ
         bbhYEwK99ChzmAEJ+1XGzBrb5itMd4dVBvbuV5+oX5RdUcyBYIXenC+aQy9auxfhHdkn
         XrB52RyKKV+ueNz/r0dwuxduQw0q/YXs3k8U80helzBN2XjSU73ljKdbJyf9KzCXn9TB
         Qdvw==
X-Forwarded-Encrypted: i=1; AJvYcCUSmlACgufzeur3nUpiYK4BkL6SHkMJvoVRFYtsX4t7c1JF/CXfNlL02wznrjeYd3WB0pjs6a8z3n7s2LtV5UNeH3fiXUWFUOeqUrhU
X-Gm-Message-State: AOJu0YxIPIPfzoU3PEFQ4ePcI7lTaMuLfiiL91GXdGWKB1gWMuzfcEfn
	6YmwND+qJtDI5hL7yajcYUk5uMgKPDTtxjhKK/HuuR0BbFYAN8fxzvisskgb15WAfAmQaHtCTAe
	xR/A6q/jTFh/gDUALMi0H9TXCDrl182j2wDq4
X-Google-Smtp-Source: AGHT+IFqzClAkeUAEZ5dDdtVtLG91v/7Sd20NLE2vvV9EcJjFDOCvJmBSUvogcyYFI/rqPh/4pPb+YkzamoJRiY+6/A=
X-Received: by 2002:a05:622a:5c15:b0:431:4e0b:d675 with SMTP id
 gd21-20020a05622a5c1500b004314e0bd675mr34242qtb.18.1711497924951; Tue, 26 Mar
 2024 17:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com>
 <20240209031441.943012-12-weilin.wang@intel.com> <CAP-5=fW_8qsxxjh+vhunVALuqqgXhDZzZSWUnJYV0OhmTHm7rA@mail.gmail.com>
 <CO6PR11MB5635DE7FD0CDF473A5357983EE352@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635DE7FD0CDF473A5357983EE352@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Mar 2024 17:05:13 -0700
Message-ID: <CAP-5=fVn9tOob73VPpUci4rzW213TNatBvEQXuBADUi-F0VzeA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 11/15] perf stat: Handle taken alone in hardware-grouping
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:06=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Saturday, March 23, 2024 10:25 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>; Namhyung Kim
> > <namhyung@kernel.org>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> > Peter Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; linux-per=
f-
> > users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor, Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>; Mark Rutland <mark.rutland@arm.com>
> > Subject: Re: [RFC PATCH v4 11/15] perf stat: Handle taken alone in hard=
ware-
> > grouping
> >
> > On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add taken alone into consideration when grouping. Only one taken
> > > alone event is supported per group.
> >
> > Is there an example of this?
>
> Yes, there are about 20+ taken alone core events in SPR. Events like
> UOPS_RETIRED.MS, FRONTEND_RETIRED.DSB_MISS,
> INT_MISC.UNKNOWN_BRANCH_CYCLES, and etc.
>
> If we run `perf stat -e` with two such kind of events, we will see multip=
lexing.
> ./perf stat -e "INT_MISC.UNKNOWN_BRANCH_CYCLES,UOPS_RETIRED.MS" -a sleep =
1

Should these events be in a group?

>  Performance counter stats for 'system wide':
>
>          3,257,425      INT_MISC.UNKNOWN_BRANCH_CYCLES                   =
                       (50.04%)
>        134,098,908      UOPS_RETIRED.MS                                  =
                       (49.96%)
>
>        1.008902540 seconds time elapsed
>
> This multiplexing should not happen if we run only one such type of event=
 at a time.
> ./perf stat -e "INT_MISC.CLEAR_RESTEER_CYCLES,UOPS_RETIRED.MS" -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>          5,107,299      INT_MISC.CLEAR_RESTEER_CYCLES
>         21,929,170      UOPS_RETIRED.MS
>
>        1.009937991 seconds time elapsed
>
> Should I add this example in the commit message?

So taken alone means that the events share a counter? What's going
wrong in the first case and causing the multiplexing?

Thanks,
Ian

> Thanks,
> Weilin
>
> >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/pmu-events/jevents.py   |  7 ++++++-
> > >  tools/perf/pmu-events/pmu-events.h |  1 +
> > >  tools/perf/util/metricgroup.c      | 20 +++++++++++++++-----
> > >  3 files changed, 22 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-
> > events/jevents.py
> > > index bc91b7efa49a..4fbb367a3228 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -56,7 +56,9 @@ _json_event_attributes =3D [
> > >      # The list of counter(s) this event could use
> > >      'counters',
> > >      # Longer things (the last won't be iterated over during decompre=
ss).
> > > -    'long_desc'
> > > +    'long_desc',
> > > +    # Taken alone event could not be collected in the same group wit=
h other
> > taken alone event
> > > +    'taken_alone'
> > >  ]
> > >
> > >  # Attributes that are in pmu_unit_layout.
> > > @@ -355,6 +357,9 @@ class JsonEvent:
> > >      self.num_counters =3D jd.get('NumCounters')
> > >      # Number of fixed counter
> > >      self.num_fixed_counters =3D jd.get('NumFixedCounters')
> > > +    # If the event is taken alone event, which cannot be grouped wit=
h any
> > other
> > > +    # taken alone event.
> > > +    self.taken_alone =3D jd.get('TakenAlone')
> > >      filter =3D jd.get('Filter')
> > >      self.unit =3D jd.get('ScaleUnit')
> > >      self.perpkg =3D jd.get('PerPkg')
> > > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-
> > events/pmu-events.h
> > > index e245e4738970..837edfeb676a 100644
> > > --- a/tools/perf/pmu-events/pmu-events.h
> > > +++ b/tools/perf/pmu-events/pmu-events.h
> > > @@ -54,6 +54,7 @@ struct pmu_event {
> > >         const char *unit;
> > >         bool perpkg;
> > >         bool deprecated;
> > > +       bool taken_alone;
> > >  };
> > >
> > >  struct pmu_metric {
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> > > index fe115f0880f9..95d3868819e3 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -189,6 +189,7 @@ struct metricgroup__event_info {
> > >         /** The event uses special counters that we consider that as =
free counter
> > >          *  during the event grouping*/
> > >         bool free_counter;
> > > +       bool taken_alone;
> > >         /** The counters the event allowed to be collected on. */
> > >         DECLARE_BITMAP(counters, NR_COUNTERS);
> > >  };
> > > @@ -235,6 +236,7 @@ struct metricgroup__group {
> > >         DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
> > >         /** Head to the list of event names in this group*/
> > >         struct list_head event_head;
> > > +       bool taken_alone;
> > >  };
> > >
> > >  struct metricgroup__group_events {
> > > @@ -1717,6 +1719,7 @@ static void metricgroup__free_pmu_info(struct
> > list_head *pmu_info_list)
> > >  static struct metricgroup__event_info *event_info__new(const char *n=
ame,
> > >                                                       const char *pmu=
_name,
> > >                                                       const char *cou=
nter,
> > > +                                                     bool taken_alon=
e,
> > >                                                       bool free_count=
er)
> > >  {
> > >         int ret =3D 0;
> > > @@ -1731,6 +1734,7 @@ static struct metricgroup__event_info
> > *event_info__new(const char *name,
> > >                 pmu_name =3D "core";
> > >
> > >         e->name =3D name;
> > > +       e->taken_alone =3D taken_alone;
> > >         e->free_counter =3D free_counter;
> > >         e->pmu_name =3D pmu_name;
> > >         if (free_counter) {
> > > @@ -1769,7 +1773,8 @@ static int
> > metricgroup__add_metric_event_callback(const struct pmu_event *pe,
> > >         if (!strcasecmp(pe->name, d->event_name)) {
> > >                 if (!pe->counters)
> > >                         return -EINVAL;
> > > -               event =3D event_info__new(d->event_id, pe->pmu, pe->c=
ounters,
> > /*free_counter=3D*/false);
> > > +               event =3D event_info__new(d->event_id, pe->pmu, pe->c=
ounters,
> > > +                                       pe->taken_alone, /*free_count=
er=3D*/false);
> > >                 if (!event)
> > >                         return -ENOMEM;
> > >                 list_add(&event->nd, d->list);
> > > @@ -1892,6 +1897,8 @@ static int find_and_set_counters(struct
> > metricgroup__event_info *e,
> > >         int ret;
> > >         unsigned long find_bit =3D 0;
> > >
> > > +       if (e->taken_alone && current_group->taken_alone)
> > > +               return -ENOSPC;
> > >         if (e->free_counter)
> > >                 return 0;
> > >         if (e->fixed_counter) {
> > > @@ -1926,11 +1933,13 @@ static int _insert_event(struct
> > metricgroup__event_info *e,
> > >                 list_add(&event->nd, &group->event_head);
> > >         else
> > >                 list_add_tail(&event->nd, &group->event_head);
> > > +       if (e->taken_alone)
> > > +               group->taken_alone =3D true;
> > >         return 0;
> > >  }
> > >
> > >  /**
> > > - * Insert the new_group node at the end of the group list.
> > > + * Initialize the new group and insert it to the end of the group li=
st.
> > >   */
> > >  static int insert_new_group(struct list_head *head,
> > >                            struct metricgroup__group *new_group,
> > > @@ -1940,6 +1949,7 @@ static int insert_new_group(struct list_head
> > *head,
> > >         INIT_LIST_HEAD(&new_group->event_head);
> > >         fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
> > >         fill_counter_bitmap(new_group->fixed_counters, 0,
> > num_fixed_counters);
> > > +       new_group->taken_alone =3D false;
> > >         list_add_tail(&new_group->nd, head);
> > >         return 0;
> > >  }
> > > @@ -2143,8 +2153,8 @@ static int create_grouping(struct list_head
> > *pmu_info_list,
> > >         //TODO: for each new core group, we should consider to add ev=
ents that
> > uses fixed counters
> > >         list_for_each_entry(e, event_info_list, nd) {
> > >                 bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf,
> > NR_COUNTERS);
> > > -               pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s\=
n", e->name,
> > > -                       e->pmu_name, bit_buf);
> > > +               pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s,
> > [taken_alone]=3D%d\n",
> > > +                       e->name, e->pmu_name, bit_buf, e->taken_alone=
);
> > >                 ret =3D assign_event_grouping(e, pmu_info_list, &grou=
ps);
> > >                 if (ret)
> > >                         goto out;
> > > @@ -2191,7 +2201,7 @@ static int hw_aware_build_grouping(struct
> > expr_parse_ctx *ctx __maybe_unused,
> > >                 if (is_special_event(id)) {
> > >                         struct metricgroup__event_info *event;
> > >
> > > -                       event =3D event_info__new(id, "default_core",=
 "0",
> > > +                       event =3D event_info__new(id, "default_core",=
 "0", false,
> >
> > nit: document constant arguments, so "/*taken_alone=3D*/false,"
> >
> > Thanks,
> > Ian
> >
> > >                                                 /*free_counter=3D*/tr=
ue);
> > >                         if (!event)
> > >                                 goto err_out;
> > > --
> > > 2.42.0
> > >

