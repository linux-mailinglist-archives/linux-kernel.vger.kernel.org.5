Return-Path: <linux-kernel+bounces-139143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B289FF09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EFE1F24A32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DF180A68;
	Wed, 10 Apr 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCwffH8w"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1B1779B4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771246; cv=none; b=XSlbif+Re8cjvaS1ACSTZcK8ZP+V8fPbnOPR5t8zHWHthM5fe4YmUed43vx/mlQ515ZRdAi5/ClQLt8QqKxTRSnYb2a/iMiHQpxvVmUOBV38IcQs6Z7yULjIxYms3oKXvZaR7jF1+KMid4ny3KrVSmrk7ZrrkrceYIvSLnzPefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771246; c=relaxed/simple;
	bh=U2pZnP1konvnQhB/8ukCXwjpY2KiZnevOUsD5Sl3zFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI2vgoaJhgijD/mKtdp8JdOUD2bqp+4Id1sWi7+48uM3Zu3LOHcczbxh+W3w2XJHDR19ud13yiE4KbgABG8Dew5dfWr9z2N1/ppy706Tkl2XQmvbNZI3eCfcCDmXgjW7VkMzDQGsjZ8yu7o7wgYrYNbfwL9NjcQGfcCz3CnWHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCwffH8w; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a0c8c5f18so14475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712771244; x=1713376044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8JBr66IYQPbEWB8lMmmv3b0L51hsKTke/Sa3zBljZA=;
        b=uCwffH8wGLg5SQVLHPhLu0l8cwC8AoGbNP5OAAZDSljmD0PMzbMzI3G4Xp9qZDgI/L
         IOf7Z9T40zJz2EQCgX6kQFdLhU/GWECLuXzenHWrjKkTvHuX/yMIqw6wylWBcWXzRpLP
         WCREJiRQh3BeWA1GXc0sTcKbQWE5CnfhIBQisTU4KH6b1BtpO/m7HQqKisTarCLBAvuZ
         VjgHxa8qPr/BezZR4+XYXwM2SKD4z6XkyYLaHWSA/UQdscsTMvsjZtTPxQdGOd6E4oJg
         3ayplhTclJ4lpHtXJnFRGNMBV/+/CFGyk4peT7MEk57ikSzAQZ+ifRlD/KuMcdAFp/P6
         sjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771244; x=1713376044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8JBr66IYQPbEWB8lMmmv3b0L51hsKTke/Sa3zBljZA=;
        b=qeICz/7tEeYGxZ2B3AeN5iRGVPNU43X9sqfmwAlJNw7zqESWYzq0wMBDHOEW7FPtcd
         K2W7Z+jdn5qwP3vgLQtogOOF9u2bcXiDzOyPjWXHZQkJogRmr9ffkMw54SfPT7RLCopJ
         1TTjVFBO4TvPloTJVlvtJQLZP2PB/n0gvh2fhZfYUUKBNbPPIjucSY0/T3WqIgaz8Q5c
         LofsUAsWbRvWE6aAifX2Am/LDfma12Q8KblxL27tlnxgONJJPOqahmMwBxrWEo+y7wz9
         L4cYuqLDqovwHTN11EzWGL3ScO2zAFFCE92poM7pp6YFBHzfk2WbUq6eIVDZbjU5+k5c
         cQug==
X-Forwarded-Encrypted: i=1; AJvYcCWLtBeUFfprqujBKDh7tTrHfJlOsxb8FZJ0fXxjDn0pp3n9Wk+bC7KN2ocls75sCteeshxO8XGB+kVzGR+AdKLAZWgbAOC6wLkoL4hd
X-Gm-Message-State: AOJu0Yyns1cAoZ4ZIG5w8zo1mWWtkiNl3aznJdDIwlyDEQYmJVRsPcCR
	vXLorg7ScZ99ZHUPP17JgwhLcFYo03ZlwYP954zcux95j/xPcrxTNCLltqG4DE9kDoAEcy0wMoq
	kCecuMcQv6PfWJmXpfLovbSRhpfaP1wgg9U5F
