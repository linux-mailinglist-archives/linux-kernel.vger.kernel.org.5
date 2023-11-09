Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5647E62FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjKIE71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKIE7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:59:24 -0500
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9FB92594
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:59:21 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-f7-654c6726fb7b
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v4 0/3] Reduce TLB flushes under some specific conditions
Date:   Thu,  9 Nov 2023 13:59:05 +0900
Message-Id: <20231109045908.54996-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnoa5auk+qwYMWQ4s569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsri+6yGjxfHeA0wW
        mzdNZbb4/QOobs4UK4uTsyazOAh4fG/tY/FYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPd+fO
        sXucmPGbxWPnQ0uPeScDPd7vu8rmsfWXncfnTXIe7+a/ZQvgi+KySUnNySxLLdK3S+DK6Hi3
        m61gunbFnbVbGBsYvyh0MXJySAiYSHR3bmeGsS/N28MCYrMJqEvcuPETLC4iYCZxsPUPexcj
        FwezwAMmiblvVzCCJIQFnCWW/ZnC1sXIwcEioCrxo6cYJMwrYCpxcd8FNoiZ8hKrNxxgBumV
        ELjPJjF3+Xp2iISkxMEVN1gmMHIvYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYxstq/0Tv
        YPx0IfgQowAHoxIP742/3qlCrIllxZW5hxglOJiVRHgvmPikCvGmJFZWpRblxxeV5qQWH2KU
        5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamBMnu1mt/Pslv9maR4bY7fkMFcefOd39Up4
        Wv10pmPvXiRW+rru+Pgx/HqCKM+8BLYlmRsWbmn/t8Pzostul6sPXpc+n8q29m+Efnrnieob
        2nOMC+PPcgYf9Mm5/yOtcdocrW/d79kz9U/te3jjmM0Pvi1pn/4FXGyyt57Dx3YwqHlxU37J
        ti8xSizFGYmGWsxFxYkAay1RlV8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAwFGArn9CAMSswMaCGludGVybmFsIgYKBApOO4MtJmdMZTDf2xs4nK+sBjjz
        sP4GOOiwhwE49a/6Azjl8o4EOMOdyQU407qcBjjerP8FOM+6rQU4uKW+AjjSwKACONe64QE4
        x43AAjizspUDOPv4nAY4nJQ6OMmakwRAEUj3hY4ESKCydUizqCpIo7zpAkiyqokGSLLykgdI
        7s7OB0jImPsESLnhOUieyVFI777VBkij6PACSLX6Pkjzsh5I7p/tBlAPWgo8ZGVsaXZlci8+
        YApoiO67BnCXK3jcrbQBgAH0IIoBCQgYEDQY0p68BIoBCQgGECcY2Nj5A4oBCQgUEDYYwYX8
        B4oBCggDEOACGJ3tqAGKAQkIExBDGKb8lAaKAQgIBBAlGPiMc4oBCQgNEDUY0b7QBooBCQgY
        EB8Yq7DAA5ABCKABAKoBFGludm1haWw1LnNraHluaXguY29tsgEGCgSmffyRuAH000fCARAI
        ASIMDWCUS2USBWF2c3ltwgEYCAMiFA3QNExlEg1kYXl6ZXJvX3J1bGVzwgEbCAQiFw1KV2Vg
        EhBnYXRla2VlcGVyX3J1bGVzwgECCAkagAFFFnzEaIG75a+9aDs+MPOG5waZ8Hv4merIuO18
        qxWpERYU24GKdQcOpD034ovIz4ZeFPOQkI1AGUPoRpfYURVwxEnczj5Wg1vpr2I0vAadPGvF
        HlCSCOGfFnAygY7+2ftA9t+1EB8CRAQ1162NVhtZt7D9ENbNKBt73eLiM6JP1yIEc2hhMSoD
        cnNhjxryDEYCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

While I'm working with CXL memory, I have been facing migration overhead
esp. TLB shootdown on promotion or demotion between different tiers.
Yeah.. most TLB shootdowns on migration through hinting fault can be
avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
flushing TLB in batch if PTE is inaccessible").

However, it's only for ones using hinting fault. I thought it'd be much
better if we have a general mechanism to reduce # of TLB flushes and
TLB misses, that we can apply to any type of migration. I tried it only
for tiering migration for now tho.

I'm suggesting a mechanism to reduce TLB flushes by keeping source and
destination of folios participated in the migrations until all TLB
flushes required are done, only if those folios are not mapped with
write permission PTE entries at all. I worked Based on v6.6-rc5.

