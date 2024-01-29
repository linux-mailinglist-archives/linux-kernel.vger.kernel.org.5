Return-Path: <linux-kernel+bounces-42730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC48405AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DFA283479
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454A9657B0;
	Mon, 29 Jan 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj792J1p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD379657B3;
	Mon, 29 Jan 2024 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532548; cv=none; b=K+UHK/mRXoB3PLzSJw4Hc1Ud2iv3rBy3JwrwATxPZQz5Qerc/nYX4ieQx9DHJJ0kecw8ooNJoyBY7nKf72llJmCFQTGMD+V8IrxOwIaw2Q1QdrimdnqEO0qYx1XIwdMDJlwTe4WUI21qUgze8ysDyZE24vlVHY8lmvgt8ft7ioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532548; c=relaxed/simple;
	bh=VL5pNvnkQOiSj9vwY01FvxPpPTQKiMSBL6wrtNUbUDg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LBeka4O+1QJkdYjtye9buwY9fo4Khl0qRFkpmGrNsxZHYvssW6He0pRCnYJtrwFZHHsn+PQpqpchgsuyu44r4zC7HSGHigb2qXXmhUE3C+Wdb67gIsqdZysDkbxPyaEctMX9IRAYs3ceZmpdU4WB/qbjsateY3m+8U359oWlfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj792J1p; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706532546; x=1738068546;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VL5pNvnkQOiSj9vwY01FvxPpPTQKiMSBL6wrtNUbUDg=;
  b=Bj792J1pv0KOcpq4Bq1utHM3EKK/VT4Ciimnpl7S8FCX7GOX9FwmBpxQ
   vGnVpOFs57a9wuMEc3zXAQAFn2oRl1biQVYz/Q12js9fr2WwEuu0VJOX/
   LjZGLQUzYH9XQl545oboShsgYw9DSNkLIWWIIsmT1cwnv0hxOsRFbmxsU
   fneJQIOppp6MPdtB6JAy9OM0ov/SW6zP9j9FeVDIz0bJCM6ZIyxlE/D/0
   zu2AiC1dxPQNiBuX64McA451X7lo/7U0O9t3mf3R1UPZia9CjQYXTVKb6
   S0PAkO9y9Qn9IUqIObPvIC2JWioqR62SYLyO5HsYejgtihCzmWjJt8Vy+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16466990"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16466990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 04:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29508479"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 04:48:46 -0800
Message-ID: <31bae596-ecb1-4b9c-9f1c-aaec4bcefd38@intel.com>
Date: Mon, 29 Jan 2024 14:48:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/11] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240111081914.3123-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/24 10:19, Adrian Hunter wrote:
> Hi
> 
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> These patches add such a facilty and show how it would work for Intel
> Processor Trace.
> 
> Maintainers of other AUX area tracing implementations are requested to
> consider if this is something they might employ and then whether or not
> the ABI would work for them.
> 
> Changes to perf tools are now (since V4) fleshed out.
> 
> 
> Changes in V4:
> 
>     perf/core: Add aux_pause, aux_resume, aux_start_paused
> 	Rename aux_output_cfg -> aux_action
> 	Reorder aux_action bits from:
> 		aux_pause, aux_resume, aux_start_paused
> 	to:
> 		aux_start_paused, aux_pause, aux_resume
> 	Fix aux_action bits __u64 -> __u32
> 
>     coresight: Have a stab at support for pause / resume
> 	Dropped
> 
>     perf tools
> 	All new patches
> 
> Changes in RFC V3:
> 
>     coresight: Have a stab at support for pause / resume
> 	'mode' -> 'flags' so it at least compiles
> 
> Changes in RFC V2:
> 
> 	Use ->stop() / ->start() instead of ->pause_resume()
> 	Move aux_start_paused bit into aux_output_cfg
> 	Tighten up when Intel PT pause / resume is allowed
> 	Add an example of how it might work for CoreSight

Any more comments?


