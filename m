Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0D7CBCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjJQHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJQHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:53:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A2AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:53:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA132C433C7;
        Tue, 17 Oct 2023 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697529180;
        bh=p4vpHmypakCe2FUK/2r5Z+O00L713pYXDijPBBsNJtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3EcTVMYCp1luKu0MYqwDlTz6z3NwwAlbckflCa9SjThkR/IQPIVbYCG+RfqHTCP/
         NPKfhTe7AKTD+QNo720QTt4hZ0/Zg5pZ8QJtEt87QHVB2DRB+S3s9IgWtHHNbkK0rd
         ftudnKKxgDiZ2Nkn9mWsAQv6u/NqfEfQb6q+4Q6TqSDuA9CX1iyJVfHkR+GNpH9ZuF
         5swsQ9Y33VQI0JjskK79q5EYN8flWzVZ2hdrR5Zy2GbELOrfissMawNbqQXN6jBLgO
         x4AA6/EZ+3BlnN+nCEUxmNsnb4v2K5Coz321wwvQOffPpUg2XGbecOKJO5jnnBKn2H
         /tC5gCkMjhaSg==
Date:   Tue, 17 Oct 2023 10:52:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
Message-ID: <20231017075246.GA2824@kernel.org>
References: <20231017062215.171670-1-rppt@kernel.org>
 <4207feb8-be8c-4d49-b880-31366c0414cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207feb8-be8c-4d49-b880-31366c0414cb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:28:14AM +0200, David Hildenbrand wrote:
> On 17.10.23 08:22, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
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
> > Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> 
> That's just a resend I assume? Or has anything changed?

Oh, I forgot RESEND prefix, sorry
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
