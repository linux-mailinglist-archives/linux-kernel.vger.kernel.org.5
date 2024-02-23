Return-Path: <linux-kernel+bounces-77883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD6860B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A501F25D28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C914ABA;
	Fri, 23 Feb 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7amSfa0"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D1134BF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674479; cv=none; b=VcJldBj9NHwtVXnXsjUMo6pDpYE1I0vYtIw9ZjKhwXqd9utxZjtzdqCaENPlQVwn0V5YX2QL6fESvIYJ532S4jf9y9lMFJ1nDg3p0mXcoS8AZHYPNXAdYbB145hXEucf5coi8OQ3o3OFZ1VlXEJsm3W2cnOdFS02Zp1NP4c9AFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674479; c=relaxed/simple;
	bh=hk4iHkgvtcaWYle7qzHBv616q29Ztlm/sy3d+PC79Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laWe32qw5e6y8279plYo7lssELNLh3eOuTygfi/HUAWC/vAZ9pnw6qjTWR78ESplg/6IYBpHnouXdL3jgT2a2Bk7kw0gIRNh15nmtnJb1HerLB8jnNc4UR/CEPSPYJtZNWEVLcpaHmVOMuNSLJsa/HPAGD/O90NgI9IgtujCne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7amSfa0; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42e2507c6e1so152101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708674476; x=1709279276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0KdWXnNPXrO2hGoS5Yn0GgQ86C30MJU/LxxkA1XfDQ=;
        b=K7amSfa0WbX32V9429ZeoRnQAELNaSVe8EMQ3Uo50npLA073HROTDT19ZI/xbpv04Y
         3CEHu/jPoY1SmILLCTBlJQfMKcdFpNpeeI8N7RjGRhQ69kWN2Z5UQs8vgLlsl88r+rXM
         PHmZoljJNJzCrwd/IgL56y84wM+UuJ4ceu+/tZKYb8mz/G+XyvQ/6nD0Aqvw9ccEDF66
         3EmbcDaMycDE7o74WRYU25PtsAR5t+tyfYZa2LLgy60JDWdrIQyjwp7iHKnsUeTY0Oae
         urvIStTMFpmHqhkbEPf8TAKMz2on3HZK2yi9vSoA7S7zAwaVXPnltuW68aRQJW3n7Wal
         pr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674476; x=1709279276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0KdWXnNPXrO2hGoS5Yn0GgQ86C30MJU/LxxkA1XfDQ=;
        b=bnDTXkfKTx5wIWCdEsKypAHTNZfl0pv1dMMFHm8FStZnxwy+GgeGrq1QIK95Go4mzK
         F+EnCDQuPr2KsnKDymDPNOWKyQw9iGCpUt2o9Fuv15PAW77Dle0nTJcJRWA1LmoP4QKK
         8MeY148G0E2iwvmUj9jqb02HGxAwGumZPdIbboDp/tqicD1ohhVfM95fj2AY1UCvufvU
         +cAhpqSP14YhTbFae6Upfkv3ekzlJo7g0vcrt4SD+FDh8KXqdq0lID4ZQW13n3+pkXLD
         YS1/aLttx3d985WxxB7RI/UoeymweH8sJ3eVvZSGIEe6IdDdKN3x9AIGDBoveheKlr9y
         UneQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9kAwdmB38kDLb/W3Rd2xQr3GaCL3HjfjTMM7QRgCGOhNUEhIP7uMIUSbHTSAEbarVmJgAHGo2DusQH13T0DWdXGcBH88bSuSNzKTZ
X-Gm-Message-State: AOJu0YxRpI9g26jRKxSKFDGuBt/ptxOntnpFNk4FTXddOLbmTovBIbEN
	/7bHDUrHlSRNUnhs3cxAgtMmtc2viI3KC2coRaL02pXut3vq06D9+FZUYQayGnyOMJmi4GgS306
	HNBBrrO+UHKcP3ue5dirp9Sb6/rLSUUYYCTZu
X-Google-Smtp-Source: AGHT+IGCZ+nykAXIUYDNesdFKBY3E/jD75YseTN49er9jeQmWSKaIS20lHbvPwqxHZ16J1haZ1rsHzph3W0dNzTVy0U=
X-Received: by 2002:ac8:7dcd:0:b0:42e:4e52:5aad with SMTP id
 c13-20020ac87dcd000000b0042e4e525aadmr557743qte.12.1708674475711; Thu, 22 Feb
 2024 23:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221072100.412939-1-weilin.wang@intel.com>
 <20240221072100.412939-3-weilin.wang@intel.com> <ZdY4a5yx-C9ziobq@x1>
 <CAP-5=fU5JVki4OCYvYyPoBLguwHSwXripiO3Gq+MddV9ZWfnTQ@mail.gmail.com> <CAM9d7ch3E=hNbX6=xUHZ+B_Dphy_sALzaCki1he3-O00DAoYXg@mail.gmail.com>
