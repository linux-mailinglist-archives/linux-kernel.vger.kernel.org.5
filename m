Return-Path: <linux-kernel+bounces-163073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A88B6499
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000FF289545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CBD184102;
	Mon, 29 Apr 2024 21:31:32 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA412B73;
	Mon, 29 Apr 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426291; cv=none; b=ZyqLDPjR6ZOLFvUYkj+nrsNC//P8lEXfnc1rfthjMP28F3IUh9Jfy24wf6qzvzEwEoppJQyJqr3B5LokEgVOMltJyNujhiplVRwv+IEcC7XA2sICsNjh5Kvxyr3cQg8UT0jmQD300m9SHG/AfNd4wBVu25x7ZOURa+DTY40YpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426291; c=relaxed/simple;
	bh=Fl6XvrvFJSIhSxQ9pd+w6AqpPODhrCf8tYIKRsbcwxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X49l9h2y9mhMhDP3war44/+CJkQyNYLoLwRgBk4hrLmL7j+rdj22Z54l6qYRD504SOD5ZjANVvPWWQhrcCCclfYnFiidWwmsdDJc5GvdxzQq+zSDm1jSXi3WAW6GF/N3HFflxPJjrzaB4dUbvBf7n7HmcJxbf7rqWa+I0psvifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4081574d6so1196415b3a.2;
        Mon, 29 Apr 2024 14:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426289; x=1715031089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP6HbfwNK5+qUJ1h02ve6Ie9128x30bxsUrDg6c503g=;
        b=NmUIs+0DEK8Pbt0QtGi22Wmq7wFc0vqRXJmZXXZ7jdG6yVJqLyyleiXJhH+6OAz/JY
         g//rGlCbQzEnsLIy4dmjKA/1EgsXCOpTGtRMDR/zVEJSItVC3FrJhKh+iS1dDhkAyduA
         e4XN5JFhf43vs0hxJaagLZSrynfRLJ0sCbyfljwPyMNBroHkUyCA2MKX282noTEHKKNg
         nokBY3X6PMNXCiulLNiE0pvCAqVLpphnuyE5QPr0aIXJ05BiX0J0HccVvICckDWsLeA+
         rZyBvKmIvfa7D6PIwR+mECKy/C7zh6F33IqrTybI/iNEfz7fghqCdOcW78lDVur791BJ
         7C0g==
X-Forwarded-Encrypted: i=1; AJvYcCXHtBpyUUtIBgyv7It1MKWbRiE+7ZZD97rWvTMvUEW6KxufXtS3yBHldgI6jxGZLs6AB5q7+d/Bc6Z0oBeYKsaObAIQocAQ3mM+ZX9h453FJwz7TbUcf4QbR0Z1nXFUPqE6yFJUy9t3n5iwr5k8pA==
X-Gm-Message-State: AOJu0YzJWSTf0TlEj9eZYO6nDLWgfrWGJH9Y+t+kykrqPua9iDFBZmSF
	hMYZLBd0FA9OHiItM0Ps/yd83GM3TAUFZiQep0m9vugmbXWmKzg/ekb7ttAKqxHi991FcjYySt6
	/i7rZksSPl1TYZuSFAgsZuPU3o+0=
X-Google-Smtp-Source: AGHT+IEkQVGODG0vLZ5nh2x4VH7GgclljQgpgUvb1KQvkLAu9EfAwM0M/qMKOlS2/veJX8x6dwgcSEA49gLOjunnVY0=
X-Received: by 2002:a05:6a20:d48f:b0:1ae:426d:abc5 with SMTP id
 im15-20020a056a20d48f00b001ae426dabc5mr11894101pzb.28.1714426289526; Mon, 29
 Apr 2024 14:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-4-irogers@google.com>
In-Reply-To: <20240428053616.1125891-4-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 29 Apr 2024 14:31:17 -0700
Message-ID: <CAM9d7cgzTsfk3C+dTN80f5FhB1rmfturjuUUwvSTeUvny5eWKw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] perf evsel: Add retirement latency event support
To: Ian Rogers <irogers@google.com>
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

On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> When a retirement latency event is processed it sets a flag on the
> evsel. This change makes it so that when the flag is set evsel
> opening, reading and exiting report values from child perf record and
> perf report processes.
>
> Something similar was suggested by Namhyung Kim in:
> https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+rD06R=
Anu9-EQ@mail.gmail.com/
>
> This is trying to add support for retirement latency directly in
> events rather than through metric changes, as suggested by Weilin Wang in=
:
> https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.c=
om/

