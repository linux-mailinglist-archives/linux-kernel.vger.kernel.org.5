Return-Path: <linux-kernel+bounces-155898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59208AF8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B791DB2A427
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B60142E9A;
	Tue, 23 Apr 2024 20:59:36 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBB20B3E;
	Tue, 23 Apr 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905975; cv=none; b=HGWzVpGboWJuEjHjYhWk61rztEcoMJkmsvEWSu/YZ6JYMTkV+FovxH1imfL/GaCS4yEfXdMMB1OEsBHcdwSw8g2iYyEsrpITRYBhnOdsUGZvW/emxYMd43MBA6FK1HCe5/Q0JU3WMSHa0vMEuKBVAVxRI0pACmUnouiD2LpfaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905975; c=relaxed/simple;
	bh=5SDGe5/Rg8HjRQsFbXk1Ma6s9Wbj77wGZSMRb4Bczw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnua7pFYFtmQtSpMe85vohuinLLQcqUTHSQsrEQ+el+dHA+eASmk1mQAGg1V0f8xx/1I1FV/86FEfmphdrMFrcwoXa8ss1JxvigqsWcW6hHz7/qhgJA2L2Dfj5znsxInIPM4Q+BcSQD8Wk0BprW7Oy2pAPjxILAt3/zUk3I9oxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so4034977a91.3;
        Tue, 23 Apr 2024 13:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905973; x=1714510773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBeqSI3IIX47FE0ri+7aH+nM7AjGrtFetouTL+Dn5NQ=;
        b=HD2BbNa6Wvokr2kYACzKBM4XgCbFtuu9Hgz40oNkMjuAZn1oAfJZw1EXtJQ00KYX1g
         fGFjcOO9gQKIHzBqfCubta4BHOilCpXEm8fzks2Ny3MD+22hBEsaoMgHd7WZh6pue3/o
         loxF0gMt10s5mtWJI74aKRomI0XnCGwx8Z4OnhBBMHiagQaltyfpUwMY5O8WEwMS94KW
         USP3eEQIeaAhxsMjkIcEeZcX1y/Gnz+LEvPoIcn4cYUo3aQLIcBV787B4525/6D317z4
         tPewzLyvsXy8H4ni2W+H87/VcnHQ5fF4bATnlZSyvld06glwxPhwM3s5Z+uPT+tjLa/d
         ynZg==
X-Forwarded-Encrypted: i=1; AJvYcCUirtxQ3wHrVIXZ4n+rq0n72t9S+y/M4hfR3U2eWwZslvVDjHE1Zzce1RjiEGXIBRF+7Rgase/57ZtNlLm/Fy1zY/n+1bNHk1bT11Wr1KGhxgcW10QGxfi2HeIE0decItFRuqyk0d8QpuLYLeVlsA==
X-Gm-Message-State: AOJu0Yz5HKLbo68SvkZ6FwQWXuAXtMhEZlyQFBnjTudMueW+FuUDWHUW
	+/6aViQtfO9CszcbJ5t3VGARdW4VqfivfXfpBKprQiT44g0HYIDim/huwqIQxLDiQ6Mom3VH96A
	LkU86NS+EIAIxy0k79KvvwhMM9Vs=
X-Google-Smtp-Source: AGHT+IFck9sXtMzijlpgD6MXxkJKTHVFrdVFokxoLXjQ108dxQyPRgepSDK+AuAqtViojRxTdPbTnPWIeZdsYIBJsgg=
X-Received: by 2002:a17:90a:f018:b0:2a2:5860:dea8 with SMTP id
 bt24-20020a17090af01800b002a25860dea8mr526778pjb.7.1713905972821; Tue, 23 Apr
 2024 13:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com> <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Apr 2024 13:59:21 -0700
