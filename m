Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE017DA3EE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbjJ0XEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:04:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75EB1B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIC72DSpJVs7W+INa9ZE/cpUKT6g0DmrJrh4qb2iCub9sk2q4sanVImvD11TqP2csS+FL+EWQ2luDHiJR9bxM44/Izz3zwdTcEmoc3D5wsCgWgb9DverJOOyfYWnb9uOeZdcbZmdHnu/M5zElFKP4pomPEXqX2IuaqxHsw2QVIRZ/4+gNmpqBB+rIjmefquKlechM7za4S8rUeZ1z1oG/oJ3rHS2xTxjqXj/WOzHnkvsdqxjXs6uTMQlcsgUS6M6E0UrOAtzXEuM1rPAvMaVy4UqSJ//CLlLYBuZY9FhvXhlkZZHVoUd7dlM6NX6IIYczJd6DtKzPA0CXqcsyCxBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ldLKbzZl/mUGSLeo0F0BHrhxUwyXc76MW2zMfALH64=;
 b=fMHN8JP984fcw7y9Rw0eOhwghZDGVr7fxHEvHZ50/vWIOp/sZqImJDslyqiSCi6o2d7YtzVxH0Ue353ZFkVoRkxHIJHmCNOdU+FG5mJ3XcIESjI7HBjVRUdYIcDDVdKRVAOn42B5HLn9Zs0jYn1tMCG65VSrnrFuv1YEz1oJB9qhtG9FZp3AFcTopPWzPlXk+R2mvPMZJam/TgkH5NVDi/nAhBZ7/k6396aIvYqFALA7MrHNeOJTaW0BhkxVe0ZKQPGipvEEb7cgzq+AWBehTf4ETWcqoWCbEa0QrGr7R0ZtDx+r8cTyCXqMByl5tmQO1VJpB6X0sFGWQXMX7c+seA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ldLKbzZl/mUGSLeo0F0BHrhxUwyXc76MW2zMfALH64=;
 b=tZJLJXMLzwbV3ZfBjdc6srsxCm/8Abr+JrkJgnG09LuuFHA5ztP91WJDjllOCfAydMyTNhFu6fSV2CBnlffDwKLjmPoZN79J3c5YM9icsxQ3zPuYVkWEOV8deaugnEFyL+1nXJ5ulVnjqXOeO43dZiarFVsclvkaQPHZMEeCE7sJHMuMVxAV5mvKJfnKKtJr8d0hnU81LfYbEAFP4SQkztugB8/ftkoCCPqmUVwZ8tODLgXfehKFPQiCsJS4gwE9vZBiTyJy602Rx7MUfIP5o9cn8EvjxFL5HD/2NhJA2Ac9SsdEh6BJEpEOXNnYUQsCob7K3e/qSHm54iao/F7B2w==
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 23:04:34 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::c8) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 23:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 23:04:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 27 Oct
 2023 16:04:21 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 27 Oct
 2023 16:04:20 -0700
