Return-Path: <linux-kernel+bounces-59105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06E84F141
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8901C23E07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC265BBD;
	Fri,  9 Feb 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RW8Rm8j6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148957303;
	Fri,  9 Feb 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466496; cv=none; b=kTSdGTigR0yIcWC4Y6QEog/sXkkklVMg5EDwpPUH/286yRjiL6OKCfVuATkLjOplMtqTQRqTRxHUcxfvYxZ8JBLPi95YICw1YfYtbtXYRmptSjNyNMbTpAnPy/97AVz3aPhRPExETCg5OXOqGpQRDw/Os9qdsdTo9kxcYC6rjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466496; c=relaxed/simple;
	bh=odqYYfgwkzr9LdQp9Op8mRYllrVCWTdsitkPlh2e2hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1dRyP4Yl6YEeMrJHlijdnUnCUe5iyfpecz/C2oRN9maM1pDhUlmawjZMbMzUTxZ+JtnY6vZ6rZ0s8KIihM6/wqgCpK48zOCRyBCT/DmlfiksP8eS0VJdDupUNDiY2Oh0vDSM5Ih2aGoIQIMGOQc3LPaWkYF4G+qbsqKlXkaYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RW8Rm8j6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707466495; x=1739002495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=odqYYfgwkzr9LdQp9Op8mRYllrVCWTdsitkPlh2e2hM=;
  b=RW8Rm8j6IEcrZapXzOKQ8ni1GXO80wkjzKOacsD859KINJzm4ALvWLN6
   R4IECHXJXiCMjXiHzMoAphl1tYtbEu6o6a0yBznkch6bX88DBbLkiPhql
   TrrU7T6aGq0R2RFn1pxyMgDcEoqU3pMp8Y3de8k9hYcTOG6atkBMzwuMW
   t5++JIbGdg+tc89M3v8ZQBkNPt75VAxAj8+DrWfoSbjjR8sqslHv+f5+u
   CzRRvAAj4jHDN7yfL3nt693SOKq8RzxMphy5pNQe5WFMwlHvAoGXiGO6J
   b68zx8wjth78OdIhr2zW66BE9+Q99a8NQm80QMAkLakRbnkoAQFmFVCGC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18804147"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="18804147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 00:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1889450"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 00:14:48 -0800
Message-ID: <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com>
Date: Fri, 9 Feb 2024 10:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
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
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <20240208113127.22216-2-adrian.hunter@intel.com> <ZcVuK1nnxG18ps-a@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZcVuK1nnxG18ps-a@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/02/24 02:13, Andi Kleen wrote:
>> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
>> +{
>> +	if (pause) {
>> +		if (!READ_ONCE(event->aux_paused)) {
>> +			WRITE_ONCE(event->aux_paused, 1);
>> +			event->pmu->stop(event, PERF_EF_PAUSE);
>> +		}
>> +	} else {
>> +		if (READ_ONCE(event->aux_paused)) {
>> +			WRITE_ONCE(event->aux_paused, 0);
>> +			event->pmu->start(event, PERF_EF_RESUME);
>> +		}
> 
> This doesn't look atomic. Either the READ/WRITE once are not needed,
> or you need an actually atomic construct.

Yes READ_ONCE / WRITE_ONCE is not really needed here.

> 
>> +
>> +	rb = ring_buffer_get(event);
>> +	if (!rb)
>> +		return;
>> +
>> +	local_irq_save(flags);
>> +	/* Guard against NMI, NMI loses here */
>> +	if (READ_ONCE(rb->aux_in_pause_resume))
>> +		goto out_restore;
>> +	WRITE_ONCE(rb->aux_in_pause_resume, 1);
> 
> 
>> +	barrier();
>> +	__perf_event_aux_pause(event, pause);
>> +	barrier();
>> +	WRITE_ONCE(rb->aux_in_pause_resume, 0);
> 
> Dito.
> 

The writes to rb->aux_in_pause_resume must be done
only once.  It might be possible to get away without
WRITE_ONCE(), but really the compiler should be informed
not to make assumptions.


