Return-Path: <linux-kernel+bounces-151595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA418AB0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3082E283B62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2B12EBE9;
	Fri, 19 Apr 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkD10Zur"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9F12D748
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537672; cv=none; b=hFfLfVssR0MFs6VQhQjhLnLWAp3E+kpByLRtVR1K9TTCjngmOUrnHfln8ZhXeKq69VqAAKejxfw4wXFpj629bnrdzV5mNie3OpD6Sbr/qRjalToKNMCsWTrn1nAq5XowU3CKDtQtjmslqO4plD8O2LjcqLlZksFKgPzXTfgYsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537672; c=relaxed/simple;
	bh=0ZVcZLmguVwwsrcLmuRwvIm+QXIMZti0ZQqnj8tsLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo2qTIJ7L9kgUj25Zn3kIWcz4u4S0ktokghpMDmEW4hmX9nvnH3xzsloq1QTmKdQUSGQTHwa/B9Thp1xeWJhZEa1Z1RyFbWuo8NIKUPp0n920RprBwPKWhFWooEaGsl1bP3ufwSrR5qiqgBf7hfijSaNoja97t+p65SpY0WKUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkD10Zur; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4348110e888so275241cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713537669; x=1714142469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+5NRO0keNj748cHc56gDHYVamniP4PzKmCJTJlGNYs=;
        b=gkD10ZurYRHwHpNEl8H0WGsWTYrvzO+LMg2bcVPoJ3Mws1nFfuvHlrDjA+tV6gD93N
         SgRrol4fUcbbkFMhKqFOdFwQh3LCKXk0mVpv9tku4qzDaJ8VRlrzIc/fmpDSG2xNyxrA
         Tl09P1S2/JyJJ8ZFeG7Aqr0FbRUEKDNvussTMzs7JRa+ZTk2qxyDLS3IcKBB4Scls+6Z
         tIwgbbXBnk8F2onUpns0UQq5jmx3ybb63e92j5Z1zCdeNxozfNFurDirBsgdBeeBlArh
         7KJQwG2TFjmhkdQN1DHIL2Vh/la0oj8H0FVOQ4ZpL97a08LVbRrswBtRwuJkAUxJQddt
         aOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537669; x=1714142469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+5NRO0keNj748cHc56gDHYVamniP4PzKmCJTJlGNYs=;
        b=k/Jicy0vyCeYn4wgqzAoGc1oKTLE2HPYPV84/IYJWv0QtsQF1vd5YSFdam1mUn55R1
         kdGQtqM8bpLe9g6swk3bg33nlcXNzj0p73FHTfO/Zc41JXUoFGxZ0ovW/rdOeVGh9UIf
         hfPLpwTIBKFKQyuDd1+T2TehrXgf1Esr+NyAdInbNPhUyD5X6Su0TXYU5IrYgMOb9L0E
         3AO8J1uXoB1eq96560XA7vzBcCxN4EKPggjnQJyGA4ZquH430dgCNMpNf65d+RRO5ARv
         V03SUkAcZxG+d77OinKjssWPZ9gQfYAlhB+FHsoL4RKNKnY02iakCaGt0Zi/zHJb5ank
         Id1g==
X-Forwarded-Encrypted: i=1; AJvYcCXhhqEcXagr/kOwXiK6D5ETJW7NdZh/XDswLxNNRt6iFzHXrgmzFyh4USKP+xLDbhnxxDowUbLrxieVjuvnFMQ8pMsyTUmZCrhcuWNp
X-Gm-Message-State: AOJu0YwWtvxKlQqM2zUyXpcSnHZaKqgQ5qgaMql3Nb9nU5J0f7WfCR5X
	ry/1E4kisXGbqFq3gRs73w6CnaX1bUmE1m37wavGveCmx/FTTDZgCX/TLdd/ILco2xkQi4/wAqe
	a3GDwdGodWsl56CPYy4uPffSYTSaNLnk6L3C/
X-Google-Smtp-Source: AGHT+IG4ZTggbnV0lF4zBdKYEyF+UCmLg/6TvY1ySQga5KDtXBVFH7NUVRJx3yKiVucvcOqTKDvdEKNsOGI97DzTjXE=
X-Received: by 2002:a05:622a:52:b0:437:9875:9671 with SMTP id
 y18-20020a05622a005200b0043798759671mr319114qtw.0.1713537669042; Fri, 19 Apr
 2024 07:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417183219.1208493-1-irogers@google.com> <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
In-Reply-To: <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Apr 2024 07:40:54 -0700
Message-ID: <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output test
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:54=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
> > Hard coded metric names fail on ARM testing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat+std_output.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tes=
ts/shell/stat+std_output.sh
> > index cbf2894b2c84..845f83213855 100755
> > --- a/tools/perf/tests/shell/stat+std_output.sh
> > +++ b/tools/perf/tests/shell/stat+std_output.sh
> > @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.s=
td.XXXXX)
> >
> >  event_name=3D(cpu-clock task-clock context-switches cpu-migrations pag=
e-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions=
 branches branch-misses)
> >  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "=
frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "=
of all branches")
> > -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_b=
ound" "bad_speculation" "backend_bound")
> > +skip_metric=3D($(perf list --raw Default 2> /dev/null))
>
>
> The "perf list --raw Default" only gives the topdown metrics.
> The "stalled cycles per insn" is not covered.
> The check should skip the line of "stalled cycles per insn" as well.
>
>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles i=
dle
>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycles i=
dle
>      2,603,501,247 instructions              #    0.50  insns per cycle
>                                              #    1.48  stalled cycles
> per insn
>        484,357,498 branches                  #  283.455 M/sec
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/builtin-stat.c#n24
>
> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
> seems power and older x86 CPU have the events.

Oh, sigh. This test should really ignore lines like that. How much do
we care about these metrics? The RISC-V event parsing change:
https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/
means that legacy hardware events will be uncommon and we need to
adapt the hard coded metrics in stat-shadow.c to json ones. Once they
are json metrics they will be in Default.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> >  cleanup() {
> >    rm -f "${stat_output}"

