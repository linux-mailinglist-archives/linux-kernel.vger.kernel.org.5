Return-Path: <linux-kernel+bounces-97244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65381876779
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D441F21F05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63FC1F93E;
	Fri,  8 Mar 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0C9+I+w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A091865;
	Fri,  8 Mar 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912373; cv=none; b=Sskr6vry2UZuGgsPAi1TffeAWITztrpI5KMfdAmzbtvxbLNrABFVEEiE4quFNxRxyOMY1ks/yLFpUu8W0YCNO7PwA+AUK7SbbZPSbuDXx6RRTtSr9cey5DCmX83l73yoWvnJxh9/OzcuqELzBdeRLdQPTvWRcBX6e6Odk/SPImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912373; c=relaxed/simple;
	bh=9h4zpabX33FnuG9PKHlSlWYTN5xYzT8IUzo10FfqYyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M3PCttQCuOmmXmSyhkQtkgGThfofbrUrcSs0xxqyH9kQ/ibSt8+hHWNQwtfHQ1AOVfyBP7QkLP+B29zfeb2xc+90AOai6l1727yT+nT3qGWXTLW/EJru5bEuQMHjdbJFuhYbLXUpTRYJLlOzNrlot3wFzRZIFwLx77Nj+/M4SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0C9+I+w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709912372; x=1741448372;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9h4zpabX33FnuG9PKHlSlWYTN5xYzT8IUzo10FfqYyk=;
  b=K0C9+I+w7qdQZ8nfP8VucQes+Ievyqbw+yrRcw8G7MwzkTm9b4b0pvIQ
   VdjEh+KJQiE+M9iNzykDFzEN1LCOhxt6g+egKkbz/4xIsuTuideCPUisr
   TRHWDoVGNCzZ4KcpOIuVi4kwC8VOiqMm8gWoVbPKOfam+IGlK9N20uv4/
   4gqQOCfehrSt/V+bIQD0d9XiUhFkDjQzXrlax0gJ8Ds69P6r16SJCyqGX
   0Mm/38PCzN5C1+Sy4iR3mL2zkkRqBEOper+i4qaMukqrKw7x7hdn+966U
   LQkZeqM6rtZg94B5YeBenGSFapwdBWpCgEIeyT5JGOgVrQ4zhq+dTaj/2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4773475"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4773475"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:39:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41465976"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:39:30 -0800
Received: from [10.212.124.40] (kliang2-mobl1.ccr.corp.intel.com [10.212.124.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3B445580DDD;
	Fri,  8 Mar 2024 07:39:28 -0800 (PST)
Message-ID: <89249fc5-6102-45d4-9345-5dd80d06e001@linux.intel.com>
Date: Fri, 8 Mar 2024 10:39:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Extra verbose/perf-list details
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308001915.4060155-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-07 7:19 p.m., Ian Rogers wrote:
> Add more encoding detail and raw event details in perf list. Add PMU
> name and reverse lookup from config to event name to
> perf_event_attr_fprintf. This makes the verbose output easier to read,
> and the perf list information more specific.
> 
> v3. Fix to reverse lookup to ensure or aliases are loaded and if
>     getting the config value fails for an event/alias just continue to
>     the next one.
> v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
>     becomes "Raw event descriptor" add assert to keep term numbers in
>     sync, fix a commit message.
> 
> Ian Rogers (6):
>   perf list: Add tracepoint encoding to detailed output
>   perf pmu: Drop "default_core" from alias names
>   perf list: Allow wordwrap to wrap on commas
>   perf list: Give more details about raw event encodings
>   perf tools: Use pmus to describe type from attribute
>   perf tools: Add/use PMU reverse lookup from config to name

The patch series look good to me.
I verified it on a hybrid machine. The new format is the same as the
advertise.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> 
>  tools/perf/builtin-list.c                 | 21 ++++-
>  tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
>  tools/perf/util/pmu.c                     | 82 +++++++++++++++++++-
>  tools/perf/util/pmu.h                     |  4 +
>  tools/perf/util/pmus.c                    | 94 +++++++++++++++++++++++
>  tools/perf/util/pmus.h                    |  1 +
>  tools/perf/util/print-events.c            | 55 +++++++------
>  7 files changed, 242 insertions(+), 41 deletions(-)
> 

