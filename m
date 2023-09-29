Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0C7B3797
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjI2QN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2QN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:13:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29774199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:13:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343771FB;
        Fri, 29 Sep 2023 09:14:33 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4489B3F59C;
        Fri, 29 Sep 2023 09:13:52 -0700 (PDT)
Message-ID: <c68a8de4-129e-f03f-5a1c-ab43d96b2f42@arm.com>
Date:   Fri, 29 Sep 2023 17:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
Content-Language: en-GB
To:     David Laight <David.Laight@ACULAB.COM>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "amitsinght@marvell.com" <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-10-james.morse@arm.com>
 <6f7b411db77846b2a305b93d0cf0ee7b@AcuMS.aculab.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <6f7b411db77846b2a305b93d0cf0ee7b@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 17/09/2023 22:00, David Laight wrote:
> From: James Morse
>> Sent: 14 September 2023 18:21
>>
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
>>
>>  int closids_supported(void)
>> @@ -126,7 +126,7 @@ static void closid_init(void)
>>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>>
>>  	/* CLOSID 0 is always reserved for the default group */
>> -	closid_free_map &= ~1;
>> +	clear_bit(0, &closid_free_map);

> Don't the clear_bit() etc functions use locked accesses?

Yes. In this case there is no need for it to be atomic, just to use the bitmap API so this
can be made bigger in the future. It's currently protected by the rdtgroup_mutex (I'll add
some lockdep annotations to document that).


> These are always measurably more expensive than the C operators.

I'll switch this to use the double-underscore version which are non-atomic,
double-underscore is usually a warning not to use this function!

I doubt the performance matters as this is only ever called from a mkdir() syscall when
the configuration is changed, which we anticipate only really happens once at boot.



Thanks,

James
