Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6C7D72B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjJYR5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjJYR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:56:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 058351A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:56:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DFA51474;
        Wed, 25 Oct 2023 10:57:37 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25E2D3F738;
        Wed, 25 Oct 2023 10:56:53 -0700 (PDT)
Message-ID: <b9f4777d-1a3b-25e1-0a6b-c5d8b69e3569@arm.com>
Date:   Wed, 25 Oct 2023 18:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-14-james.morse@arm.com>
 <57554be0-5be8-ee03-a9dc-88deaac43453@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <57554be0-5be8-ee03-a9dc-88deaac43453@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 03/10/2023 22:17, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index b44c487727d4..bd263b9a0abd 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/kernfs.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/slab.h>
>> +#include <linux/tick.h>
>>  #include "internal.h"
>>  
> 
> Please keep the empty line between groups of header files.

(in this case, adding one, but sure)


>> @@ -520,12 +521,24 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int smp_mon_event_count(void *arg)
>> +{
>> +	mon_event_count(arg);
>> +
>> +	return 0;
>> +}
>> +
>>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>>  		    int evtid, int first)
>>  {
>> +	int cpu;
>> +
>> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> 
> This comment is not accurate at this point. It should accompany the code it applies to.
> 
>> +	lockdep_assert_held(&rdtgroup_mutex);

This refers to the d->cpu_mask calls further down this function. These are written to by
the cpuhp callbacks, rdtgroup_mutex is what prevents the cpuhp callback from running at
the same time as mon_event_read(). If that mutex weren't held, you could pick an offline CPU.

Patch 24 changes this to be lockdep_asser_cpus_held(), as the mutex is no longer used for
this purpose.

This got added here instead of patch-24 because I've added additional use of d->cpu_mask,
these things serve to document how that is safe. If you prefer I'll leave it unsaid here,
and add it with all the others in patch24.


Thanks,

James
