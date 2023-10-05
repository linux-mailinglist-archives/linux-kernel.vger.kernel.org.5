Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20637BA78C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJERP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJEROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:14:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F248C3692
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:06:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76D8CC15;
        Thu,  5 Oct 2023 10:07:22 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6013F5A1;
        Thu,  5 Oct 2023 10:06:41 -0700 (PDT)
Message-ID: <9cbbbae4-c1f5-97e1-0d29-b83827d6c70d@arm.com>
Date:   Thu, 5 Oct 2023 18:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-5-james.morse@arm.com>
 <64a2b373-2859-4412-8858-9a99d7e646f5@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <64a2b373-2859-4412-8858-9a99d7e646f5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 04/10/2023 19:01, Moger, Babu wrote:
> On 9/14/23 12:21, James Morse wrote:
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

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7a7369a323b5..d25cb8c9a20e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3189,6 +3189,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>>  	return 0;
>>  }
>>  
>> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
>> +{
>> +	if (rdt_mon_capable)
>> +		free_rmid(rgrp->mon.rmid);
>> +}
>> +
>>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  			     const char *name, umode_t mode,
>>  			     enum rdt_group_type rtype, struct rdtgroup **r)
>> @@ -3254,12 +3260,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  		goto out_destroy;
>>  	}
>>  
>> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> -	if (ret)
>> -		goto out_destroy;
>> -
>> -	kernfs_activate(kn);
> 
> You should not remove "kernfs_activate(kn); from here (only the last line).
> 
> kernfs_create_dir is called in this function.
> 
> /* kernfs creates the directory for rdtgrp */
>  kn = kernfs_create_dir(parent_kn, name, mode, rdtgrp);
> 
> 
> There should be matching kernfs_activate.

I think your point is kernfs_activate() should have been called by the time
mkdir_rdt_prepare() returns because it creates other directories. I don't think this
matters because kernfs_activate() is a tree operation. Sure, the control/monitor group
directory isn't visible once mkdir_rdt_prepare() returns, but by the time either of its
two callers return, changes to the directory tree have been activated.

Moving these lines is the to ensure user-space doesn't see the control/monitor group as
existing without the mon_data directory that is created by mkdir_rdt_prepare_rmid_alloc().


>> -
>>  	/*
>>  	 * The caller unlocks the parent_kn upon success.
>>  	 */
>> @@ -3278,7 +3278,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>>  {
>>  	kernfs_remove(rgrp->kn);
>> -	free_rmid(rgrp->mon.rmid);
>>  	rdtgroup_remove(rgrp);
>>  }
>>  
>> @@ -3300,12 +3299,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>  	prgrp = rdtgrp->mon.parent;
>>  	rdtgrp->closid = prgrp->closid;
>>  
>> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> +	if (ret) {
>> +		mkdir_rdt_prepare_clean(rdtgrp);
>> +		goto out_unlock;
>> +	}
>> +
>> +	kernfs_activate(rdtgrp->kn);
> 
> I dont see the need for this. There is kernfs_activate  inside
> mkdir_rdt_prepare_rmid_alloc (mkdir_rdt_prepare_rmid_alloc
> ->mkdir_mondata_all)  for all the files created.

> Also mkdir_rdt_prepare already has kernfs_activate for the files it created.

It does, and this makes the mon_data directory visible in the parent control/monitor group
- but that control/monitor group isn't visible until this kernfs_activate(rdtgrp->kn)
makes it visible. The scope of these tree operations is different.

Looking at this again, there is an existing problem with the mon_groups directory not
being visible until after the control/monitor group is visible, worse is that if the
mon_group directory creation fails, the control/monitor group is removed. Chances are
no-one is depending on this.

I do think ultimately these kernfs_activate() calls should be moved to the end of the
syscall helpers that change the directory structure. This would stop things being briefly
visible.



Thanks!

James
