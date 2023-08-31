Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1378E530
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbjHaDzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbjHaDzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:55:10 -0400
Received: from out-245.mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7931DCC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:55:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693454105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5ttZ6ggIxksvgixGRYxXupGBIp2Nf+x9zH0x4jn6+E=;
        b=G1qJF6nIrNpnQbcGfM61fjDUQAwecbqLnDhnEp33tl8Uwdy04PdQV7MZpOP87jVIJfVkhk
        Xvh+eT5s6C8uVH7QGNnF8CJdA1yYSp9nw/bRzQ41Wp60hFF6OFUqwXH31nAKS4VCXyUKvv
        u+xDDeBgli2fvRMnC2F7ez2U4VVRagY=
Mime-Version: 1.0
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <254b1ef9-376f-a47b-ee54-ea34b40b3f72@oracle.com>
Date:   Thu, 31 Aug 2023 11:54:28 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70844AE7-794D-475D-A660-F02EED4BA301@linux.dev>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-11-mike.kravetz@oracle.com>
 <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
 <e20692b8-ae64-b2e9-4177-062bf0c937ba@oracle.com>
 <254b1ef9-376f-a47b-ee54-ea34b40b3f72@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 31, 2023, at 00:03, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>=20
> On 30/08/2023 12:13, Joao Martins wrote:
>> On 30/08/2023 09:09, Muchun Song wrote:
>>> On 2023/8/26 03:04, Mike Kravetz wrote:
>>>> +
>>>> +        /*
>>>> +         * We are only splitting, not remapping the hugetlb =
vmemmap
>>>> +         * pages.
>>>> +         */
>>>> +        if (bulk)
>>>> +            continue;
>>>=20
>>> Actually, we don not need a flag to detect this situation, you could
>>> use "!@walk->remap_pte" to determine whether we should go into the
>>> next level traversal of the page table. ->remap_pte is used to =
traverse
>>> the pte entry, so it make senses to continue to the next pmd entry =
if
>>> it is NULL.
>>>=20
>>=20
>> Yeap, great suggestion.
>>=20
>>>> +
>>>>           vmemmap_pte_range(pmd, addr, next, walk);
>>>>       } while (pmd++, addr =3D next, addr !=3D end);
>>>>   @@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long =
start,
>>>> unsigned long end,
>>>>               return ret;
>>>>       } while (pgd++, addr =3D next, addr !=3D end);
>>>>   -    flush_tlb_kernel_range(start, end);
>>>> +    if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
>>>> +        flush_tlb_kernel_range(start, end);
>>>=20
>>> This could be:
>>>=20
>>>     if (walk->remap_pte)
>>>         flush_tlb_kernel_range(start, end);
>>>=20
>> Yeap.
>>=20
>=20
> Quite correction: This stays as is, except with a flag rename. That is =
because
> this is actual flush that we intend to batch in the next patch. And =
while the
> PMD split could just use !walk->remap_pte, the next patch would just =
need to
> test NO_TLB_FLUSH flag. Meaning we endup anyways just testing for this
> to-be-consolidated flag

I think this really should be "if (walk->remap_pte && !(flag & =
VMEMMAP_NO_TLB_FLUSH))"
in your next patch. This TLB flushing only make sense for the case of =
existing of
@walk->remap_pte. I know "if (!(flag & VMEMMAP_NO_TLB_FLUSH))" check is =
suitable for your
use case, but what if a user (even if it does not exist now, but it may =
in the future)
passing a NULL @walk->remap_pte and not specifying VMEMMAP_NO_TLB_FLUSH? =
Then we will
do a useless TLB flushing. This is why I suggest you change this to "if =
(walk->remap_pte)"
in this patch and change it to "if (walk->remap_pte && !(flag & =
VMEMMAP_NO_TLB_FLUSH))"
in the next patch.

Thanks.




