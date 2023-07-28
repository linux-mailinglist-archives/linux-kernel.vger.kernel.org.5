Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABED7671E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjG1QgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjG1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:35:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A19D34211
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:35:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ADA92F4;
        Fri, 28 Jul 2023 09:36:14 -0700 (PDT)
Received: from [10.1.27.148] (e125956.cambridge.arm.com [10.1.27.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663E53F67D;
        Fri, 28 Jul 2023 09:35:27 -0700 (PDT)
Message-ID: <aeeb6edf-f34d-03c8-a8a5-6e8e79567936@arm.com>
Date:   Fri, 28 Jul 2023 17:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4 08/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
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
 <20230525180209.19497-9-james.morse@arm.com>
 <348034b1-7bca-a8cf-b5bc-36c656de0bd3@intel.com>
Content-Language: en-US
In-Reply-To: <348034b1-7bca-a8cf-b5bc-36c656de0bd3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/15/23 23:09, Reinette Chatre wrote:
> On 5/25/2023 11:01 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 1e7fa40ee471..128d4c7206e4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -379,6 +379,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>>   	return ERR_PTR(-ENOSPC);
>>   }
>>   
>> +/**
>> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
>> + *                                  RMID are clean, or the CLOSID that has
>> + *                                  the most clean RMID.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator will
>> + * choose the CLOSID with the most clean RMID.
>> + *
>> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
>> + * be returned.
>> + *
>> + * Call when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined. If not, call
>> + * resctrl_closid_alloc_first_free() instead.
> 
> I was not able to find where resctrl_closid_alloc_first_free() is introduced.

Oops, this was the name for the other half of closid_alloc() back when I thought it was more
readable to give it a name. The version posted leaves it alone to reduce the churn. I'll drop this paragraph.


Thanks,

James

