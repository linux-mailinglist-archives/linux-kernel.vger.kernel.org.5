Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50AA7E88F2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKKDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjKKDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:21:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753E2591
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:21:18 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SS1811lzNzPnfw;
        Sat, 11 Nov 2023 11:17:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 11 Nov 2023 11:21:15 +0800
Message-ID: <64ee5424-2e45-41fc-af24-07271bac7d0d@huawei.com>
Date:   Sat, 11 Nov 2023 11:21:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] fs/proc/page: use a folio in stable_page_flags()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-3-wangkefeng.wang@huawei.com>
 <ZU5zRk+yi74pmAsq@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZU5zRk+yi74pmAsq@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2023/11/11 2:15, Matthew Wilcox wrote:
> On Fri, Nov 10, 2023 at 11:33:19AM +0800, Kefeng Wang wrote:
>> Replace nine compound_head() calls with one page_folio().
> 
> But that's not all it does.  Honestly, when you write these kind of
> things, I wonder if you understand what you're doing.

Oh, yes, I total wrong for some change, the kpagelfags should report
per-page.

> 
> After this patch, if we report on a tail page, we set (some of) the
> flags according to how its head page is set.  Before, we would have not
> reported on it at all.

I should force on the following specific flags in this patch

1) PageKsm
    - KSM only normal anon page, also it is wrapper of folio_test_ksm()
2) struct page *head = compound_head(page); PageLRU(head) PageAnon(head)
    - they expect to check the head page flags
3) page_count(page) == 0 && is_free_buddy_page(page)
    - this is to identify free buddy page, also page_count is a wrapper
      of folio_ref_count
4) page_is_idle
    - a wrapper of folio_test_idle

Matthew and Gregory, correct me if I am still misunderstanding, man thanks.
> 
> This was THE ENTIRE POINT of Greg's patch.  And why his patch made sense
> and yours is nonsense.  Andrew, please drop this patch series.
> 
