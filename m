Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B426B7937B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjIFJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjIFJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:08:09 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE948CFD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:08:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rgc3N46Jrz4f3tNb
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:08:00 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqlwQfhk+8P8CQ--.16917S3;
        Wed, 06 Sep 2023 17:08:01 +0800 (CST)
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
 <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
 <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
 <ZPbm5SwHOhiAtG7w@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <58a0c4be-0302-04e0-8723-df37407884a8@huaweicloud.com>
Date:   Wed, 6 Sep 2023 17:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZPbm5SwHOhiAtG7w@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHVqlwQfhk+8P8CQ--.16917S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7CFWxGw4fGrWDWw1Utrb_yoW5CFW5pr
        y8AF4Utr1UtFn3Cw1IyrZ7ZayIy3yqyFyUXFWY9F90yasrtwn3Gr15Kr1UurWDGrn09a1a
        vF4rtFsIk3WUZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/5 16:29, Baoquan He wrote:
> On 09/04/23 at 10:47am, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2023/9/1 17:49, Baoquan He wrote:
>>>>> +
>>>>> +		*high = true;
>>>>> +	} else if (ret || !*crash_size) {
>>>> This check can be moved outside of #ifdef. Because even '!high', it's completely
>>>> applicable. The overall adjustment is as follows:
>>> Hmm, the current logic is much easier to understand. However, I may not
>>> 100% get your suggestion. Can you paste the complete code in your
>>> suggested way? Do not need 100% correct code, just the skeleton of code logic
>>> so that I can better understand it and add inline comment.
>>
>> int __init parse_crashkernel(...)
>> {
>> 	int ret;
>>
>> 	/* crashkernel=X[@offset] */
>> 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>> 				crash_base, NULL);
>>
>> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> 	if (high && ret == -ENOENT) {
>> 		... ...		//The code for your original branch "else if (ret == -ENOENT) {"
>> 		ret = 0;	//Added based on the next discussion
>> 	}
>> +#endif
>>
>>  	if (!*crash_size)
>> 		ret = -EINVAL;
>>
>> 	return ret;
>> }
>>
> Thanks, Zhen Lei.
> 
> I paste the whole parse_crashkernel() as you suggested at bottom. Please
> check if it's what you want. 

Yes.

> To me, both is fine to me. I have two minor
> concerns to your suggested way.
> 
> 1)
> I took the "if (!high) return" way because except of x86/arm64, all
> other architectures will call parse_crashkerne() and check
> if *crash_size ==0. Please try 'git grep "parse_crashkernel(" arch'
> and check those call sites. With that, we will have duplicated checking.

Add some patches to remove the duplicated checking of other ARCHs? After this
patch series upstreamed.

> 
>         ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>                                 crash_base, NULL);
>         if (!high)
>                 return ret;
> 2)
> I actually like below branch and the code comment. It can give people
> hint about what's going on in that case. Discarding it is a little pity.

Except that "!*crash_size" and "(high && ret == -ENOENT)" needs special comments,
other common errors do not need to be described, I think. Even if some is required,
it should be placed in function __parse_crashkernel().

> 
>         } else if (ret || !*crash_size) {
>                 /* The specified value is invalid */
>                 return -1;
>         }
> 
> int __init parse_crashkernel(...)
> {
> 	int ret;
> 
> 	/* crashkernel=X[@offset] */
> 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> 				crash_base, NULL);
> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> 	if (high && ret == -ENOENT) {
> 		ret = __parse_crashkernel(cmdline, 0, crash_size,
> 				crash_base, suffix_tbl[SUFFIX_HIGH]);
> 		if (ret || !*crash_size)
> 			return -EINVAL;
> 
> 		/*
> 		 * crashkernel=Y,low can be specified or not, but invalid value
> 		 * is not allowed.
> 		 */
> 		ret = __parse_crashkernel(cmdline, 0, low_size,
> 				crash_base, suffix_tbl[SUFFIX_LOW]);
> 		if (ret == -ENOENT) {
> 			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> 			ret = 0;
> 		} else if (ret) {
> 			return ret;
> 		}
> 
> 		*high = true;
> 	}
> #endif
> 
> 	if (!*crash_size)
> 		ret = -EINVAL;
> 
> 	return ret;
> }
> 
> .
> 

-- 
Regards,
  Zhen Lei

