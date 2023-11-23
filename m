Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99DE7F5765
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKWE21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKWE2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:28:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2911F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcnKDMCJtQYDQ5SgGTTgR3PRqzCaZtlGEyGQNWfnG8/SNwVipWOXr+HhS6NMDRfIziF3aN5ZBh27HxzsXRFGM1EeXC34KSoCre4gLwx3d4XOtHYOV84f+oKATEDIlc5Mo90TNm6dWMs5Aa9lJ5T7D8XKidQk1Fto1B6lL4WRB7BkqHmQovr/AH3Q0G5dcAOaMV/X3lKJmNc2N2L+ODEPTPkS3XXQazFhduDHm9Gqmp0BSdlY3EUMe9uUqEEZGWMO/eqeCrSqbQEbY4YavJOZEdTVU0hVLz0fx6ytiKKKjhYeuZlmVN+0XEoXWFeZnSBx9eWWGqiPFqXCCZeh5csMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLnZ7inFeUIrHRpT2D1Txu4VdkRBY2Xvlzl4vcKaqWQ=;
 b=m7KBCA3G0Kbf+uu9MeV68ZUVsm7HVB4lESAHaBWZbI8vcVpZ2mRAOUvQ9JsaKga8T4mU1gDUmpOXFM1RXpD+gkS7nZzdcAqIhWfEaP7cmMvQSzHuwCiQWsUJUZztQ9kcWJYmHyqqutwgmt/Ae78Zbg8iQPAjmpMZL/IBRqbx9NO2aur2x+Ymz9QIeiTkwWNaqYNi3vTB7Yrbb8P+1cPKDBZOnS+Bmyz7MBEaPKu1uhsUKqz9ubPBgoXDEYy1c/CBhY8b/OAFy2QegKiphCzJUdJwOoj1I3U4h7Fn0Yn2yVdGY4o8RYClSG0WCKTbzdkLTvzRi+w7sBnDx2kQiNQi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLnZ7inFeUIrHRpT2D1Txu4VdkRBY2Xvlzl4vcKaqWQ=;
 b=RzdU1P6GDDB/TSSpEkblrt3AHFxuUx98VSMWi9wo/vaO+gRm3hNiMvmHc0rabbhBNM/N6XqYZ5So5OXSAkeY6zA/nGNwAqzVBj+FAk+1Wvw5JQ4SNzYjX5CRtRbfDZyYi2jGSniihHn7xQQJEGstQtBRnjcJ1ORVPdO+vYqeiOD96cnGzj9GnPbdZn/8foOKZSpkW+BWbMZGv/5PTPW5EiKsRM+I/QGHASMAqyhcKB5VzkIwDQpwFxz7A4nc6H8nEtxUnRGWkT7wgOSqxf9tfC+K4/zhgWQRjpwBdnYIcJSf04AApabrdwP0gVsbQf5T2Uu7q2VKDkm/S/Q8IyjlMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 04:28:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 04:28:25 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
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
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Date:   Thu, 23 Nov 2023 15:26:59 +1100
In-reply-to: <20231115163018.1303287-2-ryan.roberts@arm.com>
Message-ID: <87jzq9xfdo.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0095.ausprd01.prod.outlook.com
 (2603:10c6:10:111::10) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec4d94c-a03e-470c-4c3c-08dbebdca1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlX3dYIeli4mnC9Z6s1CyZGssc81foln1ii6x4QYHoD111K9opMU6Z7ZLQc9vferFuZagi/izFSc1kJRXqgSBs4GGdY1sslOXIorauuiPEu86sl2FQ/nOSSsv0DgXO61aEPnkySsJ8HTWUUtvQLp1+CrUtIpv7cWEJF40sjyDJIsfnWD7zoP3zTPuV4m6Jjs0a6fnRK3dMkBtbsr+YrkzOC3qrumogvEcbKrtq6Jwio1P1y3h94X23cdCrd8HDWzKX8UftkiFvOsdFEQqVa07BfszPkoMIFXdnBeGrV4PVsBLdEqP1PkLXZ7IvJSZ58b0UP5S3tsd3XKDFqqPnGYMvcecFk/Uvzvw0qblpQoWx8I2RBa7czcnipUgVdWlO28opz00r1/tectkZDPfNqFsp3E/8kdClffXv6qBKYdtgwz+P+eI+OZr2/uUJl1MG+UiNlCZV7RlmaV/XaE1DLWLOXGTSkizuleLP3Y/cVyD5/fz0J3ILBCl5u9QEAoNgBU8kkrff4iGhT2BBq155i4qdim1i4yd+LidLbi2Y7FUv+GqE1sIpIc9MiyK3CQnrku
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(83380400001)(6666004)(6512007)(9686003)(6506007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(30864003)(6486002)(478600001)(316002)(6916009)(54906003)(66556008)(66476007)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lfu4kb9yy1NNnyypPyR67WZLlNNLBKu/QXaMo6B+D9UNHsyfSaWFFyWcC3+G?=
 =?us-ascii?Q?d9TmVsEFhPCcnR6lT2NaSekPSddfPDPtxVxpFjb8IHtoMtLBmGkuUGZz99Vv?=
 =?us-ascii?Q?UwcyhThF6gd3BsJbg/N68mz3Mqq5DAXra+IFU6f0a8gcI+LpCBlojwMavYhK?=
 =?us-ascii?Q?7Z/1CUWIAe4r7uCZqdW8ntXo9shjfaGOknhrciMjsbrqdyrm2bWmE9zvBlZ7?=
 =?us-ascii?Q?gDVIZkcEHjkOoRaqf9rG1Ii8JcQICNqyl2hoqk7kzQ/UAySNDT1HlJOC8jxR?=
 =?us-ascii?Q?oUIQ/JIFJJVHkTDaupjolHiw5PJzt8qDRI7aP1bma8iRJuJ392BBjFdMBGMr?=
 =?us-ascii?Q?93hLZffKprsIJKmWYbNUf6eE/wWARHZoUbcoRbsMaTHYMy5482x905nYKgeV?=
 =?us-ascii?Q?pRF3+LmZUMsTldY3YL6g+cZ9n6r5m0v1d28hT4EqvB6Mauw1npEwqw96Jmnu?=
 =?us-ascii?Q?V4E0rwFJrtReilrl6EsSNHTkNvZVbTSXPgeeYFDMItsZiKga9CTJZq+OcD3Z?=
 =?us-ascii?Q?7DRIEj/23agem37XRW/4N2ob8tsvNWcwDvYiOKtSrX7Gg0nP7ZhzxhxCjtmt?=
 =?us-ascii?Q?3Blo+zxcgJPuabd4anj0Mrkf44fL3ZmnQ45gm3aw30M7DVifj50cp9wEUXA7?=
 =?us-ascii?Q?Cx63ACQPFOXaAQvejx72dlOZfyyy5R9JdoFDfd2BOF1QG4cuIMEnCzN7nStM?=
 =?us-ascii?Q?1Dzfrqa34esMJiRmiCy3u1E7LuW750Mb81nS6Oj3egwGYQDN1OXYw0c5wf46?=
 =?us-ascii?Q?2EqKVgY7i1C54jeKGjlKUnT1+nD8ihrFZvr7jzIzgtI5Rn2sPLDv2WSQ++2m?=
 =?us-ascii?Q?kSwRrQ7LAucRWwWLDto1YvDB85wkeW5V+H5S1m/jzXVW+xvet2RNz4WjsjiA?=
 =?us-ascii?Q?Jk/lpulu1mj6Em2wROP6ndImusZPyGJ5ww0PjGcymeV7UbnIYJSC+0OOta51?=
 =?us-ascii?Q?msCuhHibaR38ObeOZGp01exC1dDhq9a9l0MBCzBRtISgDBcHlfZ+UpUu6pV9?=
 =?us-ascii?Q?Z8nhDEk6oX/ajX0Gl48UWVKgvgAl8yIYcaKzYTa0r8rMS2UKPl4Jzjg/Y0mF?=
 =?us-ascii?Q?k5628cdaMrKHxxkHlccD+MQg5fH1NPvczPP/I9v47/tLIfDOt0jnjzXoYyuM?=
 =?us-ascii?Q?frk1YPRdje99qUD/sntzxRHhI1XvklEYizsSrfGqIhpdAkOtsUEXS8EyG43V?=
 =?us-ascii?Q?e40CPaXAYSU0see4sk6TTDWJLynvgruxD2PY4v08BrDlx5LMsT/H+Lcebu3V?=
 =?us-ascii?Q?R/lS/inwvT0sKHf2vXB6GHX1qRgJ0sdzbxceprXl5wXWyZoa0E7uhGq1VT7x?=
 =?us-ascii?Q?ayyfUzjkldAYHjrfaLR5c0UOCDUkPWYDJnSva1mEq4LnnXpEurDqo+9KDDGn?=
 =?us-ascii?Q?FkqihWpATL22dkqYixmxrz1UooM5gcjqaHMyMxarLZ9k9EjiDEYmTUYMv6ov?=
 =?us-ascii?Q?mo6iCrPbDVKafuTC0lHrZIrAobralHM43xEgs67d5DDa0am/2cTmfIUaL0z2?=
 =?us-ascii?Q?Sg/ok303KQreZ2CJEmo9RtjJ1L03YVW9E/WzjXSCWBaoZsp79AGoudccTHV/?=
 =?us-ascii?Q?bv3l38mn8TInxQ1sW97uAj8noMTzTDuS2ceFGkZ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec4d94c-a03e-470c-4c3c-08dbebdca1e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 04:28:25.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y96PzQGQxBBbdPiPu+5qHC2N84lbk8CP5gqqf11LYZtRgzV4tzY3aK4mTWOnjS1xPeYOc79B26cItWOBkDz/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
> maps a physically contiguous block of memory, all belonging to the same
> folio, with the same permissions, and for shared mappings, the same
> dirty state. This will likely improve performance by a tiny amount due
> to batching the folio reference count management and calling set_ptes()
> rather than making individual calls to set_pte_at().
>
> However, the primary motivation for this change is to reduce the number
> of tlb maintenance operations that the arm64 backend has to perform
> during fork, as it is about to add transparent support for the
> "contiguous bit" in its ptes. By write-protecting the parent using the
> new ptep_set_wrprotects() (note the 's' at the end) function, the
> backend can avoid having to unfold contig ranges of PTEs, which is
> expensive, when all ptes in the range are being write-protected.
> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
> in the child, the backend does not need to fold a contiguous range once
> they are all populated - they can be initially populated as a contiguous
> range in the first place.
>
> This change addresses the core-mm refactoring only, and introduces
> ptep_set_wrprotects() with a default implementation that calls
> ptep_set_wrprotect() for each pte in the range. A separate change will
> implement ptep_set_wrprotects() in the arm64 backend to realize the
> performance improvement as part of the work to enable contpte mappings.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h |  13 +++
>  mm/memory.c             | 175 +++++++++++++++++++++++++++++++---------
>  2 files changed, 150 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..1c50f8a0fdde 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>  }
>  #endif
>  
> +#ifndef ptep_set_wrprotects
> +struct mm_struct;
> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
> +				unsigned long address, pte_t *ptep,
> +				unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
> +		ptep_set_wrprotect(mm, address, ptep);
> +}
> +#endif
> +
>  /*
>   * On some architectures hardware does not set page access bit when accessing
>   * memory page, it is responsibility of software setting this bit. It brings
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a5497..b7c8228883cf 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -921,46 +921,129 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  		/* Uffd-wp needs to be delivered to dest pte as well */
>  		pte = pte_mkuffd_wp(pte);
>  	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> -	return 0;
> +	return 1;