Message-ID: <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:23=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Monday, April 1, 2024 1:58 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Fri, Mar 29, 2024 at 12:12=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > When retire_latency value is used in a metric formula, perf stat woul=
d fork a
> > > perf record process with "-e" and "-W" options. Perf record will coll=
ect
> > > required retire_latency values in parallel while perf stat is collect=
ing
> > > counting values.
> > >
> > > At the point of time that perf stat stops counting, it would send sig=
term
> > signal
> > > to perf record process and receiving sampling data back from perf rec=
ord
> > from a
> > > pipe. Perf stat will then process the received data to get retire lat=
ency data
> > > and calculate metric result.
> > >
> > > Another thread is required to synchronize between perf stat and perf =
record
> > > when we pass data through pipe.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c     | 190
> > +++++++++++++++++++++++++++++++++-
> > >  tools/perf/util/data.c        |   6 +-
> > >  tools/perf/util/metricgroup.h |   8 ++
> > >  tools/perf/util/stat.h        |   2 +
> > >  4 files changed, 203 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 6291e1e24535..7fbe47b0c44c 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -94,8 +94,13 @@
> > >  #include <perf/evlist.h>
> > >  #include <internal/threadmap.h>
> > >
> > > +#include "util/sample.h"
> > > +#include <sys/param.h>
> > > +#include <subcmd/run-command.h>
> > > +
> > >  #define DEFAULT_SEPARATOR      " "
> > >  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
> > > +#define PERF_DATA              "-"
> > >
> > >  static void print_counters(struct timespec *ts, int argc, const char=
 **argv);
> > >
> > > @@ -163,6 +168,8 @@ static struct perf_stat_config stat_config =3D {
> > >         .ctl_fd_ack             =3D -1,
> > >         .iostat_run             =3D false,
> > >         .tpebs_events           =3D LIST_HEAD_INIT(stat_config.tpebs_=
events),
> > > +       .tpebs_results          =3D LIST_HEAD_INIT(stat_config.tpebs_=
results),
> > > +       .tpebs_pid              =3D -1,
> > >  };
> > >
> > >  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> > > @@ -684,15 +691,155 @@ static enum counter_recovery
> > stat_handle_error(struct evsel *counter)
> > >
> > >         if (child_pid !=3D -1)
> > >                 kill(child_pid, SIGTERM);
> > > +       if (stat_config.tpebs_pid !=3D -1)
> > > +               kill(stat_config.tpebs_pid, SIGTERM);
> > >         return COUNTER_FATAL;
> > >  }
> > >
> > > -static int __run_perf_record(void)
> > > +static int __run_perf_record(const char **record_argv)
> > >  {
> > > +       int i =3D 0;
> > > +       struct tpebs_event *e;
> > > +
> > >         pr_debug("Prepare perf record for retire_latency\n");
> > > +
> > > +       record_argv[i++] =3D "perf";
> > > +       record_argv[i++] =3D "record";
> > > +       record_argv[i++] =3D "-W";
> > > +       record_argv[i++] =3D "--synth=3Dno";
> > > +
> > > +       if (stat_config.user_requested_cpu_list) {
> > > +               record_argv[i++] =3D "-C";
> > > +               record_argv[i++] =3D stat_config.user_requested_cpu_l=
ist;
> > > +       }
> > > +
> > > +       if (stat_config.system_wide)
> > > +               record_argv[i++] =3D "-a";
> > > +
> > > +       if (!stat_config.system_wide && !stat_config.user_requested_c=
pu_list)
> > {
> > > +               pr_err("Require -a or -C option to run sampling.\n");
> > > +               return -ECANCELED;
> > > +       }
> > > +
> > > +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> > > +               record_argv[i++] =3D "-e";
> > > +               record_argv[i++] =3D e->name;
> > > +       }
> > > +
> > > +       record_argv[i++] =3D "-o";
> > > +       record_argv[i++] =3D PERF_DATA;
> > > +
> > >         return 0;
> > >  }
> >
> > Still I think it's weird it has 'perf record' in perf stat (despite the
> > 'perf stat record').  If it's only Intel thing and we don't have a plan
> > to do the same on other arches, we can move it to the arch
> > directory and keep the perf stat code simple.
>
> I'm not sure what is the proper way to solve this. And Ian mentioned
> that put code in arch directory could potentially cause other bugs.
> So I'm wondering if we could keep this code here for now. I could work
> on it later if we found it's better to be in arch directory.

