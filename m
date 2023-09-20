Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1E7A70D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjITDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjITDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:05:53 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [IPv6:2001:41d0:1004:224b::db])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB310C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:05:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695179146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDBdAOX8X4/yrrTFzJbuMsKMOkcsSNgaTZUefdy6Nao=;
        b=azFm46innPw/65tmW3UAt68ipYmSNr80v//8HmFizwfiNGkGw0fe2zrfnr7UfHOdeBPqpj
        F9QzphTq0VG+xK+qAXTuI4XP7d5x8Pu7odblTZmZF3GKJ/fwZhrEcBXlxcHiAnQb7kjvgi
        U28tex+IzTVGMKeyEg+PEObm9Q7TFNo=
Mime-Version: 1.0
Subject: Re: [PATCH v4 3/8] hugetlb: perform vmemmap optimization on a list of
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230919204954.GA425719@monkey>
Date:   Wed, 20 Sep 2023 11:05:30 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <57BC1D0C-23B2-4363-8B14-9602B69D53D5@linux.dev>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-4-mike.kravetz@oracle.com>
 <e284396d-c32d-b69d-21c6-7025db93b873@linux.dev>
 <20230919204954.GA425719@monkey>
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



> On Sep 20, 2023, at 04:49, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 09/19/23 11:10, Muchun Song wrote:
>>=20
>>=20
>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>> When adding hugetlb pages to the pool, we first create a list of the
>>> allocated pages before adding to the pool.  Pass this list of pages =
to a
>>> new routine hugetlb_vmemmap_optimize_folios() for vmemmap =
optimization.
>>>=20
>>> Due to significant differences in vmemmmap initialization for =
bootmem
>>> allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
>>> is created.
>>>=20
>>> We also modify the routine vmemmap_should_optimize() to check for =
pages
>>> that are already optimized.  There are code paths that might request
>>> vmemmap optimization twice and we want to make sure this is not
>>> attempted.
>>>=20
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb.c         | 50 =
+++++++++++++++++++++++++++++++++++++-------
>>>  mm/hugetlb_vmemmap.c | 11 ++++++++++
>>>  mm/hugetlb_vmemmap.h |  5 +++++
>>>  3 files changed, 58 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 8624286be273..d6f3db3c1313 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2269,6 +2269,11 @@ static void =
prep_and_add_allocated_folios(struct hstate *h,
>>>  {
>>>   struct folio *folio, *tmp_f;
>>> + /*
>>> +  * Send list for bulk vmemmap optimization processing
>>> +  */
>>=20
>> =46rom the kernel development document, one-line comment format is =
"/**/".
>>=20
>=20
> Will change the comments introduced here.

BTW, there are some places as well, please updates all, thanks.

>=20
>>> + hugetlb_vmemmap_optimize_folios(h, folio_list);
>>> +
>>>   /*
>>>    * Add all new pool pages to free lists in one lock cycle
>>>    */
>>> @@ -3309,6 +3314,40 @@ static void __init =
hugetlb_folio_init_vmemmap(struct folio *folio,
>>>   prep_compound_head((struct page *)folio, huge_page_order(h));
>>>  }
>>> +static void __init prep_and_add_bootmem_folios(struct hstate *h,
>>> + struct list_head *folio_list)
>>> +{
>>> + struct folio *folio, *tmp_f;
>>> +
>>> + /*
>>> +  * Send list for bulk vmemmap optimization processing
>>> +  */
>>> + hugetlb_vmemmap_optimize_folios(h, folio_list);
>>> +
>>> + /*
>>> +  * Add all new pool pages to free lists in one lock cycle
>>> +  */
>>> + spin_lock_irq(&hugetlb_lock);
>>> + list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>>> + if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>>> + /*
>>> +  * If HVO fails, initialize all tail struct pages
>>> +  * We do not worry about potential long lock hold
>>> +  * time as this is early in boot and there should
>>> +  * be no contention.
>>> +  */
>>> + hugetlb_folio_init_tail_vmemmap(folio,
>>> + HUGETLB_VMEMMAP_RESERVE_PAGES,
>>> + pages_per_huge_page(h));
>>> + }
>>> + __prep_account_new_huge_page(h, folio_nid(folio));
>>> + enqueue_hugetlb_folio(h, folio);
>>> + }
>>> + spin_unlock_irq(&hugetlb_lock);
>>> +
>>> + INIT_LIST_HEAD(folio_list);
>>=20
>> I'm not sure what is the purpose of the reinitialization to list =
head?
>>=20
>=20
> There really is no purpose.  This was copied from
> prep_and_add_allocated_folios which also has this unnecessary call.  =
It is
> unnecessary as enqueue_hugetlb_folio() will do a list_move for each
> folio on the list.  Therefore, at the end of the loop we KNOW the list
> is empty.

Right.

>=20
> I will remove here and in prep_and_add_allocated_folios.

Thanks.

>=20
> Thanks,
> --=20
> Mike Kravetz


