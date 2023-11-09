Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E737E6322
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjKIFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:22:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69D26A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699507356; x=1731043356;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=e33c2uN/sZ1gCO8gfMvAlJ76c6IyVEglAASzfPKBaMc=;
  b=Z6DTgIwPHdwauflFuI721iktrbSsARpV4aFKhnQ+gjyf3NXXgkSR5XKP
   BcaJjNkCaEj6hAZM4BHlx64mp6T31t2qKfSYhuPIFBjhSdFF134wel/+g
   y1Czck2qAhfqp1cTxdcPGjFvjl/GDWDyHSaC3zhenT6n/zcOfUwuzhnYq
   MdSLsFWJAOeBTrL9N/ZDL2jFTAaQzvJ3JmBcVzcFY3d4zjuu+FcPIXF/v
   1YSB1TfiITEdJyXE+Bd+ZBh2NxTn5DpLQrNInDT5H7DfrwMkOnAc/BMuO
   SEuL6FexInHVKlYCMabd8Y8Q3m93k7rLZniYSx2Mc7UlF9d4CXLZeEbcV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="387084982"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="387084982"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763295380"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="763295380"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:22:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul@sk.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel_team@skhynix.com>, <akpm@linux-foundation.org>,
        <namit@vmware.com>, <xhao@linux.alibaba.com>,
        <mgorman@techsingularity.net>, <hughd@google.com>,
        <willy@infradead.org>, <david@redhat.com>, <peterz@infradead.org>,
        <luto@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
In-Reply-To: <20231109045908.54996-1-byungchul@sk.com> (Byungchul Park's
        message of "Thu, 9 Nov 2023 13:59:05 +0900")
References: <20231109045908.54996-1-byungchul@sk.com>
Date:   Thu, 09 Nov 2023 13:20:29 +0800
Message-ID: <87il6bijtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul@sk.com> writes:

> Hi everyone,
>
> While I'm working with CXL memory, I have been facing migration overhead
> esp. TLB shootdown on promotion or demotion between different tiers.
> Yeah.. most TLB shootdowns on migration through hinting fault can be
> avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
> flushing TLB in batch if PTE is inaccessible").
>
> However, it's only for ones using hinting fault. I thought it'd be much
> better if we have a general mechanism to reduce # of TLB flushes and
> TLB misses, that we can apply to any type of migration. I tried it only
> for tiering migration for now tho.
>
> I'm suggesting a mechanism to reduce TLB flushes by keeping source and
> destination of folios participated in the migrations until all TLB
> flushes required are done, only if those folios are not mapped with
> write permission PTE entries at all. I worked Based on v6.6-rc5.
>
> Can you believe it? I saw the number of TLB full flush reduced about
> 80% and iTLB miss reduced about 50%, and the time wise performance
> always shows at least 1% stable improvement with the workload I tested
> with, XSBench. However, I believe that it would help more with other
> ones or any real ones. It'd be appreciated to let me know if I'm missing
> something.

