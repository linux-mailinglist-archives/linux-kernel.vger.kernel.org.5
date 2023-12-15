Return-Path: <linux-kernel+bounces-1332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77F814D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD11C211A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052353EA62;
	Fri, 15 Dec 2023 16:51:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7B3DB90;
	Fri, 15 Dec 2023 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C83A5C15;
	Fri, 15 Dec 2023 08:52:38 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EBB3F5A1;
	Fri, 15 Dec 2023 08:51:52 -0800 (PST)
Date: Fri, 15 Dec 2023 16:51:49 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXyEJYXVNn2i06ro@FVFF77S0Q05N>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXxyanyZgWBTOnoK@kernel.org>

On Fri, Dec 15, 2023 at 12:36:10PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 12, 2023 at 06:31:05PM +0000, Mark Rutland escreveu:
> > On ARM it'll be essentially the same as on x86: if you open an event with
> > type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
> > specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
> > happens to be found by perf_init_event() when iterating over the 'pmus' list.
>  
> > If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
> > will opened on the appropriate CPU PMU, by virtue of being rejected by others
> > when perf_init_event() iterates over the 'pmus' list.
> 
> The way that it is working non on my intel hybrid system, with Kan's
> patch, is equivalent to using this on the RK3399pc board I have:
> 
> root@roc-rk3399-pc:~# perf top -e armv8_cortex_a72/cycles/P,armv8_cortex_a53/cycles/P
> 
> Wouldn't be better to make 'perf top' on ARM work the way is being done
> in x86 now, i.e. default to opening the two events, one per PMU and
> allow the user to switch back and forth using the TUI/stdio?

TBH, for perf top I don't know *which* behaviour is preferable, but I agree
that it'd be good for x86 and arm to work in the same way.

For design-cleanliness and consistency with other commands I can see that
opening those separately is probably for the best, but for typical usage of
perf top it's really nice to have those presented together without having to
tab back-and-forth between the distinct PMUs, and so the existing behaviour of
using CPU-bound PERF_EVENT_TYPE_HARDWARE events is arguably nicer for the user.

I don't have a strong feeling either way; I'm personally happy so long as
explicit pmu_name/event/ events don't get silently converted into
PERF_EVENT_TYPE_HARDWARE events, and as long as we correctly set the extended
HW type when we decide to use that.

Thanks,
Mark.

> Kan, I also noticed that the name of the event is:
> 
> 1K cpu_atom/cycles:P/                                                                                                                                                                         ◆
> 11K cpu_core/cycles:P/
> 
> If I try to use that on the command line:
> 
> root@number:~# perf top -e cpu_atom/cycles:P/
> event syntax error: 'cpu_atom/cycles:P/'
>                               \___ Bad event or PMU
> 
> Unable to find PMU or event on a PMU of 'cpu_atom'
> 
> Initial error:
> event syntax error: 'cpu_atom/cycles:P/'
>                               \___ unknown term 'cycles:P' for pmu 'cpu_atom'
> 
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
> Run 'perf list' for a list of valid events
> 
>  Usage: perf top [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> root@number:~#
> 
> It should be:
> 
>   "cpu_atom/cycles/P"
> 
> - Arnaldo

