Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438079CF03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjILK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjILK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:57:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 596731726;
        Tue, 12 Sep 2023 03:57:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA7CC15;
        Tue, 12 Sep 2023 03:58:02 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E69673F67D;
        Tue, 12 Sep 2023 03:57:22 -0700 (PDT)
Message-ID: <48c40672-caab-68ef-cbd7-640f5a39e639@arm.com>
Date:   Tue, 12 Sep 2023 11:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf cs-etm: Fix kernel timestamp handling
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230910092413.53538-1-leo.yan@linaro.org>
 <04823db9-ed6c-0695-b9de-5a63bfa0aa5a@arm.com>
 <20230912015204.GA122656@leoy-huanghe>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230912015204.GA122656@leoy-huanghe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 02:52, Leo Yan wrote:
> Hi James,
> 
> On Mon, Sep 11, 2023 at 02:24:09PM +0100, James Clark wrote:
> 
> [...]
> 
>>> The current code can support both timestamp sources when synthesizing
>>> samples. However, the decoding flow only relies on the hardware
>>> timestamp.  If the hardware timestamp is zero, it becomes impossible to
>>> decode the trace data.  Consequently, in this case, the commands below
>>> won't output any samples:
>>>
>>>     perf record -e cs_etm// --per-thread --timestamp -- ls
>>>     perf script
>>
>> Hi Leo,
>>
>> I couldn't reproduce this issue, even when hard coding the hardware
>> timestamp to zero in cs_etm_decoder__do_hard_timestamp() like this:
>>
>>  converted_timestamp = 0;
> 
> I reproduced this issue on the Juno-r2 board, its "etm->has_virtual_ts"
> is always false and Arm CoreSight timestamp packets are zeros.
> 
> Besides set "converted_timestamp = 0", it might need to hard code
> "etm->has_virtual_ts" to false?
> >> I'm not sure why this would result in no samples being generated either,
>> because we don't actually use the timestamps for anything yet [1]. We
>> always wait until the very end of the file before decoding to ensure
>> that all of the mmaps are loaded. And the timestamp is just assigned to
>> the samples, but they shouldn't affect whether they are generated or not.
>>
>> Unless there is something else I'm missing?
> 
> Let's review below code.
> 
> cs_etm__queue_first_cs_timestamp() retrieves trace data and decodes it,
> and breaks the while loop until it find the timestamp is not zero or no
> trace data is avaliable.  When the timestamp is always zero, the while
> loop continues to drop the CoreSight trace data and don't synthesize
> samples.
> 
>   cs_etm__queue_first_cs_timestamp()
>   {
>       ...
> 
>       while(1) {
>           ret = cs_etm__get_data_block(etmq);
>           if (ret <= 0)
>               goto out;
> 
>           ret = cs_etm__decode_data_block(etmq);
>           if (ret)
>               goto out;
> 
>           cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>           /* We found a timestamp, no need to continue. */
>           if (cs_timestamp)
>               break;
> 
>           cs_etm__clear_all_packet_queues(etmq);
>       }
>   }
> 

Ah, I couldn't reproduce it because I was missing your other patch to
add Coresight timestamps when Perf timestamps are requested. If I add
that patch or force Coresight timestamps then I can reproduce the issue:

   $ perf record -e cs_etm/timestamp=1/ --per-thread --timestamp -- ls

But when running perf script I get this warning:

 Zero Coresight timestamp found at Idx:39. Decoding may be improved by
 prepending 'Z' to your current --itrace arguments.

And then if I force timeless mode like it says to do I get samples:

 $ perf script --itrace=Zi1000i

I'm not sure if silently making it use the kernel timestamp for sorting
makes sense, especially when zero hardware timestamps are a bug, and we
already have a warning and a workaround for it.

Also it would mean that you are requesting timestamps on a platform that
isn't generating them. Maybe the fix could also just be to not request
timestamps, and then it uses the timeless decoding flow that also works:

   $ perf record -e cs_etm/timestamp=0/ --per-thread --timestamp -- ls

My worry is that mixing kernel and coresight timestamps for sorting
could make the code confusing to reason about, and sorting based on a
single static AUX timestamp doesn't make sense logically (it's almost
like a hack where the side effect is to make it work). And there isn't
really anything that there isn't already a workaround for. Unless you
want to explicitly disable the "use the Z option" warning and make it
work transparently? Which I'm not sure is the right thing to do.


>> Also, in cs_etm__queue_first_cs_timestamp(), cs_timestamp is used for
>> sorting the decoding order between CPUs, but if the hardware timestamp
>> is 0, then it's 0 on all trace.
> 
> Correct.
> 
>> So the sorting would be the same if you change that to be the kernel
>> timestamp. They're all still the same
>> static number, but just a different number (because we wait until the
>> end of the file, 'latest_kernel_timestamp' is always the timestamp of
>> the last AUX event in the file).
> 
> If we use the 'latest_kernel_timestamp' as timestamp, it's non-zero
> timestamp rather than all timestamp '0'.  Yes, 'latest_kernel_timestamp'
> is a coarse kernel timestamp which is shared by all trace data recorded
> in the AUX event, though it's a static number, it can allow us to break
> the while loop mentioned above.
> 
> I understand 'latest_kernel_timestamp' is inaccurate for sorting, but
> as least now it exists in current code, quotes from util/cs-etm.c:
> 
>   /*
>    * Record the latest kernel timestamp available in the header   
>    * for samples so that synthesised samples occur from this point
>    * onwards.
>    */
>   if (sample->time && (sample->time != (u64)-1))
>         etm->latest_kernel_timestamp = sample->time;
> 
>> [1]: I still plan to change the decoding to decode up to the current
>> time in the file, rather than waiting for the end of the file before
>> starting. That way decoding trace when there were overlapping mmap
>> regions in time will be more accurate.
> 
> Thanks for heading up.  I am not sure if I understand this correctly,
> but seems to me it is a good thing to try for using overlapping mmap
> events.
> 
> Just a side topic, if an Arm platform connect the Arm timer counter to
> Arm CoreSight, and detect virtual timestamp is false (thus
> etm->has_virtual_ts is 0).  I think this might happen on some legacy
> platforms, can we use some ways to allow users to still use the Arm
> CoreSight timestamp in this case?  E.g. we can force set
> etm->has_virtual_ts to 1 when user specify the config
> '-e cs_etm/timestamp/'.
> 
> Thanks,
> Leo
