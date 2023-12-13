Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC35811BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjLMSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjLMSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:04:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B392112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:04:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34FDC15;
        Wed, 13 Dec 2023 10:04:59 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59B573F762;
        Wed, 13 Dec 2023 10:04:11 -0800 (PST)
Message-ID: <d0079d15-9950-5c74-75e9-aed848b48ea4@arm.com>
Date:   Wed, 13 Dec 2023 18:04:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 05/24] x86/resctrl: Track the closid with the rmid
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
 <20231025180345.28061-6-james.morse@arm.com>
 <77d92d3e-7259-418f-8b3a-e245dbc3d259@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <77d92d3e-7259-418f-8b3a-e245dbc3d259@amd.com>
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

On 09/11/2023 20:31, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> x86's RMID are independent of the CLOSID. An RMID can be allocated,
>> used and freed without considering the CLOSID.
>>
>> MPAM's equivalent feature is PMG, which is not an independent number,
>> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
>> 'RMID' can be allocated for a single CLOSID.
>> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
>> monitor groups.
>>
>> To allow resctrl to disambiguate RMID values for different CLOSID,
>> everything in resctrl that keeps an RMID value needs to know the CLOSID
>> too. This will always be ignored on x86.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 5d9864919f1c..2a0233cd0bc9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -285,9 +300,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  		if (nrmid >= r->num_rmid)
>>  			break;
>>  
>> -		entry = __rmid_entry(nrmid);
>> +		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
> 
> What is temporary means here? Can you please elaborate(or remove)?

It means this line gets removed in a subsequent patch - don't spend too long rationalising
the values used. This one gets removed in the next patch as __check_limbo() is changed to
operate by index instead.


Thanks,

James
