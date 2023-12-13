Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B1811BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379333AbjLMSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:04:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C86E4106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:04:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD02C15;
        Wed, 13 Dec 2023 10:05:33 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 788EE3F762;
        Wed, 13 Dec 2023 10:04:44 -0800 (PST)
Message-ID: <6574ef0d-bc23-0c2c-e575-dbb5978f57b0@arm.com>
Date:   Wed, 13 Dec 2023 18:04:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 08/24] x86/resctrl: Track the number of dirty RMID a
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
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-9-james.morse@arm.com>
 <2033865a-b57b-4956-8ab6-d749ad782aa3@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2033865a-b57b-4956-8ab6-d749ad782aa3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:43, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> @@ -794,13 +815,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
>> +		u32 *tmp;
>> +
>> +		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
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
> 
> Since this is a global variable and resctrl keeps running on this alloc
> failure I think it will be safer to add a:
> 	
> 		closid_num_dirty_rmid = NULL

Yup, I had that for dom_data_exit(), but missed it here.


> With that added you can add:
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

James
