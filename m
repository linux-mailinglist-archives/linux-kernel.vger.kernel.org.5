Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F577E7696
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbjKJBcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:32:32 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D4B44A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:32:30 -0800 (PST)
X-AuditID: a67dfc5b-d85ff70000001748-c6-654d882de360
Date:   Fri, 10 Nov 2023 10:32:24 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20231110013224.GD72073@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <87il6bijtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il6bijtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC9ZZnka5uh2+qweQXJhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CVcXTr
        P6aCTpOKrbv3sTQwflXrYuTkkBAwkWiYt48Jxv655w4riM0ioCox9cUNMJtNQF3ixo2fzCC2
        iICGxKeFy9m7GLk4mAXeMEmcbt4GViQs4C6x69QdsCJeAQuJ7vPP2EBsIYFMiRudW1kh4oIS
        J2c+YQGxmQW0JG78ewm0mAPIlpZY/o8DJMwpYCfxvPMb2BhRAWWJA9uOM4HskhBYxS6xae0E
        RohDJSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMAoXFb7
        J3oH46cLwYcYBTgYlXh4L1z3SRViTSwrrsw9xCjBwawkwnvBBCjEm5JYWZValB9fVJqTWnyI
        UZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBkcNjq9477uW7o6+eN4/ofbuEN7/CpmCr
        oc9h58/3lkUuOV9dXLElzmxr8jmjTw2/09kEmn/3uqR/nLf+xyShBzPPnVihr/n43IOPq1dq
        NX5ya6xVUrAPn3lbcO1ys5OfWM9nCG1+eHbpv7ylLYv6vFSuLtt3yU4qcdVa24R3io/LVBbP
        LLYQ2qPEUpyRaKjFXFScCACANeEhvgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC5WfdrKvb4ZtqsH67nMWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBlHt/5jKug0qdi6ex9LA+NXtS5GTg4JAROJn3vusILYLAKqElNf3ACz2QTUJW7c
        +MkMYosIaEh8WricvYuRi4NZ4A2TxOnmbWBFwgLuErtO3QEr4hWwkOg+/4wNxBYSyJS40bmV
        FSIuKHFy5hMWEJtZQEvixr+XTF2MHEC2tMTyfxwgYU4BO4nnnd/AxogKKEsc2HacaQIj7ywk
        3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMKaW1f6ZuIPxy2X3Q4wCHIxK
        PLwXrvukCrEmlhVX5h5ilOBgVhLhvWACFOJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQ
        nliSmp2aWpBaBJNl4uCUamD0Uf6azbNMxf+gC3Om532th20mL+47M2/MWy436dL/z68XSNot
        u//EmmFFySJXvXDb8Nt1XY+mHpth4i/z7ecq+1ORR77ffXHH1OnR3XBB3bX3bzlvfxrhanCF
        q4dD6e/qW/xbvdXtb+z89XjG0zczGTw1j9dmF73Kudg06UBt8NuLQUt27016qcRSnJFoqMVc
        VJwIAA5006mlAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:20:29PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Hi everyone,
