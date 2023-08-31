Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16078E66D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjHaGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbjHaGWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:22:34 -0400
Received: from out-249.mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8927170C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:21:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693462911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpQNp0A8i0S7SQfKTwp86WbNGnfzkLE8YkfFQsWuvUM=;
        b=X140LA5XVSse65boP6zP2hcTtma2Vup+iEfNBHXkmt0K3YzHrytzoMCTuIRmymld+BWC9O
        BSseNNTlDRlB4rJ90jaxCNTS7a6as5yKaFlXaFcbmlQ/tFnvOv8nfND+MM8RcvqHyUzesV
        jh57Am7jhW9FRzWn8Vw7VVDzAAJ/1KA=
Mime-Version: 1.0
Subject: Re: [External] [v3 4/4] mm: hugetlb: Skip initialization of gigantic
 tail struct pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
Date:   Thu, 31 Aug 2023 14:21:06 +0800
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
Message-Id: <A5CD653A-DAA6-481F-963E-AB04D2170088@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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



> On Aug 30, 2023, at 18:27, Usama Arif <usama.arif@bytedance.com> =
wrote:
> On 28/08/2023 12:33, Muchun Song wrote:
>>> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> =
wrote:
>>>=20
>>> The new boot flow when it comes to initialization of gigantic pages
>>> is as follows:
>>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>>> the region after the first struct page is marked as noinit.
>>> - This results in only the first struct page to be
>>> initialized in reserve_bootmem_region. As the tail struct pages are
>>> not initialized at this point, there can be a significant saving
>>> in boot time if HVO succeeds later on.
>>> - Later on in the boot, HVO is attempted. If its successful, only =
the first
>>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct =
pages
>>> after the head struct page are initialized. If it is not successful,
>>> then all of the tail struct pages are initialized.
>>>=20
>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> This edition is simpler than before ever, thanks for your work.
>> There is premise that other subsystems do not access vmemmap pages
>> before the initialization of vmemmap pages associated withe HugeTLB
>> pages allocated from bootmem for your optimization. However, IIUC, =
the
>> compacting path could access arbitrary struct page when memory fails
>> to be allocated via buddy allocator. So we should make sure that
>> those struct pages are not referenced in this routine. And I know
>> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
>> the same issue, but I don't find any code to prevent this from
>> happening. I need more time to confirm this, if someone already =
knows,
>> please let me know, thanks. So I think HugeTLB should adopt the =
similar
>> way to prevent this.
>> Thanks.
>=20
> Thanks for the reviews.
>=20
> So if I understand it correctly, the uninitialized pages due to the =
optimization in this patch and due to DEFERRED_STRUCT_PAGE_INIT should =
be treated in the same way during compaction. I see that in =
isolate_freepages during compaction there is a check to see if PageBuddy =
flag is set and also there are calls like __pageblock_pfn_to_page to =
check if the pageblock is valid.
>=20
> But if the struct page is uninitialized then they would contain random =
data and these checks could pass if certain bits were set?
>=20
> Compaction is done on free list. I think the uninitialized struct =
pages atleast from DEFERRED_STRUCT_PAGE_INIT would be part of freelist, =
so I think their pfn would be considered for compaction.
>=20
> Could someone more familiar with DEFERRED_STRUCT_PAGE_INIT and =
compaction confirm how the uninitialized struct pages are handled when =
compaction happens? Thanks!

Hi Mel,

Could you help us answer this question? I think you must be the expert =
of
CONFIG_DEFERRED_STRUCT_PAGE_INIT. I summarize the context here. As we =
all know,
some struct pages are uninnitialized when =
CONFIG_DEFERRED_STRUCT_PAGE_INIT is
enabled, if someone allocates a larger memory (e.g. order is 4) via =
buddy
allocator and fails to allocate the memory, then we will go into the =
compacting
routine, which will traverse all pfns and use pfn_to_page to access its =
struct
page, however, those struct pages may be uninnitialized (so it's =
arbitrary data).
Our question is how to prevent the compacting routine from accessing =
those
uninitialized struct pages? We'll be appreciated if you know the answer.

Thanks.


