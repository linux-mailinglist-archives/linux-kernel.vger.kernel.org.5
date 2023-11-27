Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36467F9B45
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjK0IGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0IGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:06:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11D40B5;
        Mon, 27 Nov 2023 00:06:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF59C2F4;
        Mon, 27 Nov 2023 00:07:01 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00BAA3F6C4;
        Mon, 27 Nov 2023 00:06:09 -0800 (PST)
Message-ID: <2bceeb7f-2c0d-4344-8a4b-a944cbd2f4f8@arm.com>
Date:   Mon, 27 Nov 2023 13:36:06 +0530
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
 <62b84faf-f413-6bfd-5fc1-ac2489e61e00@arm.com>
 <648dc72b-7120-498f-8963-dbdc0d1acce0@arm.com>
 <1d731458-d339-1ffa-0d18-33628634224f@arm.com>
 <6ab8a99b-00cb-4e53-9f95-51fa1f45a3b8@arm.com>
 <9d458499-30b2-77e8-d74c-1623e53539fc@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <9d458499-30b2-77e8-d74c-1623e53539fc@arm.com>
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



On 11/23/23 18:05, James Clark wrote:
> 
> 
> On 21/11/2023 09:57, Anshuman Khandual wrote:
>>
>>
>> On 11/15/23 15:37, James Clark wrote:
>>>
>>>
>>> On 15/11/2023 07:22, Anshuman Khandual wrote:
>>>> On 11/14/23 17:44, James Clark wrote:
>>>>>
>>>>>
>>>>> On 14/11/2023 05:13, Anshuman Khandual wrote:
>>>>> [...]
>>>>>
>>>>>> +/*
>>>>>> + * This is a read only constant and safe during multi threaded access
>>>>>> + */
>>>>>> +static struct perf_branch_stack zero_branch_stack = { .nr = 0, .hw_idx = -1ULL};
>>>>>> +
>>>>>> +static void read_branch_records(struct pmu_hw_events *cpuc,
>>>>>> +				struct perf_event *event,
>>>>>> +				struct perf_sample_data *data,
>>>>>> +				bool *branch_captured)
>>>>>> +{
>>>>>> +	/*
>>>>>> +	 * CPU specific branch records buffer must have been allocated already
>>>>>> +	 * for the hardware records to be captured and processed further.
>>>>>> +	 */
>>>>>> +	if (WARN_ON(!cpuc->branches))
>>>>>> +		return;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Overflowed event's branch_sample_type does not match the configured
>>>>>> +	 * branch filters in the BRBE HW. So the captured branch records here
>>>>>> +	 * cannot be co-related to the overflowed event. Report to the user as
>>>>>> +	 * if no branch records have been captured, and flush branch records.
>>>>>> +	 * The same scenario is applicable when the current task context does
>>>>>> +	 * not match with overflown event.
>>>>>> +	 */
>>>>>> +	if ((cpuc->brbe_sample_type != event->attr.branch_sample_type) ||
>>>>>> +	    (event->ctx->task && cpuc->brbe_context != event->ctx)) {
>>>>>> +		perf_sample_save_brstack(data, event, &zero_branch_stack);
>>>>>
>>>>> Is there any benefit to outputting a zero size stack vs not outputting
>>>>> anything at all?
>>>>
>>>> The event has got PERF_SAMPLE_BRANCH_STACK marked and hence perf_sample_data
>>>> must have PERF_SAMPLE_BRANCH_STACK with it's br_stack pointing to the branch
>>>> records. Hence without assigning a zeroed struct perf_branch_stack, there is
>>>> a chance, that perf_sample_data will pass on some garbage branch records to
>>>> the ring buffer.
>>>>
>>>
>>> I don't think that's an issue, the perf core code handles the case where
>>> no branch stack exists on a sample. It even outputs the zero length for
>>> you, but there is other stuff that can be skipped if you just never call
>>> perf_sample_save_brstack():
>>
>> Sending out perf_sample_data without valid data->br_stack seems problematic,
>> which would be the case when perf_sample_save_brstack() never gets called on
>> the perf_sample_data being prepared, and depend on the below 'else' case for
>> pushing out zero records.
>>
> 
> I'm not following why it would be problematic. data->br_stack is
> initialised to NULL in perf_prepare_sample() and the core code
> specifically has a path that was added for the case where
> perf_sample_save_brstack() was never called.

Without perf_sample_save_brstack() called on the perf sample data will
preserve 'data->br_stack' unchanged as NULL from perf_prepare_sample(),
The perf sample record, will eventually be skipped for 'data->br_stack'
element in perf_output_sample().

void perf_prepare_sample(struct perf_sample_data *data,
                         struct perf_event *event,
                         struct pt_regs *regs)
{
	....
        if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
                data->br_stack = NULL;
                data->dyn_size += sizeof(u64);
                data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
        }
	....
}

void perf_output_sample(struct perf_output_handle *handle,
                        struct perf_event_header *header,
                        struct perf_sample_data *data,
                        struct perf_event *event)
{
	....
        if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
                if (data->br_stack) {
                        size_t size;

                        size = data->br_stack->nr
                             * sizeof(struct perf_branch_entry);

                        perf_output_put(handle, data->br_stack->nr);
                        if (branch_sample_hw_index(event))
                                perf_output_put(handle, data->br_stack->hw_idx);
                        perf_output_copy(handle, data->br_stack->entries, size);
                } else {
                        /*
                         * we always store at least the value of nr
                         */
                        u64 nr = 0;
                        perf_output_put(handle, nr);
                }
        }
	....
}
