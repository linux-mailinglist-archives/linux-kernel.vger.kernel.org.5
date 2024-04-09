Return-Path: <linux-kernel+bounces-137207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523089DEDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099E2299793
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425280619;
	Tue,  9 Apr 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOH1Ma7m"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5934AED6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676056; cv=none; b=WhiEkftWQs/iJ9DTUBj8Mgx1cM8CegFQRALjOjJIWuAgeSpgjCc96BpvWDFjIqzJoKe+QYyM5825M5qqJtPr3et0Ngbregln/V/hOcEg10LY1ryt+lvViMI1RgqJTm6TGsZDxWfwcQZGk3oWDE1HEBEbW58ixARMHgJGtt5HMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676056; c=relaxed/simple;
	bh=LTD+mhfPRehkNEyaFJWaRvw2jJwZDKY0SI/jSRdJUQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msrIESdb7vgjrNV9C+tOj8pg0v4rUf8QktRAM2ut65J1Tfc0EyeVlhNQHIqt1KUunDHDOdJKtRXb38pl2iePpMPhXRRAp/sLnmBs6TKPM4pejf1u5yQYAYL+dCPp7zogcIqI605fCWfvWSnBkZrpIjbdmB7w6ryLyBsw+t/cK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOH1Ma7m; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ee0c326e8so346441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712676053; x=1713280853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFuqaDnaOkGluf5UzjqPL+fVURXSAJrdpEHRxej2ffc=;
        b=UOH1Ma7m/NoOpYVCt1esAEOf3W/Pkshsg+h8EaEb89gEmdDbipRBnyAZ35Cj1orcJ6
         MkBVh2LP0Lqs7JhBOyTUtD4WGRdzD3Z1w9kaeW6fSKlyW7nEvBmn+vU5WrOGWDUbwE7Q
         cy9UFP8VqM4KJ5s5V8VkYPDPLmHPHXmCgQUGb7DcDQbjGOvLCkXpJLt9Nh2DZ4lxzl+Q
         Y9yrC7Uwy93xIoy9/mArJqn+XQ4k3d4QCn1lyCsBOUeuCrFxaXcPcXZSzldRUZztP9GZ
         HMN3zvm+ZL5I6OkT4kHkdb6rd2J6/uMZlARBFoAnZr4MVLR74vjXHILSDJYRImOqEBZ7
         rn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676053; x=1713280853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFuqaDnaOkGluf5UzjqPL+fVURXSAJrdpEHRxej2ffc=;
        b=ixo1YCHRu5GZmZCqrJmzkl+6glX4WdujK+qOKKQyLcv6ZYHC8fhpwYyInypj/R5bOE
         cYWEskvNBYFAQVYTiG2ZUzV3+ewEqfOOozV1VxRUOQhdKLDTRDLJj3L386OtI17cKbqX
         TA7tmxZBVE82NiLoemyRUHu+bmWD0oIr2X1gjYzMUzJrZA9ze/+NvySxEMWDZchOgIly
         wZ9XpovF/COatvYkgh2Kukii+/4iPeIYDHuj94W2lStKoCBLCRO49S7Bx9UfgetoXsJ+
         ikhUb55Vs6GNRk1klPCgdKYeadmNeshEetKayt97ziLTJ9utTGsoT62u0RV6X6dLqDDS
         w8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUFb5iSU1clOQAl6x2KMnF+3lIZbNztl0rtQkXx8h+RvoaVcNydNW++sF2erxcMG0D7arcjdUYBbHfN14uihuICDzfGqtO5oOzwaxvi
X-Gm-Message-State: AOJu0YwrZ3KGPwfE5GNgOyfrMcKp3rHYWjNXdHHnI0NNir4nv5axbJOF
	pW8YjYPo7CSK6pcQM954FLYsbmMnNYuCmwgkEc+pIs+ZnCP640S3RarPi8uhjCW76h7xCPNh6q7
	+XgJ8uOLFCzSjbOK1+9RlRSuKeTZKrPS5hwTM
