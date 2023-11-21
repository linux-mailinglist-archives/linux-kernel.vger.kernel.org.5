Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5C7F2B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKULWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:22:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4619C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:22:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgegHFPhzLKYXv6LqsA4eY7+KnCksZpy63EVnUxW0VfIRBECmqEyaXEgeXLr0YVRgSuGBZbPbgGGl0KHxnVSEv4ZCse81cTllZEtVUBKslk/NQFC0sZedR8yXkBIj0WrxCc6KpGc7z0cvJVRPkcPXyW7jDH83+3WRcyiX9HxTUXD4n1jV0+XIkevK0CyekpNm5JoabGvwVUXa9RJiq2KMf3Hj4if1zjqNwqjudh3t27YcmWqQ5NeuMquMfO5Lvm+zWlthl+WXjLuJKbMXolqTLemuv7T9ugM04gdG0n321piyVXoAjuqkIj9cp+8NNzmOybnRgRCt/TOQx/Dn33kXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T55v0ThRPFS8ivvT1uW5DI5uyerugczAR+2pDPt0p8U=;
 b=kKo8Byi+NO/q25N4z2AWXVq3tQutKAgEySv8v86tNJAGpqmHmY48n7KyE/ThXWHINQ2BB3AKDwWeAqtQ5VtZPe/qV+Fq+Nfh3o7aqlfPaXH+0tutJtAZWfdHPI9fJxPGFGF5SdhVvsizp9ZdoGD9TSU1yH/d6V6FAP5WMRYBIW3MWGAWgugs9pS7M915UwW2OJmPQcQ8FG8VuOI5sEdn9pU8/jKkkOn1coRvKhpKQqsiMu45UyfmnYyqqhlxB7AD4BHxuNmJvJJgRKl1Axrh99a5GrHchvdvAAFm/kMONhC5Hu7bG6jtlCdnT0zR5gZNgfeN+RYdq7136y9la3iTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T55v0ThRPFS8ivvT1uW5DI5uyerugczAR+2pDPt0p8U=;
 b=cjNIm4z0LaI9YgZXFsttx0sCFF/3gxxG0+UKAcKc6sfOA+Z4Ib2f9jNmad0lG894jdTMgAfP7Ypid6o4nZtVpi2VPLhQUzPi6RDoDedMA0tTGNlSSApaYCIv2hhks0xE4Di+qYS0Z5nSvD5JWFo70fx0PGCxq1Rf4TVR8vh61sc38WFF9myJghm/j7W3Uy9wtafytEWOdhQS7sp52ihYeyWeU9gDTM9zPzajxamNq15za+xXSO/lx8L7iz+aUffXdEM3dLAl95tkumkvoaNRhKNE29uGQ6GL/IFvuvfSCN1fEh7lZMx75j8xaYuGXvyRTid1eyLEp8w+0X3jo1antg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Tue, 21 Nov
 2023 11:22:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 11:22:39 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-13-ryan.roberts@arm.com>
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
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] arm64/mm: Wire up PTE_CONT for user mappings
Date:   Tue, 21 Nov 2023 22:22:28 +1100
In-reply-to: <20231115163018.1303287-13-ryan.roberts@arm.com>
Message-ID: <87v89vmjus.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:10:31::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bffa6e-9f01-42f3-260c-08dbea842b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hx8zpAfW7pRhhykqbC+RtIEpCEGAQOVJEJoVusELljY50ssvNbj+9qebpfIPUxbdUm3ZhLtnF+jmDkj+L+MFa6mChMT61fpnXug4s9J7GK/ztrjdbmINMDQm5nbRZusE3KQpILys2jtQ4T4/lowsYVE+pWkoIr/TNxmbPoqFoKEhXbv+a2eaK71fGZyIOk+JIk4zDraTHD6kGCpgez45hIiFo8iJJQZYVLCRDzF3hMctvF+9DEZ/6PFqY1WxVCJ2gRbF+Wff1jepS+Px6+djKflx6gguPz4bhU+ckkyVTm6O8nUXQOkMR/bcUeOv6bjCNv0OAOzVluBUEd8l9uf8GsMPkWGsT5H58uWmm33qmcMtas7METO6GLkzje+ICmensqrdSnlSsdMg7hVx87Y6Zo6VDtjQT0GU1caCRgWC2fXMRwFcgQz0T0W5nE0AbEtsGPLlZ24ASlYrKb18VPUR0sWY4CsramcsnrPOYSjl12h/aCXrfgKvTemqtqszLnWmfrJf4z2vJChF/XpPyCLzFj/EOIOQWB1ewIE+/CZccao1Z0Eyr+yrN5r2XABkxR9l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(30864003)(26005)(6512007)(2906002)(9686003)(5660300002)(7416002)(8936002)(41300700001)(6506007)(4326008)(8676002)(6666004)(38100700002)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3pVnIGTN/89G+v9NQFrdSD/fI3Y6KqpjkXP9xJQeL1FTY6Y/v7dl1CNTUoz?=
 =?us-ascii?Q?l5RvdzwbuDf3FADszs+F6vmY13H9SIcwvu571MbLEyMHlivB6g5WzobPzp2l?=
 =?us-ascii?Q?Ob6lhGU3B+9stVGheWP9pkDdbBwutlrBOhDS7afvuo3mvCsXQOATlnzb7RKZ?=
 =?us-ascii?Q?uNHcPhAxn43Y4yoIFIL88s1E8qu4XQ86YfXIk0bWS7PMXeWJKD/mHDH9Pwky?=
 =?us-ascii?Q?qJwGEOUtKVeXPEjZ3LiajrGXIT129ncKz4PMRhPv0bvi+VSSq/5wSW75niw5?=
 =?us-ascii?Q?YazUbwR/79vFZfLQY2wxGigNFOsOHGlNlDe3gSmaNf7rUl5A9vWJRpWkSubE?=
 =?us-ascii?Q?eSS7lxnrXJKh75PLyDR5AsZYmWQLX+qFEc2zpDg7MG2raupLpU4UO1plt0NQ?=
 =?us-ascii?Q?1evp2gwKKMW61UxShA5vL8JIU4fgsrYlYqqbItWloHk9DWmHjtWwv4qAXkRH?=
 =?us-ascii?Q?YPMVC6wiq6bttHzRDbKL8pLS5VtSaZVJCQhg4Vh/3yH7TDSBpDmeBNkDTOJo?=
 =?us-ascii?Q?Rfv1E/eBEX8QdzmF2O+zltQ71e7V9y1UYVm+DFIvQ/impPIgQlsyrUU36sdz?=
 =?us-ascii?Q?uOEbadWcOyl4s/1gd7/oc1USjQuV5i3tYLWKI8xTqqvJTghxoorbNrZJFpmg?=
 =?us-ascii?Q?b4kPTWYsZ1kLKRg8fR1x8i/OusxqgdE4kYN5j312tKgWo4YO8kPwr6WxKb5Q?=
 =?us-ascii?Q?rdCL525RTofrDk3wlAxUM2iVzNK7lyNhy34iQr3ZELvjKiymQ5kaMr9vhVHW?=
 =?us-ascii?Q?CHhqgi8V1BBmGTnWB4p70NL7zAc9FSEB4Qi8C6C4SfGW2CeLfhUdKrnQb7tb?=
 =?us-ascii?Q?50zxrgjTqpfcomgFNijsiEW0lXrSSokXeX0kSzYUHRUmEEeTBu/DN2WUxcx4?=
 =?us-ascii?Q?jHHbp9VKwF+3q9sNfD3Lo308nD1OPE3txBlZS1rT8j98Rhj4by0HkKbI+OfR?=
 =?us-ascii?Q?PcWwE0Auh+FQFgQZ7lpEXev7fqGM2xNKRtsV83cq4QbfACDruUzYz1ou4ATS?=
 =?us-ascii?Q?WpOY55vX5wYiEmzzHOkauhdKdBkbZil7YMGEk4nHRZc5wp5Yy8bRYzAm0tDb?=
 =?us-ascii?Q?1JpDum98FquNxzkdxSInLwWH5x4PK9cHvAbMhVESv4WwqNi3d2GYpgRsr9M5?=
 =?us-ascii?Q?DxULUBa483jme9ME8txkDLPQSHlHMbnmw3C7Vyf++qWbblZdt9YFDQJ8wz1h?=
 =?us-ascii?Q?vPA3kLg/lxQ/dmmAb52QzCgaMhMRnt798flvXVweAz1UmH2V9a9yp0Jr9w9p?=
 =?us-ascii?Q?TB0dpIJQpZQ2l+Uu19C5f0OwSKqefLc3Gjgt+HOLBm+CsSSVIBW7WocgBXfc?=
 =?us-ascii?Q?9wnwF+csgbzdmEVfbXpb9j2HGI1QBVsXHuKLLPFpGFt8nMRRjKS4cMRBrguh?=
 =?us-ascii?Q?UWVdJJJG4ly5C+9E1eCVMw8l1kVy1QjmyrOoDsL2XT4LqPTXqyZY3j2elwBU?=
 =?us-ascii?Q?Mko4JRGyh2Rqgejo+TCJk48WXw4ZXbYm3vp6SYMTxRBzItvExPoGn979woiL?=
 =?us-ascii?Q?Z+tmWbT1oDbZs0+q4NUSesXv7BsBSLCrDbzdUnL7oHwinbpOcdv+gEDQIphw?=
 =?us-ascii?Q?ioc+VOiurPOeynZhJuhLvzLokqjS/BF+L/5lDBK/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bffa6e-9f01-42f3-260c-08dbea842b9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:22:39.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv5PgmkjolPTRia22gxrZf8/BZ8JzP72JyI8Kl41VUd1ayjqNUIIicG00WnjW95cj0XtvVz4ltM3y3rS4bEfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
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

