Return-Path: <linux-kernel+bounces-47169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA813844A12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005BDB28759
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE739FFC;
	Wed, 31 Jan 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B03D72OS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CD3A1A0;
	Wed, 31 Jan 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736540; cv=none; b=AZoAia3SqDMZRmkntpGLbvPTy4z2hRM66g1uUH7kCxH9NEJiSScp6yWztd8MdhRwyu3F4oew2ppmW/Gb83yhZUE9kDToaBtO+fRxkbfp6miXcZ9jD8iI+JeJ/mvHctL2nJga0H+jwpFQ375lCDMmew+8245ubpDzPwWJsbiSFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736540; c=relaxed/simple;
	bh=Fbnr4fMRTDUr74wLHxRLBWWBfgC3oBjgHGw6GLDYTy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2sUp3Yp+mUQRxK/L5776ZWhbKKIzOnDnCBvHgZLFK5JUlU4mal9UH/4LF8rUgCt0Sp6XRL6Gin8E/aZ/TSNqzOS8D21zmd8xDM2hUwIJg7nSc+nNF2xieNWziOLdUeyvxkxhoBPuekIQ1AdWCTGx9rZs3+tkXK4EG9cQuBlgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B03D72OS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706736538; x=1738272538;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Fbnr4fMRTDUr74wLHxRLBWWBfgC3oBjgHGw6GLDYTy8=;
  b=B03D72OS52KWhI+jfFDaWR1Uxo5JSSj3Tmx2AzJi4ROTGaauVd1Y2KFZ
   zFOK7YonCrzYGNtMHnKSPUP8MmTprKZgcD+jSqNi90bFDI3UJ+jRNVx4V
   03C2ugivjM2SSspjLmIRhoF7znvZaaCAw8MrM90lAebYC65GuYd5c7htv
   +1oP96Upa3eYTMnERA/GUzRD2WeitwMosWugP9dbLMDrU0NFTchpGsQCy
   qeBzN9NJA2jqLQ3vRKp2lxIDTsYrox7gJs8BA56YqI2jJ1fiuN5sb48y1
   6ACFRhUeLFYs5vD5bCjT3G+XjfJuY7EdsWiOnuLdFbTY14oXG2frXTwnC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10831967"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10831967"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:28:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878904558"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878904558"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:28:56 -0800
