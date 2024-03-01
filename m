Return-Path: <linux-kernel+bounces-87753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C9486D886
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F38284589
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8D2B9BA;
	Fri,  1 Mar 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxA9zho0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917D17556
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255177; cv=none; b=iW2H8tMIm0MnuYo/Qf5jHrUJludSqIbX+UR3SusEAi8Tpaq+YuIgxxHsnZXdaLbMYDRSOwqaLG9B0vyTBs95iZ2Fy5Hkbov2nzOb3pyEzf5DTsQ0kvYcIqGmPHZ/nBMmk7v0NRSsXYKGmADcgHPZY4F0NIeAZW/4FrISvcVzZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255177; c=relaxed/simple;
	bh=QwEN1k/cHLzvMaWPFjpg1irL60P6i8tNmytsV7QkE1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAfsCA2i41nGIpEvBLuJN+NV7gAOAWW5L2vq0JbnwTPnF2d1SRlINmv0iObJN8gvEzvYuUgXbNWAu1l9oeXwH/je9L9xtBD9juu8eOunVaPGktmXBnUHk9NknXjBS7L3hDjsElF+t4lmaHGau/dWVP7tofFQVj/ZM+16dD6Joc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxA9zho0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc9f4d1106so78795ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709255175; x=1709859975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vChUkylk47jCtb99U8qi4uunBO8k+CjLWplXiyL0CXU=;
        b=AxA9zho0TGcy9WaPbfLWAUkOXFjnDfrUqoloMlHzSR28+Efe3mFw+11jbGZdLxWHo4
         z40s1HyT/CLqc+ttgvgqTL6kgmoYYZvmGUQMVnVQ8F8wB4iUARf0khmtSWwsnUR6XpKP
         hVSwmnNjoi9BDDVurZeFcesWa+AzSgDBF/+SJrsaeHOJDVF+SyHFr2y9EJaJhH11QJuZ
         G7O1FJFCrYRYCzrS4AHi3ZokD9BD7qIKYm7eu8cTCjHk6sAWN8CciBZBxOrjJk5bgpAO
         c+X3FOzFhKM+DaDsVyzjz70lQFj2Ody6sTzPRQwfKIfC0g8UJfdvC/KmfP8TFh2FYMfp
         eE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709255175; x=1709859975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vChUkylk47jCtb99U8qi4uunBO8k+CjLWplXiyL0CXU=;
        b=anKNZPraKRY3yXSOSsZpJMAiNYh+EkTW7Rj0Ajr5o1e14WoRP3SbSYE7CiVDZxk7aM
         mt0APHcMoC1+MIvOpGQDf46ncAXUb+RyusLul+QiMe8jXCUTUimASjpm+MRGMeG/39ui
         pxcbEHfdLMITwgyn3skkOx3xuEGmzpHultNbLeaEpNZ+RqCv6+J915kYza6ES6S+K+PY
         qFcvtG2lMkuyhOU3gnCYW7U3USNQGjwVAry/ZbXOWXUoXeVO5dy7PZLYuvkX9sGL/cUT
         Lxj4MlwJ+dXTbtL2RsgPSr1N/I7wMtW9F0hQo2z/dJnAByEuk5K5meNO7p+V2R4+HJb/
         j1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGctdt10flNfxK2dnIe9oeyXy6GScOOh76kbLAJYialu4WNCBb1d+CRgtU3hAbHhwImlwxEl9sQH/5SURASUWsaLRwjGa3qlroV3ra
X-Gm-Message-State: AOJu0Yz1nGtefbx89JDoyNTdilWsIJDkevYaPsON73k8CSsd/SjCiGHb
	XasTfqoGWu+8Z8Q0KqkZVQv0bZirk8Qyf5CynKi6mM6NqzZM3pvkJuXj2EVeVSiMhj1R9yzsNm2
	bcbmshQI/Qis7t3HsZTpvQ+qAbp+ypbaR9apx
X-Google-Smtp-Source: AGHT+IF6ZLpaSGpEgRZjTs852OfdqF7Oqx/Q69br0DHWr2ELtuG/uOgbhtiPHQK0QiwgtskzsqynH7v2AYDqcsKFhws=
X-Received: by 2002:a17:902:fb06:b0:1db:a356:b954 with SMTP id
 le6-20020a170902fb0600b001dba356b954mr88822plb.28.1709255175255; Thu, 29 Feb
 2024 17:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070757.796244-1-irogers@google.com> <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
