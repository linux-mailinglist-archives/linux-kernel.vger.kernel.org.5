Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D0787608
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbjHXQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbjHXQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:50:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97421B9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:50:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37FD2D75;
        Thu, 24 Aug 2023 09:51:37 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3C73F740;
        Thu, 24 Aug 2023 09:50:54 -0700 (PDT)
Message-ID: <91e45ca9-41ba-a54d-1e0a-01b11b0b27ab@arm.com>
Date:   Thu, 24 Aug 2023 17:50:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/24] x86/resctrl: Track the closid with the rmid
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
 <20230728164254.27562-2-james.morse@arm.com>
 <53c3da82-35d3-cdc9-f5d9-be6cb904a163@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <53c3da82-35d3-cdc9-f5d9-be6cb904a163@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/08/2023 23:32, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index ded1fc7cb7cb..fa66029de41c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -470,7 +480,8 @@ void mon_event_count(void *info)
>>  
>>  	if (rdtgrp->type == RDTCTRL_GROUP) {
>>  		list_for_each_entry(entry, head, mon.crdtgrp_list) {
>> -			if (__mon_event_count(entry->mon.rmid, rr) == 0)
>> +			if (__mon_event_count(rdtgrp->closid, entry->mon.rmid,
>> +					      rr) == 0)
>>  				ret = 0;
>>  		}
>>  	}

> I understand that the parent and child resource groups should have the same
> closid, but that makes me wonder why you use the parent closid in this change,
> but later in the change to mbm_handle_overflow() where the monitor groups are
> traversed you use the closid from the child resource group?

I'd intended to always use the values from the same struct, as that is the least
surprising thing to do. This is the odd one out, I'll fix it.


>> @@ -732,10 +744,11 @@ static int dom_data_init(struct rdt_resource *r)
>>  	}
>>  
>>  	/*
>> -	 * RMID 0 is special and is always allocated. It's used for all
>> -	 * tasks that are not monitored.
>> +	 * CLOSID 0 and RMID 0 are special and are always allocated. These are
>> +	 * used for rdtgroup_default control group, which will be setup later.
>> +	 * See rdtgroup_setup_root().
>>  	 */
>> -	entry = __rmid_entry(0);
>> +	entry = __rmid_entry(0, 0);
> 
> There seems to be an ordering issue here with the hardcoded values for 
> RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID used before those defines
> are introduced in the next patch. That may be ok since this code changes in
> the next patch ... but the comment is left referring to the constant. Maybe
> it would just be clearer if the defines are moved to this patch?

Sure,


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 725344048f85..f7fda4fc2c9e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3252,7 +3252,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  	return 0;
>>  
>>  out_idfree:
>> -	free_rmid(rdtgrp->mon.rmid);
>> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>  out_destroy:
>>  	kernfs_put(rdtgrp->kn);
>>  	kernfs_remove(rdtgrp->kn);
> 
> This does not look right ... as you note in later patches closid_alloc() is called
> _after_ mkdir_rdt_prepare(). Adding rdtgrp->closid to free_rmid() at this point would
> thus use an uninitialized value. I know this code is being moved in subsequent
> patches so it seems the patches may need to be reordered?
> 
>> @@ -3266,7 +3266,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>>  {
>>  	kernfs_remove(rgrp->kn);
>> -	free_rmid(rgrp->mon.rmid);
>> +	free_rmid(rgrp->closid, rgrp->mon.rmid);
>>  	rdtgroup_remove(rgrp);
>>  }
>>  
> 
> Related issue to above. Looking at how mkdir_rdt_prepare_clean() is called, right
> after closid is freed, this seems to be use-after-free?  Another motivation to
> re-order the patches?

It all washes out in the end, and nothing depends on this value until the MPAM support is
merged.

I'll take a look at how invasive it is to re-order the series.


Thanks,

James
