Return-Path: <linux-kernel+bounces-4732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63281814F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DFE1F230F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21052747E;
	Tue, 19 Dec 2023 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFhhsSqL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA76FAE;
	Tue, 19 Dec 2023 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702965944; x=1734501944;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=B9VaDMUrCEz6mgrMx63+aVJwvbSy2QKfCuC4u1wqq24=;
  b=MFhhsSqLCzJK6mAN/A+WzpuTVlxptkHoRPvtDQNthd2sTAlUyPpV7/xB
   bIKDRgmfsvLahWcjNxG4p+jNhxCsecNJBMyUf6UQUduC15qWPc/Hze/Gh
   2PPn2ylaTnDxedCPNpmqQLeEgjLFtOahtJAA7X2B9a0usiiqTncw/tndr
   KcThUvZAl6mFd/uqo4PPARaOQJv2GGDgyxtUchDRIjh2pocNZUxNCtlYU
   5M0U6/pPGv75cJLYEj+nDViyDmGT1oskrj6AprkMNCkL0kHC7lsLOvFIV
   h9gdrUFxDfzs381Uty3YxIaCATBATMY98SO2z1MZ+xSe1HnKaS2piSejJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459953189"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459953189"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="17478195"
Received: from opipikin-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.174])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:05:39 -0800
Message-ID: <ebf302c5-edd8-451d-b9fa-69733b354fab@intel.com>
Date: Tue, 19 Dec 2023 08:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V2 0/4] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, James Clark <james.clark@arm.com>
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
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231208172449.35444-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/23 19:24, Adrian Hunter wrote:
> Hi
> 
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> These patches add such a facilty and show how it would work for Intel
> Processor Trace.
> 
> Maintainers of other AUX area tracing implementations are requested to
> consider if this is something they might employ and then whether or not
> the ABI would work for them.
> 
> Changes to perf tools are not fleshed out yet.
> 
> 
> Changes in RFC V2:
> 
>       Use ->stop() / ->start() instead of ->pause_resume()
>       Move aux_start_paused bit into aux_output_cfg
>       Tighten up when Intel PT pause / resume is allowed
>       Add an example of how it might work for CoreSight

Any comments?

> 
> 
> Adrian Hunter (4):
>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>       perf/x86/intel/pt: Add support for pause / resume
>       perf tools: Add support for AUX area pause / resume
>       coresight: Have a stab at support for pause / resume
> 
>  arch/x86/events/intel/pt.c                       | 63 ++++++++++++++++++++-
>  arch/x86/events/intel/pt.h                       |  4 ++
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 29 ++++++++--
>  include/linux/perf_event.h                       | 15 +++++
>  include/uapi/linux/perf_event.h                  | 11 +++-
>  kernel/events/core.c                             | 72 +++++++++++++++++++++++-
>  kernel/events/internal.h                         |  1 +
>  tools/include/uapi/linux/perf_event.h            | 11 +++-
>  tools/perf/util/auxtrace.c                       |  4 ++
>  tools/perf/util/evsel.c                          |  9 +++
>  tools/perf/util/evsel_config.h                   |  6 ++
>  tools/perf/util/parse-events.c                   | 33 +++++++++++
>  tools/perf/util/parse-events.h                   |  3 +
>  tools/perf/util/parse-events.l                   |  3 +
>  tools/perf/util/perf_event_attr_fprintf.c        |  3 +
>  15 files changed, 255 insertions(+), 12 deletions(-)
> 
> 
> Regards
> Adrian


