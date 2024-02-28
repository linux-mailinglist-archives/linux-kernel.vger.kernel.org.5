Return-Path: <linux-kernel+bounces-84311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C086A4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9512A1F25AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEF1C10;
	Wed, 28 Feb 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBRv8dJf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC21865
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082855; cv=none; b=gWeqc+f1yTcksGCLv8jLJ+8uPsii3TEpwcBa53f6m22akr19Gp9zRm0AlLaHWMrCh9exe/Ha5m2CU1epTY60cRfIkFSILt82JrfRCJNEYBhxwqo38/R4nhB9i647sCRsVFZKCURmfBCcm6T8DD4KMtYKztLPUiHY9cz+SX0V63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082855; c=relaxed/simple;
	bh=HKkuS08UCcLnHyFsd/PYYoXs8kcwCswrif8F5EXst5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvguMGDKu7nWCeJ1lClKIfpWP6Hq8sGoOZQbiv+oqUfOxaD+2tFeUayvEpPBbbI/HC23PmPMzG36EI3nT6+xhnISn4ndBfjCaSB1IOLj6CBKK9rVa9LHOtLIXNq1p8pPyW0Jp847eVo4B2JZ3UFyoLCE0Szx1bIpPLfoGNFqO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBRv8dJf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc929e5d99so50225ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709082853; x=1709687653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlNbSg8kNoUs/tgbtkS2aQ1H0pP30218seX1FJswzYk=;
        b=uBRv8dJfG9Ayl2lbYLVm0mxZFd55YC/2OdA7xy/rh0PPDrnfOGRFKw//6o3YB91Ylk
         pCh03WAWMPaI+IDj4fIiJFBttkv8mfCaQnvtMgxxB5ckGDBnK2THpsUugGIWzNHofHA2
         RDAM9c+tGlK3KSUF9mZsxxQbd1fhnBbIaEOHXZRVVLZOLZ0CnhWJWMEFEU2w0UegPPss
         akycBkFxNwGfXbdNH9Sm8dJ+88DXe02yVWlFnTa6VyfgFMyjFvnE7kfmIaOrt8a8cJPl
         9XJ8aiTmcIgNys7UMSUHpSQu+H0HN2mVD1qfKQKPlIbFNEONKgmJremzBD5qsOcvsqfx
         A5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082853; x=1709687653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlNbSg8kNoUs/tgbtkS2aQ1H0pP30218seX1FJswzYk=;
        b=HN8wgOAN0A6QjSWN9UYH+b6eSddMYRyY2EI+ar+3apQUDt+3OdYFY2CYhCf8KGIL8K
         WqLDEemNSEbF5fiaOtg3Xidwf4jA9pghCRDfDRpdEBRY2vW/FHZaxBkUWIgYVEIJ3yPE
         NLDxEzXnWgS2MRa5kbBnru5ukaoceEA1FpECBE5JQrhvrnhI+bGkFcKHjOGy3SARTJt/
         5mlFC9Er/ciWmfZSbkP0gB2rMxRz5818/HrC3gsfUeDqEvrpeMHYCoxoJEyAx0sqty4A
         90Wtx9/85zzbnrtedlwwSL8tJsxOz0qh4HPxCl/yji5N5/Lz8uFm629b+lmL1HTg7KTX
         2oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFer9yMiXF1erGYymPTDl4K53+6r/FkZT1kEN4o3jvYp+wWGf23Nuj7tbxVyMxuC1neG5FJWibHEUDTVKSI74DkUZ8tqzOkD5kd2xK
X-Gm-Message-State: AOJu0Yw3rnTHuYOY2HYWyKlYLLoWF0vBXybpkz0WwKVjHHQ1B6sZcIMk
	zIcTYbLbmHTX4G0THlImpV+WxImcC8eNtm7bopYe7hwtbF5/r6o15DHVAAmAFJI/n/RAsj87xZf
	N+1ZoVS+iFdhxYbQ/nISsrZ58L2FAVAPgG29L
X-Google-Smtp-Source: AGHT+IHWTGLOXw7UCZsuUDKRR/YwZ/zk3nDnghvgm3pzDrtd8//qwbUnObkm2y3zSqyw46qzK/kjbMsiMJGiHVbVHyU=
X-Received: by 2002:a17:902:8c88:b0:1db:a356:b954 with SMTP id
 t8-20020a1709028c8800b001dba356b954mr48652plo.28.1709082852418; Tue, 27 Feb
 2024 17:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209230657.1546739-1-namhyung@kernel.org> <CAP-5=fWS-5vbX+dF+bjPLf4OkkQg2kV515oLGTwL6C8kU7Gu3g@mail.gmail.com>
 <CAM9d7chRWk2mpph3zVTQXJeaWaFTreUZAWvHafoYqx5vsfpTpw@mail.gmail.com>
