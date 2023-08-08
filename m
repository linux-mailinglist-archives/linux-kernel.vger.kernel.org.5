Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6C7746B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHHS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjHHS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:59:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67427772B9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:20:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKsvH4YFSz1hwFq;
        Tue,  8 Aug 2023 20:29:31 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:32:20 +0800
Subject: Re: [PATCH] mm/page_alloc: remove unneeded current_order check
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230808020555.658430-1-linmiaohe@huawei.com>
 <20230808081651.0d8573551f87de016c018529@hugovil.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3d0a7207-c46c-a183-65aa-7429e39b4f1c@huawei.com>
Date:   Tue, 8 Aug 2023 20:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230808081651.0d8573551f87de016c018529@hugovil.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 20:16, Hugo Villeneuve wrote:
> On Tue, 8 Aug 2023 10:05:55 +0800
> Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> current_order is guaranteed to '>=' min_order while min_order always '>='
>> order. So current_order must be '>=' order.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/page_alloc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 96b7c1a7d1f2..d37ec87515d0 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2072,8 +2072,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>>  		 * allocation falls back into a different pageblock than this
>>  		 * one, it won't cause permanent fragmentation.
>>  		 */
>> -		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
>> -					&& current_order > order)
>> +		if (!can_steal && start_migratetype == MIGRATE_MOVABLE)
>>  			goto find_smallest;
> 
> Hi,
> if my analysis is correct, min_order can be initialized to the value of
> order before the loop begins.
> 
> In that case, in the last loop iteration, current_order will be
> equal to min_order and also to order. The condition 'current_order >
> order' will evaluate to false, and the 'if' block should not be
> executed?

Oh, that's my mistake. Thanks for pointing this out. Will drop this patch.

Thanks!
