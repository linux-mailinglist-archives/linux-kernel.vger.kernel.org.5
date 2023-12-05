Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568AD804760
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbjLEDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjLEDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:37:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E710F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPmlgDOq2po3UfeJWUUAoRHJTYwh6Rb9mEQpORcHXKQD8c1B2dymYjmCcgsBX8R22gqkCFshTGA9fvrOCNYYfZJ4wSLkk3ZlP2KBrGeYp4akudW+QJoyYBgix4EhZOjRA0IEnjDV41Xebo7ShaFnzrJI9H3Js8u1SJdPy9OgUgN7/6P/26holQWfJQgK+iRvbUH43ajHKwIixB4TAw9fVjDUKqK43RNjnlXSp6bvSDnYMpLBoZBCwwHrRzbsf3aUynh/RwcJxe0Qccp7Ed25Tniky9BeFXLAd1P6CFg1UN1+8Q8UjL7UBzAW36DdVhk/W+YXV5N6lBI1/t+YkS3oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKhJk4gkjzJ1gCAY+ePKV4+dw8c9Y8vpG4n+qq+LQ9U=;
 b=gPbITEE9d3E7w8N5tF5ZReWEuoNXbT/qLIi8X0RDNSGEjSwcThmIuLheJ4khy9Zg0hMM0Fg1ZGZKIpcpyzN4XzUztBbzGfje5DyRkeHVEm8w000bbwW9hJGzWdYXKEJmDJ0la0vGR577i+f69ka3YeVn6QjHVED1i9BZPQpfS3Q63HKH41o1b3fgWqhnW1HyKpmnq04kwa+MrPvIe+PK9hM2Yd/DXBoSQ6tHoGpqKiOMxyOaz0yvdWbhppk42fKni6VkpbJZCQ57h2xukKcODj60EwcCbmzAnJ4nihNtGyVMiGDfiZYNAwlQyo54HnRXvDKhEYOh/x0++iYTjfCxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKhJk4gkjzJ1gCAY+ePKV4+dw8c9Y8vpG4n+qq+LQ9U=;
 b=VLeZBT6yMitouOKeVreid1CEMuhuGg2VulkVTkHk3v9DDvYEDl5zO6Mc3CJRPjxLY8+2gjwTm+eWU2HRjH7GnMMy4zmDHMtNniW5kltMVXIKMsfL3+MekmllEXAiDva935KBX8H6/5Sj6D9I0XBdatTSuCjIV7pOxWu3y8BZrtMnqpSlUzBvjH9IUAcdVCIgWtdkGUShe+EslXfsU5AbxI8mNBSHJtjMeGhEKhmdho6xEQcUyklXP4XmkONCxyQkE38JKinLOcE5WB7ZgqzU41VUTW2Svn1DRB3PBjNV1p39cYDuc47YGPcHew2+uHIe8kX53TRWopzZ72E6RPeOmQ==
