Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A77F32A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKUPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:46:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 587E897
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:46:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE7B51042;
        Tue, 21 Nov 2023 07:47:21 -0800 (PST)
Received: from [10.1.26.189] (XHFQ2J9959.cambridge.arm.com [10.1.26.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21533F7A6;
        Tue, 21 Nov 2023 07:46:32 -0800 (PST)
Message-ID: <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
Date:   Tue, 21 Nov 2023 15:46:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Enable >0 order folio memory compaction
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231113170157.280181-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 17:01, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It is on top of
> mm-everything-2023-10-21-02-40 (also applies to mm-everything-2023-11-10-20-42
> without conflicts).
> 
> Per patch vm-scalability results on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz)
> 16G VM are at the bottom and based on mm-everything-2023-10-21-02-40.
> Each has 5 runs. Highlights:
> 
> 1. mmap-pread-seq-mt: -18.3% if split folios during compaction and -7.7%
> if migrating folios during compaction.
> 
> 2. lru-file-readtwice: +41.5% if split folios during compaction and
> +30.4% if migrating folios during compaction.
> 
> 3. lru-file-mmap-read: +35.1% if split folios during compaction and
> +32.3% if migrating folios during compaction.
> 
> I will run experiments on bare metal and report results later.
> 
> 
> Changelog
> ===
> 
> From RFC:
> 1. Enabled >0 order folio compaction in the first patch by splitting all
> to-be-migrated folios. (per Huang, Ying)
> 
> 2. Stopped isolating compound pages with order greater than cc->order
> to avoid wasting effort, since cc->order gives a hint that no free pages
> with order greater than it exist, thus migrating the compound pages will fail.
> (per Baolin Wang)
> 
> 3. Retained the folio check within lru lock. (per Baolin Wang)
> 
> 4. Made isolate_freepages_block() generate order-sorted multi lists.
> (per Johannes Weiner)
> 
> 
> Overview
> ===
> 
> To support >0 order folio compaction, the patchset changes how free pages used
> for migration are kept during compaction. Free pages used to be split into
> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
> page order stored in page->private is zeroed, and page reference is set to 1).
> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
> on their order without post allocation process. When migrate_pages() asks for
> a new page, one of the free pages, based on the requested page order, is
> then processed and given out.
> 
> 
> Optimizations
> ===
> 
> 1. Free page split is added to increase migration success rate in case
> a source page does not have a matched free page in the free page lists.
> Free page merge is possible but not implemented, since existing
> PFN-based buddy page merge algorithm requires the identification of
> buddy pages, but free pages kept for memory compaction cannot have
> PageBuddy set to avoid confusing other PFN scanners.
> 
> 2. Sort source pages in ascending order before migration is added to
> reduce free page split. Otherwise, high order free pages might be
> prematurely split, causing undesired high order folio migration failures.
> 
> 
> TODOs
> ===
> 
> 1. Refactor free page post allocation and free page preparation code so
> that compaction_alloc() and compaction_free() can call functions instead
> of hard coding.
> 
> 2. Make isolate_migratepages_block() produce a sorted list for
> compaction to avoid sort_folio_by_order() in Patch 4.
> 
> 
> Feel free to give comments and ask questions.
> 
> Thanks.
> 
> vm-scalability results
> ===
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>   12896955            +2.7%   13249322            -4.0%   12385175 ±  5%      +1.1%   13033951            -0.4%   12845698        vm-scalability.throughput

Hi Zi,

Are you able to add any commentary to these results as I'm struggling to
interpret them; Is a positive or negative change better (are they times or
rates?). What are the stddev values? The title suggests percent but the values
are huge - I'm trying to understand what the error bars look like - are the
swings real or noise?

Thanks,
Ryan

> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>   14626665            -5.5%   13825048            -1.7%   14384837            -1.9%   14345958            -2.0%   14338834        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>   14314960           -18.3%   11691969 ±  2%      -7.7%   13217795            -8.8%   13057395           -10.8%   12764204        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    6498203 ±  6%     +41.5%    9193356           +30.4%    8472024           +30.0%    8449054 ±  3%     +32.3%    8596781 ±  2%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    5440732 ± 10%     +35.1%    7352631 ±  9%     +32.3%    7200622 ±  5%     +27.0%    6909673 ±  4%     +25.9%    6849852 ±  5%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read-rand/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    1627989            +0.3%    1632141            +1.8%    1656877            +0.1%    1629816            -0.2%    1625213        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/8T/qemu-vm/anon-wx-seq-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    6738043            +1.4%    6835096            +1.4%    6834329            +1.0%    6805401            +1.2%    6820637        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/8T/qemu-vm/anon-w-seq-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    7644894            +0.2%    7661425            +0.4%    7676929            +1.0%    7719218            +0.3%    7664658        vm-scalability.throughput
> 
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-wx-rand-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     521941            +3.3%     539254            +3.3%     539213            +1.0%     527048            +3.4%     539588        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-w-rand/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     481028            +4.3%     501876            +2.4%     492713            +0.4%     482829 ±  2%      +3.5%     497649 ±  2%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-w-rand-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     477063            +4.0%     496373            +4.0%     496283            +1.4%     483966            +3.2%     492216 ±  2%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     458073            +3.3%     473056            +2.6%     469835            +0.3%     459266            +3.0%     471735        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     468158            +0.8%     472115            +1.4%     474547            +1.1%     473307            +2.1%     478173        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/2T/qemu-vm/shm-xread-seq/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    3489946            +1.4%    3540036            +0.4%    3505413            +1.7%    3549852            +1.4%    3539309        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/2T/qemu-vm/shm-xread-seq-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    2621783            +1.0%    2647480            +0.6%    2636399            +0.7%    2641150            +0.1%    2624301        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/2T/qemu-vm/shm-pread-seq/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    3504293            +1.5%    3557664            -0.4%    3489639            +0.4%    3516842            +0.8%    3533944        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>     919378 ±  6%      +3.8%     954028 ± 10%      +7.2%     985920 ±  6%      +7.4%     987077 ±  5%     +14.2%    1049473 ±  2%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync-mt/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>    2398063            +2.0%    2446844            -1.5%    2361096 ±  2%      -3.1%    2324346 ±  4%      -1.0%    2375055 ±  4%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/128G/qemu-vm/truncate/vm-scalability
> 
> commit: 
>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>   6.6.0-rc4-split-folio-in-compaction+
>   6.6.0-rc4-folio-migration-in-compaction+
>   6.6.0-rc4-folio-migration-free-page-split+
>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
> 
> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f 
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \          |                \  
>  2.084e+08 ±  2%      +1.5%  2.114e+08 ±  3%      +6.5%   2.22e+08 ±  3%      -2.3%  2.035e+08 ±  2%      -2.1%   2.04e+08 ±  5%  vm-scalability.throughput
> 
> 
> 
> [1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
> 
> Zi Yan (4):
>   mm/compaction: enable compacting >0 order folios.
>   mm/compaction: add support for >0 order folio memory compaction.
>   mm/compaction: optimize >0 order folio compaction with free page
>     split.
>   mm/compaction: optimize >0 order folio compaction by sorting source
>     pages.
> 
>  mm/compaction.c | 280 ++++++++++++++++++++++++++++++++++++------------
>  mm/internal.h   |   7 +-
>  2 files changed, 217 insertions(+), 70 deletions(-)
> 

