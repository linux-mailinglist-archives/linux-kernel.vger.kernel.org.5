Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F3797477
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbjIGPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbjIGPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:34:50 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEB19A9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:34:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694067629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/F7h9TiNNa7lrbVKcJMgQDBJdRxF3UEGbRAi+uX3qX4=;
        b=nEPh6ulcfFBu6ATTQcm5TTFdu2fIloClDLDU9Ug//uYrL448O/rda4rgK6bUZ7nY9XM+MK
        rdD1nHgwFT+BnaJSNrmW5M8LHpsF0K3pxLTm4yj8vWjUDlw78KzosrMnsjRKmLE153Ab4v
        iTzNOj+aND5yigiJuQK7YFHqMA/xX+Y=
Mime-Version: 1.0
Subject: Re: [PATCH v2 08/11] hugetlb: batch freeing of vmemmap pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230906213855.GD3612@monkey>
Date:   Thu, 7 Sep 2023 14:19:45 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
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
Message-Id: <9F499C49-3046-4EF2-8C2A-3458A954B2DE@linux.dev>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-9-mike.kravetz@oracle.com>
 <b9b7351b-ddee-64c7-e78a-00df85c56e94@linux.dev>
 <20230906213855.GD3612@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 7, 2023, at 05:38, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 09/06/23 15:38, Muchun Song wrote:
>>=20
>>=20
>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>> Now that batching of hugetlb vmemmap optimization processing is =
possible,
>>> batch the freeing of vmemmap pages.  When freeing vmemmap pages for =
a
>>> hugetlb page, we add them to a list that is freed after the entire =
batch
>>> has been processed.
>>>=20
>>> This enhances the ability to return contiguous ranges of memory to =
the
>>> low level allocators.
>>>=20
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb_vmemmap.c | 60 =
++++++++++++++++++++++++++++----------------
>>>  1 file changed, 38 insertions(+), 22 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index 79de984919ef..a715712df831 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -306,18 +306,21 @@ static void vmemmap_restore_pte(pte_t *pte, =
unsigned long addr,
>>>   * @end: end address of the vmemmap virtual address range that we =
want to
>>>   * remap.
>>>   * @reuse: reuse address.
>>> + * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It =
is callers
>>> + * responsibility to free pages.
>>>   *
>>>   * Return: %0 on success, negative error code otherwise.
>>>   */
>>>  static int vmemmap_remap_free(unsigned long start, unsigned long =
end,
>>> -       unsigned long reuse)
>>> +       unsigned long reuse,
>>> +       struct list_head *vmemmap_pages)
>>>  {
>>>   int ret;
>>> - LIST_HEAD(vmemmap_pages);
>>> + LIST_HEAD(freed_pages);
>>=20
>> IIUC, we could reuse the parameter of @vmemmap_pages directly instead =
of
>> a temporary variable, could it be dropped?
>>=20
>=20
> I was concerned about the error case where we call vmemmap_remap_range =
a
> second time.  In the first call to vmemmap_remap_range with =
vmemmap_remap_pte,
> vmemmap pages to be freed are added to the end of the list =
(list_add_tail).
> In the call to vmemmap_remap_range after error with =
vmemmap_restore_pte,
> pages are taken off the head of the list (list_first_entry).  So, it =
seems
> that it would be possible to use a different set of pages in the =
restore

Yes.

> operation.  This would be an issue if pages had different =
characteristics such
> as being on different nodes.  Is that a real concern?

A good point. Now I see your concern, it is better to keep the same node
as before when error occurs.

>=20
> I suppose we could change vmemmap_remap_pte to add pages to the head =
of
> the list?  I do not recall the reasoning behind adding to tail.

I think we could do this, the code will be a little simple. Actually, =
there
is no reason behind adding to tail (BTW, the first commit is introduced =
by
me, no secret here :-)).

Thanks.

> --=20
> Mike Kravetz