In-Reply-To: <CAM9d7chRWk2mpph3zVTQXJeaWaFTreUZAWvHafoYqx5vsfpTpw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 17:13:57 -0800
Message-ID: <CAP-5=fXuDdOrsF4hG_wxua+Y9_PziRtYB8hLsAfm_UQc_Qsk8g@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf lock contention: Account contending locks too
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Feb 27, 2024 at 3:49=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Fri, Feb 9, 2024 at 3:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Currently it accounts the contention using delta between timestamps i=
n
> > > lock:contention_begin and lock:contention_end tracepoints.  But it me=
ans
> > > the lock should see the both events during the monitoring period.
> > >
> > > Actually there are 4 cases that happen with the monitoring:
> > >
> > >                 monitoring period
> > >             /                       \
> > >             |                       |
> > >  1:  B------+-----------------------+--------E
> > >  2:    B----+-------------E         |
> > >  3:         |           B-----------+----E
> > >  4:         |     B-------------E   |
> > >             |                       |
> > >             t0                      t1
> > >
> > > where B and E mean contention BEGIN and END, respectively.  So it onl=
y
> > > accounts the case 4 for now.  It seems there's no way to handle the c=
ase
> > > 1.  The case 2 might be handled if it saved the timestamp (t0), but i=
t
> > > lacks the information from the B notably the flags which shows the lo=
ck
> > > types.  Also it could be a nested lock which it currently ignores.  S=
o
> > > I think we should ignore the case 2.
> > >
> > > However we can handle the case 3 if we save the timestamp (t1) at the
> > > end of the period.  And then it can iterate the map entries in the
> > > userspace and update the lock stat accordinly.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/bpf_lock_contention.c         | 116 ++++++++++++++++=
++
> > >  .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 +--
> > >  tools/perf/util/bpf_skel/lock_data.h          |   7 ++
> > >  3 files changed, 132 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/=
bpf_lock_contention.c
> > > index 31ff19afc20c..d6bafd9a3955 100644
> > > --- a/tools/perf/util/bpf_lock_contention.c
> > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > @@ -179,6 +179,119 @@ int lock_contention_prepare(struct lock_content=
ion *con)
> > >         return 0;
> > >  }
> > >
> > > +static void mark_end_timestamp(void)
> > > +{
> > > +       DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > > +               .flags =3D BPF_F_TEST_RUN_ON_CPU,
> >
> > It seems strange that this and the raw tracepoint are both test. I see
> > similar non-test uses in libbpf-tools. It would be worth documenting
> > that this isn't test code. Everything else LGTM.
>
> It's a BPF syscall API that allows to run a certain kind of BPF program
> directly and not to necessarily be in a test.

Right, I was meaning that it'd be good to capture that as a comment so
that someone reading the code isn't going to think it is test code.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > +       );
> > > +       int prog_fd =3D bpf_program__fd(skel->progs.end_timestamp);
> > > +
> > > +       bpf_prog_test_run_opts(prog_fd, &opts);
> > > +}
> > > +
> > > +static void update_lock_stat(int map_fd, int pid, u64 end_ts,
> > > +                            enum lock_aggr_mode aggr_mode,
> > > +                            struct tstamp_data *ts_data)
> > > +{
> > > +       u64 delta;
> > > +       struct contention_key stat_key =3D {};
> > > +       struct contention_data stat_data;
> > > +
> > > +       if (ts_data->timestamp >=3D end_ts)
> > > +               return;
> > > +
> > > +       delta =3D end_ts - ts_data->timestamp;
> > > +
> > > +       switch (aggr_mode) {
> > > +       case LOCK_AGGR_CALLER:
> > > +               stat_key.stack_id =3D ts_data->stack_id;
> > > +               break;
> > > +       case LOCK_AGGR_TASK:
> > > +               stat_key.pid =3D pid;
> > > +               break;
> > > +       case LOCK_AGGR_ADDR:
> > > +               stat_key.lock_addr_or_cgroup =3D ts_data->lock;
> > > +               break;
> > > +       case LOCK_AGGR_CGROUP:
> > > +               /* TODO */
> > > +               return;
> > > +       default:
> > > +               return;
> > > +       }
> > > +
> > > +       if (bpf_map_lookup_elem(map_fd, &stat_key, &stat_data) < 0)
> > > +               return;
> > > +
> > > +       stat_data.total_time +=3D delta;
> > > +       stat_data.count++;
> > > +
> > > +       if (delta > stat_data.max_time)
> > > +               stat_data.max_time =3D delta;
> > > +       if (delta < stat_data.min_time)
> > > +               stat_data.min_time =3D delta;
> > > +
> > > +       bpf_map_update_elem(map_fd, &stat_key, &stat_data, BPF_EXIST)=
;
> > > +}
> > > +
> > > +/*
> > > + * Account entries in the tstamp map (which didn't see the correspon=
ding
> > > + * lock:contention_end tracepoint) using end_ts.
> > > + */
> > > +static void account_end_timestamp(struct lock_contention *con)
> > > +{
> > > +       int ts_fd, stat_fd;
> > > +       int *prev_key, key;
> > > +       u64 end_ts =3D skel->bss->end_ts;
> > > +       int total_cpus;
> > > +       enum lock_aggr_mode aggr_mode =3D con->aggr_mode;
> > > +       struct tstamp_data ts_data, *cpu_data;
> > > +
> > > +       /* Iterate per-task tstamp map (key =3D TID) */
> > > +       ts_fd =3D bpf_map__fd(skel->maps.tstamp);
> > > +       stat_fd =3D bpf_map__fd(skel->maps.lock_stat);
> > > +
> > > +       prev_key =3D NULL;
> > > +       while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> > > +               if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) =3D=3D=
 0) {
> > > +                       int pid =3D key;
> > > +
> > > +                       if (aggr_mode =3D=3D LOCK_AGGR_TASK && con->o=
wner)
> > > +                               pid =3D ts_data.flags;
> > > +
> > > +                       update_lock_stat(stat_fd, pid, end_ts, aggr_m=
ode,
> > > +                                        &ts_data);
> > > +               }
> > > +
> > > +               prev_key =3D &key;
> > > +       }
> > > +
> > > +       /* Now it'll check per-cpu tstamp map which doesn't have TID.=
 */