Can you help to test the effect of commit 7e12beb8ca2a ("migrate_pages:
batch flushing TLB") for your test case?  To test it, you can revert it
and compare the performance before and after the reverting.

And, how do you trigger migration when testing XSBench?  Use a tiered
memory system, and migrate pages between DRAM and CXL memory back and
forth?  If so, how many pages will you migrate for each migration?

--
Best Regards,
Huang, Ying

>
> 	Byungchul
>
> ---
>
> Changes from v3:
>
> 	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
> 	   migrc_enable. (feedbacked by Nadav)
> 	2. Remove the optimization skipping CPUs that have already
> 	   performed TLB flushes needed by any reason when performing
> 	   TLB flushes by migrc because I can't tell the performance
> 	   difference between w/ the optimization and w/o that.
> 	   (feedbacked by Nadav)
> 	3. Minimize arch-specific code. While at it, move all the migrc
>            declarations and inline functions from include/linux/mm.h to
>            mm/internal.h (feedbacked by Dave Hansen, Nadav)
> 	4. Separate a part making migrc paused when the system is in
> 	   high memory pressure to another patch. (feedbacked by Nadav)
> 	5. Rename:
> 	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
> 	      b. tlb_ubc_nowr to tlb_ubc_ro,
> 	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
> 	      d. migrc_stop to migrc_pause.
> 	   (feedbacked by Nadav)
> 	6. Use ->lru list_head instead of introducing a new llist_head.
> 	   (feedbacked by Nadav)
> 	7. Use non-atomic operations of page-flag when it's safe.
> 	   (feedbacked by Nadav)
> 	8. Use stack instead of keeping a pointer of 'struct migrc_req'
> 	   in struct task, which is for manipulating it locally.
> 	   (feedbacked by Nadav)
> 	9. Replace a lot of simple functions to inline functions placed
> 	   in a header, mm/internal.h. (feedbacked by Nadav)
> 	10. Add additional sufficient comments. (feedbacked by Nadav)
> 	11. Remove a lot of wrapper functions. (feedbacked by Nadav)
>
> Changes from RFC v2:
>
> 	1. Remove additional occupation in struct page. To do that,
> 	   unioned with lru field for migrc's list and added a page
> 	   flag. I know page flag is a thing that we don't like to add
> 	   but no choice because migrc should distinguish folios under
> 	   migrc's control from others. Instead, I force migrc to be
> 	   used only on 64 bit system to mitigate you guys from getting
> 	   angry.
> 	2. Remove meaningless internal object allocator that I
> 	   introduced to minimize impact onto the system. However, a ton
> 	   of tests showed there was no difference.
> 	3. Stop migrc from working when the system is in high memory
> 	   pressure like about to perform direct reclaim. At the
> 	   condition where the swap mechanism is heavily used, I found
> 	   the system suffered from regression without this control.
> 	4. Exclude folios that pte_dirty() == true from migrc's interest
> 	   so that migrc can work simpler.
> 	5. Combine several patches that work tightly coupled to one.
> 	6. Add sufficient comments for better review.
> 	7. Manage migrc's request in per-node manner (from globally).
> 	8. Add TLB miss improvement in commit message.
> 	9. Test with more CPUs(4 -> 16) to see bigger improvement.
>
> Changes from RFC:
>
> 	1. Fix a bug triggered when a destination folio at the previous
> 	   migration becomes a source folio at the next migration,
> 	   before the folio gets handled properly so that the folio can
> 	   play with another migration. There was inconsistency in the
> 	   folio's state. Fixed it.
> 	2. Split the patch set into more pieces so that the folks can
> 	   review better. (Feedbacked by Nadav Amit)
> 	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
> 	   (Feedbacked by Nadav Amit)
> 	4. Tried to add sufficient comments to explain the patch set
> 	   better. (Feedbacked by Nadav Amit)
>
> Byungchul Park (3):
>   mm/rmap: Recognize read-only TLB entries during batched TLB flush
>   mm: Defer TLB flush by keeping both src and dst folios at migration
>   mm: Pause migrc mechanism at high memory pressure
>
>  arch/x86/include/asm/tlbflush.h |   3 +
>  arch/x86/mm/tlb.c               |  11 ++
>  include/linux/mm_types.h        |  21 +++
>  include/linux/mmzone.h          |   9 ++
>  include/linux/page-flags.h      |   4 +
>  include/linux/sched.h           |   7 +
>  include/trace/events/mmflags.h  |   3 +-
>  mm/internal.h                   |  78 ++++++++++
>  mm/memory.c                     |  11 ++
>  mm/migrate.c                    | 266 ++++++++++++++++++++++++++++++++
>  mm/page_alloc.c                 |  30 +++-
>  mm/rmap.c                       |  35 ++++-
>  12 files changed, 475 insertions(+), 3 deletions(-)