[...]

> +static void contpte_fold(struct mm_struct *mm, unsigned long addr,
> +			pte_t *ptep, pte_t pte, bool fold)
> +{
> +	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
> +	unsigned long start_addr;
> +	pte_t *start_ptep;
> +	int i;
> +
> +	start_ptep = ptep = contpte_align_down(ptep);
> +	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
> +	pte = fold ? pte_mkcont(pte) : pte_mknoncont(pte);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
> +		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
> +
> +		if (pte_dirty(ptent))
> +			pte = pte_mkdirty(pte);
> +
> +		if (pte_young(ptent))
> +			pte = pte_mkyoung(pte);
> +	}
> +
> +	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> +
> +	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> +}
> +
> +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> +			pte_t *ptep, pte_t pte)
> +{
> +	/*
> +	 * We have already checked that the virtual and pysical addresses are
> +	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
> +	 * remaining checks are to ensure that the contpte range is fully
> +	 * covered by a single folio, and ensure that all the ptes are valid
> +	 * with contiguous PFNs and matching prots. We ignore the state of the
> +	 * access and dirty bits for the purpose of deciding if its a contiguous
> +	 * range; the folding process will generate a single contpte entry which
> +	 * has a single access and dirty bit. Those 2 bits are the logical OR of
> +	 * their respective bits in the constituent pte entries. In order to
> +	 * ensure the contpte range is covered by a single folio, we must
> +	 * recover the folio from the pfn, but special mappings don't have a
> +	 * folio backing them. Fortunately contpte_try_fold() already checked
> +	 * that the pte is not special - we never try to fold special mappings.
> +	 * Note we can't use vm_normal_page() for this since we don't have the
> +	 * vma.
> +	 */
> +
> +	struct page *page = pte_page(pte);
> +	struct folio *folio = page_folio(page);
> +	unsigned long folio_saddr = addr - (page - &folio->page) * PAGE_SIZE;
> +	unsigned long folio_eaddr = folio_saddr + folio_nr_pages(folio) * PAGE_SIZE;
> +	unsigned long cont_saddr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +	unsigned long cont_eaddr = cont_saddr + CONT_PTE_SIZE;
> +	unsigned long pfn;
> +	pgprot_t prot;
> +	pte_t subpte;
> +	pte_t *orig_ptep;
> +	int i;
> +
> +	if (folio_saddr > cont_saddr || folio_eaddr < cont_eaddr)
> +		return;
> +
> +	pfn = pte_pfn(pte) - ((addr - cont_saddr) >> PAGE_SHIFT);
> +	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
> +	orig_ptep = ptep;
> +	ptep = contpte_align_down(ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
> +		subpte = __ptep_get(ptep);
> +		subpte = pte_mkold(pte_mkclean(subpte));
> +
> +		if (!pte_valid(subpte) ||
> +		    pte_pfn(subpte) != pfn ||
> +		    pgprot_val(pte_pgprot(subpte)) != pgprot_val(prot))
> +			return;
> +	}
> +
> +	contpte_fold(mm, addr, orig_ptep, pte, true);
> +}
> +EXPORT_SYMBOL(__contpte_try_fold);
> +
> +void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
> +			pte_t *ptep, pte_t pte)
> +{
> +	/*
> +	 * We have already checked that the ptes are contiguous in
> +	 * contpte_try_unfold(), so we can unfold unconditionally here.
> +	 */
> +
> +	contpte_fold(mm, addr, ptep, pte, false);

I'm still working my way through the series but calling a fold during an
unfold stood out as it seemed wrong. Obviously further reading revealed
the boolean flag that changes the functions meaning but I think it would
be better to refactor that.

We could easily rename contpte_fold() to eg. set_cont_ptes() and factor
the pte calculation loop into a separate helper
(eg. calculate_contpte_dirty_young() or some hopefully better name)
called further up the stack. That has an added benefit of providing a
spot to add the nice comment for young/dirty rules you provided in the
patch description ;-)