Received: from SA1PR02CA0022.namprd02.prod.outlook.com (2603:10b6:806:2cf::29)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 03:37:50 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::d7) by SA1PR02CA0022.outlook.office365.com
 (2603:10b6:806:2cf::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Tue, 5 Dec 2023 03:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:37:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:37:35 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:37:34 -0800
Message-ID: <2be046e1-ef95-4244-ae23-e56071ae1218@nvidia.com>
Date:   Mon, 4 Dec 2023 19:37:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Yin Fengwei" <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Yu Zhao" <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf56f57-061e-433a-696d-08dbf5438e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uz9jh2cqhzycJfDn+pruoHJFnn1XORtYGGtIW0W1Sb5t571BsVdDkfg/Cut1INaF69GSDl7FYOPnQ3MKc/xrrrTSxuMx15CLXFCK+8Jh7rJi7VeW2hmYIczkcKI8Dl2nFr7jTljQR3ccWTPYfNfMg0LvEaxj/V3te9SbJQlEGWYmGrIn5bRAuxOdORTY7rHMS3sWuDtaAk4mJCE/S124XmNUj3qrC/KPyxlYTsPVGtxFYvYF7YUf+VshqNmnLl9d6glFKOD1QzqshZtKBmoar65v7B/f/SEcZbvkcbLbeUYUc+Mc0060O5N/9zgtWbaDhjXitZg23SLuj5vrvwJBW5a0hFC+4y+JQTWqSDpc66dKpcD00hGdeDTT4mSfMDWcY0bvLl3GfxN4dXUuBSDvwj/jQ+jC4dQDH6+nZYx2bjqUiOp7HlUYnigJ5hcDGLaTxtVnRUvrU2DR5ySrme6Qy2CoJACpt6R+BnBImyxYoZlV67KAnG4I9fCo3WVP1JERkcVYmtKRX/pB2ehU5n8hXwJPE+RiubyFwOq83HRJNavZW6mngW+6F5wpAlQIJu/xZh8jB5exUepTdBH6EiPMVFXTQPwFSM48k6UgEmZdqb1dT2O5B06SbpDp+lIiEWnqLoTpKDHvyYVt06xeQJuJSI2LaRxTaCJ+B0XgpfOPLtqMerBHVqxVhehMNO58C1kwztfE15nlp4n2QPqQcfWVT9Ye3jpFCHdBDYuv2rAtSz92g1ZP//ejvWDc6PRHVGbpeYmfBi06Yf1G4g1R5D3ekqxTZw0K3X8PrjgST/dhmS0vLYqCh1DcVCLsEd+sbhah4f6AYOTSFNOOIMNPoFaoADPJKsfvASoKIwA3P8TSvgfzdfMzI3qovC/8oCTBiu6vZ9G3nOTJi2V7LppOXLC3vA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(40470700004)(36840700001)(46966006)(66899024)(921008)(36756003)(41300700001)(5660300002)(7416002)(30864003)(2906002)(86362001)(31696002)(40460700003)(5930299018)(47076005)(356005)(7636003)(2616005)(478600001)(4326008)(53546011)(426003)(336012)(82740400003)(83380400001)(966005)(26005)(16526019)(40480700001)(8676002)(8936002)(31686004)(36860700001)(16576012)(110136005)(54906003)(316002)(70206006)(6636002)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:37:49.8343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf56f57-061e-433a-696d-08dbf5438e29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 02:20, Ryan Roberts wrote:
> Hi All,
> 
> A new week, a new version, a new name... This is v8 of a series to implement
> multi-size THP (mTHP) for anonymous memory (previously called "small-sized THP"
> and "large anonymous folios"). Matthew objected to "small huge" so hopefully
> this fares better.
> 
> The objective of this is to improve performance by allocating larger chunks of
> memory during anonymous page faults:
> 
> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>     pages, there are efficiency savings to be had; fewer page faults, batched PTE
>     and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>     overhead. This should benefit all architectures.
> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>     advantage of HW TLB compression techniques. A reduction in TLB pressure
>     speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>     TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
> 
> This version changes the name and tidies up some of the kernel code and test
> code, based on feedback against v7 (see change log for details).

Using a couple of Armv8 systems, I've tested this patchset. I applied it
to top of tree (Linux 6.7-rc4), on top of your latest contig pte series
[1].

With those two patchsets applied, the mm selftests look OK--or at least
as OK as they normally do. I compared test runs between THP/mTHP set to
"always", vs "never", to verify that there were no new test failures.
Details: specifically, I set one particular page size (2 MB) to
"inherit", and then toggled /sys/kernel/mm/transparent_hugepage/enabled
between "always" and "never".

I also re-ran my usual compute/AI benchmark, and I'm still seeing the
same 10x performance improvement that I reported for the v6 patchset.

So for this patchset and for [1] as well, please feel free to add:

Tested-by: John Hubbard <jhubbard@nvidia.com>


[1] https://lore.kernel.org/all/20231204105440.61448-1-ryan.roberts@arm.com/


thanks,
-- 
John Hubbard
NVIDIA

> 
> By default, the existing behaviour (and performance) is maintained. The user
> must explicitly enable multi-size THP to see the performance benefit. This is
> done via a new sysfs interface (as recommended by David Hildenbrand - thanks to
> David for the suggestion)! This interface is inspired by the existing
> per-hugepage-size sysfs interface used by hugetlb, provides full backwards
> compatibility with the existing PMD-size THP interface, and provides a base for
> future extensibility. See [8] for detailed discussion of the interface.
> 
> This series is based on mm-unstable (715b67adf4c8).
> 
> 
> Prerequisites
> =============
> 
> Some work items identified as being prerequisites are listed on page 3 at [9].
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
> On NUMA balancing, which currently ignores any PTE-mapped THPs it encounters,
> John Hubbard has investigated this and concluded that it is A) not clear at the
> moment what a better policy might be for PTE-mapped THP and B) questions whether
> this should really be considered a prerequisite given no regression is caused
> for the default "multi-size THP disabled" case, and there is no correctness
> issue when it is enabled - its just a potential for non-optimal performance.
> 
> If there are no disagreements about removing numa balancing from the list (none
> were raised when I first posted this comment against v7), then that just leaves
> compaction which is in review on list at the moment.
> 
> I really would like to get this series (and its remaining comapction
> prerequisite) in for v6.8. I accept that it may be a bit optimistic at this
> point, but lets see where we get to with review?
> 
> 
> Testing
> =======
> 
> The series includes patches for mm selftests to enlighten the cow and khugepaged
> tests to explicitly test with multi-size THP, in the same way that PMD-sized
> THP is tested. The new tests all pass, and no regressions are observed in the mm
> selftest suite. I've also run my usual kernel compilation and java script
> benchmarks without any issues.
> 
> Refer to my performance numbers posted with v6 [6]. (These are for multi-size
> THP only - they do not include the arm64 contpte follow-on series).
> 
> John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
> some workloads at [11]. (Observed using v6 of this series as well as the arm64
> contpte series).
> 
> Kefeng Wang at Huawei has also indicated he sees improvements at [12] although
> there are some latency regressions also.
> 
> 
> Changes since v7 [7]
> ====================
> 
>    - Renamed "small-sized THP" -> "multi-size THP" in commit logs
>    - Added various Reviewed-by/Tested-by tags (Barry, David, Alistair)
>    - Patch 3:
>        - Fine-tuned transhuge documentation multi-size THP (JohnH)
>        - Converted hugepage_global_enabled() and hugepage_global_always() macros
>          to static inline functions (JohnH)
>        - Renamed hugepage_vma_check() to thp_vma_allowable_orders() (JohnH)
>        - Renamed transhuge_vma_suitable() to thp_vma_suitable_orders() (JohnH)
>        - Renamed "global" enabled sysfs file option to "inherit" (JohnH)
>    - Patch 9:
>        - cow selftest: Renamed param size -> thpsize (David)
>        - cow selftest: Changed test fail to assert() (David)
>        - cow selftest: Log PMD size separately from all the supported THP sizes
>          (David)
>    - Patch 10:
>        - cow selftest: No longer special case pmdsize; keep all THP sizes in
>          thpsizes[]
> 
> 
> Changes since v6 [6]
> ====================
> 
>    - Refactored vmf_pte_range_changed() to remove uffd special-case (suggested by
>      JohnH)
>    - Dropped accounting patch (#3 in v6) (suggested by DavidH)
>        - Continue to account *PMD-sized* THP only for now
>        - Can add more counters in future if needed
>        - Page cache large folios haven't needed any new counters yet
>    - Pivot to sysfs ABI proposed by DavidH
>        - per-size directories in a similar shape to that used by hugetlb
>    - Dropped "recommend" keyword patch (#6 in v6) (suggested by DavidH, Yu Zhou)
>        - For now, users need to understand implicitly which sizes are beneficial
>          to their HW/SW
>    - Dropped arch_wants_pte_order() patch (#7 in v6)
>        - No longer needed due to dropping patch "recommend" keyword patch
>    - Enlightened khugepaged mm selftest to explicitly test with small-size THP
>    - Scrubbed commit logs to use "small-sized THP" consistently (suggested by
>      DavidH)
> 
> 
> Changes since v5 [5]
> ====================
> 
>    - Added accounting for PTE-mapped THPs (patch 3)
>    - Added runtime control mechanism via sysfs as extension to THP (patch 4)
>    - Minor refactoring of alloc_anon_folio() to integrate with runtime controls
>    - Stripped out hardcoded policy for allocation order; its now all user space
>      controlled (although user space can request "recommend" which will configure
>      the HW-preferred order)
> 
> 
> Changes since v4 [4]
> ====================
> 
>    - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>      now uses the default order-3 size. I have moved this patch over to
>      the contpte series.
>    - Added "mm: Allow deferred splitting of arbitrary large anon folios" back
>      into series. I originally removed this at v2 to add to a separate series,
>      but that series has transformed significantly and it no longer fits, so
>      bringing it back here.
>    - Reintroduced dependency on set_ptes(); Originally dropped this at v2, but
>      set_ptes() is in mm-unstable now.
>    - Updated policy for when to allocate LAF; only fallback to order-0 if
>      MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rely on
>      sysfs's never/madvise/always knob.
>    - Fallback to order-0 whenever uffd is armed for the vma, not just when
>      uffd-wp is set on the pte.
>    - alloc_anon_folio() now returns `struct folio *`, where errors are encoded
>      with ERR_PTR().
> 
>    The last 3 changes were proposed by Yu Zhao - thanks!
> 
> 
> Changes since v3 [3]
> ====================
> 
>    - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>    - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded that a
>      sysctl is preferable but we will wait until real workload needs it.
>    - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>    - Added mm selftests for large anon folios in cow test suite.
> 
> 
> Changes since v2 [2]
> ====================
> 
>    - Dropped commit "Allow deferred splitting of arbitrary large anon folios"
>        - Huang, Ying suggested the "batch zap" work (which I dropped from this
>          series after v1) is a prerequisite for merging FLXEIBLE_THP, so I've
>          moved the deferred split patch to a separate series along with the batch
>          zap changes. I plan to submit this series early next week.
>    - Changed folio order fallback policy
>        - We no longer iterate from preferred to 0 looking for acceptable policy
>        - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0 only
>    - Removed vma parameter from arch_wants_pte_order()
>    - Added command line parameter `flexthp_unhinted_max`
>        - clamps preferred order when vma hasn't explicitly opted-in to THP
>    - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is disabled
>      for process or system).
>    - Simplified implementation and integration with do_anonymous_page()
>    - Removed dependency on set_ptes()
> 
> 
> Changes since v1 [1]
> ====================
> 
>    - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>    - replaced with arch-independent alloc_anon_folio()
>        - follows THP allocation approach
>    - no longer retry with intermediate orders if allocation fails
>        - fallback directly to order-0
>    - remove folio_add_new_anon_rmap_range() patch
>        - instead add its new functionality to folio_add_new_anon_rmap()
>    - remove batch-zap pte mappings optimization patch
>        - remove enabler folio_remove_rmap_range() patch too
>        - These offer real perf improvement so will submit separately
>    - simplify Kconfig
>        - single FLEXIBLE_THP option, which is independent of arch
>        - depends on TRANSPARENT_HUGEPAGE
>        - when enabled default to max anon folio size of 64K unless arch
>          explicitly overrides
>    - simplify changes to do_anonymous_page():
>        - no more retry loop
> 
> 
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@arm.com/
> [5] https://lore.kernel.org/linux-mm/20230810142942.3169679-1-ryan.roberts@arm.com/
> [6] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.roberts@arm.com/
> [7] https://lore.kernel.org/linux-mm/20231122162950.3854897-1-ryan.roberts@arm.com/
> [8] https://lore.kernel.org/linux-mm/6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com/
> [9] https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA
> [10] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
> [11] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/
> [12] https://lore.kernel.org/linux-mm/479b3e2b-456d-46c1-9677-38f6c95a0be8@huawei.com/
> 
> 
> Thanks,
> Ryan
> 
> Ryan Roberts (10):
>    mm: Allow deferred splitting of arbitrary anon large folios
>    mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>    mm: thp: Introduce multi-size THP sysfs interface
>    mm: thp: Support allocation of anonymous multi-size THP
>    selftests/mm/kugepaged: Restore thp settings at exit
>    selftests/mm: Factor out thp settings management
>    selftests/mm: Support multi-size THP interface in thp_settings
>    selftests/mm/khugepaged: Enlighten for multi-size THP
>    selftests/mm/cow: Generalize do_run_with_thp() helper
>    selftests/mm/cow: Add tests for anonymous multi-size THP
> 
>   Documentation/admin-guide/mm/transhuge.rst |  97 ++++-
>   Documentation/filesystems/proc.rst         |   6 +-
>   fs/proc/task_mmu.c                         |   3 +-
>   include/linux/huge_mm.h                    | 116 ++++--
>   mm/huge_memory.c                           | 268 ++++++++++++--
>   mm/khugepaged.c                            |  20 +-
>   mm/memory.c                                | 114 +++++-
>   mm/page_vma_mapped.c                       |   3 +-
>   mm/rmap.c                                  |  32 +-
>   tools/testing/selftests/mm/Makefile        |   4 +-
>   tools/testing/selftests/mm/cow.c           | 185 +++++++---
>   tools/testing/selftests/mm/khugepaged.c    | 410 ++++-----------------
>   tools/testing/selftests/mm/run_vmtests.sh  |   2 +
>   tools/testing/selftests/mm/thp_settings.c  | 349 ++++++++++++++++++
>   tools/testing/selftests/mm/thp_settings.h  |  80 ++++
>   15 files changed, 1177 insertions(+), 512 deletions(-)
>   create mode 100644 tools/testing/selftests/mm/thp_settings.c
>   create mode 100644 tools/testing/selftests/mm/thp_settings.h
> 
> --
> 2.25.1
> 


