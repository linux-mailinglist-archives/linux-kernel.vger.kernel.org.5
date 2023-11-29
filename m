Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E67FCD93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376814AbjK2Dmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjK2Dmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:42:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDF10FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNdg9E15UB6RlvrgBCgOdYxYjE/RrAlKXpMUo+MdQ8jiHnoPy0htO9mCmPYSOYIUWg75AEKc5UA57ePfzkxwqeAVbVpGaZHFlry3kkJ1DDFH8dK3GODCvI7XXJpQIsE3RsKS6iIoXa41HPpXwgK+OT9/sT9QyPP8IUYpw/fkN/a4m1ZnKH9CyQCcjPSVch72COXVVbZn+uKl+cm9zTOlWs5qLl7QU3/fjdlTk5+hn/hQpAujPqT8hVP/0YLeexa7e+jxEi85fROSYioKF3Ynv0rmU5ZuLXwy1lOdnk0XmZ7kFSIvF4rXBWIxa1df3NAUg0G5zESHiZ3EKZ7LbNMtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIRkHg6UK5ly0iz7/RQZxic5/TyiMYV48zAtEkcUn+k=;
 b=Vbqrp2eLc5g/1d2zfkcITdIm+ljFVusXuJWeiLM0YYtFrKmlckfbXl/JYHgZI/DkNOMN9ZarmQdkrNZDFHb6nHKgS+b/iYnc3M42xkHxkqIO6s6kRKEcWCRQZjWLTjSuuwu93GWGfeoLBhoV52S06KPbTyCcKlcuJJa8pAKG1ds7sRjmS5scsXqrGSfONCqJpxkZs3bPC2MQYndOLODEbOM5rAHNbFekPFfwhY2FGtYI2qsyd8gijIyuAr91Es+srdLRvjTCdDS7EP6ASgn+klwCqciHnJmCbmJq7Fg0h36IvPJrds7vTA2X8FH5xnVZSX7tf8Gql1XrJI1Gt/yyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIRkHg6UK5ly0iz7/RQZxic5/TyiMYV48zAtEkcUn+k=;
 b=MGQKEqPgh4/oLKEazJVZGwujtYZurpuqVQ+MsSZtN+yIDiaMFeavKuaxym2UOI5RL+2KTYH855qfJgoalSVAqLsxAVclqwTwi17HSI9L9SaxwV7FQwuHfqa5WOBBTBFMVK5h0vZVE1mdMY2t4a0LVm92RDDbPphllZHM8G5nZ3nT52ZDlU8MB31y2unz0rRBhI0YebXNcsPe+7pqFowoybcFsxke/wmVQZcN5xFoWnYvwk36sionkfZ7SORcGAV7KN/lCx12i8EzOkJabu9uEWaaBlmybBHe3QBDokYKAbUYducznw67ybGyPxsZiX1DIZpZ3H18w0lVe1vAI3sX1w==
Received: from CH0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:610:e6::19)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 03:42:53 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:610:e6:cafe::43) by CH0PR03CA0284.outlook.office365.com
 (2603:10b6:610:e6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 03:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 03:42:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 19:42:38 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 19:42:37 -0800
Message-ID: <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
Date:   Tue, 28 Nov 2023 19:42:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs
 interface
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-4-ryan.roberts@arm.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231122162950.3854897-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae2cffb-7e05-41f1-20d8-08dbf08d444b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: La6Te8n8fFdfvDhs8PImJNT0odpF9J8VWbF+ShMJ6ZRmen/mFPHd/OlKK8y5bClY415pCHKFRVEI8jE8JgFIXbENTXWN8WGm2af/cu+JTqO0eC/XKIxKa9O8HZ5P4rDnr1XLckYmEqOryJ3JkipSsXfj0uUuceDsIBHdvacgeWOhnTsFFptP61/GgXs8Jcp7P2l0x7k7526uE9CQtUbGLYCYZDu/T/duvqOC/U0t2EdMzGnrkStJbkDnMdT70wn45TIAkrOpJ9ZhJ6pt0GsBVKxb1n1WjmuyzU7xi3E9rGY+9OnKE1w3bLOqZ3lRvaGRzEUgnX+bDzjYKccJafgA1s4tlGtoIa8xTQ+zL0ko9YdRu5+johR2aueEy3PyEixsUcZ7GKKnTCBG4OcojbsTyPISHUJxuaZ8/MY7NDGvHDoBunO6E+WPCIaGa3dFlm/sYicLYiiW03D3NKfTKVXH9eN0h981ih3rJ+UJP7UDFC2vvp2VNtiyhhg2p7KNYVl3t7IdGm7gLDVOLS2bjWM+d4ouWQ1PAnM8Bq7ResdUjfwm4uC36olIJXSQJgHukry/HUSK6gVGWCj78GVdmXEcQOBn7ZWZIJ14q7i0mlW9S9s8znzJjYzeiD7AD9EMrVU9NHO1WXbyugq5h39NEapf2bYnAhoF9kXsAMJLLZ9H83yDXKKrfjR9VwMFx6GOpnca0Yc/pqYuyrjBKQbvot2FSmUBK/22i2r6AfANu/eFBQyhNuSMOqdy1aA076YhcTT45UJwFK1CsDtXqfCM95q+0YogiVzvuiPKMXopRhhKFErqZoEfEcxEkMvdgVzVqzpM
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(86362001)(31696002)(47076005)(2906002)(5660300002)(356005)(31686004)(40480700001)(8676002)(4326008)(7416002)(36860700001)(41300700001)(8936002)(336012)(83380400001)(30864003)(426003)(54906003)(16526019)(110136005)(316002)(16576012)(40460700003)(36756003)(2616005)(921008)(82740400003)(478600001)(53546011)(7636003)(70586007)(70206006)(26005)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 03:42:52.8323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae2cffb-7e05-41f1-20d8-08dbf08d444b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 08:29, Ryan Roberts wrote:
> In preparation for adding support for anonymous small-sized THP,
> introduce new sysfs structure that will be used to control the new
> behaviours. A new directory is added under transparent_hugepage for each
> supported THP size, and contains an `enabled` file, which can be set to
> "global" (to inherrit the global setting), "always", "madvise" or
> "never". For now, the kernel still only supports PMD-sized anonymous
> THP, so only 1 directory is populated.
> 
> The first half of the change converts transhuge_vma_suitable() and
> hugepage_vma_check() so that they take a bitfield of orders for which
> the user wants to determine support, and the functions filter out all
> the orders that can't be supported, given the current sysfs
> configuration and the VMA dimensions. If there is only 1 order set in
> the input then the output can continue to be treated like a boolean;
> this is the case for most call sites.
> 
> The second half of the change implements the new sysfs interface. It has
> been done so that each supported THP size has a `struct thpsize`, which
> describes the relevant metadata and is itself a kobject. This is pretty
> minimal for now, but should make it easy to add new per-thpsize files to
> the interface if needed in future (e.g. per-size defrag). Rather than
> keep the `enabled` state directly in the struct thpsize, I've elected to
> directly encode it into huge_anon_orders_[always|madvise|global]
> bitfields since this reduces the amount of work required in
> transhuge_vma_suitable() which is called for every page fault.
> 
> The remainder is copied from Documentation/admin-guide/mm/transhuge.rst,
> as modified by this commit. See that file for further details.
> 
> Transparent Hugepage Support for anonymous memory can be entirely
> disabled (mostly for debugging purposes) or only enabled inside
> MADV_HUGEPAGE regions (to avoid the risk of consuming more memory
> resources) or enabled system wide. This can be achieved
> per-supported-THP-size with one of::
> 
> 	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 
> where <size> is the hugepage size being addressed, the available sizes
> for which vary by system. Alternatively it is possible to specify that
> a given hugepage size will inherrit the global enabled setting::
> 
> 	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 
> The global (legacy) enabled setting can be set as follows::
> 
> 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
> 
> By default, PMD-sized hugepages have enabled="global" and all other
> hugepage sizes have enabled="never". If enabling multiple hugepage
> sizes, the kernel will select the most appropriate enabled size for a
> given allocation.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  74 ++++--
>   Documentation/filesystems/proc.rst         |   6 +-
>   fs/proc/task_mmu.c                         |   3 +-
>   include/linux/huge_mm.h                    | 100 +++++---
>   mm/huge_memory.c                           | 263 +++++++++++++++++++--
>   mm/khugepaged.c                            |  16 +-
>   mm/memory.c                                |   6 +-
>   mm/page_vma_mapped.c                       |   3 +-
>   8 files changed, 387 insertions(+), 84 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index b0cc8243e093..52565e0bd074 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -45,10 +45,23 @@ components:
>      the two is using hugepages just because of the fact the TLB miss is
>      going to run faster.
> 
> +As well as PMD-sized THP described above, it is also possible to
> +configure the system to allocate "small-sized THP" to back anonymous

Here's one of the places to change to the new name, which lately is
"multi-size THP", or mTHP or m_thp for short. (I've typed "multi-size"
instead of "multi-sized", because the 'd' doesn't add significantly to
the meaning, and if in doubt, shorter is better.


> +memory (for example 16K, 32K, 64K, etc). These THPs continue to be
> +PTE-mapped, but in many cases can still provide similar benefits to
> +those outlined above: Page faults are significantly reduced (by a
> +factor of e.g. 4, 8, 16, etc), but latency spikes are much less
> +prominent because the size of each page isn't as huge as the PMD-sized
> +variant and there is less memory to clear in each page fault. Some
> +architectures also employ TLB compression mechanisms to squeeze more
> +entries in when a set of PTEs are virtually and physically contiguous
> +and approporiately aligned. In this case, TLB misses will occur less
> +often.
> +

OK, all of the above still seems like it can remain the same.

>   THP can be enabled system wide or restricted to certain tasks or even
>   memory ranges inside task's address space. Unless THP is completely
>   disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into huge pages.
> +collapses sequences of basic pages into PMD-sized huge pages.
> 
>   The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>   interface and using madvise(2) and prctl(2) system calls.
> @@ -95,12 +108,29 @@ Global THP controls
>   Transparent Hugepage Support for anonymous memory can be entirely disabled
>   (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
>   regions (to avoid the risk of consuming more memory resources) or enabled
> -system wide. This can be achieved with one of::
> +system wide. This can be achieved per-supported-THP-size with one of::
> +
> +	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +
> +where <size> is the hugepage size being addressed, the available sizes
> +for which vary by system. Alternatively it is possible to specify that
> +a given hugepage size will inherrit the global enabled setting::

typo: inherrit

> +
> +	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +
> +The global (legacy) enabled setting can be set as follows::
> 
>   	echo always >/sys/kernel/mm/transparent_hugepage/enabled
>   	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>   	echo never >/sys/kernel/mm/transparent_hugepage/enabled
> 
> +By default, PMD-sized hugepages have enabled="global" and all other
> +hugepage sizes have enabled="never". If enabling multiple hugepage
> +sizes, the kernel will select the most appropriate enabled size for a
> +given allocation.
> +

This is slightly murky. I wonder if "inherited" is a little more directly
informative than global; it certainly felt that way my first time running
this and poking at it.

And a few trivial examples would be a nice touch.

And so overall with a few other minor tweaks, I'd suggest this:

...
where <size> is the hugepage size being addressed, the available sizes
for which vary by system.

For example:
	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

Alternatively it is possible to specify that a given hugepage size will inherit
the top-level "enabled" value:

	echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled

For example:
	echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

The top-level setting (for use with "inherited") can be by issuing one of the
following commands::

	echo always >/sys/kernel/mm/transparent_hugepage/enabled
	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
	echo never >/sys/kernel/mm/transparent_hugepage/enabled

By default, PMD-sized hugepages have enabled="inherited" and all other
hugepage sizes have enabled="never".


>   It's also possible to limit defrag efforts in the VM to generate
>   anonymous hugepages in case they're not immediately free to madvise
>   regions or to never try to defrag memory and simply fallback to regular
> @@ -146,25 +176,34 @@ madvise
>   never
>   	should be self-explanatory.
> 
> -By default kernel tries to use huge zero page on read page fault to
> -anonymous mapping. It's possible to disable huge zero page by writing 0
> -or enable it back by writing 1::
> +By default kernel tries to use huge, PMD-mappable zero page on read
> +page fault to anonymous mapping. It's possible to disable huge zero
> +page by writing 0 or enable it back by writing 1::
> 
>   	echo 0 >/sys/kernel/mm/transparent_hugepage/use_zero_page
>   	echo 1 >/sys/kernel/mm/transparent_hugepage/use_zero_page
> 
> -Some userspace (such as a test program, or an optimized memory allocation
> -library) may want to know the size (in bytes) of a transparent hugepage::
> +Some userspace (such as a test program, or an optimized memory
> +allocation library) may want to know the size (in bytes) of a
> +PMD-mappable transparent hugepage::
> 
>   	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
> 
> -khugepaged will be automatically started when
> -transparent_hugepage/enabled is set to "always" or "madvise, and it'll
> -be automatically shutdown if it's set to "never".
> +khugepaged will be automatically started when one or more hugepage
> +sizes are enabled (either by directly setting "always" or "madvise",
> +or by setting "global" while the global enabled is set to "always" or
> +"madvise"), and it'll be automatically shutdown when the last hugepage
> +size is disabled (either by directly setting "never", or by setting
> +"global" while the global enabled is set to "never").
> 
>   Khugepaged controls
>   -------------------
> 
> +.. note::
> +   khugepaged currently only searches for opportunities to collapse to
> +   PMD-sized THP and no attempt is made to collapse to small-sized
> +   THP.
> +
>   khugepaged runs usually at low frequency so while one may not want to
>   invoke defrag algorithms synchronously during the page faults, it
>   should be worth invoking defrag at least in khugepaged. However it's
> @@ -282,10 +321,11 @@ force
>   Need of application restart
>   ===========================
> 
> -The transparent_hugepage/enabled values and tmpfs mount option only affect
> -future behavior. So to make them effective you need to restart any
> -application that could have been using hugepages. This also applies to the
> -regions registered in khugepaged.
> +The transparent_hugepage/enabled and
> +transparent_hugepage/hugepages-<size>kB/enabled values and tmpfs mount
> +option only affect future behavior. So to make them effective you need
> +to restart any application that could have been using hugepages. This
> +also applies to the regions registered in khugepaged.
> 
>   Monitoring usage
>   ================
> @@ -308,6 +348,10 @@ frequently will incur overhead.
>   There are a number of counters in ``/proc/vmstat`` that may be used to
>   monitor how successfully the system is providing huge pages for use.
> 
> +.. note::
> +   Currently the below counters only record events relating to
> +   PMD-sized THP. Events relating to small-sized THP are not included.

Here's another spot to rename to "multi-size THP".

> +
>   thp_fault_alloc
>   	is incremented every time a huge page is successfully
>   	allocated to handle a page fault.
> @@ -413,7 +457,7 @@ for huge pages.
>   Optimizing the applications
>   ===========================
> 
> -To be guaranteed that the kernel will map a 2M page immediately in any
> +To be guaranteed that the kernel will map a THP immediately in any
>   memory region, the mmap region has to be hugepage naturally
>   aligned. posix_memalign() can provide that guarantee.
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 49ef12df631b..f8e8dd1fd148 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -528,9 +528,9 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
>   does not take into account swapped out page of underlying shmem objects.
>   "Locked" indicates whether the mapping is locked in memory or not.
> 
> -"THPeligible" indicates whether the mapping is eligible for allocating THP
> -pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
> -It just shows the current status.
> +"THPeligible" indicates whether the mapping is eligible for allocating
> +naturally aligned THP pages of any currently enabled size. 1 if true, 0
> +otherwise. It just shows the current status.

"It just shows the current status"...as opposed to what? I'm missing an
educational opportunity here--not sure what this means. :)

> 
>   "VmFlags" field deserves a separate description. This member represents the
>   kernel flags associated with the particular virtual memory area in two letter
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51e0ec658457..2e25362ca9fa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -865,7 +865,8 @@ static int show_smap(struct seq_file *m, void *v)
>   	__show_smap(m, &mss, false);
> 
>   	seq_printf(m, "THPeligible:    %8u\n",
> -		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
> +		   !!hugepage_vma_check(vma, vma->vm_flags, true, false, true,
> +					THP_ORDERS_ALL));
> 
>   	if (arch_pkeys_enabled())
>   		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..7d6f7d96b039 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -67,6 +67,21 @@ extern struct kobj_attribute shmem_enabled_attr;
>   #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> 
> +/*
> + * Mask of all large folio orders supported for anonymous THP.
> + */
> +#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
> +
> +/*
> + * Mask of all large folio orders supported for file THP.
> + */
> +#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))

Is there something about file THP that implies PUD_ORDER? This
deserves an explanatory comment, I think.

> +
> +/*
> + * Mask of all large folio orders supported for THP.
> + */
> +#define THP_ORDERS_ALL		(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   #define HPAGE_PMD_SHIFT PMD_SHIFT
>   #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
> @@ -78,13 +93,18 @@ extern struct kobj_attribute shmem_enabled_attr;
> 
>   extern unsigned long transparent_hugepage_flags;
> 
> -#define hugepage_flags_enabled()					       \
> -	(transparent_hugepage_flags &				       \
> -	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
> -	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
> -#define hugepage_flags_always()				\
> -	(transparent_hugepage_flags &			\
> -	 (1<<TRANSPARENT_HUGEPAGE_FLAG))

Are macros actually required? If not, static inlines would be nicer.

> +bool hugepage_flags_enabled(void);
> +
> +static inline int first_order(unsigned long orders)
> +{
> +	return fls_long(orders) - 1;
> +}
> +
> +static inline int next_order(unsigned long *orders, int prev)
> +{
> +	*orders &= ~BIT(prev);
> +	return first_order(*orders);
> +}
> 
>   /*
>    * Do the below checks:
> @@ -97,23 +117,39 @@ extern unsigned long transparent_hugepage_flags;
>    *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
>    *     area.
>    */
> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long addr)
> -{
> -	unsigned long haddr;
> -
> -	/* Don't have to check pgoff for anonymous vma */
> -	if (!vma_is_anonymous(vma)) {
> -		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> -				HPAGE_PMD_NR))
> -			return false;
> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long orders)

Changing this from a bool to a mask of orders is quite significant, and
both the function name and the function-level comment documentation need
to also be adjusted. Here, perhaps one of these names would work:

         transhuge_vma_suitable_orders()
         transhuge_vma_orders()


> +{
> +	int order;
> +
> +	/*
> +	 * Iterate over orders, highest to lowest, removing orders that don't
> +	 * meet alignment requirements from the set. Exit loop at first order
> +	 * that meets requirements, since all lower orders must also meet
> +	 * requirements.

Should we add a little note here, to the effect of, "this is unilaterally
taking over a certain amount of allocation-like policy, by deciding how
to search for folios of a certain size"?

Or is this The Only Way To Do It, after all? I know we had some discussion
about it, and intuitively it feels reasonable, but wanted to poke at it
one last time anyway.

> +	 */
> +
> +	order = first_order(orders);
> +
> +	while (orders) {
> +		unsigned long hpage_size = PAGE_SIZE << order;
> +		unsigned long haddr = ALIGN_DOWN(addr, hpage_size);
> +
> +		if (haddr >= vma->vm_start &&
> +		    haddr + hpage_size <= vma->vm_end) {
> +			if (!vma_is_anonymous(vma)) {
> +				if (IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> +						vma->vm_pgoff,
> +						hpage_size >> PAGE_SHIFT))
> +					break;
> +			} else
> +				break;
> +		}
> +
> +		order = next_order(&orders, order);
>   	}
> 
> -	haddr = addr & HPAGE_PMD_MASK;
> -
> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> -		return false;
> -	return true;
> +	return orders;
>   }
> 
>   static inline bool file_thp_enabled(struct vm_area_struct *vma)
> @@ -130,8 +166,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>   	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>   }
> 
> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> -			bool smaps, bool in_pf, bool enforce_sysfs);
> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
> +				 unsigned long vm_flags, bool smaps, bool in_pf,
> +				 bool enforce_sysfs, unsigned long orders);
> 
>   #define transparent_hugepage_use_zero_page()				\
>   	(transparent_hugepage_flags &					\
> @@ -267,17 +304,18 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
>   	return false;
>   }
> 
> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long addr)
> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long orders)
>   {
> -	return false;
> +	return 0;
>   }
> 
> -static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> -				      unsigned long vm_flags, bool smaps,
> -				      bool in_pf, bool enforce_sysfs)
> +static inline unsigned long hugepage_vma_check(struct vm_area_struct *vma,
> +					unsigned long vm_flags, bool smaps,
> +					bool in_pf, bool enforce_sysfs,
> +					unsigned long orders)
>   {
> -	return false;
> +	return 0;
>   }
> 
>   static inline void folio_prep_large_rmappable(struct folio *folio) {}
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6eb55f97a3d2..0b545d56420c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -74,12 +74,60 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   static atomic_t huge_zero_refcount;
>   struct page *huge_zero_page __read_mostly;
>   unsigned long huge_zero_pfn __read_mostly = ~0UL;
> +static unsigned long huge_anon_orders_always __read_mostly;
> +static unsigned long huge_anon_orders_madvise __read_mostly;
> +static unsigned long huge_anon_orders_global __read_mostly;
> 
> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> -			bool smaps, bool in_pf, bool enforce_sysfs)
> +#define hugepage_global_enabled()			\
> +	(transparent_hugepage_flags &			\
> +	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		\
> +	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
> +
> +#define hugepage_global_always()			\
> +	(transparent_hugepage_flags &			\
> +	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
> +

Here again, I'd like to request that we avoid macros, as I don't think
they are strictly required.

> +bool hugepage_flags_enabled(void)
>   {
> +	/*
> +	 * We cover both the anon and the file-backed case here; we must return
> +	 * true if globally enabled, even when all anon sizes are set to never.
> +	 * So we don't need to look at huge_anon_orders_global.
> +	 */
> +	return hugepage_global_enabled() ||
> +	       huge_anon_orders_always ||
> +	       huge_anon_orders_madvise;
> +}
> +
> +/**
> + * hugepage_vma_check - determine which hugepage orders can be applied to vma
> + * @vma:  the vm area to check
> + * @vm_flags: use these vm_flags instead of vma->vm_flags
> + * @smaps: whether answer will be used for smaps file
> + * @in_pf: whether answer will be used by page fault handler
> + * @enforce_sysfs: whether sysfs config should be taken into account
> + * @orders: bitfield of all orders to consider
> + *
> + * Calculates the intersection of the requested hugepage orders and the allowed
> + * hugepage orders for the provided vma. Permitted orders are encoded as a set
> + * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
> + * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
> + *
> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
> + * orders are allowed.
> + */
> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
> +				 unsigned long vm_flags, bool smaps, bool in_pf,
> +				 bool enforce_sysfs, unsigned long orders)

Here again, a bool return type has been changed to a bitfield. Let's
also update the function name. Maybe one of these:

         hugepage_vma_orders()
         hugepage_vma_allowable_orders()

?


thanks,
-- 
John Hubbard
NVIDIA