In-Reply-To: <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 17:06:04 -0800
Message-ID: <CAP-5=fVWC+MeeUcNmofkQi766se4P0ERGz_+L+7uTFUXocwVvQ@mail.gmail.com>
Subject: Re: [PATCH v1] libperf evlist: Avoid out-of-bounds access
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 28, 2024 at 11:08=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Parallel testing appears to show a race between allocating and setting
> > evsel ids. As there is a bounds check on the xyarray it yields a segv
> > like:
> >
> > ```
> > AddressSanitizer:DEADLYSIGNAL
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > =3D=3D484408=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00=
0000000010
> >
> > =3D=3D484408=3D=3DThe signal is caused by a WRITE memory access.
> >
> > =3D=3D484408=3D=3DHint: address points to the zero page.
> >
> >     #0 0x55cef5d4eff4 in perf_evlist__id_hash tools/lib/perf/evlist.c:2=
56
> >     #1 0x55cef5d4f132 in perf_evlist__id_add tools/lib/perf/evlist.c:27=
4
> >     #2 0x55cef5d4f545 in perf_evlist__id_add_fd tools/lib/perf/evlist.c=
:315
> >     #3 0x55cef5a1923f in store_evsel_ids util/evsel.c:3130
> >     #4 0x55cef5a19400 in evsel__store_ids util/evsel.c:3147
> >     #5 0x55cef5888204 in __run_perf_stat tools/perf/builtin-stat.c:832
> >     #6 0x55cef5888c06 in run_perf_stat tools/perf/builtin-stat.c:960
> >     #7 0x55cef58932db in cmd_stat tools/perf/builtin-stat.c:2878
> > ...
> > ```
> >
> > Avoid this crash by early exiting the perf_evlist__id_add_fd and
> > perf_evlist__id_add is the access is out-of-bounds.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> While I'm ok with this change, the real fix would be changing
> evsel_store__ids() to use xyarray__max_{x,y} for fd instead
> of cpu and thread map numbers.

So I'm not sure on how to code that fix. Could you take over looking
at this? It reproduces for me with "perf test -v -p" when built with
"-fsanitize=3Daddress".

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/lib/perf/evlist.c                  | 18 ++++++++++++------
> >  tools/lib/perf/include/internal/evlist.h |  4 ++--
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 058e3ff10f9b..c6d67fc9e57e 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -248,10 +248,10 @@ u64 perf_evlist__read_format(struct perf_evlist *=
evlist)
> >
> >  static void perf_evlist__id_hash(struct perf_evlist *evlist,
> >                                  struct perf_evsel *evsel,
> > -                                int cpu, int thread, u64 id)
> > +                                int cpu_map_idx, int thread, u64 id)
> >  {
> >         int hash;
> > -       struct perf_sample_id *sid =3D SID(evsel, cpu, thread);
> > +       struct perf_sample_id *sid =3D SID(evsel, cpu_map_idx, thread);
> >
> >         sid->id =3D id;
> >         sid->evsel =3D evsel;
> > @@ -269,21 +269,27 @@ void perf_evlist__reset_id_hash(struct perf_evlis=
t *evlist)
> >
> >  void perf_evlist__id_add(struct perf_evlist *evlist,
> >                          struct perf_evsel *evsel,
> > -                        int cpu, int thread, u64 id)
> > +                        int cpu_map_idx, int thread, u64 id)
> >  {
> > -       perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
> > +       if (!SID(evsel, cpu_map_idx, thread))
> > +               return;
> > +
> > +       perf_evlist__id_hash(evlist, evsel, cpu_map_idx, thread, id);
> >         evsel->id[evsel->ids++] =3D id;
> >  }
> >
> >  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
> >                            struct perf_evsel *evsel,
> > -                          int cpu, int thread, int fd)
> > +                          int cpu_map_idx, int thread, int fd)
> >  {
> >         u64 read_data[4] =3D { 0, };
> >         int id_idx =3D 1; /* The first entry is the counter value */
> >         u64 id;
> >         int ret;
> >
> > +       if (!SID(evsel, cpu_map_idx, thread))
> > +               return -1;
> > +
> >         ret =3D ioctl(fd, PERF_EVENT_IOC_ID, &id);
> >         if (!ret)
> >                 goto add;
> > @@ -312,7 +318,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evli=
st,
> >         id =3D read_data[id_idx];
> >
> >  add:
> > -       perf_evlist__id_add(evlist, evsel, cpu, thread, id);
> > +       perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
> >         return 0;
> >  }
> >
> > diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/=
include/internal/evlist.h
> > index d86ffe8ed483..f43bdb9b6227 100644
> > --- a/tools/lib/perf/include/internal/evlist.h
> > +++ b/tools/lib/perf/include/internal/evlist.h
> > @@ -126,11 +126,11 @@ u64 perf_evlist__read_format(struct perf_evlist *=
evlist);
> >
> >  void perf_evlist__id_add(struct perf_evlist *evlist,
> >                          struct perf_evsel *evsel,
> > -                        int cpu, int thread, u64 id);
> > +                        int cpu_map_idx, int thread, u64 id);
> >
> >  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
> >                            struct perf_evsel *evsel,
> > -                          int cpu, int thread, int fd);
> > +                          int cpu_map_idx, int thread, int fd);
> >
> >  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
> >
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >
>

