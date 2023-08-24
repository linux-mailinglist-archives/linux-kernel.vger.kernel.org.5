Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A617D78761F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbjHXQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbjHXQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:55:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 819DF1989
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:55:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB391007;
        Thu, 24 Aug 2023 09:56:18 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84EFD3F740;
        Thu, 24 Aug 2023 09:55:35 -0700 (PDT)
Message-ID: <fb244874-da8f-ac6f-511f-92861a340abe@arm.com>
Date:   Thu, 24 Aug 2023 17:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
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
 <20230728164254.27562-11-james.morse@arm.com>
 <989616c3-ea4c-1c9b-b857-6d8bcb4843bd@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <989616c3-ea4c-1c9b-b857-6d8bcb4843bd@intel.com>
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

On 09/08/2023 23:34, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
>> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
>> a specific CPU to be tested against the mask, and evaluates to false
>> when CONFIG_NO_HZ_FULL is not defined.
>>
>> The resctrl code needs to pick a CPU to run some work on, a new helper
>> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
>> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
>> be behind an ifdef too.
>>
>> Move the tick_nohz_full_mask declaration, this lets callers drop the
>> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
>> something like tick_nohz_full_cpu().
>>
>> The definition does not need to be moved as any callers should be
>> removed at compile time unless CONFIG_NO_HZ_FULL is defined.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>  include/linux/tick.h | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> This is outside of the resctrl area. What is the upstreaming
> plan for this patch?

Once you're happy with the rest of it - we can give the other folk on CC a poke.
I'd assume changes to this file also go via tip. It would just need an ack from the
relevant person.


Thanks,

James