X-Google-Smtp-Source: AGHT+IEwyeH/uTKd6vE5FT7EZV1m93yRVgWhpRUWKwhkTvRVpwZ3B7d44wWKlovjHjyWZoB3QtTzSrMZh/Q2PW7McPE=
X-Received: by 2002:a05:6e02:18c7:b0:369:e18b:bda2 with SMTP id
 s7-20020a056e0218c700b00369e18bbda2mr14021ilu.6.1712771243877; Wed, 10 Apr
 2024 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com>
 <20240209031441.943012-15-weilin.wang@intel.com> <CAP-5=fU1R7QYKCWPrrZ_wA1RCfat+BqiA12=UG2a-GrBLPL0BA@mail.gmail.com>
 <CO6PR11MB56358253F9CE3C3772A665EEEE072@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56358253F9CE3C3772A665EEEE072@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 10:47:12 -0700
Message-ID: <CAP-5=fVtLbRva9KLMdDPNMkF-F9LDp-3C10RymC-QbYdtwEbQA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 14/15] perf stat: Add tool events support in hardware-grouping
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

On Tue, Apr 9, 2024 at 1:51=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Saturday, March 23, 2024 10:56 PM
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
> > Subject: Re: [RFC PATCH v4 14/15] perf stat: Add tool events support in
> > hardware-grouping
> >
> > On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add tool events into default_core grouping strings if find tool event=
s so
> > > that metrics use tool events could be correctly calculated. Need this=
 step