X-Google-Smtp-Source: AGHT+IG4KTX5VXe6SSRgfM8ZVIDsqfe4/iiVdzVWRX/sUXM+UoWJyIzB+ECThAaE7O3KhHkrt4lsM2sOTdiYeuSMwo8=
X-Received: by 2002:a05:622a:5c88:b0:434:7929:93fd with SMTP id
 ge8-20020a05622a5c8800b00434792993fdmr259640qtb.3.1712676052586; Tue, 09 Apr
 2024 08:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406073804.1932415-1-irogers@google.com> <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
In-Reply-To: <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 08:20:36 -0700
Message-ID: <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use strings
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:41=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-04-06 3:38 a.m., Ian Rogers wrote:
> > add_default_atttributes would add evsels by having pre-created
> > perf_event_attr, however, this needed fixing for hybrid as the
> > extended PMU type was necessary for each core PMU. The logic for this
> > was in an arch specific x86 function and wasn't present for ARM,
> > meaning that default events weren't being opened on all PMUs on
> > ARM. Change the creation of the default events to use parse_events and
> > strings as that will open the events on all PMUs.
> >
> > Rather than try to detect events on PMUs before parsing, parse the
> > event but skip its output in stat-display.
>
> But the current skip could leave unnecessary empty lines. It's better to
> avoid the empty lines as well.
>
> $perf stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.91 msec task-clock                       #    0.001 CPUs
> utilized
>                  1      context-switches                 #    1.096 K/sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 68      page-faults                      #   74.534 K/sec
>          1,121,410      instructions                     #    1.04  insn
> per cycle
>          1,081,095      cycles                           #    1.185 GHz
>
>
>            251,649      branches                         #  275.829 M/sec
>              7,252      branch-misses                    #    2.88% of
> all branches

Agreed. Will fix for v2.

