Return-Path: <linux-kernel+bounces-7209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4981A336
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B6E1F25D02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779541874;
	Wed, 20 Dec 2023 15:54:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8041862;
	Wed, 20 Dec 2023 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA68A1FB;
	Wed, 20 Dec 2023 07:54:53 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DEF3F64C;
	Wed, 20 Dec 2023 07:54:06 -0800 (PST)
Message-ID: <0bbbcdb5-41eb-dd07-660a-2e5e4a0d59f0@arm.com>
Date: Wed, 20 Dec 2023 15:54:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 1/4] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20231208172449.35444-1-adrian.hunter@intel.com>
 <20231208172449.35444-2-adrian.hunter@intel.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231208172449.35444-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/12/2023 17:24, Adrian Hunter wrote:
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> Add ability for an event to "pause" or "resume" AUX area tracing.
> 
> Add aux_pause bit to perf_event_attr to indicate that, if the event
> happens, the associated AUX area tracing should be paused. Ditto
> aux_resume. Do not allow aux_pause and aux_resume to be set together.
> 
> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
> event that it should start in a "paused" state.
> 
> Add aux_paused to struct perf_event for AUX area events to keep track of
> the "paused" state. aux_paused is initialized to aux_start_paused.
> 
> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
> callbacks. Call as needed, during __perf_event_output(). Add
> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
> handler. Pause/resume in NMI context will miss out if it coincides with
> another pause/resume.
> 
> To use aux_pause or aux_resume, an event must be in a group with the AUX
> area event as the group leader.
> 
> Example (requires Intel PT and tools patches also):
> 
>  $ perf record --kcore -e '{intel_pt/aux-start-paused/k,syscalls:sys_enter_newuname/aux-resume/,syscalls:sys_exit_newuname/aux-pause/}' uname

I think it might be useful to have an aux-toggle option as well, and
then you could do sampling if you put it on a PMU counter with an
interval. Unless you can make two events for the same counter with
different intervals, and one does resume and the other does pause? I'm
not sure if that would work?

Other than that it looks ok. I got Coresight working with a couple of
changes to what you posted on here, but that can always be done more
thoroughly later if we leave PERF_PMU_CAP_AUX_PAUSE off Coresight for now.

Thanks
James

