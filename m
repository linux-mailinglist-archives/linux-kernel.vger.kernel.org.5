Return-Path: <linux-kernel+bounces-17200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B028249AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63C5287A52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8A1E516;
	Thu,  4 Jan 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+LLXUal"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579941DFE4;
	Thu,  4 Jan 2024 20:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D7C433C8;
	Thu,  4 Jan 2024 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704400628;
	bh=a8xLbo0tsyN6zjcgxC/0/SukCsLZkJhe7HQ4vjjIj2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+LLXUalTxg51OR6CgQ+OA7VuIbQPbWTCc8BgxbZz03exQkyongzikz0jHbynTvzS
	 SRXlhmhDPHapReMyZxcKM5sgMpVii48tSu+V8OM6PQcqjCv/ASEkeEkVWhh+/lV5be
	 kPGq8kM/7+JwYpuBULvkv1HLy2AimNPtWkZH9643+enoT3bl1I+JWBkcIifG3Eeh77
	 z1VPnDJkQjOfCAke1LudFp8k/WUeR4fAkwgaBQWB5zOqPPPLBPiTCICuV2G+v8Yfvd
	 lm/+FUM49tH+4zTfI8UxPYAjdgBRLhZigoXXtqBsN9rI/v7YZ6rZOpodP7J0E2aaMF
	 wKUBRNSHwJ7dg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 012E4403EF; Thu,  4 Jan 2024 17:37:05 -0300 (-03)
Date: Thu, 4 Jan 2024 17:37:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
Message-ID: <ZZcW8Zk02wPbpXJI@kernel.org>
References: <20240104074259.653219-1-irogers@google.com>
 <ZZam-EG-UepcXtWw@kernel.org>
 <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Jan 04, 2024 at 05:56:22AM -0800, Ian Rogers escreveu:
> On Thu, Jan 4, 2024 at 4:39 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Jan 03, 2024 at 11:42:56PM -0800, Ian Rogers escreveu:
> > > Fix that the core PMU is being specified for 2 uncore events. Specify
> > > a PMU for the alderlake UNCORE_FREQ metric.
<SNIP>
> > 101: perf all metricgroups test                                      : Ok
> > 102: perf all metrics test                                           : FAILED!
> > 107: perf metrics value validation                                   : Ok

> > 102 is now failing due to some other problem:

> > root@number:~# perf test -v 102
> > 102: perf all metrics test                                           :
> > --- start ---
> > test child forked, pid 2701034
> > Testing tma_core_bound
> > Testing tma_info_core_ilp
<SNIP>
> > Testing tma_memory_fence
> > Metric 'tma_memory_fence' not printed in:
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 49.458 usec (+- 0.033 usec)
> >   Average num. events: 47.000 (+- 0.000)
> >   Average time per event 1.052 usec
> >   Average data synthesis took: 53.268 usec (+- 0.027 usec)
> >   Average num. events: 244.000 (+- 0.000)
> >   Average time per event 0.218 usec

> >  Performance counter stats for 'perf bench internals synthesize':

> >      <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
> >      <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
> >      <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
> >      <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
> >      <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
> >      <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
> >      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
> >      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
> >      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
> >      <not counted>      cpu_core/MISC2_RETIRED.LFENCE/                                          (0.00%)
> >      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
> >      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
> >      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
> >      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
> >      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

> >        1.177929044 seconds time elapsed

> >        0.434552000 seconds user
> >        0.736874000 seconds sys
> > Testing tma_port_1
<SNIP>
> > test child finished with -1
> > ---- end ----
> > perf all metrics test: FAILED!
> > root@number:~#

> Have a try disabling the NMI watchdog. Agreed that there is more to

Did the trick, added this to the cset log message:

--------------------------------------- 8< ----------------------------
Test 102 is failing for another reason, not being able to get as many
counters as needed, Ian Rogers suggested disabling the NMI watchdog to
have more counters available:

  root@number:/home/acme# cat /proc/sys/kernel/nmi_watchdog
  1
  root@number:/home/acme# echo 0 > /proc/sys/kernel/nmi_watchdog
  root@number:/home/acme# perf test 102
  102: perf all metrics test                                           : Ok
  root@number:/home/acme#
--------------------------------------- 8< ----------------------------

- Arnaldo

> fix here but I think the PMU driver is in part to blame because
> manually breaking the weak group of events is a fix. Fwiw, if we
> switch to the buddy watchdog mechanism then we'll no longer need to
> disable the NMI watchdog:
> https://lore.kernel.org/lkml/20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid/