> >
> > While I'm working with CXL memory, I have been facing migration overhead
> > esp. TLB shootdown on promotion or demotion between different tiers.
> > Yeah.. most TLB shootdowns on migration through hinting fault can be
> > avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
> > flushing TLB in batch if PTE is inaccessible").
> >
> > However, it's only for ones using hinting fault. I thought it'd be much
> > better if we have a general mechanism to reduce # of TLB flushes and
> > TLB misses, that we can apply to any type of migration. I tried it only
> > for tiering migration for now tho.
> >
> > I'm suggesting a mechanism to reduce TLB flushes by keeping source and
> > destination of folios participated in the migrations until all TLB
> > flushes required are done, only if those folios are not mapped with
> > write permission PTE entries at all. I worked Based on v6.6-rc5.
> >
> > Can you believe it? I saw the number of TLB full flush reduced about
> > 80% and iTLB miss reduced about 50%, and the time wise performance
> > always shows at least 1% stable improvement with the workload I tested
> > with, XSBench. However, I believe that it would help more with other
> > ones or any real ones. It'd be appreciated to let me know if I'm missing
> > something.
> 
> Can you help to test the effect of commit 7e12beb8ca2a ("migrate_pages:
> batch flushing TLB") for your test case?  To test it, you can revert it
> and compare the performance before and after the reverting.

I will.

> And, how do you trigger migration when testing XSBench?  Use a tiered
> memory system, and migrate pages between DRAM and CXL memory back and
> forth?  If so, how many pages will you migrate for each migration?

Honestly I've been focusing on the migration # and TLB #. I will get
back to you.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> >
> > 	Byungchul
> >
> > ---
> >
> > Changes from v3:
> >
> > 	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
> > 	   migrc_enable. (feedbacked by Nadav)
> > 	2. Remove the optimization skipping CPUs that have already
> > 	   performed TLB flushes needed by any reason when performing
> > 	   TLB flushes by migrc because I can't tell the performance
> > 	   difference between w/ the optimization and w/o that.
> > 	   (feedbacked by Nadav)
> > 	3. Minimize arch-specific code. While at it, move all the migrc
> >            declarations and inline functions from include/linux/mm.h to
> >            mm/internal.h (feedbacked by Dave Hansen, Nadav)
> > 	4. Separate a part making migrc paused when the system is in
> > 	   high memory pressure to another patch. (feedbacked by Nadav)
> > 	5. Rename:
> > 	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
> > 	      b. tlb_ubc_nowr to tlb_ubc_ro,
> > 	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
> > 	      d. migrc_stop to migrc_pause.
> > 	   (feedbacked by Nadav)
> > 	6. Use ->lru list_head instead of introducing a new llist_head.
> > 	   (feedbacked by Nadav)
> > 	7. Use non-atomic operations of page-flag when it's safe.
> > 	   (feedbacked by Nadav)
> > 	8. Use stack instead of keeping a pointer of 'struct migrc_req'
> > 	   in struct task, which is for manipulating it locally.
> > 	   (feedbacked by Nadav)
> > 	9. Replace a lot of simple functions to inline functions placed
> > 	   in a header, mm/internal.h. (feedbacked by Nadav)
> > 	10. Add additional sufficient comments. (feedbacked by Nadav)
> > 	11. Remove a lot of wrapper functions. (feedbacked by Nadav)
> >
> > Changes from RFC v2:
> >
> > 	1. Remove additional occupation in struct page. To do that,
> > 	   unioned with lru field for migrc's list and added a page
> > 	   flag. I know page flag is a thing that we don't like to add
> > 	   but no choice because migrc should distinguish folios under
> > 	   migrc's control from others. Instead, I force migrc to be
> > 	   used only on 64 bit system to mitigate you guys from getting
> > 	   angry.
> > 	2. Remove meaningless internal object allocator that I
> > 	   introduced to minimize impact onto the system. However, a ton
> > 	   of tests showed there was no difference.
> > 	3. Stop migrc from working when the system is in high memory
> > 	   pressure like about to perform direct reclaim. At the
> > 	   condition where the swap mechanism is heavily used, I found
> > 	   the system suffered from regression without this control.
> > 	4. Exclude folios that pte_dirty() == true from migrc's interest
> > 	   so that migrc can work simpler.
> > 	5. Combine several patches that work tightly coupled to one.
> > 	6. Add sufficient comments for better review.
> > 	7. Manage migrc's request in per-node manner (from globally).
> > 	8. Add TLB miss improvement in commit message.
> > 	9. Test with more CPUs(4 -> 16) to see bigger improvement.
> >
> > Changes from RFC:
> >
> > 	1. Fix a bug triggered when a destination folio at the previous
> > 	   migration becomes a source folio at the next migration,
> > 	   before the folio gets handled properly so that the folio can
> > 	   play with another migration. There was inconsistency in the
> > 	   folio's state. Fixed it.
> > 	2. Split the patch set into more pieces so that the folks can
> > 	   review better. (Feedbacked by Nadav Amit)
> > 	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
> > 	   (Feedbacked by Nadav Amit)
> > 	4. Tried to add sufficient comments to explain the patch set
> > 	   better. (Feedbacked by Nadav Amit)
> >
> > Byungchul Park (3):
> >   mm/rmap: Recognize read-only TLB entries during batched TLB flush
> >   mm: Defer TLB flush by keeping both src and dst folios at migration
> >   mm: Pause migrc mechanism at high memory pressure
> >
> >  arch/x86/include/asm/tlbflush.h |   3 +
> >  arch/x86/mm/tlb.c               |  11 ++
> >  include/linux/mm_types.h        |  21 +++
> >  include/linux/mmzone.h          |   9 ++
> >  include/linux/page-flags.h      |   4 +
> >  include/linux/sched.h           |   7 +
> >  include/trace/events/mmflags.h  |   3 +-
> >  mm/internal.h                   |  78 ++++++++++
> >  mm/memory.c                     |  11 ++
> >  mm/migrate.c                    | 266 ++++++++++++++++++++++++++++++++
> >  mm/page_alloc.c                 |  30 +++-
> >  mm/rmap.c                       |  35 ++++-
> >  12 files changed, 475 insertions(+), 3 deletions(-)
