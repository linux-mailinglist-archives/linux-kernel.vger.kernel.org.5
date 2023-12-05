Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAB8047B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjLEDlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjLEDlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:41:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D13D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBTP3qDfYVF4UQNOt5gj+qH+xs4F5n1YQqWkL2CSP5xQlYRpW25NYBcxpWYVFFgd5jaIG5nYyextbiR2uJt1NQgC/1AKbTkv/woQ3aBJ0sFq6aVokZ2tQohjIkNIBiIV5ab6Fqb0OxMf1iD4Nh9mBv2+QzcvhunSvCUYKog9mrEpmKLi0FgtHV/A7bXr/7ztqRJK19BhvggWHBrdJXa+gx65DloUgaj65Gdw13HH/Ud+bw4+tGOKv+R3S/Bj3QhOL2hqtdGozEBKf8RKk80I/hpCEK9DDVAzYTQMNML6ARCfA+JFSbIb3AOAAAUBKaawOoG85iDkiOCIrrMoU6Dpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7yBpcR6pEF+m0AkAQxE2NmGu2nZvLpOwelh1BjqXIs=;
 b=S3zG86PRIasSu6QU1mV+Nf2dFZnB/uRzfGfsHQId+7RMLjccC3j4MyI/DWQWp6BEzzC3vGmiCYZlZl0TjKBr2odG8HFsI8g6jaAzjqxW1JVSxbtnQrQGN8PJbRpSMR4u+83CaYL+UMBpPOXPxTCoOjxgxWMzWMAGIVrWaBHaJhPCTBtIoWMNJyT8fJbZjRd5379ZM3A3xtTvqZYg6/YU7U+D1Ma5FHAqUxpuWboVJMfn+PiBtlfx11gxdHgxAc3LH5bXs6JpR9LcV5NGYtHR0vcObnZR+c4J+0ZkB07B4BZjZy61xYyncu/Pn96GLGfGptIM+RF1rNPqVKxz80M3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7yBpcR6pEF+m0AkAQxE2NmGu2nZvLpOwelh1BjqXIs=;
 b=EVuwuDIEfJQBZJluvppB1jcMcZYHRr8SteM6veMp4vwlXu9d5xxDFCl3EQEYDerZeDt5oEHznXWi+C+SDoWIRiakObZnVjyQ/FUX4YNs/grm0YXs9qm20lQ+XnPq5pxKBbOlHYiNSiO19839eF/bXaHwLEmm3ednxhY2FvnIV4kTtkYBuwPCAZ5AX3rogsJ74yq0SdeYWJEMxT5txEB1uPgSsq2GYsegT8RCEPutW9cn2eOgtJ0eUNZpMXXgnYY05RRq+Orf5qxNFYHKJA8cz+msn3YrL2Xsvs1xCa7tg53gsxHqf0dts3XVeDZGR7haUOsrUeOTdcUjsj8LdxljUg==
