Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616780468F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjLED3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjLED27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:28:59 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A6CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:29:04 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-46487cb65f4so589169137.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701746944; x=1702351744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRYZs2ccf7Jea7Y1XO8nn0v+O1TPuptHdUG0scn04ls=;
        b=cqTiiLnxCJrRegV1Or82nEDUrXy0qXiKsa0oeaJKtiIWqA337VtdsFhA6Dy8RmB8ss
         fRDIoiCQ1J9CjJxGAWsV+zVsXxBXst/TuvJOvWs1GY9g89CDECdPNPpQbEZImIqvBUpA
         XKGZ3DsHvaBIZKDSF4Y9vVlDM5NwKHfJUEmAVHxazp2U9DJAQq8UB8pRC3l3UmyJS6wM
         qTMjOfLxU7+GA/kFJa7qL9bs0EtUeIXWYslbucxvxbbn9BDNhUVV0V7D7UXjm+MHZuno
         F9eqCNZH4eHyuvekkZgoS1dV1gMSEoPakGgEN3zjHfT9xQX7LfKKbwuzcaW5otsc2mkL
         EzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701746944; x=1702351744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRYZs2ccf7Jea7Y1XO8nn0v+O1TPuptHdUG0scn04ls=;
        b=eW8us1dXhOaWenlKajdmdff3A7BJKJR/7gjZIzbUlzqkbOxrrB9EpFTcgtAf0uX6uL
         QqSMBm1Fd+zhdF3fIxHD7dqtpEMsyZFhuiJkk/T7mq6MoBgLnWwKr+8JwWYiHFn8gHdP
         bt8WYFg3g7bTWkKrMgs/C2yAo9dro0Jekws/Zngjs7Sn9QG8r3Ln5HwhjPPYU7lGz/Jy
         w2ZQHS1NtYETV0OyQ1EWQCs1/M2SBPVwznZ/5l5bmpg336Hv6KsLTCNn6uwOgi3Gu/xm
         WDNWbhv5em0o/3Ozg+19o+by2voaoXdkCJL8S1l6JnTFV+V2j0J41KR2JgLm7azTUb8A
         dU5g==
X-Gm-Message-State: AOJu0YyUT+E9gqyDx5NG+o8xy+TVnrecCknhcpxijnPQGhduyvjaR/3y
        qyq+DSV4M8fbIBP9JnOzc9UfYknLYzYylXOrG5I=
X-Google-Smtp-Source: AGHT+IF7H0tlqgWsjIBN/XWGNrPpJBtzSvfTM8En23cVZGvoDfTL7JSJIwMueB4hcQousWvTkXyaOmBSOrr/SCOVRLk=
X-Received: by 2002:a05:6102:34e2:b0:462:c2e9:6dda with SMTP id
 bi2-20020a05610234e200b00462c2e96ddamr2481290vsb.31.1701746943543; Mon, 04
 Dec 2023 19:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com>
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Dec 2023 16:28:51 +1300
Message-ID: <CAGsJ_4yfq8Y4vaxiP95Mrn-Oa0=3aY8kAzS6Ojd+eL-ViRr+DA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 11:20=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi All,
>
> A new week, a new version, a new name... This is v8 of a series to implem=
ent
> multi-size THP (mTHP) for anonymous memory (previously called "small-size=
d THP"
> and "large anonymous folios"). Matthew objected to "small huge" so hopefu=
lly
> this fares better.
>
> The objective of this is to improve performance by allocating larger chun=
ks of
> memory during anonymous page faults:
>
> 1) Since SW (the kernel) is dealing with larger chunks of memory than bas=
e
>    pages, there are efficiency savings to be had; fewer page faults, batc=
hed PTE
>    and RMAP manipulation, reduced lru list, etc. In short, we reduce kern=
el
>    overhead. This should benefit all architectures.
> 2) Since we are now mapping physically contiguous chunks of memory, we ca=
n take
>    advantage of HW TLB compression techniques. A reduction in TLB pressur=
e
>    speeds up kernel and user space. arm64 systems have 2 mechanisms to co=
alesce
>    TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>
> This version changes the name and tidies up some of the kernel code and t=
est
> code, based on feedback against v7 (see change log for details).
>
> By default, the existing behaviour (and performance) is maintained. The u=
ser
> must explicitly enable multi-size THP to see the performance benefit. Thi=
s is
> done via a new sysfs interface (as recommended by David Hildenbrand - tha=
nks to
> David for the suggestion)! This interface is inspired by the existing
> per-hugepage-size sysfs interface used by hugetlb, provides full backward=
s
> compatibility with the existing PMD-size THP interface, and provides a ba=
se for
> future extensibility. See [8] for detailed discussion of the interface.
>
> This series is based on mm-unstable (715b67adf4c8).
>
>
> Prerequisites
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Some work items identified as being prerequisites are listed on page 3 at=
 [9].
