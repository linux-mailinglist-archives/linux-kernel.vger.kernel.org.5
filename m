Return-Path: <linux-kernel+bounces-4393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B6817C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC491C228BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17797740A2;
	Mon, 18 Dec 2023 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGCE9Z7x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0F7408F;
	Mon, 18 Dec 2023 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702933661; x=1734469661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6btknFUZVYtWSkDJIuGzJcXYDP+9Dja//hfkbuiwJEU=;
  b=YGCE9Z7x7exc+FkL8sF+LtFju9oYsvoYTt6nl8Aw2sn16QhbCxJrnJ/Y
   sH2JKfO0re5aR9EsqH0b9ZhqB1pnLitCW1n/5ahVXgu2M88ynFv1CJZZI
   uELPiWkb9YvejLvor7dBQ8BAp+l8bYlzfBxicgxaAnHf2rtlH+L9/EPUE
   z1igMkXy3AqsXwD+NI9gbfEPZZF6n88kTectbHuNMpHLj/B6pHMWQL0im
   rX5VmLRN5lF0sMyQka+ntYbh8ntkfwSCr76zHldM/YqCO2pMU7J5bKLWA
   H/rJBVqA1Bt1SdUdxhfl2m9FC66ZQb0tFViBemFUn/ezUBqyZNPY7W09+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2777457"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2777457"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107093938"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="1107093938"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:07:40 -0800
Received: from [10.209.146.249] (kliang2-mobl1.ccr.corp.intel.com [10.209.146.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D4781580842;
	Mon, 18 Dec 2023 13:07:38 -0800 (PST)
Message-ID: <f07e2580-023c-4530-acba-43b59562517e@linux.intel.com>
Date: Mon, 18 Dec 2023 16:07:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, maz@kernel.org, marcan@marcan.st,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
 <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
 <ZXyaZjwrpy6toGf6@kernel.org>
 <14957171-6abd-4fd6-9e05-669b4945c0df@linux.intel.com>
 <ZYCqM2WQjUHWNUfw@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZYCqM2WQjUHWNUfw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-18 3:23 p.m., Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 15, 2023 at 01:53:12PM -0500, Liang, Kan escreveu:
>> On 2023-12-15 1:26 p.m., Arnaldo Carvalho de Melo wrote:
>>> Right, I implemented it in a slightly different way, but end result
>>> should be the same:
> 
>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Date: Fri, 15 Dec 2023 15:23:30 -0300
>>> Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when uniquefying using the PMU name
>  
>> Looks good to me and verified.
> 
>> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> 
> I ended up with a bit more simplified version:
> 
> From 22ecc4601e28a12661f14ca877e39348dab6be8e Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 15 Dec 2023 15:23:30 -0300
> Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when
>  uniquefying using the PMU name
> 
> When turning an event with attributes to the format including the PMU we
> need to move the "event:attributes" format to "event/attributes/" so
> that we can copy the event displayed and use it in the command line,
> i.e. in 'perf top' we had:
> 
>  1K cpu_atom/cycles:P/
>  11K cpu_core/cycles:P/
> 
> If I try to use that on the command line:
> 
>   # perf top -e cpu_atom/cycles:P/
>   event syntax error: 'cpu_atom/cycles:P/'
>                                 \___ Bad event or PMU
> 
>   Unable to find PMU or event on a PMU of 'cpu_atom'
> 
>   Initial error:
>   event syntax error: 'cpu_atom/cycles:P/'
>                                 \___ unknown term 'cycles:P' for pmu
>   'cpu_atom'
> 
>   valid terms:
> 
>     event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite ,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
>   Run
>     'perf list' for a list of valid events
> 
>   Usage: perf top [<options>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
>   #
> 
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZXxyanyZgWBTOnoK@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/util/evlist.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 6f0892803c2249af..95f25e9fb994ab2a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2521,9 +2521,8 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
>  
>  void evlist__uniquify_name(struct evlist *evlist)
>  {
> +	char *new_name, empty_attributes[2] = ":", *attributes;
>  	struct evsel *pos;
> -	char *new_name;
> -	int ret;
>  
>  	if (perf_pmus__num_core_pmus() == 1)
>  		return;
> @@ -2535,11 +2534,17 @@ void evlist__uniquify_name(struct evlist *evlist)
>  		if (strchr(pos->name, '/'))
>  			continue;
>  
> -		ret = asprintf(&new_name, "%s/%s/",
> -			       pos->pmu_name, pos->name);
> -		if (ret) {
> +		attributes = strchr(pos->name, ':');
> +		if (attributes)
> +			*attributes = '\0';
> +		else
> +			attributes = empty_attributes;
> +
> +		if (asprintf(&new_name, "%s/%s/%s", pos->pmu_name, pos->name, attributes + 1)) {
>  			free(pos->name);
>  			pos->name = new_name;
> +		} else {
> +			*attributes = ':';
>  		}
>  	}
>  }

