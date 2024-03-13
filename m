Return-Path: <linux-kernel+bounces-101470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5FB87A783
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B072849DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F8405DF;
	Wed, 13 Mar 2024 12:24:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ABB405C7;
	Wed, 13 Mar 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332679; cv=none; b=eR/E+x4qgI1NkSfzy+GeWl456NgVCD+lqtOlEEanhLE3j8jSp62EIkl2boKW1gSSyTHrGdMO0u/Niu1qSPFFFdN/1FHzhIvcKNWOO/HL+3kYsDuqmQFmWRigovb44fzSfob7ZlDTloikDG0e52EOfGEi6c1TWnDCkdzTzBhHkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332679; c=relaxed/simple;
	bh=ahmmwEV6FEghfLNhPpQz+s7UIijKpo3SPoJSq7yskug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4yGHWPRTCNkzPdTUDPKwyNfXSrUGUlC+MJJijOrqgT/ZvWmvaJSVSQ/jhoF/di34NG6F+C1EeeAPDFmxhoaUqQ4ELmrhFiRVWlEpqCgECuSf4t6p0qNosdej/2V+l0KAuWHpMufuyJoM56gAXX+tAoPJsyRrYj3k2VcW58rb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8151007;
	Wed, 13 Mar 2024 05:25:13 -0700 (PDT)
Received: from [10.57.52.245] (unknown [10.57.52.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2D03F762;
	Wed, 13 Mar 2024 05:24:33 -0700 (PDT)
Message-ID: <b94175cd-3128-4c94-b888-32ccd0164e9c@arm.com>
Date: Wed, 13 Mar 2024 12:24:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] perf: Define common uncore capabilities
Content-Language: en-GB
To: James Clark <james.clark@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, jialong.yang@shingroup.cn,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <cover.1710257512.git.robin.murphy@arm.com>
 <8496411b6ae9306b70cb90edafa4134b113a3cfe.1710257512.git.robin.murphy@arm.com>
 <993147ab-26b5-e497-d50f-0f500c8c81b8@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <993147ab-26b5-e497-d50f-0f500c8c81b8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-13 11:23 am, James Clark wrote:
> 
> 
> On 12/03/2024 17:34, Robin Murphy wrote:
>> Nearly all uncore/system PMUs share a common set of capbilities,
>> so let's wrap those up in a single macro for ease of use.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   include/linux/perf_event.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index b1fd832ed8bf..5d5db122005b 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -293,6 +293,9 @@ struct perf_event_pmu_context;
>>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>>   #define PERF_PMU_CAP_NO_COMMON_EVENTS		0x0200
>>   
>> +#define PERF_PMU_UNCORE_CAPS \
>> +(PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_COMMON_EVENTS)
>> +
> 
> The most minor of nits: missing space before |. There is another one in
> another commit that triggers checkpatch but that line gets deleted anyway.

Bleh, thanks for the catch. And it seems that wasn't the only thing I 
inexplicably managed to mess up in the rename patch either... All fixed 
locally now.

Cheers,
Robin.

> 
>>   struct perf_output_handle;
>>   
>>   #define PMU_NULL_DEV	((void *)(~0UL))

