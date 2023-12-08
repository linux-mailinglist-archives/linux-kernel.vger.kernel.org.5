Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D3809754
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjLHAiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:38:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865FD5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:38:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkjxBWi71pxtpbED2btR8GRBfMm1tWnGf/hGl4TBqSjGgMcKyTW8+zkw/VA5CVs1CzigNLzuWAB7d21MlfgUvX19noBEbu1VvbBSob0ZyiQ+1uj1wE7u455MPGUO3H/5f1GQ6+sd9OVpvBXKoxjxHcIQuC5pWs/sAUF52jlkhWYnmqGT+BUGy1okjQnw8DYBzs4jGaHKB8zG2vteCHTb65UTCu64IQAvPqfiE9Vi3Pbomnc0dwJweZzc+4gFcNBuyN7sTvNRwvjbEgDn9SjXTNRtg9AIbnZhy4uMMPywu1GAfM55IuggMytbN3ZTldSFGcjjblHM3ltFl54NIdvmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx1PAMjMnsDB5fK0tnrB98n8Vss/JNzWfKM276KuEIU=;
 b=ApmK5AvKkXTAnic6z/jVF4S5ti1ESAgx+96nlWGECz2a41tK9T9MuFp0edTivjsUrYoxnM9jS3IEAL+TTp+UilxKxd0UmcSPDsOcR4/tT9XWjli3ZEXawxVtcERd1EhSPnLXRZ5JwBF3ndOyWCa9yxftljgEaVOgmz3CtapcgcZXRXwoUIknc9PfNgT6wGHQEKOZ/f20hgUYs3tEITzTZr3sfXKwwcIxwv534+1bnbkM/YVk/KoqiTKky7NAMYdIEnFhWW2ub9bjBZXoEB1R4vmGfMJLF9Kl1i3FWpLmuDk70zHSEgp69sh5b9PLnOep1ppTyDh8eMgWw6NOqZXNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx1PAMjMnsDB5fK0tnrB98n8Vss/JNzWfKM276KuEIU=;
 b=gsXt8oX1z9sZ1mrQVkeYz2Gid9LmUwhBJE41HuaLYfe35fMfV2YT3kpUMO64Y8v+HRlY/Cbekqp/8m5TWzjhytU15WyEyfwH9AlUq8TNMBpgqFBT0TusFbpEjGNr1X/rJ+jtUHjJgZPzVryyrocqeapHzmOH8vfi8h6FHykTYcDxPkFFXe0EiAn2qbw3sMTTVO/oQnUSIGjDVapC5/6Lu8lAqPphUSxuCrqFeaAASbEbfDqYq0LHWgPzTJZaQkyO40wPakdM8WGvLC4FvfS+10jy5EppKBng55O5iy/rX4sd9IhY4E2246d2AghnbslQL3xfXC2SWGBMzR1lfdge5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 00:38:16 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 00:38:15 +0000
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
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
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Date:   Fri, 08 Dec 2023 11:32:38 +1100
In-reply-to: <20231204105440.61448-2-ryan.roberts@arm.com>
Message-ID: <87lea5a5qm.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:e::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0e10d3-263b-4d6a-dcc0-08dbf785f6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGGxvLmRzc9NCW/dXre6Awtp3x4thU57HJzQGyVvJxx/xkcde0TljjhBpYkcw3PG3eQ6ncDqx9S+arLlQDCHbibTs6Z2CdHP8oGxtiWHcZxdkmLC4tm7nUMlhnKEkJvU3RwnOJoAPyI24fizxCPODWQAJPxqY1A0WqEikNIAgbhpQ/N8jgbyPPe3t99h6QOUbn2xluSuMI4IQmaADYvwqBn7oolzUr5DhyutdIJXqgyxxz1IcS/GBlzTc9GcS3zheIoN+rh+TEs5fdfw2fTQz5RCzEADUJndzrOtaEiZSwSQKES24jzzGN7gr2xklFf5XXxLXGAxp/ur8/yq2ptxzJK4/KO/+cybIGDUvDFNiW7cgx0b2qSFsEiWPEFDV+y0Pz2tNOapei7B5O8sKcfHQGLrQNlzBeIOUNRIyx8+JcNn827XB3uQF51s4x1vEijsOMX/REe3Vk+He1nnk+ieFwsRgZ/TDyHgtavaQ4VAKlrAXES+B/3WZiSCw2g6xSeSaI/k89TZXJ1xo8e0ate30lfvcooenMbTyRqAfZkLUZWLNaqpqLA8I3FJIGlPne6oOPGReuEztJy+2DXL6wFOVIHP0+3QHf8OeGXXEyeGKlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(26005)(6506007)(6512007)(41300700001)(9686003)(478600001)(6486002)(66946007)(2906002)(38100700002)(6666004)(54906003)(6916009)(316002)(66476007)(4326008)(8676002)(8936002)(7416002)(66556008)(83380400001)(5660300002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IE2VOYWcS4vVslmi8RzfAlamAMfU0EWoJRO6GvNFD5KOBQBuA7kL2Al9q/fN?=
 =?us-ascii?Q?p6xksCQjCVd6XCBUcRWoi6KT7np3g4mtxlj8pMqZeqpKprPngsRlHNKXwN+S?=
 =?us-ascii?Q?h+6UqMLTip2hTo7NLa4k+Ivk6ZFKsn7FuBRjIcobD4w0rfhEzdriaWuhS+9D?=
 =?us-ascii?Q?bY0Poxg/FG7A5LwEGFA8GSiDDTBpXOgfE4tlwzCXvef6guEX1hfkz1mmr5MN?=
 =?us-ascii?Q?137+grZVO+luYn5GjQsgQEYZTZ8kK4lUCm+Vt1URUwJppFWIl4Nfmu/eAAoQ?=
 =?us-ascii?Q?8C8TLWM9MejR0P1LjQR1mTH0nK7wi1/4MOf48pq9GL760Uwt1b/05L4XMxYr?=
 =?us-ascii?Q?BffQIga/XPnlz2RgifAPpRDaNO7XTR1m9s5rIcSWAGuxWLdM6avCbQCfHhAW?=
 =?us-ascii?Q?AVaVbneFVaSQwsBM6H72ENVr1OX/xWHWkPjef6d043cdd8AKzmrEFmpADb2q?=
 =?us-ascii?Q?cKucQmYEK2ltQnjja1ItZDUmoUn1PKigUIZiNX9koIqogc5g1Avxpu2w67Ce?=
 =?us-ascii?Q?D1Kg/eQXz8yVD3nAZ3YbBWu4fzsPdJyyubeHBla6aS1mywgB5tA/STv3Ivr+?=
 =?us-ascii?Q?az9Mw4dW8717W+YHpvandLD17m1I7pb0kLTQ6l9JWr3qMnI8tcTfCUCJQYVv?=
 =?us-ascii?Q?Qe35j80SMIyXviZdtz/TZiSlyjct8FlPX0VxSp9PPt/IAKCIU0IcU2Ze2TGD?=
 =?us-ascii?Q?7pUln5iUDo0+jNGpGFztNlqFJjvmS2MN9K7Dr/ka+RQi0MHhyv3MszatSV4l?=
 =?us-ascii?Q?DdAT/9yP1zmqIf38RlDkL3st557KxTQSeqO9H0A0c2ItEWkJep40NcV4vfAR?=
 =?us-ascii?Q?hCSbrnezcOOUUbhfgg3JNXuRfVW3NhSzgZcnoWcBQMYlEeYI5BzLRPrzLf8m?=
 =?us-ascii?Q?7Un3YsEQ8UqcFTAGOv9ILbdAQ5fg1XSj5iFVSuoOcjPrgTn4+e46ND5vidnj?=
 =?us-ascii?Q?kOz73jZWCtp1TJAoWC1xF3YaZ1M38WGbNvSJ4QxXu34NtbOv6Ogxvf1KY8kS?=
 =?us-ascii?Q?CIuxLUV3J49V99/gAOeskQGiiTLclwk/XGtFelCKY/VmX/2dSZLrqenPVrPA?=
 =?us-ascii?Q?jtd2Lt5/V5+HC1gk+R5I4KqKL0aPre0cquVGuqCJ1gB+2pFO3lG4puJ97y3q?=
 =?us-ascii?Q?R4Ms1vyd0Mrvs0iO8y68lsXlUde4C815ZRcNYT1YDHCmU+ENdBWfUDIx3TlP?=
 =?us-ascii?Q?ZFalveVLmzpYadrapc8Ve9GNpbKb0W6A4dB+FxlxvkR+wN4B6NDCd9YAz5XH?=
 =?us-ascii?Q?HIcSxxpQLFhq5ZXZubV+d7S64YuXJ2+K2allhay7tdtAkZlIHD5swDVx0UQY?=
 =?us-ascii?Q?9Bz8XD1weZKWldFg2pqkrv7WtFR7SGfWW2Rg1yTt7uMCVvZz26hqWalNFee4?=
 =?us-ascii?Q?6UusbkFlRKMvu4eX/r0jrQDP7GEhNCYzILnaXozBF+BvUDdnSyGJ6kSsNcFk?=
 =?us-ascii?Q?BbPOO9EJLUE9ZFnKO+Nj3I0xCUdrOTgVDXzrBKaIel0IKBo58d/T8SEoa1mI?=
 =?us-ascii?Q?93tJINrGuVqZ0ty9LhH4rjt6N+R3j+jLpKeG1zZ06PqlQo9BcnYB2qKI8N2+?=
 =?us-ascii?Q?ESFUzngQMqIBrqVxLOdPNOqT5rV/wVKZVwalVcfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0e10d3-263b-4d6a-dcc0-08dbf785f6cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:38:15.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZDgGkV7p1YH5OFcl2t+yXW0qwWFut8fNsGH/QkHAhVM9x8Qe9Yf5BwdXtcrccc6FPgHiXw/POVytYoNC4n+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

<snip>

>  /*
>   * On some architectures hardware does not set page access bit when accessing
>   * memory page, it is responsibility of software setting this bit. It brings
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a5497..8a87a488950c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -924,68 +924,162 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	return 0;
>  }
>  
> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> +				      struct page *page, pte_t *pte,
> +				      unsigned long addr, unsigned long end,
> +				      pte_t ptent, bool enforce_uffd_wp,
> +				      int *dirty_nr, int *writable_nr)
> +{
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +	bool prot_none;
> +	bool uffd_wp;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	/*
> +	 * Loop either to `end` or to end of folio if its contiguously mapped,
> +	 * whichever is smaller.
> +	 */
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	floops = min_t(int, floops,
> +		       folio_pfn(folio_next(folio)) - page_to_pfn(page));

Much better, thanks for addressing my comments here.

> +
> +	pfn = page_to_pfn(page);
> +	prot_none = pte_protnone(ptent);
> +	uffd_wp = pte_uffd_wp(ptent);
> +
> +	*dirty_nr = !!pte_dirty(ptent);
> +	*writable_nr = !!pte_write(ptent);
> +
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +
> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
> +		    prot_none != pte_protnone(ptent) ||
> +		    (enforce_uffd_wp && uffd_wp != pte_uffd_wp(ptent)))
> +			break;
> +
> +		if (pte_dirty(ptent))
> +			(*dirty_nr)++;
> +		if (pte_write(ptent))
> +			(*writable_nr)++;
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return i;
> +}
> +
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
> +	bool anon = false;
> +	bool enforce_uffd_wp = userfaultfd_wp(dst_vma);
> +	int nr_dirty = !!pte_dirty(pte);
> +	int nr_writable = !!pte_write(pte);
> +	int i, ret;
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
> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
> +						pte, enforce_uffd_wp, &nr_dirty,
> +						&nr_writable);
> +		folio_ref_add(folio, nr);
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
> +					folio_ref_sub(folio, nr);
> +					ret = copy_present_page(
> +						dst_vma, src_vma, dst_pte,
> +						src_pte, addr, rss, prealloc,
> +						page);
> +					return ret == 0 ? 1 : ret;
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
> -	}
>  
> -	/*
> -	 * If it's a COW mapping, write protect it both
> -	 * in the parent and the child
> -	 */
> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> -		ptep_set_wrprotect(src_mm, addr, src_pte);
> -		pte = pte_wrprotect(pte);
> +		if (i < nr) {
> +			folio_ref_sub(folio, nr - i);
> +			nr = i;
> +		}
>  	}
> -	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
>  
>  	/*
> -	 * If it's a shared mapping, mark it clean in
> -	 * the child
> +	 * If it's a shared mapping, mark it clean and write protected in the
> +	 * child, and rely on a write fault to fix up the permissions. This
> +	 * allows determining batch size without having to consider RO/RW
> +	 * permissions. As an optimization, skip wrprotect if all ptes in the
> +	 * batch have the same permissions.
> +	 *
> +	 * If its a private (CoW) mapping, mark it dirty in the child if _any_
> +	 * of the parent mappings in the block were marked dirty. The contiguous
> +	 * block of mappings are all backed by the same folio, so if any are
> +	 * dirty then the whole folio is dirty. This allows determining batch
> +	 * size without having to consider the dirty bit. Further, write protect
> +	 * it both in the parent and the child so that a future write will cause
> +	 * a CoW. As as an optimization, skip the wrprotect if all the ptes in
> +	 * the batch are already readonly.
>  	 */
> -	if (vm_flags & VM_SHARED)
> +	if (vm_flags & VM_SHARED) {
>  		pte = pte_mkclean(pte);
> -	pte = pte_mkold(pte);
> +		if (nr_writable > 0 && nr_writable < nr)
> +			pte = pte_wrprotect(pte);
> +	} else {
> +		if (nr_dirty)
> +			pte = pte_mkdirty(pte);
> +		if (nr_writable) {
> +			ptep_set_wrprotects(src_mm, addr, src_pte, nr);
> +			pte = pte_wrprotect(pte);
> +		}
> +	}
>  
> -	if (!userfaultfd_wp(dst_vma))
> +	pte = pte_mkold(pte);
> +	pte = pte_clear_soft_dirty(pte);
> +	if (!enforce_uffd_wp)
>  		pte = pte_clear_uffd_wp(pte);
>  
> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> -	return 0;
> +	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> +	return nr;

