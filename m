Return-Path: <linux-kernel+bounces-34441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D048379DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FCFB25BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E91272DB;
	Tue, 23 Jan 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="zebvpRoC"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA321272D1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968566; cv=none; b=Z7498iAFdMMcJp7Vstkzcl7NoUpCpikpT2A3S3G8TnDjflM3xbKSiGvNntz3Kvc1rjwwfVTjuSaHxngvOXiFESYWe0QU6+vTKsJP/qjs+6lQSkfVwMrNlX+s2G2gtVeI1dkgYgQFLQKXQjHlmqtwtzE9qolHRDIUJFUM3NQbd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968566; c=relaxed/simple;
	bh=Jdg61seavXE1xpT5pY2hLDNUXhU6byHp1r4GrlR7kMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNkb3uin7BK2aqeBiXLmRfmfv+PGPYq8X95rzbfsukdiWmlqhaGQdD4BQkFy4Ju3bve73rL+056O97RUzfg92RVhPf2O1iNx5BQkP8mRaZ/1ih//Vq8arR9iXd3isnao2Ar5kBuHB3LjiHRuICK6m75z6sh4Gkmn+G/vB6f0JQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zebvpRoC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so63565ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968563; x=1706573363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6iTX3Dff/qf4GiTmslr7evJO0INpDmUd3EHXqqq3wQ=;
        b=zebvpRoCn1NRTtisZrPZACcUsPbib5xrU3m4YcucMgNqDNIg10bVUdeHKfrDNjFYir
         pzy79S+5xw7m71QwSdlGmO1XIv5IWNTRnIP6rMcwT3hiE0u00zZdQjI5Q5nX6LY3UP95
         N4MbJiyVqnJMmLYFLW8Njw4gGh19RAR8BgmKWbPpV7M4+NRwlcL+TmV6BO3Y/H3LM5nE
         Cl77C1S4uXnznWeLq8dE3fQYvanGaUGLec5zaa68gVs/GA60n3uQlMZkPiB4C/Rswexv
         882d/EDdk05K+2yYvvh1CWckX+2BZ1Z86e3DCA6r9s/VjpdGsD/dwyRzbQUgyGM9dN1a
         e9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968563; x=1706573363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6iTX3Dff/qf4GiTmslr7evJO0INpDmUd3EHXqqq3wQ=;
        b=vtIFQp54q15iOwrp2Zp0ihq3tJJJd++446+A/Rqqf1oNgn1Fkc2zm/LOTT2SCOinOr
         oI+guQO2nKPFUmMWm/TbppYo6e2eXOls/LsFd4aKAk0KAGmGKo5jDcnuFEVnOpePz2OS
         hy5CcQWz0JaEjxsULTyajX/EcVtN7AI9VsaC4nQaLODGkrvi3ASlV1SP7tcHy6iiCx9r
         cjRPqjbHa5QkIQ5/XoOVAoUCkwq0SYWOBGqF5zTfRKKE1Cf1yuWfnpyNhLTolXl7wgt3
         rXOWlHibfuXm+PYStIJH8Y+V5bCehv3ImAnQt1zZz47uz91K0bIhXMG+iuU2oC0eFXT9
         LZVQ==
X-Gm-Message-State: AOJu0Yy9S2Vl/ghecSY92JbMM0QO1cxNGVxbLUTnKrmfr1t8RcrDe+16
	zJuq9H1jxvJy6ueyqVZCb1x/j7drFXTmWoG1JprpNMwm8/7gw72hLSN0K1mfN6eYO92R8i4o8JG
	s5178p+UJcyT6YP8LC9P9ITyWObdmRRFf/Fi4
X-Google-Smtp-Source: AGHT+IGqNTx22hwyx7T0tN42zdxmyKTBbyuTaqbWxwjPCDxtKJTpB4ygzpyrf+5qPDdG35azdOsTjzkSR/SOtDR0Sbo=
X-Received: by 2002:a92:d0ce:0:b0:361:932f:f078 with SMTP id
 y14-20020a92d0ce000000b00361932ff078mr105294ila.22.1705968563081; Mon, 22 Jan
 2024 16:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122155436.185089-1-james.clark@arm.com> <CAP-5=fX=GDGoZaACtPagB23k-1JGN6yaNgEdCS2QMnpz1htiyg@mail.gmail.com>