> The summary is:
>
> | item                          | status                  |
> |:------------------------------|:------------------------|
> | mlock                         | In mainline (v6.7)      |
> | madvise                       | In mainline (v6.6)      |
> | compaction                    | v1 posted [10]          |
> | numa balancing                | Investigated: see below |
> | user-triggered page migration | In mainline (v6.7)      |
> | khugepaged collapse           | In mainline (NOP)       |
>
> On NUMA balancing, which currently ignores any PTE-mapped THPs it encount=
ers,
> John Hubbard has investigated this and concluded that it is A) not clear =
at the
> moment what a better policy might be for PTE-mapped THP and B) questions =
whether
> this should really be considered a prerequisite given no regression is ca=
used
> for the default "multi-size THP disabled" case, and there is no correctne=
ss
> issue when it is enabled - its just a potential for non-optimal performan=
ce.
>
> If there are no disagreements about removing numa balancing from the list=
 (none
> were raised when I first posted this comment against v7), then that just =
leaves
> compaction which is in review on list at the moment.
>
> I really would like to get this series (and its remaining comapction
> prerequisite) in for v6.8. I accept that it may be a bit optimistic at th=
is
> point, but lets see where we get to with review?
>

Hi Ryan,

A question but i don't think it should block this series,  do we have any p=
lan
to extend /proc/meminfo, /proc/pid/smaps, /proc/vmstat to present some
information regarding the new multi-size THP.

e.g how many folios in each-size for the system, how many multi-size folios=
 LRU,
how many large folios in each VMA etc.

In products and labs, we need some health monitors to make sure the system
status is visible and works as expected. right now, i feel i am like
blindly exploring
the system without those statistics.

>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The series includes patches for mm selftests to enlighten the cow and khu=
gepaged
> tests to explicitly test with multi-size THP, in the same way that PMD-si=
zed
> THP is tested. The new tests all pass, and no regressions are observed in=
 the mm
