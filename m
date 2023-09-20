Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218BD7A70B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjITCsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:48:21 -0400
Received: from out-222.mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF4CA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 19:48:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695178093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90dpuWkSNpYOn5Bwrw/HrT1nHeiQih2ItWu9YBquWTY=;
        b=MypVaEqK2j/LUSt8onkeWROq1bmjMcVubeR7TXa2+ke1wnX27/NIpRdRWqqBVgjgEnop/2
        3ENu0RNvMx0qf+fy3PZRyShTkBm3hfKlIUpkBFdra/JoRG3+5/gkRbHsSs4hsWmG4orGe9
        gGd0pxJzayBfK1vii2wnVKqkyUu0Yis=
Mime-Version: 1.0
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5bd9c4f5-3411-4327-a495-ce6672150977@oracle.com>
Date:   Wed, 20 Sep 2023 10:47:33 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8712DC1-7A22-4A59-BB2C-F7089D8FCC16@linux.dev>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
 <d8ca9ff5-3160-49a1-947a-de4998887dce@oracle.com>
 <07192BE2-C66E-4F74-8F76-05F57777C6B7@linux.dev>
 <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
 <83B874B6-FF22-4588-90A9-31644D598032@linux.dev>
 <5bd9c4f5-3411-4327-a495-ce6672150977@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 19, 2023, at 23:09, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>=20
