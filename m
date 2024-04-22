Return-Path: <linux-kernel+bounces-153936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27D8AD51B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B04B21708
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57167155358;
	Mon, 22 Apr 2024 19:46:00 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB9155345;
	Mon, 22 Apr 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815159; cv=none; b=hzd8pbeWtJhitU4io/hU2MUBhnSZ8wwBXWTQCfYYU6eJS8WYBJN9qY3Wh9EXrYfnUHZGNGYWxFomd9gWLp97kWydGo998mGD8Quf1uOmE+6dhJrZES87JVF2VIv5J3nApa0kJyE/q4sTaBA2A99bcEF5kyCc84K+3MFj0sdCbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815159; c=relaxed/simple;
	bh=cPCrY/g4GE12LLjdQZepUh5jaTOD3D1o7JRSsMAHPso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUCbe+tLOz+nlN+WOlAoHO51ly+1useQOo26puqcSthglhBDLgvobEoIhyU7nLNaGgrXvf/SaZtMaT9mRgrbZJBBDajVmFDaResS1gCmfkGaF4Ooz8spgug897XdvAwmrTjQZiroYoUzqTtzOIb5aUaaT+JDy5TxLAgaLLFc/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a53b331400so3138912a91.1;
        Mon, 22 Apr 2024 12:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815157; x=1714419957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqnd2c1aRKmoN9NvvHc5OClPZ5/P3rZlA9YikS0cS+4=;
        b=Q8tojDFpRM7Um3x+FVTA+Fq1c7FuupCAhEo4LSHvkLflBWhob2a7gzl+jXvz564SgZ
         NeHrsR5WFqCHw0dt9zn7YqWt46xHGcuSYYJmVEkS5AxVEWGUuJjfDBfVytw0kQ8whlUM
         CYBzoz8KKdsY8hPpef2G1gqNtlIo0mwXx7b6mgA7qb389bkT9PkXjiF2hUankkz6UZU/
         ock3D3aCVzV7j5eLO69zUtC6I85bft23X7GS0q2oBcZa/COMzVfNhAuUKEBq3/Gw3gH6
         dF7u3q2rm/JSJ7f917Dkf41dvlMnqd3smEjeerov2Fnt025iv0WIJEoj759irJykspuJ
         MX3g==
X-Forwarded-Encrypted: i=1; AJvYcCVmWyfgCOA9U0WQnI2clxTufjAXKgQ+cCAz/1nx92amITWXJuxFKey/vJq7a35xTaqHoCIuf0I7jibAmLvLzKpA9B3LySyKDXVw4nQHxBjcOHNbUtCyo0aKyZW7N512zczH+NJnUYW4WPIZKt733A==
X-Gm-Message-State: AOJu0Yx8sYX+LBxrCYEO5vNS3jIk0rkmUMSbsBDqsdZZQTuZcOPqCXLx
	ACHPCKTzl1g88H2pSYXWjbPReesB05dGDIZlHVtUDzcmKJl6qXIdXi3uax9wSRnvJ1eTCqSa9LZ
	i3yKzG8ZCZ+RZ/zDoHn6+SIuRKBrCMeVl
X-Google-Smtp-Source: AGHT+IHTJyBGqXD1UI1mhgOg+dpXzXS0OQ6kCKzkIMSnqFponElzDWL8xBUfMtDZhJevoG5Om9u4VxGolTE+6iBL+TU=
X-Received: by 2002:a17:90a:c983:b0:2a2:f06a:4fea with SMTP id
 w3-20020a17090ac98300b002a2f06a4feamr8522263pjt.27.1713815157037; Mon, 22 Apr
 2024 12:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402214436.1409476-1-weilin.wang@intel.com> <20240402214436.1409476-4-weilin.wang@intel.com>
In-Reply-To: <20240402214436.1409476-4-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 12:45:45 -0700
Message-ID: <CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+rD06RAnu9-EQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 2:46=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, perf stat would fo=
rk a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.
>
> At the point of time that perf stat stops counting, it would send sigterm=
 signal
> to perf record process and receiving sampling data back from perf record =
from a
> pipe. Perf stat will then process the received data to get retire latency=
 data
> and calculate metric result.
>
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.

I feel like I'm repeating some of the precious review comments..

