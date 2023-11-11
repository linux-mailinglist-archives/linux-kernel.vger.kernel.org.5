Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4E7E8A17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjKKJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:49:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACA3AAE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:49:44 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SS9nC6cDQzrT1b;
        Sat, 11 Nov 2023 17:46:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 11 Nov 2023 17:49:38 +0800
Message-ID: <438ba640-c205-4034-886e-6a7231f3d210@huawei.com>
Date:   Sat, 11 Nov 2023 17:49:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] fs/proc/page: respect folio head-page flag
 placement
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-4-wangkefeng.wang@huawei.com>
 <ZU50JT0OVdAh9q5W@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZU50JT0OVdAh9q5W@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/11 2:19, Matthew Wilcox wrote:
> On Fri, Nov 10, 2023 at 11:33:20AM +0800, Kefeng Wang wrote:
>> kpageflags reads page-flags directly from the page, even when the
>> respective flag is only updated on the headpage of a folio.
>>
>> Since most flags are stored in head flags, make k = folio->flags,
>> and add new p = page->flags used for per-page flags.
> 
> You'd do better to steal Greg's commit message.

Sure

> 
>> Originally-from: Gregory Price <gregory.price@memverge.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
>> @@ -202,7 +202,7 @@ u64 stable_page_flags(struct page *page)
>>   	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
>>   
>>   #ifdef CONFIG_MEMORY_FAILURE
>> -	u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
>> +	u |= kpf_copy_bit(p, KPF_HWPOISON,	PG_hwpoison);
> 
> This is correct.
> 
>> @@ -211,13 +211,13 @@ u64 stable_page_flags(struct page *page)
>>   
>>   	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>>   	u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,	PG_mappedtodisk);
>> -	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
>> -	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
>> -	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
>> +	u |= kpf_copy_bit(p, KPF_PRIVATE,	PG_private);
>> +	u |= kpf_copy_bit(p, KPF_PRIVATE_2,	PG_private_2);
>> +	u |= kpf_copy_bit(p, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
> 
> This is not.  PG_private is not, I believe, set on tail pages.
> Ditto the other two.  If you know differently ... ?

k = folio->flags, p = page->flags
as PG_private/private_2/owner_priv_1 use PF_ANY page policy,
so they should per-page check, confused...

See checked page flags,

PG_error        PF_NO_TAIL
PG_dirty        PF_HEAD
PG_uptodate     PF_NO_TAIL
PG_writeback    PF_NO_TAIL
PG_lru          PF_HEAD
PG_referenced 	PF_HEAD
PG_active       PF_HEAD
PG_reclaim      PF_NO_TAIL
PG_swapbacked   PF_NO_TAIL
PG_unevictable  PF_HEAD
PG_mlocked      PF_NO_TAIL
PG_hwpoison     PF_ANY
PG_uncached     PF_NO_COMPOUND	
PG_reserved     PF_NO_COMPOUND
PG_mappedtodisk PF_NO_TAIL
PG_private      PF_ANY
PG_private_2    PF_ANY
PG_owner_priv_1 PF_ANY

above part has 4 types,

1) PF_HEAD        - should use k

2) PF_ANY         - should use p

3) PF_NO_TAIL
    - PageXXX will check head page flags, so suppose to use k,
      but here use bit check, I wonder it should use p?

4) PF_NO_COMPOUND
   - should per-page check
> 
>>   #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>> -	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
>> -	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
>> +	u |= kpf_copy_bit(p, KPF_ARCH_2,	PG_arch_2);
>> +	u |= kpf_copy_bit(p, KPF_ARCH_3,	PG_arch_3);
>>   #endif
> 
> I also don't think this is correct, but there are many uses of
> PG_arch* and I may have missed something.
> 

And 3 arch page flags,

PG_arch_1
  - PG_dcache_clean, from achetlb.rst, I think it is per-folio, use k
	
PG_arch_2
  - only arm64 mte, PG_mte_tagged
PG_arch_3
  - only arm64 mte, PG_mte_lock

the two PG_arch only used by arm64 mte, they are per-page flag, use p

Correct me if I am wrong, thanks.