Received: from [10.212.91.97] (kliang2-mobl1.ccr.corp.intel.com [10.212.91.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 510AE580201;
	Wed, 31 Jan 2024 13:28:54 -0800 (PST)
Message-ID: <c6302684-a8c6-4acc-9772-efbb2ea129c8@linux.intel.com>
Date: Wed, 31 Jan 2024 16:28:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf jevents: Drop or simplify small integer values
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kajol Jain <kjain@linux.ibm.com>, John Garry <john.g.garry@oracle.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>,
 Veronika Molnarova <vmolnaro@redhat.com>, Michael Petlan
 <mpetlan@redhat.com>, Edward Baker <edward.baker@intel.com>,
 Perry Taylor <perry.taylor@intel.com>
References: <20240131201429.792138-1-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240131201429.792138-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-31 3:14 p.m., Ian Rogers wrote:
> Prior to this patch '0' would be dropped as the config values default
> to 0. Some json values are hex and the string '0' wouldn't match '0x0'
> as zero. Add a more robust is_zero test to drop these event terms.
> 
> When encoding numbers as hex, if the number is between 0 and 9
> inclusive then don't add a 0x prefix.
> 
> Update test expectations for these changes.
> 
> On x86 this reduces the event/metric C string by 58,411 bytes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/pmu-events/jevents.py | 23 ++++++++++++++++++++---
>  tools/perf/tests/pmu-events.c    | 22 +++++++++++-----------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 53ab050c8fa4..2c7e5d61ce92 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -203,7 +203,7 @@ class JsonEvent:
>  
>      def llx(x: int) -> str:
>        """Convert an int to a string similar to a printf modifier of %#llx."""
> -      return '0' if x == 0 else hex(x)
> +      return str(x) if x >= 0 and x < 10 else hex(x)
>  
>      def fixdesc(s: str) -> str:
>        """Fix formatting issue for the desc string."""
> @@ -294,6 +294,23 @@ class JsonEvent:
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>  
> +    def is_zero(val: str) -> bool:
> +        try:
> +            if val.startswith('0x'):
> +                return int(val, 16) == 0
> +            else:
> +                return int(val) == 0
> +        except e:
> +            return False
> +
> +    def canonicalize_value(val: str) -> str:
> +        try:
> +            if val.startswith('0x'):
> +                return llx(int(val, 16))
> +            return str(int(val))
> +        except e:
> +            return val
> +
>      eventcode = 0
>      if 'EventCode' in jd:
>        eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
> @@ -358,8 +375,8 @@ class JsonEvent:
>          ('RdWrMask', 'rdwrmask='),
>      ]
>      for key, value in event_fields:
> -      if key in jd and jd[key] != '0':
> -        event += ',' + value + jd[key]
> +      if key in jd and not is_zero(jd[key]):
> +        event += f',{value}{canonicalize_value(jd[key])}'
>      if filter:
>        event += f',{filter}'
>      if msr:
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index a56d32905743..47a7c3277540 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -70,7 +70,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
>  	.event = {
>  		.pmu = "default_core",
>  		.name = "segment_reg_loads.any",
> -		.event = "event=0x6,period=200000,umask=0x80",
> +		.event = "event=6,period=200000,umask=0x80",
>  		.desc = "Number of segment register loads",
>  		.topic = "other",
>  	},
> @@ -82,7 +82,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
>  	.event = {
>  		.pmu = "default_core",
>  		.name = "dispatch_blocked.any",
> -		.event = "event=0x9,period=200000,umask=0x20",
> +		.event = "event=9,period=200000,umask=0x20",
>  		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
>  		.topic = "other",
>  	},
> @@ -94,11 +94,11 @@ static const struct perf_pmu_test_event eist_trans = {
>  	.event = {
>  		.pmu = "default_core",
>  		.name = "eist_trans",
> -		.event = "event=0x3a,period=200000,umask=0x0",
> +		.event = "event=0x3a,period=200000",
>  		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>  		.topic = "other",
>  	},
> -	.alias_str = "event=0x3a,period=0x30d40,umask=0",
> +	.alias_str = "event=0x3a,period=0x30d40",
>  	.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>  };
>  
> @@ -128,7 +128,7 @@ static const struct perf_pmu_test_event *core_events[] = {
>  static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
>  	.event = {
>  		.name = "uncore_hisi_ddrc.flux_wcmd",
> -		.event = "event=0x2",
> +		.event = "event=2",
>  		.desc = "DDRC write commands",
>  		.topic = "uncore",
>  		.long_desc = "DDRC write commands",
> @@ -156,13 +156,13 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
>  static const struct perf_pmu_test_event uncore_hyphen = {
>  	.event = {
>  		.name = "event-hyphen",
> -		.event = "event=0xe0,umask=0x00",
> +		.event = "event=0xe0",
>  		.desc = "UNC_CBO_HYPHEN",
>  		.topic = "uncore",
>  		.long_desc = "UNC_CBO_HYPHEN",
>  		.pmu = "uncore_cbox",
>  	},
> -	.alias_str = "event=0xe0,umask=0",
> +	.alias_str = "event=0xe0",
>  	.alias_long_desc = "UNC_CBO_HYPHEN",
>  	.matching_pmu = "uncore_cbox_0",
>  };
> @@ -170,13 +170,13 @@ static const struct perf_pmu_test_event uncore_hyphen = {
>  static const struct perf_pmu_test_event uncore_two_hyph = {
>  	.event = {
>  		.name = "event-two-hyph",
> -		.event = "event=0xc0,umask=0x00",
> +		.event = "event=0xc0",
>  		.desc = "UNC_CBO_TWO_HYPH",
>  		.topic = "uncore",
>  		.long_desc = "UNC_CBO_TWO_HYPH",
>  		.pmu = "uncore_cbox",
>  	},
> -	.alias_str = "event=0xc0,umask=0",
> +	.alias_str = "event=0xc0",
>  	.alias_long_desc = "UNC_CBO_TWO_HYPH",
>  	.matching_pmu = "uncore_cbox_0",
>  };
> @@ -184,7 +184,7 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
>  static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
>  	.event = {
>  		.name = "uncore_hisi_l3c.rd_hit_cpipe",
> -		.event = "event=0x7",
> +		.event = "event=7",
>  		.desc = "Total read hits",
>  		.topic = "uncore",
>  		.long_desc = "Total read hits",
> @@ -265,7 +265,7 @@ static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
>  static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
>  	.event = {
>  		.name = "sys_cmn_pmu.hnf_cache_miss",
> -		.event = "eventid=0x1,type=0x5",
> +		.event = "eventid=1,type=5",
>  		.desc = "Counts total cache misses in first lookup result (high priority)",
>  		.topic = "uncore",
>  		.pmu = "uncore_sys_cmn_pmu",

