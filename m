Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14778BD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjH2DeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjH2Ddo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:33:44 -0400
Received: from out-248.mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7011C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:33:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693280017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbU8Li2pRJ88mITWQeQKv1yZgPCpNOVQ4jVcRFDLRV8=;
        b=lsH6FSk/Ob/4Bz2BuQiJvTRRTAxO/IJpT9k/r9eGA4q/ZzUHku6pCOkbDNOd3SVMbHc4Ns
        Ml6suvzSu9UZYuWXilXUnFtVloKwgC5kvh/DCDpTGffbqj2Nfc5yzuLRUUaS5MpScxu9+h
        TGSl9WcY/IuPR1GBdyO5zgzz9laDDVs=
Mime-Version: 1.0
Subject: Re: [v3 4/4] mm: hugetlb: Skip initialization of gigantic tail struct
 pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230828210418.GD3290@monkey>
Date:   Tue, 29 Aug 2023 11:33:10 +0800
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9D058DC-699B-4B6D-90EC-D81ADD32C6DD@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <20230828210418.GD3290@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 29, 2023, at 05:04, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 08/28/23 19:33, Muchun Song wrote:
>>=20
>>=20
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
>>=20
>> This edition is simpler than before ever, thanks for your work.
>>=20
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
>=20
> In this patch, the call to hugetlb_vmemmap_optimize() is moved BEFORE
> __prep_new_hugetlb_folio or prep_new_hugetlb_folio in all code paths.
> The prep_new_hugetlb_folio routine(s) are what set the destructor =
(soon
> to be a flag) that identifies the set of pages as a hugetlb page.  So,
> there is now a window where a set of pages not identified as hugetlb
> will not have vmemmap pages.

Thanks for your point it out.

Seems this issue is not related to this change? =
hugetlb_vmemmap_optimize()
is called before the setting of destructor since the initial commit
f41f2ed43ca5. Right?

>=20
> Recently, I closed the same window in the hugetlb freeing code paths =
with
> commit 32c877191e02 'hugetlb: do not clear hugetlb dtor until =
allocating'.

Yes, I saw it.=20

> This patch needs to be reworked so that this window is not opened in =
the
> allocation paths.

So I think the fix should be a separate series.

Thanks.


