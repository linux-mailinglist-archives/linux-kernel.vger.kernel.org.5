Return-Path: <linux-kernel+bounces-95872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE687545C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093831F21853
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A212FF92;
	Thu,  7 Mar 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hAIOK8WZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31112FF70
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829706; cv=none; b=RRbLU1tGwt+iU8yNuLAaOYCkaZJLbtv5XVZowtq8pPAcfMVT6hj00iTIUd7rUzTcjPg+KCfNxxLUXEYMLRpTY4sU4L2ewA+rjyZOKqmcueRAVDmUHkLWDeAyA8J+ynpAv739LrUtZ4vx42eNJzGpDKQjZlBfaMYUcGdPh9x5Wg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829706; c=relaxed/simple;
	bh=6nyIKxiQbWnuB6A5JFxe3c+0SCxWLpVupxUECwvczwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrEccpnT1nwoBUaBxN5PZEVotnejkkWCQ0QGkvUk2qNLsKd9U1N2OMWABfKTpio8Pd61Mgk7MVY7oUBYIvpGIkS5nGtUA/b/SYRAXXZniG9qF3RUpPwiiiVdt84bbxM2/5ZTOJq1Y6Mew7sS2mHTsiZ7+ikcSj77QMNj5FCx41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAIOK8WZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc9f4d1106so193475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709829703; x=1710434503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHuE8p/GblvLzvBmTpKW0shJ0jfpxlDm7q0Is36+rvg=;
        b=hAIOK8WZvGPAIxUI+Di+LetjGEwXg5aM6YZ9WKsFSx9bTL2nqfeg9RuZ4Tjf4U41/7
         4a9QvUMe6eEG5Jr5ehp6g1F5bY/o7jP1241unmYW1JM1wJNjWNuUwbx4iEA2tqqkYE11
         yeo8VYaCOEcIxhwBTTK3y1vbdkj5r5fkHu4QPhvcVtdYlb0tHW4oKyDb2O07LKTvFlpr
         +VcjadFqr+Gm/xJzbGS9kbi7GczKVfsWkGFHILlclKK1JJIZ8Hd/ue+94txhTK0+ecBE
         0e3qmGTY/uGuU2G1xyh3N4DJK2xXML2xiCwIZA2jZXSo3Nz+fUPVNvbmWjWJAyV94/Xg
         w3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829703; x=1710434503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHuE8p/GblvLzvBmTpKW0shJ0jfpxlDm7q0Is36+rvg=;
        b=hjjOP/HImooAq9FlsyccKWJbDJNw1YQBU78U+39YjdAsuB6cO/TyfpYSOWnDOmM9yM
         1w56bSr5f9ah/3h74/lXgdjiHi/z9uRPpqEcNpgf7Y4Dh98S2zmXP4k6d9dJ5vU7/xYO
         pf+YpzkIEUeU18id1JIz3EoIySIcf9chJjFYgT30l8afH8G3HmbTnq5ZOdiYWmZCN7oG
         2B9Jtkos7B3a/X3H5SejQ/jQjZeDYninUnIliAAP0kJPGF6Orj4x7WaIZx0QHgDkHWWO
         ag8msawbv2CDhorOK8QReNrTyi/CQXiL683iQWk7QBEK12MO5bZQ4ktmINOW3bQE4fKi
         uGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA9TXCUCmm19U2jOYw9DOyS1SUsrYF55tdQOJJJiVfw4lwnIWAJ/L4kLlXmFLaegioUxQtD6oY4ix0EUg9Oz5SFWc09SXSd/KhXpgt
X-Gm-Message-State: AOJu0YxTv796xnVwtjl/dMzm0nrFl3xrdgmVmb6ANzTKLejd3PVtv5bI
	u1nqWS5qNFp7FDcgMBoIbeXRJgGL52Q/2EIOLPgMjXt6a4eL9rfLLqLNJNEI84q5CVDvnKLxJAY
	WZtxmdhiy5LAJ4wJ7OHDL80zXRFF3MSAHcVcU