This seems to create perf record + report pair for each R event
while Weilin's patch handled multiple events at once.

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 186 +++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h |   3 +
>  2 files changed, 188 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a0a8aee7d6b9..17c123cddde3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -22,6 +22,7 @@
>  #include <sys/resource.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <signal.h>
>  #include <stdlib.h>
>  #include <perf/evsel.h>
>  #include "asm/bug.h"
> @@ -58,6 +59,7 @@
>  #include <internal/xyarray.h>
>  #include <internal/lib.h>
>  #include <internal/threadmap.h>
> +#include <subcmd/run-command.h>
>
>  #include <linux/ctype.h>
>
> @@ -493,6 +495,162 @@ struct evsel *evsel__newtp_idx(const char *sys, con=
st char *name, int idx)
>  }
>  #endif
>
> +static int evsel__start_retire_latency_cpu(struct evsel *evsel, struct p=
erf_cpu_map *cpus,
> +                                         int cpu_map_idx)
> +{
> +       char buf[16];
> +       int pipefd[2];
> +       int err, i;
> +       struct perf_cpu cpu =3D perf_cpu_map__cpu(cpus, cpu_map_idx);
> +       struct child_process *child_record =3D
> +               xyarray__entry(evsel->children, cpu_map_idx, 0);
> +       struct child_process *child_report =3D
> +               xyarray__entry(evsel->children, cpu_map_idx, 1);
> +       char *event =3D strdup(evsel__name(evsel));
> +       /* TODO: the dummy event also won't be used, but there's no optio=
n to disable. */
> +       const char *record_argv[15] =3D {
> +               [0] =3D "perf",
> +               [1] =3D "record",
> +               [2] =3D "--synth=3Dno",
> +               [3] =3D "--no-bpf-event",
> +               [4] =3D "-W",
> +               [5] =3D "-o",
> +               [6] =3D "-",
> +               [7] =3D "-e",
> +       };
> +       const char *report_argv[] =3D {
> +               [0] =3D "perf",
> +               [1] =3D "report",
> +               [2] =3D "-i",
> +               [3] =3D "-",
> +               [4] =3D "-q",
> +               [5] =3D "-F",
> +               [6] =3D "retire_lat",
> +               NULL,
> +       };
> +
> +       if (evsel->core.attr.sample_period) /* no sampling */
> +               return -EINVAL;
> +
> +       if (!event)
> +               return -ENOMEM;
> +
> +       /* Change the R modifier to the maximum precision one. */
> +       for (i =3D strlen(event) - 1; i > 0; i--) {
> +               if (event[i] =3D=3D 'R')
> +                       break;
> +               if (event[i] =3D=3D ':' || event[i] =3D=3D '/')
> +                       i =3D 0;
> +       }
> +       if (i <=3D 0) {
> +               pr_err("Expected retired latency 'R'\n");
> +               return -EINVAL;
> +       }
> +       event[i] =3D 'P';
> +
> +       i =3D 8;
> +       record_argv[i++] =3D event;
> +       if (verbose) {
> +               record_argv[i++] =3D verbose > 1 ? "-vv" : "-v";
> +       }
> +       if (cpu.cpu >=3D 0) {
> +               record_argv[i++] =3D "-C";
> +               snprintf(buf, sizeof(buf), "%d", cpu.cpu);
> +               record_argv[i++] =3D buf;
> +       } else {
> +               record_argv[i++] =3D "-a";
> +       }
> +       /* TODO: use something like the control fds to control perf recor=
d behavior. */
> +       record_argv[i++] =3D "sleep";
> +       record_argv[i++] =3D "0.1";

This might be too short and the record process can exit
before perf report (but I guess it's fine when using a pipe).
Also I'm not sure if it's ok to get the retire latency of 100 ms
regardless of the execution of the given workload.

> +
> +       if (pipe(pipefd) < 0) {
> +               free(event);
> +               return -errno;
> +       }
> +
> +       child_record->argv =3D record_argv;
> +       child_record->pid =3D -1;
> +       child_record->no_stdin =3D 1;
> +       if (verbose)
> +               child_record->err =3D fileno(stderr);
> +       else
> +               child_record->no_stderr =3D 1;
> +       child_record->out =3D pipefd[1];
> +       err =3D start_command(child_record);
> +       free(event);
> +       if (err)
> +               return err;
> +
> +       child_report->argv =3D report_argv;
> +       child_report->pid =3D -1;
> +       if (verbose)
> +               child_report->err =3D fileno(stderr);
> +       else
> +               child_report->no_stderr =3D 1;
> +       child_report->in =3D pipefd[0];
> +       child_report->out =3D -1;
> +       return start_command(child_report);
> +}
> +
> +static int evsel__finish_retire_latency_cpu(struct evsel *evsel, int cpu=
_map_idx)
> +{
> +       struct child_process *child_record =3D
> +               xyarray__entry(evsel->children, cpu_map_idx, 0);
> +       struct child_process *child_report =3D
> +               xyarray__entry(evsel->children, cpu_map_idx, 1);
> +
> +       if (child_record->pid > 0)
> +               finish_command(child_record);
> +       if (child_report->pid > 0)
> +               finish_command(child_report);
> +       return 0;
> +}
> +
> +static int evsel__read_retire_latency(struct evsel *evsel, int cpu_map_i=
dx, int thread)
> +{
> +       struct child_process *child_record =3D xyarray__entry(evsel->chil=
dren, cpu_map_idx, 0);
> +       struct child_process *child_report =3D xyarray__entry(evsel->chil=
dren, cpu_map_idx, 1);
> +       struct perf_counts_values *count =3D perf_counts(evsel->counts, c=
pu_map_idx, thread);
> +       char buf[256];
> +       int err;
> +
> +       kill(child_record->pid, SIGTERM);
> +       err =3D read(child_report->out, buf, sizeof(buf));
> +       if (err < 0 || strlen(buf) =3D=3D 0)
> +               return -1;
> +
> +       count->val =3D atoll(buf);
> +       count->ena =3D 1;
> +       count->run =3D 1;
> +       count->id =3D 0;
> +       count->lost =3D 0;
> +
> +       /*
> +        * TODO: The SIGCHLD from the children exiting will cause interva=
l mode
> +        *       to stop, use the control fd to avoid this.
> +        */
> +       err =3D evsel__finish_retire_latency_cpu(evsel, cpu_map_idx);
> +       if (err)
> +               return err;
> +
> +       /* Restart the counter. */
> +       return evsel__start_retire_latency_cpu(evsel, evsel->core.cpus, c=
pu_map_idx);

Is this for the interval mode?  Then I think it's better to move the
logic there and let this code just do the 'read'.


> +}
> +
> +static int evsel__finish_retire_latency(struct evsel *evsel)
> +{
> +       int idx;
> +
> +       perf_cpu_map__for_each_idx(idx, evsel->core.cpus) {
> +               int err =3D evsel__finish_retire_latency_cpu(evsel, idx);
> +
> +               if (err)
> +                       return err;
> +       }
> +       return 0;
> +}
> +
>  const char *const evsel__hw_names[PERF_COUNT_HW_MAX] =3D {
>         "cycles",
>         "instructions",
> @@ -1465,6 +1623,10 @@ static void evsel__free_config_terms(struct evsel =
*evsel)
>
>  void evsel__exit(struct evsel *evsel)
>  {
> +       if (evsel->children) {
> +               evsel__finish_retire_latency(evsel);
> +               zfree(&evsel->children);

You'd better call xyarray__delete() and set it to NULL.

Thanks,
Namhyung

> +       }
>         assert(list_empty(&evsel->core.node));
>         assert(evsel->evlist =3D=3D NULL);
>         bpf_counter__destroy(evsel);
> @@ -1778,6 +1940,9 @@ int evsel__read_counter(struct evsel *evsel, int cp=
u_map_idx, int thread)
>         if (evsel__is_tool(evsel))
>                 return evsel__read_tool(evsel, cpu_map_idx, thread);
>
> +       if (evsel->retire_lat)
> +               return evsel__read_retire_latency(evsel, cpu_map_idx, thr=
ead);
> +
>         if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
>                 return evsel__read_group(evsel, cpu_map_idx, thread);
>
> @@ -1993,10 +2158,22 @@ static int __evsel__prepare_open(struct evsel *ev=
sel, struct perf_cpu_map *cpus,
>                 threads =3D empty_thread_map;
>         }
>
> -       if (evsel->core.fd =3D=3D NULL &&
> +       if (!evsel->retire_lat && evsel->core.fd =3D=3D NULL &&
>             perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nt=
hreads) < 0)
>                 return -ENOMEM;
>
> +       if (evsel->retire_lat && evsel->children =3D=3D NULL) {
> +               /*
> +                * Use ylen of 2, [0] is the record and [1] is the report
> +                * command. Currently retirement latency doesn't support
> +                * per-thread mode.
> +                */
> +               evsel->children =3D xyarray__new(perf_cpu_map__nr(cpus), =
/*ylen=3D*/2,
> +                                       sizeof(struct child_process));
> +               if (!evsel->children)
> +                       return -ENOMEM;
> +       }
> +
>         evsel->open_flags =3D PERF_FLAG_FD_CLOEXEC;
>         if (evsel->cgrp)
>                 evsel->open_flags |=3D PERF_FLAG_PID_CGROUP;
> @@ -2209,6 +2386,13 @@ static int evsel__open_cpu(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>
>         for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
>
> +               if (evsel->retire_lat) {
> +                       err =3D evsel__start_retire_latency_cpu(evsel, cp=
us, idx);
> +                       if (err)
> +                               goto out_close;
> +                       continue;
> +               }
> +
>                 for (thread =3D 0; thread < nthreads; thread++) {
>                         int fd, group_fd;
>  retry_open:
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index bd8e84954e34..3c0806436e64 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -177,6 +177,9 @@ struct evsel {
>         __u64 start_time;
>         /* Is the tool's fd for /proc/pid/stat or /proc/stat. */
>         bool pid_stat;
> +
> +       /* Used for retire_lat child process. */
> +       struct xyarray *children;
>  };
>
>  struct perf_missing_features {
> --
> 2.44.0.769.g3c40516874-goog
>

