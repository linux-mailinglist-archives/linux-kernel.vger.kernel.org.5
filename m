Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD5787609
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbjHXQwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbjHXQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:51:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7097F1B9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:51:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA5E1007;
        Thu, 24 Aug 2023 09:52:33 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75CD63F740;
        Thu, 24 Aug 2023 09:51:50 -0700 (PDT)
Message-ID: <dee72388-764e-a123-13a8-3a47341c8c55@arm.com>
Date:   Thu, 24 Aug 2023 17:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/24] x86/resctrl: Access per-rmid structures by index
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
 <20230728164254.27562-3-james.morse@arm.com>
 <d93950f3-1ceb-9652-f223-f6e550f8a818@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <d93950f3-1ceb-9652-f223-f6e550f8a818@intel.com>
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

On 09/08/2023 23:32, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> @@ -377,14 +399,17 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
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
>> +	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
>> +						RESCTRL_RESERVED_RMID))
>> +		return;
>> +

> Why is this encoding necessary? Can the provided function parameters
> not be tested directly against RESCTRL_RESERVED_CLOSID and
> RESCTRL_RESERVED_RMID ?

Doing this by encoding means if the architecture code supplies an
resctrl_arch_rmid_idx_encode() that ignores the closid, this reduces down to:
| if (rmid == RESCTRL_RESERVED_RMID)

which is what the code did before. I'll add a comment:
|	/*
|	 * Do not allow RESCTRL_RESERVED_RMID to be free'd. Comparing by index
|	 * allows architectures that ignore the closid parameter to avoid an
|	 * unnecessary check.
|	 */


Thanks,

James



