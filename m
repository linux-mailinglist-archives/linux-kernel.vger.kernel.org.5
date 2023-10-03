Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801E7B6EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbjJCQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:40:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CE04A7;
        Tue,  3 Oct 2023 09:39:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFC06C15;
        Tue,  3 Oct 2023 09:40:35 -0700 (PDT)
Received: from [10.57.2.226] (unknown [10.57.2.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5060A3F762;
        Tue,  3 Oct 2023 09:39:55 -0700 (PDT)
Message-ID: <df7ba4b1-791c-fd46-18d4-db35f2472fc1@arm.com>
Date:   Tue, 3 Oct 2023 17:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
References: <20230821231608.50911-1-bwicaksono@nvidia.com>
 <f3784fae-154e-784b-bbf2-72dc6ecaf9e9@os.amperecomputing.com>
 <SJ0PR12MB5676E06544970DD8D139F9B5A0C4A@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <SJ0PR12MB5676E06544970DD8D139F9B5A0C4A@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar

On 03/10/2023 15:20, Besar Wicaksono wrote:
> Thanks Ilkka.
> Suzuki/Robin, can we have someone from Arm to review this patch ? It's been a while.
> 

Apologies for the delay.

> Regards,
> Besar
> 
>> -----Original Message-----
>> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Sent: Thursday, September 14, 2023 1:19 PM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>
>> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
>> ilkka@os.amperecomputing.com; catalin.marinas@arm.com; will@kernel.org;
>> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
>> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
>> Sethi <vsethi@nvidia.com>; Richard Wiley <rwiley@nvidia.com>; Eric Funsten
>> <efunsten@nvidia.com>
>> Subject: Re: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Besar,
>>
>> On Mon, 21 Aug 2023, Besar Wicaksono wrote:
>>> Arm Coresight PMU driver consists of main standard code and
>>> vendor backend code. Both are currently built as a single module.
>>> This patch adds vendor registration API to separate the two to
>>> keep things modular. The main driver requests each known backend
>>> module during initialization and defer device binding process.
>>> The backend module then registers an init callback to the main
>>> driver and continue the device driver binding process.
>>>
>>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>
>> I tested the patch with AmpereOne patchset on top of it and it seemed to
>> work fine. In addition, the patch looks good to me.
>>
>> Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>
>>
>> Cheers, Ilkka
>>
>>> ---
>>>
>>> Changes from v5:
>>> * Incorporate review comments.
>>> * Fix arm_cspmu_impl_match_get not returning NULL if no matching impl.
>>> * Fix impl_match.module may reset when registering PMU.
>>> * Maintain backend module ref count until PMU registration is done.
>>> Thanks to Will, Suzuki, and Robin for the feedback.
>>> v5: https://lore.kernel.org/linux-arm-kernel/20230705104745.52255-1-
>> bwicaksono@nvidia.com/T/#u

The changes to address the comments from v5, looks good to me. Thanks
for fixing them.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

