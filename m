Return-Path: <linux-kernel+bounces-163273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CC8B680E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D184E283033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D999DDA1;
	Tue, 30 Apr 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4Rd5tHu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5ED2E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445274; cv=none; b=aQFemb9iJMi61SnVGA0E2lu0ulttT5h5a12uAiUsAGCtzkbMOu/cXbWCoiiClzTHVTVdZ39xlLrJjQrOLMwc4MW+eumRNqQEJrzWu+qXGZGpAr3flYIzKQwhkEBuPKijniTf8W6tk3b00Of0LpNp1Eo+PFfK0BgjxM2dcTV5OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445274; c=relaxed/simple;
	bh=mnwGR/XMSdieOzHwjCgXJ+kk8Hps3bPaz7btK/Gfn+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWO8miwiNRBtXvli7my8lnE8f2xkj6rfGrfAAom+VA/Xkc+fJ/Xv49Rq5Mu5XeflzrAyvw2Bb3K3cMBeRvQxE74BbNYicA5iomMiHOUtdS81m9X5uld4ezzdOqO30INhsVwajz72AJ4wwfrZmcFQyss/S8+Te/0ORsHxzxh+AFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4Rd5tHu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e8fcb0b860so56035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714445271; x=1715050071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPE3Zb3sYpHNA5hs7ka8O8nb8miX8n3dnWZ8KfjyXB0=;
        b=i4Rd5tHuy/7FKyWnv2K/tM/Wb24nI0QnWWKk5G3LZKKAmdVADpHWisC+TU/ZHfFSx0
         V/kvR8VTtfZu031XDyc+hneWwFiHyD+Jd5vEomPT3WhM+YySZVvB66g6dZcU1KsRPzLw
         twXkyf0YRGCAn0yCVWbKJPRdPsQnDpAKUgeprJXA1qOcDcOCpHCg3JOiu52q6eJ6qNxf
         A460Q3x+TlMVOYmRKaSr+aMBpHdumlZTsYeYYUbV2l/z2FudfZaNFg/4/PgHyQ2yL4qq
         9X2XZo95mgEzmImPdZCYOfQ/krPw5ovHa7vAgrVGVMwJbMuikMb8onNiDJJduR2bqh/y
         a/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714445271; x=1715050071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPE3Zb3sYpHNA5hs7ka8O8nb8miX8n3dnWZ8KfjyXB0=;
        b=cIKRIjC/x0/Iw4PYYvP5r6SDmVkg4SsPdOybWY8nM+R2PYiYMj+zvtVIZl3Q1Ir0sC
         8ZPVzQEOHME+EuD9pafl/Mi2HywfZhP6mR5ai8qOlFbqb7Au5bd962VysqZOMZjBfRxb
         BZGwKC4rxNh6LrzP5aUY/CyM2BB8jnXgpPRjMsHr3E8tUw0gcrCH20Ac3AS7sNyDe1Cc
         mczwr1Y46pTmSdfxav5aF8FyA/XGYdO4c2Y9rTk1lQmxxNj3MZsXR49yNYZ1XzYJ8kXG
         eX0Wo8upkgWRrTd2uoRZit9FybnRzX+B+NWCQEF2GYr1FodGilva/uDuRN9+wJq3iCb8
         dlOg==
X-Forwarded-Encrypted: i=1; AJvYcCUh2vtbURk1GKrm2K6RrskIFRNfcE9NiwPu6LAcRYHdZYQcRqzWNMnQGzCq3RG2VZchtY5r+Vp7kmggEgyrz7Ws8TAejHO1UUn6EKyZ
X-Gm-Message-State: AOJu0Yxt+h95BBN8NPijYEtQJlIro4eQ5kHhPWYfWLfEH4F/r3HZCL9S
	4FDKHJu/Lc/8kuRWoffyucg/XQYGt9itdvw2O4VBAmQjHYGoehzbbb7CR9vf2BiJuFklH5f1shw
	qzwmCpY29HaA1tg3jJM5RhMiRWkWmzkCqj/GM
