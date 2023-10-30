Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808BE7DB485
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjJ3HlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3HlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:41:00 -0400
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 00:40:55 PDT
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDADC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:40:55 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-9b-653f5a7f3bb6
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v3 0/3] Reduce TLB flushes under some specific conditions
Date:   Mon, 30 Oct 2023 16:25:37 +0900
Message-Id: <20231030072540.38631-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC9ZZnoW59lH2qQdNzUYs569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsri+6yGjxfHeA0wW
        mzdNZbb4/QOobs4UK4uTsyazOAh4fG/tY/FYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPd+fO
        sXucmPGbxWPnQ0uPeScDPd7vu8rmsfWXncfnTXIe7+a/ZQvgi+KySUnNySxLLdK3S+DKOHP0
        AkvBL5WKnxOmsDQwfpTuYuTkkBAwkTi98jU7jL1u2xkWEJtNQF3ixo2fzCC2iICZxMHWP0A1
        XBzMAg+YJOa+XcEIkhAWcJY4s3o2WDOLgKrEh4u/2EBsXgFTiZN7fjFCDJWXWL3hADNIs4TA
        bTaJBYeeMUEkJCUOrrjBMoGRewEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwEBeVvsnegfj
        pwvBhxgFOBiVeHgDwu1ShVgTy4orcw8xSnAwK4nwMjvapArxpiRWVqUW5ccXleakFh9ilOZg
        URLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgdM7d/G77xZ6PlXfmzOT7ufPV1MNlj+/zriiR
        yNnFHmTXMOXo2hBGKYnCm4di9zwI6Lq063Nzj3mgct+xG5WTGOJ2hfSu0/pY+c8g7oiA+vWk
        m5ftH6XM2V+VIPfWm8tyvcaMmx940o9fULgfeK77IqPa4aL4h1YJ8y/OeS88MaKgQveVTcqX
        SUosxRmJhlrMRcWJALrMaC9gAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsXC5WfdrFsfZZ9qMOcBs8Wc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBlnjl5gKfilUvFzwhSWBsaP0l2MnBwSAiYS67adYQGx2QTUJW7c+MkMYosImEkc
        bP3D3sXIxcEs8IBJYu7bFYwgCWEBZ4kzq2ezg9gsAqoSHy7+YgOxeQVMJU7u+cUIMVReYvWG
        A8wTGDkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzLZbV/Ju5g/HLZ/RCjAAejEg9v
        QLhdqhBrYllxZe4hRgkOZiURXmZHm1Qh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJ
        JanZqakFqUUwWSYOTqkGRjVDL6bfLow8WmUSXFfull9LkkyMm7juTaDWXGmTde1xMte/JDzl
        2OJ12dnusrKe/s1ZC2ZbOpTJyX6+v+N+xszVt00rEryb7Bob4ia6F3hsWKnUu0co8PDayKqf
        6i33Zk7/krBS2PxklPvUHdnsi+e/TpVqnGLTlpzPErl2Q4vzdXmD+UdXKbEUZyQaajEXFScC
        APbxBLdHAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To Huang Ying,

I tried to apply migrc to swap. Fortunately I couldn't see any
regression but no performance improvement either. I thought it's
meaningless to make code bigger without observing any benefit. So I
won't include the part. Thoughts?

To Nadav Amit,

I tried to split this patch set to as many as possible for better
review. However, it was very hard to make each patch meaningfully and
stably work because it works very tightly coupled to one another. So I
ended in combining those patches to one again. Instead, I tried my best
to add sufficient comments in code. Any opinion would be appreciated.

Hi everyone,

While I'm working with CXL memory, I have been facing migraion overhead
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
80%, iTLB miss reduced about 50% and the performance improved a little
bit with the workload I tested with, XSBench. However, I believe that it
would help more with other ones or any real ones. It'd be appreciated to
let me know if I'm missing something.

	Byungchul

---

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
  mm/rmap: Recognize non-writable TLB entries during TLB batch flush
  mm: Defer TLB flush by keeping both src and dst folios at migration
  mm, migrc: Add a sysctl knob to enable/disable MIGRC mechanism

 arch/x86/include/asm/tlbflush.h |   9 +
 arch/x86/mm/tlb.c               |  98 ++++++++++
 include/linux/mm.h              |  25 +++
 include/linux/mm_types.h        |  49 +++++
 include/linux/mm_types_task.h   |   4 +-
 include/linux/mmzone.h          |   7 +
 include/linux/page-flags.h      |   7 +
 include/linux/sched.h           |   9 +
 include/trace/events/mmflags.h  |   9 +-
 init/Kconfig                    |  14 ++
 mm/internal.h                   |  14 ++
 mm/memory.c                     |  13 ++
 mm/migrate.c                    | 310 ++++++++++++++++++++++++++++++++
 mm/page_alloc.c                 |  29 ++-
 mm/rmap.c                       | 115 +++++++++++-
 15 files changed, 703 insertions(+), 9 deletions(-)

-- 
2.17.1

