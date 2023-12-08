Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3E8098A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572884AbjLHBbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:30:57 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C41715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0W8tOX9e2ZOLjts2ybo06bwvnorvRQsHVmI1fm4rM1Lc1OmNjzhmmbZwwHc5RF+xbG2Q8/jpG7UWbCJEnrsQ1fJrYr75wByUuux5f4mMLgvDduXLxr8MQLg7WY3txhOpJkV1GOsxWwiK2/hmWjO9V7N/YDen2eybo5TPi3SMh/UG33vFFu0WzkZp+vQhsrw+JbH1o0Pz3uP0J9FP+eqyoUVvf1QqxKBL79SYk4//2lWqvFpcOTTOuZFWVBGPSJU36A8aOA5VSMkSc2uqBq4/TSeUqSLE2Q1++/OIIu503e7d2WDZVoSBiqsfKeXipLP0b5XwZX2aL3eYTv8kfpjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Fkv8huytLjMsn7KFu0Hu/6eMhU4MYqMVQWUbQsWr8=;
 b=cLlhk4t1ZyMIafZLeEPd7n7D6NdLTJgLgHX9qKoviLVgskWqcwqbO21MRcOLbgTSPg4lX7eOZnprdUPp8p3eejsz6PMgvsuuhPjJID1PYx0ujbAqLOtDXJWtw0oPnQ1M2UMEUwO/Byj4ugzbuIDkkkXvwFD6ZKWrKdT9xkeex2oO/5gMeTA/aHYE9ivqJJF/8oTO/Z+JXcSYGa1yTJLy0lr9YbmiZWyRCvTAy6TEE4IWB8wJxk3iwXw1AJ2k0mIPypKgyVCC4CO2d5GsWSpH5wxq/2CvbQZnleGIasFOegcp+KbODHJf4BunN61dAKqjQ5PzBbjAU2jqAFGAFGIAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Fkv8huytLjMsn7KFu0Hu/6eMhU4MYqMVQWUbQsWr8=;
 b=ubxZXiHqJspjXy3Y07aFZvM0DCFhD2sQ/XPPbsdt52qr+iWKjtBSis6Ij/IO33jHkgiu7Oe66/AKUluvcWtOkHq7UhcY9e82rxubocGHy1943nKtzWzrB/poUiXvnpex/RuGwjtKvYBTUkI0pmoPQYmFOmU9lEEW8ta1vXy9KP/FhTXzeI10G6ZijHvJpuZ16AiwgAumo1vvW1YDQCBN656mwqIq+5n6BcpzzlCy3YW9tpyAYdlOjFDOYFW8kVKCQaqy6bkKhjnj+CnZ7ScMjpIduMNfDb+DltIv+dy2848Z1hdJSKOFaVhyYVXRHJHKt/dUaY6BFL6iPRKQ/klTdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:31:00 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:30:59 +0000
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-3-ryan.roberts@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] mm: Batch-clear PTE ranges during zap_pte_range()
Date:   Fri, 08 Dec 2023 12:30:40 +1100
In-reply-to: <20231204105440.61448-3-ryan.roberts@arm.com>
Message-ID: <87h6kta3ap.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0125.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::14) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 988e53ad-4cbc-43a3-bd50-08dbf78d54f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzNxfdVaucsHU86tODw128/iKp/IYgd3HFvSKEK6EuW/v/rSqWBskzFJnpYS6yjRNQRBu6/sRXIAR6nqKQyG80AItcIXy0r2y72aX/fz5QTEcSoKleSHDR+XtLdz7KdMPHG6rc58oeGIvuSFqL2mh4GHgLGs9V6V51kTIISIkHpAaWmtJGCWvwPE7vcIFov/cYNWTXZOhaPhCXquU40GP4/pQbbFHgJl7Zykrs+0tOHh8ygK7Yj3HY5j/00rk2ylQeIV+hF+kfLSpWA7hLf3lx9jRVv9qD8L/OZ0i/uQqcBXIIA0Z8ulwUM/509o03mNalrV0QNGEGRLNtE6ssIFcixVk5LkfbMffXEsX9XvCoRcmepe/8IzEG1SPT5OjAQ4zhpmkqGWFv8wMBy8oQ8fdAKMtH+lfHQ1jJFcjgTfawdZWdxAlVoD3vjehyVmQMJZlhrJgx2xcbE+hGZfJkDdl69M6yd6AKZdQOPubUMDaHlAIGoIJ5l6CbV5w+GxYAMRxuAmls3cm0g/PPyEJrFpO5v1tNfjy8s5h2L7r6UQJhbbaVrCRM8R6KNbwk4tVHVd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8676002)(8936002)(7416002)(4326008)(6486002)(6666004)(6512007)(9686003)(6506007)(478600001)(5660300002)(316002)(6916009)(66476007)(54906003)(66556008)(66946007)(41300700001)(2906002)(38100700002)(26005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BW91A+iigNx64R+C7naPWZrUGn6YaWMe1I59dDd9rcWVqNz/6Jrrl9XKjfFy?=
 =?us-ascii?Q?yRKb+33HfsnykGn/PPFVNtQDdihg8NlJTEE8lpifdaNIgpNVAc6dqzFrm+7M?=
 =?us-ascii?Q?5+f9nI0wiZ+mBV1fgeUIDmAVsPEUc8hXlnppRXuUDCmt7RJWx8H5IP/Agw/B?=
 =?us-ascii?Q?N3eXmNNumptUoxYcvmRaNsw6wkCmhcIVAec1v+82h2hF8DjYKvlavT3ABL6Q?=
 =?us-ascii?Q?E9ZWt/AKcQCBhMCZncIxYem4Moy1YJqvs+LEhXfFbdqM2hWTNbbBNLQZbwjO?=
 =?us-ascii?Q?xvKFxhbQeRMjmV5WLUPgrYd9OR0lPg3VvPuz6+2ZIkUZ4sI/N7HZJS9bMerq?=
 =?us-ascii?Q?aY42zu37yLHf1VN2x/T4hI1c2a+/CyhVtoxP7/PVzyEnLS/DWu7glOIkYKKx?=
 =?us-ascii?Q?uPZJljPr9SvaoTBh9q8rGIijgTeADy5JXYRChVhk0XYi5KKk4w0+HYb3fKKK?=
 =?us-ascii?Q?kY3J/lYKhOUAWD0iJ+QLtjuK+jXDEuaeWaPXFd3jtJK8cMeM5MmcaR8bRw5M?=
 =?us-ascii?Q?dCd5lWa1pBp37JROqZjr2WlpL8mhhZnQF7TI0r5Y/1SdbgUqt5FRU/8sPK6U?=
 =?us-ascii?Q?Mvqzp4QxB6KdidhPIBzSGqfgbaxcD1D5yNn7f9WgBp3xECNfXIQ6oW8fGcHk?=
 =?us-ascii?Q?t28uFodr60McPLm+3XZy7FZl238ce0Wp0KjO6td26YHDX8sOZCiEVjwpGc7O?=
 =?us-ascii?Q?buKeS1pbu0vJay0v9UP53yKJtHo66pM7wFRRS1JhCUyvFCpPoWEnAngqSwNd?=
 =?us-ascii?Q?DvzwSDaPp4AR+B9BVyH+tHSlrG6+b/rtBSKnzqKRByRZrA/L9Lhww1QosxPp?=
 =?us-ascii?Q?nCP/l8LPD5d1Unj0fOw4AlpEald3Hay83YL81QvhhdWGDwfX8uAUO8waLQEt?=
 =?us-ascii?Q?+QhcFriwg8/T8CZ8Pqx4UjzwQbiqQRsy8fXIlIGu2Pa5Nnt2funk3DCpvc1+?=
 =?us-ascii?Q?RzAUMg18ilcN4d4VsfeL/FJmGTfIpvbSpGM4mXfN8iUYP6Cvvms7Ab3DGjBy?=
 =?us-ascii?Q?DprjSypvzrmK4lzhD42yBTY8nBX0i6apmn0u0vULs1lcxJaxrju17lXpMkel?=
 =?us-ascii?Q?p7534dfjjMv8VSLNnWTaw5Xfa99wbkwM92wfu9CqluyZ/tGGQfG89UgIv/RF?=
 =?us-ascii?Q?mHMd4ZouUGNxL6LgWeJYOCIs34qZ+Z+rWsUmEQnElhMx7wbXVqXAfSSfCpaV?=
 =?us-ascii?Q?101axDzcIFbBlUqm+TU2VhkYhbmYSUFaO7HQ1MPARtHNFBx0mbikEDPtPDYi?=
 =?us-ascii?Q?81540cjSh425BcyZe7xoOey2ziwENTpdlTtvjfWXFr3oIRKnCtCryRW8h1Fd?=
 =?us-ascii?Q?+LACuPmnU42c9TiuodKm36J78JNy+9K0zJtkMIi/zjhs5ICZt3mL+vQGyHZq?=
 =?us-ascii?Q?9x1s9JuHr1zLcZw5eGRfFqRKKLPdPeT/LL65/VLUMgIdtxxUsfqGR1TZcZ+t?=
 =?us-ascii?Q?DcjIzYolaGVA7nDzWEZ+XJ2I+6dBNGR6+EmCJGe3ir6Cgy+Up2iLinf78wV6?=
 =?us-ascii?Q?gPNwJmDEjs9fEsZMmW68YSitUDA5tQzfMSIsYZXVA5Z3J6cKnZeoPSLhmOQz?=
 =?us-ascii?Q?gWp42GKaGBMDRUQQsZ1LAxWyIfhKoN9StoSbNjzf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988e53ad-4cbc-43a3-bd50-08dbf78d54f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:30:59.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwzqxcqGE1I35K0kU/F/JurJB/tzz4PRB6yz2zN8tpCrHXn3Wa1pvu9XMsFF+jRIuoZJHr9xL5ejXJCuENbIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> Convert zap_pte_range() to clear a set of ptes in a batch. A given batch
> maps a physically contiguous block of memory, all belonging to the same
> folio. This will likely improve performance by a tiny amount due to
> removing duplicate calls to mark the folio dirty and accessed. And also
> provides us with a future opportunity to batch the rmap removal.
>
> However, the primary motivation for this change is to reduce the number
> of tlb maintenance operations that the arm64 backend has to perform
> during exit and other syscalls that cause zap_pte_range() (e.g. munmap,
> madvise(DONTNEED), etc.), as it is about to add transparent support for
> the "contiguous bit" in its ptes. By clearing ptes using the new
> clear_ptes() API, the backend doesn't have to perform an expensive
> unfold operation when a PTE being cleared is part of a contpte block.
> Instead it can just clear the whole block immediately.
>
> This change addresses the core-mm refactoring only, and introduces
> clear_ptes() with a default implementation that calls
> ptep_get_and_clear_full() for each pte in the range. Note that this API
> returns the pte at the beginning of the batch, but with the dirty and
> young bits set if ANY of the ptes in the cleared batch had those bits
> set; this information is applied to the folio by the core-mm. Given the
> batch is garranteed to cover only a single folio, collapsing this state

Nit: s/garranteed/guaranteed/

> does not lose any useful information.
>
> A separate change will implement clear_ptes() in the arm64 backend to
> realize the performance improvement as part of the work to enable
> contpte mappings.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/asm-generic/tlb.h |  9 ++++++
>  include/linux/pgtable.h   | 26 ++++++++++++++++
>  mm/memory.c               | 63 ++++++++++++++++++++++++++-------------
>  mm/mmu_gather.c           | 14 +++++++++
>  4 files changed, 92 insertions(+), 20 deletions(-)

<snip>

> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 4f559f4ddd21..57b4d5f0dfa4 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -47,6 +47,20 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	return true;
>  }
>  
> +unsigned int tlb_get_guaranteed_space(struct mmu_gather *tlb)
> +{
> +	struct mmu_gather_batch *batch = tlb->active;
> +	unsigned int nr_next = 0;
> +
> +	/* Allocate next batch so we can guarrantee at least one batch. */
> +	if (tlb_next_batch(tlb)) {
> +		tlb->active = batch;

Rather than calling tlb_next_batch(tlb) and then undoing some of what it
does I think it would be clearer to factor out the allocation part of
tlb_next_batch(tlb) into a separate function (eg. tlb_alloc_batch) that
you can call from both here and tlb_next_batch().

Otherwise I think this overall direction looks better than trying to
play funny games in the arch layer as it's much clearer what's going on
to core-mm code.

 - Alistair

> +		nr_next = batch->next->max;
> +	}
> +
> +	return batch->max - batch->nr + nr_next;
> +}
> +
>  #ifdef CONFIG_SMP
>  static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
>  {

