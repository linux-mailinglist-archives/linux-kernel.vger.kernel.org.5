Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5967EBB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjKODOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjKODOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:14:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E8E7;
        Tue, 14 Nov 2023 19:13:55 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SVSpf38HMz1P7pR;
        Wed, 15 Nov 2023 11:10:34 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Wed, 15 Nov 2023 11:13:53 +0800
Subject: Re: [PATCH -next] mm/kmemleak: move the initialisation of object to
 __link_object
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20231023025125.90972-1-liushixin2@huawei.com>
 <CAMuHMdWj0UzwNaxUvcocTfh481qRJpOWwXxsJCTJfu1oCqvgdA@mail.gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <f971c2b5-9ee8-1df5-8b8a-d8802b677fa3@huawei.com>
Date:   Wed, 15 Nov 2023 11:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWj0UzwNaxUvcocTfh481qRJpOWwXxsJCTJfu1oCqvgdA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/15 0:21, Geert Uytterhoeven wrote:
> Hi Liu,
>
> On Mon, Oct 23, 2023 at 3:52 AM Liu Shixin <liushixin2@huawei.com> wrote:
>> Leave __alloc_object() just do the actual allocation and __link_object()
>> do the full initialisation.
>>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Thanks for your patch, which is now commit 245245c2fffd0050
> ("mm/kmemleak: move the initialisation of object to __link_object")
> in v6.7-rc1.
>
> I have bisected to this commit the BUG splat below (seen on various
> platforms).  Reverting this commit fixes the issue.
Thanks for the discovery. It looks like that we can't call set_track_prepare() inside kmemleak_lock.
I will revert this patch.

Thanks.
>
>  Memory: 7923468K/8257536K available (9024K kernel code, 5144K rwdata,
> 4088K rodata, 3072K init, 18331K bss, 268532K reserved, 65536K
> cma-reserved)
>  SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> +
> +=============================
> +[ BUG: Invalid wait context ]
> +6.6.0-rc4-white-hawk-00387-g245245c2fffd #192 Not tainted
> +-----------------------------
> +swapper/0 is trying to lock:
> +ffffffc0814bbed8 (&zone->lock){....}-{3:3}, at: __rmqueue_pcplist+0x4ac/0x53c
> +other info that might help us debug this:
> +context-{5:5}
> +3 locks held by swapper/0:
> + #0: ffffffc0813cd720 (slab_mutex){....}-{4:4}, at:
> kmem_cache_create_usercopy+0xac/0x2e0
> + #1: ffffffc0813d93e8 (kmemleak_lock){....}-{2:2}, at:
> __create_object+0x48/0x98
> + #2: ffffff86bef6cc98 (&pcp->lock){....}-{3:3}, at:
> get_page_from_freelist+0x184/0x7c0
> +stack backtrace:
> +CPU: 0 PID: 0 Comm: swapper Not tainted
> 6.6.0-rc4-white-hawk-00387-g245245c2fffd #192
> +Hardware name: Renesas White Hawk CPU and Breakout boards based on
> r8a779g0 (DT)
> +Call trace:
> + dump_backtrace+0xac/0xe4
> + show_stack+0x14/0x20
> + dump_stack_lvl+0x68/0x94
> + dump_stack+0x14/0x1c
> + __lock_acquire+0x390/0xffc
> + lock_acquire+0x230/0x28c
> + _raw_spin_lock_irqsave+0x54/0x70
> + __rmqueue_pcplist+0x4ac/0x53c
> + get_page_from_freelist+0x2a8/0x7c0
> + __alloc_pages+0xf4/0x9f8
> + __stack_depot_save+0x178/0x3c8
> + stack_depot_save+0x10/0x18
> + set_track_prepare+0x44/0x70
> + __link_object+0xd0/0x220
> + __create_object+0x64/0x98
> + kmemleak_alloc+0x28/0x34
> + slab_post_alloc_hook.constprop.0+0xbc/0xc4
> + kmem_cache_alloc+0xd4/0x158
> + kmem_cache_create_usercopy+0x1c8/0x2e0
> + kmem_cache_create+0x18/0x20
> + kmemleak_init+0x74/0xfc
> + mm_core_init+0x214/0x250
> + start_kernel+0x2cc/0x4ec
> + __primary_switched+0xb4/0xbc
>  trace event string verifier disabled
>  Running RCU self tests
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

