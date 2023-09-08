Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E687980A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbjIHCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjIHCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:40:42 -0400
Received: from out-222.mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C71BDB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:40:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694140836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rs5bwBL78/PRiAuJDQ+7XQFfD46cSe+ZZZ20CkSpt74=;
        b=ttEyOjViY13b8UUNKz7qX9yHrQRVA4N5KGdUQzGnIr6APiy3VyOh6Gloc/t4WK4SvBAxM0
        UYMeFI/3xIaVCVSMoE18MfFogT7v3qyEWeKBGgOQ56sTmS2gb60vkR4wHh36mJGw/aERRE
        bjTfbWN96NLaW9zlnHWNeVxTLn5MX20=
Mime-Version: 1.0
Subject: Re: [v4 4/4] mm: hugetlb: Skip initialization of gigantic tail struct
 pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230907183712.GB3640@monkey>
Date:   Fri, 8 Sep 2023 10:39:56 +0800
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C51EF081-ABC9-4770-B329-2CAC2CE979FA@linux.dev>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230907183712.GB3640@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 8, 2023, at 02:37, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 09/06/23 12:26, Usama Arif wrote:
>> The new boot flow when it comes to initialization of gigantic pages
>> is as follows:
>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>> the region after the first struct page is marked as noinit.
>> - This results in only the first struct page to be
>> initialized in reserve_bootmem_region. As the tail struct pages are
>> not initialized at this point, there can be a significant saving
>> in boot time if HVO succeeds later on.
>> - Later on in the boot, the head page is prepped and the first
>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct =
pages
>> are initialized.
>> - HVO is attempted. If it is not successful, then the rest of the
>> tail struct pages are initialized. If it is successful, no more
>> tail struct pages need to be initialized saving significant boot =
time.
>>=20
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> ---
>> mm/hugetlb.c         | 61 =
+++++++++++++++++++++++++++++++++++++-------
>> mm/hugetlb_vmemmap.c |  2 +-
>> mm/hugetlb_vmemmap.h |  9 ++++---
>> mm/internal.h        |  3 +++
>> mm/mm_init.c         |  2 +-
>> 5 files changed, 62 insertions(+), 15 deletions(-)
>=20
> As mentioned, in general this looks good.  One small point below.
>=20
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index c32ca241df4b..540e0386514e 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate =
*h, int nid)
>> }
>>=20
>> found:
>> +
>> + 	/*
>> + 	 * Only initialize the head struct page in =
memmap_init_reserved_pages,
>> + 	 * rest of the struct pages will be initialized by the HugeTLB =
subsystem itself.
>> + 	 * The head struct page is used to get folio information by the =
HugeTLB
>> + 	 * subsystem like zone id and node id.
>> + 	 */
>> + 	memblock_reserved_mark_noinit(virt_to_phys((void *)m + =
PAGE_SIZE),
>> + 	huge_page_size(h) - PAGE_SIZE);
>> 	/* Put them into a private list first because mem_map is not up =
yet */
>> 	INIT_LIST_HEAD(&m->list);
>> 	list_add(&m->list, &huge_boot_pages);
>> @@ -3176,6 +3185,40 @@ int __alloc_bootmem_huge_page(struct hstate =
*h, int nid)
>> 	return 1;
>> }
>>=20
>> +/* Initialize [start_page:end_page_number] tail struct pages of a =
hugepage */
>> +static void __init hugetlb_folio_init_tail_vmemmap(struct folio =
*folio,
>> +     		unsigned long start_page_number,
>> +     		unsigned long end_page_number)
>> +{
>> + 	enum zone_type zone =3D zone_idx(folio_zone(folio));
>> + 	int nid =3D folio_nid(folio);
>> + 	unsigned long head_pfn =3D folio_pfn(folio);
>> + 	unsigned long pfn, end_pfn =3D head_pfn + end_page_number;
>> +
>> + 	for (pfn =3D head_pfn + start_page_number; pfn < end_pfn; pfn++) =
{
>> + 	struct page *page =3D pfn_to_page(pfn);
>> +
>> + 		__init_single_page(page, pfn, zone, nid);
>> + 		prep_compound_tail((struct page *)folio, pfn - =
head_pfn);
>> + 		set_page_count(page, 0);
>> + 	}
>> +}
>> +
>> +static void __init hugetlb_folio_init_vmemmap(struct folio *folio, =
struct hstate *h,
>> +        unsigned long nr_pages)
>> +{
>> + 	int ret;
>> +
>> + 	/* Prepare folio head */
>> +	 __folio_clear_reserved(folio);
>> + 	__folio_set_head(folio);
>> + 	ret =3D page_ref_freeze(&folio->page, 1);
>> + 	VM_BUG_ON(!ret);
>=20
> In the current code, we print a warning and free the associated pages =
to
> buddy if we ever experience an increased ref count.  The routine
> hugetlb_folio_init_tail_vmemmap does not check for this.
>=20
> I do not believe speculative/temporary ref counts this early in the =
boot
> process are possible.  It would be great to get input from someone =
else.

Yes, it is a very early stage and other tail struct pages haven't been
initialized yet, anyone should not reference them. It it the same case
as CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled.

>=20
> When I wrote the existing code, it was fairly easy to WARN and =
continue
> if we encountered an increased ref count.  Things would be bit more

In your case, I think it is not in the boot process, right?

> complicated here.  So, it may not be worth the effort.

Agree. Note that tail struct pages are not initialized here, if we want =
to
handle head page, how to handle tail pages? It really cannot resolved.
We should make the same assumption as CONFIG_DEFERRED_STRUCT_PAGE_INIT
that anyone should not reference those pages.

Thanks.

