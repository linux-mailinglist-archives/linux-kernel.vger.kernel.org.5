Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC0811BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378704AbjLMSE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:04:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D681109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:05:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94934C15;
        Wed, 13 Dec 2023 10:05:48 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB003F762;
        Wed, 13 Dec 2023 10:04:59 -0800 (PST)
Message-ID: <66bb7953-5186-c303-6b47-0f5dcf0ec3ff@arm.com>
Date:   Wed, 13 Dec 2023 18:04:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
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
 <20231025180345.28061-9-james.morse@arm.com>
 <17055477-d381-41e2-86a8-b27f871cba3e@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <17055477-d381-41e2-86a8-b27f871cba3e@amd.com>
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

On 09/11/2023 20:38, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Keep track of the number of RMID held in limbo each CLOSID has. This will
>> allow a future helper to find the 'cleanest' CLOSID when allocating.
>>
>> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
>> defined. This will never be the case on x86.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3c9343dffdf7..9a07707d3eb4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -794,13 +815,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>>  static int dom_data_init(struct rdt_resource *r)
>>  {
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>>  	struct rmid_entry *entry = NULL;
>> +	int err = 0, i;
>>  	u32 idx;
>> -	int i;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>> +		u32 *tmp;
>> +
>> +		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
>> +		if (!tmp) {
>> +			err = -ENOMEM;
>> +			goto out_unlock;
>> +		}
>> +
>> +		closid_num_dirty_rmid = tmp;
>> +	}
> 
> Any reason tmp variable required here?

Line length barking from checkpatch, the resulting newlines and indentation were hard
to read, I figured this was more readable.


>>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
>> -	if (!rmid_ptrs)
>> -		return -ENOMEM;
>> +	if (!rmid_ptrs) {
>> +		kfree(closid_num_dirty_rmid);
> 
> Should there be check here while feeing?
> 
> if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))

Not for the sake of kfree(), which is quite happy with NULL.

But it looks like it is needed for the compiler to realise that closid_num_dirty_rmid
isn't used at all, and can be optimised out - which was my intention.

Thanks, I'll add that.


>> +		err = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>>  
>>  	for (i = 0; i < idx_limit; i++) {
>>  		entry = &rmid_ptrs[i];


Thanks,

James
