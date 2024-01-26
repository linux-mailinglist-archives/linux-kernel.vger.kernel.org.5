Return-Path: <linux-kernel+bounces-39872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E183D6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830CF29752A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395A249FD;
	Fri, 26 Jan 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IE1xLR+g"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1058238
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259789; cv=none; b=j3prCK+EV11kP0LQ+zbUPDBMxZcc6EggOySEVcwl+xrVsxrcuQyWrBYnr69YLB0l9CHMGbxxn/2dh9IxXklLE2RxkmMPVs2qdGB+q7WaizFLaJJ7ctybkjutV8TKNX6+5BIH4BPZyuWsYcoJMp133rIlghpCjQZGiSwTAY6vLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259789; c=relaxed/simple;
	bh=YP+wDkDQWlkmmpMzR0P8FeyeFxB/XGbhpGgpVm4o6QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAiEbjwHM64d8++fHLAC2BnzEvh6Lb560tCdQK7/l9MnZMYDcvFnQFMj6raFFFX+lUqWwild/A35fP5C54FS5PxpyziVzGxBILx4JdkR/N2fNO0cgvkmkavDsQtFEeHkHdy+e0FAT2gPZUEPasr3g7puH0F3ivxr7kch+bBF6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IE1xLR+g; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706259776; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FbA0lyJxmLju9NRfsg/A+ypSW6Yan+DUwSG88cTa/8M=;
	b=IE1xLR+gAQHZsnr0yRxuipBVFz9NzmAnZM1MmfTtC+5Xmo6ZQeK+eNQ1SPcO0Ga3QJADxc4DgZPyErzisZoi9kMM7TdcaesTHoWctHibVX5TI1EZRYqia9zp+9gWr7VnEHw42k+7x8+sUo6Egl0R0jngm7vTmLLrIXXa71jxOa0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W.NB0N7_1706259772;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.NB0N7_1706259772)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 17:02:54 +0800
Message-ID: <f7d7eb0a-2bb3-4ae0-9874-7b667f8a004c@linux.alibaba.com>
Date: Fri, 26 Jan 2024 17:03:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Enable >0 order folio memory compaction
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240123034636.1095672-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/23/2024 11:46 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It is on top of
> mm-everything-2024-01-18-22-21.
> 
> I am aware of that split free pages is necessary for folio
> migration in compaction, since if >0 order free pages are never split
> and no order-0 free page is scanned, compaction will end prematurely due
> to migration returns -ENOMEM. Free page split becomes a must instead of
> an optimization.
> 
> Some applications from vm-scalability show different performance trends
> on default LRU and CONFIG_LRU_GEN from patch 1 (split folio during compaction),
> to patch 2 (folio migration during compaction), to patch 3 (folio
> migration during compaction with free page split). I am looking into it.
> 
> lkp ncompare results (with >5% delta) for default LRU and CONFIG_LRU_GEN are
> shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G VM).

Overall, I haven't found any obvious issues, thanks for your work. 
However I got some percentage regression when running thpcompact on my 
machine(16 cores and 120G memory) without enabling mTHP:
                                  k6.8-rc1               k6.8-rc1-patched
Percentage huge-1        86.19 (   0.00%)       51.17 ( -40.63%)
Percentage huge-3        93.64 (   0.00%)       42.48 ( -54.64%)
Percentage huge-5        94.93 (   0.00%)       31.06 ( -67.28%)
Percentage huge-7        95.40 (   0.00%)       19.09 ( -79.99%)
Percentage huge-12       93.51 (   0.00%)       32.06 ( -65.71%)
Percentage huge-18       83.02 (   0.00%)       54.58 ( -34.26%)
Percentage huge-24       83.17 (   0.00%)       49.61 ( -40.35%)
Percentage huge-30       96.69 (   0.00%)       59.82 ( -38.13%)
Percentage huge-32       95.52 (   0.00%)       59.20 ( -38.03%)

