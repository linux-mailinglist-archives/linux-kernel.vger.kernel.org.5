Return-Path: <linux-kernel+bounces-112566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB1887B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A152825F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA433EC;
	Sun, 24 Mar 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYm/Vl6U"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0D1A38DE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711251612; cv=none; b=nHB+rVvepHt7Oz6ySFlZNf9KrETYZVAcfLmXw6KZtbU0xkWZQu9fTm0DbAOBh5mkHZErFgzwW1Q7KvghAvXqY67R5498y/5mfMmIsxVwYu5NzB1IubZWxfl/hbGK2giGnkNdLO9/zN2/qU5e8cRleOOpzATO2euJ1sdcoOK7L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711251612; c=relaxed/simple;
	bh=S7b5ZbpXRqKI5JmrrK1NgiQdzQmNlR0MslST3M8ZaCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVzLhv+GRy3hcsdtzyAweXDQVX8BWOvg1zZbEKMlsKSKHXeKAFEYiZRsKDxpvgYo33ZGCe9McW7VcIt5J3IBcSKcaLsdJWeIR7Evew5xqjHlBbxAxh79Cy2gOCZLyZoaI9uB2Cjb1i3yD/EHzAT5gjtD2STZZKCwnXwPYPIEft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYm/Vl6U; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430d3fcc511so169691cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711251610; x=1711856410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pALwttyO0Y8JdCBeWVNm2d5E3U5T3uBmPmjj6rFt50=;
        b=aYm/Vl6UVrkx21t/yBGqoabvskRAVHUfhIjRGs8QfE0uUhEOCFyzs7AGt+HgXjIXXx
         rf4rfCB70NFEU66DkVd3S8ZcNselzGUSx+OSc79RrWKWONqGHs2zgVLnJI81gTSA1sbt
         UHc7BD592aBlbHYgjJWJdUxDnIawkO4BdiBOsAsCPVwaTFyvYN94AteJZPRJJLLpT9Ez
         1g6/dN/fO9qlKayzdS+D5ZQkko6MTNjBWprZ2lxIRyNqXxgi9n5ozx+prKHCZ1LkZaBW
         h2Fp3d/ZCjnjvOznUyIAs4CoHNWt6g9N7Pd38x1X+fXc5eWWw5T3IcojJV392twwoC2p
         qscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711251610; x=1711856410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pALwttyO0Y8JdCBeWVNm2d5E3U5T3uBmPmjj6rFt50=;
        b=T9OQwktBkJCIM13gRvnLtW9wDt+1osrdFAZLcdOLE7N0nTRDkV51385iJ6xtr3ImWi
         Z1vBiQugb1zrU40iQb589Yg9fV3PXs5iwpHdvrutMkL6h8X9IbzZXf+yxI+JZy2YONzT
         qgKmS2yXMTVbVEO5xbnGT3nMQTB3s3LD4ZVevm/dpVrAccBMalWnwcmAGV8JKyLj14Tw
         oFBUfwLNQzVd7LyltEI0ajd6Ze6xiNpOmshhx8fXEViRODYzD7ipqsRFKj1v7fo3Ygu+
         3LQomah7QlvHq2rKukWyS7HIInywd52sfkXiCp7fVwR62a1WPlDReqX1QFOpdEEMPe3s
         pREA==
X-Forwarded-Encrypted: i=1; AJvYcCU5/KiG4e4BdWRkYkxOtdIKvyQop87yXHQBPlLKBc+jAL4BGXUSCKUrcsa7yuEUUkda891KGLc6a8PCgbLdty8lWFileRcQil1rrW7k
X-Gm-Message-State: AOJu0YwZwW4Yyd2jnu14HIUlHbbvxVFjuzIncRWektT+FV6n7mjfGO5y
	zPrvz0Aqiq0qVm0FscHi+GYEz8nW0hJfHLh/wsfFC5BdYHvspEPWMXyQT3JyBGFLwedumSkO1ab
	p+RBSqYBD+EpqL3qOqDHYjEhdRkGlSH6SD93Z
X-Google-Smtp-Source: AGHT+IG2kxiNHOFasiTIlhQOEd8tSgkv5C9tLigyDB9Oz8sxtO8ssFARZQmlkfE5tkcstjcglPvv8IKkKw6R/yCO0+I=
X-Received: by 2002:ac8:5754:0:b0:431:15b3:cc33 with SMTP id
 20-20020ac85754000000b0043115b3cc33mr887392qtx.20.1711251609607; Sat, 23 Mar
 2024 20:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312234921.812685-1-weilin.wang@intel.com> <20240312234921.812685-3-weilin.wang@intel.com>
