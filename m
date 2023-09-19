Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786A7A5D24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjISI56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjISI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:57:48 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B1129
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:57:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695113858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhG63ZKSBvU91SDuaCV2UVUbpZEeTJ9JdWWGs2XqxmU=;
        b=uGdjC6QrZs4BreUkw8Io9PPSZ3Cw7OlodJ7r9RJeihtKLtehE0lQalsQIYhoQl3Yx3+wqO
        Qcpkj7awzZ3lb66E8mMQCckiiA4N4EgN4sUclQo5t/yjEel+9uAglU6TO9VyRvMpHB+mWa
        lJxrBYS1Wkn7DVHqptDPsQoCsPMIZWw=
Mime-Version: 1.0
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
Date:   Tue, 19 Sep 2023 16:57:00 +0800
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
Message-Id: <83B874B6-FF22-4588-90A9-31644D598032@linux.dev>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
 <d8ca9ff5-3160-49a1-947a-de4998887dce@oracle.com>
 <07192BE2-C66E-4F74-8F76-05F57777C6B7@linux.dev>
 <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
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



> On Sep 19, 2023, at 16:55, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>=20
> On 19/09/2023 09:41, Muchun Song wrote:
>>> On Sep 19, 2023, at 16:26, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>>> On 19/09/2023 07:42, Muchun Song wrote:
>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>=20
>>>>> In an effort to minimize amount of TLB flushes, batch all PMD =
splits
>>>>> belonging to a range of pages in order to perform only 1 (global) =
TLB
>>>>> flush.
>>>>>=20
>>>>> Add a flags field to the walker and pass whether it's a bulk =
allocation
>>>>> or just a single page to decide to remap. First value
>>>>> (VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the =
TLB
>>>>> flush when we split the PMD.
>>>>>=20
>>>>> Rebased and updated by Mike Kravetz
>>>>>=20
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> ---
>>>>> mm/hugetlb_vmemmap.c | 79 =
+++++++++++++++++++++++++++++++++++++++++---
>>>>> 1 file changed, 75 insertions(+), 4 deletions(-)
>>>>>=20
>>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>>> index 147ed15bcae4..e8bc2f7567db 100644
>>>>> --- a/mm/hugetlb_vmemmap.c
>>>>> +++ b/mm/hugetlb_vmemmap.c
>>>>> @@ -27,6 +27,7 @@
>>>>>  * @reuse_addr:        the virtual address of the @reuse_page =
page.
>>>>>  * @vmemmap_pages:    the list head of the vmemmap pages that can =
be freed
>>>>>  *            or is mapped from.
>>>>> + * @flags:        used to modify behavior in bulk operations
>>>>=20
>>>> Better to describe it as "used to modify behavior in vmemmap page =
table walking
>>>> operations"
>>>>=20
>>> OK
>>>=20
>>>>> void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct =
list_head
>>>>> *folio_list)
>>>>> {
>>>>>     struct folio *folio;
>>>>>     LIST_HEAD(vmemmap_pages);
>>>>> +    list_for_each_entry(folio, folio_list, lru)
>>>>> +        hugetlb_vmemmap_split(h, &folio->page);
>>>>> +
>>>>> +    flush_tlb_all();
>>>>> +
>>>>>     list_for_each_entry(folio, folio_list, lru) {
>>>>>         int ret =3D __hugetlb_vmemmap_optimize(h, &folio->page,
>>>>>                                 &vmemmap_pages);
>>>>=20
>>>> This is unlikely to be failed since the page table allocation
>>>> is moved to the above=20
>>>=20
>>>> (Note that the head vmemmap page allocation
>>>> is not mandatory).=20
>>>=20
>>> Good point that I almost forgot
>>>=20
>>>> So we should handle the error case in the above
>>>> splitting operation.
>>>=20
>>> But back to the previous discussion in v2... the thinking was that =
/some/ PMDs
>>> got split, and say could allow some PTE remapping to occur and free =
some pages
>>> back (each page allows 6 more splits worst case). Then the next
>>> __hugetlb_vmemmap_optimize() will have to split PMD pages again for =
those
>>> hugepages that failed the batch PMD split (as we only defer the PTE =
remap tlb
>>> flush in this stage).
>>=20
>> Oh, yes. Maybe we could break the above traversal as early as =
possible
>> once we enter an ENOMEM?
>>=20
>=20
> Sounds good -- no point in keep trying to split if we are failing with =
OOM.
>=20
> Perhaps a comment in both of these clauses (the early break on split =
and the OOM
> handling in batch optimize) could help make this clear.

Make sense.

Thanks.

>=20
>>>=20
>>> Unless this isn't something worth handling
>>>=20
>>> Joao


