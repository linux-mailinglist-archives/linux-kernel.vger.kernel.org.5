Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0CC798A45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbjIHP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjIHP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:58:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299861BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:58:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D145C150C;
        Fri,  8 Sep 2023 08:59:19 -0700 (PDT)
Received: from [10.57.5.217] (unknown [10.57.5.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C2363F67D;
        Fri,  8 Sep 2023 08:58:38 -0700 (PDT)
Message-ID: <ecc96b20-db88-5a96-d99b-98d6d20030cb@arm.com>
Date:   Fri, 8 Sep 2023 16:58:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 10/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
Content-Language: en-US
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
 <20230728164254.27562-11-james.morse@arm.com>
 <989616c3-ea4c-1c9b-b857-6d8bcb4843bd@intel.com>
 <fb244874-da8f-ac6f-511f-92861a340abe@arm.com>
 <c9706a35-4a61-df51-2c70-d4bab62f9eab@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <c9706a35-4a61-df51-2c70-d4bab62f9eab@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/25/23 01:43, Reinette Chatre wrote:
> On 8/24/2023 9:55 AM, James Morse wrote:
>> On 09/08/2023 23:34, Reinette Chatre wrote:
>>> On 7/28/2023 9:42 AM, James Morse wrote:
>>>> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
>>>> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
>>>> a specific CPU to be tested against the mask, and evaluates to false
>>>> when CONFIG_NO_HZ_FULL is not defined.
>>>>
>>>> The resctrl code needs to pick a CPU to run some work on, a new helper
>>>> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
>>>> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
>>>> be behind an ifdef too.
>>>>
>>>> Move the tick_nohz_full_mask declaration, this lets callers drop the
>>>> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
>>>> something like tick_nohz_full_cpu().
>>>>
>>>> The definition does not need to be moved as any callers should be
>>>> removed at compile time unless CONFIG_NO_HZ_FULL is defined.

>>> This is outside of the resctrl area. What is the upstreaming
>>> plan for this patch?
>>
>> Once you're happy with the rest of it - we can give the other folk on CC a poke.
>> I'd assume changes to this file also go via tip. It would just need an ack from the
>> relevant person.
> 
> At the moment this change is buried within a pile of resctrl
> changes so we need to make sure that folks are not surprised by this
> thinking we are trying to sneak it in. Please note that
> CC is currently missing Frederic Weisbecker.

Oops, fixed.


> I wonder if it may help to change cover letter to be something like
> "x86/resctrl and tick/nohz: Monitor ..." Just an idea.

I think that would be excessive - the subject of the patch already matches what is normal for that file. I'll move the patch to the top of the series as that makes it clearer that there is no dependency on the rest of the series.


Thanks,

James