I don't have any further comments and you have addressed my previous
ones so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

However whilst I think the above CoW sequence looks correct it would be
nice if someone else could take a look as well.

>  }
>  
>  static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
> @@ -1021,6 +1115,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	int rss[NR_MM_COUNTERS];
>  	swp_entry_t entry = (swp_entry_t){0};
>  	struct folio *prealloc = NULL;
> +	int nr_ptes;
>  
>  again:
>  	progress = 0;
> @@ -1051,6 +1146,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	arch_enter_lazy_mmu_mode();
>  
>  	do {
> +		nr_ptes = 1;
> +
>  		/*
>  		 * We are holding two locks at this point - either of them
>  		 * could generate latencies in another task on another CPU.
> @@ -1086,16 +1183,21 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			 * the now present pte.
>  			 */
>  			WARN_ON_ONCE(ret != -ENOENT);
> +			ret = 0;
>  		}
> -		/* copy_present_pte() will clear `*prealloc' if consumed */
> -		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       addr, rss, &prealloc);
> +		/* copy_present_ptes() will clear `*prealloc' if consumed */
> +		nr_ptes = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
> +					    addr, end, rss, &prealloc);
> +
>  		/*
>  		 * If we need a pre-allocated page for this pte, drop the
>  		 * locks, allocate, and try again.
>  		 */
> -		if (unlikely(ret == -EAGAIN))
> +		if (unlikely(nr_ptes == -EAGAIN)) {
> +			ret = -EAGAIN;
>  			break;
> +		}
> +
>  		if (unlikely(prealloc)) {
>  			/*
>  			 * pre-alloc page cannot be reused by next time so as
> @@ -1106,8 +1208,9 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			folio_put(prealloc);
>  			prealloc = NULL;
>  		}
> -		progress += 8;
> -	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
> +		progress += 8 * nr_ptes;
> +	} while (dst_pte += nr_ptes, src_pte += nr_ptes,
> +		 addr += PAGE_SIZE * nr_ptes, addr != end);
>  
>  	arch_leave_lazy_mmu_mode();
>  	pte_unmap_unlock(orig_src_pte, src_ptl);

