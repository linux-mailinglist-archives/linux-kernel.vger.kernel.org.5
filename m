Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945677E8A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjKKK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjKKK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:57:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B53AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:57:28 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SSCGL47mtzPng8;
        Sat, 11 Nov 2023 18:53:14 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 11 Nov 2023 18:57:24 +0800
Message-ID: <e2d66b13-99f3-49b6-a47f-5379ae536c9a@huawei.com>
Date:   Sat, 11 Nov 2023 18:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mm: task_mmu: use a folio in smaps_account()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-6-wangkefeng.wang@huawei.com>
 <ZU52ifwZcNhmz0rA@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZU52ifwZcNhmz0rA@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/11/11 2:29, Matthew Wilcox wrote:
> On Fri, Nov 10, 2023 at 11:33:22AM +0800, Kefeng Wang wrote:
>> Replace seven implicit calls to compound_head() with one page_folio().
> 
> You're so focused on trying to accomplish your goal (killing off the
> page_idle and page_young functions) that you're doing a poor job thinkig
> about the conversions you're doing along the way.
> 
>> +++ b/fs/proc/task_mmu.c
>> @@ -445,23 +445,25 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   {
>>   	int i, nr = compound ? compound_nr(page) : 1;
>>   	unsigned long size = nr * PAGE_SIZE;
>> +	struct folio *folio = page_folio(page);
> 
> Stop right here.  The use of compound_nr() should give you pause.
> 
> After looking at how smaps_account() is used, it seems to me that the
> two callers should each pass in PAGE_SIZE or PMD_SIZE instead of doing
> this calculation.

Yes，this will save extra calculation

> 
> More generally, step back from this series.  Do a good job of
> transforming fs/proc/task_mmu.c to use folios.  Once you've done
> that, you can approach the young/idle work again.
> 
Thanks for you advise，will try this firstly.
> 
