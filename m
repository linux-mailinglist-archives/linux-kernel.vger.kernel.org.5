Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A075599F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQCdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjGQCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:33:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C623E71
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:33:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R45ff19TzzLnm8;
        Mon, 17 Jul 2023 10:30:50 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 10:33:14 +0800
Subject: Re: [PATCH 1/4] mm/swapfile: fix wrong swap entry type for hwpoisoned
 swapcache page
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-2-linmiaohe@huawei.com>
 <ZLIXg7BPPAoUYUGV@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <33748ced-5fd3-f3f7-f358-ca016ca8ba36@huawei.com>
Date:   Mon, 17 Jul 2023 10:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZLIXg7BPPAoUYUGV@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/15 11:50, Matthew Wilcox wrote:
> On Sat, Jul 15, 2023 at 11:17:26AM +0800, Miaohe Lin wrote:
>> Hwpoisoned dirty swap cache page is kept in the swap cache and there's
>> simple interception code in do_swap_page() to catch it. But when trying
>> to swapoff, unuse_pte() will wrongly install a general sense of "future
>> accesses are invalid" swap entry for hwpoisoned swap cache page due to
>> unaware of such type of page. The user will receive SIGBUS signal without
>> expected BUS_MCEERR_AR payload.
> 
> Have you observed this, or do you just think it's true?
> 
>> +++ b/mm/swapfile.c
>> @@ -1767,7 +1767,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		swp_entry_t swp_entry;
>>  
>>  		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>> -		if (hwposioned) {
>> +		/* Hwpoisoned swapcache page is also !PageUptodate. */
>> +		if (hwposioned || PageHWPoison(page)) {
> 
> This line makes no sense to me.  How do we get here with PageHWPoison()
> being true and hwposioned being false?

hwposioned will be true iff ksm_might_need_to_copy returns -EHWPOISON.
And there's PageUptodate check in ksm_might_need_to_copy before we can return -EHWPOISON:

  ksm_might_need_to_copy
    if (!PageUptodate(page))
      return page;		/* let do_swap_page report the error */
    ^^^
    Will return here because hwpoisoned swapcache page is !PageUptodate(cleared via me_swapcache_dirty()).

Or am I miss something?

Thanks.
