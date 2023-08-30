Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C978D971
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjH3SdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbjH3NHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:07:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768C194
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:06:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so288671cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693400813; x=1694005613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om1L6Hod1xV1IReW0iDiLMl0QxXta9SCQRRwwajX4tc=;
        b=uoMOpnBmPcEM5rYGlVUuyOKCjt8tCdxBVmSFcf0AWy+eVuyiAXAM+yqrt4VTYrE+L1
         t0hIXIdfKDNPbXY2SqvDUu7mIEmhfuo68rbAbbb72ICuVYOs/ZUKY41kXpw+UW0E+cW5
         UmNyvibUtIma77DAqMUjjM06Os0fyB6uZ3to+eRCxwUnLXuPGF74x1YMxKMbeR+Bnm08
         Wa6deXkHxxsQupCNsemIAHJvXujrDpeueyJwvm81T4q7Xggeau38OzHWjFvBSHs6SZyp
         DlmoL4IBREc8kEHhnHymj0GJu9fnw1Iowwakh8+1bhmjVhhNloh3iusUonktnv2bMyCQ
         xG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400813; x=1694005613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om1L6Hod1xV1IReW0iDiLMl0QxXta9SCQRRwwajX4tc=;
        b=NkRBgGvPVHFySlX6Gf7dxZql+zff7NIHsTaHT1Y9YWk/r0V+OV5EMyRArIKsYjWqXq
         fYJUIrAoL1ZLCPRRQ1HZdkx98X4wwu5TnbSzcHpKQwgJlLA3CqUQUCvlPKoqosh9am8I
         d7LyHIjAG8L5WunyoryhvBbaYd8/y4VwKcW7L//c6CfWJtgYUCgSJ9Vt0T9tVYqFddPG
         glvkBfzllr/xUhXWr76FCXAHIvOMblxT1tO5mKXLYlcPu4B1oAreSXtqevGAuctDMMpd
         1qOqxPH9HvJlZsDssPEohsrsqTwJpGM/s2jv2UJjOAbE6ZE48BCbeF9c0oajtL/pB+jU
         UI8A==
X-Gm-Message-State: AOJu0Yyr2hS+P9H/fEseA5RLAxtNEvbB5rUmA1+kRLTadyrZPqGLMnb2
        zAp8I0CJucqIr+8h0AysF2WtRCFB8Dyii6+4V16jKA==
X-Google-Smtp-Source: AGHT+IH6wRmA9qvSqCVxonLmMGPcjz1432MWW5mXEF9DJi7xrbfbM2nhOOoyTSSJ8AHlfeRMa43JpqjQaN000irf/jE=
X-Received: by 2002:a05:622a:1004:b0:3f6:97b4:1a4d with SMTP id
 d4-20020a05622a100400b003f697b41a4dmr415707qte.23.1693400812700; Wed, 30 Aug
 2023 06:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230826062203.1058041-1-irogers@google.com> <4f493093-fe3e-0d17-1bdb-3c3545734f0c@arm.com>
