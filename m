Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEC7D72B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJYR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjJYR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:57:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42EB5187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:57:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C34A14BF;
        Wed, 25 Oct 2023 10:58:12 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3678B3F738;
        Wed, 25 Oct 2023 10:57:25 -0700 (PDT)
Message-ID: <4adbf8dd-6c19-969c-84cd-297caae4b8f1@arm.com>
Date:   Wed, 25 Oct 2023 18:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230914172138.11977-15-james.morse@arm.com>
 <2947d0b3-349d-4dc3-0c57-0a68b297327c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2947d0b3-349d-4dc3-0c57-0a68b297327c@intel.com>
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

On 03/10/2023 22:18, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>  			   u64 *val);
>>  
>> +/**
>> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>> + *
>> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
>> + * resctrl_arch_rmid_read() is called with preemption disabled.
>> + */
>> +static inline void resctrl_arch_rmid_read_context_check(void)
>> +{
>> +	if (!irqs_disabled())
>> +		might_sleep();
>> +}
>>  
>>  /**
>>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
> 
> I was expecting the above to look like you said it would look [1].

Hmm, not sure what happened there - it even made it into the changelog for the patch.
Presumably an earlier change conflicted and I messed up the resolution.

Fixed now.


Thanks,

James
