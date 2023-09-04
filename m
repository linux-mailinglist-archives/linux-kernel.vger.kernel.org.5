Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE379102A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351099AbjIDCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbjIDCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:48:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E19114
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:48:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfCjr0q93z4f3kKq
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:48:00 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqleRfVkcC9CCQ--.43117S3;
        Mon, 04 Sep 2023 10:48:00 +0800 (CST)
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
Date:   Mon, 4 Sep 2023 10:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHVqleRfVkcC9CCQ--.43117S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxAw48GryrJw4xJF4UXFb_yoW8Aw4rpr
        1rAF4UJF1UAFn5G34IvFZ3uayfJrZ2vrWUZrWakas0yr9IywnIyr15Ga129rWv9rnFqF4S
        vF48tFsIyryF9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/1 17:49, Baoquan He wrote:
>>> +
>>> +		*high = true;
>>> +	} else if (ret || !*crash_size) {
>> This check can be moved outside of #ifdef. Because even '!high', it's completely
>> applicable. The overall adjustment is as follows:
> Hmm, the current logic is much easier to understand. However, I may not
> 100% get your suggestion. Can you paste the complete code in your
> suggested way? Do not need 100% correct code, just the skeleton of code logic
> so that I can better understand it and add inline comment.

int __init parse_crashkernel(...)
{
	int ret;

	/* crashkernel=X[@offset] */
	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
				crash_base, NULL);

#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
	if (high && ret == -ENOENT) {
		... ...		//The code for your original branch "else if (ret == -ENOENT) {"
		ret = 0;	//Added based on the next discussion
	}
+#endif

 	if (!*crash_size)
		ret = -EINVAL;

	return ret;
}

> 
>> -  	if (!high)
>> -  		return ret;
>>
>> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> 	if (high && ret == -ENOENT) {
>> 		... ...
>> 		if (ret || !*crash_size)	//parse HIGH
>> 		... ...
>> 	}
>>
>> 	//At this point, *crash_size is not 0 and ret is 0.
>> 	//We can also delete if (!*crash_size) above because it will be checked later.
>> #endif
>>
>> 	if (!*crash_size)
>> 		ret = -EINVAL;
>>
>> 	return ret;
> When crashkernel=,high is specified while crashkernel=,low is omitted,
> the ret==-ENOENT, but we can't return ret directly. That is still an
> acceptable way.

Oh, yes. Sorry, I didn't notice branch "ret==-ENOENT" didn't return. So "ret = 0;"
needs to be added.

	if (high && ret == -ENOENT) {
		... ...
		*high = true;
+		ret = 0;
	}

> 
>> -  	return 0;
>>
>>> +		/* The specified value is invalid */
>>> +		return -1;
>>> +	}
>>> +#endif
>>>  	return 0;
>>>  }
>>>  
>>>

-- 
Regards,
  Zhen Lei