>
> >
> > Closes: https://lore.kernel.org/lkml/CAP-5=3DfVABSBZnsmtRn1uF-k-G1GWM-L=
5SgiinhPTfHbQsKXb_g@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evlist.c |  74 +-------
> >  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
> >  tools/perf/util/evlist.c          |  43 -----
> >  tools/perf/util/evlist.h          |  12 --
> >  tools/perf/util/stat-display.c    |   3 +
> >  5 files changed, 118 insertions(+), 305 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index b1ce0c52d88d..fb8e314aa364 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -1,78 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <stdio.h>
> > -#include "util/pmu.h"
> > -#include "util/pmus.h"
> > -#include "util/evlist.h"
> > -#include "util/parse-events.h"
> > -#include "util/event.h"
> > +#include <string.h>
> > +#include "../../../util/evlist.h"
> > +#include "../../../util/evsel.h"
> >  #include "topdown.h"
> >  #include "evsel.h"
> >
> > -static int ___evlist__add_default_attrs(struct evlist *evlist,
> > -                                     struct perf_event_attr *attrs,
> > -                                     size_t nr_attrs)
> > -{
> > -     LIST_HEAD(head);
> > -     size_t i =3D 0;
> > -
> > -     for (i =3D 0; i < nr_attrs; i++)
> > -             event_attr_init(attrs + i);
> > -
> > -     if (perf_pmus__num_core_pmus() =3D=3D 1)
> > -             return evlist__add_attrs(evlist, attrs, nr_attrs);
> > -
> > -     for (i =3D 0; i < nr_attrs; i++) {
> > -             struct perf_pmu *pmu =3D NULL;
> > -
> > -             if (attrs[i].type =3D=3D PERF_TYPE_SOFTWARE) {
> > -                     struct evsel *evsel =3D evsel__new(attrs + i);
> > -
> > -                     if (evsel =3D=3D NULL)
> > -                             goto out_delete_partial_list;
> > -                     list_add_tail(&evsel->core.node, &head);
> > -                     continue;
> > -             }
> > -
> > -             while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > -                     struct perf_cpu_map *cpus;
> > -                     struct evsel *evsel;
> > -
> > -                     evsel =3D evsel__new(attrs + i);
> > -                     if (evsel =3D=3D NULL)
> > -                             goto out_delete_partial_list;
> > -                     evsel->core.attr.config |=3D (__u64)pmu->type << =
PERF_PMU_TYPE_SHIFT;
> > -                     cpus =3D perf_cpu_map__get(pmu->cpus);
> > -                     evsel->core.cpus =3D cpus;
> > -                     evsel->core.own_cpus =3D perf_cpu_map__get(cpus);
> > -                     evsel->pmu_name =3D strdup(pmu->name);
> > -                     list_add_tail(&evsel->core.node, &head);
> > -             }
> > -     }
> > -
> > -     evlist__splice_list_tail(evlist, &head);
> > -
> > -     return 0;
> > -
> > -out_delete_partial_list:
> > -     {
> > -             struct evsel *evsel, *n;
> > -
> > -             __evlist__for_each_entry_safe(&head, n, evsel)
> > -                     evsel__delete(evsel);
> > -     }
> > -     return -1;
> > -}
> > -
> > -int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -                                struct perf_event_attr *attrs,
> > -                                size_t nr_attrs)
> > -{
> > -     if (!nr_attrs)
> > -             return 0;
> > -
> > -     return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> >  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> >  {
> >       if (topdown_sys_has_perf_metrics() &&
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 65388c57bb5d..e7de32a8c10c 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1944,130 +1944,25 @@ static int perf_stat_init_aggr_mode_file(struc=
t perf_stat *st)
> >  }
> >
> >  /*
> > - * Add default attributes, if there were no attributes specified or
> > + * Add default events, if there were no attributes specified or
> >   * if -d/--detailed, -d -d or -d -d -d is used:
> >   */
> > -static int add_default_attributes(void)
> > +static int add_default_events(void)
> >  {
> > -     struct perf_event_attr default_attrs0[] =3D {
> > -
> > -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_TASK_CLOCK=
           },
> > -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_CONTEXT_SW=
ITCHES     },
> > -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_CPU_MIGRAT=
IONS               },
> > -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_PAGE_FAULT=
S          },
> > -
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_CPU_CYCLES=
           },
> > -};
> > -     struct perf_event_attr frontend_attrs[] =3D {
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_STALLED_CY=
CLES_FRONTEND      },
> > -};
> > -     struct perf_event_attr backend_attrs[] =3D {
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_STALLED_CY=
CLES_BACKEND       },
> > -};
> > -     struct perf_event_attr default_attrs1[] =3D {
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_INSTRUCTIO=
NS         },
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_BRANCH_INS=
TRUCTIONS  },
> > -  { .type =3D PERF_TYPE_HARDWARE, .config =3D PERF_COUNT_HW_BRANCH_MIS=
SES                },
> > -
> > -};
> > -
> > -/*
> > - * Detailed stats (-d), covering the L1 and last level data caches:
> > - */
> > -     struct perf_event_attr detailed_attrs[] =3D {
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1D                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1D                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_LL                 <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_LL                 <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -};
> > -
> > -/*
> > - * Very detailed stats (-d -d), covering the instruction cache and the=
 TLB caches:
> > - */
> > -     struct perf_event_attr very_detailed_attrs[] =3D {
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1I                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1I                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -
> > -};
> > +     const char *pmu =3D parse_events_option_args.pmu_filter ?: "all";
> > +     struct parse_events_error err;
> > +     struct evlist *evlist =3D evlist__new();
> > +     struct evsel *evsel;
> > +     int ret =3D 0;
> >
> > -/*
> > - * Very, very detailed stats (-d -d -d), adding prefetch events:
> > - */
> > -     struct perf_event_attr very_very_detailed_attrs[] =3D {
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1D                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)                   =
       },