X-Google-Smtp-Source: AGHT+IG5x26zmsAYDCnrD3BwwHEov2d5JGtzO8DQJ7g9sUpwQCSyseiWtAF4eRZp3ewQ1sagThhFIJeb6KUbz1beJKY=
X-Received: by 2002:a17:902:cec9:b0:1db:9fed:c591 with SMTP id
 d9-20020a170902cec900b001db9fedc591mr294445plg.22.1709829702816; Thu, 07 Mar
 2024 08:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com> <20240307081412.3933750-5-irogers@google.com>
 <f8f6df3a-2061-4ee1-8d69-735361f83cdd@linux.intel.com>
In-Reply-To: <f8f6df3a-2061-4ee1-8d69-735361f83cdd@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Mar 2024 08:41:29 -0800
Message-ID: <CAP-5=fVDehaXaJ6nBQjxSTRcW9_7WQn-cQwPkyB=s+o=f5gpcw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf list: Give more details about raw event encodings
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:34=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-03-07 3:14 a.m., Ian Rogers wrote:
> > List all the PMUs, not just the first core one, and list real format
> > specifiers with value ranges.
> >
> > Before:
> > ```
> > $ perf list
> > ...
> >   rNNN                                               [Raw hardware even=
t descriptor]
> >   cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier                  [Raw hardware =
event descriptor]
> >        [(see 'man perf-list' on how to encode it)]
> >   mem:<addr>[/len][:access]                          [Hardware breakpoi=
nt]
> > ...
> > ```
> >
> > After:
> > ```
> > $ perf list
> > ...
> >   rNNN                                               [Raw hardware even=
t descriptor]
> >   cpu/event=3D0..255,pc,edge,.../modifier              [Raw hardware ev=
ent descriptor]
> >        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
> >   breakpoint//modifier                               [Raw hardware even=
t descriptor]
> >   cstate_core/event=3D0..0xffffffffffffffff/modifier   [Raw hardware ev=
ent descriptor]
> >   cstate_pkg/event=3D0..0xffffffffffffffff/modifier    [Raw hardware ev=
ent descriptor]
> >   i915/i915_eventid=3D0..0x1fffff/modifier             [Raw hardware ev=
ent descriptor]
> >   intel_bts//modifier                                [Raw hardware even=
t descriptor]
> >   intel_pt/ptw,event,cyc_thresh=3D0..15,.../modifier   [Raw hardware ev=
ent descriptor]
> >   kprobe/retprobe/modifier                           [Raw hardware even=
t descriptor]
> >   msr/event=3D0..0xffffffffffffffff/modifier           [Raw hardware ev=
ent descriptor]
> >   power/event=3D0..255/modifier                        [Raw hardware ev=
ent descriptor]
> >   software//modifier                                 [Raw hardware even=
t descriptor]
>
> Software apparently is not a raw hardware event. Ideally, we should have
> a consist name. E.g.,
> software//modifier      [Raw Software event descriptor]
> tracepoint//modifier    [Raw Tracepoint event descriptor]
>
> If it's too complex, I guess using [event descriptor] or just dropping
> it should be OK for me as well.

Thanks Kan! I think just "[Raw event descriptor]" so I can avoid
having a bunch of special case logic.

>
> >   tracepoint//modifier                               [Raw hardware even=
t descriptor]
> >   uncore_arb/event=3D0..255,edge,inv,.../modifier      [Raw hardware ev=
ent descriptor]
> >   uncore_cbox/event=3D0..255,edge,inv,.../modifier     [Raw hardware ev=
ent descriptor]
> >   uncore_clock/event=3D0..255/modifier                 [Raw hardware ev=
ent descriptor]
> >   uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier[Raw ha=
rdware event descriptor]
> >   uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier[Raw hardware =
event descriptor]
> >   mem:<addr>[/len][:access]                          [Hardware breakpoi=
nt]
> > ...
> > ```
> >
> > With '--details' provide more details on the formats encoding:
> > ```
> >   cpu/event=3D0..255,pc,edge,.../modifier              [Raw hardware ev=
ent descriptor]
> >        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
> >         cpu/event=3D0..255,pc,edge,offcore_rsp=3D0..0xffffffffffffffff,=
ldlat=3D0..0xffff,inv,
> >         umask=3D0..255,frontend=3D0..0xffffff,cmask=3D0..255,config=3D0=
.0xffffffffffffffff,
> >         config1=3D0..0xffffffffffffffff,config2=3D0..0xffffffffffffffff=
,config3=3D0..0xffffffffffffffff,
> >         name=3Dstring,period=3Dnumber,freq=3Dnumber,branch_type=3D(u|k|=
hv|any|...),time,
> >         call-graph=3D(fp|dwarf|lbr),stack-size=3Dnumber,max-stack=3Dnum=
ber,nr=3Dnumber,inherit,no-inherit,
> >         overwrite,no-overwrite,percore,aux-output,aux-sample-size=3Dnum=
ber/modifier
> >   breakpoint//modifier                               [Raw hardware even=
t descriptor]
> >         breakpoint//modifier
> >   cstate_core/event=3D0..0xffffffffffffffff/modifier   [Raw hardware ev=
ent descriptor]
> >         cstate_core/event=3D0..0xffffffffffffffff/modifier
> >   cstate_pkg/event=3D0..0xffffffffffffffff/modifier    [Raw hardware ev=
ent descriptor]
> >         cstate_pkg/event=3D0..0xffffffffffffffff/modifier
> >   i915/i915_eventid=3D0..0x1fffff/modifier             [Raw hardware ev=
ent descriptor]
> >         i915/i915_eventid=3D0..0x1fffff/modifier
> >   intel_bts//modifier                                [Raw hardware even=
t descriptor]
> >         intel_bts//modifier
> >   intel_pt/ptw,event,cyc_thresh=3D0..15,.../modifier   [Raw hardware ev=
ent descriptor]
> >         intel_pt/ptw,event,cyc_thresh=3D0..15,pt,notnt,branch,tsc,pwr_e=
vt,fup_on_ptw,cyc,noretcomp,
> >         mtc,psb_period=3D0..15,mtc_period=3D0..15/modifier
> >   kprobe/retprobe/modifier                           [Raw hardware even=
t descriptor]
> >         kprobe/retprobe/modifier
> >   msr/event=3D0..0xffffffffffffffff/modifier           [Raw hardware ev=
ent descriptor]
> >         msr/event=3D0..0xffffffffffffffff/modifier
> >   power/event=3D0..255/modifier                        [Raw hardware ev=
ent descriptor]
> >         power/event=3D0..255/modifier
> >   software//modifier                                 [Raw hardware even=
t descriptor]
> >         software//modifier
> >   tracepoint//modifier                               [Raw hardware even=
t descriptor]
> >         tracepoint//modifier
> >   uncore_arb/event=3D0..255,edge,inv,.../modifier      [Raw hardware ev=
ent descriptor]
> >         uncore_arb/event=3D0..255,edge,inv,umask=3D0..255,cmask=3D0..31=
/modifier
> >   uncore_cbox/event=3D0..255,edge,inv,.../modifier     [Raw hardware ev=
ent descriptor]
> >         uncore_cbox/event=3D0..255,edge,inv,umask=3D0..255,cmask=3D0..3=
1/modifier
> >   uncore_clock/event=3D0..255/modifier                 [Raw hardware ev=
ent descriptor]
> >         uncore_clock/event=3D0..255/modifier
> >   uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier[Raw ha=
rdware event descriptor]
> >         uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier
> >   uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier[Raw hardware =
event descriptor]
> >         uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c          | 55 +++++++++++++++++++-
> >  tools/perf/util/pmu.h          |  3 ++
> >  tools/perf/util/pmus.c         | 94 ++++++++++++++++++++++++++++++++++
> >  tools/perf/util/pmus.h         |  1 +
> >  tools/perf/util/print-events.c | 18 +------
> >  5 files changed, 153 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 24be587e3537..904725f03d29 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1603,6 +1603,55 @@ bool perf_pmu__has_format(const struct perf_pmu =
*pmu, const char *name)
> >       return false;
> >  }
> >
> > +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_f=
ormat_callback cb)
> > +{
> > +     static const char *const terms[] =3D {
> > +             "config=3D0..0xffffffffffffffff",
> > +             "config1=3D0..0xffffffffffffffff",
> > +             "config2=3D0..0xffffffffffffffff",
> > +             "config3=3D0..0xffffffffffffffff",
> > +             "name=3Dstring",
> > +             "period=3Dnumber",
> > +             "freq=3Dnumber",
> > +             "branch_type=3D(u|k|hv|any|...)",
> > +             "time",
> > +             "call-graph=3D(fp|dwarf|lbr)",
> > +             "stack-size=3Dnumber",
> > +             "max-stack=3Dnumber",
> > +             "nr=3Dnumber",
> > +             "inherit",
> > +             "no-inherit",
> > +             "overwrite",
> > +             "no-overwrite",
> > +             "percore",
> > +             "aux-output",
> > +             "aux-sample-size=3Dnumber",
> > +     };
>
> I think it's very likely we forget to update the const table when
> introducing a new term. In the parse-events.c, there is
> config_term_names[] to restore the name of terms. Can it be shared here?
> So every time a new term is introduced, the perf list can be updated
> automatically.

Makes sense, I'll add in v2. I was originally pondering making the
list specific in some way. Perhaps in the future we can associate
valid generic terms with PMUs, like the config_term_common,
config_term_pmu, etc. code in parse-events.c.

Thanks,
Ian

> Thanks,
> Kan
> > +     struct perf_pmu_format *format;
> > +     int ret;
> > +
> > +     list_for_each_entry(format, &pmu->format, list) {
> > +             perf_pmu_format__load(pmu, format);
> > +             ret =3D cb(state, format->name, (int)format->value, forma=
t->bits);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     if (!pmu->is_core)
> > +             return 0;
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(terms); i++) {
> > +             int config =3D PERF_PMU_FORMAT_VALUE_CONFIG;
> > +
> > +             if (i < PERF_PMU_FORMAT_VALUE_CONFIG_END)
> > +                     config =3D i;
> > +
> > +             ret =3D cb(state, terms[i], config, /*bits=3D*/NULL);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> >  bool is_pmu_core(const char *name)
> >  {
> >       return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sys=
fs_pmu_core(name);
> > @@ -1697,8 +1746,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pm=
u, bool skip_duplicate_pmus,
> >       pmu_add_cpu_aliases(pmu);
> >       list_for_each_entry(event, &pmu->aliases, list) {
> >               size_t buf_used;
> > +             int pmu_name_len;
> >
> >               info.pmu_name =3D event->pmu_name ?: pmu->name;
> > +             pmu_name_len =3D skip_duplicate_pmus
> > +                     ? pmu_name_len_no_suffix(info.pmu_name, /*num=3D*=
/NULL)
> > +                     : (int)strlen(info.pmu_name);
> >               info.alias =3D NULL;
> >               if (event->desc) {
> >                       info.name =3D event->name;
> > @@ -1723,7 +1776,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
> >               info.encoding_desc =3D buf + buf_used;
> >               parse_events_terms__to_strbuf(&event->terms, &sb);
> >               buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_=
used,
> > -                             "%s/%s/", info.pmu_name, sb.buf) + 1;
> > +                             "%.*s/%s/", pmu_name_len, info.pmu_name, =
sb.buf) + 1;
> >               info.topic =3D event->topic;
> >               info.str =3D sb.buf;
> >               info.deprecated =3D event->deprecated;
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index e35d985206db..9f5284b29ecf 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -196,6 +196,8 @@ struct pmu_event_info {
> >  };
> >
> >  typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *=
info);
> > +typedef int (*pmu_format_callback)(void *state, const char *name, int =
config,
> > +                                const unsigned long *bits);
> >
> >  void pmu_add_sys_aliases(struct perf_pmu *pmu);
> >  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *att=
r,
> > @@ -215,6 +217,7 @@ int perf_pmu__find_event(struct perf_pmu *pmu, cons=
t char *event, void *state, p
> >  int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager=
_load);
> >  void perf_pmu_format__set_value(void *format, int config, unsigned lon=
g *bits);
> >  bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name=
);
> > +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_f=
ormat_callback cb);
> >
> >  bool is_pmu_core(const char *name);
> >  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 16505071d362..89b15ddeb24e 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -16,6 +16,7 @@
> >  #include "pmus.h"
> >  #include "pmu.h"
> >  #include "print-events.h"
> > +#include "strbuf.h"
> >
> >  /*
> >   * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it'=
s sysfs
> > @@ -503,6 +504,99 @@ void perf_pmus__print_pmu_events(const struct prin=
t_callbacks *print_cb, void *p
> >       zfree(&aliases);
> >  }
> >
> > +struct build_format_string_args {
> > +     struct strbuf short_string;
> > +     struct strbuf long_string;
> > +     int num_formats;
> > +};
> > +
> > +static int build_format_string(void *state, const char *name, int conf=
ig,
> > +                            const unsigned long *bits)
> > +{
> > +     struct build_format_string_args *args =3D state;
> > +     unsigned int num_bits;
> > +     int ret1, ret2 =3D 0;
> > +
> > +     (void)config;
> > +     args->num_formats++;
> > +     if (args->num_formats > 1) {
> > +             strbuf_addch(&args->long_string, ',');
> > +             if (args->num_formats < 4)
> > +                     strbuf_addch(&args->short_string, ',');
> > +     }
> > +     num_bits =3D bits ? bitmap_weight(bits, PERF_PMU_FORMAT_BITS) : 0=
;
> > +     if (num_bits <=3D 1) {
> > +             ret1 =3D strbuf_addf(&args->long_string, "%s", name);
> > +             if (args->num_formats < 4)
> > +                     ret2 =3D strbuf_addf(&args->short_string, "%s", n=
ame);
> > +     } else if (num_bits > 8) {
> > +             ret1 =3D strbuf_addf(&args->long_string, "%s=3D0..0x%llx"=
, name,
> > +                                ULLONG_MAX >> (64 - num_bits));
> > +             if (args->num_formats < 4) {
> > +                     ret2 =3D strbuf_addf(&args->short_string, "%s=3D0=
.0x%llx", name,
> > +                                        ULLONG_MAX >> (64 - num_bits))=
;
> > +             }
> > +     } else {
> > +             ret1 =3D strbuf_addf(&args->long_string, "%s=3D0..%llu", =
name,
> > +                               ULLONG_MAX >> (64 - num_bits));
> > +             if (args->num_formats < 4) {
> > +                     ret2 =3D strbuf_addf(&args->short_string, "%s=3D0=
.%llu", name,
> > +                                        ULLONG_MAX >> (64 - num_bits))=
;
> > +             }
> > +     }
> > +     return ret1 < 0 ? ret1 : (ret2 < 0 ? ret2 : 0);
> > +}
> > +
> > +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *pri=
nt_cb, void *print_state)
> > +{
> > +     bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_=
state);
> > +     struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     if (skip_duplicate_pmus)
> > +             scan_fn =3D perf_pmus__scan_skip_duplicates;
> > +     else
> > +             scan_fn =3D perf_pmus__scan;
> > +
> > +     while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> > +             struct build_format_string_args format_args =3D {
> > +                     .short_string =3D STRBUF_INIT,
> > +                     .long_string =3D STRBUF_INIT,
> > +                     .num_formats =3D 0,
> > +             };
> > +             int len =3D pmu_name_len_no_suffix(pmu->name, /*num=3D*/N=
ULL);
> > +             const char *desc =3D "(see 'man perf-list' or 'man perf-r=
ecord' on how to encode it)";
> > +
> > +             if (!pmu->is_core)
> > +                     desc =3D NULL;
> > +
> > +             strbuf_addf(&format_args.short_string, "%.*s/", len, pmu-=
>name);
> > +             strbuf_addf(&format_args.long_string, "%.*s/", len, pmu->=
name);
> > +             perf_pmu__for_each_format(pmu, &format_args, build_format=
_string);
> > +
> > +             if (format_args.num_formats > 3)
> > +                     strbuf_addf(&format_args.short_string, ",.../modi=
fier");
> > +             else
> > +                     strbuf_addf(&format_args.short_string, "/modifier=
");
> > +
> > +             strbuf_addf(&format_args.long_string, "/modifier");
> > +             print_cb->print_event(print_state,
> > +                             /*topic=3D*/NULL,
> > +                             /*pmu_name=3D*/NULL,
> > +                             format_args.short_string.buf,
> > +                             /*event_alias=3D*/NULL,
> > +                             /*scale_unit=3D*/NULL,
> > +                             /*deprecated=3D*/false,
> > +                             "Raw hardware event descriptor",
> > +                             desc,
> > +                             /*long_desc=3D*/NULL,
> > +                             format_args.long_string.buf);
> > +
> > +             strbuf_release(&format_args.short_string);
> > +             strbuf_release(&format_args.long_string);
> > +     }
> > +}
> > +
> >  bool perf_pmus__have_event(const char *pname, const char *name)
> >  {
> >       struct perf_pmu *pmu =3D perf_pmus__find(pname);
> > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > index 94d2a08d894b..eec599d8aebd 100644
> > --- a/tools/perf/util/pmus.h
> > +++ b/tools/perf/util/pmus.h
> > @@ -18,6 +18,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu=
 *pmu);
> >  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
> >
> >  void perf_pmus__print_pmu_events(const struct print_callbacks *print_c=
b, void *print_state);
> > +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *pri=
nt_cb, void *print_state);
> >  bool perf_pmus__have_event(const char *pname, const char *name);
> >  int perf_pmus__num_core_pmus(void);
> >  bool perf_pmus__supports_extended_type(void);
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-eve=
nts.c
> > index e0d2b49bab66..3a7f14fe2390 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -416,8 +416,6 @@ void print_symbol_events(const struct print_callbac=
ks *print_cb, void *print_sta
> >   */
> >  void print_events(const struct print_callbacks *print_cb, void *print_=
state)
> >  {
> > -     char *tmp;
> > -
> >       print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
> >                       event_symbols_hw, PERF_COUNT_HW_MAX);
> >       print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
> > @@ -441,21 +439,7 @@ void print_events(const struct print_callbacks *pr=
int_cb, void *print_state)
> >                       /*long_desc=3D*/NULL,
> >                       /*encoding_desc=3D*/NULL);
> >
> > -     if (asprintf(&tmp, "%s/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier",
> > -                  perf_pmus__scan_core(/*pmu=3D*/NULL)->name) > 0) {
> > -             print_cb->print_event(print_state,
> > -                             /*topic=3D*/NULL,
> > -                             /*pmu_name=3D*/NULL,
> > -                             tmp,
> > -                             /*event_alias=3D*/NULL,
> > -                             /*scale_unit=3D*/NULL,
> > -                             /*deprecated=3D*/false,
> > -                             event_type_descriptors[PERF_TYPE_RAW],
> > -                             "(see 'man perf-list' on how to encode it=
)",
> > -                             /*long_desc=3D*/NULL,
> > -                             /*encoding_desc=3D*/NULL);
> > -             free(tmp);
> > -     }
> > +     perf_pmus__print_raw_pmu_events(print_cb, print_state);
> >
> >       print_cb->print_event(print_state,
> >                       /*topic=3D*/NULL,