> > > +       if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_=
AGGR_CGROUP)
> > > +               return;
> > > +
> > > +       total_cpus =3D cpu__max_cpu().cpu;
> > > +       ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
> > > +
> > > +       cpu_data =3D calloc(total_cpus, sizeof(*cpu_data));
> > > +       if (cpu_data =3D=3D NULL)
> > > +               return;
> > > +
> > > +       prev_key =3D NULL;
> > > +       while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> > > +               if (bpf_map_lookup_elem(ts_fd, &key, cpu_data) < 0)
> > > +                       goto next;
> > > +
> > > +               for (int i =3D 0; i < total_cpus; i++) {
> > > +                       update_lock_stat(stat_fd, -1, end_ts, aggr_mo=
de,
> > > +                                        &cpu_data[i]);
> > > +               }
> > > +
> > > +next:
> > > +               prev_key =3D &key;
> > > +       }
> > > +       free(cpu_data);
> > > +}
> > > +
> > >  int lock_contention_start(void)
> > >  {
> > >         skel->bss->enabled =3D 1;
> > > @@ -188,6 +301,7 @@ int lock_contention_start(void)
> > >  int lock_contention_stop(void)
> > >  {
> > >         skel->bss->enabled =3D 0;
> > > +       mark_end_timestamp();
> > >         return 0;
> > >  }
> > >
> > > @@ -301,6 +415,8 @@ int lock_contention_read(struct lock_contention *=
con)
> > >         if (stack_trace =3D=3D NULL)
> > >                 return -1;
> > >
> > > +       account_end_timestamp(con);
> > > +
> > >         if (con->aggr_mode =3D=3D LOCK_AGGR_TASK) {
> > >                 struct thread *idle =3D __machine__findnew_thread(mac=
hine,
> > >                                                                 /*pid=
=3D*/0,
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/p=
erf/util/bpf_skel/lock_contention.bpf.c
> > > index 95cd8414f6ef..fb54bd38e7d0 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > @@ -19,13 +19,6 @@
> > >  #define LCB_F_PERCPU   (1U << 4)
> > >  #define LCB_F_MUTEX    (1U << 5)
> > >
> > > -struct tstamp_data {
> > > -       __u64 timestamp;
> > > -       __u64 lock;
> > > -       __u32 flags;
> > > -       __s32 stack_id;
> > > -};
> > > -
> > >  /* callstack storage  */
> > >  struct {
> > >         __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > @@ -140,6 +133,8 @@ int perf_subsys_id =3D -1;
> > >  /* determine the key of lock stat */
> > >  int aggr_mode;
> > >
> > > +__u64 end_ts;
> > > +
> > >  /* error stat */
> > >  int task_fail;
> > >  int stack_fail;
> > > @@ -559,4 +554,11 @@ int BPF_PROG(collect_lock_syms)
> > >         return 0;
> > >  }
> > >
> > > +SEC("raw_tp/bpf_test_finish")
> > > +int BPF_PROG(end_timestamp)
> > > +{
> > > +       end_ts =3D bpf_ktime_get_ns();
> > > +       return 0;
> > > +}
> > > +
> > >  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> > > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/b=
pf_skel/lock_data.h
> > > index 08482daf61be..36af11faad03 100644
> > > --- a/tools/perf/util/bpf_skel/lock_data.h
> > > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > > @@ -3,6 +3,13 @@
> > >  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
> > >  #define UTIL_BPF_SKEL_LOCK_DATA_H
> > >
> > > +struct tstamp_data {
> > > +       u64 timestamp;
> > > +       u64 lock;
> > > +       u32 flags;
> > > +       u32 stack_id;
> > > +};
> > > +
> > >  struct contention_key {
> > >         u32 stack_id;
> > >         u32 pid;
> > > --
> > > 2.43.0.687.g38aa6559b0-goog
> > >