Received: from SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 03:41:23 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::55) by SN7P220CA0022.outlook.office365.com
 (2603:10b6:806:123::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Tue, 5 Dec 2023 03:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:41:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:41:03 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:41:02 -0800
Message-ID: <ea345a14-0a39-425c-a2df-d163ca948f57@nvidia.com>
Date:   Mon, 4 Dec 2023 19:41:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Transparent Contiguous PTEs for User Mappings
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231204105440.61448-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a892c17-57a7-45eb-6d50-08dbf5440c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7LmvvRd2W0dJxizg5chxyEZYkXQcMmUgMdzf+COVYfpg328BM2+ADmMn5Wc5ZvEAuqKsDo9LpgLKpZYqBG0FR5g5REahsdIYSQklbjFqM9H0M5IyhPNw7y3iOU2he243fPb9oNMH+YBP13aTHzYqgwcYjcl20Kd+mdvzZvrLngI+znSGROY9OrAzi0TQbCZJA/3UXnm99na/v/mvpcY93crKk+IMgPpGX7oaE9NFebNk152kqHxdlCtFunoD9HFecp1N1afoJuWQ6s356PiAJDcLT/2JJJcJbGmQgERkxvKWEjZj2CxGPQbJ9yRk3bALJhgHylRCH4ro+uXZDrvhJ/HbU8hEdn8Cknp+VmS0g+jcPfSNhobWvpBNo2gjux3hN6N3aBidnWomBzfu1k8rWEtTGpdUL9BH1LTV5+hzXW2BQ/QsF4fZzry+cUgu8poAc+HgOLRdKXCRdTsTNRr+6VkQ9mIOhLtjKzQ/ln+B6ZhBEzgBiiYQzCVuCQlcFt6/PjfjE+rXNzXdvggGrlZM/EW6mWuheH5QfaTSY7Ov1ggSNgIBqQZ5sk9ch8QHtjJ4InM0tuRA1e40vc+EQuVUrmatFVJCsrc4eIETUlh1+bSnsdHtW6LhFzob9xAh4TBkhzIUbMxt5Xh+v/dK3V9W1Cn2H23MV8pld0BiRg+lq3PzxwzL8Bgq7ggh5X82Wg17GHRHVtykRR2CWDd1AMUkyHNaGkmzjX5aJrL1z93bXPguPOZ6CHK0brg+ZBRXRwyJgrNwBcZyNW31VSQgFtkcnqlwaWlmhQhxJnyhImL5O7FXGf3gPwTamXjlRpqfY7doRBRAbprKCzjJLj4VEfbr+5CleRX61YVy0qVrlnaYpbeXCUrUzGxE+88kWPm7fyb
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002)(16576012)(316002)(110136005)(40460700003)(478600001)(966005)(7416002)(5660300002)(921008)(36756003)(41300700001)(2906002)(31696002)(86362001)(40480700001)(83380400001)(356005)(82740400003)(47076005)(426003)(66574015)(16526019)(2616005)(336012)(26005)(7636003)(36860700001)(31686004)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:41:21.0963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a892c17-57a7-45eb-6d50-08dbf5440c15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 02:54, Ryan Roberts wrote:
> Hi All,
> 
> This is v3 of a series to opportunistically and transparently use contpte
> mappings (set the contiguous bit in ptes) for user memory when those mappings
> meet the requirements. It is part of a wider effort to improve performance by
> allocating and mapping variable-sized blocks of memory (folios). One aim is for
> the 4K kernel to approach the performance of the 16K kernel, but without
> breaking compatibility and without the associated increase in memory. Another
> aim is to benefit the 16K and 64K kernels by enabling 2M THP, since this is the
> contpte size for those kernels. We have good performance data that demonstrates
> both aims are being met (see below).
> 
> Of course this is only one half of the change. We require the mapped physical
> memory to be the correct size and alignment for this to actually be useful (i.e.
> 64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solving this
> problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs, ...) will
> allocate large folios up to the PMD size today, and more filesystems are coming.
> And the other half of my work, to enable "multi-size THP" (large folios) for
> anonymous memory, makes contpte sized folios prevalent for anonymous memory too
> [3].
> 

Hi Ryan,

Using a couple of Armv8 systems, I've tested this patchset. Details are in my
reply to the mTHP patchset [1].

So for this patchset, please feel free to add:

Tested-by: John Hubbard <jhubbard@nvidia.com>


[1] https://lore.kernel.org/all/2be046e1-ef95-4244-ae23-e56071ae1218@nvidia.com/


thanks,
-- 
John Hubbard
NVIDIA

