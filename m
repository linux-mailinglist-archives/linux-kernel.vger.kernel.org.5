Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294D787615
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbjHXQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242757AbjHXQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:53:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959391BD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:53:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88AAD1007;
        Thu, 24 Aug 2023 09:53:54 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA2F3F740;
        Thu, 24 Aug 2023 09:53:11 -0700 (PDT)
Message-ID: <20b566d9-448b-5367-b4db-593466e7a2f8@arm.com>
Date:   Thu, 24 Aug 2023 17:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
 <03cd7ac4-b58d-c7a8-7cb9-ebcc770d21f0@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <03cd7ac4-b58d-c7a8-7cb9-ebcc770d21f0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/08/2023 23:33, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index de91ca781d9f..44addc0126fc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -43,6 +43,13 @@ struct rmid_entry {
>>   */
>>  static LIST_HEAD(rmid_free_lru);
>>  
>> +/**
>> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
>> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
>> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
>> + */
>> +static int *closid_num_dirty_rmid;
>> +
> 
> Will the values ever be negative?

Nope, int is just fewer keystrokes. I'll change it to unsigned int.


>>  /**
>>   * @rmid_limbo_count     count of currently unused but (potentially)
>>   *     dirty RMIDs.


>> @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>>  static int dom_data_init(struct rdt_resource *r)
>>  {
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>>  	struct rmid_entry *entry = NULL;
>>  	u32 idx;
>>  	int i;
>>  
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>> +		int *tmp;
>> +
>> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
>> +		if (!tmp)
>> +			return -ENOMEM;
>> +
>> +		mutex_lock(&rdtgroup_mutex);
>> +		closid_num_dirty_rmid = tmp;
>> +		mutex_unlock(&rdtgroup_mutex);
>> +	}
>> +
> 
> It does no harm but I cannot see why the mutex is needed here. 

It's belt-and-braces to ensure that all accesses to that global variable are protected by
that lock. This avoids giving me a memory ordering headache.
rmid_ptrs and the call to __rmid_entry() that dereferences it should probably get the same
treatment.

I'll move the locking to the caller as the least-churny way of covering both.


>>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
>> -	if (!rmid_ptrs)
>> +	if (!rmid_ptrs) {
>> +		kfree(closid_num_dirty_rmid);
>>  		return -ENOMEM;
>> +	}
>>  
>>  	for (i = 0; i < idx_limit; i++) {
>>  		entry = &rmid_ptrs[i];
> 
> How will this new memory be freed? Actually I cannot find where
> rmid_ptrs is freed either .... is a "dom_data_free()" needed?

Oh that's not deliberate? :P

rmid_ptrs has been immortal since the beginning. The good news is resctrl_exit() goes in
the exitcall section, which is in the DISCARDS section of the linker script as resctrl
can't be built as a module. It isn't possible to tear resctrl down, so no-one will notice
this leak.

Something on my eternal-todo-list is to make the filesystem parts of resctrl a loadable
module (if Tony doesn't get there first!). That would flush this sort of thing out.
Last time I triggered resctrl_exit() manually not all of the files got cleaned up - I
haven't investigated it further.


I agree it should probably have a kfree() call somewhere under rdtgroup_exit(), as its
only the L3 that needs any of this, I'll add resctrl_exit_mon_l3_config() for
rdtgroup_exit() to call.

Another option is to rip out all the __exit text as its discarded anyway. But if loadable
modules is the direction of travel, it probably make more sense to fix it.


Thanks,

James