X-Google-Smtp-Source: AGHT+IEfn5msKxh32sb27vL4wrGjkyt5wB/CLibK0NNNzAPQWh80Add4gyihYhSzbx/YAeL9aitHOrN794vba90dvXQ=
X-Received: by 2002:a17:902:c942:b0:1e3:d0f0:4623 with SMTP id
 i2-20020a170902c94200b001e3d0f04623mr84276pla.17.1714445270345; Mon, 29 Apr
 2024 19:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-2-irogers@google.com>
 <CAM9d7cjX_5SS=JGnjMLxG3fcReyuhUoJQacKVsBtcW2ngD06sw@mail.gmail.com>
In-Reply-To: <CAM9d7cjX_5SS=JGnjMLxG3fcReyuhUoJQacKVsBtcW2ngD06sw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 19:47:38 -0700
Message-ID: <CAP-5=fVE5kOip29qx=phZPfRHj+hE=gqTpMhKWmdb6T5=ipzag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] perf evsel: Refactor tool events
To: Namhyung Kim <namhyung@kernel.org>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Song Liu <song@kernel.org>, James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Tool events unnecessarily open a dummy perf event which is useless
> > even with `perf record` which will still open a dummy event. Change
> > the behavior of tool events so:
>
> Right, I was surprised that we need a dummy event for that.
>
> >
> >  - duration_time - call `rdclock` on open and then report the count as
> >    a delta since the start in evsel__read_counter. This moves code out
> >    of builtin-stat making it more general purpose.
> >
> >  - user_time/system_time - open the fd as either `/proc/pid/stat` or
> >    `/proc/stat` for cases like system wide. evsel__read_counter will
> >    read the appropriate field out of the procfs file. These values
> >    were previously supplied by wait4, if the procfs read fails then
> >    the wait4 values are used, assuming the process/thread terminated.
> >    By reading user_time and system_time this way, interval mode can be
> >    supported.
>
> Good improvement!
>
> >
> > Opening any of the tool events for `perf record` returns invalid.
>
> Ok, I think those tool events are for `perf stat` only.
>
> But I feel like this change is a separate optimization and can be
> independently submitted (from the retire-latency or tPEBS change).

