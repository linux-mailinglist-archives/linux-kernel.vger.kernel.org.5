Return-Path: <linux-kernel+bounces-151662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A192C8AB1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BD11F22A68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC512F58B;
	Fri, 19 Apr 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mgVGwByA"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFC12AAF4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540218; cv=none; b=eCoirKSZSV/8dVqzG2UslbBuIsBzOQ1inpxBmmsY368X2svFMSLgbmdCc/W8OxO0fdj2zaOaF8L7tUuMpGdWcwO4fgIL4tGII7inSBHnNyGha2Zs3I2Q6teh9GbEOtas0CAmkmwf95vppwevVX6t8n9r6/vUsASQaNGsDqz5hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540218; c=relaxed/simple;
	bh=GIAimIXdqLxzYbNegjt+SwqQglE9A8ZOB26zfIsr6Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwHejLtKWBcrcbpn3/wAGC6psmC8Vw1NIa80mmRSZoz2xvp101eStSUo+Y5hN8GquTH0KyPcSCSX/CHT5mnk4J95YkwxvWZW8+DBlY4WetaTJsg4pSgIaXzuimfchNfM3k2ALzSQh0nnQiLYthQXa5pmeh4mKg+6d1Qh19d0tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgVGwByA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-434b5abbb0dso309881cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713540215; x=1714145015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqqvqqU0RLWeLV5OEenfyC9RG8V0cWxiI7JG1ryx5y8=;
        b=mgVGwByAG9L0RHayyUke4i9TfmRRTlBFMjFzWGP50n+7rgPIF9PGA80LMfKyogBzbR
         tYKJZI1M5BRchedttEFxdQjNk86O9VcQeQaSd8wEU0zke/3qpSyjmr+HHPtzthoU8TC7
         yir/FnZosz/aWUoHijNzkq3rrhahR7FngYxvFDvMmO4uKeZ81wSsr4T0fB7nkes3GsVf
         6ETZlITZxvym/D8sCwrfo4C+sTieBDS8Lqs28D43+dbU3/TBmrSgipocCp92HiUN2BC/
         DhnepNF8lcbJ4QU45IYaONTQtbFQZTz9AeFL38BP2HkOEQiQyaqJLwnS2o/XWsWCy3DQ
         TirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540215; x=1714145015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqqvqqU0RLWeLV5OEenfyC9RG8V0cWxiI7JG1ryx5y8=;
        b=rsZu4aDCLqjGB0rfkU9dWUaFVpunUp6yF8VsV/fx7ttDlIt68zVOScFbw+sYGEXkZC
         nUivNu0fcqnqRsJSmjrXfkdEcnhB1T0sObchVCuPUKjkCWG3yNdkBmQ0yhm6HnCPsf/6
         N83agSLDD1cRnlmLuFJXbFdHZontVOucqqEHYtcQRpeTmSNCB/9z1kWvTfXySYovirv7
         ug5lzKUtflarPzTcuQ//CNZUvB4YbqSEjrl0DZCI8hnNShNiu8CEoeZoW0zT1H5cZY0h
         i3JW2atMWOHtHFQUP+vvbAhwetshnbtdx7xOm/TytMhiRIbdI481nR5UBxegDKWLwp2I
         IsdA==
X-Forwarded-Encrypted: i=1; AJvYcCV14qaEsJWeTg9myjApD+FpScEEmxctavzl2a1QgEvfquJaQB3Crqo3G+Tim2xlLgl2Br80B2wdV+sivPwSxZ2lGA1I4Q31oGo5AtB5
X-Gm-Message-State: AOJu0YzKjPKXIdPYiCFcHm8S0mpp4OOWlV3JFzP8Un6tT3nn8g00YUXK
	R7ZmSak2n3bjTpuawVPKjSiZifrDGJFnNM4phPyiia4Xb6A0w8vPcLqfC/AuRT+BPg9Lyc3ciyI
	xJsHkXolbjTjENEglqqP7eC5+wbrNF6oCUatn
X-Google-Smtp-Source: AGHT+IEx/0aFlucL09+ooXR2fa2x36BqtRpTp/YtvG1FZYkQ0FXIjdBQPiW8SMC2zY2Fr8KdF2XJZxb0Db7uroLI51U=
X-Received: by 2002:a05:622a:188f:b0:437:a00d:62ca with SMTP id
 v15-20020a05622a188f00b00437a00d62camr268383qtc.7.1713540215414; Fri, 19 Apr
 2024 08:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417183219.1208493-1-irogers@google.com> <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
 <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com> <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
In-Reply-To: <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Apr 2024 08:23:22 -0700
Message-ID: <CAP-5=fV-mGX7QXT4G=VyzWjL5_AJuZ_69aj6JYbV8NVhuy-8TA@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 8:09=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-19 10:40 a.m., Ian Rogers wrote:
> > On Fri, Apr 19, 2024 at 6:54=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
> >>> Hard coded metric names fail on ARM testing.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/t=
ests/shell/stat+std_output.sh
> >>> index cbf2894b2c84..845f83213855 100755
> >>> --- a/tools/perf/tests/shell/stat+std_output.sh
> >>> +++ b/tools/perf/tests/shell/stat+std_output.sh
> >>> @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output=
std.XXXXX)
> >>>
> >>>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations p=
age-faults stalled-cycles-frontend stalled-cycles-backend cycles instructio=
ns branches branch-misses)
> >>>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec"=
 "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec"=
 "of all branches")
> >>> -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend=
_bound" "bad_speculation" "backend_bound")
> >>> +skip_metric=3D($(perf list --raw Default 2> /dev/null))
> >>
> >>
> >> The "perf list --raw Default" only gives the topdown metrics.
> >> The "stalled cycles per insn" is not covered.
> >> The check should skip the line of "stalled cycles per insn" as well.
> >>
> >>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycle=
s idle
> >>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycle=
s idle
> >>      2,603,501,247 instructions              #    0.50  insns per cycl=
e
> >>                                              #    1.48  stalled cycles
> >> per insn
> >>        484,357,498 branches                  #  283.455 M/sec
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/tools/perf/builtin-stat.c#n24
> >>
> >> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
> >> seems power and older x86 CPU have the events.
> >
> > Oh, sigh. This test should really ignore lines like that. How much do
> > we care about these metrics? The RISC-V event parsing change:
> > https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com=
/
> > means that legacy hardware events will be uncommon and we need to
> > adapt the hard coded metrics in stat-shadow.c to json ones. Once they
> > are json metrics they will be in Default.
>
> It seems except the newer Intel CPU, all the other ARCHs support the two
> stalled-cycles-* events and the metric. For Intel, there are Topdown
> metrics. But it seems an important metrics for the other ARCHs.
>
> RISC-V
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/perf/riscv_pmu_sbi.c#n134
> Power
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/perf/power9-pmu.c#n279
> Arm
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/perf/arm_pmuv3.c#n53
>
> So almost all json files have to be updated. I'm not sure if it's a
> practical way to fix the issue.

So I'd very much like to get rid of the hard coded metrics:
 - they don't use or respect event groups,
 - their ad hoc printing can introduce extra metric results
unexpectedly in output,
 - they fall outside of optimizations like Weilin's metric event grouping w=
ork.
I'm hoping the python json generation of metrics makes their removal practi=
cal:
https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/

That's a lot to get landed for this fix:
 - 40+ patches for python based json generation.
 - 10+ patches for parse events changes.
So I think a version that hard codes ignoring the hard coded metrics
is in order.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>>
> >>>  cleanup() {
> >>>    rm -f "${stat_output}"
> >

