Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031BB775364
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjHIHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:02:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0696919BC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:02:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC73211FB;
        Wed,  9 Aug 2023 00:02:43 -0700 (PDT)
Received: from [10.163.54.83] (unknown [10.163.54.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773AD3F64C;
        Wed,  9 Aug 2023 00:01:58 -0700 (PDT)
Message-ID: <a6b50669-37f2-98dd-e137-c76add8edbc0@arm.com>
Date:   Wed, 9 Aug 2023 12:31:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-2-anshuman.khandual@arm.com>
 <89058c7c-1fed-60ea-7233-04187772a931@arm.com>
 <20230804163921.GE30679@willie-the-truck>
 <9b630f76-2f9e-fc42-012e-403f4b8c1dee@arm.com>
 <20230808132157.GB2369@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230808132157.GB2369@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 18:51, Will Deacon wrote:
> On Mon, Aug 07, 2023 at 11:03:40AM +0530, Anshuman Khandual wrote:
>> On 8/4/23 22:09, Will Deacon wrote:
>>> On Thu, Aug 03, 2023 at 11:43:27AM +0530, Anshuman Khandual wrote:
>>>> On 8/3/23 11:26, Anshuman Khandual wrote:
>>>>> +	/*
>>>>> +	 * Sanity check all the GICC tables for the same interrupt
>>>>> +	 * number. For now, only support homogeneous ACPI machines.
>>>>> +	 */
>>>>> +	for_each_possible_cpu(cpu) {
>>>>> +		struct acpi_madt_generic_interrupt *gicc;
>>>>> +
>>>>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>>>>> +		if (gicc->header.length < len)
>>>>> +			return gsi ? -ENXIO : 0;
>>>>> +
>>>>> +		this_gsi = parse_gsi(gicc);
>>>>> +		if (!this_gsi)
>>>>> +			return gsi ? -ENXIO : 0;
>>>>
>>>> Moved parse_gsi() return code checking to its original place just to
>>>> make it similar in semantics to existing 'gicc->header.length check'.
>>>> If 'gsi' is valid i.e atleast a single cpu has been probed, return
>>>> -ENXIO indicating mismatch, otherwise just return 0.
>>>
>>> Wouldn't that still be the case without the check in this hunk? We'd run
>>> into the homogeneous check and return -ENXIO from there, no?
>> Although the return code will be the same i.e -ENXIO, but not for the same reason.
>>
>> 		this_gsi = parse_gsi(gicc);
>> 		if (!this_gsi)
>> 			return gsi ? -ENXIO : 0;
>>
>> This returns 0 when IRQ could not be parsed for the first cpu, but returns -ENXIO
>> for subsequent cpus. Although return code -ENXIO here still indicates IRQ parsing
>> to have failed.
>>
>> 		} else if (hetid != this_hetid || gsi != this_gsi) {
>> 			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
>> 			return -ENXIO;
>> 		} 
>>
>> This returns -ENXIO when there is a IRQ mismatch. But if the above check is not
>> there, -ENXIO return code here could not be classified into IRQ parse problem or
>> mismatch without looking into the IRQ value.
> 
> Sorry, but I don't understand your point here. If any of this fails, there's
> going to be some debugging needed to look at the ACPI tables; the only
> difference with my suggestion is that you'll get a message indicating that
> the devices aren't homogeneous, which I think is helpful.

I dont have strong opinion either way. Hence will move 'this_gsi' check inside the
!gsi conditional check like you had suggested earlier.
