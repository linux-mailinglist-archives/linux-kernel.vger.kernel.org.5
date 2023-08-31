Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8765C78E9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjHaKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjHaKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:01:56 -0400
Received: from out-243.mta0.migadu.com (out-243.mta0.migadu.com [91.218.175.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209BCEE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:01:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693476111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKc1BtceIQGmsRun6QDSzaR2M4uTT4/ClHb8w8QgRJs=;
        b=MIeAL94hzGLpBkuqvJopyawFDuReZXKLmlTgY6nxwsBpwp1nfnT1q1Op78u96Kfi/j63Jt
        JYYAsAEDps3s8X8P+MrVz29CWb5sDbVWvl9zQiSOAuIh4WVVJwTWP0ksd6Npdv0jZgrpT0
        2hNjfFi/8RlzuxCKZFy5KzBvkTcoeEk=
Mime-Version: 1.0
Subject: Re: [External] [v3 4/4] mm: hugetlb: Skip initialization of gigantic
 tail struct pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230831095801.76rtpgdsvdijbw5t@techsingularity.net>
Date:   Thu, 31 Aug 2023 18:01:08 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Usama Arif <usama.arif@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07E9202B-CA8B-4E1E-93FC-7BF84CB8E988@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
 <A5CD653A-DAA6-481F-963E-AB04D2170088@linux.dev>
 <20230831095801.76rtpgdsvdijbw5t@techsingularity.net>
To:     Mel Gorman <mgorman@techsingularity.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 31, 2023, at 17:58, Mel Gorman <mgorman@techsingularity.net> =
wrote:
>=20
> On Thu, Aug 31, 2023 at 02:21:06PM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 30, 2023, at 18:27, Usama Arif <usama.arif@bytedance.com> =
wrote:
>>> On 28/08/2023 12:33, Muchun Song wrote:
>>>>> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> =
wrote:
>>>>>=20
>>>>> The new boot flow when it comes to initialization of gigantic =
pages
>>>>> is as follows:
>>>>> - At boot time, for a gigantic page during =
__alloc_bootmem_hugepage,
>>>>> the region after the first struct page is marked as noinit.
>>>>> - This results in only the first struct page to be
>>>>> initialized in reserve_bootmem_region. As the tail struct pages =
are
>>>>> not initialized at this point, there can be a significant saving
>>>>> in boot time if HVO succeeds later on.
>>>>> - Later on in the boot, HVO is attempted. If its successful, only =
the first
>>>>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct =
pages
>>>>> after the head struct page are initialized. If it is not =
successful,
>>>>> then all of the tail struct pages are initialized.
>>>>>=20
>>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>> This edition is simpler than before ever, thanks for your work.
>>>> There is premise that other subsystems do not access vmemmap pages
>>>> before the initialization of vmemmap pages associated withe HugeTLB
>>>> pages allocated from bootmem for your optimization. However, IIUC, =
the
>>>> compacting path could access arbitrary struct page when memory =
fails
>>>> to be allocated via buddy allocator. So we should make sure that
>>>> those struct pages are not referenced in this routine. And I know
>>>> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
>>>> the same issue, but I don't find any code to prevent this from
>>>> happening. I need more time to confirm this, if someone already =
knows,
>>>> please let me know, thanks. So I think HugeTLB should adopt the =
similar
>>>> way to prevent this.
>>>> Thanks.
>>>=20
>>> Thanks for the reviews.
>>>=20
>>> So if I understand it correctly, the uninitialized pages due to the =
optimization in this patch and due to DEFERRED_STRUCT_PAGE_INIT should =
be treated in the same way during compaction. I see that in =
isolate_freepages during compaction there is a check to see if PageBuddy =
flag is set and also there are calls like __pageblock_pfn_to_page to =
check if the pageblock is valid.
>>>=20
>>> But if the struct page is uninitialized then they would contain =
random data and these checks could pass if certain bits were set?
>>>=20
>>> Compaction is done on free list. I think the uninitialized struct =
pages atleast from DEFERRED_STRUCT_PAGE_INIT would be part of freelist, =
so I think their pfn would be considered for compaction.
>>>=20
>>> Could someone more familiar with DEFERRED_STRUCT_PAGE_INIT and =
compaction confirm how the uninitialized struct pages are handled when =
compaction happens? Thanks!
>>=20
>> Hi Mel,
>>=20
>> Could you help us answer this question? I think you must be the =
expert of
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT. I summarize the context here. As we =
all know,
>> some struct pages are uninnitialized when =
CONFIG_DEFERRED_STRUCT_PAGE_INIT is
>> enabled, if someone allocates a larger memory (e.g. order is 4) via =
buddy
>> allocator and fails to allocate the memory, then we will go into the =
compacting
>> routine, which will traverse all pfns and use pfn_to_page to access =
its struct
>> page, however, those struct pages may be uninnitialized (so it's =
arbitrary data).
>> Our question is how to prevent the compacting routine from accessing =
those
>> uninitialized struct pages? We'll be appreciated if you know the =
answer.
>>=20
>=20
> I didn't check the code but IIRC, the struct pages should be at least
> valid and not contain arbitrary data once page_alloc_init_late =
finishes.

However, the buddy allocator is ready before page_alloc_init_late(), so =
it
may access arbitrary data in compacting routine, right?

>=20
> --=20
> Mel Gorman
> SUSE Labs

