Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC77785CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjHKDNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:13:22 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019CDA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:13:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMTQ46fFZz4f3n6L
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:13:16 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgCXu8NMp9VkuWKfAQ--.41702S2;
        Fri, 11 Aug 2023 11:13:18 +0800 (CST)
Subject: Re: [PATCH 1/3] mm/page_alloc: correct start page when guard page
 debug is enabled
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230810095309.3109107-1-shikemeng@huaweicloud.com>
 <20230810095309.3109107-2-shikemeng@huaweicloud.com>
 <6c766c69-21c5-9f52-a172-18083edcb2c5@redhat.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <35c924a8-1232-a460-6a25-43827c6d6ef8@huaweicloud.com>
Date:   Fri, 11 Aug 2023 11:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6c766c69-21c5-9f52-a172-18083edcb2c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCXu8NMp9VkuWKfAQ--.41702S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UWw4xJw1kCFy3Gw4UJwb_yoW8tw1rpr
        1Ikw1jkrW5G395Cw17JF1DCryrJr4YgaykCr1xXa4UJw43Jry2gr17XrnFgF18Gr4xGryU
        Jr4qyr1rZr17ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/10/2023 5:10 PM, David Hildenbrand wrote:
> On 10.08.23 11:53, Kemeng Shi wrote:
>> When guard page debug is enabled and set_page_guard returns success, we miss
>> to forward page to point to start of next split range and we will do split
>> unexpectedly in page range without target page. Move start page update
>> before set_page_guard to fix this.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/page_alloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 96b7c1a7d1f2..fd93d1396ccd 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6557,6 +6557,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>>               next_page = page;
>>               current_buddy = page + size;
>>           }
>> +        page = next_page;
>>             if (set_page_guard(zone, current_buddy, high, migratetype))
>>               continue;
>> @@ -6564,7 +6565,6 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>>           if (current_buddy != target) {
>>               add_to_free_list(current_buddy, zone, high, migratetype);
>>               set_buddy_order(current_buddy, high);
>> -            page = next_page;
>>           }
>>       }
>>   }
> 
> Is this worth a Fixes: tag?
> 
Sure, I will add this in next version.
> What is the user-visible result?
> 
As we split to wrong target page, then splited pages are not able to merge
back to originial order when target page is put back and splited pages except
target page is not usable. To be specific:

Consider target page is the third page in buddy page with order 2.
| buddy-2 | Page | Target | Page |

After break down to target page, we will only set first page to Guard
because of bug.
| Guard   | Page | Target | Page |

When we try put_page_back_buddy with target page, the buddy page of target
if neither guard nor buddy, Then it's not able to construct original page
with order 2
| Guard | Page | buddy-0 | Page |

All pages except target page is not in free list and is not usable.

