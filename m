Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3776F72F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHDBxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHDBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:53:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666491FF3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:53:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH7wz2RZ8zVk1x;
        Fri,  4 Aug 2023 09:51:31 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:53:17 +0800
Subject: Re: [PATCH] mm/mm_init: use helper macro BITS_PER_LONG
To:     Mike Rapoport <rppt@kernel.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230803114051.637709-1-linmiaohe@huawei.com>
 <20230803133346.GH2607694@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b1dd7fd9-3454-c6d7-2195-4dfbc295f56d@huawei.com>
Date:   Fri, 4 Aug 2023 09:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230803133346.GH2607694@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 21:33, Mike Rapoport wrote:
> On Thu, Aug 03, 2023 at 07:40:51PM +0800, Miaohe Lin wrote:
>> It's more readable to use helper macro BITS_PER_LONG. No functional
>> change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/mm_init.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 66aca3f6accd..2f37dbb5ff9a 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
>>  	int shift, width;
>>  	unsigned long or_mask, add_mask;
>>  
>> -	shift = 8 * sizeof(unsigned long);
>> +	shift = BITS_PER_LONG;
>>  	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
>>  		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
>>  	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
>> @@ -1431,7 +1431,7 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>>  	usemapsize = roundup(zonesize, pageblock_nr_pages);
>>  	usemapsize = usemapsize >> pageblock_order;
>>  	usemapsize *= NR_PAGEBLOCK_BITS;
>> -	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
>> +	usemapsize = roundup(usemapsize, BITS_PER_LONG);
>>  
>>  	return usemapsize / 8;
> 
> BITS_PER_BYTE instead of 8 here?

Sure, this is even better. Will do.

Thanks.
