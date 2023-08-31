Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE85578E515
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbjHaD2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjHaD2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:28:39 -0400
Received: from out-247.mta0.migadu.com (out-247.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA7D185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:28:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693452513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIeM3nyX8rQsoSZOOJBtrylSeTVSP/9u4tsI5GW+b0I=;
        b=GDP1BPLu5hRvbUVAUyMhkrvbjzXXrHtH7tALDkLcCW81o/bTst5s5Hro+nPfQDIztk1Ma2
        GAB93DMcmsfObQWpmJsPT+khIly/x5V67WZuA/saNnSumiAYYwuAgGpHkTbkR/77NKKx3J
        NhGI7eKlwgsiGdcsCGwT5fzdpyzc+hQ=
Mime-Version: 1.0
Subject: Re: [PATCH 09/12] hugetlb_vmemmap: Optimistically set Optimized flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230830224706.GC55006@monkey>
Date:   Thu, 31 Aug 2023 11:27:52 +0800
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
Message-Id: <7D01FB21-5182-428D-BCD8-89C679ABEEC8@linux.dev>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-10-mike.kravetz@oracle.com>
 <8e298c9f-1ef3-5c99-d7b5-47fd6703cf83@linux.dev>
 <20230830224706.GC55006@monkey>
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



> On Aug 31, 2023, at 06:47, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 08/30/23 15:26, Muchun Song wrote:
>>=20
>>=20
>> On 2023/8/26 03:04, Mike Kravetz wrote:
>>> At the beginning of hugetlb_vmemmap_optimize, optimistically set
>>> the HPageVmemmapOptimized flag in the head page.  Clear the flag
>>> if the operation fails.
>>>=20
>>> No change in behavior.  However, this will become important in
>>> subsequent patches where we batch delay TLB flushing.  We need to
>>> make sure the content in the old and new vmemmap pages are the same.
>>=20
>> Sorry, I didn't get the point here. Could you elaborate it?
>>=20
>=20
> Sorry, this really could use a better explanation.
>=20
>>>=20
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb_vmemmap.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index e390170c0887..500a118915ff 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -566,7 +566,9 @@ static void __hugetlb_vmemmap_optimize(const =
struct hstate *h,
>>>   if (!vmemmap_should_optimize(h, head))
>>>   return;
>>> + /* Optimistically assume success */
>>>   static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>> + SetHPageVmemmapOptimized(head);
>>>   vmemmap_end =3D vmemmap_start + hugetlb_vmemmap_size(h);
>>>   vmemmap_reuse =3D vmemmap_start;
>>> @@ -577,10 +579,10 @@ static void __hugetlb_vmemmap_optimize(const =
struct hstate *h,
>>>    * to the page which @vmemmap_reuse is mapped to, then free the =
pages
>>>    * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>>>    */
>>> - if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, =
bulk_pages))
>>> + if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, =
bulk_pages)) {
>>>   static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>> - else
>>> - SetHPageVmemmapOptimized(head);
>>> + ClearHPageVmemmapOptimized(head);
>>> + }
>=20
> Consider the case where we have successfully remapped vmemmap AND
> - we have replaced the page table page (pte page) containing the =
struct
>  page of the hugetlb head page.  Joao's commit 11aad2631bf7
>  'mm/hugetlb_vmemmap: remap head page to newly allocated page'.
> - we have NOT flushed the TLB after remapping due to batching the
>  operations before flush.
>=20
> In this case, it is possible that the old head page is still in the =
TLB
> and caches and SetHPageVmemmapOptimized(head) will actually set the =
flag
> in the old pte page.  We then have an optimized hugetlb page without =
the
> HPageVmemmapOptimized flag set.  When developing this series, we
> experienced various BUGs as a result of this situation.

Now, I got it. Thanks for your elaboration.

>=20
> In the case of an error during optimization, we do a TLB flush so if
> we need to clear the flag we will write to the correct pte page.

Right.

>=20
> Hope that makes sense.
>=20
> I add an explanation like this to the commit message and perhaps put
> this closer to/or squash with the patch that batches operations before
> flushing TLB.

Yes. But I'd also like to add a big comment to explain what's going on =
here
instead of a simple "Optimistically assume success". This one really =
makes
me think it is an optimization not a mandatory premise.

Thanks.

> --=20
> Mike Kravetz
>=20
>>>  }
>>>  /**


