Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAD760B41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGYHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjGYHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:14:35 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4557CBD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:14:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R97Z9680Sz4f3kFQ
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:14:25 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JSdr9khB8NOw--.47987S3;
        Tue, 25 Jul 2023 15:14:28 +0800 (CST)
Subject: Re: [PATCH 0/3] arm64: kdump: Restore the write protection for the
 crashkernel memory region
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
 <ZL595WtNlLnvtnJl@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <f067c293-fce4-6514-fa8b-947cae781c27@huaweicloud.com>
Date:   Tue, 25 Jul 2023 15:14:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZL595WtNlLnvtnJl@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCH77JSdr9khB8NOw--.47987S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3tryxtw1fuFy5uw1xXwb_yoW5tr4kpF
        WxWrWUKr4DtFn7A3WkZw1xCrW8Ca1Fkry5Wrn3Cwn8urnxWrn2yF12gw1Y9FWxGrZa9a43
        XFWYqr9I93W5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/24 21:34, Baoquan He wrote:
> Hi,
> 
> On 07/21/23 at 04:17pm, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Unlike in the past, the low memory allocation direction of the crashkernel is
>> changed from top-down to bottom-up. As long as the DMA zone has sufficient
>> continuous free memory, the allocated crashkernel low memory must meet the
>> requirements. The allocation direction of crashkernel high memory remains
>> unchanged, that is, top-down. As long as the high memory(above DMA zone) has
>> sufficient continuous free memory, the allocated crashkernel high memory must
>> meet the requirements. In this way, with the restoration of the original
>> page-level mapping and the implementation of the arch_kexec_protect_crashkres()
>> function, write protection for the crashkernel memory region can be supported.
>>
>> Of course, if the high memory or low memory cannot meet the initial requirements,
>> that is, fall back is required. In this case, write protection is not supported
>> because the newly allocated memory is not page-level mapped.
>>
>> Because the original retry process is eliminated, the new process looks clearer
>> and is a simple sequential flow.
> 
> Thanks, but no.
> 
> The pure semantics and the corresponding implementation have been 
> complicated, it's not worth adding so much more complication to it
> just because of one inessential feature.

It's just that the code looks like if..else branches are a little more, but the
idea is not complicated.
1. Reserve low memory bottom-up(start from 0), reserve high memory top-down(start from CRASH_ADDR_HIGH_MAX)
2. zone_sizes_init() update arm64_dma_phys_limit, now CRASH_ADDR_LOW_MAX is known.
3. Use CRASH_ADDR_LOW_MAX to verify the preserved low memory and high memory, OK or fall back.

To be honest, the code can be simplified a lot if we don't support the following:
-----
If reservation from the high memory failed, the kernel falls back to
searching the low memory with the specified size in crashkernel=,high.
If it succeeds, no further reservation for low memory is needed.

> 
> If stomp really happened and destroy the loaded kdump kernel, the write
> protection truly can save kdump to make vmcore dumping succeed. While
> without write protection, we at least know that stomp happened by the
> later checksum verifycation. That's an advantage over write protection
> which silently ignores the stomp, right?

Theoretically, write protection can catch exceptions in a timely manner
and ensure that kdump is successful. If the problem is easy to reproduce,
it doesn't matter if it fails once. However, for versions that have been
delivered for commercial use, the customer may not give the second chance.

> 
> So, due to the low cost performance, from people maintaining and
> understanding the code point of view, I would like to NACK this series.
> BUT since all these code changes are added into arm64 arch, I won't
> object if arm64 maintainers wants to pikc them up.

This new idea is not bad. After all, before commercial use, "fall back"
can be avoided by adjusting crashkernel size in command line. So the
problem is pretty much solved.

> 
> By the way, as we have talked before, arm64 lacks the loaded kernel
> checksum storing and verifying, would you like to add that?

OKay.

> 
> Thanks
> Baoquan
> 
> .
> 

-- 
Regards,
  Zhen Lei

