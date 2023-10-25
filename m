Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE337D72BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjJYR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJYR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:58:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8CB0191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:58:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 838B81516;
        Wed, 25 Oct 2023 10:58:57 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9093F738;
        Wed, 25 Oct 2023 10:58:11 -0700 (PDT)
Message-ID: <bcd6e00a-55a8-f275-5675-36865cc53b28@arm.com>
Date:   Wed, 25 Oct 2023 18:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20230914172138.11977-16-james.morse@arm.com>
 <14289ca5-5e33-6cfc-fe65-e5fd9651ed99@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <14289ca5-5e33-6cfc-fe65-e5fd9651ed99@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 05/10/2023 22:46, Moger, Babu wrote:
> On 9/14/2023 12:21 PM, James Morse wrote:
>> Depending on the number of monitors available, Arm's MPAM may need to
>> allocate a monitor prior to reading the counter value. Allocating a
>> contended resource may involve sleeping.
>>
>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
>> the allocation should be valid for all domains.
>>
>> __check_limbo() and mon_event_count() each make multiple calls to
>> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
>> the allocation should be valid for multiple invocations of
>> resctrl_arch_rmid_read().
>>
>> Add arch hooks for this allocation, which need calling before
>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>> resctrl_arch_rmid_read(), then freed again afterwards. The helper
>> can be called on any CPU, and can sleep.

>>   diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f7311102e94c..5e4b4df9610b 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -235,6 +235,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct
>> rdt_domain *d);
>>    * @rmid:        rmid of the counter to read.
>>    * @eventid:        eventid to read, e.g. L3 occupancy.
>>    * @val:        result of the counter read in bytes.
>> + * @arch_mon_ctx:    An architecture specific value from
>> + *            resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
>> + *            the hardware monitor allocated for this read request.
>>    *
>>    * Some architectures need to sleep when first programming some of the counters.
>>    * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
>> @@ -248,7 +251,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct
>> rdt_domain *d);
>>    */
>>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>                  u32 closid, u32 rmid, enum resctrl_event_id eventid,
>> -               u64 *val);
>> +               u64 *val, void *arch_mon_ctx);

> Just wondering.. Have you thought about passing rmid_read structure to this function?

I did, but I'd prefer to leave that as private to resctrl as the proposed PMU driver ends
up using this API too.


> Because most of the information is already inside the rmid_read structure. We can avoid
> passing 7 parameters.

We'd end up passing all these parameters via memory ... but the compiler knows when it has
to do this, and when it doesn't. For example on aarch64 the compiler knows it can pass all
seven of these arguments in registers. On x86_64 it looks like 6 arguments can be passed,
and the last one is never used on x86 so it never needs reading off the stack. (all this
feels like micro-optimisation!)


Thanks,

James