In-Reply-To: <CAM9d7ch3E=hNbX6=xUHZ+B_Dphy_sALzaCki1he3-O00DAoYXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Feb 2024 23:47:41 -0800
Message-ID: <CAP-5=fWf4YxOZUmuZsUt9na=CpXL-eLkd9d6OvtsgJkONC1gzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi,
>
> On Wed, Feb 21, 2024 at 12:34=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Feb 21, 2024 at 02:20:56AM -0500, weilin.wang@intel.com wrote=
:
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > You wrote no description for this patch, please add one and show
> > > examples of the feature being used, if possible.
> > >
> > > See below for more comments.
> > >
> > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > > +static int __cmd_script(struct child_process *cmd __maybe_unused)
> > > > +{
> > > > +     int err =3D 0;
> > > > +     struct perf_session *session;
> > > > +     struct perf_data data =3D {
> > > > +             .mode =3D PERF_DATA_MODE_READ,
> > > > +             .path =3D PERF_DATA,
> > > > +             .fd   =3D cmd->out,
> > > > +     };
> > > > +     struct perf_script script =3D {
> > > > +             .tool =3D {
> > > > +             .sample          =3D process_sample_event,
> > > > +             .ordered_events  =3D true,
> > > > +             .ordering_requires_timestamps =3D true,
> > > > +             .feature         =3D process_feature_event,
> > > > +             .attr            =3D perf_event__process_attr,
> > > > +             },
> > > > +     };
> > > > +     struct tpebs_event *e;
> > > > +
> > > > +     list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> > > > +             struct tpebs_retire_lat *new =3D malloc(sizeof(struct=
 tpebs_retire_lat));
> > > > +
> > > > +             if (!new)
> > > > +                     return -1;
> > > > +             new->name =3D strdup(e->name);
> > > > +             new->tpebs_name =3D strdup(e->tpebs_name);
> > > > +             new->count =3D 0;
> > > > +             new->sum =3D 0;
> > >
> > > Without even having thought that much about this overall architecture=
,
> > > that looks too heavy at first sight, the above is done in tools/perf/
> > > as:
> > >
> > > void tpebs_retire_lat__delete(struct tpebs_retire_lat *retire_lat)
> > > {
> > >         if (retire_lat =3D=3D NULL)
> > >                 return;
> > >
> > >         zfree(&retire_lat->tpebs_name);
> > >         zfree(&retire_lat->tpebs_name);
> > > }
> > >
> > > struct tpebs_retire_lat__new(tpebs_event *e)
> > > {
> > >         struct tpebs_retire_lat *retire_lat =3D zalloc(sizeof(*retire=
_lat));
> > >
> > >         if (retire_lat !=3D NULL) {
> > >                 retire_lat->name =3D strdup(e->name);
> > >                 retire_lat->tpebs_name =3D strdup(e->tpebs_name);
> > >
> > >                 if (retire_lat->name =3D=3D NULL || retire_lat->tpebs=
_name =3D=3D NULL) {
> > >                         tpebs_retire_lat__delete(retire_lat);
> > >                         retire_lat =3D NULL;
> > >                 }
> > >         }
> > >
> > >         return retire_lat;
> > > }
> > >
> > > And then you call the constructor  in that loop, and the destructor a=
t
> > > some point when those data structures are not needed.
> > >
> > > We do it because perf has a TUI mode and we may end up calling tools
> > > from them in a long running session, so we need to avoid leaks.
> > >
> > > Also can we somehow hide Intel specific terms in arch specific files
> > > while leaving something generic, possibly implementable in other arch=
es
> > > in the core code? I mean hiding clearly intel specific stuff like the
> > > "tpebs" term in tools/perf/arch/x86/.
> >
> > Thanks Arnaldo, TPEBS support is necessary to support TMA metrics 4.7
> > on meteorlake. The timed values replace hard coded constants that
> > assume worst case latencies. You can see the metrics here:
> > https://github.com/intel/perfmon/blob/main/TMA_Metrics-full.csv
> > in the MTL (meteorlake) column row 29 there is:
> > MEM_INST_RETIRED.STLB_HIT_LOADS*min($PEBS, #Mem_STLB_Hit_Cost) / CLKS
> > + Load_STLB_Miss
> > where the $PEBS is supposed to be replaced with the latency from a
> > sample of MEM_INST_RETIRED.STLB_HIT_LOADS. There are meteorlake
> > machines shipping but currently there are no perf metrics.
> >
> > Weilin raised the TPEBS problem in the LPC 2023 talk, the issue being
> > that sampling and counting don't really exist in the current perf tool
> > code at the same time. BPF could be a workaround but permissions are
> > an issue. Perhaps leader sampling but then what to do if two latencies
> > are needed. Forking perf to do this is an expedient and ideally we'd
> > not do it.
>
> Even with BPF, I think it needs two instances of an event - one for
> counting and the other for sampling, right?  I wonder if it can just
> use a single event for sampling and show the sum of periods in
> PERF_SAMPLE_READ.
>
> I'm not sure if an event group can have sampling and non-sampling
> events at the same time.  But it can be done without groups then.
> Anyway what's the issue with two latencies?

The latencies come from samples and with leader sampling only the
leader gets sampled so we can't get two latencies. For 2 latencies
we'd need 2 groups for 2 leaders or to modify leader sampling - if we
could encode that we want to sample but don't need the sample in the
mmap, just want the latency being available to be read, etc. This and
BPF are both long-term viable solutions, but forking is the expedient
solution to get something going - we'd likely want it as a fallback
anyway.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > I'm against stuff going in the arch directory in general. If something
> > is specific to a PMU, let's special case the logic for that PMU in the
> > tool. The arch directory gets us into messes like:
> > https://lore.kernel.org/lkml/CAP-5=3DfVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhP=
TfHbQsKXb_g@mail.gmail.com/
> > Where a heterogenous/hybrid/big.little fix is in the x86 arch folder
> > (overriding a weak symbol) but not in the arm or other ones leading to
> > an arm bug.
> >
> > I think the idea of a count coming from an external or tool source is
> > something of a more generic concept. I think what Weilin is doing here
> > is setting the groundwork for doing that, a first implementation. I'd
> > like the expr literals, like #smt_on, #num_cpus, etc. to be more like
> > tool events such as duration_time. I think we can move in the
> > direction that Weilin is adding here and then iterate to clean up
> > these things, hopefully move them to events that then other tools
> > could use, etc.
> >
> > Thanks,
> > Ian
> >
> >
> >
> >
> > > > +             list_add_tail(&new->nd, &stat_config.tpebs_results);
> > > > +     }
> > > > +
> > > > +     kill(cmd->pid, SIGTERM);
> > > > +     session =3D perf_session__new(&data, &script.tool);
> > > > +     if (IS_ERR(session))
> > > > +             return PTR_ERR(session);
> > > > +     script.session =3D session;
> > > > +     err =3D perf_session__process_events(session);
> > > > +     perf_session__delete(session);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +
> > > >  static int __run_perf_stat(int argc, const char **argv, int run_id=
x)
> > > >  {
> > > >       int interval =3D stat_config.interval;
> > > > @@ -709,12 +866,14 @@ static int __run_perf_stat(int argc, const ch=
ar **argv, int run_idx)
> > > >       struct affinity saved_affinity, *affinity =3D NULL;
> > > >       int err;
> > > >       bool second_pass =3D false;
> > > > +     struct child_process cmd;
> > > >
> > > >       //Prepare perf record for sampling event retire_latency befor=
e fork and prepare workload
> > > >       if (stat_config.tpebs_event_size > 0) {
> > > >               int ret;
> > > >
> > > > -             ret =3D __run_perf_record();
> > > > +             pr_debug("perf stat pid =3D %d\n", getpid());
> > > > +             ret =3D prepare_perf_record(&cmd);
> > > >               if (ret)
> > > >                       return ret;
> > > >       }
> > > > @@ -924,6 +1083,17 @@ static int __run_perf_stat(int argc, const ch=
ar **argv, int run_idx)
> > > >
> > > >       t1 =3D rdclock();
> > > >
> > > > +     if (stat_config.tpebs_event_size > 0) {
> > > > +             int ret;
> > > > +
> > > > +             pr_debug("pid =3D %d\n", getpid());
> > > > +             pr_debug("cmd.pid =3D %d\n", cmd.pid);
> > > > +
> > > > +             ret =3D __cmd_script(&cmd);
> > > > +             close(cmd.out);
> > > > +             pr_debug("%d\n", ret);
> > > > +     }
> > > > +
> > > >       if (stat_config.walltime_run_table)
> > > >               stat_config.walltime_run[run_idx] =3D t1 - t0;
> > > >
> > > > @@ -2714,6 +2884,7 @@ int cmd_stat(int argc, const char **argv)
> > > >       }
> > > >
> > > >       INIT_LIST_HEAD(&stat_config.tpebs_events);
> > > > +     INIT_LIST_HEAD(&stat_config.tpebs_results);
> > > >
> > > >       /*
> > > >        * Metric parsing needs to be delayed as metrics may optimize=
 events
> > > > @@ -2921,5 +3092,7 @@ int cmd_stat(int argc, const char **argv)
> > > >       metricgroup__rblist_exit(&stat_config.metric_events);
> > > >       evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_=
ack, &stat_config.ctl_fd_close);
> > > >
> > > > +     tpebs_data__delete();
> > > > +
> > > >       return status;
> > > >  }
> > > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > > index fc16299c915f..2298ca3b370b 100644
> > > > --- a/tools/perf/util/data.c
> > > > +++ b/tools/perf/util/data.c
> > > > @@ -173,6 +173,10 @@ static bool check_pipe(struct perf_data *data)
> > > >       int fd =3D perf_data__is_read(data) ?
> > > >                STDIN_FILENO : STDOUT_FILENO;
> > > >
> > > > +     if (data->fd > 0) {
> > > > +             fd =3D data->fd;
> > > > +     }
> > > > +
> > > >       if (!data->path) {
> > > >               if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
> > > >                       is_pipe =3D true;
> > > > diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> > > > index effcc195d7e9..5554d46ad212 100644
> > > > --- a/tools/perf/util/data.h
> > > > +++ b/tools/perf/util/data.h
> > > > @@ -28,6 +28,7 @@ struct perf_data_file {
> > > >
> > > >  struct perf_data {
> > > >       const char              *path;
> > > > +     int                      fd;
> > > >       struct perf_data_file    file;
> > > >       bool                     is_pipe;
> > > >       bool                     is_dir;
> > > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metric=
group.c
> > > > index 6c16e5a0b1fc..8518e2b3e5be 100644
> > > > --- a/tools/perf/util/metricgroup.c
> > > > +++ b/tools/perf/util/metricgroup.c
> > > > @@ -691,8 +691,17 @@ static int metricgroup__build_event_string(str=
uct strbuf *events,
> > > >
> > > >               if (p) {
> > > >                       struct tpebs_event *new_event =3D malloc(size=
of(struct tpebs_event));
> > > > -                     *p =3D '\0';
> > > > +                     char *name;
> > > > +
> > > >                       new_event->tpebs_name =3D strdup(id);
> > > > +                     *p =3D '\0';
> > > > +                     name =3D malloc(strlen(id) + 2);
> > > > +                     if (!name)
> > > > +                             return -ENOMEM;
> > > > +
> > > > +                     strcpy(name, id);
> > > > +                     strcat(name, ":p");
> > > > +                     new_event->name =3D name;
> > >
> > > For such cases we use asprintf(), that allocates and formats the stri=
ng
> > > in one call, look for examples in other tools/perf/ files.
> > >
> > > >                       *tpebs_event_size +=3D 1;
> > > >                       pr_debug("retire_latency required, tpebs_even=
t_size=3D%lu, new_event=3D%s\n",
> > > >                       *tpebs_event_size, new_event->name);
> > > > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metric=
group.h
> > > > index 7c24ed768ff3..1fa12cc3294e 100644
> > > > --- a/tools/perf/util/metricgroup.h
> > > > +++ b/tools/perf/util/metricgroup.h
> > > > @@ -71,6 +71,13 @@ struct tpebs_event {
> > > >       const char *name;
> > > >       const char *tpebs_name;
> > > >  };
> > > > +struct tpebs_retire_lat {
> > > > +     struct list_head nd;
> > > > +     const char *name;
> > > > +     const char *tpebs_name;
> > > > +     size_t count;
> > > > +     int sum;
> > > > +};
> > >
> > > Here you declare the constructor and destructor I suggested above.
> > >
> > > >  struct metric_event *metricgroup__lookup(struct rblist *metric_eve=
nts,
> > > >                                        struct evsel *evsel,
> > > > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > > > index 9d0186316b29..8e180f13aa2d 100644
> > > > --- a/tools/perf/util/stat.h
> > > > +++ b/tools/perf/util/stat.h
> > > > @@ -111,6 +111,9 @@ struct perf_stat_config {
> > > >       struct rblist            metric_events;
> > > >       struct list_head         tpebs_events;
> > > >       size_t                   tpebs_event_size;
> > > > +     struct list_head         tpebs_results;
> > > > +     pid_t                    tpebs_pid;
> > > > +     int                      tpebs_pipe;
> > > >       int                      ctl_fd;
> > > >       int                      ctl_fd_ack;
> > > >       bool                     ctl_fd_close;
> > > > --
> > > > 2.43.0
> > > >

