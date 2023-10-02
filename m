Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17917B5527
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjJBOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjJBOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:18:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111FB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:18:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392EHSGZ011771;
        Mon, 2 Oct 2023 09:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696256249;
        bh=rG/Xjtl/LvFUMnG3FeEUi1JZ8Ho/Bgo0K7qA9FAEUO0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=pXVWVTlypjQqudHAk+8NysPLqTYafDxBynTc7Pn0xpyMY8okU148BSL0AFk9XP0o+
         sYSP2isCwdWVDN9aK0EhnOK056sUQYn5oPV700cb/DEOKcgYgM5tri+1fkD1WH4vog
         km+uSr6ekNDk4pwsd9jZIio6W48HVs5U2n/1IatQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392EHSwL077767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Oct 2023 09:17:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 09:17:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 09:17:28 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392EHRst110936;
        Mon, 2 Oct 2023 09:17:27 -0500
Message-ID: <a40df914-18cf-75ae-4e4d-98332c3d1b56@ti.com>
Date:   Mon, 2 Oct 2023 09:17:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Zhizhou Zhang <zhizhou.zh@gmail.com>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <arnd@arndb.de>, <wangkefeng.wang@huawei.com>,
        <willy@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230907143302.4940-1-zhizhou.zh@gmail.com>
 <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
 <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
 <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
 <ZPwrkRldQU/5TOcz@local>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZPwrkRldQU/5TOcz@local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/23 3:23 AM, Zhi-zhou Zhang wrote:
> On Fri, Sep 08, 2023 at 11:00:31PM +0200, Linus Walleij wrote:
>> On Fri, Sep 8, 2023 at 3:50 PM Russell King (Oracle)
>> <linux@armlinux.org.uk> wrote:
>>
>>> However, it makes a total nonsense of the comment, which explains
>>> precisely why the flush_cache_all() is where it is. Moving it before
>>> that comment means that the comment is now rediculous.
>>
>> Zhizhou, can you look over the comment placement?
> 
> Linus, I found the bug on a cortex-a55 cpu with high address memory.
> Since the lr is also corruptted, when flush_cache_all() is done, the
> program continues at the next instruction after fixup_pv_table(). So
> the disabling cache and flush_cache_all() is executed a secondary time.
> Then this time lr is correct so the kernel may boot up as usual.
> 
> I read the comment carefully, I am not sure how "to ensure nothing is
> prefetched into the caches" affects the system. My patch doesn't
> prevent instrution prefetch though. But in my board everythings looks
> good.
> 
> So I come up with a new fixup plan, that's keep the location of
> flush_cache_all() with adding a flush stack cache before disabling
> cache, the code is as follow, the fix is a bit ugly -- it makes
> assumption stack grow towards low address and flush_cache_all() will
> not occupy more than 32 bytes in the future. Comparing with move
> flush_cache_all() before disabling cache, Which one do you prefer?
> Thanks!
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 03fb0fe926f3..83a54c61a86b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1640,6 +1640,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
>   	unsigned long pa_pgd;
>   	unsigned int cr, ttbcr;
>   	long long offset;
> +	void *stack;
>   
>   	if (!mdesc->pv_fixup)
>   		return;
> @@ -1675,7 +1676,14 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
>   	/* Run the patch stub to update the constants */
>   	fixup_pv_table(&__pv_table_begin,
>   		(&__pv_table_end - &__pv_table_begin) << 2);
> -	flush_cache_all();
> +
> +	/*
> +	 * clean stack in cacheline that undering memory will be changed in
> +	 * the following flush_cache_all(). assuming 32 bytes is enough for
> +	 * flush_cache_all().

Adding this extra clean here seems reasonable, but this comment needs
fixed to give the exact reasoning and warn others to not dirty the stack
after this point. Maybe something like

/*
  * The stack is currently in cacheable memory, after caching is disabled
  * writes to the stack will bypass the cached stack. If this now stale
  * cached stack is then evicted it will overwrite the updated stack in
  * memory. Clean the stack's cache-line and then ensure no writes to the
  * stack are made between here and disabling the cache below.
  */

Andrew

> +	 */
> +	stack = (void *) (current_stack_pointer - 32);
> +	__cpuc_flush_dcache_area(stack, 32);
>   
>   	/*
>   	 * We changing not only the virtual to physical mapping, but also
> @@ -1691,6 +1699,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
>   	asm("mrc p15, 0, %0, c2, c0, 2" : "=r" (ttbcr));
>   	asm volatile("mcr p15, 0, %0, c2, c0, 2"
>   		: : "r" (ttbcr & ~(3 << 8 | 3 << 10)));
> +	flush_cache_all();
>   
>   	/*
>   	 * Fixup the page tables - this must be in the idmap region as
> 
>>
>>> So, please don't put it in the patch system.
>>>
>>> The patch certainly needs to be tested on TI Keystone which is the
>>> primary user of this code.
>>
>> Added Andrew Davis and Nishanth Menon to the thread:
>> can you folks review and test this for Keystone?
>>
>> Yours,
>> Linus Walleij