> On 19/09/2023 09:57, Muchun Song wrote:
>>> On Sep 19, 2023, at 16:55, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>>> On 19/09/2023 09:41, Muchun Song wrote:
>>>>> On Sep 19, 2023, at 16:26, Joao Martins =
<joao.m.martins@oracle.com> wrote:
>>>>> On 19/09/2023 07:42, Muchun Song wrote:
>>>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>>>>>    list_for_each_entry(folio, folio_list, lru) {
>>>>>>>        int ret =3D __hugetlb_vmemmap_optimize(h, &folio->page,
>>>>>>>                                &vmemmap_pages);
>>>>>>=20
>>>>>> This is unlikely to be failed since the page table allocation
>>>>>> is moved to the above=20
>>>>>=20
>>>>>> (Note that the head vmemmap page allocation
>>>>>> is not mandatory).=20
>>>>>=20
>>>>> Good point that I almost forgot
>>>>>=20
>>>>>> So we should handle the error case in the above
>>>>>> splitting operation.
>>>>>=20
>>>>> But back to the previous discussion in v2... the thinking was that =
/some/ PMDs
>>>>> got split, and say could allow some PTE remapping to occur and =
free some pages
>>>>> back (each page allows 6 more splits worst case). Then the next
>>>>> __hugetlb_vmemmap_optimize() will have to split PMD pages again =
for those
>>>>> hugepages that failed the batch PMD split (as we only defer the =
PTE remap tlb
>>>>> flush in this stage).
>>>>=20
>>>> Oh, yes. Maybe we could break the above traversal as early as =
possible
>>>> once we enter an ENOMEM?
>>>>=20
>>>=20
>>> Sounds good -- no point in keep trying to split if we are failing =
with OOM.
>>>=20
>>> Perhaps a comment in both of these clauses (the early break on split =
and the OOM
>>> handling in batch optimize) could help make this clear.
>>=20
>> Make sense.
>=20
> These are the changes I have so far for this patch based on the =
discussion so
> far. For next one it's at the end:

Code looks good to me. One nit below.

>=20
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index e8bc2f7567db..d9c6f2cf698c 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -27,7 +27,8 @@
>  * @reuse_addr:                the virtual address of the @reuse_page =
page.
>  * @vmemmap_pages:     the list head of the vmemmap pages that can be =
freed
>  *                     or is mapped from.
> - * @flags:             used to modify behavior in bulk operations
> + * @flags:             used to modify behavior in vmemmap page table =
walking
> + *                     operations.
>  */
> struct vmemmap_remap_walk {
>        void                    (*remap_pte)(pte_t *pte, unsigned long =
addr,
> @@ -36,6 +37,8 @@ struct vmemmap_remap_walk {
>        struct page             *reuse_page;
>        unsigned long           reuse_addr;
>        struct list_head        *vmemmap_pages;
> +
> +/* Skip the TLB flush when we split the PMD */
> #define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
>        unsigned long           flags;
> };
> @@ -132,7 +135,7 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned =
long addr,
>                int ret;
>=20
>                ret =3D split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
> -                               walk->flags & =
VMEMMAP_SPLIT_NO_TLB_FLUSH);
> +                               !(walk->flags & =
VMEMMAP_SPLIT_NO_TLB_FLUSH));
>                if (ret)
>                        return ret;
>=20
> @@ -677,13 +680,13 @@ void hugetlb_vmemmap_optimize(const struct =
hstate *h,
> struct page *head)
>        free_vmemmap_page_list(&vmemmap_pages);
> }
>=20
> -static void hugetlb_vmemmap_split(const struct hstate *h, struct page =
*head)
> +static int hugetlb_vmemmap_split(const struct hstate *h, struct page =
*head)
> {
>        unsigned long vmemmap_start =3D (unsigned long)head, =
vmemmap_end;
>        unsigned long vmemmap_reuse;
>=20
>        if (!vmemmap_should_optimize(h, head))
> -               return;
> +               return 0;
>=20
>        vmemmap_end     =3D vmemmap_start + hugetlb_vmemmap_size(h);
>        vmemmap_reuse   =3D vmemmap_start;
> @@ -693,7 +696,7 @@ static void hugetlb_vmemmap_split(const struct =
hstate *h,
> struct page *head)
>         * Split PMDs on the vmemmap virtual address range =
[@vmemmap_start,
>         * @vmemmap_end]
>         */
> -       vmemmap_remap_split(vmemmap_start, vmemmap_end, =
vmemmap_reuse);
> +       return vmemmap_remap_split(vmemmap_start, vmemmap_end, =
vmemmap_reuse);
> }
>=20
> void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct =
list_head
> *folio_list)
> @@ -701,8 +704,18 @@ void hugetlb_vmemmap_optimize_folios(struct =
hstate *h,
> struct list_head *folio_l
>        struct folio *folio;
>        LIST_HEAD(vmemmap_pages);
>=20
> -       list_for_each_entry(folio, folio_list, lru)
> -               hugetlb_vmemmap_split(h, &folio->page);
> +       list_for_each_entry(folio, folio_list, lru) {
> +               int ret =3D hugetlb_vmemmap_split(h, &folio->page);
> +
> +               /*
> +                * Spliting the PMD requires allocating a page, thus =
lets fail
                      ^^^^                                 ^^^
                    Splitting                           page table page

I'd like to specify the functionality of the allocated page.

> +                * early once we encounter the first OOM. No point in =
retrying
> +                * as it can be dynamically done on remap with the =
memory
> +                * we get back from the vmemmap deduplication.
> +                */
> +               if (ret =3D=3D -ENOMEM)
> +                       break;
> +       }
>=20
>        flush_tlb_all();
>=20
> For patch 7, I only have commentary added derived from this earlier =
discussion
> above:
>=20
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index d9c6f2cf698c..f6a1020a4b6a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
>=20
> /* Skip the TLB flush when we split the PMD */
> #define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
> +/* Skip the TLB flush when we remap the PTE */
> #define VMEMMAP_REMAP_NO_TLB_FLUSH     BIT(1)
>        unsigned long           flags;
> };
>=20
> @@ -721,19 +739,28 @@ void hugetlb_vmemmap_optimize_folios(struct =
hstate *h,
> struct list_head *folio_l
>=20
>        list_for_each_entry(folio, folio_list, lru) {
>                int ret =3D __hugetlb_vmemmap_optimize(h, &folio->page,
>                                               &vmemmap_pages,
>                                               =
VMEMMAP_REMAP_NO_TLB_FLUSH);
>=20
>                /*
>                 * Pages to be freed may have been accumulated.  If we
>                 * encounter an ENOMEM,  free what we have and try =
again.
> +                * This can occur in the case that both spliting fails
                                                            ^^^
                                                         splitting

> +                * halfway and head page allocation also failed. In =
this
                                 ^^^^^^^
                            head vmemmap page

Otherwise:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

> +                * case __hugetlb_vmemmap_optimize() would free memory
> +                * allowing more vmemmap remaps to occur.
>                 */
>                if (ret =3D=3D -ENOMEM && !list_empty(&vmemmap_pages)) =
{
>=20

