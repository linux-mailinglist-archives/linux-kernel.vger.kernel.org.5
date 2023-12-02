Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE85801BCC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjLBJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjLBJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:47:46 -0500
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D57197
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 01:47:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701510469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWg0EL3RaVOmoE3sMtlw7YEVcWUVCDJ1DGg90IqvGCU=;
        b=t17SwvtPvSBpQHzsL7annwyRE/ek5+7JyWpHeAunX2V05pfdxiCyjCPubq0hiFQjG1U5vE
        dAQAciU0FmjcGOH3h+1AvMn5R6jmJCjPRGTYqVrQoiGgnYiC5cF4YSy0tHJ8quZ6n3mwFF
        F9yGO4WDWlwsVSlNeJfUpimQUbkHCr8=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] mm: pagewalk: assert write mmap lock only for walking the user page tables
Date:   Sat, 2 Dec 2023 17:47:07 +0800
Message-Id: <6D1D5629-56C0-457E-A1BD-A09255AB9A3D@linux.dev>
References: <bc999ed5-9601-4c8a-9f7d-c6f972daec33@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
In-Reply-To: <bc999ed5-9601-4c8a-9f7d-c6f972daec33@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
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



> On Dec 2, 2023, at 17:25, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>=20
> =EF=BB=BF
>=20
> On 2023/12/2 16:08, Muchun Song wrote:
>>>> On Dec 1, 2023, at 19:09, Kefeng Wang <wangkefeng.wang@huawei.com> wrot=
e:
>>>=20
>>>=20
>>>=20
>>> On 2023/11/27 16:46, Muchun Song wrote:
>>>> The 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walke=
r")
>>>> introduces an assertion to walk_page_range_novma() to make all the user=
s
>>>> of page table walker is safe. However, the race only exists for walking=
 the
>>>> user page tables. And it is ridiculous to hold a particular user mmap w=
rite
>>>> lock against the changes of the kernel page tables. So only assert at l=
east
>>>> mmap read lock when walking the kernel page tables. And some users matc=
hing
>>>> this case could downgrade to a mmap read lock to relief the contention o=
f
>>>> mmap lock of init_mm, it will be nicer in hugetlb (only holding mmap re=
ad
>>>> lock) in the next patch.
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> ---
>>>>  mm/pagewalk.c | 29 ++++++++++++++++++++++++++++-
>>>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>>>> index b7d7e4fcfad7a..f46c80b18ce4f 100644
>>>> --- a/mm/pagewalk.c
>>>> +++ b/mm/pagewalk.c
>>>> @@ -539,6 +539,11 @@ int walk_page_range(struct mm_struct *mm, unsigned=
 long start,
>>>>   * not backed by VMAs. Because 'unusual' entries may be walked this fu=
nction
>>>>   * will also not lock the PTEs for the pte_entry() callback. This is u=
seful for
>>>>   * walking the kernel pages tables or page tables for firmware.
>>>> + *
>>>> + * Note: Be careful to walk the kernel pages tables, the caller may be=
 need to
>>>> + * take other effective approache (mmap lock may be insufficient) to p=
revent
>>>> + * the intermediate kernel page tables belonging to the specified addr=
ess range
>>>> + * from being freed (e.g. memory hot-remove).
>>>>   */
>>>>  int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>>>>    unsigned long end, const struct mm_walk_ops *ops,
>>>> @@ -556,7 +561,29 @@ int walk_page_range_novma(struct mm_struct *mm, un=
signed long start,
>>>>   if (start >=3D end || !walk.mm)
>>>>   return -EINVAL;
>>>>  - mmap_assert_write_locked(walk.mm);
>>>> + /*
>>>> + * 1) For walking the user virtual address space:
>>>> + *
>>>> + * The mmap lock protects the page walker from changes to the page
>>>> + * tables during the walk.  However a read lock is insufficient to
>>>> + * protect those areas which don't have a VMA as munmap() detaches
>>>> + * the VMAs before downgrading to a read lock and actually tearing
>>>> + * down PTEs/page tables. In which case, the mmap write lock should
>>>> + * be hold.
>>>> + *
>>>> + * 2) For walking the kernel virtual address space:
>>>> + *
>>>> + * The kernel intermediate page tables usually do not be freed, so
>>>> + * the mmap map read lock is sufficient. But there are some exceptions=
.
>>>> + * E.g. memory hot-remove. In which case, the mmap lock is insufficien=
t
>>>> + * to prevent the intermediate kernel pages tables belonging to the
>>>> + * specified address range from being freed. The caller should take
>>>> + * other actions to prevent this race.
>>>> + */
>>>> + if (mm =3D=3D &init_mm)
>>>> +    mmap_assert_locked(walk.mm);
>>>> + else
>>>> +    mmap_assert_write_locked(walk.mm);
>>>=20
>>> Maybe just use process_mm_walk_lock() and set correct page_walk_lock in s=
truct mm_walk_ops?
>> No. You also need to make sure the users do not pass the wrong
>> walk_lock, so you also need to add something like following:
>=20
> But all other walk_page_XX has been converted=EF=BC=8Csee more from commit=

> 49b0638502da "mm: enable page walking API to lock vmas during the walk"),
> there's nothing special about this one, the calls must pass the right
> page_walk_lock to mm_walk_ops,

If you think this one is not special, why it is not converted by that commit=
 at that time?=20

>=20
>> if (mm =3D=3D &init_mm)
>>    VM_BUG_ON(walk_lock !=3D PGWALK_RDLOCK);
>> else
>>    VM_BUG_ON(walk_lock =3D=3D PGWALK_RDLOCK);
>> I do not think the code will be simple.
>=20
> or adding the above lock check into process_mm_walk_lock too.

No. it=E2=80=99s wrong. walk_page_range_novma is special compared with other=
 variants, the check is only applicable for walk_page_range_novma, not for i=
ts variants.=