Maybe somewhere in the util/ and keep the main code minimal.
IIUC it's only for very recent (or upcoming?) Intel CPUs and we
don't have tests (hopefully can run on other arch/CPUs).

So I don't think having it here would help fixing potential bugs.

> > >
> > > +static void prepare_run_command(struct child_process *cmd,
> > > +                              const char **argv)
> > > +{
> > > +       memset(cmd, 0, sizeof(*cmd));
> > > +       cmd->argv =3D argv;
> > > +       cmd->out =3D -1;
> > > +}
> > > +
> > > +static int prepare_perf_record(struct child_process *cmd)
> > > +{
> > > +       const char **record_argv;
> > > +       int ret;
> > > +
> > > +       record_argv =3D calloc(10 + 2 * stat_config.tpebs_event_size,=
 sizeof(char
> > *));
> > > +       if (!record_argv)
> > > +               return -1;
> > > +
> > > +       ret =3D __run_perf_record(record_argv);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       prepare_run_command(cmd, record_argv);
> > > +       return start_command(cmd);
> > > +}
> > > +
> > > +struct perf_script {
> > > +       struct perf_tool        tool;
> > > +       struct perf_session     *session;
> > > +};
> > > +
> > > +static void tpebs_data__delete(void)
> > > +{
> > > +       struct tpebs_retire_lat *r, *rtmp;
> > > +       struct tpebs_event *e, *etmp;
> > > +
> > > +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results,=
 event.nd)