In-Reply-To: <CAP-5=fX=GDGoZaACtPagB23k-1JGN6yaNgEdCS2QMnpz1htiyg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 16:09:11 -0800
Message-ID: <CAP-5=fWvjjEtGdZ7-B9nJ2jFEu1zQD0=eg8Np4S+f6DaKVTQpQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix session topology test on heterogeneous systems
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, mark.rutland@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Changbin Du <changbin.du@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:09=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi James, I think the subject should be something like "perf evlist:
> Fix new_default for >1 core PMU" as the change will apply more widely
> than just the test. The test failure fix can be in the subject. You
> could add a:
>
> Closes: https://lore.kernel.org/lkml/CAP-5=3DfWVQ-7ijjK3-w1q+k2WYVNHbAcej=
b-xY0ptbjRw476VKA@mail.gmail.com/
>
> On Mon, Jan 22, 2024 at 7:55=E2=80=AFAM James Clark <james.clark@arm.com>=
 wrote:
> >
> > The test currently fails with this message when evlist__new_default()
> > opens more than one event:
> >
> >   32: Session topology                                                :
> >   --- start ---
> >   templ file: /tmp/perf-test-vv5YzZ
> >   Using CPUID 0x00000000410fd070
> >   Opening: unknown-hardware:HG
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             0 (PERF_TYPE_HARDWARE)
> >     config                           0xb00000000
> >     disabled                         1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 4
> >   Opening: unknown-hardware:HG
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             0 (PERF_TYPE_HARDWARE)
> >     config                           0xa00000000
> >     disabled                         1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 5
> >   non matching sample_type
> >   FAILED tests/topology.c:73 can't get session
> >   ---- end ----
> >   Session topology: FAILED!
> >
> > This is because when re-opening the file and parsing the header, Perf
> > expects that any file that has more than one event has the session ID
> > flag set. Perf record already sets the flag in a similar way when there
> > is more than one event, so add the same logic to evlist__new_default().
> >
> > evlist__new_default() is only currently used in tests, so I don't
> > expect this change to have any other side effects.
> >
> > The session topology test has been failing on Arm big.LITTLE platforms
> > since commit 251aa040244a ("perf parse-events: Wildcard most
> > "numeric" events") when evlist__new_default() started opening multiple
> > events for 'cycles'.
> >
> > Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events=
")
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/evlist.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 95f25e9fb994..56db37fac6f6 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -95,6 +95,7 @@ struct evlist *evlist__new_default(void)
> >         struct evlist *evlist =3D evlist__new();
> >         bool can_profile_kernel;
> >         int err;
> > +       struct evsel *evsel;
> >
> >         if (!evlist)
> >                 return NULL;
> > @@ -106,6 +107,10 @@ struct evlist *evlist__new_default(void)
> >                 evlist =3D NULL;
> >         }
> >
> > +       if (evlist->core.nr_entries > 1)
> > +               evlist__for_each_entry(evlist, evsel)
> > +                       evsel__set_sample_id(evsel, false);
> > +
>
> nit: the if should have curlies, with them we can reduce the scope of
> evsel like below. It is also nice for constants to name the arguments
> [1].
>
> if (evlist->core.nr_entries > 1) {
>     struct evsel *evsel;
>
>     evlist__for_each_entry(evlist, evsel)
>         evsel__set_sample_id(evsel, /*can_sample_identifier=3D*/false);
> }
>
> Tested-by: Ian Rogers <irogers@google.com>
> (also Reviewed-by)
>
> When testing with this with Mark's change [2] I see on alderlake two fail=
ures:
> ```
> irogers@alderlake:~$ perf test 74 -vv
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> BPF maps, etc
> 74: daemon operations                                               :
> --- start ---
> test child forked, pid 553821
> test daemon list
> test daemon reconfig
> test daemon stop
> test daemon signal
> signal 12 sent to session 'test [554082]'
> signal 12 sent to session 'test [554082]'
> FAILED: perf data no generated
> test daemon ping
> test daemon lock
> test child finished with -1
> ---- end ----
> daemon operations: FAILED!
> irogers@alderlake:~$ perf test 76 -vv
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> BPF maps, etc
> 76: perf list tests                                                 :
> --- start ---
> test child forked, pid 554167
> Json output test
> Expecting ',' delimiter: line 4971 column 2 (char 243497)
> test child finished with -1
> ---- end ----
> perf list tests: FAILED!
> ```
> So I think this patch may be exposing other latent issues. I'll try to
> take a look.

Unrelated issues to this patch, fixes in:
https://lore.kernel.org/lkml/20240123000604.1211486-1-irogers@google.com/

Thanks,
Ian

> Another thought, rather than having an evlist validate we should just
> assert the evlist is always in a good shape whenever it is mutated.
> That would have avoided this bug as the code would have blown up
> early.
>
> Thanks,
> Ian
>
> [1] https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-comm=
ent.html
> [2] https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@arm=
com/
>
> >         return evlist;
> >  }
>
>
> >
> > --
> > 2.34.1
> >