In-Reply-To: <4f493093-fe3e-0d17-1bdb-3c3545734f0c@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 06:06:40 -0700
Message-ID: <CAP-5=fVcc-0xUe1SnHCBUiDEWBc1VA3O52SsOAV3LDV3nZo=jg@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Use "default_core" for events with no Unit
To:     James Clark <james.clark@arm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:00=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 26/08/2023 07:22, Ian Rogers wrote:
> > The json Unit field encodes the name of the PMU to match the events
> > to. When no name is given it has meant the "cpu" core PMU except for
> > tests. On ARM, Intel hybrid and s390 the core PMU is named differently
> > which means that using "cpu" for this case causes the events not to
> > get matched to the PMU. Introduce a new "default_core" string for this
> > case and in the pmu__name_match force all core PMUs to match this
> > name.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Fixes: 2e255b4f9f41 ("perf jevents: Group events by PMU")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Hi Ian,
>
> Running 'perf list' with this change I get "munmap_chunk(): invalid
> pointer". It's probably related to an earlier change though.
>
> Here's the stack:
>
> Program received signal SIGABRT, Aborted.
> __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
> 50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:50
> #1  0x0000fffff70adaac in __GI_abort () at abort.c:79
> #2  0x0000fffff70faf40 in __libc_message (action=3Daction@entry=3Ddo_abor=
t, fmt=3Dfmt@entry=3D0xfffff71bc518 "%s\n")
>      at ../sysdeps/posix/libc_fatal.c:155
> #3  0x0000fffff7102344 in malloc_printerr (str=3Dstr@entry=3D0xfffff71b7a=
e0 "munmap_chunk(): invalid pointer") at malloc.c:5347
> #4  0x0000fffff7102644 in munmap_chunk (p=3D<optimized out>) at malloc.c:=
2830
> #5  0x0000aaaaaadc727c in __zfree (ptr=3D0xaaaaaaf89db0) at ../../lib/zal=
loc.c:13
> #6  0x0000aaaaaacbbbcc in assign_str (name=3D0xaaaaaae878c2 "l1d_cache_re=
fill", field=3D0xaaaaaae4fb78 "value", old_str=3D0xaaaaaaf89db0,
>      new_str=3D0xaaaaaae878f7 "event=3D0x3") at util/pmu.c:454
> #7  0x0000aaaaaacbbdf4 in update_alias (pe=3D0xffffffffd450, table=3D0xaa=
aaaaf43870 <pmu_events_map+592>, vdata=3D0xffffffffd598)
>      at util/pmu.c:490
> #8  0x0000aaaaaadbc37c in pmu_events_table__find_event_pmu (table=3D0xaaa=
aaaf43870 <pmu_events_map+592>,
>      pmu=3D0xaaaaaaf43400 <pmu_events.arm_neoverse_n1>, name=3D0xaaaaaaf9=
00b3 "l1d_cache_refill", fn=3D0xaaaaaacbbcc0 <update_alias>,
>      data=3D0xffffffffd598) at pmu-events/pmu-events.c:5359
> #9  0x0000aaaaaadbc598 in pmu_events_table__find_event (table=3D0xaaaaaaf=
43870 <pmu_events_map+592>, pmu=3D0xaaaaaaf8fcd0,
>      name=3D0xaaaaaaf900b3 "l1d_cache_refill", fn=3D0xaaaaaacbbcc0 <updat=
e_alias>, data=3D0xffffffffd598)
>      at pmu-events/pmu-events.c:5398
> #10 0x0000aaaaaacbc1f0 in perf_pmu__new_alias (pmu=3D0xaaaaaaf8fcd0, name=
=3D0xaaaaaaf900b3 "l1d_cache_refill", desc=3D0x0, val=3D0x0,
>      val_fd=3D0xaaaaaaf8a2e0, pe=3D0x0) at util/pmu.c:569
> #11 0x0000aaaaaacbc710 in pmu_aliases_parse (pmu=3D0xaaaaaaf8fcd0) at uti=
l/pmu.c:673
> #12 0x0000aaaaaacbf168 in perf_pmu__num_events (pmu=3D0xaaaaaaf8fcd0) at =
util/pmu.c:1633
> #13 0x0000aaaaaacc1e00 in perf_pmus__print_pmu_events (print_cb=3D0xfffff=
fffe878, print_state=3D0xffffffffe898) at util/pmus.c:359
> #14 0x0000aaaaaac53810 in print_events (print_cb=3D0xffffffffe878, print_=
state=3D0xffffffffe898) at util/print-events.c:407
> #15 0x0000aaaaaab1cc30 in cmd_list (argc=3D0, argv=3D0xfffffffff0c0) at b=
uiltin-list.c:524
> #16 0x0000aaaaaac106f0 in run_builtin (p=3D0xaaaaaaf59580 <commands+240>,=
 argc=3D2, argv=3D0xfffffffff0c0) at perf.c:322
> #17 0x0000aaaaaac109a4 in handle_internal_command (argc=3D2, argv=3D0xfff=
ffffff0c0) at perf.c:375
> #18 0x0000aaaaaac10b5c in run_argv (argcp=3D0xffffffffeebc, argv=3D0xffff=
ffffeeb0) at perf.c:419
> #19 0x0000aaaaaac10e84 in main (argc=3D2, argv=3D0xfffffffff0c0) at perf.=
c:535

Hi James,

Could you try adding:
https://lore.kernel.org/lkml/20230830000545.1638964-1-irogers@google.com/
which I believe fixes the problem.

Thanks,
Ian

