Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219A079DD83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbjIMBXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjIMBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:23:39 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401B1708
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1694568212; bh=xWf1b2muuY0Mjkzl9OKGkFAm7aGKTwg/3EP4cheXjBQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tS5UsJoo3AOqlMuGBTvriYqLuQg7XrL+uF1POWV7YQwjAOm9NKKiDu6R+LTd6HEkk
         gHPli3psuXCAeRDAFFII/FqhdJ5eilhSRPwAZ0IjHziKxw35K4W+Wsjnyp1LJPFCux
         zpdKcPx2B8ZTCs3BwEHVmdmlKkw1kiS9JVtLXZCY=
Received: from [192.168.9.172] (unknown [101.88.25.36])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 69BA360120;
        Wed, 13 Sep 2023 09:23:32 +0800 (CST)
Message-ID: <bfdcbbb0-3df0-1778-6250-99e1120bb077@xen0n.name>
Date:   Wed, 13 Sep 2023 09:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] LoongArch: Set all reserved memblocks on Node#0 at
 initialization
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        WANG Xuerui <git@xen0n.name>
References: <20230911092810.3108092-1-chenhuacai@loongson.cn>
 <b96c53eb-3c6f-d981-7573-10b95c3005a2@xen0n.name>
 <CAAhV-H6p6F6j61fiFz=KdhkRX_fN+jzhhuarJdcQ0LHtTLpzKw@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6p6F6j61fiFz=KdhkRX_fN+jzhhuarJdcQ0LHtTLpzKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 08:49, Huacai Chen wrote:
> On Wed, Sep 13, 2023 at 12:08 AM WANG Xuerui <kernel@xen0n.name> wrote:
>> On 9/11/23 17:28, Huacai Chen wrote:
>>> After commit 61167ad5fecdea ("mm: pass nid to reserve_bootmem_region()")
>>> we get a panic if DEFERRED_STRUCT_PAGE_INIT is enabled:
>>>
>>> [snip]
>>>
>>> The reason is early memblock_reserve() in memblock_init() set node id
>> Why is it that only "early" but not "late" memblock_reserve() matters? I
>> failed to see the reason because the arch-specific memblock_init() isn't
>> even in the backtrace, which means that *neither* is the culprit.
> Late memblock_reserve() operates on subregions of memblock.memory
> regions. These reserved regions will be set to the correct node at the
> first iteration of memmap_init_reserved_pages().
Thanks for the clarification. According to the code behavior (and the 
comment I left on the reordering change below) I'm now sure the intended 
meaning is "calling memblock_reserve() after memblock_set_node() is 
effectively leaving those regions with nid=MAX_NUMNODES" (or something 
like that, pointing out that the memblock_set_node() call actually had 
no effect in this case). "Early" and "late" in the context of init code 
can be especially confusing IMO :-)
>
> Huacai
>
>>> to MAX_NUMNODES, which causes NODE_DATA(nid) be a NULL dereference in
>> "making NODE_DATA(nid) a NULL ..."
>>> reserve_bootmem_region() -> init_reserved_page(). So set all reserved
>>> memblocks on Node#0 at initialization to avoid this panic.
>>>
>>> Reported-by: WANG Xuerui <git@xen0n.name>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    arch/loongarch/kernel/mem.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
>>> index 4a4107a6a965..aed901c57fb4 100644
>>> --- a/arch/loongarch/kernel/mem.c
>>> +++ b/arch/loongarch/kernel/mem.c
>>> @@ -50,7 +50,6 @@ void __init memblock_init(void)
>>>        }
>>>
>>>        memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>>> -     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
>>>
>>>        /* Reserve the first 2MB */
>>>        memblock_reserve(PHYS_OFFSET, 0x200000);
>>> @@ -58,4 +57,7 @@ void __init memblock_init(void)
>>>        /* Reserve the kernel text/data/bss */
>>>        memblock_reserve(__pa_symbol(&_text),
>>>                         __pa_symbol(&_end) - __pa_symbol(&_text));
>>> +
>>> +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
>>> +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.reserved, 0);
>> So the reordering is for being able to override the newly added
>> memblocks' nids to 0, and additionally doing the same for
>> memblock.reserved is the actual fix. Looks okay.
>>>    }
>> And I've tested the patch on the 2-way 3C5000L server, and it now
>> correctly boots with deferred struct page init enabled. Thanks for
>> providing such a quick fix!
>>
>> Tested-by: WANG Xuerui <git@xen0n.name>
>> Reviewed-by: WANG Xuerui <git@xen0n.name>  # with nits addressed
>>
>> --
>> WANG "xen0n" Xuerui
>>
>> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>>
>>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