> > {
> > > +               list_del_init(&r->event.nd);
> > > +               free(r);
> > > +       }
> > > +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, =
nd) {
> > > +               list_del_init(&e->nd);
> > > +               free(e);
> >
> > Shouldn't it free the names?
> >
> >
> > > +       }
> > > +}
> > > +
> > > +static int process_sample_event(struct perf_tool *tool __maybe_unuse=
d,
> > > +                               union perf_event *event __maybe_unuse=
d,
> > > +                               struct perf_sample *sample,
> > > +                               struct evsel *evsel,
> > > +                               struct machine *machine __maybe_unuse=
d)
> > > +{
> > > +       int ret =3D 0;
> > > +       const char *evname;
> > > +       struct tpebs_retire_lat *t;
> > > +
> > > +       evname =3D evsel__name(evsel);
> > > +
> > > +       /*
> > > +        * Need to handle per core results? We are assuming average r=
etire
> > > +        * latency value will be used. Save the number of samples and=
 the sum
> > of
> > > +        * retire latency value for each event.
> > > +        */
> > > +       list_for_each_entry(t, &stat_config.tpebs_results, event.nd) =
{
> > > +               if (!strcmp(evname, t->event.name)) {
> > > +                       t->count +=3D 1;
> > > +                       t->sum +=3D sample->retire_lat;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int process_feature_event(struct perf_session *session,
> > > +                                union perf_event *event)
> > > +{
> > > +       if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > > +               return perf_event__process_feature(session, event);
> > > +       return 0;
> > > +}
> > > +
> > > +static void *__cmd_script(void *arg __maybe_unused)
> >
> > The arg is used.
> >
> > Also I don't like the name 'script' as it has nothing to do with
> > scripting.  Maybe 'sample_reader', 'tpebs_reader' or
> > 'reader_thread'?
> >
> >
> > > +{
> > > +       struct child_process *cmd =3D arg;
> > > +       struct perf_session *session;
> > > +       struct perf_data data =3D {
> > > +               .mode =3D PERF_DATA_MODE_READ,
> > > +               .path =3D PERF_DATA,
> > > +               .file.fd =3D cmd->out,
> > > +       };
> > > +       struct perf_script script =3D {
> > > +               .tool =3D {
> > > +               .sample          =3D process_sample_event,
> > > +               .feature         =3D process_feature_event,
> > > +               .attr            =3D perf_event__process_attr,
> >
> > Broken indentation.  And if you just use the tool, you can
> > pass it directly.
> >
> >
> > > +               },
> > > +       };
> > > +
> > > +       session =3D perf_session__new(&data, &script.tool);
> > > +       if (IS_ERR(session))
> > > +               return NULL;
> > > +       script.session =3D session;
> > > +       perf_session__process_events(session);
> > > +       perf_session__delete(session);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >  {
> > >         int interval =3D stat_config.interval;
> > > @@ -709,15 +856,38 @@ static int __run_perf_stat(int argc, const char
> > **argv, int run_idx)
> > >         struct affinity saved_affinity, *affinity =3D NULL;
> > >         int err;
> > >         bool second_pass =3D false;
> > > +       struct child_process cmd;
> > > +       pthread_t thread_script;
> > >
> > >         /* Prepare perf record for sampling event retire_latency befo=
re fork and
> > >          * prepare workload */
> > >         if (stat_config.tpebs_event_size > 0) {
> > >                 int ret;
> > > +               struct tpebs_event *e;
> > >
> > > -               ret =3D __run_perf_record();
> > > +               pr_debug("perf stat pid =3D %d\n", getpid());
> > > +               list_for_each_entry(e, &stat_config.tpebs_events, nd)=
 {
> > > +                       struct tpebs_retire_lat *new =3D malloc(sizeo=
f(struct
> > tpebs_retire_lat));
> > > +
> > > +                       if (!new)
> > > +                               return -1;
> > > +                       new->event.name =3D strdup(e->name);
> > > +                       new->event.tpebs_name =3D strdup(e->tpebs_nam=
e);
> >
> > These can fail too.
> >
> >
> > > +                       new->count =3D 0;
> > > +                       new->sum =3D 0;
> > > +                       list_add_tail(&new->event.nd, &stat_config.tp=
ebs_results);
> > > +               }
> > > +               ret =3D prepare_perf_record(&cmd);
> > >                 if (ret)
> > >                         return ret;
> > > +               if (pthread_create(&thread_script, NULL, __cmd_script=
, &cmd)) {
> > > +                       kill(cmd.pid, SIGTERM);
> > > +                       close(cmd.out);
> > > +                       pr_err("Could not create thread to process sa=
mple data.\n");
> > > +                       return -1;
> > > +               }
> > > +               /* Wait for perf record initialization a little bit.*=
/
> > > +               sleep(2);
> >
> > This won't guarantee anything.  If you want to make sure the
> > 'thread_script' to run before the 'perf record' process, you can
> > use a pipe to signal that like in evlist__prepare_workload() and
> > evlist__start_workload().
>
> This sleep is added to make perf stat wait for record initialization beca=
use in the
> case that the workload runs very small a mount of time, we'd like to ensu=
re perf
> record has enough time to launch and start collecting sample data.

But waiting for 2 seconds won't solve the problem.

>
> Because the code uses the common API in run-command.h to do the fork, I t=
hink
> it cannot use PIPE like in evlist__prepare_workload to sync and start per=
f record
> and perf stat data collection together. Please correct me if I'm wrong he=
re.

Ok, it'd be hard to sync both perf record and perf stat with a single workl=
oad.
I think you can try --control option in perf record to enable/disable
with timing
you want.  Also --synth=3Dno should reduce a lot of overhead during
initialization.
Maybe you can also add --synth=3Dno-kernel to completely skip the synthesis=
.

Thanks,
Namhyung


> > >         }
> > >
> > >         if (forks) {
> > > @@ -925,6 +1095,17 @@ static int __run_perf_stat(int argc, const char
> > **argv, int run_idx)
> > >
> > >         t1 =3D rdclock();
> > >
> > > +       if (stat_config.tpebs_event_size > 0) {
> > > +               int ret;
> > > +
> > > +               kill(cmd.pid, SIGTERM);
> > > +               pthread_join(thread_script, NULL);
> > > +               close(cmd.out);
> > > +               ret =3D finish_command(&cmd);
> > > +               if (ret !=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> > > +                       return ret;
> > > +       }
> > > +
> > >         if (stat_config.walltime_run_table)
> > >                 stat_config.walltime_run[run_idx] =3D t1 - t0;
> > >
> > > @@ -1032,6 +1213,9 @@ static void sig_atexit(void)
> > >         if (child_pid !=3D -1)
> > >                 kill(child_pid, SIGTERM);
> > >
> > > +       if (stat_config.tpebs_pid !=3D -1)
> > > +               kill(stat_config.tpebs_pid, SIGTERM);
> > > +
> > >         sigprocmask(SIG_SETMASK, &oset, NULL);
> > >
> > >         if (signr =3D=3D -1)
> > > @@ -2972,5 +3156,7 @@ int cmd_stat(int argc, const char **argv)
> > >         metricgroup__rblist_exit(&stat_config.metric_events);
> > >         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_=
ack,
> > &stat_config.ctl_fd_close);
> > >
> > > +       tpebs_data__delete();
> > > +
> > >         return status;
> > >  }
> > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > index 08c4bfbd817f..98e3014c0aef 100644
> > > --- a/tools/perf/util/data.c
> > > +++ b/tools/perf/util/data.c
> > > @@ -204,7 +204,11 @@ static bool check_pipe(struct perf_data *data)
> > >                                 data->file.fd =3D fd;
> > >                                 data->use_stdio =3D false;
> > >                         }
> > > -               } else {
> > > +               /*
> > > +                * When is_pipe and data->file.fd is given, use given=
 fd
> > > +                * instead of STDIN_FILENO or STDOUT_FILENO
> > > +                */
> > > +               } else if (data->file.fd <=3D 0) {
> > >                         data->file.fd =3D fd;
> > >                 }
> > >         }
> >
> > I think this can be in a separate commit.
> >
> >
> > > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgr=
oup.h
> > > index 7c24ed768ff3..ae788edef30f 100644
> > > --- a/tools/perf/util/metricgroup.h
> > > +++ b/tools/perf/util/metricgroup.h
> > > @@ -68,10 +68,18 @@ struct metric_expr {
> > >
> > >  struct tpebs_event {
> > >         struct list_head nd;
> > > +       /* Event name */
> > >         const char *name;
> > > +       /* Event name with the TPEBS modifier R */
> > >         const char *tpebs_name;
> > >  };
> > >
> > > +struct tpebs_retire_lat {
> > > +       struct tpebs_event event;
> > > +       size_t count;
> > > +       int sum;
> > > +};
> >
> > Actually I don't know why you need this separate structure.
> > Can we just use tpebs_event?
>
> Currently, we use average value as the retire latency value in metrics. B=
ut we
> might update it to use other value, for example the minimum or maximum. S=
o, I thought
> it would be better to have a dedicated data structure to handle this data=
 I could update
> the code to use tpebs_event if you still feel that's better.
>
> Thanks,
> Weilin
>
> >
> > Thanks,
> > Namhyung
> >
> >
> > > +
> > >  struct metric_event *metricgroup__lookup(struct rblist *metric_event=
s,
> > >                                          struct evsel *evsel,
> > >                                          bool create);
> > > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > > index b987960df3c5..0726bdc06681 100644
> > > --- a/tools/perf/util/stat.h
> > > +++ b/tools/perf/util/stat.h
> > > @@ -111,6 +111,8 @@ struct perf_stat_config {
> > >         struct rblist            metric_events;
> > >         struct list_head         tpebs_events;
> > >         size_t                   tpebs_event_size;
> > > +       struct list_head         tpebs_results;
> > > +       pid_t                    tpebs_pid;
> > >         int                      ctl_fd;
> > >         int                      ctl_fd_ack;
> > >         bool                     ctl_fd_close;
> > > --
> > > 2.43.0
> > >