> > ---
> >  tools/perf/pmu-events/jevents.py |  2 +-
> >  tools/perf/tests/pmu-events.c    | 19 ++++++++++---------
> >  tools/perf/util/pmu.c            |  7 ++++++-
> >  3 files changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 712f80d7d071..a7e88332276d 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -266,7 +266,7 @@ class JsonEvent:
> >      def unit_to_pmu(unit: str) -> Optional[str]:
> >        """Convert a JSON Unit to Linux PMU name."""
> >        if not unit:
> > -        return 'cpu'
> > +        return 'default_core'
> >        # Comment brought over from jevents.c:
> >        # it's not realistic to keep adding these, we need something mor=
e scalable ...
> >        table =3D {
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-event=
s.c
> > index ce4da9b1d115..f5321fbdee79 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -44,7 +44,7 @@ struct perf_pmu_test_pmu {
> >
> >  static const struct perf_pmu_test_event bp_l1_btb_correct =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "bp_l1_btb_correct",
> >               .event =3D "event=3D0x8a",
> >               .desc =3D "L1 BTB Correction",
> > @@ -56,7 +56,7 @@ static const struct perf_pmu_test_event bp_l1_btb_cor=
rect =3D {
> >
> >  static const struct perf_pmu_test_event bp_l2_btb_correct =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "bp_l2_btb_correct",
> >               .event =3D "event=3D0x8b",
> >               .desc =3D "L2 BTB Correction",
> > @@ -68,7 +68,7 @@ static const struct perf_pmu_test_event bp_l2_btb_cor=
rect =3D {
> >
> >  static const struct perf_pmu_test_event segment_reg_loads_any =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "segment_reg_loads.any",
> >               .event =3D "event=3D0x6,period=3D200000,umask=3D0x80",
> >               .desc =3D "Number of segment register loads",
> > @@ -80,7 +80,7 @@ static const struct perf_pmu_test_event segment_reg_l=
oads_any =3D {
> >
> >  static const struct perf_pmu_test_event dispatch_blocked_any =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "dispatch_blocked.any",
> >               .event =3D "event=3D0x9,period=3D200000,umask=3D0x20",
> >               .desc =3D "Memory cluster signals to block micro-op dispa=
tch for any reason",
> > @@ -92,7 +92,7 @@ static const struct perf_pmu_test_event dispatch_bloc=
ked_any =3D {
> >
> >  static const struct perf_pmu_test_event eist_trans =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "eist_trans",
> >               .event =3D "event=3D0x3a,period=3D200000,umask=3D0x0",
> >               .desc =3D "Number of Enhanced Intel SpeedStep(R) Technolo=
gy (EIST) transitions",
> > @@ -104,7 +104,7 @@ static const struct perf_pmu_test_event eist_trans =
=3D {
> >
> >  static const struct perf_pmu_test_event l3_cache_rd =3D {
> >       .event =3D {
> > -             .pmu =3D "cpu",
> > +             .pmu =3D "default_core",
> >               .name =3D "l3_cache_rd",
> >               .event =3D "event=3D0x40",
> >               .desc =3D "L3 cache access, read",
> > @@ -391,8 +391,8 @@ static int compare_alias_to_test_event(struct pmu_e=
vent_info *alias,
> >               return -1;
> >       }
> >
> > -
> > -     if (!is_same(alias->pmu_name, test_event->event.pmu)) {
> > +     if (!is_same(alias->pmu_name, test_event->event.pmu) &&
> > +         !is_same(alias->pmu_name, "default_core")) {
> >               pr_debug("testing aliases PMU %s: mismatched pmu_name, %s=
 vs %s\n",
> >                         pmu_name, alias->pmu_name, test_event->event.pm=
u);
> >               return -1;
> > @@ -409,7 +409,7 @@ static int test__pmu_event_table_core_callback(cons=
t struct pmu_event *pe,
> >       struct perf_pmu_test_event const **test_event_table;
> >       bool found =3D false;
> >
> > -     if (strcmp(pe->pmu, "cpu"))
> > +     if (strcmp(pe->pmu, "default_core"))
> >               test_event_table =3D &uncore_events[0];
> >       else
> >               test_event_table =3D &core_events[0];
> > @@ -543,6 +543,7 @@ static int __test_core_pmu_event_aliases(const char=
 *pmu_name, int *count)
> >       INIT_LIST_HEAD(&pmu->caps);
> >       INIT_LIST_HEAD(&pmu->list);
> >       pmu->name =3D strdup(pmu_name);
> > +     pmu->is_core =3D true;
> >
> >       pmu->events_table =3D table;
> >       pmu_add_cpu_aliases_table(pmu, table);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 502fd58c3ea7..cde33e01959a 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1747,7 +1747,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pm=
u, bool skip_duplicate_pmus,
> >  bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
> >  {
> >       return !strcmp(pmu->name, pmu_name) ||
> > -             (pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->=
name));
> > +             (pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->=
name)) ||
> > +             /*
> > +              * jevents and tests use default_core as a marker for any=
 core
> > +              * PMU as the PMU name varies across architectures.
> > +              */
> > +             (pmu->is_core && !strcmp(pmu_name, "default_core"));
> >  }
> >
> >  bool perf_pmu__is_software(const struct perf_pmu *pmu)
