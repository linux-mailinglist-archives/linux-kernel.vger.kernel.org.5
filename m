Return-Path: <linux-kernel+bounces-111684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8A886F95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4BC286FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6994E1B3;
	Fri, 22 Mar 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6IEtcMb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEB4644E;
	Fri, 22 Mar 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120402; cv=none; b=L+mHiDEFL6ucHutsvWaLRAaFdPAAbQBbwlVSVCtgbtXCYSYOQOAGxrT+OlZWnCNhG8/fgUrO43VKlGg5APLqtiJJNj2RKBLi3olpf+c2yHSCSNgb3Z42+JN3fVDnmil9S48JdyoUJomknR6FDD2DNjGcMJJEMxQzVEaZ93g7j1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120402; c=relaxed/simple;
	bh=7L6ZHwWrV2R7L/x34TkpSTjw2xByD8vuZxWFmtB+Nsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7A9HoSpi1vFkK1wqVM5Wbo3Ao0TeXSJBq3jolqqcXUQFkzzBseDgQdLZcciHSMrgV6FEw1qm6fIf4xagVzbP241Mh0a1se72lpTDD/K5Qj1PvniZXI6Cps0LPutOOlyiysckCcFO3YZhAmMb6pWqXpr6iMnOOlMXjyyO6AK38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6IEtcMb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711120400; x=1742656400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7L6ZHwWrV2R7L/x34TkpSTjw2xByD8vuZxWFmtB+Nsw=;
  b=l6IEtcMb+SKZKRxeKdfpuBdaiUEIjqzOrxMurjQvSryZpyAjuo0dWjyI
   XW2O5jaI1T/sEMBKVga8ccEy8PD80juF1R0VTJeQ6UAut+Ph2mEvDApl3
   Tti2lOQQcswrS7VdbvHKSgy5h9red4vgLqeDWhpLjzRgrB1ZvqB08KFQz
   JgdoyLw9x3b/71QQ41OMVXosswzo4VRVjn8/A4Q1J/ejAQ2J2UUQZkGYU
   +MW5LZjYRdNwuR6Q1CYeiA8Q5EDEPLfl0k6ms9W9fzzCmoopdjeJfaD1m
   D+hEiHDWsUK2a5lTJaHNRZUg+HUjl1L/8jzkqgcOqoJKLCRCgJFqNqCrz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6037261"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6037261"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 08:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15041410"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.137])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 08:13:16 -0700
Message-ID: <fcc93b09-eca2-498b-b141-06941c9395c5@intel.com>
Date: Fri, 22 Mar 2024 17:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf tools: Add Kan Liang to MAINTAINERS as a
 reviewer
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <Zf2YlxkUObfNqFgC@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zf2YlxkUObfNqFgC@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/24 16:41, Arnaldo Carvalho de Melo wrote:
> Kan has been reviewing patches regularly, add him as a perf tools
> reviewer so that people CC him on new patches.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Acked-by: "Liang, Kan" <kan.liang@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43b39956694ae69c..91a867845d0c2ab8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17264,6 +17264,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Ian Rogers <irogers@google.com>
>  R:	Adrian Hunter <adrian.hunter@intel.com>
> +R:	"Liang, Kan" <kan.liang@linux.intel.com>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported


