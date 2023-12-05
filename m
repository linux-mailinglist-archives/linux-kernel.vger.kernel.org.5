Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2B805706
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbjLEOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbjLEOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:19:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327F90
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:19:10 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sl2bq13l6zFrC6;
        Tue,  5 Dec 2023 22:14:47 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 22:19:07 +0800
Message-ID: <b8f5a47a-af1e-44ed-a89b-460d0be56d2c@huawei.com>
Date:   Tue, 5 Dec 2023 22:19:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/4 18:20, Ryan Roberts wrote:
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

Hi Ryan,

Here is some test results based on v6.7-rc1 +
[PATCH v7 00/10] Small-sized THP for anonymous memory +
[PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings

case1: basepage 64K
case2: basepage 4K + thp=64k + PAGE_ALLOC_COSTLY_ORDER = 3
case3: basepage 4K + thp=64k + PAGE_ALLOC_COSTLY_ORDER = 4

The results is compared with basepage 4K on Kunpeng920.

Note,
- The test based on ext4 filesystem and THP=2M is disabled.
- The results were not analyzed, it is for reference only,
   as some values of test items are not consistent.

1) Unixbench 1core
Index_Values_1core                       case1       case2    case3
Dhrystone_2_using_register_variables     0.28%      0.39%     0.17%
Double-Precision_Whetstone              -0.01%      0.00%     0.00%
Execl_Throughput                        *21.13%*    2.16%     3.01%
File_Copy_1024_bufsize_2000_maxblocks   -0.51%     *8.33%*   *8.76%*
File_Copy_256_bufsize_500_maxblocks      0.78%     *11.89%*  *10.85%*
File_Copy_4096_bufsize_8000_maxblocks    7.42%      7.27%    *10.66%*
Pipe_Throughput                         -0.24%     *6.82%*   *5.08%*
Pipe-based_Context_Switching             1.38%     *13.49%*  *9.91%*
Process_Creation                        *32.46%*    4.30%    *8.54%*
Shell_Scripts_(1_concurrent)            *31.67%*    1.92%     2.60%
Shell_Scripts_(8_concurrent)            *40.59%*    1.30%    *5.29%*
System_Call_Overhead                     3.92%     *8.13%     2.96%

System_Benchmarks_Index_Score           10.66%      5.39%     5.58%

For 1core,
- case1 wins on Execl_Throughput/Process_Creation/Shell_Scripts
   a lot, and score higher 10.66% vs basepage 4K.
- case2/3 wins on File_Copy/Pipe and score higher 5%+ than basepage 4K,
   also case3 looks better on Shell_Scripts_(8_concurrent) than case2.

2) Unixbench 128core
Index_Values_128core                    case1     case2     case3
Dhrystone_2_using_register_variables    2.07%    -0.03%    -0.11%
Double-Precision_Whetstone             -0.03%     0.00%    0.00%
Execl_Throughput                       *39.28%*  -4.23%    1.93%
File_Copy_1024_bufsize_2000_maxblocks   5.46%     1.30%    4.20%
File_Copy_256_bufsize_500_maxblocks    -8.89%    *6.56%   *5.02%*
File_Copy_4096_bufsize_8000_maxblocks   3.43%   *-5.46%*   0.56%
Pipe_Throughput                         3.80%    *7.69%   *7.80%*
Pipe-based_Context_Switching           *7.62%*    0.95%    4.69%
Process_Creation                       *28.11%*  -2.79%    2.40%
Shell_Scripts_(1_concurrent)           *39.68%*   1.86%   *5.30%*
Shell_Scripts_(8_concurrent)           *41.35%*   2.49%   *7.16%*
System_Call_Overhead                   -1.55%    -0.04%   *8.23%*

System_Benchmarks_Index_Score          12.08%     0.63%    3.88%

For 128core,
- case1 wins on Execl_Throughput/Process_Creation/Shell_Scripts
   a lot, also good at Pipe-based_Context_Switching, and score higher
   12.08% vs basepage 4K.
- case2/case3 wins on File_Copy_256/Pipe_Throughput, but case2 is
   not better than basepage 4K, case3 wins 3.88%.

3) Lmbench Processor_processes
Processor_Processes    case1      case2      case3
null_call              1.76%      0.40%     0.65%
null_io               -0.76%     -0.38%    -0.23%
stat                 *-16.09%*  *-12.49%*   4.22%
open_close            -2.69%      4.51%     3.21%
slct_TCP              -0.56%      0.00%    -0.44%
sig_inst              -1.54%      0.73%     0.70%
sig_hndl              -2.85%      0.01%     1.85%
fork_proc            *23.31%*     8.77%    -5.42%
exec_proc            *13.22%*    -0.30%     1.09%
sh_proc              *14.04%*    -0.10%     1.09%

- case1 is much better than basepage 4K, same as Unixbench test,
   case2 is better on fork_proc, but case3 is worse
- note: the variance of fork/exec/sh is bigger than others

4) Lmbench Context_switching_ctxsw
Context_switching_ctxsw  case1     case2         case3
2p/0K                   -12.16%    -5.29%       -1.86%
2p/16K                  -11.26%    -3.71%       -4.53%
2p/64K                  -2.60%      3.84%       -1.98%
8p/16K                  -7.56%     -1.21%       -0.88%
8p/64K                   5.10%      4.88%        1.19%
16p/16K                 -5.81%     -2.44%       -3.84%
16p/64K                  4.29%     -1.94%       -2.50%
- case1/2/3 worse than basepage 4K and case1 is the worst.

4) Lmbench Local_latencies
Local_latencies      case1      case2     case3
Pipe                -9.23%      0.58%    -4.34%
AF_UNIX             -5.34%     -1.76%     3.03%
UDP                 -6.70%     -5.96%    -9.81%
TCP                 -7.95%     -7.58%    -5.63%
TCP_conn            -213.99%   -227.78%  -659.67%
- TCP_conn is very unreliable, ignore it
- case1/2/3 slower than basepage 4K

5) Lmbench File_&_VM_latencies
File_&_VM_latencies    case1     case2        case3
10K_File_Create        2.60%    -0.52%         2.66%
10K_File_Delete       -2.91%    -5.20%        -2.11%
10K_File_Create       10.23%     1.18%         0.12%
10K_File_Delete      -17.76%    -2.97%        -1.49%
Mmap_Latency         *63.05%*    2.57%        -0.96%
Prot_Fault            10.41%    -3.21%       *-19.11%*
Page_Fault          *-132.01%*   2.35%        -0.79%
100fd_selct          -1.20%      0.10%         0.31%
- case1 is very good at Mmap_Latency and not good at Page_fault
- case2/3 slower on Prot_Faul/10K_FILE_Delete vs basepage 4k,
   the rest doesn't look much different.

6) Lmbench Local_bandwidths
Local_bandwidths    case1   case2       case3
Pipe               265.22%   15.44%     11.33%
AF_UNIX            13.41%   -2.66%      2.63%
TCP               -1.30%     25.90%     2.48%
File_reread        14.79%    31.52%    -14.16%
Mmap_reread        27.47%    49.00%    -0.11%
Bcopy(libc)        2.58%     2.45%      2.46%
Bcopy(hand)        25.78%    22.56%     22.68%
Mem_read           38.26%    36.80%     36.49%
Mem_write          10.93%    3.44%      3.12%

- case1 is very good at bandwidth, case2 is better than basepage 4k
   but lower than case1, case3 is bad at File_reread

7)Lmbench Memory_latencies
Memory_latencies    case1     case2     case3
L1_$                0.02%     0.00%    -0.03%
L2_$               -1.56%    -2.65%    -1.25%
Main_mem           50.82%     32.51%    33.47%
Rand_mem           15.29%    -8.79%    -8.80%

- case1 also good at Main/Rand mem access latencies,
- case2/case3 is better at Main_mem, but worse at Rand_mem.

Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>







