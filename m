Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B487D811BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378894AbjLMSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjLMSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:04:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C8A0E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:04:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CC0C15;
        Wed, 13 Dec 2023 10:05:15 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18ED3F762;
        Wed, 13 Dec 2023 10:04:27 -0800 (PST)
Message-ID: <8f1c6ec9-fbd8-4fc1-eeb7-2c6badcd0065@arm.com>
Date:   Wed, 13 Dec 2023 18:04:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index
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
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-7-james.morse@arm.com>
 <ee2cd6ee-4dd5-4505-b059-b65f030a1e1e@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ee2cd6ee-4dd5-4505-b059-b65f030a1e1e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:42, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 0056c9962a44..fc70a2650729 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -604,7 +604,8 @@ static void clear_closid_rmid(int cpu)
>>  	state->default_rmid = 0;
>>  	state->cur_closid = 0;
>>  	state->cur_rmid = 0;
> 
> These assignments can also use the new RESERVED defines, no?

Yup, done.

>> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>> +	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
>> +	      RESCTRL_RESERVED_CLOSID);
>>  }
>>  
> 
> 
> Looks like rdtgroup_setup_default() is also a candidate to replace
> hardcoded "0" for closid and rmid with the new defines.

Sure, done.


>> @@ -670,7 +703,7 @@ void cqm_handle_limbo(struct work_struct *work)
>>  
>>  	__check_limbo(d, false);
>>  
>> -	if (has_busy_rmid(r, d))
>> +	if (has_busy_rmid(d))
>>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>>  
> 
> This change results in a new compile warning:
> 
> arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘cqm_handle_limbo’:
> arch/x86/kernel/cpu/resctrl/monitor.c:805:30: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]
>   805 |         struct rdt_resource *r; 

Hmm, looks like the assignment foxes gcc-12 into thinking this is okay.
I've removed that now.


Thanks,

James
