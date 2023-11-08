Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84877E4EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjKHBlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKHBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:41:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A05188
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:41:01 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SQ78H00xHzVm5g;
        Wed,  8 Nov 2023 09:40:46 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 09:40:10 +0800
Message-ID: <81e0289c-225c-4468-959c-937d3678cb2d@huawei.com>
Date:   Wed, 8 Nov 2023 09:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm: ksm: use more folio api in
 ksm_might_need_to_copy()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-2-wangkefeng.wang@huawei.com>
 <ZUpIlkO0E7+i2hCg@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUpIlkO0E7+i2hCg@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 22:24, Matthew Wilcox wrote:
> On Tue, Nov 07, 2023 at 09:52:11PM +0800, Kefeng Wang wrote:
>>   struct page *ksm_might_need_to_copy(struct page *page,
>> -			struct vm_area_struct *vma, unsigned long address)
>> +			struct vm_area_struct *vma, unsigned long addr)
>>   {
>>   	struct folio *folio = page_folio(page);
>>   	struct anon_vma *anon_vma = folio_anon_vma(folio);
>> -	struct page *new_page;
>> +	struct folio *new_folio;
>>   
>> -	if (PageKsm(page)) {
>> -		if (page_stable_node(page) &&
>> +	if (folio_test_ksm(folio)) {
>> +		if (folio_stable_node(folio) &&
>>   		    !(ksm_run & KSM_RUN_UNMERGE))
>>   			return page;	/* no need to copy it */
>>   	} else if (!anon_vma) {
>>   		return page;		/* no need to copy it */
>> -	} else if (page->index == linear_page_index(vma, address) &&
>> +	} else if (page->index == linear_page_index(vma, addr) &&
> 
> Hmm.  page->index is going away.  What should we do here instead?

Do you mean to replace page->index to folio->index, or kill index from
struct page?

> 
> The rest of this looks good.
> 
