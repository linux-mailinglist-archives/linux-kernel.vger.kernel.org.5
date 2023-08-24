Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8903078760F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbjHXQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjHXQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:52:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1725DE51
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:52:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14A661007;
        Thu, 24 Aug 2023 09:52:46 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C733F740;
        Thu, 24 Aug 2023 09:52:02 -0700 (PDT)
Message-ID: <86658d9d-0d8b-d39c-2245-8614b0efc2bc@arm.com>
Date:   Thu, 24 Aug 2023 17:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
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
 <20230728164254.27562-5-james.morse@arm.com>
 <beb61f8e-636f-a0cd-73b4-6294f90092eb@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <beb61f8e-636f-a0cd-73b4-6294f90092eb@intel.com>
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

On 15/08/2023 01:50, Fenghua Yu wrote:
> On 7/28/23 09:42, James Morse wrote:
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

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e7178bbbd30f..7c5cfb373d03 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3336,10 +3344,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>       ret = 0;
>>         rdtgrp->closid = closid;
>> -    ret = rdtgroup_init_alloc(rdtgrp);
>> -    if (ret < 0)
>> +
>> +    ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> +    if (ret)
>>           goto out_id_free;
> 
> Is it better to change "out_id_free" to "out_closid_free"?
> It's not confused to name it "out_id_free" because only closid is freed.
> But this patch introduces new "rmid" free. So it's better to rename the label to
> "out_closid_free" and it matches the following "out_rmid_free" as well.

Yup, makes sense. I only left the existing code alone to avoid too much churn. This way is
much more readable.


Thanks,

James
