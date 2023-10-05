Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370D77BA819
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjJERbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJERag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:30:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E2AA171A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:07:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8CD5C15;
        Thu,  5 Oct 2023 10:08:14 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09BD23F5A1;
        Thu,  5 Oct 2023 10:07:32 -0700 (PDT)
Message-ID: <a7933189-5bcd-e979-1d33-544186a438a5@arm.com>
Date:   Thu, 5 Oct 2023 18:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
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
 <20230914172138.11977-10-james.morse@arm.com>
 <b31e1fd2-31b6-4240-94e7-870bcfd51754@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <b31e1fd2-31b6-4240-94e7-870bcfd51754@amd.com>
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

On 04/10/2023 21:38, Moger, Babu wrote:
> On 9/14/23 12:21, James Morse wrote:
>> The resctrl CLOSID allocator uses a single 32bit word to track which
>> CLOSID are free. The setting and clearing of bits is open coded.
>>
>> A subsequent patch adds resctrl_closid_is_free(), which adds more open
>> coded bitmaps operations. These will eventually need changing to use
>> the bitops helpers so that a CLOSID bitmap of the correct size can be
>> allocated dynamically.
>>
>> Convert the existing open coded bit manipulations of closid_free_map
>> to use set_bit() and friends.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ac1a6437469f..fa449ee0d1a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -106,7 +106,7 @@ void rdt_staged_configs_clear(void)
>>   * - Our choices on how to configure each resource become progressively more
>>   *   limited as the number of resources grows.
>>   */
>> -static int closid_free_map;
>> +static unsigned long closid_free_map;
>>  static int closid_free_map_len;
>>  
>>  int closids_supported(void)
>> @@ -126,7 +126,7 @@ static void closid_init(void)
>>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>>  
>>  	/* CLOSID 0 is always reserved for the default group */
>> -	closid_free_map &= ~1;
>> +	clear_bit(0, &closid_free_map);
> 
> How about using RESCTRL_RESERVED_CLOSID instead of 0 here?

Great idea - even more readable.


Thanks,

James
