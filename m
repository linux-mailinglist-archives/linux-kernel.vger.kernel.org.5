Return-Path: <linux-kernel+bounces-33711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14515836D90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C119E286890
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4657860;
	Mon, 22 Jan 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPrbotgb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B523FB32;
	Mon, 22 Jan 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941696; cv=none; b=qO8FPgUzBkMEzav6aP14rkxJ6pYtuLWT02Szvmyaq6B0RPu9S2o+i0DuVmiKs2Xiw6NAS1SggoZ/DNctEXAwB20rNYCHCMYVS/ENNN3FUyElnn2OXwBCEeosbwuRbBnzMuUWA/jSb0gN7ldKLH0yV7P9FWnndyAeyugMrlj0uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941696; c=relaxed/simple;
	bh=WZbZUl1MjixLL5VT/lynUlF+EP83NSUk9//tSkgXzj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+o+Gtj+sAuU4JU798quG5u5I8gjgSxj+4qmpCiX47zA4VOIEY4aWpXGOsyE6G6qr7EBmDYDDBxdjUgkHBCU0XJqZtZqj+fHFh4A74bl+7fJyLyHLHmJbXyFwDeuCxLzmQ0l9RxTvdcCZ2mtEr1jz3LwX0nW3Ybf/RsevE7lxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPrbotgb; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705941694; x=1737477694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZbZUl1MjixLL5VT/lynUlF+EP83NSUk9//tSkgXzj0=;
  b=HPrbotgbxiyZDDTbgFSuvW2j8tlz33lnBAgmYWAwDmIUpItTZYjOgTlM
   azwBdbT9nJKz8mZHaMcSp5WlxfJiUYvcQeNnzN/YRYjtl+/qAorCohhxf
   sfDTZTT2xL5urMaDTC9IQoDpJ1FHiF3Kp5f+ZJw/qIq6t/roqdIstDHk7
   2EWG4vrWP/Qh5IOOHXI1MdKuvpPMVJBzpUd0PJ21QkDQiXMnNRcYK3IHH
   Sz99tt7UzLMwG548OiS7w/J47Jb+FiXyBNSfuh/CTPVrY/If0DylzHHeu
   WYvxhohocZruYAQQryBeUCRzW6uNmjOaFw/T4wAwCO5oG5Tm+n3rpk+Bw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="398410600"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="398410600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819770723"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819770723"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:41:33 -0800
Received: from [10.213.164.62] (kliang2-mobl1.ccr.corp.intel.com [10.213.164.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 52838580689;
	Mon, 22 Jan 2024 08:41:31 -0800 (PST)
Message-ID: <d4779b12-bb10-4957-a83d-8569f09421ff@linux.intel.com>
Date: Mon, 22 Jan 2024 11:41:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix session topology test on heterogeneous
 systems
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 mark.rutland@arm.com, irogers@google.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, Changbin Du <changbin.du@huawei.com>,
 linux-kernel@vger.kernel.org
References: <20240122155436.185089-1-james.clark@arm.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240122155436.185089-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-22 10:54 a.m., James Clark wrote:
> The test currently fails with this message when evlist__new_default()
> opens more than one event:
> 
>   32: Session topology                                                :
>   --- start ---
>   templ file: /tmp/perf-test-vv5YzZ
>   Using CPUID 0x00000000410fd070
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xb00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xa00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
>   non matching sample_type
>   FAILED tests/topology.c:73 can't get session
>   ---- end ----
>   Session topology: FAILED!
> 
> This is because when re-opening the file and parsing the header, Perf
> expects that any file that has more than one event has the session ID
> flag set. Perf record already sets the flag in a similar way when there
> is more than one event, so add the same logic to evlist__new_default().
> 
> evlist__new_default() is only currently used in tests, so I don't
> expect this change to have any other side effects.
> 
> The session topology test has been failing on Arm big.LITTLE platforms
> since commit 251aa040244a ("perf parse-events: Wildcard most
> "numeric" events") when evlist__new_default() started opening multiple
> events for 'cycles'.
> 
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Signed-off-by: James Clark <james.clark@arm.com>
Verified on an Intel hybrid machine.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan


> ---
>  tools/perf/util/evlist.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 95f25e9fb994..56db37fac6f6 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -95,6 +95,7 @@ struct evlist *evlist__new_default(void)
>  	struct evlist *evlist = evlist__new();
>  	bool can_profile_kernel;
>  	int err;
> +	struct evsel *evsel;
>  
>  	if (!evlist)
>  		return NULL;
> @@ -106,6 +107,10 @@ struct evlist *evlist__new_default(void)
>  		evlist = NULL;
>  	}
>  
> +	if (evlist->core.nr_entries > 1)
> +		evlist__for_each_entry(evlist, evsel)
> +			evsel__set_sample_id(evsel, false);
> +
>  	return evlist;
>  }
>  