In other words we'd have something like:

void __contpte_try_unfold() {
     pte = calculate_contpte_dirty_young(mm, addr, ptep, pte);
     pte = pte_mknoncont(pte);
     set_cont_ptes(mm, addr, ptep, pte);
}

Which IMHO is more immediately understandable.

 - Alistair

> +}
> +EXPORT_SYMBOL(__contpte_try_unfold);
> +
> +pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
> +{
> +	/*
> +	 * Gather access/dirty bits, which may be populated in any of the ptes
> +	 * of the contig range. We are guarranteed to be holding the PTL, so any
> +	 * contiguous range cannot be unfolded or otherwise modified under our
> +	 * feet.
> +	 */
> +
> +	pte_t pte;
> +	int i;
> +
> +	ptep = contpte_align_down(ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++) {
> +		pte = __ptep_get(ptep);
> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +EXPORT_SYMBOL(contpte_ptep_get);
> +
> +pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
> +{
> +	/*
> +	 * Gather access/dirty bits, which may be populated in any of the ptes
> +	 * of the contig range. We may not be holding the PTL, so any contiguous
> +	 * range may be unfolded/modified/refolded under our feet. Therefore we
> +	 * ensure we read a _consistent_ contpte range by checking that all ptes
> +	 * in the range are valid and have CONT_PTE set, that all pfns are
> +	 * contiguous and that all pgprots are the same (ignoring access/dirty).
> +	 * If we find a pte that is not consistent, then we must be racing with
> +	 * an update so start again. If the target pte does not have CONT_PTE
> +	 * set then that is considered consistent on its own because it is not
> +	 * part of a contpte range.
> +	 */
> +
> +	pte_t orig_pte;
> +	pgprot_t orig_prot;
> +	pte_t *ptep;
> +	unsigned long pfn;
> +	pte_t pte;
> +	pgprot_t prot;
> +	int i;
> +
> +retry:
> +	orig_pte = __ptep_get(orig_ptep);
> +
> +	if (!pte_valid_cont(orig_pte))
> +		return orig_pte;
> +
> +	orig_prot = pte_pgprot(pte_mkold(pte_mkclean(orig_pte)));
> +	ptep = contpte_align_down(orig_ptep);
> +	pfn = pte_pfn(orig_pte) - (orig_ptep - ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
> +		pte = __ptep_get(ptep);
> +		prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
> +
> +		if (!pte_valid_cont(pte) ||
> +		   pte_pfn(pte) != pfn ||
> +		   pgprot_val(prot) != pgprot_val(orig_prot))
> +			goto retry;
> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +EXPORT_SYMBOL(contpte_ptep_get_lockless);
> +
> +void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
> +					pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	unsigned long next;
> +	unsigned long end = addr + (nr << PAGE_SHIFT);
> +	unsigned long pfn = pte_pfn(pte);
> +	pgprot_t prot = pte_pgprot(pte);
> +	pte_t orig_pte;
> +
> +	do {
> +		next = pte_cont_addr_end(addr, end);
> +		nr = (next - addr) >> PAGE_SHIFT;
> +		pte = pfn_pte(pfn, prot);
> +
> +		if (((addr | next | (pfn << PAGE_SHIFT)) & ~CONT_PTE_MASK) == 0)
> +			pte = pte_mkcont(pte);
> +		else
> +			pte = pte_mknoncont(pte);
> +
> +		/*
> +		 * If operating on a partial contiguous range then we must first
> +		 * unfold the contiguous range if it was previously folded.
> +		 * Otherwise we could end up with overlapping tlb entries.
> +		 */
> +		if (nr != CONT_PTES)
> +			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +
> +		/*
> +		 * If we are replacing ptes that were contiguous or if the new
> +		 * ptes are contiguous and any of the ptes being replaced are
> +		 * valid, we need to clear and flush the range to prevent
> +		 * overlapping tlb entries.
> +		 */
> +		orig_pte = __ptep_get(ptep);
> +		if (pte_valid_cont(orig_pte) ||
> +		    (pte_cont(pte) && ptep_any_valid(ptep, nr)))
> +			ptep_clear_flush_range(mm, addr, ptep, nr);
> +
> +		__set_ptes(mm, addr, ptep, pte, nr);
> +
> +		addr = next;
> +		ptep += nr;
> +		pfn += nr;
> +
> +	} while (addr != end);
> +}
> +EXPORT_SYMBOL(contpte_set_ptes);
> +
> +int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
> +					unsigned long addr, pte_t *ptep)
> +{
> +	/*
> +	 * ptep_clear_flush_young() technically requires us to clear the access
> +	 * flag for a _single_ pte. However, the core-mm code actually tracks
> +	 * access/dirty per folio, not per page. And since we only create a
> +	 * contig range when the range is covered by a single folio, we can get
> +	 * away with clearing young for the whole contig range here, so we avoid
> +	 * having to unfold.
> +	 */
> +
> +	int i;
> +	int young = 0;
> +
> +	ptep = contpte_align_down(ptep);
> +	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> +		young |= __ptep_test_and_clear_young(vma, addr, ptep);
> +
> +	return young;
> +}
> +EXPORT_SYMBOL(contpte_ptep_test_and_clear_young);
> +
> +int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> +					unsigned long addr, pte_t *ptep)
> +{
> +	int young;
> +
> +	young = contpte_ptep_test_and_clear_young(vma, addr, ptep);
> +
> +	if (young) {
> +		/*
> +		 * See comment in __ptep_clear_flush_young(); same rationale for
> +		 * eliding the trailing DSB applies here.
> +		 */
> +		addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +		__flush_tlb_range_nosync(vma, addr, addr + CONT_PTE_SIZE,
> +					 PAGE_SIZE, true, 3);
> +	}
> +
> +	return young;
> +}
> +EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
> +
> +int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> +					unsigned long addr, pte_t *ptep,
> +					pte_t entry, int dirty)
> +{
> +	pte_t orig_pte;
> +	int i;
> +	unsigned long start_addr;
> +
> +	/*
> +	 * Gather the access/dirty bits for the contiguous range. If nothing has
> +	 * changed, its a noop.
> +	 */
> +	orig_pte = ptep_get(ptep);
> +	if (pte_val(orig_pte) == pte_val(entry))
> +		return 0;
> +
> +	/*
> +	 * We can fix up access/dirty bits without having to unfold/fold the
> +	 * contig range. But if the write bit is changing, we need to go through
> +	 * the full unfold/fold cycle.
> +	 */
> +	if (pte_write(orig_pte) == pte_write(entry)) {
> +		/*
> +		 * For HW access management, we technically only need to update
> +		 * the flag on a single pte in the range. But for SW access
> +		 * management, we need to update all the ptes to prevent extra
> +		 * faults. Avoid per-page tlb flush in __ptep_set_access_flags()
> +		 * and instead flush the whole range at the end.
> +		 */
> +		ptep = contpte_align_down(ptep);
> +		start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +
> +		for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> +			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
> +
> +		if (dirty)
> +			__flush_tlb_range(vma, start_addr, addr,
> +							PAGE_SIZE, true, 3);
> +	} else {
> +		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
> +		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
> +		contpte_try_fold(vma->vm_mm, addr, ptep, entry);
> +	}
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(contpte_ptep_set_access_flags);

