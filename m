Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE787FE7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjK3D61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3D6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:58:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92C25D5C;
        Wed, 29 Nov 2023 19:58:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3EB31042;
        Wed, 29 Nov 2023 19:59:17 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A143F5A1;
        Wed, 29 Nov 2023 19:58:26 -0800 (PST)
Message-ID: <c00d54e3-b097-4a61-9d07-dce14ba7801c@arm.com>
Date:   Thu, 30 Nov 2023 09:28:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 framework
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-4-anshuman.khandual@arm.com>
 <5f281bb8-9d74-041f-4311-6d68b5ee271d@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5f281bb8-9d74-041f-4311-6d68b5ee271d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 22:40, James Clark wrote:
> 
> On 14/11/2023 05:13, Anshuman Khandual wrote:
> [...]
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index d712a19e47ac..76f1376ae594 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -317,6 +317,15 @@ armpmu_del(struct perf_event *event, int flags)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int idx = hwc->idx;
>>  
>> +	if (has_branch_stack(event)) {
>> +		WARN_ON_ONCE(!hw_events->brbe_users);
>> +		hw_events->brbe_users--;
>> +		if (!hw_events->brbe_users) {
>> +			hw_events->brbe_context = NULL;
>> +			hw_events->brbe_sample_type = 0;
>> +		}
>> +	}
>> +
>>  	armpmu_stop(event, PERF_EF_UPDATE);
>>  	hw_events->events[idx] = NULL;
>>  	armpmu->clear_event_idx(hw_events, event);
>> @@ -333,6 +342,22 @@ armpmu_add(struct perf_event *event, int flags)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int idx;
>>  
>> +	if (has_branch_stack(event)) {
>> +		/*
>> +		 * Reset branch records buffer if a new task event gets
>> +		 * scheduled on a PMU which might have existing records.
>> +		 * Otherwise older branch records present in the buffer
>> +		 * might leak into the new task event.
>> +		 */
>> +		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
>> +			hw_events->brbe_context = event->ctx;
>> +			if (armpmu->branch_reset)
>> +				armpmu->branch_reset();
> What about a per-thread event following a per-cpu event? Doesn't that
> also need to branch_reset()? If hw_events->brbe_context was already
> previously assigned, once the per-thread event is switched in it skips
> this reset following a per-cpu event on the same core.

Right, guess it is real a possibility. How about folding in something like ..

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 76f1376ae594..15bb80823ae6 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -343,6 +343,22 @@ armpmu_add(struct perf_event *event, int flags)
        int idx;
 
        if (has_branch_stack(event)) {
+               /*
+                * Reset branch records buffer if a new CPU bound event
+                * gets scheduled on a PMU. Otherwise existing branch
+                * records present in the buffer might just leak into
+                * such events.
+                *
+                * Also reset current 'hw_events->brbe_context' because
+                * any previous task bound event now would have lost an
+                * opportunity for continuous branch records.
+                */
+               if (!event->ctx->task) {
+                       hw_events->brbe_context = NULL;
+                       if (armpmu->branch_reset)
+                               armpmu->branch_reset();
+               }
+
                /*
                 * Reset branch records buffer if a new task event gets
                 * scheduled on a PMU which might have existing records.
