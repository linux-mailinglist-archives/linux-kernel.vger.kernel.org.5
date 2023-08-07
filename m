Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720D771783
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHGAh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:37:57 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73C101
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:37:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RJy8c3qPGz4f3kKV
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:37:52 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgA3si7fPNBkOuprAA--.26529S2;
        Mon, 07 Aug 2023 08:37:52 +0800 (CST)
Subject: Re: [PATCH 1/9] mm/compaction: use correct list in
 move_freelist_{head}/{tail}
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-2-shikemeng@huaweicloud.com>
 <20230805101109.740fdc21418d0753c4658df1@linux-foundation.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fac35b05-e253-c015-7224-eb4a43843adb@huaweicloud.com>
Date:   Mon, 7 Aug 2023 08:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230805101109.740fdc21418d0753c4658df1@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgA3si7fPNBkOuprAA--.26529S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rAw4xKryxJr1UGFW3ZFb_yoW8GFy7pr
        WFkF4UJF4UArW0yFnrXw4q9w18tF47Zr1Yk3y5uFW7AFn8trZrtF9akF4Uu393GrWjkrs0
        vrsrKrsIkrW3Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/6/2023 1:11 AM, Andrew Morton wrote:
> On Sat,  5 Aug 2023 19:07:03 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> The freepage is chained with buddy_list in freelist head. Use buddy_list
>> instead of lru to correct the list operation.
>>
>> ...
>>
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1395,8 +1395,8 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>>  {
>>  	LIST_HEAD(sublist);
>>  
>> -	if (!list_is_last(freelist, &freepage->lru)) {
>> -		list_cut_before(&sublist, freelist, &freepage->lru);
>> +	if (!list_is_last(freelist, &freepage->buddy_list)) {
>> +		list_cut_before(&sublist, freelist, &freepage->buddy_list);
>>  		list_splice_tail(&sublist, freelist);
>>  	}
>>  }
>> @@ -1412,8 +1412,8 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>>  {
>>  	LIST_HEAD(sublist);
>>  
>> -	if (!list_is_first(freelist, &freepage->lru)) {
>> -		list_cut_position(&sublist, freelist, &freepage->lru);
>> +	if (!list_is_first(freelist, &freepage->buddy_list)) {
>> +		list_cut_position(&sublist, freelist, &freepage->buddy_list);
>>  		list_splice_tail(&sublist, freelist);
>>  	}
>>  }
> 
> This looks like a significant error.  Can we speculate about the
> possible runtime effects?
> 
> 
> It seems no runtime effects for now as lru and buddy_list share
the same memory address in a union.

