Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE7CF41C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjJSJfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJSJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:35:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C57FE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:35:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7ADC433C9;
        Thu, 19 Oct 2023 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697708131;
        bh=uMWdtkngp6pIrB6Yzva+d5KcRLh0y1iTkblF4Qad//Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axZ6C03sVf1qgnGcWKKR6zQ0cHUzzJMlVYCbue9/8bIEbrsU3h1WkH4OB94AjbMVz
         Yvt/vnxwj92dSRgJ0Ym1gP+wddHqFq00hgEuM69mXwC9z/Q2P8BhBvhlpb9CfehzQ1
         /5PuygQFdmspxlt0+WY3NgwZM82M8PTfyLtA+lA9x9M7l11PBP73vS5PMP2RtpjpcL
         mMt+1iuRuuI6+1Cupg8d/4hfzRXfZ9IIBj2lAXhHzdtfFCb90mpzwUZuD3ls9GWTfo
         4wxjFBGWXvOE9kvNWP3MxI8i5SGQFe6vxniw9pXgtvI8b6GBbvYNTVaAAQizH37hVa
         Zrho5Tp/AqBwA==
Date:   Thu, 19 Oct 2023 12:35:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
Message-ID: <20231019093515.GE2824@kernel.org>
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+2qqjEO5/867br@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:42:50PM +0200, Ingo Molnar wrote:
> 
> * Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Qi Zheng reports crashes in a production environment and provides a
> > simplified example as a reproducer:
> > 
> >   For example, if we use qemu to start a two NUMA node kernel,
> >   one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> >   and the other node has 2G, then we will encounter the
> >   following panic:
> > 
> >   [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   [    0.150783] #PF: supervisor write access in kernel mode
> >   [    0.151488] #PF: error_code(0x0002) - not-present page
> >   <...>
> >   [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> >   <...>
> >   [    0.169781] Call Trace:
> >   [    0.170159]  <TASK>
> >   [    0.170448]  deactivate_slab+0x187/0x3c0
> >   [    0.171031]  ? bootstrap+0x1b/0x10e
> >   [    0.171559]  ? preempt_count_sub+0x9/0xa0
> >   [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> >   [    0.172735]  ? bootstrap+0x1b/0x10e
> >   [    0.173236]  bootstrap+0x6b/0x10e
> >   [    0.173720]  kmem_cache_init+0x10a/0x188
> >   [    0.174240]  start_kernel+0x415/0x6ac
> >   [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> >   [    0.175417]  </TASK>
> >   [    0.175713] Modules linked in:
> >   [    0.176117] CR2: 0000000000000000
> > 
> > The crashes happen because of inconsistency between nodemask that has
> > nodes with less than 4MB as memoryless and the actual memory fed into
> > core mm.
> 
> Presumably the core MM got fixed too to not just crash, but provide some 
> sort of warning?
> 
> > The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> > empty node in SRAT parsing") that introduced minimal size of a NUMA node
> > does not explain why a node size cannot be less than 4MB and what boot
> > failures this restriction might fix.
> > 
> > Since then a lot has changed and core mm won't confuse badly about small
> > node sizes.
> 
> Core MM won't get confused ... other than by the above weird Qemu topology, 
> to which it responds with a ... NULL pointer dereference?
> 
> Seems quite close to the literal definition of 'get confused badly' to me, 
> and doesn't give me the warm fuzzy feeling that giving the core MM even 
> *more* weird topologies is super safe ... :-/

The confusion is not about topology and not because of the small size of a
node.
The confusion is because x86 fails to consistently report it's memory
layout.  At one point it says there is memoryless node and another point it
says that that node actually has memory.

And dropping the kludge that says "Don't confuse VM with a node that
doesn't have the minimum amount of memory" fixes exactly that.
 
> > Drop the limitation for the minimal node size.
> 
> While I agree with dropping the limitation, and I agree that 9391a3f9c7f1 
> should have provided more of a justification, I believe a core MM fix is in 
> order as well, for it to not crash. [ If it's fixed upstream already, 
> please reference the relevant commit ID. ]

The core mm can be more strict about memory layouts it accepts indeed.
I'll look into that.
 
> Also, the changelog spelling & general presentation were quite low quality 
> - I've fixed it up a bit below, please carry this version going forward. 
> Please spell-check your patches before sending out Nth versions of it, 
> maybe maintainers are skipping them for a reason!
> 
> Thanks,
> 
> 	Ingo
> 
> =================>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Tue, 17 Oct 2023 09:22:15 +0300
> Subject: [PATCH] x86/mm: Drop 4MB restriction on minimal NUMA node memory size
> 
> Qi Zheng reported crashes in a production environment and provided a
> simplified example as a reproducer:
> 
>  |  For example, if we use qemu to start a two NUMA node kernel,
>  |  one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>  |  and the other node has 2G, then we will encounter the
>  |  following panic:
>  |
>  |    BUG: kernel NULL pointer dereference, address: 0000000000000000
>  |    <...>
>  |    RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>  |    <...>
>  |    Call Trace:
>  |      <TASK>
>  |      deactivate_slab()
>  |      bootstrap()
>  |      kmem_cache_init()
>  |      start_kernel()
>  |      secondary_startup_64_no_verify()
> 
> The crashes happen because of inconsistency between the nodemask that
> has nodes with less than 4MB as memoryless, and the actual memory fed
> into the core mm.
> 
> The commit:
> 
>   9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring empty node in SRAT parsing")
> 
> ... that introduced minimal size of a NUMA node does not explain why
> a node size cannot be less than 4MB and what boot failures this
> restriction might fix.
> 
> In the 17 years since then a lot has changed and core mm won't get
> confused about small node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> [ mingo: Improved changelog clarity. ]
> 
> Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Not-Yet-Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> ---
>  arch/x86/include/asm/numa.h | 7 -------
>  arch/x86/mm/numa.c          | 7 -------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>  
>  #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>  
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>  extern int numa_off;
>  
>  /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index c01c5506fd4a..aa39d678fe81 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -602,13 +602,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>  		if (start >= end)
>  			continue;
>  
> -		/*
> -		 * Don't confuse VM with a node that doesn't have the
> -		 * minimum amount of memory:
> -		 */
> -		if (end && (end - start) < NODE_MIN_SIZE)
> -			continue;
> -
>  		alloc_node_data(nid);
>  	}
>  

-- 
Sincerely yours,
Mike.