Message-ID: <8a72da61-b2ef-48ad-ae59-0bae7ac2ce10@nvidia.com>
Date:   Fri, 27 Oct 2023 16:04:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
 folios
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
        Hugh Dickins <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-6-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230929114421.3761121-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b75e65-3294-470c-4be8-08dbd74115ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/ekLc542I9zUhhw2s7eev2ttf0MB1hhbW8uYGbAdid34A0/NOmkwhJutivqzrk2w93gFz98iT2lA8yhHeOp81kZGPpKqVbGSOfCQJpgy6nEbA9mWItuj1UC4vhTcSJhXyyA6YW2tO0to/stxGFKEMYaYCFKgRikEug38BW5AcE9YyY0VJXW0S8956FEDyazoV4aUkYXGFRd8F9YzPn56Qt+2OJ1tFdC3qlib0hkGDvGyWjl/6i9BMF2pCIs0jMan9x67X7mcbOQcmFB+L6HpYtdBENys+QWgXArNdS+23vGMheWjYsUtZ9yf5fo8FClB2D5pxe7QU+D+/05mIswAd8Ao2wnA4tylSL61jzELGBbdGkyQeHZmT+kCWcFSDcZ+JOILiW/4skqUnDlrrOMhucF0H6FBjsH8ylq3ZLgJYHd03lZL83WzT7j86c1O1aOv/tf2JJOX5DyQKlLMHzsYk6Hgjmokn+/y7OUclB2k5RGzh7tBpQkL4D1aCxzSMQO10T9WaO7P2BVUY5TBNV8WCeKCsoRFwZXr89TG65PbHFKElTZ8IWynn1f6UawLQw8cQt4Irod9I1DxqEwyFvxKx7qa61wZLkXxVsCx85WE1DaZ99g/v0XOKDGGMY3o1jWLZ7+syS0vuTa3N82k7adAknZxg50tUtpuYTEMP0fBM6LZy2iXC0KWppWRnpMzBmUB/AWPpIHwrmUI4wB+fFDOjBUiNz+soWCjujlmGZ19n4ZOOmYuu/aNcCmNWSz46yWp1o694JTo+99Lfz+0sn59ouUFv7u3QNVNwrgqHsyEI0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(2906002)(31696002)(54906003)(478600001)(70586007)(316002)(36860700001)(82740400003)(110136005)(7636003)(16526019)(356005)(2616005)(53546011)(16576012)(426003)(40480700001)(336012)(41300700001)(47076005)(83380400001)(4326008)(5660300002)(7416002)(36756003)(8676002)(70206006)(8936002)(921008)(26005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 23:04:34.1860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b75e65-3294-470c-4be8-08dbd74115ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 04:44, Ryan Roberts wrote:

Hi Ryan,

A few clarifying questions below.

...
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2e7c338229a6..c4860476a1f5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>   
>   /*
> - * Mask of all large folio orders supported for anonymous THP.
> + * Mask of all large folio orders supported for anonymous THP; all orders up to
> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
> + * (which is a limitation of the THP implementation).
>    */
> -#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
> +#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>   
>   /*
>    * Mask of all large folio orders supported for file THP.
> diff --git a/mm/memory.c b/mm/memory.c
> index b5b82fc8e164..92ed9c782dc9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4059,6 +4059,87 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	return ret;
>   }
>   
> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> +{
> +	int i;
> +
> +	if (nr_pages == 1)
> +		return vmf_pte_changed(vmf);
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> +			return true;

This seems like something different than the function name implies.
It's really confusing: for a single page case, return true if the
pte in the page tables has changed, yes that is very clear.

But then for multiple page cases, which is really the main
focus here--for that, claim that the range has changed if any
pte is present (!pte_none). Can you please help me understand
what this means?

> +	}
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +{
> +	gfp_t gfp;
> +	pte_t *pte;
> +	unsigned long addr;
> +	struct folio *folio;
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned int orders;
> +	int order;
> +
> +	/*
> +	 * If uffd is active for the vma we need per-page fault fidelity to
> +	 * maintain the uffd semantics.
> +	 */
> +	if (userfaultfd_armed(vma))
> +		goto fallback;
> +
> +	/*
> +	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
> +	 * for this vma. Then filter out the orders that can't be allocated over
> +	 * the faulting address and still be fully contained in the vma.
> +	 */
> +	orders = hugepage_vma_check(vma, vma->vm_flags, false, true, true,
> +				    BIT(PMD_ORDER) - 1);
> +	orders = transhuge_vma_suitable(vma, vmf->address, orders);
> +
> +	if (!orders)
> +		goto fallback;
> +
> +	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +	if (!pte)
> +		return ERR_PTR(-EAGAIN);

pte_offset_map() can only fail due to:

     a) Wrong pmd type. These include:
         pmd_none
         pmd_bad
         pmd migration entry
         pmd_trans_huge
         pmd_devmap

     b) __pte_map() failure

For (a), why is it that -EAGAIN is used here? I see that that
will lead to a re-fault, I got that far, but am missing something
still.

For (b), same question, actually. I'm not completely sure why
why a retry is going to fix a __pte_map() failure?


> +
> +	order = first_order(orders);
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		vmf->pte = pte + pte_index(addr);
> +		if (!vmf_pte_range_changed(vmf, 1 << order))
> +			break;
> +		order = next_order(&orders, order);
> +	}
> +
> +	vmf->pte = NULL;
> +	pte_unmap(pte);
> +
> +	gfp = vma_thp_gfp_mask(vma);
> +
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		folio = vma_alloc_folio(gfp, order, vma, addr, true);
> +		if (folio) {
> +			clear_huge_page(&folio->page, addr, 1 << order);
> +			return folio;
> +		}
> +		order = next_order(&orders, order);
> +	}

And finally: is it accurate to say that there are *no* special
page flags being set, for PTE-mapped THPs? I don't see any here,
but want to confirm.


thanks,
-- 
John Hubbard
NVIDIA