> selftest suite. I've also run my usual kernel compilation and java script
> benchmarks without any issues.
>
> Refer to my performance numbers posted with v6 [6]. (These are for multi-=
size
> THP only - they do not include the arm64 contpte follow-on series).
>
> John Hubbard at Nvidia has indicated dramatic 10x performance improvement=
s for
> some workloads at [11]. (Observed using v6 of this series as well as the =
arm64
> contpte series).
>
> Kefeng Wang at Huawei has also indicated he sees improvements at [12] alt=
hough
> there are some latency regressions also.
>
>
> Changes since v7 [7]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Renamed "small-sized THP" -> "multi-size THP" in commit logs
>   - Added various Reviewed-by/Tested-by tags (Barry, David, Alistair)
>   - Patch 3:
>       - Fine-tuned transhuge documentation multi-size THP (JohnH)
>       - Converted hugepage_global_enabled() and hugepage_global_always() =
macros
>         to static inline functions (JohnH)
>       - Renamed hugepage_vma_check() to thp_vma_allowable_orders() (JohnH=
)
>       - Renamed transhuge_vma_suitable() to thp_vma_suitable_orders() (Jo=
hnH)
>       - Renamed "global" enabled sysfs file option to "inherit" (JohnH)
>   - Patch 9:
>       - cow selftest: Renamed param size -> thpsize (David)
>       - cow selftest: Changed test fail to assert() (David)
>       - cow selftest: Log PMD size separately from all the supported THP =
sizes
>         (David)
>   - Patch 10:
>       - cow selftest: No longer special case pmdsize; keep all THP sizes =
in
>         thpsizes[]
>
>
> Changes since v6 [6]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Refactored vmf_pte_range_changed() to remove uffd special-case (sugge=
sted by
>     JohnH)
>   - Dropped accounting patch (#3 in v6) (suggested by DavidH)
>       - Continue to account *PMD-sized* THP only for now
>       - Can add more counters in future if needed
>       - Page cache large folios haven't needed any new counters yet
>   - Pivot to sysfs ABI proposed by DavidH
>       - per-size directories in a similar shape to that used by hugetlb
>   - Dropped "recommend" keyword patch (#6 in v6) (suggested by DavidH, Yu=
 Zhou)
>       - For now, users need to understand implicitly which sizes are bene=
ficial
>         to their HW/SW
>   - Dropped arch_wants_pte_order() patch (#7 in v6)
>       - No longer needed due to dropping patch "recommend" keyword patch
>   - Enlightened khugepaged mm selftest to explicitly test with small-size=
 THP
>   - Scrubbed commit logs to use "small-sized THP" consistently (suggested=
 by
>     DavidH)
>
>
> Changes since v5 [5]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Added accounting for PTE-mapped THPs (patch 3)
>   - Added runtime control mechanism via sysfs as extension to THP (patch =
4)
>   - Minor refactoring of alloc_anon_folio() to integrate with runtime con=
trols
>   - Stripped out hardcoded policy for allocation order; its now all user =
space
>     controlled (although user space can request "recommend" which will co=
nfigure
>     the HW-preferred order)
>
>
> Changes since v4 [4]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>     now uses the default order-3 size. I have moved this patch over to
>     the contpte series.
>   - Added "mm: Allow deferred splitting of arbitrary large anon folios" b=
ack
>     into series. I originally removed this at v2 to add to a separate ser=
ies,
>     but that series has transformed significantly and it no longer fits, =
so
>     bringing it back here.
>   - Reintroduced dependency on set_ptes(); Originally dropped this at v2,=
 but
>     set_ptes() is in mm-unstable now.
>   - Updated policy for when to allocate LAF; only fallback to order-0 if
>     MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer re=
ly on
>     sysfs's never/madvise/always knob.
>   - Fallback to order-0 whenever uffd is armed for the vma, not just when
>     uffd-wp is set on the pte.
>   - alloc_anon_folio() now returns `struct folio *`, where errors are enc=
oded
>     with ERR_PTR().
>
>   The last 3 changes were proposed by Yu Zhao - thanks!
>
>
> Changes since v3 [3]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>   - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded t=
hat a
>     sysctl is preferable but we will wait until real workload needs it.
>   - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>   - Added mm selftests for large anon folios in cow test suite.
>
>
> Changes since v2 [2]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Dropped commit "Allow deferred splitting of arbitrary large anon foli=
os"
>       - Huang, Ying suggested the "batch zap" work (which I dropped from =
this
>         series after v1) is a prerequisite for merging FLXEIBLE_THP, so I=
've
>         moved the deferred split patch to a separate series along with th=
e batch
>         zap changes. I plan to submit this series early next week.
>   - Changed folio order fallback policy
>       - We no longer iterate from preferred to 0 looking for acceptable p=
olicy
>       - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and=
 0 only
>   - Removed vma parameter from arch_wants_pte_order()
>   - Added command line parameter `flexthp_unhinted_max`
>       - clamps preferred order when vma hasn't explicitly opted-in to THP
>   - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is di=
sabled
>     for process or system).
>   - Simplified implementation and integration with do_anonymous_page()
>   - Removed dependency on set_ptes()
>
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>   - replaced with arch-independent alloc_anon_folio()
>       - follows THP allocation approach
>   - no longer retry with intermediate orders if allocation fails
>       - fallback directly to order-0
>   - remove folio_add_new_anon_rmap_range() patch
>       - instead add its new functionality to folio_add_new_anon_rmap()
>   - remove batch-zap pte mappings optimization patch
>       - remove enabler folio_remove_rmap_range() patch too
>       - These offer real perf improvement so will submit separately
>   - simplify Kconfig
>       - single FLEXIBLE_THP option, which is independent of arch
>       - depends on TRANSPARENT_HUGEPAGE
>       - when enabled default to max anon folio size of 64K unless arch
>         explicitly overrides
>   - simplify changes to do_anonymous_page():
>       - no more retry loop
>
>
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.robert=
s@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.robert=
s@arm.com/
> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.robert=
s@arm.com/
> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.robert=
s@arm.com/
> [5] https://lore.kernel.org/linux-mm/20230810142942.3169679-1-ryan.robert=
s@arm.com/
> [6] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.robert=
s@arm.com/
> [7] https://lore.kernel.org/linux-mm/20231122162950.3854897-1-ryan.robert=
s@arm.com/
> [8] https://lore.kernel.org/linux-mm/6d89fdc9-ef55-d44e-bf12-fafff318aef8=
@redhat.com/
> [9] https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/vie=
w?usp=3Dsharing&resourcekey=3D0-U1Mj3-RhLD1JV6EThpyPyA
> [10] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent=
.com/
> [11] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be8=
5@nvidia.com/
> [12] https://lore.kernel.org/linux-mm/479b3e2b-456d-46c1-9677-38f6c95a0be=
8@huawei.com/
>
>
> Thanks,
> Ryan
>
> Ryan Roberts (10):
>   mm: Allow deferred splitting of arbitrary anon large folios
>   mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>   mm: thp: Introduce multi-size THP sysfs interface
>   mm: thp: Support allocation of anonymous multi-size THP
>   selftests/mm/kugepaged: Restore thp settings at exit
>   selftests/mm: Factor out thp settings management
>   selftests/mm: Support multi-size THP interface in thp_settings
>   selftests/mm/khugepaged: Enlighten for multi-size THP
>   selftests/mm/cow: Generalize do_run_with_thp() helper
>   selftests/mm/cow: Add tests for anonymous multi-size THP
>
>  Documentation/admin-guide/mm/transhuge.rst |  97 ++++-
>  Documentation/filesystems/proc.rst         |   6 +-
>  fs/proc/task_mmu.c                         |   3 +-
>  include/linux/huge_mm.h                    | 116 ++++--
>  mm/huge_memory.c                           | 268 ++++++++++++--
>  mm/khugepaged.c                            |  20 +-
>  mm/memory.c                                | 114 +++++-
>  mm/page_vma_mapped.c                       |   3 +-
>  mm/rmap.c                                  |  32 +-
>  tools/testing/selftests/mm/Makefile        |   4 +-
>  tools/testing/selftests/mm/cow.c           | 185 +++++++---
>  tools/testing/selftests/mm/khugepaged.c    | 410 ++++-----------------
>  tools/testing/selftests/mm/run_vmtests.sh  |   2 +
>  tools/testing/selftests/mm/thp_settings.c  | 349 ++++++++++++++++++
>  tools/testing/selftests/mm/thp_settings.h  |  80 ++++
>  15 files changed, 1177 insertions(+), 512 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/thp_settings.c
>  create mode 100644 tools/testing/selftests/mm/thp_settings.h
>
> --
> 2.25.1
>

Thanks
Barry
