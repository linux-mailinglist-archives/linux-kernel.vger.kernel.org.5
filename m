Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B4787640
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbjHXQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbjHXQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49D711FF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:58:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6731684;
        Thu, 24 Aug 2023 09:59:03 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422743F64C;
        Thu, 24 Aug 2023 09:58:20 -0700 (PDT)
Message-ID: <69a286e4-8e4b-1c26-dc3e-26fa6a533f25@arm.com>
Date:   Thu, 24 Aug 2023 17:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/24] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-GB
To:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
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
 <7425115e-6f2f-d0bf-4d35-c593360f4ded@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7425115e-6f2f-d0bf-4d35-c593360f4ded@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 18/08/2023 23:05, Fenghua Yu wrote:
> On 7/28/23 09:42, James Morse wrote:
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

>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 55bad57a7bd5..b4f611359d1e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

>> @@ -313,6 +316,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>>       struct rdt_domain *d;
>>       u32 idx;
>>   +    /* Walking r->domains, ensure it can't race with cpuhp */
>> +    lockdep_assert_cpus_held();
> 
> When rdtgroup_schemata_write() calls resctrl_arch_update_domains(), I don't see cpus lock
> is held. Is it held in the path?

Good question: like most of the filesystem accesses, this is done by
rdtgroup_kn_lock_live() which now calls cpus_read_lock().


Thanks,

James
