Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF679385D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjIFJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjIFJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:50 -0400
Received: from out-218.mta1.migadu.com (out-218.mta1.migadu.com [IPv6:2001:41d0:203:375::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C6198A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:33:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693992780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDuMH40hxOK+JtqDBTqduPq+D+6jIzzbwpv0RQE2wqg=;
        b=wBcThs4+axMpjTkBicZ5G1oORkyq7IWMsLyQgrvgpaFJjGXezo0DECGsL4H3b+iICGGNBM
        A5CfCYjk+h9ncW2htg4Bc4Bbp/OcVEKtR4iUHkMIArcYotn3/NBh2hr4DlOGkqaGFwOhKB
        mIDhxwp2rCB6tSz4tY2Jnmw4jpzZgCs=
Mime-Version: 1.0
Subject: Re: [External] [PATCH v2 09/11] hugetlb: batch PMD split for bulk
 vmemmap dedup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2e942706-5772-0a93-bab3-902644c578e7@oracle.com>
Date:   Wed, 6 Sep 2023 17:32:15 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D58A4D84-A397-4283-BB24-D31A27809DF3@linux.dev>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com>
 <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
 <CAMZfGtU2HX4UR1T2HW75xY70ZMSOdzNZ2py=EggoBYqP_1+QFg@mail.gmail.com>
 <2e942706-5772-0a93-bab3-902644c578e7@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 6, 2023, at 17:26, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>=20
>=20
>=20
> On 06/09/2023 10:11, Muchun Song wrote:
>> On Wed, Sep 6, 2023 at 4:25=E2=80=AFPM Muchun Song =
<muchun.song@linux.dev> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>=20
>>>> In an effort to minimize amount of TLB flushes, batch all PMD =
splits
>>>> belonging to a range of pages in order to perform only 1 (global) =
TLB
>>>> flush.
>>>>=20
>>>> Rebased and updated by Mike Kravetz
>>>>=20
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> ---
>>>>  mm/hugetlb_vmemmap.c | 72 =
+++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 68 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>> index a715712df831..d956551699bc 100644
>>>> --- a/mm/hugetlb_vmemmap.c
>>>> +++ b/mm/hugetlb_vmemmap.c
>>>> @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
>>>>      struct list_head        *vmemmap_pages;
>>>>  };
>>>>=20
>>>> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>>>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, =
bool flush)
>>>>  {
>>>>      pmd_t __pmd;
>>>>      int i;
>>>> @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, =
unsigned long start)
>>>>              /* Make pte visible before pmd. See comment in =
pmd_install(). */
>>>>              smp_wmb();
>>>>              pmd_populate_kernel(&init_mm, pmd, pgtable);
>>>> -             flush_tlb_kernel_range(start, start + PMD_SIZE);
>>>> +             if (flush)
>>>> +                     flush_tlb_kernel_range(start, start + =
PMD_SIZE);
>>>>      } else {
>>>>              pte_free_kernel(&init_mm, pgtable);
>>>>      }
>>>> @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, =
unsigned long addr,
>>>>      do {
>>>>              int ret;
>>>>=20
>>>> -             ret =3D split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>>>> +             ret =3D split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>>>> +                             walk->remap_pte !=3D NULL);
>>>=20
>>> It is bettter to only make @walk->remap_pte indicate whether we =
should go
>>> to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
>>> to indicate whether we should flush the TLB at pmd level. It'll be =
more
>>> clear.
>>>=20
>>>>              if (ret)
>>>>                      return ret;
>>>>=20
>>>>              next =3D pmd_addr_end(addr, end);
>>>> +
>>>> +             /*
>>>> +              * We are only splitting, not remapping the hugetlb =
vmemmap
>>>> +              * pages.
>>>> +              */
>>>> +             if (!walk->remap_pte)
>>>> +                     continue;
>>>> +
>>>>              vmemmap_pte_range(pmd, addr, next, walk);
>>>>      } while (pmd++, addr =3D next, addr !=3D end);
>>>>=20
>>>> @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long =
start, unsigned long end,
>>>>                      return ret;
>>>>      } while (pgd++, addr =3D next, addr !=3D end);
>>>>=20
>>>> -     flush_tlb_kernel_range(start, end);
>>>> +     if (walk->remap_pte)
>>>> +             flush_tlb_kernel_range(start, end);
>>>>=20
>>>>      return 0;
>>>>  }
>>>> @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, =
unsigned long addr,
>>>>      set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>>>  }
>>>>=20
>>>> +/**
>>>> + * vmemmap_remap_split - split the vmemmap virtual address range =
[@start, @end)
>>>> + *                      backing PMDs of the directmap into PTEs
>>>> + * @start:     start address of the vmemmap virtual address range =
that we want
>>>> + *             to remap.
>>>> + * @end:       end address of the vmemmap virtual address range =
that we want to
>>>> + *             remap.
>>>> + * @reuse:     reuse address.
>>>> + *
>>>> + * Return: %0 on success, negative error code otherwise.
>>>> + */
>>>> +static int vmemmap_remap_split(unsigned long start, unsigned long =
end,
>>>> +                             unsigned long reuse)
>>>> +{
>>>> +     int ret;
>>>> +     struct vmemmap_remap_walk walk =3D {
>>>> +             .remap_pte      =3D NULL,
>>>> +     };
>>>> +
>>>> +     /* See the comment in the vmemmap_remap_free(). */
>>>> +     BUG_ON(start - reuse !=3D PAGE_SIZE);
>>>> +
>>>> +     mmap_read_lock(&init_mm);
>>>> +     ret =3D vmemmap_remap_range(reuse, end, &walk);
>>>> +     mmap_read_unlock(&init_mm);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>>  /**
>>>>   * vmemmap_remap_free - remap the vmemmap virtual address range =
[@start, @end)
>>>>   *                  to the page which @reuse is mapped to, then =
free vmemmap
>>>> @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct =
hstate *h, struct page *head)
>>>>      free_vmemmap_page_list(&vmemmap_pages);
>>>>  }
>>>>=20
>>>> +static void hugetlb_vmemmap_split(const struct hstate *h, struct =
page *head)
>>>> +{
>>>> +     unsigned long vmemmap_start =3D (unsigned long)head, =
vmemmap_end;
>>>> +     unsigned long vmemmap_reuse;
>>>> +
>>>> +     if (!vmemmap_should_optimize(h, head))
>>>> +             return;
>>>> +
>>>> +     vmemmap_end     =3D vmemmap_start + hugetlb_vmemmap_size(h);
>>>> +     vmemmap_reuse   =3D vmemmap_start;
>>>> +     vmemmap_start   +=3D HUGETLB_VMEMMAP_RESERVE_SIZE;
>>>> +
>>>> +     /*
>>>> +      * Split PMDs on the vmemmap virtual address range =
[@vmemmap_start,
>>>> +      * @vmemmap_end]
>>>> +      */
>>>> +     vmemmap_remap_split(vmemmap_start, vmemmap_end, =
vmemmap_reuse);
>>>> +}
>>>> +
>>>>  void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct =
list_head *folio_list)
>>>>  {
>>>>      struct folio *folio;
>>>>      LIST_HEAD(vmemmap_pages);
>>>>=20
>>>> +     list_for_each_entry(folio, folio_list, lru)
>>>> +             hugetlb_vmemmap_split(h, &folio->page);
>>>=20
>>> Maybe it is reasonable to add a return value to =
hugetlb_vmemmap_split()
>>> to indicate whether it has done successfully, if it fails, it must =
be
>>> OOM, in which case, there is no sense to continue to split the page =
table
>>> and optimize the vmemmap pages subsequently, right?
>>=20
>> Sorry, it is reasonable to continue to optimize the vmemmap pages
>> subsequently since it should succeed because those vmemmap pages
>> have been split successfully previously.
>>=20
>> Seems we should continue to optimize vmemmap once =
hugetlb_vmemmap_split()
>> fails, then we will have more memory to continue to split.=20
>=20
> Good point
>=20
>> But it will
>> make hugetlb_vmemmap_optimize_folios() a little complex. I'd like to
>> hear you guys' opinions here.
>>=20
> I think it won't add that much complexity if we don't optimize too =
much of the
> slowpath (when we are out of memory). In the batch freeing patch we =
could
> additionally test the return value of __hugetlb_vmemmap_optimize() for =
ENOMEM
> and free the currently stored vmemmap_pages (if any), and keep =
iterating the
> optimize loop. Should be simple enough and make this a bit more =
resilient to
> that scenario.

Yep, we could try this.

> But we would need to keep the earlier check you commented above
> (where we use @remap_pte to defer PMD flush).

I think 2 flags will suitable for you, one is =
VMEMMAP_REMAP_NO_TLB_FLUSH,
another is VMEMMAP_SPLIT_NO_TLB_FLUSH.

Thanks.

>=20
>> Thanks.
>>=20
>>>=20
>>> Thanks.
>>>=20
>>>> +
>>>> +     flush_tlb_all();
>>>> +
>>>>      list_for_each_entry(folio, folio_list, lru)
>>>>              __hugetlb_vmemmap_optimize(h, &folio->page, =
&vmemmap_pages);


