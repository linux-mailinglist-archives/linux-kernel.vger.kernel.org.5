Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76376796F49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjIGDeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:34:05 -0400
Received: from out-218.mta1.migadu.com (out-218.mta1.migadu.com [IPv6:2001:41d0:203:375::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7E1998
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:34:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694057639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhW4OFUYeYRsLujjWh8342NpTRqCb5qwMPST593N+Iw=;
        b=aFoKOlEEH0sST0kn8dxBc0tsmYKz+BnvyyHmV4ygebRCBEnCQL5+3u+WZIl9rcaMYtGyZj
        tyFreW/Fuo9S3b4n8OJMHOzHICpMRqqN6uj+usWWIDK9KigDtQqMjvpj2ApGkkiDHWyZKK
        dvkHNUtcfzH/LtcBDTAfTx93QYLEnQ0=
Mime-Version: 1.0
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230906211234.GC3612@monkey>
Date:   Thu, 7 Sep 2023 11:33:18 +0800
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
Message-Id: <B8F68838-8C78-4BF1-AEC8-D89BCD49ECC7@linux.dev>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
 <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
 <20230906211234.GC3612@monkey>
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



> On Sep 7, 2023, at 05:12, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 09/06/23 16:07, Muchun Song wrote:
>>> On Sep 6, 2023, at 15:33, Muchun Song <muchun.song@linux.dev> wrote:
>>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>>> When removing hugetlb pages from the pool, we first create a list
>>>> of removed pages and then free those pages back to low level =
allocators.
>>>> Part of the 'freeing process' is to restore vmemmap for all base =
pages
>>>> if necessary.  Pass this list of pages to a new routine
>>>> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
>>>> performed in bulk.
>>>>=20
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> ---
>>>> mm/hugetlb.c         |  3 +++
>>>> mm/hugetlb_vmemmap.c | 13 +++++++++++++
>>>> mm/hugetlb_vmemmap.h |  5 +++++
>>>> 3 files changed, 21 insertions(+)
>>>>=20
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 554be94b07bd..dd2dbc256172 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct =
hstate *h, struct list_head *list)
>>>> {
>>>>  struct folio *folio, *t_folio;
>>>> + /* First restore vmemmap for all pages on list. */
>>>> + hugetlb_vmemmap_restore_folios(h, list);
>>>> +
>>>>  list_for_each_entry_safe(folio, t_folio, list, lru) {
>>>>  update_and_free_hugetlb_folio(h, folio, false);
>>>>  cond_resched();
>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>> index ac5577d372fe..79de984919ef 100644
>>>> --- a/mm/hugetlb_vmemmap.c
>>>> +++ b/mm/hugetlb_vmemmap.c
>>>> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct =
hstate *h, struct page *head)
>>>>  return ret;
>>>> }
>>>> +/*
>>>> + * This function will attempt to resore vmemmap for a list of =
folios.  There
>>>> + * is no guarantee that restoration will be successful for all or =
any folios.
>>>> + * This is used in bulk operations, and no feedback is given to =
the caller.
>>>> + */
>>>> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct =
list_head *folio_list)
>>>> +{
>>>> + struct folio *folio;
>>>> +
>>>> + list_for_each_entry(folio, folio_list, lru)
>>>> + (void)hugetlb_vmemmap_restore(h, &folio->page);
>>>=20
>>> I am curious about the purpose of "void" here, seems it it not =
necessnary,
>>> ritgh? We cound see so many palces where we do not add the void if =
the caller
>>> does not care about the return value of the callee.
>>=20
>> Another question: should we stop restoring vmemmap pages when
>> hugetlb_vmemmap_restore() fails? In which case, I suspect there
>> is no memory probably, there is no need to continue, right?
>=20
> Recall that the list of hugetlb pages may be from multiple nodes.  My =
first
> thought was that we should continue because memory allocation may fail =
on one
> node but succeed on another.  However, with
> =
https://lore.kernel.org/linux-mm/20230905031312.91929-1-yuancan@huawei.com=
/
> memory allocation should fall back to other nodes.  So, yes I do =
believe it
> would make sense to stop when hugetlb_vmemmap_restore returns ENOMEM =
as
> we are unlikely to make forward progress.

Agree.

>=20
> Today's behavior will try to restore vmemmap for all pages.  No =
stopping
> on error.
>=20
> I have mixed thoughts on this.  Quitting on error 'seems reasonable'.
> However, if we continue we 'might' be able to allocate vmemmap for one
> hugetlb page.  And, if we free one hugetlb page that should provide
> vmemmap for several more and we may be able to free most pages on the
> list.

Yes. A good point. But there should be a non-optimized huge page been
freed somewhere in parallel, otherwise we still cannot allocate memory.
However, the freeing operation happens after =
hugetlb_vmemmap_restore_folios.
If we want to handle this, we should rework update_and_free_pages_bulk()
to do a try when at least a huge pages is freed.

Thanks.

> --=20
> Mike Kravetz