In-Reply-To: <20240312234921.812685-3-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 20:39:55 -0700
Message-ID: <CAP-5=fVXmR70eUMco+B5TVmzTRjSfrk4tk3pw2o0epYiqQ=tTw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:49=E2=80=AFPM <weilin.wang@intel.com> wrote:
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
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 165 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c        |   4 +
>  tools/perf/util/data.h        |   1 +
>  tools/perf/util/metricgroup.h |  12 +++
>  tools/perf/util/stat.h        |   2 +
>  5 files changed, 182 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6291e1e24535..4e92e73cbeaf 100644
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
> +       .tpebs_pid              =3D -1,
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -687,12 +694,155 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
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
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;
> +
>         return 0;
>  }
>
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
> +
> +       record_argv =3D calloc(10 + 2 * stat_config.tpebs_event_size, siz=
eof(char *));
> +       if (!record_argv)
> +               return -1;
> +       __run_perf_record(record_argv);
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
> +static void tpebs_data__delete(void)
> +{
> +       struct tpebs_retire_lat *r, *rtmp;
> +       struct tpebs_event *e, *etmp;
> +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, nd)=
 {
> +               list_del_init(&r->nd);
> +               free(r);
> +       }
> +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) =
{
> +               list_del_init(&e->nd);
> +               free(e);
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
> +       list_for_each_entry(t, &stat_config.tpebs_results, nd) {
> +               if (!strcmp(evname, t->name)) {
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
> +       return 0;
> +}
> +
> +static int __cmd_script(struct child_process *cmd __maybe_unused)
> +{
> +       int err =3D 0;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .fd   =3D cmd->out,
> +       };
> +       struct perf_script script =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .ordering_requires_timestamps =3D true,
> +               .feature         =3D process_feature_event,
> +               .attr            =3D perf_event__process_attr,
> +               },
> +       };
> +       struct tpebs_event *e;
> +
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               struct tpebs_retire_lat *new =3D malloc(sizeof(struct tpe=
bs_retire_lat));
> +
> +               if (!new)
> +                       return -1;
> +               new->name =3D strdup(e->name);
> +               new->tpebs_name =3D strdup(e->tpebs_name);
> +               new->count =3D 0;
> +               new->sum =3D 0;
> +               list_add_tail(&new->nd, &stat_config.tpebs_results);
> +       }
> +
> +       kill(cmd->pid, SIGTERM);
> +       session =3D perf_session__new(&data, &script.tool);
> +       if (IS_ERR(session))
> +               return PTR_ERR(session);
> +       script.session =3D session;
> +       err =3D perf_session__process_events(session);
> +       perf_session__delete(session);
> +
> +       return err;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -709,13 +859,15 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         struct affinity saved_affinity, *affinity =3D NULL;
>         int err;
>         bool second_pass =3D false;
> +       struct child_process cmd;
>
>         /* Prepare perf record for sampling event retire_latency before f=
ork and
>          * prepare workload */
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> -               ret =3D __run_perf_record();
> +               pr_debug("perf stat pid =3D %d\n", getpid());
> +               ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
>         }
> @@ -925,6 +1077,13 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               ret =3D __cmd_script(&cmd);
> +               close(cmd.out);
> +       }
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -2972,5 +3131,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..2e2a20fc5c30 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -185,6 +185,10 @@ static bool check_pipe(struct perf_data *data)
>         int fd =3D perf_data__is_read(data) ?
>                  STDIN_FILENO : STDOUT_FILENO;
>
> +       if (data->fd > 0) {
> +               fd =3D data->fd;
> +       }

nit: no curlies needed here

> +
>         if (!data->path) {
>                 if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
>                         is_pipe =3D true;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 110f3ebde30f..720638116ca0 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -28,6 +28,7 @@ struct perf_data_file {
>
>  struct perf_data {
>         const char              *path;
> +       int                      fd;
>         struct perf_data_file    file;

Could fd and file be a union, so that its clear they are mutually
exclusive? Perhaps just comment.

>         bool                     is_pipe;
>         bool                     is_dir;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 7c24ed768ff3..3c37d80c4d34 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -68,10 +68,22 @@ struct metric_expr {
>
>  struct tpebs_event {
>         struct list_head nd;
> +       /* Event name */
>         const char *name;
> +       /* Event name with TPEBS modifier */
>         const char *tpebs_name;
>  };
>
> +struct tpebs_retire_lat {
> +       struct list_head nd;
> +       /* Event name */
> +       const char *name;
> +       /* Event name with TPEBS modifier */
> +       const char *tpebs_name;
> +       size_t count;
> +       int sum;
> +};

nit: Would it make sense to make this:

struct tpebs_retire_lat {
  struct tpebs_event event;
  size_t count;
  int sum;
}

Thanks,
Ian

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

