Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF90880454E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbjLECr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjLECrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:47:25 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88285CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:47:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701744450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+gZubsRH31odcoqRD7fvFFSzO5DYYZUYFSAk62Ge2s=;
        b=M41vbbN2M2qKox8gqmA+RhYSM3dMqetsHI+A/5QB16j4LcxCVBSrYBvGGHlktMG3qVWr2a
        fgVQja15ijmTOAb0+Cilr0TNpyX7gpaZqTjBpiZHylCvAMrdpr37YFRm/jHy9BlUqXVlek
        54JW757MdnpuGfGacTd+2/2/PMlGt94=
Mime-Version: 1.0
Subject: Re: [PATCH 3/4] mm: hugetlb_vmemmap: move PageVmemmapSelfHosted()
 check to split_vmemmap_huge_pmd()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231204232728.GD4129@monkey>
Date:   Tue, 5 Dec 2023 10:46:52 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2B8146D-0A41-4722-9E25-9D3F818C86C9@linux.dev>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-4-songmuchun@bytedance.com>
 <20231204232728.GD4129@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2023, at 07:27, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 11/27/23 16:46, Muchun Song wrote:
>> To check a page whether it is self-hosted needs to traverse the page =
table (e.g.
>> pmd_off_k()), however, we already have done this in the next calling =
of
>> vmemmap_remap_range().  Moving PageVmemmapSelfHosted() check to =
vmemmap_pmd_entry()
>> could simplify the code a bit.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/hugetlb_vmemmap.c | 70 =
+++++++++++++++-----------------------------
>> 1 file changed, 24 insertions(+), 46 deletions(-)
>>=20
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index ef14356855d13..ce920ca6c90ee 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -95,6 +95,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct =
page *head, unsigned long start,
>> static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
>>      unsigned long next, struct mm_walk *walk)
>> {
>> + int ret =3D 0;
>> struct page *head;
>> struct vmemmap_remap_walk *vmemmap_walk =3D walk->private;
>>=20
>> @@ -104,9 +105,30 @@ static int vmemmap_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>>=20
>> spin_lock(&init_mm.page_table_lock);
>> head =3D pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
>=20
> I was going to ask why you dropped the:
> if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> However, without the extra page table reads it really is not =
necessary.

I thought the compiler is smart enough to find out this code
is unnecessary so that it will be dropped. But I am wrong,
I did a test showing the compiler does optimize the code
when CONFIG_MEMORY_HOTPLUG is disabled, but it is not
enough compared with adding the check of =
"IS_ENABLED(CONFIG_MEMORY_HOTPLUG)".
I will add the check back in a separate patch (I suspect it is easy
for Andrew to merge).

>=20
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks.

> --=20
> Mike Kravetz


