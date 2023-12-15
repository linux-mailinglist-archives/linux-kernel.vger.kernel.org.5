Return-Path: <linux-kernel+bounces-1219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDEE814BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F2B224EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A637163;
	Fri, 15 Dec 2023 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbvWMx9j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF62320F;
	Fri, 15 Dec 2023 15:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF33C433C8;
	Fri, 15 Dec 2023 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702654574;
	bh=QkGYnpI7VkJ6ZnApbfPGjqcENeC9oxa/+M+iQlRNTew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbvWMx9j+qVNefKJn+Tr/6Z/qq08iInLITOqy0GNB2BK7LRoYq/VbHLGCxWh34XOu
	 hHgO1q5YeGHFdHw3T9N8ra22CZbt7QVjrdax1BmOz6H+qRhexQWu1H6jBiVMOig5Dk
	 U0bARE8E1aunSOR3F6K4vdv1dYodmm164F//QhohX8VQlNKMfSDY8bNnnwQA//hp2l
	 I1NBq4qLGDXjnktrRtA5+UAxMAKO7UBa+iWKBdwjbRXDst33bPxtYR2yhuXfMvKIrb
	 0UenvZqev54cr74MWAghqpnjC2ZX+b1UWPPUh+GGQO2q187B7NZK0Mzbtlifb5mK1N
	 m5lVdS0QFzrdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B4F8A403EF; Fri, 15 Dec 2023 12:36:10 -0300 (-03)
Date: Fri, 15 Dec 2023 12:36:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXxyanyZgWBTOnoK@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 06:31:05PM +0000, Mark Rutland escreveu:
> On ARM it'll be essentially the same as on x86: if you open an event with
> type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
> specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
> happens to be found by perf_init_event() when iterating over the 'pmus' list.
 
> If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
> will opened on the appropriate CPU PMU, by virtue of being rejected by others
> when perf_init_event() iterates over the 'pmus' list.

The way that it is working non on my intel hybrid system, with Kan's
patch, is equivalent to using this on the RK3399pc board I have:

root@roc-rk3399-pc:~# perf top -e armv8_cortex_a72/cycles/P,armv8_cortex_a53/cycles/P

Wouldn't be better to make 'perf top' on ARM work the way is being done
in x86 now, i.e. default to opening the two events, one per PMU and
allow the user to switch back and forth using the TUI/stdio?

Kan, I also noticed that the name of the event is:

1K cpu_atom/cycles:P/                                                                                                                                                                         ◆
11K cpu_core/cycles:P/

If I try to use that on the command line:

root@number:~# perf top -e cpu_atom/cycles:P/
event syntax error: 'cpu_atom/cycles:P/'
                              \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu_atom'

Initial error:
event syntax error: 'cpu_atom/cycles:P/'
                              \___ unknown term 'cycles:P' for pmu 'cpu_atom'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
Run 'perf list' for a list of valid events

 Usage: perf top [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events
root@number:~#

It should be:

  "cpu_atom/cycles/P"

- Arnaldo