> > -
> > -  { .type =3D PERF_TYPE_HW_CACHE,
> > -    .config =3D
> > -      PERF_COUNT_HW_CACHE_L1D                <<  0  |
> > -     (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> > -     (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)                   =
       },
> > -};
> > +     if (!evlist)
> > +             return -ENOMEM;
> >
> > -     struct perf_event_attr default_null_attrs[] =3D {};
> > -     const char *pmu =3D parse_events_option_args.pmu_filter ?: "all";
> > +     parse_events_error__init(&err);
> >
> >       /* Set attrs if no event is selected and !null_run: */
> >       if (stat_config.null_run)
> > -             return 0;
> > +             goto out;
> >
> >       if (transaction_run) {
> >               /* Handle -T as -M transaction. Once platform specific me=
trics
> > @@ -2077,15 +1972,17 @@ static int add_default_attributes(void)
> >                */
> >               if (!metricgroup__has_metric(pmu, "transaction")) {
> >                       pr_err("Missing transaction metrics\n");
> > -                     return -1;
> > +                     ret =3D -1;
> > +                     goto out;
> >               }
> > -             return metricgroup__parse_groups(evsel_list, pmu, "transa=
ction",
> > +             ret =3D metricgroup__parse_groups(evlist, pmu, "transacti=
on",
> >                                               stat_config.metric_no_gro=
up,
> >                                               stat_config.metric_no_mer=
ge,
> >                                               stat_config.metric_no_thr=
eshold,
> >                                               stat_config.user_requeste=
d_cpu_list,
> >                                               stat_config.system_wide,
> >                                               &stat_config.metric_event=
s);
> > +             goto out;
> >       }
> >
> >       if (smi_cost) {
> > @@ -2093,32 +1990,36 @@ static int add_default_attributes(void)
> >
> >               if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
> >                       pr_err("freeze_on_smi is not supported.\n");
> > -                     return -1;
> > +                     ret =3D -1;
> > +                     goto out;
> >               }
> >
> >               if (!smi) {
> >                       if (sysfs__write_int(FREEZE_ON_SMI_PATH, 1) < 0) =
{
> > -                             fprintf(stderr, "Failed to set freeze_on_=
smi.\n");
> > -                             return -1;
> > +                             pr_err("Failed to set freeze_on_smi.\n");
> > +                             ret =3D -1;
> > +                             goto out;
> >                       }
> >                       smi_reset =3D true;
> >               }
> >
> >               if (!metricgroup__has_metric(pmu, "smi")) {
> >                       pr_err("Missing smi metrics\n");
> > -                     return -1;
> > +                     ret =3D -1;
> > +                     goto out;
> >               }
> >
> >               if (!force_metric_only)
> >                       stat_config.metric_only =3D true;
> >
> > -             return metricgroup__parse_groups(evsel_list, pmu, "smi",
> > +             ret =3D metricgroup__parse_groups(evlist, pmu, "smi",
> >                                               stat_config.metric_no_gro=
up,
> >                                               stat_config.metric_no_mer=
ge,
> >                                               stat_config.metric_no_thr=
eshold,
> >                                               stat_config.user_requeste=
d_cpu_list,
> >                                               stat_config.system_wide,
> >                                               &stat_config.metric_event=
s);
> > +             goto out;
> >       }
> >
> >       if (topdown_run) {
> > @@ -2131,105 +2032,137 @@ static int add_default_attributes(void)
> >               if (!max_level) {
> >                       pr_err("Topdown requested but the topdown metric =
groups aren't present.\n"
> >                               "(See perf list the metric groups have na=
mes like TopdownL1)\n");
> > -                     return -1;
> > +                     ret =3D -1;
> > +                     goto out;
> >               }
> >               if (stat_config.topdown_level > max_level) {
> >                       pr_err("Invalid top-down metrics level. The max l=
evel is %u.\n", max_level);
> > -                     return -1;
> > -             } else if (!stat_config.topdown_level)
> > +                     ret =3D -1;
> > +                     goto out;
> > +             } else if (!stat_config.topdown_level) {
> >                       stat_config.topdown_level =3D 1;
> > -
> > +             }
> >               if (!stat_config.interval && !stat_config.metric_only) {
> >                       fprintf(stat_config.output,
> >                               "Topdown accuracy may decrease when measu=
ring long periods.\n"
> >                               "Please print the result regularly, e.g. =
-I1000\n");
> >               }
> >               str[8] =3D stat_config.topdown_level + '0';
> > -             if (metricgroup__parse_groups(evsel_list,
> > +             if (metricgroup__parse_groups(evlist,
> >                                               pmu, str,
> >                                               /*metric_no_group=3D*/fal=
se,
> >                                               /*metric_no_merge=3D*/fal=
se,
> >                                               /*metric_no_threshold=3D*=
/true,
> >                                               stat_config.user_requeste=
d_cpu_list,
> >                                               stat_config.system_wide,
> > -                                             &stat_config.metric_event=
s) < 0)
> > -                     return -1;
> > +                                             &stat_config.metric_event=
s) < 0) {
> > +                     ret =3D -1;
> > +                     goto out;
> > +             }
> >       }
> >
> >       if (!stat_config.topdown_level)
> >               stat_config.topdown_level =3D 1;
> >
> > -     if (!evsel_list->core.nr_entries) {
> > +     if (!evlist->core.nr_entries) {
> >               /* No events so add defaults. */
> >               if (target__has_cpu(&target))
> > -                     default_attrs0[0].config =3D PERF_COUNT_SW_CPU_CL=
OCK;
> > +                     ret =3D parse_events(evlist, "cpu-clock", &err);
> > +             else
> > +                     ret =3D parse_events(evlist, "task-clock", &err);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             ret =3D parse_events(evlist,
> > +                             "context-switches,"
> > +                             "cpu-migrations,"
> > +                             "page-faults,"
> > +                             "instructions,"
> > +                             "cycles,"
>
> "cycles",
> "instructions",
>
> It's better to keep the original order.

So the original order was:
"cycles,"
"stalled-cycles-frontend,"
"stalled-cycles-backend,"
"instructions"

but many/most/all core PMUs don't provide the stalled-* events. At the
programmer level instructions is the most fundamental thing, so having
it last felt wrong hence moving it to be the first after the software
events. My thought was, if we're going to reorder things then let's
not do a half measure like:
"cycles,"
"instructions,"
"stalled-cycles-frontend,"
"stalled-cycles-backend"

let's just put things into their best order. It is obviously easy to
change but having this way wasn't an accident. There's obviously
subjectivity about whether cycles is more fundamental than
instructions, my thought is that you get taught instructions first and
that these take some number of cycles to execute, hence thinking
instructions should have some priority in the output over cycles -
some people may not even know what cycles means, it is hard enough
when you do given the variety of different clocks :-)

Thanks,
Ian

> Thanks,
> Kan
>
> > +                             "stalled-cycles-frontend,"
> > +                             "stalled-cycles-backend,"
> > +                             "branches,"
> > +                             "branch-misses",
> > +                             &err);
> > +             if (ret)
> > +                     goto out;
> >
> > -             if (evlist__add_default_attrs(evsel_list, default_attrs0)=
 < 0)
> > -                     return -1;
> > -             if (perf_pmus__have_event("cpu", "stalled-cycles-frontend=
")) {
> > -                     if (evlist__add_default_attrs(evsel_list, fronten=
d_attrs) < 0)
> > -                             return -1;
> > -             }
> > -             if (perf_pmus__have_event("cpu", "stalled-cycles-backend"=
)) {
> > -                     if (evlist__add_default_attrs(evsel_list, backend=
_attrs) < 0)
> > -                             return -1;
> > -             }
> > -             if (evlist__add_default_attrs(evsel_list, default_attrs1)=
 < 0)
> > -                     return -1;
> >               /*
> >                * Add TopdownL1 metrics if they exist. To minimize
> >                * multiplexing, don't request threshold computation.
> >                */
> >               if (metricgroup__has_metric(pmu, "Default")) {
> >                       struct evlist *metric_evlist =3D evlist__new();
> > -                     struct evsel *metric_evsel;
> > -
> > -                     if (!metric_evlist)
> > -                             return -1;
> >
> > +                     if (!metric_evlist) {
> > +                             ret =3D -ENOMEM;
> > +                             goto out;
> > +                     }
> >                       if (metricgroup__parse_groups(metric_evlist, pmu,=
 "Default",
> >                                                       /*metric_no_group=
=3D*/false,
> >                                                       /*metric_no_merge=
=3D*/false,
> >                                                       /*metric_no_thres=
hold=3D*/true,
> >                                                       stat_config.user_=
requested_cpu_list,
> >                                                       stat_config.syste=
m_wide,
> > -                                                     &stat_config.metr=
ic_events) < 0)
> > -                             return -1;
> > -
> > -                     evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> > -                             metric_evsel->skippable =3D true;
> > -                             metric_evsel->default_metricgroup =3D tru=
e;
> > +                                                     &stat_config.metr=
ic_events) < 0) {
> > +                             ret =3D -1;
> > +                             goto out;
> >                       }
> > -                     evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
> > +
> > +                     evlist__for_each_entry(metric_evlist, evsel)
> > +                             evsel->default_metricgroup =3D true;
> > +
> > +                     evlist__splice_list_tail(evlist, &metric_evlist->=
core.entries);
> >                       evlist__delete(metric_evlist);
> >               }
> > -
> > -             /* Platform specific attrs */
> > -             if (evlist__add_default_attrs(evsel_list, default_null_at=
trs) < 0)
> > -                     return -1;
> >       }
> >
> >       /* Detailed events get appended to the event list: */
> >
> > -     if (detailed_run <  1)
> > -             return 0;
> > -
> > -     /* Append detailed run extra attributes: */
> > -     if (evlist__add_default_attrs(evsel_list, detailed_attrs) < 0)
> > -             return -1;
> > -
> > -     if (detailed_run < 2)
> > -             return 0;
> > -
> > -     /* Append very detailed run extra attributes: */
> > -     if (evlist__add_default_attrs(evsel_list, very_detailed_attrs) < =
0)
> > -             return -1;
> > -
> > -     if (detailed_run < 3)
> > -             return 0;
> > -
> > -     /* Append very, very detailed run extra attributes: */
> > -     return evlist__add_default_attrs(evsel_list, very_very_detailed_a=
ttrs);
> > +     if (!ret && detailed_run >=3D  1) {
> > +             /*
> > +              * Detailed stats (-d), covering the L1 and last level da=
ta
> > +              * caches:
> > +              */
> > +             ret =3D parse_events(evlist,
> > +                             "L1-dcache-loads,"
> > +                             "L1-dcache-load-misses,"
> > +                             "LLC-loads,"
> > +                             "LLC-load-misses",
> > +                             &err);
> > +     }
> > +     if (!ret && detailed_run >=3D  2) {
> > +             /*
> > +              * Very detailed stats (-d -d), covering the instruction =
cache
> > +              * and the TLB caches:
> > +              */
> > +             ret =3D parse_events(evlist,
> > +                             "L1-icache-loads,"
> > +                             "L1-icache-load-misses,"
> > +                             "dTLB-loads,"
> > +                             "dTLB-load-misses,"
> > +                             "iTLB-loads,"
> > +                             "iTLB-load-misses",
> > +                             &err);
> > +     }
> > +     if (!ret && detailed_run >=3D  3) {
> > +             /*
> > +              * Very, very detailed stats (-d -d -d), adding prefetch =
events:
> > +              */
> > +             ret =3D parse_events(evlist,
> > +                             "L1-dcache-prefetches,"
> > +                             "L1-dcache-prefetch-misses",
> > +                             &err);
> > +     }
> > +out:
> > +     if (!ret) {
> > +             evlist__for_each_entry(evlist, evsel)
> > +                     evsel->skippable =3D true;
> > +     }
> > +     parse_events_error__exit(&err);
> > +     evlist__splice_list_tail(evsel_list, &evlist->core.entries);
> > +     evlist__delete(evlist);
> > +     return ret;
> >  }
> >
> >  static const char * const stat_record_usage[] =3D {
> > @@ -2736,7 +2669,7 @@ int cmd_stat(int argc, const char **argv)
> >               }
> >       }
> >
> > -     if (add_default_attributes())
> > +     if (add_default_events())
> >               goto out;
> >
> >       if (stat_config.cgroup_list) {
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 55a300a0977b..de498ba5ac1c 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -314,49 +314,6 @@ struct evsel *evlist__add_sched_switch(struct evli=
st *evlist, bool system_wide)
> >  }
> >  #endif
> >
> > -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *a=
ttrs, size_t nr_attrs)
> > -{
> > -     struct evsel *evsel, *n;
> > -     LIST_HEAD(head);
> > -     size_t i;
> > -
> > -     for (i =3D 0; i < nr_attrs; i++) {
> > -             evsel =3D evsel__new_idx(attrs + i, evlist->core.nr_entri=
es + i);
> > -             if (evsel =3D=3D NULL)
> > -                     goto out_delete_partial_list;
> > -             list_add_tail(&evsel->core.node, &head);
> > -     }
> > -
> > -     evlist__splice_list_tail(evlist, &head);
> > -
> > -     return 0;
> > -
> > -out_delete_partial_list:
> > -     __evlist__for_each_entry_safe(&head, n, evsel)
> > -             evsel__delete(evsel);
> > -     return -1;
> > -}
> > -
> > -int __evlist__add_default_attrs(struct evlist *evlist, struct perf_eve=
nt_attr *attrs, size_t nr_attrs)
> > -{
> > -     size_t i;
> > -
> > -     for (i =3D 0; i < nr_attrs; i++)
> > -             event_attr_init(attrs + i);
> > -
> > -     return evlist__add_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> > -__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -                                       struct perf_event_attr *attrs,
> > -                                       size_t nr_attrs)
> > -{
> > -     if (!nr_attrs)
> > -             return 0;
> > -
> > -     return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> >  struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int=
 id)
> >  {
> >       struct evsel *evsel;
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index cb91dc9117a2..947a78cbd7f0 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -100,18 +100,6 @@ void evlist__delete(struct evlist *evlist);
> >  void evlist__add(struct evlist *evlist, struct evsel *entry);
> >  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
> >
> > -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *a=
ttrs, size_t nr_attrs);
> > -
> > -int __evlist__add_default_attrs(struct evlist *evlist,
> > -                                  struct perf_event_attr *attrs, size_=
t nr_attrs);
> > -
> > -int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -                                struct perf_event_attr *attrs,
> > -                                size_t nr_attrs);
> > -
> > -#define evlist__add_default_attrs(evlist, array) \
> > -     arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
> > -
> >  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)=
;
> >
> >  int evlist__add_dummy(struct evlist *evlist);
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index bfc1d705f437..6631d03ad799 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -663,6 +663,9 @@ static void print_counter_value_std(struct perf_sta=
t_config *config,
> >       const char *fmt;
> >       const char *bad_count =3D evsel->supported ? CNTR_NOT_COUNTED : C=
NTR_NOT_SUPPORTED;
> >
> > +     if (!evsel->supported && evsel->skippable)
> > +             return;
> > +
> >       if (config->big_num)
> >               fmt =3D floor(sc) !=3D sc ? "%'*.2f " : "%'*.0f ";
> >       else

