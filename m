Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFE7AF7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjI0CB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0B70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:59:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D319E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 18:13:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RwJXT6DTdz4f3l1H
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:13:45 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgCHrFzKgRNlXFKYBQ--.29417S2;
        Wed, 27 Sep 2023 09:13:47 +0800 (CST)
Subject: Re: [PATCH v2 1/3] mm/page_alloc: correct start page when guard page
 debug is enabled
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
References: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
 <20230826154745.4019371-2-shikemeng@huaweicloud.com>
 <20230828152113.GA886794@ik1-406-35019.vs.sakura.ne.jp>
 <b42625d1-4c50-5c61-ef92-5008383f8682@huaweicloud.com>
 <20230926113338.GA1539169@ik1-406-35019.vs.sakura.ne.jp>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <4c050b13-8aca-7b19-333e-907e483804ea@huaweicloud.com>
Date:   Wed, 27 Sep 2023 09:13:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230926113338.GA1539169@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgCHrFzKgRNlXFKYBQ--.29417S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4fCFW3tFy5Xw48ZFyDAwb_yoWrWrWxpa
        4fGFyYkr4kJ3y5Crn2va9Fkr1ftw4ruFWUWryfZr1rWwn8trySvw43tr129F97ur13Kry8
        ZF4jyr93XayDA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 9/26/2023 7:33 PM, Naoya Horiguchi wrote:
> On Wed, Aug 30, 2023 at 02:27:33PM +0800, Kemeng Shi wrote:
>>
>>
>> on 8/28/2023 11:21 PM, Naoya Horiguchi wrote:
>>> On Sat, Aug 26, 2023 at 11:47:43PM +0800, Kemeng Shi wrote:
>>>> When guard page debug is enabled and set_page_guard returns success, we
>>>> miss to forward page to point to start of next split range and we will do
>>>> split unexpectedly in page range without target page. Move start page
>>>> update before set_page_guard to fix this.
>>>>
>>>> As we split to wrong target page, then splited pages are not able to merge
>>>> back to original order when target page is put back and splited pages
>>>> except target page is not usable. To be specific:
>>>>
>>>> Consider target page is the third page in buddy page with order 2.
>>>> | buddy-2 | Page | Target | Page |
>>>>
>>>> After break down to target page, we will only set first page to Guard
>>>> because of bug.
>>>> | Guard   | Page | Target | Page |
>>>>
>>>> When we try put_page_back_buddy with target page, the buddy page of target
>>>> if neither guard nor buddy, Then it's not able to construct original page
>>>> with order 2
>>>> | Guard | Page | buddy-0 | Page |
>>>>
>>>> All pages except target page is not in free list and is not usable.
>>>>
>>>> Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>
>>> Thank you for finding the problem and writing patches.  I think the patch
>>> fixes the reported problem, But I wonder that we really need guard page
>>> mechanism in break_down_buddy_pages() which is only called from memory_failure.
>>> As stated in Documentation/admin-guide/kernel-parameters.txt, this is a
>>> debugging feature to detect memory corruption due to buggy kernel or drivers
>>> code.  So if HW memory failrue seems to be out of the scope, and I feel that
>>> we could simply remove it from break_down_buddy_pages().
>>>
>>>         debug_guardpage_minorder=
>>>                         [KNL] When CONFIG_DEBUG_PAGEALLOC is set, this
>>>                         parameter allows control of the order of pages that will
>>>                         be intentionally kept free (and hence protected) by the
>>>                         buddy allocator. Bigger value increase the probability
>>>                         of catching random memory corruption, but reduce the
>>>                         amount of memory for normal system use. The maximum
>>>                         possible value is MAX_ORDER/2.  Setting this parameter
>>>                         to 1 or 2 should be enough to identify most random
>>>                         memory corruption problems caused by bugs in kernel or
>>>                         driver code when a CPU writes to (or reads from) a
>>>                         random memory location. Note that there exists a class
>>>                         of memory corruptions problems caused by buggy H/W or
>>>                         F/W or by drivers badly programming DMA (basically when
>>>                         memory is written at bus level and the CPU MMU is
>>>                         bypassed) which are not detectable by
>>>                         CONFIG_DEBUG_PAGEALLOC, hence this option will not help
>>>                         tracking down these problems.
>>>
>>> If you have any idea about how guard page mechanism helps memory_failrue,
>>> could you share it?
>>>
>> Hi Naoya, thanks for feedback. Commit c0a32fc5a2e47 ("mm: more intensive
>> memory corruption debugging") menthioned we konw that with
>> CONFIG_DEBUG_PAGEALLOC configured, the CPU will generate an exception on
>> access (read,write) to an unallocated page, which permits us to catch code
>> which corrupts memory; Guard page aims to keep more free/protected pages
>> and to interlace free/protected and allocated pages to increase the
>> probability of catching corruption. Keep guard page around failrue looks
>> helpful to catch random access. Wish this can help.
> 
> Sorry for my late response.
> I'm OK with keeping guardpage stuff in this code path as long as it properly works.
> And the patch looks good to me.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Do you think of sending this patch (only patch 1/3) to -stable?
> If so, please add "Cc: stable@vger.kernel.org" tag.
> 
Thanks for reply. Will cc stable in next version. Thanks!
> Thanks,
> Naoya Horiguchi
> 

