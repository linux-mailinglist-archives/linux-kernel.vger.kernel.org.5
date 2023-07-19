Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D142758E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGSHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGSHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:00:49 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179EE69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:00:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689750046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oR02ocyNOo67ut2irvQW1I2L6Nr8rh1y4Mq6MMgZptA=;
        b=P28LWt5j97mE8Bogv4TUnkw9D03W3cY38+SvKocgJGJA0cZAytNGa3JzPU3glSKdjNpsiW
        4fFlcxi11dmnQbm7yTHremnym57grfNXGsi9EP38Wsa1OIuRqtQnPzKhicLduPK4/nQfxX
        Gcm7Tjfald/RpBWB/3cLmurPL05tPH4=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb_vmemmap: use PageCompound() instead of
 PageReserved()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2b66797b-3ee9-a70f-25d0-dcab830859d2@redhat.com>
Date:   Wed, 19 Jul 2023 15:00:04 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A363D1BA-80B6-4E71-B587-EF04530BBA77@linux.dev>
References: <20230719063132.37676-1-songmuchun@bytedance.com>
 <2b66797b-3ee9-a70f-25d0-dcab830859d2@redhat.com>
To:     =?utf-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 19, 2023, at 14:51, Mika Penttil=C3=A4 <mpenttil@redhat.com> =
wrote:
>=20
> Hi,
>=20
>=20
> On 19.7.2023 9.31, Muchun Song wrote:
>> The ckeck of PageReserved() is easy to be broken in the future, =
PageCompound()
>> is more stable to check if the page should be split.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/hugetlb_vmemmap.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 4b9734777f69..8068fe890f52 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -73,8 +73,10 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, =
unsigned long start)
>>   * be treated as indepdenent small pages (as they can be freed
>>   * individually).
>>   */
>> - if (!PageReserved(head))
>> + if (PageCompound(head)) {
>> + 	VM_BUG_ON(compound_order(head) !=3D get_order(PMD_SIZE));
>>   	split_page(head, get_order(PMD_SIZE));
>=20
> I think vmemmap pages are not compound pages (even order > 0).
> They would bug on here trying to split_page() :

You are right. I have missed this. Now I remember why I use
PageReserved() instead of PageCompound() when I fist submit
the commit 39d35edee453. Thanks for your reminder.

Sorry for the noise. Please ignore this patch.

Thanks.

>=20
>=20
> void split_page(struct page *page, unsigned int order)
> {
>        int i;
>=20
>        VM_BUG_ON_PAGE(PageCompound(page), page);
>=20
>=20
>> + }
>>     /* Make pte visible before pmd. See comment in pmd_install(). */
>>   smp_wmb();
>=20
> --Mika
>=20

