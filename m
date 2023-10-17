Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E77CBA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjJQGM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjJQGM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F403B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:12:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F4C433C9;
        Tue, 17 Oct 2023 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697523144;
        bh=WZL7RMv9Zq/flTstARyomtZeBjuP+jl2Fbh947mNZjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubNVksdDjR5U3wRRg8jlP3jRY5F+VUPiIcGj/yOxk94jF9xgeqvFFQyW3zvfLXuAa
         aRMuD2bNnylMN8NGUI6n/Xoq3N3aw5sQarV/zxO5FvmtRDqHXyfMlceBF+85NFoHDJ
         ToellsOzqWjn7M8SzB3hEr6EgBR9pO2MK+JR+N5tq/bBvCjHRoyupp1fPxmKsRlkD6
         YaKN/igqRKWuSuTkPE8CH6iet0DIosIcwR4Bm1d6M5i4TRmH4LbeshglfGnnra/OK7
         fWKlyqxFmz/rbfCr3ZzJHXZKeA1lGJMyNd4iFaS8ll5YOovN07Wb1pn2AmY4wpUvWJ
         xALE0IYqDaiaw==
Date:   Tue, 17 Oct 2023 09:12:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <20231017061210.GW3303@kernel.org>
References: <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz>
 <Y+ymKw1eJaRcmDNN@kernel.org>
 <8f506561-44f7-a243-f0cc-59543f487e4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f506561-44f7-a243-f0cc-59543f487e4d@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:09:42PM +0800, Qi Zheng wrote:
> Hi Mike,
> 
> On 2023/2/15 17:30, Mike Rapoport wrote:
> [...]
> > 
> > How about we try this:
> > 
> >  From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > Date: Wed, 15 Feb 2023 11:12:18 +0200
> > Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
> > 
> > Qi Zheng reports crashes in a production environment and provides a
> > simplified example as a reproducer:
> > 
> >    For example, if we use qemu to start a two NUMA node kernel,
> >    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> >    and the other node has 2G, then we will encounter the
> >    following panic:
> > 
> >    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >    [    0.150783] #PF: supervisor write access in kernel mode
> >    [    0.151488] #PF: error_code(0x0002) - not-present page
> >    <...>
> >    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> >    <...>
> >    [    0.169781] Call Trace:
> >    [    0.170159]  <TASK>
> >    [    0.170448]  deactivate_slab+0x187/0x3c0
> >    [    0.171031]  ? bootstrap+0x1b/0x10e
> >    [    0.171559]  ? preempt_count_sub+0x9/0xa0
> >    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> >    [    0.172735]  ? bootstrap+0x1b/0x10e
> >    [    0.173236]  bootstrap+0x6b/0x10e
> >    [    0.173720]  kmem_cache_init+0x10a/0x188
> >    [    0.174240]  start_kernel+0x415/0x6ac
> >    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> >    [    0.175417]  </TASK>
> >    [    0.175713] Modules linked in:
> >    [    0.176117] CR2: 0000000000000000
> > 
> > The crashes happen because of inconsistency between nodemask that has
> > nodes with less than 4MB as memoryless and the actual memory fed into
> > core mm.
> > 
> > The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> > empty node in SRAT parsing") that introduced minimal size of a NUMA node
> > does not explain why a node size cannot be less than 4MB and what boot
> > failures this restriction might fix.
> > 
> > Since then a lot has changed and core mm won't confuse badly about small
> > node sizes.
> > 
> > Drop the limitation for the minimal node size.
> > 
> > Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   arch/x86/include/asm/numa.h | 7 -------
> >   arch/x86/mm/numa.c          | 7 -------
> >   2 files changed, 14 deletions(-)
> 
> What's the current progress on this patch? This patch doesn't seem to be
> merged into any trees. Did I miss something?

Looks like it fell between the cracks. I'll resend.
 
> Thanks,
> Qi
> 

-- 
Sincerely yours,
Mike.
