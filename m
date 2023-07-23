Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062175DFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGWCX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWCXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:23:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA531BD4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:23:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R7n8J2YSvzHnVL;
        Sun, 23 Jul 2023 10:20:48 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 10:23:19 +0800
Subject: Re: [PATCH 1/4] mm/swapfile: fix wrong swap entry type for hwpoisoned
 swapcache page
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-2-linmiaohe@huawei.com>
 <ZLIXg7BPPAoUYUGV@casper.infradead.org>
 <33748ced-5fd3-f3f7-f358-ca016ca8ba36@huawei.com>
 <ZLStQ5QACPOHJcd2@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c81fb547-df79-6966-790d-219b8511f3c2@huawei.com>
Date:   Sun, 23 Jul 2023 10:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZLStQ5QACPOHJcd2@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/7/17 10:53, Matthew Wilcox wrote:
> On Mon, Jul 17, 2023 at 10:33:14AM +0800, Miaohe Lin wrote:
>> On 2023/7/15 11:50, Matthew Wilcox wrote:
>>> On Sat, Jul 15, 2023 at 11:17:26AM +0800, Miaohe Lin wrote:
>>>> Hwpoisoned dirty swap cache page is kept in the swap cache and there's
>>>> simple interception code in do_swap_page() to catch it. But when trying
>>>> to swapoff, unuse_pte() will wrongly install a general sense of "future
>>>> accesses are invalid" swap entry for hwpoisoned swap cache page due to
>>>> unaware of such type of page. The user will receive SIGBUS signal without
>>>> expected BUS_MCEERR_AR payload.
>>>
>>> Have you observed this, or do you just think it's true?
>>>
>>>> +++ b/mm/swapfile.c
>>>> @@ -1767,7 +1767,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>>>  		swp_entry_t swp_entry;
>>>>  
>>>>  		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>> -		if (hwposioned) {
>>>> +		/* Hwpoisoned swapcache page is also !PageUptodate. */
>>>> +		if (hwposioned || PageHWPoison(page)) {
>>>
>>> This line makes no sense to me.  How do we get here with PageHWPoison()
>>> being true and hwposioned being false?
>>
>> hwposioned will be true iff ksm_might_need_to_copy returns -EHWPOISON.
>> And there's PageUptodate check in ksm_might_need_to_copy before we can return -EHWPOISON:
>>
>>   ksm_might_need_to_copy
>>     if (!PageUptodate(page))
>>       return page;		/* let do_swap_page report the error */
>>     ^^^
>>     Will return here because hwpoisoned swapcache page is !PageUptodate(cleared via me_swapcache_dirty()).
>>
>> Or am I miss something?
> 
> Ah!  So we don't even get to calling copy_mc_to_kernel().  That seems
> like a bug in ksm_might_need_to_copy(), don't you think?  Maybe this
> would be a better fix:
> 
> +	if (PageHWPoison(page))
> +		return ERR_PTR(-EHWPOISON);

I'm preparing posting the v2. But I found this won't fix the issue if CONFIG_KSM is disabled. So the correct fix
should be something like below?

diff --git a/mm/ksm.c b/mm/ksm.c
index 97a9627116fa..74804158ee02 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2794,6 +2794,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
                        anon_vma->root == vma->anon_vma->root) {
                return page;            /* still no need to copy it */
        }
+       if (PageHWPoison(page))
+               return ERR_PTR(-EHWPOISON);
        if (!PageUptodate(page))
                return page;            /* let do_swap_page report the error */

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 346e22b8ae97..3dcc9d92689c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1744,7 +1744,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
        struct page *swapcache;
        spinlock_t *ptl;
        pte_t *pte, new_pte, old_pte;
-       bool hwposioned = false;
+       bool hwposioned = PageHWPoison(page);
        int ret = 1;

        swapcache = page;


Thanks.


