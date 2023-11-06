Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D437E18A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjKFCbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:31:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F637D6;
        Sun,  5 Nov 2023 18:31:02 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SNwM158NmzvQK0;
        Mon,  6 Nov 2023 10:30:53 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 10:30:59 +0800
Message-ID: <e3c275c3-e09d-4495-8132-9464133db283@huawei.com>
Date:   Mon, 6 Nov 2023 10:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] mm: memory: use a folio in zap_pte_range()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>
References: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
 <20231104035522.2418660-7-wangkefeng.wang@huawei.com>
 <ZUZ9dg4YHZdUKDqO@casper.infradead.org>
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUZ9dg4YHZdUKDqO@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/5 1:20, Matthew Wilcox wrote:
> On Sat, Nov 04, 2023 at 11:55:18AM +0800, Kefeng Wang wrote:
>> -/* Decides whether we should zap this page with the page pointer specified */
>> -static inline bool should_zap_page(struct zap_details *details, struct page *page)
>> +/* Decides whether we should zap this folio with the folio pointer specified */
>> +static inline bool should_zap_page(struct zap_details *details, struct folio *folio)
> 
> Surely we should rename this to should_zap_folio()?
Will update.
> 
>> @@ -1487,10 +1492,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>   			 * see zap_install_uffd_wp_if_needed().
>>   			 */
>>   			WARN_ON_ONCE(!vma_is_anonymous(vma));
>> -			rss[mm_counter(page)]--;
>> +			rss[mm_counter(&folio->page)]--;
>>   			if (is_device_private_entry(entry))
>> -				page_remove_rmap(page, vma, false);
>> -			put_page(page);
>> +				page_remove_rmap(&folio->page, vma, false);
>> +			folio_put(folio);
> 
> This is wrong.  If we have a PTE-mapped THP, you'll remove the head page
> N times instead of removing each of N pages.

This is device private entry, I suppose that it won't be a THP and large 
folio when check migrate_vma_check_page() and migrate_vma_insert_page(),
right?

> 
> I suspect you're going to collide with Ryan's work by doing this ...
> 
Maybe not if the above is true, at least for now.

Thanks.


