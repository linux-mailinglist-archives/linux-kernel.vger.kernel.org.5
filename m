Return-Path: <linux-kernel+bounces-81852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E02A867AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621C51C23BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DDF12C532;
	Mon, 26 Feb 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkD/LCs3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FA12BEA1;
	Mon, 26 Feb 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963213; cv=none; b=q8LCmuLIkW+k5uxJazRjmXvoRbGhMQ5Xn2c1W/U/3ZwY7ru8VjGSHoglfXDErPCry3HBClK29qzOygblmC0kYlkmyestcKqFttWQ09h18vxs9eKZhiWGtMGmSUnwVyNDNf3y/NmkMCFWTV8cNn9U0QdbiVf/7wpn2hese0kNLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963213; c=relaxed/simple;
	bh=eiEN98yjHWpgsNieB++vFqM13GnLlyTzpq+LgyXfNJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m0s0fTy228gOGuB0P73Ph+InQfkcIruaBof91YjEqCFbVWzsM2aw4ImC4nDDPb4cWb77kdhHzRCtKEi+ytQHnWTxONA86Qd2au5BYcKSwNoWC23cwERgw9z8oPDsQEeDHg+eGDXkTTTaiMqZkEWwwN1qCGApvK5txKJzOnRkc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkD/LCs3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708963212; x=1740499212;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eiEN98yjHWpgsNieB++vFqM13GnLlyTzpq+LgyXfNJQ=;
  b=QkD/LCs3soZs/MyJ4+ilDzn1vFS0yW7zn3SycV0yvs4uOM8EMhOOTHyi
   wVbwY2938XgYxfaW+0vwBDMNhpzZdua8hVHfEUTbzlY5HYX15QYlr/syQ
   fUikc+i57oAhVLSDGXNTX4qrlHu2oaru7fY0m/ueSjdtjg5SeyGgK4Vjx
   ErkCUjQUIHt4V0bRTrlIPPk5IU98945LjkcPT+XFwXZjxvT6E/lP8KbKk
   ZTwCuNcZm3vxI2J/dckpa+r2QTwph85+LKqI5rtOkywmrmAIklQJyY9Xb
   zHUv5Ss4ln6QmhmPVAUo8jbKSvRkvxKxG5dn+2bd5/ET+zJq+wCTKiuo0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3419570"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3419570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:00:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6914761"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:00:10 -0800
Received: from [10.213.175.136] (kliang2-mobl1.ccr.corp.intel.com [10.213.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 11EDC580ABD;
	Mon, 26 Feb 2024 08:00:08 -0800 (PST)
Message-ID: <cf12ec88-0a15-4aa8-b6b8-948841d7d66d@linux.intel.com>
Date: Mon, 26 Feb 2024 11:00:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf metrics: Fix metric matching
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240224011420.3066322-1-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240224011420.3066322-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-23 8:14 p.m., Ian Rogers wrote:
> The metric match function fails for cases like looking for "metric" in
> the string "all;foo_metric;metric" as the "metric" in "foo_metric"
> matches but isn't preceeded by a ';'. Fix this by matching the first
> list item and recursively matching on failure the next item after a
> semicolon.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/metricgroup.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b24a1c177a80..2d6865c392ef 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -352,25 +352,23 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
>  	return 0;
>  }
>  
> -static bool match_metric(const char *n, const char *list)
> +static bool match_metric(const char *metric_or_groups, const char *sought)
>  {
>  	int len;
>  	char *m;
>  
> -	if (!list)
> +	if (!sought)
>  		return false;
> -	if (!strcmp(list, "all"))
> +	if (!strcmp(sought, "all"))
>  		return true;
> -	if (!n)
> -		return !strcasecmp(list, "No_group");
> -	len = strlen(list);
> -	m = strcasestr(n, list);
> -	if (!m)
> -		return false;
> -	if ((m == n || m[-1] == ';' || m[-1] == ' ') &&
> -	    (m[len] == 0 || m[len] == ';'))
> +	if (!metric_or_groups)
> +		return !strcasecmp(sought, "No_group");
> +	len = strlen(sought);
> +	if (!strncasecmp(metric_or_groups, sought, len) &&
> +	    (metric_or_groups[len] == 0 || metric_or_groups[len] == ';'))
>  		return true;
> -	return false;
> +	m = strchr(metric_or_groups, ';');
> +	return m && match_metric(m + 1, sought);
>  }
>  
>  static bool match_pm_metric(const struct pmu_metric *pm, const char *pmu, const char *metric)

