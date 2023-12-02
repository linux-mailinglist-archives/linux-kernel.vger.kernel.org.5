Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33805801B66
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjLBIJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLBIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:09:04 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E1134
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:09:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701504547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brrTfRqIr/zFBCw4NqIsnKtK9OdzMgGTyuDsHZLvG2I=;
        b=ggUl4N+vJPm0ftTWLYo3HDQeywbMbi2luvGxr270YyfxY4vs0QfgfktQKw4+9zOgGDhyK4
        Wo+gf2GqkWSPhOaoGVmy3Scg3DC+7Mtv48VBtWoDrRiHA7TNaFdkDdVaNRxlonvTweMsFb
        vOSeEG+zEtMptLV3FnFJBWtff5DyqKg=
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] mm: pagewalk: assert write mmap lock only for walking
 the user page tables
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9e5c199a-9b4d-4d1b-97d4-dd2b776ac85f@huawei.com>
Date:   Sat, 2 Dec 2023 16:08:32 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AB1EE49-496E-46DE-B51E-42B06AA717D8@linux.dev>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-2-songmuchun@bytedance.com>
 <9e5c199a-9b4d-4d1b-97d4-dd2b776ac85f@huawei.com>
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



> On Dec 1, 2023, at 19:09, Kefeng Wang <wangkefeng.wang@huawei.com> =
wrote:
>=20
>=20
>=20
> On 2023/11/27 16:46, Muchun Song wrote:
>> The 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page =
walker")
>> introduces an assertion to walk_page_range_novma() to make all the =
users
>> of page table walker is safe. However, the race only exists for =
walking the
>> user page tables. And it is ridiculous to hold a particular user mmap =
write
>> lock against the changes of the kernel page tables. So only assert at =
least
>> mmap read lock when walking the kernel page tables. And some users =
matching
>> this case could downgrade to a mmap read lock to relief the =
contention of
>> mmap lock of init_mm, it will be nicer in hugetlb (only holding mmap =
read
>> lock) in the next patch.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/pagewalk.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index b7d7e4fcfad7a..f46c80b18ce4f 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -539,6 +539,11 @@ int walk_page_range(struct mm_struct *mm, =
unsigned long start,
>>   * not backed by VMAs. Because 'unusual' entries may be walked this =
function
>>   * will also not lock the PTEs for the pte_entry() callback. This is =
useful for
>>   * walking the kernel pages tables or page tables for firmware.
>> + *
>> + * Note: Be careful to walk the kernel pages tables, the caller may =
be need to
>> + * take other effective approache (mmap lock may be insufficient) to =
prevent
>> + * the intermediate kernel page tables belonging to the specified =
address range
>> + * from being freed (e.g. memory hot-remove).
>>   */
>>  int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>>    unsigned long end, const struct mm_walk_ops *ops,
>> @@ -556,7 +561,29 @@ int walk_page_range_novma(struct mm_struct *mm, =
unsigned long start,
>>   if (start >=3D end || !walk.mm)
>>   return -EINVAL;
>>  - mmap_assert_write_locked(walk.mm);
>> + /*
>> + * 1) For walking the user virtual address space:
>> + *
>> + * The mmap lock protects the page walker from changes to the page
>> + * tables during the walk.  However a read lock is insufficient to
>> + * protect those areas which don't have a VMA as munmap() detaches
>> + * the VMAs before downgrading to a read lock and actually tearing
>> + * down PTEs/page tables. In which case, the mmap write lock should
>> + * be hold.
>> + *
>> + * 2) For walking the kernel virtual address space:
>> + *
>> + * The kernel intermediate page tables usually do not be freed, so
>> + * the mmap map read lock is sufficient. But there are some =
exceptions.
>> + * E.g. memory hot-remove. In which case, the mmap lock is =
insufficient
>> + * to prevent the intermediate kernel pages tables belonging to the
>> + * specified address range from being freed. The caller should take
>> + * other actions to prevent this race.
>> + */
>> + if (mm =3D=3D &init_mm)
>> + 	mmap_assert_locked(walk.mm);
>> + else
>> + 	mmap_assert_write_locked(walk.mm);
>=20
> Maybe just use process_mm_walk_lock() and set correct page_walk_lock =
in struct mm_walk_ops?

No. You also need to make sure the users do not pass the wrong
walk_lock, so you also need to add something like following:

if (mm =3D=3D &init_mm)
	VM_BUG_ON(walk_lock !=3D PGWALK_RDLOCK);
else
	VM_BUG_ON(walk_lock =3D=3D PGWALK_RDLOCK);

I do not think the code will be simple.

>=20
>>     return walk_pgd_range(start, end, &walk);
>>  }

