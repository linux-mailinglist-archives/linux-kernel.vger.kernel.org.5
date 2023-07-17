Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566137567DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGQP0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjGQP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:26:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23F3A81
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF5YdjN1OEVoYU+IOnkQJxifUmIqsiPYGpR3SIr5gOU9qBrTnGXCbKofePpptVjnh6LVQGYPlJCkXu1XO/KL4NUxwQ2qU2SsS3/HAREAYWOOSzt2AGfwY30yuoQjjIA6IskR5RFazonbE69rFZebeImGKD8sWE+MtofiS0ya+wq7naiBrCuJauRj3E3paOCGDK7lw5VFlDN1le0aThybhsPT9MchxcJgHCCLAQnKeLRx47dIK3pqkAJRUhBPFez541iwYS5XULPwvbrvyvdf6jkCXMWLAgb+KObscWPKONV9mKEmhf5PKv1kErXnAgGDCrhzg7TBwnXTIcUMsPHVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk19c9bRmSQLZJrOFUWZ8C208mBc4Za2cWcolvKjBDo=;
 b=PS62EdAPcXwIUwkMQoHCaQ8KMqIEDYw6DhBPtUPAbZSMjrrCK/7nLytfn1+2VgP533okLOsAqi/99JSLRwnlTkyLi1eVONOUEb/uScJWgpZtTM1ZrRbjcFxtZUoi0molrepXV68u5SJ9bTHV+eSd6sMlO61xMq4R1vtKy+FgZeQaJAj68B7x4sgpms3xCUOHQkOSztI42RHW0dnsNCTG6SY1o7Wc6KlHC4SU3vl5VMSFor5nCw2Wk3Emq/gDs8JzunCZKiEKIEmiAQWeKpLIPO1Lp0VngH477M+FwDbSpZ1rKWSMDVruDebnN5FE2Ceuoiv4P+jZYoTAcaKP5b/jBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk19c9bRmSQLZJrOFUWZ8C208mBc4Za2cWcolvKjBDo=;
 b=Fp0D8yrU+vX7pIY9TUFhgqOblBUa8pXx+BseCL4bmwWpKZade3cL8jCIkoai4iVM91H05TBkKbRJC16IIpIU7MDEeYr0b2uhIZblbUlcDcwkK8451VPWk5OuVU+E72UdwQUkq898rY95UGeDTvMnS7RjxtqQQEkpcCaRz+/WMC4sYROQYkNNVdpSiIjl0/EC+tx+c73J7BCXMcv71VkFShb73FioQPI2cRQ+E993pq7kG5cv8KU7SA1KCMOfb/iMPlXGJnlXEusljNTbMuFMb/V8OED655hTt2cqHI2ZjYvI5ZgpujAQ1naXySF7tikrdnFKoHIbw5UGv7QLEhKpAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:25:21 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:25:21 +0000
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
Date:   Mon, 17 Jul 2023 11:25:18 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <5A282984-F3AD-41E3-8EF2-BA0A77DD1A3A@nvidia.com>
In-Reply-To: <20230717143110.260162-4-ryan.roberts@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-4-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_324C73F8-3AC4-48D2-9540-0D2C4D100ABF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 83327f91-31f3-4f77-c146-08db86da08f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFrkbtBA+n74LEX7eavgX0SO3oNYhnEFvESIctLWfNPbMwX8qALlgCuZSaL91i313XFMZOVaupgyFukvpouuAKME7yuC3ORr1eFqO3XEXFSLDFdzHJrX6uYblA5f+9qPJDIMggHZjW8E4VSgzwIrxOwrGq++GyiqRDpSJYgtInh5UhLVs6Bu5cPXvDHp9S9hKU2hCt4Gu0ZusnCU0/HUe5mEmaA17+jGWeCPzEt/Q22BL2BmFvDEdXa7rZlCukANQiW3Gl+vQalrStR2HRjHKYlP0unT8jti29k3EgnGAQVsrsRx5F0QB7zbr5aaUqvpXaJNL/YP23xbvlaAltSHJynjqWV72fbRkgCMG7Go29xKfJyZMaM7Z6BGIVCyX4MEttjmHfTB7VWtHD7LAHjgqGA/ReumeYn/cGJNIqbupw0hMd+ABXJqx4nQUY/V4B2b80Z6wCHfj/B4z8xKSz87HXTqz27ik5RgT/STkKdE1eMc/fiIcuC8jgHAilbnQ5chePtD6x32p+s2zwhDz1O7/kpyW8ZVhs7Z7mZ163gL60bDaJ2JomA6fFiGxOWUekuocHMgkcWq9aZ8703zMIWPbg+UwcJ3wHuDuOxavQpCGfuYdb/6bYCqZWfBU1Cd0MMb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(41300700001)(8936002)(8676002)(26005)(53546011)(6506007)(33656002)(54906003)(478600001)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(6512007)(36756003)(6666004)(6486002)(38100700002)(86362001)(83380400001)(2906002)(2616005)(235185007)(5660300002)(7416002)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iOYGc7MpQzEw2nhpmTTqOYV6mq4PUEv2OlSE9/mpJsyp1aw7Kalw0Gbkttta?=
 =?us-ascii?Q?sJdm0ZdUlJ7kIJONdWEqYyXVPiJNmnNiBJQypL7Hn7SJCdhBBqGoH8lJeXxx?=
 =?us-ascii?Q?LaBxJbpKDikxQzisbPNnd/FxEXuE9g4g3dauJudwqZpD1k2ieB14255na7+g?=
 =?us-ascii?Q?zGCBEvoSpZZREoh1XuKouw3QOvpsGec0U70KYTl7iMVzAUqs1YTDxPnjvS4t?=
 =?us-ascii?Q?uaQbWPsbOAldhgBxk5EMxAu9mPzPuy/6BcbM3hZE7dKiJ2d2Io9rLiPx1fJS?=
 =?us-ascii?Q?X7oVzXkg7iUD4rXz0J82sHjc3WLkAJqdkiZxxyqQN/S+4dmfErh3wYHgCwcx?=
 =?us-ascii?Q?nxHU//tjA0pdWfbf51jnRB6Tkfow0BC2drPwrXwtucak0vG6Owe9q1ajx85O?=
 =?us-ascii?Q?IhRcKL0ubFAjkA8XNex7dlirHYQYnk0QGP/DIRwFk7hAOFDN4a7ijJzVF3QR?=
 =?us-ascii?Q?D8ITx1CeF5Q5JxbJviC8zUkFfZFSME1m4ZXDw+6ql4zTLogdVp4YahTzPULQ?=
 =?us-ascii?Q?Q/tu9H8jX340zgPxX4+4bK5PRFbiKDRAZCWaw1QUJ/j0GthS3yNGbRpOgshG?=
 =?us-ascii?Q?jSMTdWFVJ6SSaFAXAd3XH+51XsGiUW79D9fGDVBO0bbIM8UwwjAhoR1XWKa0?=
 =?us-ascii?Q?JTaQHobcRqf5E4KOBJ+/CDGSOa4H/vCRVg/IFeqeZIbPYMjS0Af5t47g9iO1?=
 =?us-ascii?Q?DyyjDzokyvP9Z+3QndB0aOb3+SJrli8RB0L7LQLGUNWSd5Qc78Jvo7SVaxvi?=
 =?us-ascii?Q?ouh27iH7Oyarbh6taHnuLknnOCsZ6G+HR8x5t0Edd/JObcsyMBvVJFZd0p6z?=
 =?us-ascii?Q?e3d3kTUw+RosnUjATKWehia5Zd8trUD/vd64zIxkQHthPrrE6sh2EkqGLVct?=
 =?us-ascii?Q?f/Ofi9+ZSlsPUklULYOsUQZVGA2ZYJiRzFDmcMqAfSrc9+35HdXUS3MEFn3t?=
 =?us-ascii?Q?B5AamMwsMLvrdcmXL630anOov1ktdBqvMs+KAvnt+gztYe9a9jXfrDDGpb/u?=
 =?us-ascii?Q?f9rEOmixdiIYZCyzmcmH7fmO1RUYKScFpUPq4sj8cyd58Ah/VldlRlFQvbLp?=
 =?us-ascii?Q?h02qpTIM+M8611utA9u/S21JtQxYxU1Rw+trTM6bexVybYEHMP5VBbkvXRjo?=
 =?us-ascii?Q?ab0PsHFp+aNjIfc09WvuJVJXRzgN0Wo5LMrTF9WYwzvWt4/z6+gL2oST+TAP?=
 =?us-ascii?Q?shj7V80tDweq6+JB0BFUGQdicgKQRyDUP1DO4+MDAIlD2g7iY91HGafph/p/?=
 =?us-ascii?Q?jyLdabzozbhAjRntYfod+kxMYZbJpcTdhlaOngLiw54V1dvWURbTTJSz11Gd?=
 =?us-ascii?Q?DLQmeL9+17nc7s2kusj4+je5eN8KUo4YBjBbBF7WImmrgqyOTnqpjyHtPLtc?=
 =?us-ascii?Q?jz2Sfc3b+pGr4KFjMKRAYdoBq7vIPTewrokkixoxSesHKRc5RNQEXtskm6SC?=
 =?us-ascii?Q?TtBKQxucNjAFZIfTSq7nhNZkez4Ju31n1galms9pGlHrPgZ5fkeCQ4ObEzNN?=
 =?us-ascii?Q?2bwnsTH2BSfNnrg2x8Vp1lltC9ekFp2uLrox15EQ4f9DAZ9iDtFlbm2IXmlm?=
 =?us-ascii?Q?GsDtaIPMRUyWkDsBZOwG2mbW92nSiUCcO9LIe42G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83327f91-31f3-4f77-c146-08db86da08f0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:25:21.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaOPvGmtecY15v+6Gn69hN2vyTrCrKTXmyEZOVFLEOmvXaRr4Ffv55UseI6keTUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_324C73F8-3AC4-48D2-9540-0D2C4D100ABF_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Jul 2023, at 10:31, Ryan Roberts wrote:

> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to th=
e
> deferrred split queue in the common case, which reduces split queue loc=
k
> contention.
>
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meanin=
g
> there is no value to adding it to the split queue.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 119 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..6facb8c8807a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1391,6 +1391,95 @@ zap_install_uffd_wp_if_needed(struct vm_area_str=
uct *vma,
>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>  }
>
> +static inline unsigned long page_addr(struct page *page,
> +				struct page *anchor, unsigned long anchor_addr)
> +{
> +	unsigned long offset;
> +	unsigned long addr;
> +
> +	offset =3D (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
> +	addr =3D anchor_addr + offset;
> +
> +	if (anchor > page) {
> +		if (addr > anchor_addr)
> +			return 0;
> +	} else {
> +		if (addr < anchor_addr)
> +			return ULONG_MAX;
> +	}
> +
> +	return addr;
> +}
> +
> +static int calc_anon_folio_map_pgcount(struct folio *folio,
> +				       struct page *page, pte_t *pte,
> +				       unsigned long addr, unsigned long end)
> +{
> +	pte_t ptent;
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +
> +	end =3D min(page_addr(&folio->page + folio_nr_pages(folio), page, add=
r),
> +		  end);
> +	floops =3D (end - addr) >> PAGE_SHIFT;
> +	pfn =3D page_to_pfn(page);
> +	pfn++;
> +	pte++;
> +
> +	for (i =3D 1; i < floops; i++) {
> +		ptent =3D ptep_get(pte);
> +
> +		if (!pte_present(ptent) ||
> +		    pte_pfn(ptent) !=3D pfn) {
> +			return i;
> +		}
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return floops;
> +}
> +
> +static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
> +					struct vm_area_struct *vma,
> +					struct page *page, pte_t *pte,
> +					unsigned long addr, unsigned long end,
> +					bool *full_out)
> +{
> +	struct folio *folio =3D page_folio(page);
> +	struct mm_struct *mm =3D tlb->mm;
> +	pte_t ptent;
> +	int pgcount;
> +	int i;
> +	bool full;
> +
> +	pgcount =3D calc_anon_folio_map_pgcount(folio, page, pte, addr, end);=

> +
> +	for (i =3D 0; i < pgcount;) {
> +		ptent =3D ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		full =3D __tlb_remove_page(tlb, page, 0);
> +
> +		if (unlikely(page_mapcount(page) < 1))
> +			print_bad_pte(vma, addr, ptent, page);
> +
> +		i++;
> +		page++;
> +		pte++;
> +		addr +=3D PAGE_SIZE;
> +
> +		if (unlikely(full))
> +			break;
> +	}
> +
> +	folio_remove_rmap_range(folio, page - i, i, vma);
> +
> +	*full_out =3D full;
> +	return i;
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
> @@ -1428,6 +1517,36 @@ static unsigned long zap_pte_range(struct mmu_ga=
ther *tlb,
>  			page =3D vm_normal_page(vma, addr, ptent);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
> +
> +			/*
> +			 * Batch zap large anonymous folio mappings. This allows
> +			 * batching the rmap removal, which means we avoid
> +			 * spuriously adding a partially unmapped folio to the
> +			 * deferrred split queue in the common case, which
> +			 * reduces split queue lock contention. Require the VMA
> +			 * to be anonymous to ensure that none of the PTEs in
> +			 * the range require zap_install_uffd_wp_if_needed().
> +			 */
> +			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
> +				bool full;
> +				int pgcount;
> +
> +				pgcount =3D zap_anon_pte_range(tlb, vma,
> +						page, pte, addr, end, &full);

Are you trying to zap as many ptes as possible if all these ptes are
within a folio? If so, why not calculate end before calling zap_anon_pte_=
range()?
That would make zap_anon_pte_range() simpler. Also check if page is part =
of
a large folio first to make sure you can batch.

> +
> +				rss[mm_counter(page)] -=3D pgcount;
> +				pgcount--;
> +				pte +=3D pgcount;
> +				addr +=3D pgcount << PAGE_SHIFT;
> +
> +				if (unlikely(full)) {
> +					force_flush =3D 1;
> +					addr +=3D PAGE_SIZE;
> +					break;
> +				}
> +				continue;
> +			}
> +
>  			ptent =3D ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> -- =

> 2.25.1


--
Best Regards,
Yan, Zi

--=_MailMate_324C73F8-3AC4-48D2-9540-0D2C4D100ABF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS1XV8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU39EP/0QWp/j7l8WcMV+vb2i2mqnkrZKeJopVE6DX
24anRw7F4cgRovOeMUOX0aT4i9zASWd4APcgiiUKwyXeZ3ubAFrV0RZxcYp+xLo6
zRFwXMGguHoUB7sq50P9XqqfEu6GB2QA8VXd8izUg6OrNzOPnKH5RIMHdK1Dg+E+
Bion1JytOOl6e+01e8YQMUbkOpty0Czqt9w4ArQx7osNn8We7G6XRwRh2sr5PMd1
u7o0Z+D9QRxF+t/sRUsMbGeD2FEaAGaEeT7MrgGW5IHk+De6yPYNM2Uotr+miZmc
DAS+ksDfyJX39F6814FQG/F3fECpkHC+FuEp+ZZjDKC2ze8v3O5dGTyuZt7Jbu/9
ZijemGatioYZDpNfjbq9ShvKuQki0RRb2/YS7p8CxaRYbYFRRM75PWVbAP1ea2GO
JHpzYgK7V1Yge3PED7aj3fNeHSaImydx9wdqbsR81nj1nQazRoFIQKSIG3qVYIJI
XG1RTApN0SSfbR0Zja0UfF300kzb4VCpNcWUiHFi3i9EFvox8mM5AaG/5Y+0Z2Rs
R3/EaBIKPJHM/udGQ234Em+ECJSPg16wUGp5xAJGoaLEBzKW1IJiVuZRgQqHpY2B
1KQH92fyP7sZli0b6Ap29wRX/6tYp1H1laQ7b85zeNOt0UZ3hSCTQrLKv/brcryJ
w+K1/Pc/
=BZVw
-----END PGP SIGNATURE-----

--=_MailMate_324C73F8-3AC4-48D2-9540-0D2C4D100ABF_=--