You're right, but as both pieces of code are changing the
evsel__read_counter implementation I'd kept them together.

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c |  74 ++++++-------
> >  tools/perf/util/evsel.c   | 223 +++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/evsel.h   |   6 +
> >  3 files changed, 259 insertions(+), 44 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 65a3dd7ffac3..428e9721b908 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -255,45 +255,37 @@ static int evsel__write_stat_event(struct evsel *=
counter, int cpu_map_idx, u32 t
> >                                            process_synthesized_event, N=
ULL);
> >  }
> >
> > -static int read_single_counter(struct evsel *counter, int cpu_map_idx,
> > -                              int thread, struct timespec *rs)
> > -{
> > -       switch(counter->tool_event) {
> > -               case PERF_TOOL_DURATION_TIME: {
> > -                       u64 val =3D rs->tv_nsec + rs->tv_sec*1000000000=
ULL;
> > -                       struct perf_counts_values *count =3D
> > -                               perf_counts(counter->counts, cpu_map_id=
x, thread);
> > -                       count->ena =3D count->run =3D val;
> > -                       count->val =3D val;
> > -                       return 0;
> > -               }
> > -               case PERF_TOOL_USER_TIME:
> > -               case PERF_TOOL_SYSTEM_TIME: {
> > -                       u64 val;
> > -                       struct perf_counts_values *count =3D
> > -                               perf_counts(counter->counts, cpu_map_id=
x, thread);
> > -                       if (counter->tool_event =3D=3D PERF_TOOL_USER_T=
IME)
> > -                               val =3D ru_stats.ru_utime_usec_stat.mea=
n;
> > -                       else
> > -                               val =3D ru_stats.ru_stime_usec_stat.mea=
n;
> > -                       count->ena =3D count->run =3D val;
> > -                       count->val =3D val;
> > -                       return 0;
> > -               }
> > -               default:
> > -               case PERF_TOOL_NONE:
> > -                       return evsel__read_counter(counter, cpu_map_idx=
, thread);
> > -               case PERF_TOOL_MAX:
> > -                       /* This should never be reached */
> > -                       return 0;
> > +static int read_single_counter(struct evsel *counter, int cpu_map_idx,=
 int thread)
> > +{
> > +       int err =3D evsel__read_counter(counter, cpu_map_idx, thread);
> > +
> > +       /*
> > +        * Reading user and system time will fail when the process
> > +        * terminates. Use the wait4 values in that case.
> > +        */
> > +       if (err &&
> > +           (counter->tool_event =3D=3D PERF_TOOL_USER_TIME ||
> > +            counter->tool_event =3D=3D PERF_TOOL_SYSTEM_TIME)) {
>
> Off-topic.  I feel like we should have a (fake) pmu for the tool events
> rather than the evsel->tool_event enum.

Sounds good to me. The refactoring in this (unmerged) test change:
https://lore.kernel.org/lkml/20240429200225.1271876-4-irogers@google.com/
makes it so we can load a PMU from something like a temporary
directory. It would be nice to get rid of the fake_pmu special case in
parse-events and similarly the tool event special case. A problem is
that libperf lacks knowledge of fake_pmus and tool events in the
evlist and evsel code. libperf can try to apply operations to these
events even though the only knowledge of them is in the perf tool.


>
> > +               u64 val;
> > +               struct perf_counts_values *count =3D
> > +                       perf_counts(counter->counts, cpu_map_idx, threa=
d);
> > +
> > +               if (counter->tool_event =3D=3D PERF_TOOL_USER_TIME)
> > +                       val =3D ru_stats.ru_utime_usec_stat.mean;
> > +               else
> > +                       val =3D ru_stats.ru_stime_usec_stat.mean;
> > +               count->ena =3D count->run =3D val;
> > +               count->val =3D val;
> > +               return 0;
> >         }
> > +       return err;
> >  }
> >
> >  /*
> >   * Read out the results of a single counter:
> >   * do not aggregate counts across CPUs in system-wide mode
> >   */
> > -static int read_counter_cpu(struct evsel *counter, struct timespec *rs=
, int cpu_map_idx)
> > +static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
> >  {
> >         int nthreads =3D perf_thread_map__nr(evsel_list->core.threads);
> >         int thread;
> > @@ -311,7 +303,7 @@ static int read_counter_cpu(struct evsel *counter, =
struct timespec *rs, int cpu_
> >                  * (via evsel__read_counter()) and sets their count->lo=
aded.
> >                  */
> >                 if (!perf_counts__is_loaded(counter->counts, cpu_map_id=
x, thread) &&
> > -                   read_single_counter(counter, cpu_map_idx, thread, r=
s)) {
> > +                   read_single_counter(counter, cpu_map_idx, thread)) =
{
> >                         counter->counts->scaled =3D -1;
> >                         perf_counts(counter->counts, cpu_map_idx, threa=
d)->ena =3D 0;
> >                         perf_counts(counter->counts, cpu_map_idx, threa=
d)->run =3D 0;
> > @@ -340,7 +332,7 @@ static int read_counter_cpu(struct evsel *counter, =
struct timespec *rs, int cpu_
> >         return 0;
> >  }
> >
> > -static int read_affinity_counters(struct timespec *rs)
> > +static int read_affinity_counters(void)
> >  {
> >         struct evlist_cpu_iterator evlist_cpu_itr;
> >         struct affinity saved_affinity, *affinity;
> > @@ -361,10 +353,8 @@ static int read_affinity_counters(struct timespec =
*rs)
> >                 if (evsel__is_bpf(counter))
> >                         continue;
> >
> > -               if (!counter->err) {
> > -                       counter->err =3D read_counter_cpu(counter, rs,
> > -                                                       evlist_cpu_itr.=
cpu_map_idx);
> > -               }
> > +               if (!counter->err)
> > +                       counter->err =3D read_counter_cpu(counter, evli=
st_cpu_itr.cpu_map_idx);
> >         }
> >         if (affinity)
> >                 affinity__cleanup(&saved_affinity);
> > @@ -388,11 +378,11 @@ static int read_bpf_map_counters(void)
> >         return 0;
> >  }
> >
> > -static int read_counters(struct timespec *rs)
> > +static int read_counters(void)
> >  {
> >         if (!stat_config.stop_read_counter) {
> >                 if (read_bpf_map_counters() ||
> > -                   read_affinity_counters(rs))
> > +                   read_affinity_counters())
> >                         return -1;
> >         }
> >         return 0;
> > @@ -423,7 +413,7 @@ static void process_interval(void)
> >
> >         evlist__reset_aggr_stats(evsel_list);
> >
> > -       if (read_counters(&rs) =3D=3D 0)
> > +       if (read_counters() =3D=3D 0)
> >                 process_counters();
> >
> >         if (STAT_RECORD) {
> > @@ -911,7 +901,7 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
> >          * avoid arbitrary skew, we must read all counters before closi=
ng any
> >          * group leaders.
> >          */
> > -       if (read_counters(&(struct timespec) { .tv_nsec =3D t1-t0 }) =
=3D=3D 0)
> > +       if (read_counters() =3D=3D 0)
> >                 process_counters();
> >
> >         /*
>
> I think this part can be a separate commit.  You can implement the
> tool event handling before actually using it. :)

It's possible but it opens a 3rd world where tool code is implemented
both in evsel and also in builtin-stat. The builtin-stat code uses
wait4 and the evsel code is using file descriptors. If tests fail
should the 3rd world be fixed? The intent here is that we're deleting
all the builtin-stat evsel tool code, a consequence of that is
deleting unused function arguments. As the changes are purely deleting
I'd prefer not to have a combined world to temporarily maintain.

>
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 3536404e9447..a0a8aee7d6b9 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -10,6 +10,7 @@
> >  #include <errno.h>
> >  #include <inttypes.h>
> >  #include <linux/bitops.h>
> > +#include <api/io.h>
> >  #include <api/fs/fs.h>
> >  #include <api/fs/tracing_path.h>
> >  #include <linux/hw_breakpoint.h>
> > @@ -30,6 +31,7 @@
> >  #include "counts.h"
> >  #include "event.h"
> >  #include "evsel.h"
> > +#include "time-utils.h"
> >  #include "util/env.h"
> >  #include "util/evsel_config.h"
> >  #include "util/evsel_fprintf.h"
> > @@ -1600,11 +1602,183 @@ static int evsel__read_group(struct evsel *lea=
der, int cpu_map_idx, int thread)
> >         return evsel__process_group_data(leader, cpu_map_idx, thread, d=
ata);
> >  }
> >
> > +static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u=
64 *val)
> > +{
> > +       char buf[256];
> > +       struct io io;
> > +       int c, i;
> > +
> > +       io__init(&io, fd, buf, sizeof(buf));
> > +
> > +       /* Skip lines to relevant CPU. */
> > +       for (i =3D -1; i < cpu.cpu; i++) {
> > +               do {
> > +                       c =3D io__get_char(&io);
> > +                       if (c =3D=3D -1)
> > +                               return -EINVAL;
> > +               } while (c !=3D '\n');
> > +       }
> > +       /* Skip to "cpu". */
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D 'c')
> > +               return -EINVAL;
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D 'p')
> > +               return -EINVAL;
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D 'u')
> > +               return -EINVAL;
> > +       /* Skip N of cpuN. */
> > +       do {
> > +               c =3D io__get_char(&io);
> > +               if (c =3D=3D -1)
> > +                       return -EINVAL;
> > +       } while (c !=3D ' ');
> > +
> > +       i =3D 1;
> > +       while (true) {
> > +               c =3D io__get_dec(&io, val);
> > +               if (c !=3D ' ')
> > +                       break;
> > +               if (field =3D=3D i)
> > +                       return 0;
> > +               i++;
> > +       }
> > +       return -EINVAL;
> > +}
>
> Looks somewhat verbose, can we have something like
> io__get_str_field() or io__get_num_filed()?

I think macro magic would probably be the best way to cut down on
verbosity, I'm not sure its a big deal given the majority of the field
handling happens in the while loops. I'd like to skip this for now.

>
> > +
> > +static int read_pid_stat_field(int fd, int field, __u64 *val)
> > +{
> > +       char buf[256];
> > +       struct io io;
> > +       int c, i;
> > +
> > +       io__init(&io, fd, buf, sizeof(buf));
> > +       c =3D io__get_dec(&io, val);
> > +       if (c !=3D ' ')
> > +               return -EINVAL;
> > +       if (field =3D=3D 1)
> > +               return 0;
> > +
> > +       /* Skip comm. */
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D '(')
> > +               return -EINVAL;
> > +       do {
> > +               c =3D io__get_char(&io);
> > +               if (c =3D=3D -1)
> > +                       return -EINVAL;
> > +       } while (c !=3D ')');
> > +       if (field =3D=3D 2)
> > +               return -EINVAL;
> > +
> > +       /* Skip state */
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D ' ')
> > +               return -EINVAL;
> > +       c =3D io__get_char(&io);
> > +       if (c =3D=3D -1)
> > +               return -EINVAL;
> > +       if (field =3D=3D 3)
> > +               return -EINVAL;
> > +
> > +       /* Loop over numeric fields*/
> > +       c =3D io__get_char(&io);
> > +       if (c !=3D ' ')
> > +               return -EINVAL;
> > +
> > +       i =3D 4;
> > +       while (true) {
> > +               c =3D io__get_dec(&io, val);
> > +               if (c =3D=3D -1)
> > +                       return -EINVAL;
> > +               if (c =3D=3D -2) {
> > +                       /* Assume a -ve was read */
> > +                       c =3D io__get_dec(&io, val);
> > +                       *val *=3D -1;
> > +               }
> > +               if (c !=3D ' ')
> > +                       return -EINVAL;
> > +               if (field =3D=3D i)
> > +                       return 0;
> > +               i++;
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> > +static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int =
thread)
> > +{
> > +       __u64 cur_time, delta_start;
> > +       int fd, err =3D 0;
> > +       struct perf_counts_values *count;
> > +       bool adjust =3D false;
> > +
> > +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > +
> > +       switch (evsel->tool_event) {
> > +       case PERF_TOOL_DURATION_TIME:
> > +               /*
> > +                * Pretend duration_time is only on the first CPU and t=
hread, or
> > +                * else aggregation will scale duration_time by the num=
ber of
> > +                * CPUs/threads.
> > +                */
>
> We could set evsel->pmu->cpus to 0, if there's a tool pmu.

For the CPU it already is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/parse-events.c#n314
There isn't an equivalent for the thread. I was tempted to add an
assert that cpu_map_idx =3D=3D 0, but it seemed more forgiving to treat it
how threads are handled - I'm always concerned about breaking existing
code given how often I'm successful at doing it :-) . We could also
try to divide the delta across all CPUs/threads, but that seemed
weird.

>
> > +               if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > +                       cur_time =3D rdclock();
> > +               else
> > +                       cur_time =3D evsel->start_time;
> > +               break;
> > +       case PERF_TOOL_USER_TIME:
> > +       case PERF_TOOL_SYSTEM_TIME: {
> > +               bool system =3D evsel->tool_event =3D=3D PERF_TOOL_SYST=
EM_TIME;
> > +
> > +               fd =3D FD(evsel, cpu_map_idx, thread);
> > +               lseek(fd, SEEK_SET, 0);
> > +               if (evsel->pid_stat) {
> > +                       /* The event exists solely on 1 CPU. */
>
> Probably the same.

Similar to above. In system wide we can give per-CPU user and system
time breakdowns, whereas the /prod/pid/stat version doesn't support
that. The code is trying to make the most out of the information /proc
will give it. Thinking about it, we shouldn't be pinning the user and
system time to CPU0 in that case, so add_event_tool:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/parse-events.c#n302
should pass "0" in the duration_time case and NULL for the others.
This should allow say "perf stat -A -I 1000 -e user_time,system_time"
to give a per second per CPU user and system time value. This reminds
me that it'd be nice to do similar for hwmon values, another fake PMU
case.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                       if (cpu_map_idx =3D=3D 0)
> > +                               err =3D read_pid_stat_field(fd, system =
? 15 : 14, &cur_time);
> > +                       else
> > +                               cur_time =3D 0;
> > +               } else {
> > +                       /* The event is for all threads. */
> > +                       if (thread =3D=3D 0) {
> > +                               struct perf_cpu cpu =3D perf_cpu_map__c=
pu(evsel->core.cpus,
> > +                                                                      =
 cpu_map_idx);
> > +
> > +                               err =3D read_stat_field(fd, cpu, system=
 ? 3 : 1, &cur_time);
> > +                       } else {
> > +                               cur_time =3D 0;
> > +                       }
> > +               }
> > +               adjust =3D true;
> > +               break;
> > +       }
> > +       case PERF_TOOL_NONE:
> > +       case PERF_TOOL_MAX:
> > +       default:
> > +               err =3D -EINVAL;
> > +       }
> > +       if (err)
> > +               return err;
> > +
> > +       delta_start =3D cur_time - evsel->start_time;
> > +       if (adjust) {
> > +               __u64 ticks_per_sec =3D sysconf(_SC_CLK_TCK);
> > +
> > +               delta_start *=3D 1000000000 / ticks_per_sec;
> > +       }
> > +       count->val    =3D delta_start;
> > +       count->ena    =3D count->run =3D delta_start;
> > +       count->lost   =3D 0;
> > +       return 0;
> > +}
> > +
> >  int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thre=
ad)
> >  {
> > -       u64 read_format =3D evsel->core.attr.read_format;
> > +       if (evsel__is_tool(evsel))
> > +               return evsel__read_tool(evsel, cpu_map_idx, thread);
> >
> > -       if (read_format & PERF_FORMAT_GROUP)
> > +       if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> >                 return evsel__read_group(evsel, cpu_map_idx, thread);
> >
> >         return evsel__read_one(evsel, cpu_map_idx, thread);
> > @@ -2005,6 +2179,13 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >         int pid =3D -1, err, old_errno;
> >         enum rlimit_action set_rlimit =3D NO_CHANGE;
> >
> > +       if (evsel->tool_event =3D=3D PERF_TOOL_DURATION_TIME) {
> > +               if (evsel->core.attr.sample_period) /* no sampling */
> > +                       return -EINVAL;
> > +               evsel->start_time =3D rdclock();
> > +               return 0;
> > +       }
> > +
> >         err =3D __evsel__prepare_open(evsel, cpus, threads);
> >         if (err)
> >                 return err;
> > @@ -2037,6 +2218,44 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >                         if (!evsel->cgrp && !evsel->core.system_wide)
> >                                 pid =3D perf_thread_map__pid(threads, t=
hread);
> >
> > +                       if (evsel->tool_event =3D=3D PERF_TOOL_USER_TIM=
E ||
> > +                           evsel->tool_event =3D=3D PERF_TOOL_SYSTEM_T=
IME) {
> > +                               bool system =3D evsel->tool_event =3D=
=3D PERF_TOOL_SYSTEM_TIME;
> > +
> > +                               if (evsel->core.attr.sample_period) {
> > +                                       /* no sampling */
> > +                                       err =3D -EINVAL;
> > +                                       goto out_close;
> > +                               }
> > +                               if (pid > -1) {
> > +                                       char buf[64];
> > +
> > +                                       snprintf(buf, sizeof(buf), "/pr=
oc/%d/stat", pid);
> > +                                       fd =3D open(buf, O_RDONLY);
> > +                                       evsel->pid_stat =3D true;
> > +                               } else {
> > +                                       fd =3D open("/proc/stat", O_RDO=
NLY);
> > +                               }
> > +                               FD(evsel, idx, thread) =3D fd;
> > +                               if (fd < 0) {
> > +                                       err =3D -errno;
> > +                                       goto out_close;
> > +                               }
> > +                               if (pid > -1) {
> > +                                       err =3D read_pid_stat_field(fd,=
 system ? 15 : 14,
> > +                                                                 &evse=
l->start_time);
> > +                               } else {
> > +                                       struct perf_cpu cpu;
> > +
> > +                                       cpu =3D perf_cpu_map__cpu(evsel=
->core.cpus, idx);
> > +                                       err =3D read_stat_field(fd, cpu=
, system ? 3 : 1,
> > +                                                             &evsel->s=
tart_time);
> > +                               }
> > +                               if (err)
> > +                                       goto out_close;
> > +                               continue;
> > +                       }
> > +
> >                         group_fd =3D get_group_fd(evsel, idx, thread);
> >
> >                         if (group_fd =3D=3D -2) {
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 517cff431de2..43f6fd1dcb4d 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -170,6 +170,12 @@ struct evsel {
> >
> >         /* for missing_features */
> >         struct perf_pmu         *pmu;
> > +
> > +       /* For tool events */
> > +       /* Beginning time subtracted when the counter is read. */
> > +       __u64 start_time;
> > +       /* Is the tool's fd for /proc/pid/stat or /proc/stat. */
> > +       bool pid_stat;
> >  };
> >
> >  struct perf_missing_features {
> > --
> > 2.44.0.769.g3c40516874-goog
> >

