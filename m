Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5977F6338
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbjKWPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKWPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:45:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2D45C1;
        Thu, 23 Nov 2023 07:45:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C4512FC;
        Thu, 23 Nov 2023 07:46:01 -0800 (PST)
Received: from [10.57.3.62] (unknown [10.57.3.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE0C3F6C4;
        Thu, 23 Nov 2023 07:45:13 -0800 (PST)
Message-ID: <4f959354-74c7-5240-bf8f-78a49fb34437@arm.com>
Date:   Thu, 23 Nov 2023 15:45:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Namhyung Kim <namhyung@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231113112507.917107-1-james.clark@arm.com>
 <20231113112507.917107-4-james.clark@arm.com>
 <CAM9d7ciDq-te1DQPrMrZQC9er0pSMY24nvC-atxdRu1C6uD08A@mail.gmail.com>
 <0bcda96e-df9a-4342-af4e-e4485c33ff55@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <0bcda96e-df9a-4342-af4e-e4485c33ff55@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2023 05:50, Anshuman Khandual wrote:
> 
> 
> On 11/21/23 03:01, Namhyung Kim wrote:
>> On Mon, Nov 13, 2023 at 3:26 AM James Clark <james.clark@arm.com> wrote:
>>> Add documentation for the new Perf event open parameters and
>>> the threshold_max capability file.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  Documentation/arch/arm64/perf.rst | 56 +++++++++++++++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>
>>> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
>>> index 1f87b57c2332..36b8111a710d 100644
>>> --- a/Documentation/arch/arm64/perf.rst
>>> +++ b/Documentation/arch/arm64/perf.rst
>>> @@ -164,3 +164,59 @@ and should be used to mask the upper bits as needed.
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
>>>  .. _tools/lib/perf/tests/test-evsel.c:
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
>>> +
>>> +Event Counting Threshold
>>> +==========================================
>>> +
>>> +Overview
>>> +--------
>>> +
>>> +FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
>>> +events whose count meets a specified threshold condition. For example if
>>> +threshold_compare is set to 2 ('Greater than or equal'), and the
>>> +threshold is set to 2, then the PMU counter will now only increment by
>>> +when an event would have previously incremented the PMU counter by 2 or
>>> +more on a single processor cycle.
>>> +
>>> +To increment by 1 after passing the threshold condition instead of the
>>> +number of events on that cycle, add the 'threshold_count' option to the
>>> +commandline.
>>> +
>>> +How-to
>>> +------
>>> +
>>> +The threshold, threshold_compare and threshold_count values can be
>>> +provided per event:
>>> +
>>> +.. code-block:: sh
>>> +
>>> +  perf stat -e stall_slot/threshold=2,threshold_compare=2/ \
>>> +            -e dtlb_walk/threshold=10,threshold_compare=3,threshold_count/
>> Can you please explain this a bit more?
>>
>> I guess the first event counts stall_slot PMU if the event if it's
>> greater than or equal to 2.  And as threshold_count is not set,
>> it'd count the stall_slot as is.  E.g. it counts 3 when it sees 3.
> 
> Hence without 'threshold_count' being set, the other two config requests
> will not have an effect, is that correct ?

Yeah I can mention this. It's implied because 0 is the default value of
config fields, and 0 is a valid value for compare and count field, so
threshold=0 has to be the way to disable it. But I can mention it
explicitly.

> 
>>
>> OTOH, dtlb_walk will count 1 if it sees an event less than 10.
>> Is my understanding correct?
> 
> 'Equals' and 'Greater-than-or-equal' makes sense and are intuitive. Just
> wondering what will happen for 'Not-equal' and 'Less-than' - when would
> the counter count in such cases ?
> 
>   0: Not-equal
>   1: Equals
>   2: Greater-than-or-equal
>   3: Less-than
> 

They would count when the event is not equal to or less than the
threshold value on any cycle. Probably going into more detail would
start to reproduce what's in the reference manual. All the pseudocode is
in there which describes how it works.

As for use cases, I'm not really sure. It probably wasn't any effort to
add into the hardware with a single not gate, and something could have
been missed if it wasn't added. You might be able to do things like
count the inverse of something without having to open another event to
subtract from to find what the inverse would be.
