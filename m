Return-Path: <linux-kernel+bounces-61120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E8850D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F7285DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3616747D;
	Mon, 12 Feb 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcKcjJ2f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC36FBE;
	Mon, 12 Feb 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720202; cv=none; b=N6YrHNMgzyr3oVWqduI+bE7dcFybKyQq5KFbem/slGsRIDiK/wl53XODUULk1W4W4ErKy4FC0BcUvEtSQps/BS4E7iGSB3LUHdCBf/XAD9j6pszGoG1pkDmEkT5J/57p/SEnyp8MCGlKCSSXWlZG2XcRG/gpsoihjyli7U7IVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720202; c=relaxed/simple;
	bh=JEaLXdeo6fNthLC6iDS4VCiLgLO+VSbXbp2Vu7m6SIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH9+ePchbsQzWi1iFLpsYudyVwUIxbhw/jl45lBJVmLGCYD9zS5VvptrjCwqEQKU9mxPNVztUdPu024u0jPpEZtZffyMPH3KJ188pkq60o6SIOJQwLhL3YGLGq2kIsiVgSnlvKk4rNOhcSQFwZqUU5WA3U26JBPaQyp1bZtqN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcKcjJ2f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707720201; x=1739256201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEaLXdeo6fNthLC6iDS4VCiLgLO+VSbXbp2Vu7m6SIc=;
  b=UcKcjJ2f/wix+61VRNgZFff2bSc4e9D1qWPoeIvGxS0A2te969f8iu8y
   7uW0YKStJXIjiuUTPmOsw7ZHE43qDwgnAWbjhfzVKL5T5nv0mIEVDOi+1
   ZpRhPPqrEWSwBNCPSL6BckfMj03A7gMK3z8mFfAbw532e33ZXEOOrxbxt
   dW5s3/x7mF6jSaiIqdItEkV1WRtlyJHsmeesc3L/Vn4Akw/3USlAlRv8M
   GWJiceSaWE+0gyzfE/i5u/4IdhfrCJnCIJkc+OF9ckNeBf/pCbcCwU0Yq
   cQj4w+gCbA5V0s4GuhpJgv5WtSUbNfBWb5L0h6X59dROdTxtMKiFkeK6h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1585983"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1585983"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33288927"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.43.27])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:43:14 -0800
Message-ID: <05ac66fc-ddda-46ff-b08d-c15943c16bc1@intel.com>
Date: Mon, 12 Feb 2024 08:43:11 +0200
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
 <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com> <ZcaUw4xQT0VcC7IO@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZcaUw4xQT0VcC7IO@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/02/24 23:10, Andi Kleen wrote:
>> The writes to rb->aux_in_pause_resume must be done
>> only once.  It might be possible to get away without
>> WRITE_ONCE(), but really the compiler should be informed
>> not to make assumptions.
> 
> What stops the NMI from firing here?

That would be fine.

> 
>>>> +  if (READ_ONCE(rb->aux_in_pause_resume))
>>>> +	/* Guard against NMI, NMI loses here */
>>>> +          goto out_restore;
> <----------------------- NMI

That would be fine.

>>>> +  WRITE_ONCE(rb->aux_in_pause_resume, 1);

From here on, the NMI will see rb->aux_in_pause_resume == 1
and do nothing, up to the point when rb->aux_in_pause_resume == 0
again.

This code is about guarding against NMI.  Interrupts are
disabled, and the rb and event only operate on 1 cpu at a time.

> 
> 
> Even if it isn't racy it needs a clear comment.

It has a comment, but it could be more explanatory.  The code
paradigm is also used in perf_pmu_snapshot_aux().


