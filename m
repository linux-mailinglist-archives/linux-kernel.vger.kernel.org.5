Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3779A1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjIKDKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjIKDKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:10:41 -0400
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [IPv6:2001:41d0:203:375::e1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914F103
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:10:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694401833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7uvq5FhhnljMN3Um+NMD1L9HxaijOwDWaM8/TobTFo=;
        b=j7U67lS0wfc2hHBLw72gaCHQEi0Eujt+ayOWyXCZeuwGBGx0Mv2vOKHyCh1z8plGBlgPsw
        LKMD3BTXrypijV/6QIoL+g6erYBfwO8bnC8i3ehQCIaDZQOwvsY3GmJ+JlQ8t6UoALtGmz
        Io2ssCgauX8CWcLcaUMfVPvdrEeAHRc=
Mime-Version: 1.0
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230908205340.GA62663@monkey>
Date:   Mon, 11 Sep 2023 11:10:18 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFE00D00-1DFF-4AF8-BB10-5B76BF06E012@linux.dev>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
 <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
 <20230906211234.GC3612@monkey>
 <B8F68838-8C78-4BF1-AEC8-D89BCD49ECC7@linux.dev>
 <20230907185421.GD3640@monkey> <20230908205340.GA62663@monkey>
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



> On Sep 9, 2023, at 04:53, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 09/07/23 11:54, Mike Kravetz wrote:
>> On 09/07/23 11:33, Muchun Song wrote:
>>>=20
>>>=20
>>>> On Sep 7, 2023, at 05:12, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>>>>=20
>>>> On 09/06/23 16:07, Muchun Song wrote:
>>>>>> On Sep 6, 2023, at 15:33, Muchun Song <muchun.song@linux.dev> =
wrote:
>>>>>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>>>>>> When removing hugetlb pages from the pool, we first create a =
list
>>>>>>> of removed pages and then free those pages back to low level =
allocators.
>>>>>>> Part of the 'freeing process' is to restore vmemmap for all base =
pages
>>>>>>> if necessary.  Pass this list of pages to a new routine
>>>>>>> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can =
be
>>>>>>> performed in bulk.
>>>>>>>=20
>>>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>>> ---
>>>>>>> mm/hugetlb.c         |  3 +++
>>>>>>> mm/hugetlb_vmemmap.c | 13 +++++++++++++
>>>>>>> mm/hugetlb_vmemmap.h |  5 +++++
>>>>>>> 3 files changed, 21 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>>>> index 554be94b07bd..dd2dbc256172 100644
>>>>>>> --- a/mm/hugetlb.c
>>>>>>> +++ b/mm/hugetlb.c
>>>>>>> @@ -1838,6 +1838,9 @@ static void =
update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
>>>>>>> {
>>>>>>> struct folio *folio, *t_folio;
>>>>>>> + /* First restore vmemmap for all pages on list. */
>>>>>>> + hugetlb_vmemmap_restore_folios(h, list);
>>>>>>> +
>>>>>>> list_for_each_entry_safe(folio, t_folio, list, lru) {
>>>>>>> update_and_free_hugetlb_folio(h, folio, false);
>>>>>>> cond_resched();
>>>>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>>>>> index ac5577d372fe..79de984919ef 100644
>>>>>>> --- a/mm/hugetlb_vmemmap.c
>>>>>>> +++ b/mm/hugetlb_vmemmap.c
>>>>>>> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct =
hstate *h, struct page *head)
>>>>>>> return ret;
>>>>>>> }
>>>>>>> +/*
>>>>>>> + * This function will attempt to resore vmemmap for a list of =
folios.  There
>>>>>>> + * is no guarantee that restoration will be successful for all =
or any folios.
>>>>>>> + * This is used in bulk operations, and no feedback is given to =
the caller.
>>>>>>> + */
>>>>>>> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, =
struct list_head *folio_list)
>>>>>>> +{
>>>>>>> + struct folio *folio;
>>>>>>> +
>>>>>>> + list_for_each_entry(folio, folio_list, lru)
>>>>>>> + (void)hugetlb_vmemmap_restore(h, &folio->page);
>>>>>>=20
>>>>>> I am curious about the purpose of "void" here, seems it it not =
necessnary,
>>>>>> ritgh? We cound see so many palces where we do not add the void =
if the caller
>>>>>> does not care about the return value of the callee.
>>>>>=20
>>>>> Another question: should we stop restoring vmemmap pages when
>>>>> hugetlb_vmemmap_restore() fails? In which case, I suspect there
>>>>> is no memory probably, there is no need to continue, right?
>>>>=20
>>>> Recall that the list of hugetlb pages may be from multiple nodes.  =
My first
>>>> thought was that we should continue because memory allocation may =
fail on one
>>>> node but succeed on another.  However, with
>>>> =
https://lore.kernel.org/linux-mm/20230905031312.91929-1-yuancan@huawei.com=
/
>>>> memory allocation should fall back to other nodes.  So, yes I do =
believe it
>>>> would make sense to stop when hugetlb_vmemmap_restore returns =
ENOMEM as
>>>> we are unlikely to make forward progress.
>>>=20
>>> Agree.
>>>=20
>>>>=20
>>>> Today's behavior will try to restore vmemmap for all pages.  No =
stopping
>>>> on error.
>>>>=20
>>>> I have mixed thoughts on this.  Quitting on error 'seems =
reasonable'.
>>>> However, if we continue we 'might' be able to allocate vmemmap for =
one
>>>> hugetlb page.  And, if we free one hugetlb page that should provide
>>>> vmemmap for several more and we may be able to free most pages on =
the
>>>> list.
>>>=20
>>> Yes. A good point. But there should be a non-optimized huge page =
been
>>> freed somewhere in parallel, otherwise we still cannot allocate =
memory.
>>=20
>> It does not have to be another huge page being freed in parallel.  It
>> could be that when allocating vmemmap for a 1G hugetlb page we were =
one
>> (4K) page short of what was required.  If someone else frees a 4K =
page,
>> freeing the next 1G page may succeed.

Right. I missed that.

>> --=20
>> Mike Kravetz
>>=20
>>> However, the freeing operation happens after =
hugetlb_vmemmap_restore_folios.
>>> If we want to handle this, we should rework =
update_and_free_pages_bulk()
>>> to do a try when at least a huge pages is freed.
>=20
> This seemed familiar.  Recall this patch which Muchun Reviewed and =
James Acked,
> =
https://lore.kernel.org/linux-mm/20230718004942.113174-3-mike.kravetz@orac=
le.com/
>=20
> If we can not restore vmemmap for a page, then it must be turned into =
a
> surplus huge page.  In this patch (not the previous one referenced), =
we
> will try to restore vmemmap one more time in a later call to
> update_and_free_hugetlb_folio.  Certainly, we do not want to try =
twice!
>=20
> My 'plan' is to include the previous patch as part of this series.  =
With
> that patch in place, the list_for_each_entry calls to =
hugetlb_vmemmap_restore
> can be replaced with a call to hugetlb_vmemmap_restore_folios.  We =
would
> change the behavior of hugetlb_vmemmap_restore_folios to return an =
error
> instead of being of type void.  If an error is returned, then we will
> make another pass through the list looking for unoptimized pages and =
add
> them as surplus.
>=20
> I think it best if we try to restore vmemmap at least once before
> converting to a surplus page.

Make sense.

Muchun

> --=20
> Mike Kravetz

