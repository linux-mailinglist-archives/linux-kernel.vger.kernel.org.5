Return-Path: <linux-kernel+bounces-1468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE8814F36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAF41F218E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49973E49F;
	Fri, 15 Dec 2023 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLtWMrtl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D904644A;
	Fri, 15 Dec 2023 17:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E7C433C8;
	Fri, 15 Dec 2023 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702662557;
	bh=+Ep5e1H59jFa0yRaMrGEHbeluIJ1lWpMHvMsd/izxKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLtWMrtlNqv4BvN5zLDprh7kls92+HXbFjEaHGy9ehZ05DmFTXcpYVw7lHwdK/H/J
	 /tt5xo3wiTRj6ToeQITNFCEOlOrY5q3jTuAXZEL4Q1dedG8bgj6k379WKQh+7jwQZA
	 AP/uayvCjdy0LpTufze0+ocEXauRUhUQoisutfund9/gXdfvDY9kqA7yLV27UnDQ4Q
	 M1MqFbVDEMrO+7O7StyAtyYGxpl55QoHp/UHqFHq2jItDfCP1mL5ilA0rU2yQjPeOl
	 P/P8zMbNFTU3ahRWScdTSkL+WN22mviodKfxybKl1HbNH5VArwIiBSlwBGzZ+pq+3o
	 sQgw6xv/o4Zdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 705E2403EF; Fri, 15 Dec 2023 14:49:14 -0300 (-03)
Date: Fri, 15 Dec 2023 14:49:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXyRmpyzNGd3gKwV@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
 <ZXyEJYXVNn2i06ro@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXyEJYXVNn2i06ro@FVFF77S0Q05N>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 15, 2023 at 04:51:49PM +0000, Mark Rutland escreveu:
> On Fri, Dec 15, 2023 at 12:36:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 12, 2023 at 06:31:05PM +0000, Mark Rutland escreveu:
> > > On ARM it'll be essentially the same as on x86: if you open an event with
> > > type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
> > > specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
> > > happens to be found by perf_init_event() when iterating over the 'pmus' list.

> > > If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
> > > will opened on the appropriate CPU PMU, by virtue of being rejected by others
> > > when perf_init_event() iterates over the 'pmus' list.

> > The way that it is working non on my intel hybrid system, with Kan's
> > patch, is equivalent to using this on the RK3399pc board I have:

> > root@roc-rk3399-pc:~# perf top -e armv8_cortex_a72/cycles/P,armv8_cortex_a53/cycles/P

> > Wouldn't be better to make 'perf top' on ARM work the way is being done
> > in x86 now, i.e. default to opening the two events, one per PMU and
> > allow the user to switch back and forth using the TUI/stdio?
 
> TBH, for perf top I don't know *which* behaviour is preferable, but I agree
> that it'd be good for x86 and arm to work in the same way.

Right, reducing the difference in the user experience accross arches.
 
> For design-cleanliness and consistency with other commands I can see that
> opening those separately is probably for the best, but for typical usage of
> perf top it's really nice to have those presented together without having to
> tab back-and-forth between the distinct PMUs, and so the existing behaviour of

Humm, so you would want two histogram viewers, one for each PMU, side by
side?

> using CPU-bound PERF_EVENT_TYPE_HARDWARE events is arguably nicer for the user.

So, on ARM64, start the following 'perf trace' session, then run the
stock 'perf top':

root@roc-rk3399-pc:~# perf trace -e perf_event_open
<SNIP calls doing capability queries and setting up sideband stuff>
   535.764 ( 0.015 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, group_fd: -1, flags: FD_CLOEXEC) = 19
   535.783 ( 0.067 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 28
   535.854 ( 0.063 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, cpu: 2, group_fd: -1, flags: FD_CLOEXEC) = 29
   535.920 ( 0.015 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, cpu: 3, group_fd: -1, flags: FD_CLOEXEC) = 30
   535.939 ( 0.016 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, cpu: 4, group_fd: -1, flags: FD_CLOEXEC) = 31
   535.959 ( 0.011 ms): perf/15627 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1 }, pid: -1, cpu: 5, group_fd: -1, flags: FD_CLOEXEC) = 32

root@roc-rk3399-pc:~# grep "CPU part" /proc/cpuinfo  | uniq -c
      4 CPU part	: 0xd03
      2 CPU part	: 0xd08
root@roc-rk3399-pc:~#

It is already doing what you suggest, right? PERF_TYPE_HARDWARE, one
counter per CPU, maps to armv8_cortex_a72/cycles/P and
armv8_cortex_a53/cycles/P.

One thing I'm thinking is that we should split this per PMU at the
hist_entry, so that we could show how many samples/events came from each
of them...

- Arnaldo
 
> I don't have a strong feeling either way; I'm personally happy so long as
> explicit pmu_name/event/ events don't get silently converted into
> PERF_EVENT_TYPE_HARDWARE events, and as long as we correctly set the extended
> HW type when we decide to use that.
> 
> Thanks,
> Mark.
> 
> > Kan, I also noticed that the name of the event is:
> > 
> > 1K cpu_atom/cycles:P/                                                                                                                                                                         ◆
> > 11K cpu_core/cycles:P/
> > 
> > If I try to use that on the command line:
> > 
> > root@number:~# perf top -e cpu_atom/cycles:P/
> > event syntax error: 'cpu_atom/cycles:P/'
> >                               \___ Bad event or PMU
> > 
> > Unable to find PMU or event on a PMU of 'cpu_atom'
> > 
> > Initial error:
> > event syntax error: 'cpu_atom/cycles:P/'
> >                               \___ unknown term 'cycles:P' for pmu 'cpu_atom'
> > 
> > valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
> > Run 'perf list' for a list of valid events
> > 
> >  Usage: perf top [<options>]
> > 
> >     -e, --event <event>   event selector. use 'perf list' to list available events
> > root@number:~#
> > 
> > It should be:
> > 
> >   "cpu_atom/cycles/P"

