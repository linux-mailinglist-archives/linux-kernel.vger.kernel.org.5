Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F47671E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjG1Qet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjG1Qeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:34:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C10944B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:34:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888562F4;
        Fri, 28 Jul 2023 09:35:22 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463D93F67D;
        Fri, 28 Jul 2023 09:34:36 -0700 (PDT)
Message-ID: <8a2d824f-0035-7672-c441-88d143b4c73a@arm.com>
Date:   Fri, 28 Jul 2023 17:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Content-Language: en-GB
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-16-james.morse@arm.com>
 <TYAPR01MB6330D9919539D40ADA52B6228B54A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB6330D9919539D40ADA52B6228B54A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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

Hi Shaopeng TAN,

On 12/06/2023 06:39, Shaopeng Tan (Fujitsu) wrote:
>> Depending on the number of monitors available, Arm's MPAM may need to
>> allocate a monitor prior to reading the counter value. Allocating a contended
>> resource may involve sleeping.
>>
>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains, the
>> allocation should be valid for all domains.
>>
>> __check_limbo() and mon_event_count() each make multiple calls to
>> resctrl_arch_rmid_read(), to avoid extra work on contended systems, the
>> allocation should be valid for multiple invocations of resctrl_arch_rmid_read().
>>
>> Add arch hooks for this allocation, which need calling before
>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>> resctrl_arch_rmid_read(), then freed again afterwards. The helper can be
>> called on any CPU, and can sleep.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index fb33100e172b..6d140018358a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -331,9 +331,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>  	struct rmid_entry *entry;
>>  	u32 idx, cur_idx = 1;
>> +	void *arch_mon_ctx;
>>  	bool rmid_dirty;
>>  	u64 val = 0;
>>
>> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r,
>> QOS_L3_OCCUP_EVENT_ID);
>> +	if (arch_mon_ctx < 0)
>> +		return;
>> +
> 
> Would it be better to use IS_ERR() macro?

Yup, much more readable!


Thanks,

James
