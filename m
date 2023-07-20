Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE375A9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGTI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGTIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:44:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31170269D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:44:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R65n138F0z18M4B;
        Thu, 20 Jul 2023 16:43:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 16:44:01 +0800
Subject: Re: [PATCH 2/4] mm: memory-failure: fix potential unexpected return
 value from unpoison_memory()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-3-linmiaohe@huawei.com>
 <20230719234851.GA1583723@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <40d3505b-e27f-b294-582d-b0926a27419e@huawei.com>
Date:   Thu, 20 Jul 2023 16:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230719234851.GA1583723@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/7/20 7:48, Naoya Horiguchi wrote:
> On Sat, Jul 15, 2023 at 11:17:27AM +0800, Miaohe Lin wrote:
>> If unpoison_memory() fails to clear page hwpoisoned flag, return value
>> ret is expected to be -EBUSY. But when get_hwpoison_page() returns 1
>> and fails to clear page hwpoisoned flag due to races, return value will
>> be unexpected 1 leading to users being confused.
> 
> Thank you for fixing this.
> 
>>
>> Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 9ab97016877e..ac074f82f5b3 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2546,11 +2546,11 @@ int unpoison_memory(unsigned long pfn)
>>  			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
>>  					 pfn, &unpoison_rs);
>>  	} else {
>> +		ret = -EBUSY;
> 
> It seems be a code smell to me that the variable "ret" is used not only to
> save the return value of unpoison_memory(), but also to save the return
> value from get_hwpoison_page(). So I think that it might be better to use
> another auto-variable solely to save the return value of get_hwpoison_page.
> Then ret has the initial value -EBUSY at this point and no need to
> reinitialize it.
> 

This should be a nice improvement. Will do it in v2.

Thanks Naoya.

