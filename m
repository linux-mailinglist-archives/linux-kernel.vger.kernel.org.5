Return-Path: <linux-kernel+bounces-99610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A64878ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C801F21FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B25788B;
	Mon, 11 Mar 2024 22:28:02 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97875786B;
	Mon, 11 Mar 2024 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196082; cv=none; b=gquCYiYWm66NJf2brWw9dX+M4ceGUjZh8h3YfAK+o9NgWTx5Ls7lzJx3Yo3fLGpNuceLiVMXUAGOwcjVY8vS+cHA4/TESGNSm+8rr9mFruOJKiHpakK7e+dBAbxOCsDEal8XlMiQecGevnKVzt8DbJ7Ib/pZtgHxv2hiEAjq08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196082; c=relaxed/simple;
	bh=kJLJQBV2qw2+MpH8WSSGUqmdlVUCAwJYDgoLRmvo8Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwIqw/cTvbX86ugkLmsav4uZhpuMrMH3yWOpYAw7YkxY/UVstsKzijzOr82BMndqqh0m/rLW9g7blwIBgXF/HpSfEIiFJxFbVgDqcPwPlwb8qYjgon3uGIZ2kaVa9NKJ7b8WAsdDV6H3ntbdGY8R1rkHOBUpiiTYv0csGRxe2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4251211a12.1;
        Mon, 11 Mar 2024 15:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196080; x=1710800880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoIhOy+bFc3EA31aYO9oJWfnZngLi2VKXb3hTBJEHAM=;
        b=K5MHCvUp5V1BuBXZNmXCLL2n8ayZIBhLEWfntM/44Nu9WrGyvkogMFaRuSnGJpY9Hu
         G9vvt4ep0BhWetPogZu+aEobVB/ZHLaQO4MycmyWlHzwhVMAViGmvPcAbpR8ilIY2TkE
         A90ub3q0kYhsSgO74Lu0G5UM5N2XKoqD+QGZA9jIvfX9IzcD9dxPfmZ1Yj3B4w870dwa
         62Ngo0czBbGkiMXXJzwI65aFBlqTczuG+3RuzTlB2XeKSPbSiPrQRy5UdAxgzLZqd0xJ
         TA73vOR4ujPZqaWJ9FGllGSuONy007uPCjk5WPY5p/Y0/LDKi0UzlMnmL2ooL4yZ2O3V
         QMEA==
X-Forwarded-Encrypted: i=1; AJvYcCXSRDqxpL/khMsRTkpjUbGKbKN4b+bYzAXmjOn9YPkSI5UeVOZooCMlkTVtv00gqiUJHVklEPjAWMc/bA4x8aH5yOusee7D+Vy8WRZLHfumoSHqe2pi2vSsZbA98CEDXZMq6fkcUkarpiec6UiTiQ==
X-Gm-Message-State: AOJu0Ywi5PF1YLfMk//MdH9r4AeKUhRI7g1uMY2pzlnNpskGoNpXmDFA
	sTn5E2i7LZVLcCaJQuuf2eodPglPGfTx2yyITcwve+AwAuVyIqIjadw5DsD3L2KReM9FDO6mpqz
	5XcSrOC9EiMwCYSEQZD9CGlGmq3w=
X-Google-Smtp-Source: AGHT+IFjNFdQjHHUJQQcXyliyhtxgze7FxedmY1LnorDAMMBCzpujSs9gQ06GBC3JW/65IQlh1/141MEhm7ShuPa+HQ=
X-Received: by 2002:a05:6a20:9385:b0:1a1:66d3:bc9e with SMTP id
 x5-20020a056a20938500b001a166d3bc9emr8869335pzh.3.1710196080086; Mon, 11 Mar
 2024 15:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com>
 <20240302001139.604829-3-weilin.wang@intel.com> <CAM9d7cjz1JPM0MQ5m6V7DCgShCBNCd5uqVLotf61J3eu216mEQ@mail.gmail.com>
 <CO6PR11MB5635949BE12E694160F28D5CEE242@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635949BE12E694160F28D5CEE242@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 15:27:48 -0700
Message-ID: <CAM9d7cguqEnxABCNYDr6W93sY3hPRBV1ieuWhy+6+H54OmWprA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:30=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Monday, March 11, 2024 2:08 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Peter Zijlstra <peterz@infradead.o=
rg>;
> > Ingo Molnar <mingo@redhat.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > Hello Weilin,
> >
> > On Fri, Mar 1, 2024 at 4:11=E2=80=AFPM <weilin.wang@intel.com> wrote:
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
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/builtin-stat.c     | 179
> > +++++++++++++++++++++++++++++++++-
> > >  tools/perf/util/data.c        |   4 +
> > >  tools/perf/util/data.h        |   1 +
> > >  tools/perf/util/metricgroup.h |   7 ++
> > >  tools/perf/util/stat.h        |   3 +
> > >  5 files changed, 191 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 5a3093541cff..3890a579349e 100644
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
> > > @@ -162,7 +167,8 @@ static struct perf_stat_config stat_config =3D {
> > >         .ctl_fd                 =3D -1,
> > >         .ctl_fd_ack             =3D -1,
> > >         .iostat_run             =3D false,
> > > -       .tpebs_event_size =3D 0,
> > > +       .tpebs_event_size       =3D 0,
> > > +       .tpebs_pid              =3D -1,
> > >  };
> > >
> > >  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> > > @@ -687,12 +693,163 @@ static enum counter_recovery
> > stat_handle_error(struct evsel *counter)
> > >         return COUNTER_FATAL;
> > >  }
> > >
> > > -static int __run_perf_record(void)
> > > +static int __run_perf_record(const char **record_argv)
> > >  {
> > > +       int i =3D 0;
> > > +       struct tpebs_event *e;
> >
> > Please put a blank line after the declaration.
> >
> >
> > >         pr_debug("Prepare perf record for retire_latency\n");
> > > +
> > > +
> >
> > A duplicate new line.
> >
> > > +       record_argv[i++] =3D "perf";
> > > +       record_argv[i++] =3D "record";
> > > +       record_argv[i++] =3D "-W";
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
> > > +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> > > +               record_argv[i++] =3D "-e";
> > > +               record_argv[i++] =3D e->name;
> > > +       }
> > > +
> > > +       record_argv[i++] =3D "-o";
> > > +       record_argv[i++] =3D PERF_DATA;
> >
> > I don't think you need side-band records and synthesizing for this.
> > I'd like to disable all of them but it'd require changes in perf record=
.
> > For now, you need to pass --synth=3Dno at least.
> >
> > Thanks,
> > Namhyung
> >
>
> Thanks Namhyung! I will update the code and send a new version.

Sure, let me finish my review before then.

Thanks,
Namhyung

