Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519057671E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjG1QfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjG1QfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:35:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DBEA4498
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:35:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DD12F4;
        Fri, 28 Jul 2023 09:35:42 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E5F3F67D;
        Fri, 28 Jul 2023 09:34:56 -0700 (PDT)
Message-ID: <983e6543-41dc-fc29-45ea-d4bc055d3372@arm.com>
Date:   Fri, 28 Jul 2023 17:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/24] x86/resctrl: Access per-rmid structures by index
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
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-3-james.morse@arm.com>
 <13187438-94f4-d6d0-81c2-cdedc0d0243f@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <13187438-94f4-d6d0-81c2-cdedc0d0243f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2023 23:03, Reinette Chatre wrote:
> On 5/25/2023 11:01 AM, James Morse wrote:
>> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
>> monitors, RMID values on arm64 are not unique unless the CLOSID is
> 
> I find the above a bit confusing ... the theme seems to be "RMID values
> on arm64 are not unique because they are different from Intel".
> Compare to: "One of the differences between Intel RDT/AMD QoS and
> Arm's MPAM monitors is that RMID values on arm64 are not unique unless
> the CLOSID is also included."

I'm not too sure what is confusing. I'll pad it out with an example.
Is this clearer?:
--------------%<--------------
x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
used to lookup the control policy, the RMID is used for monitoring. For
x86 these are independent numbers.
Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
used to lookup the control policy. The PMG in contrast is a small number
of bits that are used to subdivide PARTID when monitoring. The
cache-occupancy monitors require the PARTID to be specified when monitoring.

This means MPAM's PMG field is not unique. There are multiple PMG-0, one
per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
need to be sized by the number of unique entries for this resource.

Treat the combined CLOSID and RMID as an index, and provide architecture
helpers to pack and unpack an index. This makes the MPAM values unique.
The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
are domain mbm_local[] and mbm_total[].

x86 can ignore the CLOSID field when packing and unpacking an index, and
report as many indexes as RMID.
--------------%<--------------

>> also included. Bitmaps like rmid_busy_llc need to be sized by the
>> number of unique entries for this resource.
>>
>> Add helpers to encode/decode the CLOSID and RMID to an index. The
>> domain's rmid_busy_llc and rmid_ptrs[] are then sized by index,
>> as are the domain mbm_local and mbm_total arrays.
> 
> You can use "[]" to indicate an array.

>> On x86, the index is always just the RMID, so all these structures
>> remain the same size.
> 
> I do not consider this accurate considering that the previous
> patch increased the size of each element to support this change.

That is a different patch... My point here is that x86's array sizes don't get multiplied
by num_closid, as only arm64 needs that.

I've brushed that wording under the carpet in the text above.


>> The index gives resctrl a unique value it can use to store monitor
>> values, and allows MPAM to decode the CLOSID when reading the hardware
>> counters.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 86574adedd64..bcc25f5339c0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -377,14 +399,16 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>  
>>  void free_rmid(u32 closid, u32 rmid)
>>  {
>> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
>>  	struct rmid_entry *entry;
>>  
>> -	if (!rmid)
>> -		return;
>> -
>>  	lockdep_assert_held(&rdtgroup_mutex);
>>  
>> -	entry = __rmid_entry(closid, rmid);
>> +	/* do not allow the default rmid to be free'd */
>> +	if (!idx)
>> +		return;
>> +
> 
> The interface seem to become blurry here. There are new
> architecture specific encode/decode callbacks while at the same
> time there are a few requirements:
> - closid 0 and rmid 0 are reserved

> - closid 0 and rmid 0 must map to index 0 (the architecture
> callbacks thus do not have must freedom here ... they must
> return index 0 for closid 0 and rmid 0, no?).

It's not supposed to matter, but I agree this check in free_rmid() doesn't decode the
index to check.


> It does seem a bit strange that the one layer provides values (0,0)
> to other layer while requiring a specific answer (0).
> 
> What if RESCTRL_RESERVED_RMID is also introduced and before encoding
> the CLOSID and RMID the core first checks if it is a reserved entry
> being freed and exit early if this is the case?

Sure, that makes this cleaner.


Thanks,

James