Can you believe it? I saw the number of TLB full flush reduced about
80% and iTLB miss reduced about 50%, and the time wise performance
always shows at least 1% stable improvement with the workload I tested
with, XSBench. However, I believe that it would help more with other
ones or any real ones. It'd be appreciated to let me know if I'm missing
something.

	Byungchul

---

Changes from v3:

	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
	   migrc_enable. (feedbacked by Nadav)
	2. Remove the optimization skipping CPUs that have already
	   performed TLB flushes needed by any reason when performing
	   TLB flushes by migrc because I can't tell the performance
	   difference between w/ the optimization and w/o that.
	   (feedbacked by Nadav)
	3. Minimize arch-specific code. While at it, move all the migrc
           declarations and inline functions from include/linux/mm.h to
           mm/internal.h (feedbacked by Dave Hansen, Nadav)
	4. Separate a part making migrc paused when the system is in
	   high memory pressure to another patch. (feedbacked by Nadav)
	5. Rename:
	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
	      b. tlb_ubc_nowr to tlb_ubc_ro,
	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
	      d. migrc_stop to migrc_pause.
	   (feedbacked by Nadav)
	6. Use ->lru list_head instead of introducing a new llist_head.
	   (feedbacked by Nadav)
	7. Use non-atomic operations of page-flag when it's safe.
	   (feedbacked by Nadav)
	8. Use stack instead of keeping a pointer of 'struct migrc_req'
	   in struct task, which is for manipulating it locally.
	   (feedbacked by Nadav)
	9. Replace a lot of simple functions to inline functions placed
	   in a header, mm/internal.h. (feedbacked by Nadav)
	10. Add additional sufficient comments. (feedbacked by Nadav)
	11. Remove a lot of wrapper functions. (feedbacked by Nadav)

Changes from RFC v2:

	1. Remove additional occupation in struct page. To do that,
	   unioned with lru field for migrc's list and added a page
	   flag. I know page flag is a thing that we don't like to add
	   but no choice because migrc should distinguish folios under
	   migrc's control from others. Instead, I force migrc to be
	   used only on 64 bit system to mitigate you guys from getting
	   angry.
	2. Remove meaningless internal object allocator that I
	   introduced to minimize impact onto the system. However, a ton
	   of tests showed there was no difference.
	3. Stop migrc from working when the system is in high memory
	   pressure like about to perform direct reclaim. At the
	   condition where the swap mechanism is heavily used, I found
	   the system suffered from regression without this control.
	4. Exclude folios that pte_dirty() == true from migrc's interest
	   so that migrc can work simpler.
	5. Combine several patches that work tightly coupled to one.
	6. Add sufficient comments for better review.
	7. Manage migrc's request in per-node manner (from globally).
	8. Add TLB miss improvement in commit message.
	9. Test with more CPUs(4 -> 16) to see bigger improvement.

Changes from RFC:

	1. Fix a bug triggered when a destination folio at the previous
	   migration becomes a source folio at the next migration,
	   before the folio gets handled properly so that the folio can
	   play with another migration. There was inconsistency in the
	   folio's state. Fixed it.
	2. Split the patch set into more pieces so that the folks can
	   review better. (Feedbacked by Nadav Amit)
	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
	   (Feedbacked by Nadav Amit)
	4. Tried to add sufficient comments to explain the patch set
	   better. (Feedbacked by Nadav Amit)

Byungchul Park (3):
  mm/rmap: Recognize read-only TLB entries during batched TLB flush
  mm: Defer TLB flush by keeping both src and dst folios at migration
  mm: Pause migrc mechanism at high memory pressure

 arch/x86/include/asm/tlbflush.h |   3 +
 arch/x86/mm/tlb.c               |  11 ++
 include/linux/mm_types.h        |  21 +++
 include/linux/mmzone.h          |   9 ++
 include/linux/page-flags.h      |   4 +
 include/linux/sched.h           |   7 +
 include/trace/events/mmflags.h  |   3 +-
 mm/internal.h                   |  78 ++++++++++
 mm/memory.c                     |  11 ++
 mm/migrate.c                    | 266 ++++++++++++++++++++++++++++++++
 mm/page_alloc.c                 |  30 +++-
 mm/rmap.c                       |  35 ++++-
 12 files changed, 475 insertions(+), 3 deletions(-)

-- 
2.17.1

