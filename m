Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE17568D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGQQPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGQQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:15:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7310D7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkqb/J1KWh3vF0/unD1gPFY/Z0xPgxbTNFP1dpK7ivUgM7tRoRW/DNopN+q7wQJtykWT8B4LOUWFtQ60jCnH/Uy2h5FJznzeZgUcZQX+B4bWpAhMnyapr4LLd9Fq6x5VtP8t9a/S5Rr3mYjpQ3FuxcxsH1UZvhrRyZa6jb39sLhr8GzabxDJmrKUjtzXnNyOrXU43PKc9JZ2uzgb8zjMu2UDtTnNFS1lO4prD7iX7YzqirCMJWpryy8bIeydZ3T4b5jpz4x027LoroWj5FenVCptGSnYEC8HVtzo4g1j4BTNsrc6xEh3c/EX8EFfNnWGTicYdQY/c/TwROjrbIyprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lB7gqRiGDi1VrUdx2XW7FCMIEw7vsUlRdH7CzC9cl4=;
 b=R7tog3yyWm627ep799XAhq9d4ZUsrmJOE6OHNiIqS3YiXDsq/OcxH59h5n7wThH07NaRi4saqQpOyNRaeTW/hbgKTNw+gBdt3/WrzAOr2XO6on3jAuMDIhnegWVypYJ8lQ2QESpTwpQds190svEGpei30fw0rd5Un8aztw5kOBCtIpnG54r7dWDB6LBpl/tEWQ3w6l9W6xmNjnUOby2aB6SJrDyQmKyP0VYVDIBeETl83JPGDdW5c6T1Ep6zb8ix0RnydUTKbpJNaMXDsX+gg3hVVJ/2enGTj5adYAO0EbP8H7eZKfqwJYi2NFj2nuE8U3OsP5YxBFWlB5nsmY9+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lB7gqRiGDi1VrUdx2XW7FCMIEw7vsUlRdH7CzC9cl4=;
 b=hn/wrEdW+cltSiEmim79QFJuf2BQp3AHbAjFwUkkgRBJcYBUrVYNwST+GSOuzPDvWYBsAq23sBofQMz424ySvi13/1nIt1h41B7aIZKgvfwU13VAbRiMul+d8XRims4b60wzjEJUOw+TiQgRum08Tw+6bnnf022YlMjxcen8BXx4eM3RhD4S9gEaWTjx4Hh6iuXvyLu32tf4qFYmyCxa13xMw42TDWmptp/aP3NuAI9DkAP/PfMWNgXFCJbpVx2PDur055xH2fsXC/KVC5kzscAt32n9lKI3gAOMtrH/IEeNaQf2MJU7aWPv667VQB+bEhAyHktPpSxmfdScKf5lfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Mon, 17 Jul 2023 16:15:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:15:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 3/3] mm: Batch-zap large anonymous folio PTE mappings
