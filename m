Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9E787641
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbjHXQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjHXQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E95B4199D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:58:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0142B165C;
        Thu, 24 Aug 2023 09:58:48 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DDB3F64C;
        Thu, 24 Aug 2023 09:58:04 -0700 (PDT)
Message-ID: <faec8992-2892-ac45-a930-670cc1ab71cc@arm.com>
Date:   Thu, 24 Aug 2023 17:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20230728164254.27562-25-james.morse@arm.com>
 <4085f4f3-7a3e-8af8-1ae3-1040ca78f59f@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4085f4f3-7a3e-8af8-1ae3-1040ca78f59f@intel.com>
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

On 09/08/2023 23:41, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against cpu hotplug. The cpu hotplug
> 
> cpu hotplug -> CPU hotplug
> 
>> code already has a mechanism to do this using cpus_read_lock().
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.
>>
>> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
>> of a cpuhp callback, cpus_read_lock() must always be taken first.
>> rdtgroup_schemata_write() already does this.
>>
>> Most of the filesystem code's domain list walkers are currently
>> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
>> The exceptions are rdt_bit_usage_show() and the mon_config helpers
>> which take the lock directly.
>>
>> Make the domain list protected by RCU. An architecture-specific
>> lock prevents concurrent writers. rdt_bit_usage_show() can
>> walk the domain list under rcu_read_lock(). The mon_config helpers
>> send multiple IPIs, take the cpus_read_lock() in these cases.
>>
>> The other filesystem list walkers need to be able to sleep.
>> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
>> cpuhp callbacks can't be invoked when file system operations are
>> occurring.
>>
>> Add lockdep_assert_cpus_held() in the cases where the
>> rdtgroup_kn_lock_live() call isn't obvious.
>>
>> Resctrl's domain online/offline calls now need to take the
>> rdtgroup_mutex themselves.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index a256a96df487..47dcf2cb76ca 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -954,7 +958,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>>  
>>  	mutex_lock(&rdtgroup_mutex);
>>  	hw_shareable = r->cache.shareable_bits;
>> -	list_for_each_entry(dom, &r->domains, list) {
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(dom, &r->domains, list) {
>>  		if (sep)
>>  			seq_putc(seq, ';');
>>  		sw_shareable = 0;
> 
> Does rdt_bit_usage_show() really need RCU? It is another filesystem callback and I
> do not see a reason why it should access the domain list in a different way. It
> can follow the same pattern as all the other resctrl filesystem ops and use
> cpus_read_lock().

It doesn't today, and it was useful to have an example where RCU was used.
I'll make this call cpus_read_lock() instead.


Thanks,

James