Ops Compaction stalls                 229710.00      554846.00
Ops Compaction success                144177.00        9351.00
Ops Compaction failures                85533.00      545495.00
Ops Compaction efficiency                 62.76           1.69
Ops Page migrate success            60333689.00    11687573.00
Ops Page migrate failure               25818.00      459621.00
Ops Compaction pages isolated      127723211.00   224420997.00
Ops Compaction migrate scanned     142498744.00   173345194.00
Ops Compaction free scanned       1159752360.00   624633726.00
Ops Compact scan efficiency               12.29          27.75
Ops Compaction cost                    66050.96       17615.55

I did not have time to analyze this issue, just providing you some test 
information. And I will measure the compaction efficiency of mTHP if I 
find some time.

>  From V1 [2]:
> 1. Used folio_test_large() instead of folio_order() > 0. (per Matthew
> Wilcox)
> 
> 2. Fixed code rebase error. (per Baolin Wang)
> 
> 3. Used list_split_init() instead of list_split(). (per Ryan Boberts)
> 
> 4. Added free_pages_prepare_fpi_none() to avoid duplicate free page code
> in compaction_free().
> 
> 5. Dropped source page order sorting patch.
> 
>  From RFC [1]:
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
> Feel free to give comments and ask questions.
> 
> Thanks.
> 
> [1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@sent.com/
> [2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
> 
> vm-scalability results on CONFIG_LRU_GEN
> ===
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/small-allocs/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     2024326           +35.5%    2743772 ± 41%    +364.0%    9392198 ± 35%     +31.0%    2651634        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/small-allocs-mt/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     1450189            +0.9%    1463418           +30.4%    1891610 ± 22%      +0.3%    1454100        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>    14428848 ± 27%     -51.7%    6963308 ± 73%     +13.5%   16372621           +11.2%   16046511        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>    13569502 ± 24%     -45.9%    7340064 ± 59%     +12.3%   15240531           +10.4%   14983705        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>    13305823 ± 24%     -45.1%    7299664 ± 56%     +12.5%   14974725           +10.4%   14695963        vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>    13244376 ± 28%     +54.2%   20425838 ± 23%      -4.4%   12660113 ±  3%      -9.0%   12045809 ±  3%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     7021425 ± 11%     -20.9%    5556751 ± 19%     +14.8%    8057811 ±  3%      +9.4%    7678613 ±  4%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability
> 
> commit:
>    6.7.0-rc4+
>    6.7.0-rc4-split-folio-in-compaction+
>    6.7.0-rc4-folio-migration-in-compaction+
>    6.7.0-rc4-folio-migration-free-page-split+
> 
>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     1208994 ±137%    +263.5%    4394683 ± 49%     -49.4%     611204 ±  6%     -48.1%     627937 ± 13%  vm-scalability.throughput
> 
> 
> 
> vm-scalability results on default LRU (with -no-mglru suffix)
> ===
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
> 
> commit:
>    6.7.0-rc4-no-mglru+
>    6.7.0-rc4-split-folio-in-compaction-no-mglru+
>    6.7.0-rc4-folio-migration-in-compaction-no-mglru+
>    6.7.0-rc4-folio-migration-free-page-split-no-mglru+
> 
> 6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     8412072 ±  3%     +32.1%   11114537 ± 41%      +3.5%    8703491 ±  3%      +1.5%    8536343 ±  3%  vm-scalability.throughput
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
> 
> commit:
>    6.7.0-rc4-no-mglru+
>    6.7.0-rc4-split-folio-in-compaction-no-mglru+
>    6.7.0-rc4-folio-migration-in-compaction-no-mglru+
>    6.7.0-rc4-folio-migration-free-page-split-no-mglru+
> 
> 6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>     7095358           +10.8%    7863635 ± 16%      +5.5%    7484110            +1.5%    7200666 ±  4%  vm-scalability.throughput
> 
> 
> Zi Yan (3):
>    mm/compaction: enable compacting >0 order folios.
>    mm/compaction: add support for >0 order folio memory compaction.
>    mm/compaction: optimize >0 order folio compaction with free page
>      split.
> 
>   mm/compaction.c | 218 ++++++++++++++++++++++++++++++++++--------------
>   mm/internal.h   |   9 +-
>   mm/page_alloc.c |   6 ++
>   3 files changed, 169 insertions(+), 64 deletions(-)
> 