Date:   Mon, 17 Jul 2023 12:15:27 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <C8DCA632-EA87-4CC1-A740-F26E49F67649@nvidia.com>
In-Reply-To: <980c4e1f-116b-0113-65ee-4e77fdd3e7b4@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-4-ryan.roberts@arm.com>
 <5A282984-F3AD-41E3-8EF2-BA0A77DD1A3A@nvidia.com>
 <980c4e1f-116b-0113-65ee-4e77fdd3e7b4@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2C76F03F-DF26-4035-AAB9-1F048E9622E6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caab25a-88e3-4b0d-074b-08db86e109cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeS0AeroZ29GMQSaIhQtb3pcVIfCUQEujm9gv9ckUfgZi3brbdFIyQyH0fbMrc4rSP2CQSH0AlhtMOxGUJg4UutF/amC2YwA/zFFwAzcUywgsCkLEx5TnooHOJCQoMNuR/IyxFGhbbWtJkrYX06LgDyGl17r01luDZll/+4C5DbrqTMtwmyMYOcK4JdGmveYPFXdOzapaxgeWoicHFQKTKjSwl3fRl/FvaHJEWfPLZ/dDZKY6i+tVe7Drke4mXcn/tqMBuBpxGJQp1jMAzv4olgSMZ+gj9cNaEwtoJCJi/wp5JyBpWIjrIMsVdWADe/sj06yYyVr9gLzfZgruZImBoACmqtUvT9zNy93L8A7taCUBXkGnHUQL3zm6LOL7ZuNiz2lx3lvHCBle7MW3pPcYXXzaudmQhb5bMCoBNEFj9Oo2SdKUj7zPz6eFI4t4yrD6BBFKHfky6QThtRx8qWHOpTvA8ZFQNWSEV9Wl1xD+0RJj2Ae+Dudwt+qJcuv34JAipU+cRGtGHaREN/1JGBka095Scev8TQu8a8Wwa5szVBnJpHckn/QiTvkeqYpAVHvbq00LQA/dA0AD0RE50gO+ng7JQTB5ncMw6xW+NF126yRcwEfD2Xyb2cirjLeM3wi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(478600001)(6486002)(54906003)(2616005)(83380400001)(33656002)(86362001)(36756003)(2906002)(186003)(53546011)(6506007)(6512007)(26005)(38100700002)(4326008)(66556008)(66476007)(66946007)(6916009)(41300700001)(316002)(8676002)(5660300002)(7416002)(8936002)(235185007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zogXINuAYRfNAQe5l50P4qOAUMQqkSE6gTwrQ+sRsNOoN2FrL9TV7spRTMx1?=
 =?us-ascii?Q?g43R8I+IIHJcYEPz2mzLzYri9KfZdLrvAp1lAIUjODPhIONVvtOJIcpFRYmy?=
 =?us-ascii?Q?bcGi6ZwN+9yu/cbTAgKL7Kh/0g+LfnxQpcLJb/XgwKk0WCLNxEj1YZCrqEAI?=
 =?us-ascii?Q?y4fwbRqXFksxgPLtqAUxkFMNybTDXzYdPobL5PXLnhld5RQNZ/qb3ZhRXNpw?=
 =?us-ascii?Q?64rD1iSwOTgrVOINopkXoQLs3r+oMdDs7Zm8iHuMCDPpibsdB9OcW/Xcnjey?=
 =?us-ascii?Q?BFxDqkZkRbIjLWm2jnkdqFRQvzD6MjgCQ+as57QKTzTR/T2zovELs7rObOk9?=
 =?us-ascii?Q?zOOVQ696BL/eXKWoNxKptr1cSsp5g7GTdbZHNgXs+d/68+c+xnneSmbj4422?=
 =?us-ascii?Q?DkO8WMHg/zPuq4CAU1b/+hA4dLcO6zbaR6nnI6jxXUkPaMvlScicP5CT78x7?=
 =?us-ascii?Q?JljJ7w1aLyw+ZdWu2WGchn+jZgcfQFFRFnOk0tyOj/9OzMnf66v573R903C6?=
 =?us-ascii?Q?PN19m1cSX1doa9ro8v6P6C+R/NPbF0TMB4XeOl0j3XFMIrvJvNHcPPB/llCG?=
 =?us-ascii?Q?PPV3Wefm3Lu+05Z2woXlsn/VFuLNap/R69sF4qOBx3V3LXRruS09oiwFS6mL?=
 =?us-ascii?Q?1C5W1PY+WObHfrAMCtRk7S6Mykr43xyCCuspSySFjxfRVeKbSgMESe33x4II?=
 =?us-ascii?Q?/jRVRxGu478LT7HogMLv7b+es3ES886hFZPQoZeCb+bd0TvrkmrrqK1gWwTt?=
 =?us-ascii?Q?K9j0pETICyRQToq/P1yeCIM9iF0H/B9614j6Gp58WksqZaozGvxZtSKQ50Iv?=
 =?us-ascii?Q?0KqirlSrsx6zbbzbC4S6Y4yejTeEWoKk9FA3720WJRMGkiEfJRP219h+Nf18?=
 =?us-ascii?Q?azGrjlkYnM/5gYqdP+zkOxjy004EcmWA4bYo21+BV53bHSVoOdW+OKNj4VUO?=
 =?us-ascii?Q?Xnq8pmN304/kR61z2yVt3fXELQ5AHpyi0B+8Bo8+P1EEpgmMfDyNvsaolypZ?=
 =?us-ascii?Q?Ho8naCLHsT5gsiwnL8JYJng/NyPJmiKxSGWYGGzhQJxvF7cMWhNeX4zazMI9?=
 =?us-ascii?Q?DUHTKNLKNTkeB5xsRdEXr4DwOY68A1U5aTzP35tf8Tqqa+oUT97UCCSIOVV9?=
 =?us-ascii?Q?0VfxdETXvs+Y7XSC/vPvN8ZRDuktqqgWPakXpAw2V22pyCe/vGLYMG83JqJW?=
 =?us-ascii?Q?zEQ7lJ5qUEBjQlbaQaHuq0bStH7hVzaFjigqG+onobSWbXbW38C3tQognCy9?=
 =?us-ascii?Q?gh8gN+wdUYvlgrQG15SZJt5PFtzUN0W66MLlfiTISO4EPe5R+GnEsriAoFKd?=
 =?us-ascii?Q?lksIR/HB1wkFhmqvTDiZfbJFt2cEwxYQLPFsSTWPpZYg72e86KTTzsCLZe+P?=
 =?us-ascii?Q?I8z8sAihTJZpnzZN6ubTflFvQ9jWK0shvAAH5BDCrcVVPMtQei+vG6zQ7aOC?=
 =?us-ascii?Q?Vw4EMOKEiqHE60B9kw4t2vtJAdgxJE4S3oVsGUX+hUiqWCt6yBLFki2PAv7Y?=
 =?us-ascii?Q?aczvZ5DgUMPXXAN7fsZD9BozUsQHu/MLvrfXULaMjQIaFUoL97xCODXAi9D6?=
 =?us-ascii?Q?VP2vsm9T+beR/Xddrn3Y5C7EtJ7n7fXli8SV/Pqf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caab25a-88e3-4b0d-074b-08db86e109cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:15:29.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCHuGUo+gPZc3musEImGV5gfwMeJHsQ25lXC6FTzitMwBaStrPdtLUr876e8EXkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2C76F03F-DF26-4035-AAB9-1F048E9622E6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Jul 2023, at 11:55, Ryan Roberts wrote:

> On 17/07/2023 16:25, Zi Yan wrote:
>> On 17 Jul 2023, at 10:31, Ryan Roberts wrote:
>>
>>> This allows batching the rmap removal with folio_remove_rmap_range(),=

>>> which means we avoid spuriously adding a partially unmapped folio to =
the
>>> deferrred split queue in the common case, which reduces split queue l=
ock
>>> contention.
>>>
>>> Previously each page was removed from the rmap individually with
>>> page_remove_rmap(). If the first page belonged to a large folio, this=

>>> would cause page_remove_rmap() to conclude that the folio was now
>>> partially mapped and add the folio to the deferred split queue. But
>>> subsequent calls would cause the folio to become fully unmapped, mean=
ing
>>> there is no value to adding it to the split queue.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>>  1 file changed, 119 insertions(+)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 01f39e8144ef..6facb8c8807a 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1391,6 +1391,95 @@ zap_install_uffd_wp_if_needed(struct vm_area_s=
truct *vma,
>>>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>>  }
>>>
>>> +static inline unsigned long page_addr(struct page *page,
>>> +				struct page *anchor, unsigned long anchor_addr)
>>> +{
>>> +	unsigned long offset;
>>> +	unsigned long addr;
>>> +
>>> +	offset =3D (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;=

>>> +	addr =3D anchor_addr + offset;
>>> +
>>> +	if (anchor > page) {
>>> +		if (addr > anchor_addr)
>>> +			return 0;
>>> +	} else {
>>> +		if (addr < anchor_addr)
>>> +			return ULONG_MAX;
>>> +	}
>>> +
>>> +	return addr;
>>> +}
>>> +
>>> +static int calc_anon_folio_map_pgcount(struct folio *folio,
>>> +				       struct page *page, pte_t *pte,
>>> +				       unsigned long addr, unsigned long end)
>>> +{
>>> +	pte_t ptent;
>>> +	int floops;
>>> +	int i;
>>> +	unsigned long pfn;
>>> +
>>> +	end =3D min(page_addr(&folio->page + folio_nr_pages(folio), page, a=
ddr),
>>> +		  end);
>>> +	floops =3D (end - addr) >> PAGE_SHIFT;
>>> +	pfn =3D page_to_pfn(page);
>>> +	pfn++;
>>> +	pte++;
>>> +
>>> +	for (i =3D 1; i < floops; i++) {
>>> +		ptent =3D ptep_get(pte);
>>> +
>>> +		if (!pte_present(ptent) ||
>>> +		    pte_pfn(ptent) !=3D pfn) {
>>> +			return i;
>>> +		}
>>> +
>>> +		pfn++;
>>> +		pte++;
>>> +	}
>>> +
>>> +	return floops;
>>> +}
>>> +
>>> +static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
>>> +					struct vm_area_struct *vma,
>>> +					struct page *page, pte_t *pte,
>>> +					unsigned long addr, unsigned long end,
>>> +					bool *full_out)
>>> +{
>>> +	struct folio *folio =3D page_folio(page);
>>> +	struct mm_struct *mm =3D tlb->mm;
>>> +	pte_t ptent;
>>> +	int pgcount;
>>> +	int i;
>>> +	bool full;
>>> +
>>> +	pgcount =3D calc_anon_folio_map_pgcount(folio, page, pte, addr, end=
);
>>> +
>>> +	for (i =3D 0; i < pgcount;) {
>>> +		ptent =3D ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>> +		tlb_remove_tlb_entry(tlb, pte, addr);
>>> +		full =3D __tlb_remove_page(tlb, page, 0);
>>> +
>>> +		if (unlikely(page_mapcount(page) < 1))
>>> +			print_bad_pte(vma, addr, ptent, page);
>>> +
>>> +		i++;
>>> +		page++;
>>> +		pte++;
>>> +		addr +=3D PAGE_SIZE;
>>> +
>>> +		if (unlikely(full))
>>> +			break;
>>> +	}
>>> +
>>> +	folio_remove_rmap_range(folio, page - i, i, vma);
>>> +
>>> +	*full_out =3D full;
>>> +	return i;
>>> +}
>>> +
>>>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>  				struct vm_area_struct *vma, pmd_t *pmd,
>>>  				unsigned long addr, unsigned long end,
>>> @@ -1428,6 +1517,36 @@ static unsigned long zap_pte_range(struct mmu_=
gather *tlb,
>>>  			page =3D vm_normal_page(vma, addr, ptent);
>>>  			if (unlikely(!should_zap_page(details, page)))
>>>  				continue;
>>> +
>>> +			/*
>>> +			 * Batch zap large anonymous folio mappings. This allows
>>> +			 * batching the rmap removal, which means we avoid
>>> +			 * spuriously adding a partially unmapped folio to the
>>> +			 * deferrred split queue in the common case, which
>>> +			 * reduces split queue lock contention. Require the VMA
>>> +			 * to be anonymous to ensure that none of the PTEs in
>>> +			 * the range require zap_install_uffd_wp_if_needed().
>>> +			 */
>>> +			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
>>> +				bool full;
>>> +				int pgcount;
>>> +
>>> +				pgcount =3D zap_anon_pte_range(tlb, vma,
>>> +						page, pte, addr, end, &full);
>>
>> Are you trying to zap as many ptes as possible if all these ptes are
>> within a folio?
>
> Yes.
>
>> If so, why not calculate end before calling zap_anon_pte_range()?
>> That would make zap_anon_pte_range() simpler.
>
> I'm not sure I follow. That's currently done in calc_anon_folio_map_pgc=
ount(). I
> could move it to here, but I'm not sure that makes things simpler, just=
 puts
> more code in here and less in there?

Otherwise your zap_anon_pte_range() is really zap_anon_pte_in_folio_range=
() or
some other more descriptive name. When I first look at the name, I though=
t
PTEs will be zapped until the end. But that is not the case when I look a=
t the
code. And future users can easily be confused too and use it in a wrong w=
ay.

BTW, page_addr() needs a better name and is easily confused with existing=

page_address().

>
>> Also check if page is part of
>> a large folio first to make sure you can batch.
>
> Yeah that's fair. I'd be inclined to put that in zap_anon_pte_range() t=
o short
> circuit calc_anon_folio_map_pgcount(). But ultimately zap_anon_pte_rang=
e() would
> still zap the single pte.
>
>
>>
>>> +
>>> +				rss[mm_counter(page)] -=3D pgcount;
>>> +				pgcount--;
>>> +				pte +=3D pgcount;
>>> +				addr +=3D pgcount << PAGE_SHIFT;
>>> +
>>> +				if (unlikely(full)) {
>>> +					force_flush =3D 1;
>>> +					addr +=3D PAGE_SIZE;
>>> +					break;
>>> +				}
>>> +				continue;
>>> +			}
>>> +
>>>  			ptent =3D ptep_get_and_clear_full(mm, addr, pte,
>>>  							tlb->fullmm);
>>>  			tlb_remove_tlb_entry(tlb, pte, addr);
>>> -- =

>>> 2.25.1
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_2C76F03F-DF26-4035-AAB9-1F048E9622E6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS1aR8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUGzEP/jS7mjIGX3UnQtB5z9J1BeTQcKXD3xNREADz
ufyHudMJ34majlLYQauTqlbYGDCl3oGb1s4EdjGxdcqndYNbSPaUYWFW20+19VQt
Uspo203M71hkLrqzP9xtjDYMz3OZvNAa01Nj1hkLF89F711ljkM6PgpSKZpPILeG
49KwVz+JOnaJlIGC/TtwgRHx+X5MMd/0756IeuMih92KwN/XnyH3Liu8No5bzvCE
Yhs2vnDfjG9lTWOmixuwrk6OT8wzvPnvuudPZxT7M8JkyecFbApH7XdsqGuWYH+k
up/eT7iEHw5SS4mafs38wzL8nD/aQudnjcZJSrxZgA3EXtgtG3pghEoo42IM5IQy
76ybs+MxwmL8xFLqZD+d/aF4QWKJ+8R2V39Vat5X3L80Kjex7+ZP8XUiwuIitpP5
IWMlktD4gWPgfg4fR6w+x9gfTkvzb7MiNIqZ5M9FwIuYRmfRKMliDnRzmAjFN0KZ
3bTPCxmQL7ZYXYUceijSs5mVofl7UuSpmO0YGxWNm9wIWIvKbtpq2gtE46RzIhTu
DPeXSY8+cdC4TvJwONwo6jOohfzrvCYgZLq1tnQncIa+U5JJpC6jyoaCzGx4pP5R
Gr6ELriijILltjKIXoep4aBn0gVatw2PrzMrzQQiqZ4ICl6Tq9X64kWk/tJY3S9m
ey3EPpEl
=iIX7
-----END PGP SIGNATURE-----

--=_MailMate_2C76F03F-DF26-4035-AAB9-1F048E9622E6_=--
