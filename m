Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103A75A9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGTI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:42:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D0626AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:42:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R65kl660XzrRnN;
        Thu, 20 Jul 2023 16:41:19 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 16:42:05 +0800
Subject: Re: [PATCH 4/4] mm: memory-failure: add PageOffline() check
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-5-linmiaohe@huawei.com>
 <20230720010953.GC1583723@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0161d32a-79d8-912c-0981-496a15f3eebf@huawei.com>
Date:   Thu, 20 Jul 2023 16:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230720010953.GC1583723@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/20 9:09, Naoya Horiguchi wrote:
> On Sat, Jul 15, 2023 at 11:17:29AM +0800, Miaohe Lin wrote:
>> Memory failure is not interested in logically offlined page. Skip this
>> type of pages.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 42e63b0ab5f7..ed79b69837de 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1559,7 +1559,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>  	 * Here we are interested only in user-mapped pages, so skip any
>>  	 * other types of pages.
>>  	 */
>> -	if (PageReserved(p) || PageSlab(p) || PageTable(p))
>> +	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
> 
> hwpoison_user_mappings() is called after some checks are done, so I'm not
> sure that it's the right place to check PageOffline().

hwpoison_user_mappings() is called after the "if (!PageLRU(p) && !PageWriteback(p))" check in memory_failure().
So the page can't also be PageReserved(p) or PageSlab(p) or PageTable(p) here? I think the check here just wants
to make things clear that only user-mapped pages are interested. Or am I miss something?

Thanks Naoya.


