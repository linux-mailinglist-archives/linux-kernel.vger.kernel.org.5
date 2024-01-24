Return-Path: <linux-kernel+bounces-37323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E183AE36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442AD1C237C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F07CF29;
	Wed, 24 Jan 2024 16:19:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331737C094;
	Wed, 24 Jan 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113191; cv=none; b=OWWR7aT79qMSoSOCujBCV+P/PIfGDrEuXQdauv8pWpLVv83FRxBt7koak8ZAGexfVinMLbrvXldDnTTRDm2CXJtnrv9JrklLcEEwKBQ/rtgDRK6TAQRVzPE0bsgE2HJUNCFAeq/ab6iomdYMNyAxltN9+1gNNmHJYk0JM5a2bOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113191; c=relaxed/simple;
	bh=Qp7JcOQ7SlWmlTzgIphkIdDTBIiOYjsn2fynh4y+9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi1dGoeqTr4btPmPMeqrbgJDPzoxC86D9jEms4Ik836TVvWJsIPvq2v9Q5vBTH0a+KaJI7J7+WypFOnk2xmjRFccXADR9utfQsbAwk0ZoaKVXyj3oH8syfpfMBKmcFbC1Qb8FFlBuVpeeGiGOEpaqFVpIBEAGLbGIFOP/9x8y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C261FB;
	Wed, 24 Jan 2024 08:20:33 -0800 (PST)
Received: from [10.57.87.44] (unknown [10.57.87.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582B93F762;
	Wed, 24 Jan 2024 08:19:45 -0800 (PST)
Message-ID: <9ce80ab3-9e82-2068-3a01-ab68b9b05c1a@arm.com>
Date: Wed, 24 Jan 2024 16:19:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Rogers <irogers@google.com>, acme@redhat.com,
 john.g.garry@oracle.com, leo.yan@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 mike.leach@linaro.org, namhyung@kernel.org, suzuki.poulose@arm.com,
 tmricht@linux.ibm.com, will@kernel.org, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <5236cd64-c0ca-6d0e-137f-06a44f03ebc7@arm.com>
 <ZbEyhZScQ9spEE1I@FVFF77S0Q05N.cambridge.arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZbEyhZScQ9spEE1I@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/01/2024 15:53, Mark Rutland wrote:
> On Mon, Jan 22, 2024 at 10:43:27AM +0000, James Clark wrote:
>>
>>
>> On 16/01/2024 17:03, Mark Rutland wrote:
>>> Currently the perf tool doesn't deteect support for extneded event types
>>> on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
>>> hardware events into per-PMU events. This is due to the detection of
>>> extended event types not handling mandatory filters required by the
>>> M1/M2 PMU driver.
>>>
>>> PMU drivers and the core perf_events code can require that
>>> perf_event_attr::exclude_* filters are configured in a specific way and
>>> may reject certain configurations of filters, for example:
>>>
>>> (a) Many PMUs lack support for any event filtering, and require all
>>>     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
>>>     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
>>>     ARMv7,
>>>
>>> (b) When /proc/sys/kernel/perf_event_paranoid >= 2, the perf core
>>>     requires that perf_event_attr::exclude_kernel is set.
>>>
>>> (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
>>>     set as the hardware PMU does not count while a guest is running (but
>>>     might be extended in future to do so).
>>>
>>> In is_event_supported(), we try to account for cases (a) and (b), first
>>> attempting to open an event without any filters, and if this fails,
>>> retrying with perf_event_attr::exclude_kernel set. We do not account for
>>> case (c), or any other filters that drivers could theoretically require
>>> to be set.
>>>
>>> Thus is_event_supported() will fail to detect support for any events
>>> targetting an Apple M1/M2 PMU, even where events would be supported with
>>> perf_event_attr:::exclude_guest set.
>>>
>>> Since commit:
>>>
>>>   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")
>>>
>>> ... we use is_event_supported() to detect support for extended types,
>>> with the PMU ID encoded into the perf_event_attr::type. As above, on an
>>> Apple M1/M2 system this will always fail to detect that the event is
>>> supported, and consequently we fail to detect support for extended types
>>> even when these are supported, as they have been since commit:
>>>
>>>   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
>>>
>>> Due to this, the perf tool will not automatically expand plain
>>> PERF_TYPE_HARDWARE events into per-PMU events, even when all the
>>> necessary kernel support is present.
>>>
>>> This patch updates is_event_supported() to additionally try opening
>>> events with perf_event_attr::exclude_guest set, allowing support for
>>> events to be detected on Apple M1/M2 systems. I beleive that this is
>>> sufficient for all contemporary CPU PMU drivers, though in future it may
>>> be necessary to check for other combinations of filter bits.
>>>
>>> I've deliberately changed the check to not expect a specific error code
>>> for missing filters, as today ;the kernel may return a number of
>>> different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
>>> -EOPNOTSUPP) depending on why and where the filter configuration is
>>> rejected, and retrying for any error is more robust.
>>>
>>> Note that this does not remove the need for commit:
>>>
>>>   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
>>>
>>> ... which is still necessary so that named-pmu/event/ events work on
>>> kernels without extended type support, even if the event name happens to
>>> be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case for
>>> the M1/M2 PMU's 'cycles' and 'instructions' events).
>>>
>>> Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Cc: Hector Martin <marcan@marcan.st>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: John Garry <john.g.garry@oracle.com>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> ---
>>>  tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
>>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>>
>>
>> Tested-by: James Clark <james.clark@arm.com>
>>
>> Tested on Juno and N1SDP, although I wouldn't have expected it to make a
>> difference on those platforms because they support exclude_guest=0.
> 
> It's good to be certain, anyhow!
> 
> I've folded that tag in for v2.
> 
>> Although I do see an interaction with the test "Session topology" if I
>> hack the driver to behave like M1. The test has been failing (on
>> big.LITTLE) since commit 251aa040244a ("perf parse-events: Wildcard most
>> "numeric" events") but the result is that the test actually starts
>> passing with this change. I don't think that should really block this
>> though, it's likely going to require a separate fix which I will look into.
> 
> IIUC that fix is:
> 
>   https://lore.kernel.org/lkml/20240124094358.489372-1-james.clark@arm.com/
> 
> ... right?
> 
> Mark.
> 

Yes that's it. Turned out to be unrelated. Or only semi related and not
blocking for your patch.


