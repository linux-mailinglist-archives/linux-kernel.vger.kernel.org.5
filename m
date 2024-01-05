Return-Path: <linux-kernel+bounces-17846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1093C825384
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA86B22582
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0D2D60F;
	Fri,  5 Jan 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MftBFbOI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537E2D602;
	Fri,  5 Jan 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704459409; x=1735995409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IxLjQtYUtIj21vmc1L6JRNZs1Wlol7RrvhIuj03dwkk=;
  b=MftBFbOI4Ig6WfkNOJqcra5NA6Q9kPo8DYPxl0RGs2VVVsHROeFLyiGx
   mdeO/9U7lUnhSjqXvJzGfFLA0Ug8sICSIVBNmaAnyhi8gnUjWNvMk9VrI
   fW8of3QNnNPD15ydS4jm1/hOnPgYWDN7FqtyX3lGFPnVLy+3JG51HkSI2
   faXmZEMs5CnXYm+XjbNF8OgcZuoCi782DwpvJgKxOLgL5Pom5HYFGvONj
   OSW5zEWent/WLwg5U1ngeSnN6UXkmjIMnSKh+V3vqLJostlAntpQ5LVtj
   xft3OyZM8rCNd6y2zxj3s5fuTMbAmjTb+Pdwqwj/CJiOideJzfpP48XmR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="16118576"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="16118576"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851134361"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="851134361"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.83])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:56:42 -0800
Message-ID: <ce87308f-1b9b-41b1-8282-04c81d316c58@intel.com>
Date: Fri, 5 Jan 2024 14:56:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 4/4] coresight: Have a stab at support for pause /
 resume
Content-Language: en-US
To: James Clark <james.clark@arm.com>
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
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20231208172449.35444-5-adrian.hunter@intel.com>
 <20231215064242.36251-1-adrian.hunter@intel.com>
 <e80f75ea-99e9-e4d2-6477-443e521ef90a@arm.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <e80f75ea-99e9-e4d2-6477-443e521ef90a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/23 17:59, James Clark wrote:
> 
> 
> On 15/12/2023 06:42, Adrian Hunter wrote:
>> For discussion only, un-tested...
>>
> 
> If anyone wants to test Coresight, the diff below is required to get the
> most basic use case working. It also probably needs more thought and
> some edge case handling:

Makes sense to me

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 596c01e37624..bd0767356277 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -556,7 +556,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	struct etm_event_data *event_data;
>  	struct list_head *path;
>  
> -	if (mode & PERF_EF_PAUSE && !READ_ONCE(ctxt->pr_allowed))
> +	if ((mode & PERF_EF_PAUSE && !READ_ONCE(ctxt->pr_allowed)) ||
> +	    event->hw.state == PERF_HES_STOPPED)
>  		return;
>  
>  	WRITE_ONCE(ctxt->pr_allowed, 0);
> @@ -573,9 +574,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	/* Clear the event_data as this ETM is stopping the trace. */
>  	ctxt->event_data = NULL;
>  
> -	if (event->hw.state == PERF_HES_STOPPED)
> -		goto out_pr_allowed;
> -
>  	/* We must have a valid event_data for a running event */
>  	if (WARN_ON(!event_data))
>  		return;
> @@ -586,7 +584,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	 * nothing needs to be torn down other than outputting a
>  	 * zero sized record.
>  	 */
> -	if (handle->event && (mode & PERF_EF_UPDATE) &&
> +	if (handle->event && (mode & (PERF_EF_UPDATE | PERF_EF_PAUSE)) &&
>  	    !cpumask_test_cpu(cpu, &event_data->mask)) {
>  		event->hw.state = PERF_HES_STOPPED;
>  		perf_aux_output_end(handle, 0);
> @@ -616,7 +614,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	 * handle due to lack of buffer space), we don't
>  	 * have to do anything here.
>  	 */
> -	if (handle->event && (mode & PERF_EF_UPDATE)) {
> +	if (handle->event && (mode & (PERF_EF_UPDATE | PERF_EF_PAUSE))) {
>  		if (WARN_ON_ONCE(handle->event != event))
>  			return;
>  
> @@ -646,7 +644,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	/* Disabling the path make its elements available to other sessions */
>  	coresight_disable_path(path);
>  
> -out_pr_allowed:
>  	if (mode & PERF_EF_PAUSE)
>  		WRITE_ONCE(ctxt->pr_allowed, 1);
>  }
> @@ -656,7 +653,7 @@ static int etm_event_add(struct perf_event *event, int mode)
>  	int ret = 0;
>  	struct hw_perf_event *hwc = &event->hw;
>  
> -	if (mode & PERF_EF_START && !READ_ONCE(event->aux_paused)) {
> +	if (mode & PERF_EF_START) {
>  		etm_event_start(event, 0);
>  		if (hwc->state & PERF_HES_STOPPED)
>  			ret = -EINVAL;


