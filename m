Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9741761066
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGYKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGYKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:15:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911E919AF;
        Tue, 25 Jul 2023 03:15:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED3515BF;
        Tue, 25 Jul 2023 03:16:26 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB49E3F67D;
        Tue, 25 Jul 2023 03:15:40 -0700 (PDT)
Message-ID: <56e70195-5f58-ca03-d6fd-f73e91f56298@arm.com>
Date:   Tue, 25 Jul 2023 11:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf arm64: Fix read PMU cpu slots
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
 <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
 <ZL6pxZ4RmMC2W7S+@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZL6pxZ4RmMC2W7S+@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2023 17:41, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 24, 2023 at 03:40:12PM +0800, Jing Zhang escreveu:
>>
>>
>> 在 2023/7/24 下午1:06, Haixin Yu 写道:
>>> Commit f8ad6018ce3c ("perf pmu: Remove duplication around
>>>  EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull to read a full
>>> sysfs path, which will never success. Fix it by read file directly.
>>>
>>> Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
>>> ---
>>>  tools/perf/arch/arm64/util/pmu.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
>>> index 561de0cb6b95..512a8f13c4de 100644
>>> --- a/tools/perf/arch/arm64/util/pmu.c
>>> +++ b/tools/perf/arch/arm64/util/pmu.c
>>> @@ -54,10 +54,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
>>>  		perf_pmu__pathname_scnprintf(path, sizeof(path),
>>>  					     pmu->name, "caps/slots");
>>>  		/*
>>> -		 * The value of slots is not greater than 32 bits, but sysfs__read_int
>>> -		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
>>> +		 * The value of slots is not greater than 32 bits, but
>>> +		 * filename__read_int can't read value with 0x prefix,
>>> +		 * so use filename__read_ull instead.
>>>  		 */
>>> -		sysfs__read_ull(path, &slots);
>>> +		filename__read_ull(path, &slots);
>>>  	}
>>>  
>>>  	return slots ? (double)slots : NAN;
>>
>> Yes, the function perf_pmu__pathname_scnprintf returns the complete slots file path "/sys/bus/xxxxx/caps/slots",
>> and sysfs__read_ull will add the prefix "/sys" to the path, so the final file path becomes "/sys/sys/bus/xxxx/caps/slots"
>> which does not exist, and the slots file cannot be successfully read, so sysfs__read_ull needs to be changed to the
>> filename__read_ull.
>>
>> I tested it and it works well.
>>
>> Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> I've applied this to my local branch, thanks.
> 
> I also added the missing:
> 
> Fixes: f8ad6018ce3c065a ("perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH")
> 
> This is another case where a 'perf test' entry would come in handy.
> 
> James, please check and ack,
> 
> - Arnaldo

Oops, looks like the system I tested that on doesn't report slots so it
returns NAN whether it successfully reads the file or not.

I can't think of a test that doesn't just repeat that function so I will
probably say to leave it as is (and we're not currently doing any
automated testing on any platforms that report slots either). It's quite
visible when it breaks because the topdown metrics won't work on
platforms where they should.

Sorry for the breakage!

Acked-by: James Clark <james.clark@arm.com>