Still I think it's better to split these special case handling routines fro=
m the
normal perf stat code.

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 212 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/metricgroup.h |   8 ++
>  tools/perf/util/stat.h        |   2 +
>  3 files changed, 220 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4558b9d95441..2dcc1a12f7ef 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -94,8 +94,13 @@
>  #include <perf/evlist.h>
>  #include <internal/threadmap.h>
>
> +#include "util/sample.h"
> +#include <sys/param.h>
> +#include <subcmd/run-command.h>
> +
>  #define DEFAULT_SEPARATOR      " "
>  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
> +#define PERF_DATA              "-"
>
>  static void print_counters(struct timespec *ts, int argc, const char **a=
rgv);
>
> @@ -163,6 +168,8 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
>         .tpebs_events           =3D LIST_HEAD_INIT(stat_config.tpebs_even=
ts),
> +       .tpebs_results          =3D LIST_HEAD_INIT(stat_config.tpebs_resu=
lts),

Can we combine these two lists?  Why not move the result fields to tpebs_ev=
ents?


> +       .tpebs_pid              =3D -1,
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -684,15 +691,173 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
>
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
>         return COUNTER_FATAL;
>  }
>
> -static int __run_perf_record(void)
> +static int __run_perf_record(const char **record_argv)
>  {
> +       int i =3D 0;
> +       struct tpebs_event *e;
> +
>         pr_debug("Prepare perf record for retire_latency\n");
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +       record_argv[i++] =3D "--synth=3Dno";
> +
> +       if (stat_config.user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config.user_requested_cpu_list;
> +       }
> +
> +       if (stat_config.system_wide)
> +               record_argv[i++] =3D "-a";
> +
> +       if (!stat_config.system_wide && !stat_config.user_requested_cpu_l=
ist) {
> +               pr_err("Require -a or -C option to run sampling.\n");
> +               return -ECANCELED;
> +       }
> +
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;
> +
> +       return 0;
> +}
> +
> +static void prepare_run_command(struct child_process *cmd,
> +                              const char **argv)
> +{
> +       memset(cmd, 0, sizeof(*cmd));
> +       cmd->argv =3D argv;
> +       cmd->out =3D -1;
> +}
> +
> +static int prepare_perf_record(struct child_process *cmd)
> +{
> +       const char **record_argv;
> +       int ret;
> +
> +       record_argv =3D calloc(10 + 2 * stat_config.tpebs_event_size, siz=
eof(char *));
> +       if (!record_argv)
> +               return -1;
> +
> +       ret =3D __run_perf_record(record_argv);
> +       if (ret)
> +               return ret;

free(record_argv) before return.

> +
> +       prepare_run_command(cmd, record_argv);
> +       return start_command(cmd);
> +}
> +
> +struct perf_script {
> +       struct perf_tool        tool;
> +       struct perf_session     *session;
> +};
> +
> +static void tpebs_event_name__delete(struct tpebs_event *e)
> +{
> +       zfree(&e->name);
> +       zfree(&e->tpebs_name);
> +}
> +
> +static void tpebs_event__delete(struct tpebs_event *e)
> +{
> +       tpebs_event_name__delete(e);
> +       free(e);
> +}
> +
> +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> +{
> +       tpebs_event_name__delete(&r->event);
> +       free(r);
> +}
> +
> +static void tpebs_data__delete(void)
> +{
> +       struct tpebs_retire_lat *r, *rtmp;
> +       struct tpebs_event *e, *etmp;
> +
> +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, eve=
nt.nd) {
> +               list_del_init(&r->event.nd);
> +               tpebs_retire_lat__delete(r);
> +       }
> +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) =
{
> +               list_del_init(&e->nd);
> +               tpebs_event__delete(e);
> +       }
> +}
> +
> +static int process_sample_event(struct perf_tool *tool __maybe_unused,
> +                               union perf_event *event __maybe_unused,
> +                               struct perf_sample *sample,
> +                               struct evsel *evsel,
> +                               struct machine *machine __maybe_unused)
> +{
> +       int ret =3D 0;
> +       const char *evname;
> +       struct tpebs_retire_lat *t;
> +
> +       evname =3D evsel__name(evsel);
> +
> +       /*
> +        * Need to handle per core results? We are assuming average retir=
e
> +        * latency value will be used. Save the number of samples and the=
 sum of
> +        * retire latency value for each event.
> +        */
> +       list_for_each_entry(t, &stat_config.tpebs_results, event.nd) {
> +               if (!strcmp(evname, t->event.name)) {
> +                       t->count +=3D 1;
> +                       t->sum +=3D sample->retire_lat;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int process_feature_event(struct perf_session *session,
> +                                union perf_event *event)
> +{
> +       if (event->feat.feat_id < HEADER_LAST_FEATURE)
> +               return perf_event__process_feature(session, event);
>         return 0;
>  }
>
> +static void *__sample_reader(void *arg)
> +{
> +       struct child_process *cmd =3D arg;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .file.fd =3D cmd->out,
> +       };
> +       struct perf_script script =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .feature         =3D process_feature_event,
> +               .attr            =3D perf_event__process_attr,
> +               },
> +       };
> +
> +       session =3D perf_session__new(&data, &script.tool);
> +       if (IS_ERR(session))
> +               return NULL;
> +       script.session =3D session;
> +       perf_session__process_events(session);
> +       perf_session__delete(session);
> +
> +       return NULL;
> +}