> Optimistically, I would really like to get this series merged for v6.8; there is
> a chance that the multi-size THP series will also get merged for that version
> (although at this point pretty small). But even if it doesn't, this series still
> benefits file-backed memory from the file systems that support large folios so
> shouldn't be held up for it. Additionally I've got data that shows this series
> adds no regression when the system has no appropriate large folios.
> 
> All dependecies listed against v1 are now resolved; This series applies cleanly
> against v6.7-rc1.
> 
> Note that the first two patchs are for core-mm and provides the refactoring to
> make some crucial optimizations possible - which are then implemented in patches
> 14 and 15. The remaining patches are arm64-specific.
> 
> Testing
> =======
> 
> I've tested this series together with multi-size THP [3] on both Ampere Altra
> (bare metal) and Apple M2 (VM):
>    - mm selftests (inc new tests written for multi-size THP); no regressions
>    - Speedometer Java script benchmark in Chromium web browser; no issues
>    - Kernel compilation; no issues
>    - Various tests under high memory pressure with swap enabled; no issues
> 
> 
> Performance
> ===========
> 
> John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
> some workloads at [4], when using 64K base page kernel.
> 
> You can also see the original performance results I posted against v1 [1] which
> are still valid.
> 
> I've additionally run the kernel compilation and speedometer benchmarks on a
> system with multi-size THP disabled and large folio support for file-backed
> memory intentionally disabled; I see no change in performance in this case (i.e.
> no regression when this change is "present but not useful").
> 
> 
> Changes since v2 [2]
> ====================
> 
>    - Removed contpte_ptep_get_and_clear_full() optimisation for exit() (v2#14),
>      and replaced with a batch-clearing approach using a new arch helper,
>      clear_ptes() (v3#2 and v3#15) (Alistair and Barry)
>    - (v2#1 / v3#1)
>        - Fixed folio refcounting so that refcount >= mapcount always (DavidH)
>        - Reworked batch demarcation to avoid pte_pgprot() (DavidH)
>        - Reverted return semantic of copy_present_page() and instead fix it up in
>          copy_present_ptes() (Alistair)
>        - Removed page_cont_mapped_vaddr() and replaced with simpler logic
>          (Alistair)
>        - Made batch accounting clearer in copy_pte_range() (Alistair)
>    - (v2#12 / v3#13)
>        - Renamed contpte_fold() -> contpte_convert() and hoisted setting/
>          clearing CONT_PTE bit to higher level (Alistair)
> 
> 
> Changes since v1 [1]
> ====================
> 
>    - Export contpte_* symbols so that modules can continue to call inline
>      functions (e.g. ptep_get) which may now call the contpte_* functions (thanks
>      to JohnH)
>    - Use pte_valid() instead of pte_present() where sensible (thanks to Catalin)
>    - Factor out (pte_valid() && pte_cont()) into new pte_valid_cont() helper
>      (thanks to Catalin)
>    - Fixed bug in contpte_ptep_set_access_flags() where TLBIs were missed (thanks
>      to Catalin)
>    - Added ARM64_CONTPTE expert Kconfig (enabled by default) (thanks to Anshuman)
>    - Simplified contpte_ptep_get_and_clear_full()
>    - Improved various code comments
> 
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230622144210.2623299-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20231115163018.1303287-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-arm-kernel/20231204102027.57185-1-ryan.roberts@arm.com/
> [4] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/
> 
> 
> Thanks,
> Ryan
> 
> Ryan Roberts (15):
>    mm: Batch-copy PTE ranges during fork()
>    mm: Batch-clear PTE ranges during zap_pte_range()
>    arm64/mm: set_pte(): New layer to manage contig bit
>    arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
>    arm64/mm: pte_clear(): New layer to manage contig bit
>    arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
>    arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
>    arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
>    arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
>    arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
>    arm64/mm: ptep_get(): New layer to manage contig bit
>    arm64/mm: Split __flush_tlb_range() to elide trailing DSB
>    arm64/mm: Wire up PTE_CONT for user mappings
>    arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
>    arm64/mm: Implement clear_ptes() to optimize exit()
> 
>   arch/arm64/Kconfig                |  10 +-
>   arch/arm64/include/asm/pgtable.h  | 343 ++++++++++++++++++++---
>   arch/arm64/include/asm/tlbflush.h |  13 +-
>   arch/arm64/kernel/efi.c           |   4 +-
>   arch/arm64/kernel/mte.c           |   2 +-
>   arch/arm64/kvm/guest.c            |   2 +-
>   arch/arm64/mm/Makefile            |   1 +
>   arch/arm64/mm/contpte.c           | 436 ++++++++++++++++++++++++++++++
>   arch/arm64/mm/fault.c             |  12 +-
>   arch/arm64/mm/fixmap.c            |   4 +-
>   arch/arm64/mm/hugetlbpage.c       |  40 +--
>   arch/arm64/mm/kasan_init.c        |   6 +-
>   arch/arm64/mm/mmu.c               |  16 +-
>   arch/arm64/mm/pageattr.c          |   6 +-
>   arch/arm64/mm/trans_pgd.c         |   6 +-
>   include/asm-generic/tlb.h         |   9 +
>   include/linux/pgtable.h           |  39 +++
>   mm/memory.c                       | 258 +++++++++++++-----
>   mm/mmu_gather.c                   |  14 +
>   19 files changed, 1067 insertions(+), 154 deletions(-)
>   create mode 100644 arch/arm64/mm/contpte.c
> 
> --
> 2.25.1
> 


