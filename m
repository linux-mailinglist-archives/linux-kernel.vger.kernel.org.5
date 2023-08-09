Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3977637F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHIPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjHIPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:14:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D124D1;
        Wed,  9 Aug 2023 08:14:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BAD9D75;
        Wed,  9 Aug 2023 08:15:31 -0700 (PDT)
Received: from [10.57.1.30] (unknown [10.57.1.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893FD3F59C;
        Wed,  9 Aug 2023 08:14:45 -0700 (PDT)
Message-ID: <88350646-50c9-b7a6-9fe6-47b6b0a31f49@arm.com>
Date:   Wed, 9 Aug 2023 16:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230807142138.288713-1-james.clark@arm.com>
 <20230807142138.288713-6-james.clark@arm.com>
 <6b3d8f28-9a38-d544-e396-706022f2e5f5@oracle.com>
 <a4b93320-cf5d-9622-77fe-f51e1ec7f75b@arm.com>
 <80e089f6-12ab-b33c-d299-3f762e3a8d4f@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <80e089f6-12ab-b33c-d299-3f762e3a8d4f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2023 14:54, John Garry wrote:
> On 09/08/2023 14:06, James Clark wrote:
>>> "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if
>>> (cpuid_less_than(410fd493)) else (stall_slot - cpu_cycles)) / (#slots *
>>> cpu_cycles))"
>>>
>>> I'm currently figuring out how cpuid_less_than() would be implemented
>>> (I'm no great python wrangler), but it would be along the lines of what
>>> Ian added for "has_event" in
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!PlOppEWtIj9jDW2Zlon0zRZVpzPTzPvm5Ho5NnRIN0vD78iFcEzMEAtsrW_MrRPiW84XhWpbhc3seQcmLu-BfQ$ 
>>> Thanks,
>>> John
>> Yeah it looks like it could be done that way. Also, the way I added it,
>> it doesn't have access to the PMU type, it just does a generic
>> pmu__find_core_pmu() so won't work very well for heterogeneous systems.
> 
> I haven't been keeping a close eye on the hybrid PMU support, but AFAIK
> metrics for hybrid arm64 system, i.e. bL, aren't supported - maybe that
> has changed. The gating for bL support was in pmu__find_core_pmu()
> returning NULL for a hybrid system.
> 

Yes we're not currently publishing any metrics for hybrid systems, so in
this case for N2 and V2 it's not needed. But it would be good to try to
future proof it if possible. Although I don't know how the metrics
currently react on hybrid systems, it's also something I have to take a
look at.


>>
>> If we're going to do a deeper modification of the expression parser like
>> with has_event() it might be possible to pass in the actual CPU ID that
>> the metric is running on which would be better.
>>
>> I'll have a look.
> 
> Thanks. I was playing with this yesterday, but I was making slow
> progress. I was essentially following the has_event example, but the
> argument type causes an issue, in that has_event expected an event name,
> while we want to pass a hex string.
> 
> If you could check this then that would be great.
> 
> Thanks,
> John
> 
