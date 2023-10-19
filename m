Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B737CF4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJSKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjJSKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:14:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5933C9F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:14:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 735992F4;
        Thu, 19 Oct 2023 03:15:18 -0700 (PDT)
Received: from [10.57.68.163] (unknown [10.57.68.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AECBE3F5A1;
        Thu, 19 Oct 2023 03:14:33 -0700 (PDT)
Message-ID: <0d8ccead-d4e0-47d6-91f0-69709086c3a7@arm.com>
Date:   Thu, 19 Oct 2023 11:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: cpufeature: Change 32-bit EL0 to display
 enabled cores
Content-Language: en-GB
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com,
        krisman@suse.de, broonie@kernel.org, james.morse@arm.com,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org
References: <20231017052322.1211099-1-jeremy.linton@arm.com>
 <20231017052322.1211099-4-jeremy.linton@arm.com>
 <86ttqpm8lg.wl-maz@kernel.org> <f3fc7881-c965-2b1d-8430-b8c18783cb7b@arm.com>
 <86pm1cm780.wl-maz@kernel.org> <25ba377a-c590-1a1c-6be3-e268a6b300c9@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <25ba377a-c590-1a1c-6be3-e268a6b300c9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18 16:42, Jeremy Linton wrote:
> On 10/18/23 07:43, Marc Zyngier wrote:
>> On Tue, 17 Oct 2023 20:15:43 +0100,
>> Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> On 10/17/23 13:01, Marc Zyngier wrote:
>>>> On Tue, 17 Oct 2023 06:23:22 +0100,
>>>> Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>>>
>>>>> Now that we have the ability to display the list of cores
>>>>> with a feature when it is selectivly enabled, lets display the
>>>>> cores enabled for 32-bit use at EL0.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>    arch/arm64/kernel/cpufeature.c | 15 +++++++++++++--
>>>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpufeature.c 
>>>>> b/arch/arm64/kernel/cpufeature.c
>>>>> index b7b67bac0e60..512cbe446b41 100644
>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>> @@ -1533,8 +1533,17 @@ static bool has_32bit_el0(const struct 
>>>>> arm64_cpu_capabilities *entry, int scope)
>>>>>        if (!has_cpuid_feature(entry, scope))
>>>>>            return allow_mismatched_32bit_el0;
>>>>>    -    if (scope == SCOPE_SYSTEM)
>>>>> -        pr_info("detected: 32-bit EL0 Support\n");
>>>>> +    if (scope == SCOPE_SYSTEM) {
>>>>> +        struct arm64_cpu_capabilities *has_32bit;
>>>>> +
>>>>> +        has_32bit = (struct arm64_cpu_capabilities *)entry;
>>>>> +
>>>>> +        has_32bit->cpus = system_32bit_el0_cpumask();
>>>>
>>>> This seems rather dodgy. 'entry' comes from a static const array which
>>>> will, in all likelihood be mapped R/O pretty soon after the initial
>>>> CPU bringup. Try offlining/onlining a CPU and you should see a
>>>> firework similar to what I have below (I hacked the CnP property, but
>>>> that's no different from what you are doing):
>>>
>>> Yes, dodgy is a good word. The other choices, maintain a mask just for
>>> the print or dump the static key and always use the cpu_32bit_el0_mask
>>> or some combination, weren't much better in the "ick" category. If
>>> anyone sees a better way I'm open to suggestion, although simply
>>> dropping this last patch is fine too.
>>
>> An obvious choice would be to replace the 'cpus' cpumask with a
>> function that evaluates a cpumask stored separately.
> 
> Right, I was too busy trying to cleanup the 32-bit mask, that works too.

But if a cpumask does already exist, wouldn't the *most* logical thing 
be to use it? If it is somehow harmful to the existing machinery to set 
all of the CPUs in cpu_32bit_el0_mask if all of the CPUs support 32-bit 
EL0, that seems like a mind-bogglingly dumb design which deserves fixing 
in its own right.

To me the obvious thing would be to allocate and populate 
cpu_32bit_el0_mask unconditionally so the initial feature detection can 
work as normal, and then if anyone's really really bothered, free it 
again later if we determine there's no mismatch.

Thanks,
Robin.