> > > to support TopdownL4-L5.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/util/metricgroup.c | 49
> > ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> > > index cfdbb5f7fb77..e5b8456d0405 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -1486,6 +1486,35 @@ static void find_tool_events(const struct
> > list_head *metric_list,
> > >         }
> > >  }
> > >
> > > +/**
> > > + * get_tool_event_str - Generate and return a string with all the us=
ed tool
> > > + * event names.
> > > + */
> > > +static int get_tool_event_str(struct strbuf *events,
> > > +                             const bool tool_events[PERF_TOOL_MAX],
> > > +                             bool *has_tool_event)
> > > +{
> > > +       int i =3D 0;
> > > +       int ret;
> > > +
> > > +       perf_tool_event__for_each_event(i) {
> > > +               if (tool_events[i]) {
> > > +                       const char *tmp =3D strdup(perf_tool_event__t=
o_str(i));
> > > +
> > > +                       if (!tmp)
> > > +                               return -ENOMEM;
> > > +                       *has_tool_event =3D true;
> > > +                       ret =3D strbuf_addstr(events, ",");
> > > +                       if (ret)
> > > +                               return ret;
> > > +                       ret =3D strbuf_addstr(events, tmp);
> > > +                       if (ret)
> > > +                               return ret;
> > > +               }
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  /**
> > >   * build_combined_expr_ctx - Make an expr_parse_ctx with
> > all !group_events
> > >   *                           metric IDs, as the IDs are held in a se=
t,
> > > @@ -2049,6 +2078,7 @@ static int assign_event_grouping(struct
> > metricgroup__event_info *e,
> > >
> > >  static int hw_aware_metricgroup__build_event_string(struct list_head
> > *group_strs,
> > >                                            const char *modifier,
> > > +                                          const bool tool_events[PER=
F_TOOL_MAX],
> > >                                            struct list_head *groups)
> > >  {
> > >         struct metricgroup__pmu_group_list *p;
> > > @@ -2056,8 +2086,12 @@ static int
> > hw_aware_metricgroup__build_event_string(struct list_head *group_strs
> > >         struct metricgroup__group_events *ge;
> > >         bool no_group =3D true;
> > >         int ret =3D 0;
> > > +       struct strbuf tool_event_str =3D STRBUF_INIT;
> > > +       bool has_tool_event =3D false;
> > >
> > >  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> > > +       ret =3D get_tool_event_str(&tool_event_str, tool_events,
> > &has_tool_event);
> >
> > Does metricgroup__build_event_string need updating to use this helper
> > function too?
>
> Hi Ian,
>
> In parse_ids, tool events are inserted to the ids that passed to
> metricgroup__build_event_string. If we want to use this function here, I =
think
> we also need to update the code in parse_ids to not insert tool events.
>
> I could add this change if you think we should do this update.

I like code-reuse and sharing logic whenever possible, it seems
potentially messy though. I'll leave it up to your judgement as to
whether it is worth cleaning up. Perhaps there should be a TODO if
not.

Thanks,
Ian

> Thanks,
> Weilin
>
> >
> > Thanks,
> > Ian
> >
> > > +       RETURN_IF_NON_ZERO(ret);
> > >
> > >         list_for_each_entry(p, groups, nd) {
> > >                 list_for_each_entry(g, &p->group_head, nd) {
> > > @@ -2129,6 +2163,12 @@ static int
> > hw_aware_metricgroup__build_event_string(struct list_head *group_strs
> > >                         }
> > >                         ret =3D strbuf_addf(events, "}:W");
> > >                         RETURN_IF_NON_ZERO(ret);
> > > +
> > > +                       if (!strcmp(p->pmu_name, "default_core") && h=
as_tool_event)
> > {
> > > +                               ret =3D strbuf_addstr(events, tool_ev=
ent_str.buf);
> > > +                               RETURN_IF_NON_ZERO(ret);
> > > +                       }
> > > +
> > >                         pr_debug("events-buf: %s\n", events->buf);
> > >                         list_add_tail(&new_group_str->nd, group_strs)=
;
> > >                 }
> > > @@ -2214,6 +2254,7 @@ static int hw_aware_build_grouping(struct
> > expr_parse_ctx *ctx,
> > >                 if (ret)
> > >                         goto err_out;
> > >         }
> > > +
> > >         ret =3D get_pmu_counter_layouts(&pmu_info_list, ltable);
> > >         if (ret)
> > >                 goto err_out;
> > > @@ -2259,6 +2300,7 @@ static void
> > metricgroup__free_grouping_strs(struct list_head
> > >   */
> > >  static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
> > >                              struct expr_parse_ctx *ids, const char *=
modifier,
> > > +                            const bool tool_events[PERF_TOOL_MAX],
> > >                              struct evlist **out_evlist)
> > >  {
> > >         struct parse_events_error parse_error;
> > > @@ -2272,7 +2314,8 @@ static int hw_aware_parse_ids(struct perf_pmu
> > *fake_pmu,
> > >         ret =3D hw_aware_build_grouping(ids, &grouping);
> > >         if (ret)
> > >                 goto out;
> > > -       ret =3D hw_aware_metricgroup__build_event_string(&grouping_st=
r,
> > modifier, &grouping);
> > > +       ret =3D hw_aware_metricgroup__build_event_string(&grouping_st=
r,
> > modifier,
> > > +                                                     tool_events, &g=
rouping);
> > >         if (ret)
> > >                 goto out;
> > >
> > > @@ -2407,6 +2450,7 @@ static int hw_aware_parse_groups(struct evlist
> > *perf_evlist,
> > >         struct evlist *combined_evlist =3D NULL;
> > >         LIST_HEAD(metric_list);
> > >         struct metric *m;
> > > +       bool tool_events[PERF_TOOL_MAX] =3D {false};
> > >         int ret;
> > >         bool metric_no_group =3D false;
> > >         bool metric_no_merge =3D false;
> > > @@ -2425,11 +2469,14 @@ static int hw_aware_parse_groups(struct evlis=
t
> > *perf_evlist,
> > >         if (!metric_no_merge) {
> > >                 struct expr_parse_ctx *combined =3D NULL;
> > >
> > > +               find_tool_events(&metric_list, tool_events);
> > > +
> > >                 ret =3D hw_aware_build_combined_expr_ctx(&metric_list=
,
> > &combined);
> > >
> > >                 if (!ret && combined && hashmap__size(combined->ids))=
 {
> > >                         ret =3D hw_aware_parse_ids(fake_pmu, combined=
,
> > >                                                 /*modifier=3D*/NULL,
> > > +                                               tool_events,
> > >                                                 &combined_evlist);
> > >                 }
> > >
> > > --
> > > 2.42.0
> > >

