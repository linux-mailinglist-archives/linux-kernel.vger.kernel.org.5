Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF067F2A75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjKUKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:33:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD42995;
        Tue, 21 Nov 2023 02:33:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37575FEC;
        Tue, 21 Nov 2023 02:34:29 -0800 (PST)
Received: from [10.57.42.32] (unknown [10.57.42.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19443F73F;
        Tue, 21 Nov 2023 02:33:40 -0800 (PST)
Message-ID: <0058ca82-e55b-4490-90d0-871afce787c7@arm.com>
Date:   Tue, 21 Nov 2023 10:33:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
Content-Language: en-GB
To:     Namhyung Kim <namhyung@gmail.com>,
        James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, will@kernel.org,
        mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231113112507.917107-1-james.clark@arm.com>
 <20231113112507.917107-4-james.clark@arm.com>
 <CAM9d7ciDq-te1DQPrMrZQC9er0pSMY24nvC-atxdRu1C6uD08A@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAM9d7ciDq-te1DQPrMrZQC9er0pSMY24nvC-atxdRu1C6uD08A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 21:31, Namhyung Kim wrote:
> On Mon, Nov 13, 2023 at 3:26 AM James Clark <james.clark@arm.com> wrote:
>>
>> Add documentation for the new Perf event open parameters and
>> the threshold_max capability file.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   Documentation/arch/arm64/perf.rst | 56 +++++++++++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>
>> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
>> index 1f87b57c2332..36b8111a710d 100644
>> --- a/Documentation/arch/arm64/perf.rst
>> +++ b/Documentation/arch/arm64/perf.rst
>> @@ -164,3 +164,59 @@ and should be used to mask the upper bits as needed.
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
>>   .. _tools/lib/perf/tests/test-evsel.c:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
>> +
>> +Event Counting Threshold
>> +==========================================
>> +
>> +Overview
>> +--------
>> +
>> +FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
>> +events whose count meets a specified threshold condition. For example if
>> +threshold_compare is set to 2 ('Greater than or equal'), and the
>> +threshold is set to 2, then the PMU counter will now only increment by
>> +when an event would have previously incremented the PMU counter by 2 or
>> +more on a single processor cycle.
>> +
>> +To increment by 1 after passing the threshold condition instead of the
>> +number of events on that cycle, add the 'threshold_count' option to the
>> +commandline.
>> +
>> +How-to
>> +------
>> +
>> +The threshold, threshold_compare and threshold_count values can be
>> +provided per event:
>> +
>> +.. code-block:: sh
>> +
>> +  perf stat -e stall_slot/threshold=2,threshold_compare=2/ \
>> +            -e dtlb_walk/threshold=10,threshold_compare=3,threshold_count/
> 
> Can you please explain this a bit more?
> 
> I guess the first event counts stall_slot PMU if the event if it's
> greater than or equal to 2.  And as threshold_count is not set,
> it'd count the stall_slot as is.  E.g. it counts 3 when it sees 3.
> 
> OTOH, dtlb_walk will count 1 if it sees an event less than 10.
> Is my understanding correct?

That is correct. The behavior is described in the paragraph above.
But I agree that it would be really helpful if we explained with the
example above.

> 
>> +
>> +And the following comparison values are supported:
>> +
>> +.. code-block::
>> +
>> +  0: Not-equal
>> +  1: Equals
>> +  2: Greater-than-or-equal
>> +  3: Less-than
> 
> So the above values are for threashold_compare, right?
> It'd be nice if it's more explicit.
> 
> Similarly, it'd be helpful to have a description for the
> threshold and threshold_count fields.

Agreed.

Suzuki



> 
> Thanks,
> Namhyung
> 
>> +
>> +The maximum supported threshold value can be read from the caps of each
>> +PMU, for example:
>> +
>> +.. code-block:: sh
>> +
>> +  cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
>> +
>> +  0x000000ff
>> +
>> +If a value higher than this is given, then it will be silently clamped
>> +to the maximum. The highest possible maximum is 4095, as the config
>> +field for threshold is limited to 12 bits, and the Perf tool will refuse
>> +to parse higher values.
>> +
>> +If the PMU doesn't support FEAT_PMUv3_TH, then threshold_max will read
>> +0, and both threshold and threshold_compare will be silently ignored.
>> +threshold_max will also read as 0 on aarch32 guests, even if the host
>> +is running on hardware with the feature.
>> --
>> 2.34.1
>>
>>

