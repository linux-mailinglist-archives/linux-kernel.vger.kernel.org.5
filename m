Return-Path: <linux-kernel+bounces-95753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B487520B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AECB28DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B30130ACF;
	Thu,  7 Mar 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQVGWNLa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00512FB07;
	Thu,  7 Mar 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822216; cv=none; b=vFLfL2Snkh2DKM0bpeIUHqkodA/QoiPCUhA1sTRHRrQhvjbu+W3YFrIIPiC5w8FMrkk9hSrmzffwUCJMHPuyUh4Tqeb1qsFEz9kH3IGwp0mSCCatb3wLml14lWemwCBHocCLiEISuyn6reyBfFJvCLyZM7FWAYZBukSjBzRBMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822216; c=relaxed/simple;
	bh=bsvqT6rkyOsgS9431W5EFF9tfjXbGQErhla1EGxDfNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xv5cTLIdcxJ5rZ6y/dUfFwRHl//MyBNJJHIwW3btCLH8UrSOYq87fN4AmFY0evIL+fZ6iYK7hhCNLlZ/q+MSgZxhLuS24vePS7DnRtwNW64JYEEIk+rqsuQO6iLppbhzjqBDfL1AnQJAjliQU/VWkCKD0xlifSJzT1Fw6Gi7c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQVGWNLa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822215; x=1741358215;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bsvqT6rkyOsgS9431W5EFF9tfjXbGQErhla1EGxDfNA=;
  b=iQVGWNLaKNP/Oz9YrYcI8QRyDVoS9LAfnnkStvlCF9b7qFia1rBtfemr
   Gk67CVI48ndNAo9I9zG4xc6Ku7J/17T+83YMGKj05lMksYKt1AzIPclT/
   iynZYqF7bToNzZS6uQ4vybV99Of+IBxYTG0NTzw7sSUSHa2ilmEF2bsIM
   yKELqiJGjl8AXILggtUH6F1X9xjjCOkk4CWN6zq383pJhBjXGgeHVTmml
   zUMg3Ut2SjWRsCXbvdccfLFheo3skrsJlDpoGMBWJM4osBHUf64fcJEgv
   3Nc73vPF9SeHr4yFrsd+j++wWTHdp1RkgpgzOxeGmSctfX1YFSkT2iCL+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4662726"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4662726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10689007"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:53 -0800
Received: from [10.213.180.166] (kliang2-mobl1.ccr.corp.intel.com [10.213.180.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9A142580D54;
	Thu,  7 Mar 2024 06:36:51 -0800 (PST)
Message-ID: <c22e0d67-cf63-4bb7-8cef-05fccc384214@linux.intel.com>
Date: Thu, 7 Mar 2024 09:36:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] perf tools: Use pmus to describe type from
 attribute
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307081412.3933750-1-irogers@google.com>
 <20240307081412.3933750-6-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240307081412.3933750-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-07 3:14 a.m., Ian Rogers wrote:
> When dumping a perf_event_attr, use pmus to find the PMU and its name
> by the type number. This allows dynamically added PMUs to be described.
> 
> Before:
> ```
> $ perf stat -vv -e data_read true
> ...
> perf_event_attr:
>   type                             24
>   size                             136
>   config                           0x20ff
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ...
> ```
> 
> After:
> ```
> $ perf stat -vv -e data_read true
> ...
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ...
> ```
> 
> However, it also means that when we have a PMU name we prefer it to a
> hard coded name:
> 
> Before:
> ```
> $ perf stat -vv -e cycles true

faults?

Thanks,
Kan
> ...
> perf_event_attr:
>   type                             1 (PERF_TYPE_SOFTWARE)
>   size                             136
>   config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ...
> ```
> 
> After:
> ```
> $ perf stat -vv -e faults true
> ...
> perf_event_attr:
>   type                             1 (software)
>   size                             136
>   config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ...
> ```
> 
> It feels more consistent to do this, rather than only prefer a PMU
> name when a hard coded name isn't available.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 8f04d3b7f3ec..29e66835da3a 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -7,6 +7,8 @@
>  #include <linux/types.h>
>  #include <linux/perf_event.h>
>  #include "util/evsel_fprintf.h"
> +#include "util/pmu.h"
> +#include "util/pmus.h"
>  #include "trace-event.h"
>  
>  struct bit_names {
> @@ -75,9 +77,12 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>  }
>  
>  #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
> -static const char *stringify_perf_type_id(u64 value)
> +static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
>  {
> -	switch (value) {
> +	if (pmu)
> +		return pmu->name;
> +
> +	switch (type) {
>  	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
>  	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
>  	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
> @@ -175,9 +180,9 @@ do {								\
>  #define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
>  #define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
>  
> -static void __p_type_id(char *buf, size_t size, u64 value)
> +static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
>  {
> -	print_id_unsigned(stringify_perf_type_id(value));
> +	print_id_unsigned(stringify_perf_type_id(pmu, value));
>  }
>  
>  static void __p_config_hw_id(char *buf, size_t size, u64 value)
> @@ -246,7 +251,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
>  #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
>  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>  #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
> -#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
> +#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
>  #define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
>  
>  #define PRINT_ATTRn(_n, _f, _p, _a)			\
> @@ -262,6 +267,7 @@ do {							\
>  int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  			     attr__fprintf_f attr__fprintf, void *priv)
>  {
> +	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
>  	char buf[BUF_SIZE];
>  	int ret = 0;
>  

