Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BFA7BA78D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJERQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjJERPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:15:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1A873A92
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:07:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6823CC15;
        Thu,  5 Oct 2023 10:07:45 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467CC3F5A1;
        Thu,  5 Oct 2023 10:07:04 -0700 (PDT)
Message-ID: <cbca86ba-c7e8-dde6-2319-dc217427ec93@arm.com>
Date:   Thu, 5 Oct 2023 18:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 08/24] x86/resctrl: Track the number of dirty RMID a
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-9-james.morse@arm.com>
 <3f448b5e-de75-35fa-02ab-7cbd37389227@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <3f448b5e-de75-35fa-02ab-7cbd37389227@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 03/10/2023 22:13, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> @@ -796,13 +817,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
>> +		int *tmp;
>> +
>> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
> 
> Shouldn't this rather be sizeof(unsigned int) to match the type it will store?

It matches the type of tmp... I'll change both closid_num_dirty_rmid and tmp to a u32 *,
and this sizeof() to be sizeof(*tmp).


>> +		if (!tmp) {
>> +			err = -ENOMEM;
>> +			goto out_unlock;
>> +		}
>> +
>> +		closid_num_dirty_rmid = tmp;
>> +	}
>>  
>>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
>> -	if (!rmid_ptrs)
>> -		return -ENOMEM;
>> +	if (!rmid_ptrs) {
>> +		kfree(closid_num_dirty_rmid);
>> +		err = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>>  
>>  	for (i = 0; i < idx_limit; i++) {
>>  		entry = &rmid_ptrs[i];
>> @@ -822,13 +860,21 @@ static int dom_data_init(struct rdt_resource *r)
>>  	entry = __rmid_entry(idx);
>>  	list_del(&entry->list);
>>  
>> -	return 0;
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return err;
>>  }
>>  
>>  void resctrl_exit_mon_l3_config(struct rdt_resource *r)
>>  {
>>  	mutex_lock(&rdtgroup_mutex);
>>  
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>> +		kfree(closid_num_dirty_rmid);
>> +		closid_num_dirty_rmid = NULL;
>> +	}
>> +
>>  	kfree(rmid_ptrs);
>>  	rmid_ptrs = NULL;
>>  
> 
> Awaiting response on patch #2 related to above hunk.

It's the same story here. CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID makes this behaviour
visible to the filesystem code, which means the filesystem code can do the alloc/free of
this array. All this eventually moves out to /fs/.

This is all because the RMID allocation is dependent on the limbo list that resctrl
manages, and for MPAM the CLOSID is too. I'm sure its simpler to expose this MPAM
behaviour to resctrl - and in a way that the compiler can remove if its not needed. The
alternative would be to duplicate the allocators on each architecture. I don't think MPAM
is different enough to justify this.


Thanks,

James
