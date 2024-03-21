Return-Path: <linux-kernel+bounces-110208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A53885B81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BEB261FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220738624F;
	Thu, 21 Mar 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9m6c5zt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B186243;
	Thu, 21 Mar 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034083; cv=none; b=si/9B6TyTgtQAHPhiqs4XS8HUSMafPKGpCsPAOJWBCNxwvih3dnEzH0CrBy1LXeIht2q2jGx/nb7y6FwFNZRBoY5+Rqn2kgzwpfODf4oQfvvCEq01u789D7t0D1AM/UvSiMExa1dh0W0/tZ42hzpjRQTDx2342RcqheYCY1fokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034083; c=relaxed/simple;
	bh=w+3kmnXuBBmZnST7KWFEOyUpE7C1jEIO1nIlPJtmAE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cekQy7kdqq5Z5PROK6VmhO0TeT6BWzh1h/K7awoFM1EG+asLvEStinSLPTUmXLQg4qhFPeMCKWat7K2f0uC10PJGH3CkrHWGAJ1dWezJLp+2aEjWCv15sCeMtrUR5pt1KjSiMJeh2uUy6uQlRFf3rcBlB1B1UQ/ZdqacdY8famM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9m6c5zt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711034081; x=1742570081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w+3kmnXuBBmZnST7KWFEOyUpE7C1jEIO1nIlPJtmAE0=;
  b=R9m6c5ztpWeH0kGwlUx8Mx+FmNPPLPHDEx7aKWBmmEszIO8vb4W2E5uI
   nz9zdQp36tTwTK1Eg39EW2ffgCcwHPMMND02/uksbIvIpETXdcW8A3vjy
   b6dm3KoeEdamM5gKndrLwsjsxc9/Xp1WFU5hLc19BMwWnbHkEZBQAGJdh
   93HfdB9QG6Xl2b4ZDJ5M1X6HS8BJDCN6SwjklsxGiMxTxd3lOHi2/q1V1
   M3I/J3e36Qw5Cul3rj50NC8ztAOFUCi0AeH1rqFk3Ud9tCLyc/cpIDszp
   IBiXD4xD7sYrlEAa78zF1DghTce7W/uFbALKDlspvMxfqnQMk8zsuHZKl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5973026"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5973026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14579721"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:14:39 -0700