Now we have weight[123] fields to show the average weight.
Can we simply use it like below?

  $ perf mem record -t load -o- timeout 1 perf test -w datasym | \
    perf report -i- -q -F weight1
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.614 MB - ]
      92.2             <--- this


> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -709,6 +874,8 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
>         struct affinity saved_affinity, *affinity =3D NULL;
>         int err;
>         bool second_pass =3D false;
> +       struct child_process cmd;
> +       pthread_t reader_thread;
>
>         /*
>          * Prepare perf record for sampling event retire_latency before f=
ork and
> @@ -716,10 +883,35 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>          */
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
> +               struct tpebs_event *e;
> +
> +               pr_debug("perf stat pid =3D %d\n", getpid());
> +               list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));
>
> -               ret =3D __run_perf_record();
> +                       if (!new)
> +                               return -1;
> +                       new->event.name =3D strdup(e->name);
> +                       if (!new->event.name)
> +                               return -ENOMEM;
> +                       new->event.tpebs_name =3D strdup(e->tpebs_name);
> +                       if (!new->event.tpebs_name)
> +                               return -ENOMEM;
> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->event.nd, &stat_config.tpebs_=
results);
> +               }
> +               ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
> +               if (pthread_create(&reader_thread, NULL, __sample_reader,=
 &cmd)) {
> +                       kill(cmd.pid, SIGTERM);
> +                       close(cmd.out);
> +                       pr_err("Could not create thread to process sample=
 data.\n");
> +                       return -1;
> +               }
> +               /* Wait for perf record initialization a little bit.*/
> +               sleep(2);

This won't guarantee anything and just slows down the normal case.
You'd better make the record process wait until the reader is ready.

Thanks,
Namhyung


>         }
>
>         if (forks) {
> @@ -927,6 +1119,17 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               kill(cmd.pid, SIGTERM);
> +               pthread_join(reader_thread, NULL);
> +               close(cmd.out);
> +               ret =3D finish_command(&cmd);
> +               if (ret !=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       return ret;
> +       }
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -1034,6 +1237,9 @@ static void sig_atexit(void)
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
>
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
> +
>         sigprocmask(SIG_SETMASK, &oset, NULL);
>
>         if (signr =3D=3D -1)
> @@ -2974,5 +3180,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 7c24ed768ff3..ae788edef30f 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -68,10 +68,18 @@ struct metric_expr {
>
>  struct tpebs_event {
>         struct list_head nd;
> +       /* Event name */
>         const char *name;
> +       /* Event name with the TPEBS modifier R */
>         const char *tpebs_name;
>  };
>
> +struct tpebs_retire_lat {
> +       struct tpebs_event event;
> +       size_t count;
> +       int sum;
> +};
> +
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
>                                          bool create);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b987960df3c5..0726bdc06681 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -111,6 +111,8 @@ struct perf_stat_config {
>         struct rblist            metric_events;
>         struct list_head         tpebs_events;
>         size_t                   tpebs_event_size;
> +       struct list_head         tpebs_results;
> +       pid_t                    tpebs_pid;
>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>