We should update the function comment to indicate why we return 1 here
because it will become non-obvious in future. But perhaps it's better to
leave this as is and do the error check/return code calculation in
copy_present_ptes().

> +}
> +
> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
> +				struct page *anchor, unsigned long anchor_vaddr)

It's likely I'm easily confused but the arguments here don't make much
sense to me. Something like this (noting that I've switch the argument
order) makes more sense to me at least:

static inline unsigned long page_cont_mapped_vaddr(struct page *page,
                            unsigned long page_vaddr, struct page *next_folio_page)

> +{
> +	unsigned long offset;
> +	unsigned long vaddr;
> +
> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;

Which IMHO makes this much more readable:

	offset = (page_to_pfn(next_folio_page) - page_to_pfn(page)) << PAGE_SHIFT;

> +	vaddr = anchor_vaddr + offset;
> +
> +	if (anchor > page) {

And also highlights that I think this condition (page > folio_page_end)
is impossible to hit. Which is good ...

> +		if (vaddr > anchor_vaddr)
> +			return 0;

... because I'm not sure returning 0 is valid as we would end up setting
floops = (0 - addr) >> PAGE_SHIFT which doesn't seem like it would end
particularly well :-)

> +	} else {
> +		if (vaddr < anchor_vaddr)

Same here - isn't the vaddr of the next folio always going to be larger
than the vaddr for the current page? It seems this function is really
just calculating the virtual address of the next folio, or am I deeply
confused?

> +			return ULONG_MAX;
> +	}
> +
> +	return vaddr;
> +}
> +
> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> +				      struct page *page, pte_t *pte,
> +				      unsigned long addr, unsigned long end,
> +				      pte_t ptent, bool *any_dirty)
> +{
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +	pgprot_t prot;
> +	struct page *folio_end;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	folio_end = &folio->page + folio_nr_pages(folio);

I think you can replace this with:

folio_end = folio_next(folio)

Although given this is only passed to page_cont_mapped_vaddr() perhaps
it's better to just pass the folio in and do the calculation there.

> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	pfn = page_to_pfn(page);
> +	prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
> +
> +	*any_dirty = pte_dirty(ptent);
> +
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +		ptent = pte_mkold(pte_mkclean(ptent));
> +
> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
> +		    pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
> +			break;
> +
> +		if (pte_dirty(ptent))
> +			*any_dirty = true;
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return i;
>  }
>  
>  /*
> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
> - * is required to copy this pte.
> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
> + * first pte.
>   */
>  static inline int
> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> -		 struct folio **prealloc)
> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +		  pte_t *dst_pte, pte_t *src_pte,
> +		  unsigned long addr, unsigned long end,
> +		  int *rss, struct folio **prealloc)
>  {
>  	struct mm_struct *src_mm = src_vma->vm_mm;
>  	unsigned long vm_flags = src_vma->vm_flags;
>  	pte_t pte = ptep_get(src_pte);
>  	struct page *page;
>  	struct folio *folio;
> +	int nr = 1;
> +	bool anon;
> +	bool any_dirty = pte_dirty(pte);
> +	int i;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
> -	if (page)
> +	if (page) {
>  		folio = page_folio(page);
> -	if (page && folio_test_anon(folio)) {
> -		/*
> -		 * If this page may have been pinned by the parent process,
> -		 * copy the page immediately for the child so that we'll always
> -		 * guarantee the pinned page won't be randomly replaced in the
> -		 * future.
> -		 */
> -		folio_get(folio);
> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
> -			/* Page may be pinned, we have to copy. */
> -			folio_put(folio);
> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -						 addr, rss, prealloc, page);
> +		anon = folio_test_anon(folio);
> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
> +						end, pte, &any_dirty);
> +
> +		for (i = 0; i < nr; i++, page++) {
> +			if (anon) {
> +				/*
> +				 * If this page may have been pinned by the
> +				 * parent process, copy the page immediately for
> +				 * the child so that we'll always guarantee the
> +				 * pinned page won't be randomly replaced in the
> +				 * future.
> +				 */
> +				if (unlikely(page_try_dup_anon_rmap(
> +						page, false, src_vma))) {
> +					if (i != 0)
> +						break;
> +					/* Page may be pinned, we have to copy. */
> +					return copy_present_page(
> +						dst_vma, src_vma, dst_pte,
> +						src_pte, addr, rss, prealloc,
> +						page);
> +				}
> +				rss[MM_ANONPAGES]++;
> +				VM_BUG_ON(PageAnonExclusive(page));
> +			} else {
> +				page_dup_file_rmap(page, false);
> +				rss[mm_counter_file(page)]++;
> +			}
>  		}
> -		rss[MM_ANONPAGES]++;
> -	} else if (page) {
> -		folio_get(folio);
> -		page_dup_file_rmap(page, false);
> -		rss[mm_counter_file(page)]++;
> +
> +		nr = i;
> +		folio_ref_add(folio, nr);
>  	}
>  
>  	/*
> @@ -968,24 +1051,28 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	 * in the parent and the child
>  	 */
>  	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> -		ptep_set_wrprotect(src_mm, addr, src_pte);
> +		ptep_set_wrprotects(src_mm, addr, src_pte, nr);
>  		pte = pte_wrprotect(pte);
>  	}
> -	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
>  
>  	/*
> -	 * If it's a shared mapping, mark it clean in
> -	 * the child
> +	 * If it's a shared mapping, mark it clean in the child. If its a
> +	 * private mapping, mark it dirty in the child if _any_ of the parent
> +	 * mappings in the block were marked dirty. The contiguous block of
> +	 * mappings are all backed by the same folio, so if any are dirty then
> +	 * the whole folio is dirty. This allows us to determine the batch size
> +	 * without having to ever consider the dirty bit. See
> +	 * folio_nr_pages_cont_mapped().
>  	 */
> -	if (vm_flags & VM_SHARED)
> -		pte = pte_mkclean(pte);
> -	pte = pte_mkold(pte);
> +	pte = pte_mkold(pte_mkclean(pte));
> +	if (!(vm_flags & VM_SHARED) && any_dirty)
> +		pte = pte_mkdirty(pte);
>  
>  	if (!userfaultfd_wp(dst_vma))
>  		pte = pte_clear_uffd_wp(pte);
>  
> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> -	return 0;
> +	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> +	return nr;
>  }
>  
>  static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
> @@ -1087,15 +1174,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			 */
>  			WARN_ON_ONCE(ret != -ENOENT);
>  		}
> -		/* copy_present_pte() will clear `*prealloc' if consumed */
> -		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       addr, rss, &prealloc);
> +		/* copy_present_ptes() will clear `*prealloc' if consumed */
> +		ret = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
> +				       addr, end, rss, &prealloc);
> +
>  		/*
>  		 * If we need a pre-allocated page for this pte, drop the
>  		 * locks, allocate, and try again.
>  		 */
>  		if (unlikely(ret == -EAGAIN))
>  			break;
> +
> +		/*
> +		 * Positive return value is the number of ptes copied.
> +		 */
> +		VM_WARN_ON_ONCE(ret < 1);
> +		progress += 8 * ret;
> +		ret--;

Took me a second to figure out what was going on here. I think it would
be clearer to rename ret to nr_ptes ...

> +		dst_pte += ret;
> +		src_pte += ret;
> +		addr += ret << PAGE_SHIFT;
> +		ret = 0;
> +
>  		if (unlikely(prealloc)) {
>  			/*
>  			 * pre-alloc page cannot be reused by next time so as
> @@ -1106,7 +1206,6 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			folio_put(prealloc);
>  			prealloc = NULL;
>  		}
> -		progress += 8;
>  	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);

... and do dst_pte += nr_ptes, etc. here instead (noting of course that
the continue clauses will need nr_ptes == 1, but perhpas reset that at
the start of the loop).

>  	arch_leave_lazy_mmu_mode();

