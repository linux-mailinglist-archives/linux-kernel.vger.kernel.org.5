Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8043811BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjLMSDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjLMSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:03:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DDADDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:03:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FB2C15;
        Wed, 13 Dec 2023 10:04:34 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68DFD3F762;
        Wed, 13 Dec 2023 10:03:46 -0800 (PST)
Message-ID: <3a471478-1370-15e1-c5dc-74b9cdd3533d@arm.com>
Date:   Wed, 13 Dec 2023 18:03:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-5-james.morse@arm.com>
 <ef995760-40d8-4cb9-9d51-0b9fa56dd3c5@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ef995760-40d8-4cb9-9d51-0b9fa56dd3c5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 09/11/2023 20:29, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> RMID are allocated for each monitor or control group directory, because
>> each of these needs its own RMID. For control groups,
>> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>>
>> MPAM's equivalent of RMID is not an independent number, so can't be
>> allocated until the CLOSID is known. An RMID allocation for one CLOSID
>> may fail, whereas another may succeed depending on how many monitor
>> groups a control group has.
>>
>> The RMID allocation needs to move to be after the CLOSID has been
>> allocated.
>>
>> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
>> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
>> know the CLOSID.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1eb3a3075093..8fb0f56f64be 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3317,6 +3317,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>>  	return 0;
>>  }
>>  
>> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
>> +{
>> +	if (rdt_mon_capable)
>> +		free_rmid(rgrp->mon.rmid);
>> +}
> 
> The check if (rdt_mon_capable) is extra here. Not required. Otherwise
> looks good.

It pairs with the behaviour of mkdir_rdt_prepare_rmid_alloc(), which returns early if
(!rdt_mon_capable). This avoids double-adding rmid-0 to the limbo list.


> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks! I assume you're happy with my above description of the rdt_mon_capable check is
needed.


Thanks,

James