Received: from [10.212.125.116] (kliang2-mobl1.ccr.corp.intel.com [10.212.125.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 39B89580C6E;
	Thu, 21 Mar 2024 08:14:37 -0700 (PDT)
Message-ID: <c1ade566-111a-46b2-81b7-c165890c84ce@linux.intel.com>
Date: Thu, 21 Mar 2024 11:14:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] perf vendor events intel update
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240321060016.1464787-1-irogers@google.com>
 <ZfxDX--WFVDlGad5@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZfxDX--WFVDlGad5@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-21 10:25 a.m., Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 11:00:04PM -0700, Ian Rogers wrote:
>> Update events to the latest on:
>> https://github.com/intel/perfmon
>>
>> Using the converter script:
>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> 
> Kan,
> 
> 	Can you please take a look and provide an Acked or Reviewed-by?
> 


Sure. The patch series look good to me. Thanks Ian!

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Thanks!
> 
> - Arnaldo
>  
>> Ian Rogers (12):
>>   perf vendor events intel: Update cascadelakex to 1.21
>>   perf vendor events intel: Update emeraldrapids to 1.06
>>   perf vendor events intel: Update grandridge to 1.02
>>   perf vendor events intel: Update icelakex to 1.24
>>   perf vendor events intel: Update lunarlake to 1.01
>>   perf vendor events intel: Update meteorlake to 1.08
>>   perf vendor events intel: Update sapphirerapids to 1.20
>>   perf vendor events intel: Update sierraforest to 1.02
>>   perf vendor events intel: Update skylakex to 1.33
>>   perf vendor events intel: Update skylake to v58
>>   perf vendor events intel: Update snowridgex to 1.22
>>   perf vendor events intel: Remove info metrics erroneously in TopdownL1
>>
>>  .../arch/x86/broadwellx/bdx-metrics.json      |  35 +++---
>>  .../arch/x86/cascadelakex/clx-metrics.json    |  85 +++++--------
>>  .../arch/x86/cascadelakex/frontend.json       |  10 +-
>>  .../arch/x86/cascadelakex/memory.json         |   2 +-
>>  .../arch/x86/cascadelakex/other.json          |   2 +-
>>  .../arch/x86/cascadelakex/pipeline.json       |   2 +-
>>  .../x86/cascadelakex/uncore-interconnect.json |  14 +--
>>  .../arch/x86/cascadelakex/virtual-memory.json |   2 +-
>>  .../arch/x86/emeraldrapids/frontend.json      |   2 +-
>>  .../arch/x86/emeraldrapids/memory.json        |   1 +
>>  .../arch/x86/emeraldrapids/pipeline.json      |   3 +
>>  .../arch/x86/emeraldrapids/uncore-cache.json  | 112 ++++++++++++++++-
>>  .../emeraldrapids/uncore-interconnect.json    |  26 ++--
>>  .../arch/x86/grandridge/pipeline.json         |  43 ++++++-
>>  .../arch/x86/grandridge/uncore-cache.json     |  28 ++++-
>>  .../arch/x86/haswellx/hsx-metrics.json        |  35 +++---
>>  .../arch/x86/icelakex/frontend.json           |   2 +-
>>  .../arch/x86/icelakex/icx-metrics.json        |  95 ++++++--------
>>  .../pmu-events/arch/x86/icelakex/memory.json  |   1 +
>>  .../arch/x86/icelakex/uncore-cache.json       |  22 +++-
>>  .../x86/icelakex/uncore-interconnect.json     |  64 +++++-----
>>  .../arch/x86/icelakex/uncore-io.json          |  11 --
>>  .../pmu-events/arch/x86/lunarlake/cache.json  |  24 ++--
>>  .../arch/x86/lunarlake/frontend.json          |   2 +-
>>  .../pmu-events/arch/x86/lunarlake/memory.json |   4 +-
>>  .../pmu-events/arch/x86/lunarlake/other.json  |   4 +-
>>  .../arch/x86/lunarlake/pipeline.json          | 109 +++++++++++++---
>>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  20 +--
>>  .../pmu-events/arch/x86/meteorlake/cache.json |  30 +++++
>>  .../arch/x86/meteorlake/frontend.json         |   4 +-
>>  .../arch/x86/meteorlake/memory.json           |  20 +++
>>  .../pmu-events/arch/x86/meteorlake/other.json |  42 ++++++-
>>  .../arch/x86/meteorlake/pipeline.json         |  44 +++++--
>>  .../x86/meteorlake/uncore-interconnect.json   |  22 +++-
>>  .../arch/x86/sapphirerapids/cache.json        |   1 +
>>  .../arch/x86/sapphirerapids/frontend.json     |   2 +-
>>  .../arch/x86/sapphirerapids/memory.json       |   1 +
>>  .../arch/x86/sapphirerapids/pipeline.json     |  19 +--
>>  .../arch/x86/sapphirerapids/spr-metrics.json  | 119 +++++++-----------
>>  .../arch/x86/sapphirerapids/uncore-cache.json | 112 ++++++++++++++++-
>>  .../sapphirerapids/uncore-interconnect.json   |  26 ++--
>>  .../arch/x86/sierraforest/pipeline.json       |  36 +++++-
>>  .../pmu-events/arch/x86/skylake/frontend.json |  10 +-
>>  .../pmu-events/arch/x86/skylakex/cache.json   |   9 ++
>>  .../arch/x86/skylakex/frontend.json           |  10 +-
>>  .../pmu-events/arch/x86/skylakex/memory.json  |   2 +-
>>  .../pmu-events/arch/x86/skylakex/other.json   |   2 +-
>>  .../arch/x86/skylakex/pipeline.json           |   2 +-
>>  .../arch/x86/skylakex/skx-metrics.json        |  85 +++++--------
>>  .../x86/skylakex/uncore-interconnect.json     |  14 +--
>>  .../arch/x86/skylakex/uncore-io.json          |   2 +-
>>  .../arch/x86/skylakex/virtual-memory.json     |   2 +-
>>  .../arch/x86/snowridgex/uncore-cache.json     |   4 +-
>>  .../x86/snowridgex/uncore-interconnect.json   |   6 +-
>>  .../arch/x86/snowridgex/uncore-io.json        |  11 --
>>  55 files changed, 911 insertions(+), 486 deletions(-)
>>
>> -- 
>> 2.44.0.396.g6e790dbe36-goog
>>
> 

