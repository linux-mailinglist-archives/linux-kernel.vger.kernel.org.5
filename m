Return-Path: <linux-kernel+bounces-151507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC218AAFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58E2282402
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297912D1FF;
	Fri, 19 Apr 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBHMynGm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8612AAFD;
	Fri, 19 Apr 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534895; cv=none; b=gUWBjBh/OJmmur3fexFX+d8vjPD3SMwsY4hX4qoGuNTn1FVizozaFZv1abZ2vi+vBl1uG6WUEQMjFxvcFtTkwmVdc33Rd8nByUcSa7pYI25waJdzZ2Lt3EjI6dMJl2GHnK9I8koIo+qRyJh3crZYi6U87mZAzG8WRZ8E4Yz24D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534895; c=relaxed/simple;
	bh=QCLGtnkSFVFP1qWH///9S/RvYON05jeWdCb3oDr+b3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DChjwUAVyO2G1KqgDso+9D04U+uu/FwrKKqyhSgce3FuySMOPGNGMaKbTE9g/BxXC0zIQ43RFwFUE1UwTQANrt57lEkVcEXW5oCnNHjeoRANfejkBhhzbrYCvBWh9y2WQlVXJEU0oAm60M+O0TyxbZ1c449TiT8xapsAGCXRiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBHMynGm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713534893; x=1745070893;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QCLGtnkSFVFP1qWH///9S/RvYON05jeWdCb3oDr+b3s=;
  b=RBHMynGmVVT0gCIHVevcIuuvg5qbLWucNE4IvjptYxWcb4IB7q/kNj6j
   AHU5b4hsSA2nS5ar8usx+OColcXa8tnxlQOseyQhv3bogrgVjLb6L73Sx
   j3LNpYlJf3ZzEVSQNAuPczm3b3SOd2770gKOi9mECD92mN4kdtM8J2CJe
   YXsd8nA3xQFTpJdWgjGbV10E7euhuHOhhpTQgxb87mNXvaI1XvXtbXG5y
   5h7f7LHs4ek11Xu2FScPM8eDuOLiG2jT2J4DfrpkncU7o1n4C+d+CGIV0
   9dYTDdzIcQTOMpoerg/L/iHb6FlBdOEhoC9vV108CwG900fo77zUZuBxa
   A==;
X-CSE-ConnectionGUID: EptBvppTQpeJvw4mBVMKNA==
X-CSE-MsgGUID: hYFejNttQuq4DHU07648Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12917029"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12917029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:54:52 -0700
X-CSE-ConnectionGUID: EHGXZ2iKRxOOctN5BAubUg==
X-CSE-MsgGUID: +lJRY5p4RGCtjRVNSqDWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54540968"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:54:52 -0700
Received: from [10.212.13.6] (kliang2-mobl1.ccr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 151E7206DFDC;
	Fri, 19 Apr 2024 06:54:49 -0700 (PDT)
Message-ID: <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
Date: Fri, 19 Apr 2024 09:54:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output
 test
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417183219.1208493-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240417183219.1208493-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-17 2:32 p.m., Ian Rogers wrote:
> Hard coded metric names fail on ARM testing.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> index cbf2894b2c84..845f83213855 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>  
>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
>  event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
> -skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
> +skip_metric=($(perf list --raw Default 2> /dev/null))


The "perf list --raw Default" only gives the topdown metrics.
The "stalled cycles per insn" is not covered.
The check should skip the line of "stalled cycles per insn" as well.

     3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles idle
     1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycles idle
     2,603,501,247 instructions              #    0.50  insns per cycle
                                             #    1.48  stalled cycles
per insn
       484,357,498 branches                  #  283.455 M/sec
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c#n24

The newer Intel CPU doesn't have the stalled-cycles-* events. But it
seems power and older x86 CPU have the events.

Thanks,
Kan

>  
>  cleanup() {
>    rm -f "${stat_output}"

