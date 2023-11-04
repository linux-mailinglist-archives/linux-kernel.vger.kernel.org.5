Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969317E0D40
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376308AbjKDCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbjKDCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:12:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878A10C4;
        Fri,  3 Nov 2023 19:12:45 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMh2t5Fbvz4f3l23;
        Sat,  4 Nov 2023 10:12:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 5928C1A016E;
        Sat,  4 Nov 2023 10:12:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3gtKYqEVl534bEw--.14196S3;
        Sat, 04 Nov 2023 10:12:42 +0800 (CST)
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
To:     =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc:     =?UTF-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
 <ZUUd48QF/TEGFzPy@fedora>
 <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4172bf45-2c45-676a-2895-410281ebc6aa@huaweicloud.com>
Date:   Sat, 4 Nov 2023 10:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3gtKYqEVl534bEw--.14196S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1DuF4xKFy7WFy3tF1xAFb_yoW3Kr1fpF
        WxG3WYyF4jqFnFvrn7ta1rZrn3K34UCrW7Wry5Cry7Ar9xKFnFgFWIqryYkF9aqr1DGrWj
        vr4Utas7WF4DZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/04 9:11, Ed Tsai (蔡宗軒) 写道:
> On Sat, 2023-11-04 at 00:20 +0800, Ming Lei wrote:
>>   On Wed, Nov 01, 2023 at 02:23:26AM +0000, Ed Tsai (蔡宗軒) wrote:
>>> On Wed, 2023-10-25 at 17:22 +0800, ed.tsai@mediatek.com wrote:
>>>> From: Ed Tsai <ed.tsai@mediatek.com>
>>>>
>>>> Referring to commit 07173c3ec276 ("block: enable multipage
>> bvecs"),
>>>> each bio_vec now holds more than one page, potentially exceeding
>>>> 1MB in size and causing alignment issues with the queue limit.
>>>>
>>>> In a sequential read/write scenario, the file system maximizes
>> the
>>>> bio's capacity before submitting. However, misalignment with the
>>>> queue limit can result in the bio being split into smaller I/O
>>>> operations.
>>>>
>>>> For instance, assuming the maximum I/O size is set to 512KB and
>> the
>>>> memory is highly fragmented, resulting in each bio containing
>> only
>>>> one 2-pages bio_vec (i.e., bi_size = 1028KB). This would cause
>> the
>>>> bio to be split into two 512KB portions and one 4KB portion. As a
>>>> result, the originally expected continuous large I/O operations
>> are
>>>> interspersed with many small I/O operations.
>>>>
>>>> To address this issue, this patch adds a check for the
>> max_sectors
>>>> before submitting the bio. This allows the upper layers to
>>>> proactively
>>>> detect and handle alignment issues.
>>>>
>>>> I performed the Antutu V10 Storage Test on a UFS 4.0 device,
>> which
>>>> resulted in a significant improvement in the Sequential test:
>>>>
>>>> Sequential Read (average of 5 rounds):
>>>> Original: 3033.7 MB/sec
>>>> Patched: 3520.9 MB/sec
>>>>
>>>> Sequential Write (average of 5 rounds):
>>>> Original: 2225.4 MB/sec
>>>> Patched: 2800.3 MB/sec
>>>>
>>>> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
>>>> ---
>>>>   block/bio.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index 816d412c06e9..a4a1f775b9ea 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -1227,6 +1227,7 @@ static int __bio_iov_iter_get_pages(struct
>> bio
>>>> *bio, struct iov_iter *iter)
>>>>   iov_iter_extraction_t extraction_flags = 0;
>>>>   unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>>>>   unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>>>> +struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)-
>>>>> limits;
>>>>   struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>>>>   struct page **pages = (struct page **)bv;
>>>>   ssize_t size, left;
>>>> @@ -1275,6 +1276,11 @@ static int __bio_iov_iter_get_pages(struct
>> bio
>>>> *bio, struct iov_iter *iter)
>>>>   struct page *page = pages[i];
>>>>   
>>>>   len = min_t(size_t, PAGE_SIZE - offset, left);
>>>> +if (bio->bi_iter.bi_size + len >
>>>> +    lim->max_sectors << SECTOR_SHIFT) {
>>>> +ret = left;
>>>> +break;
>>>> +}
>>>>   if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>>>>   ret = bio_iov_add_zone_append_page(bio, page,
>>>> len,
>>>>   offset);
>>>> -- 
>>>> 2.18.0
>>>>
>>>
>>>
>>> Hi Jens,
>>>
>>> Just to clarify any potential confusion, I would like to provide
>>> further details based on the assumed scenario mentioned above.
>>>
>>> When the upper layer continuously sends 1028KB full-sized bios for
>>> sequential reads, the Block Layer sees the following sequence:
>>> submit bio: size = 1028KB, start LBA = n
>>> submit bio: size = 1028KB, start LBA = n + 1028KB
>>> submit bio: size = 1028KB, start LBA = n + 2056KB
>>> ...
>>>
>>> However, due to the queue limit restricting the I/O size to a
>> maximum
>>> of 512KB, the Block Layer splits into the following sequence:
>>> submit bio: size = 512KB, start LBA = n
>>> submit bio: size = 512KB, start LBA = n +  512KB
>>> submit bio: size =   4KB, start LBA = n + 1024KB
>>> submit bio: size = 512KB, start LBA = n + 1028KB
>>> submit bio: size = 512KB, start LBA = n + 1540KB
>>> submit bio: size =   4KB, start LBA = n + 2052KB
>>> submit bio: size = 512KB, start LBA = n + 2056KB
>>> submit bio: size = 512KB, start LBA = n + 2568KB
>>> submit bio: size =   4KB, start LBA = n + 3080KB
>>> ...
>>>
>>> The original expectation was for the storage to receive large,
>>> contiguous requests. However, due to non-alignment, many small I/O
>>> requests are generated. This problem is easily visible because the
>>> user pages passed in are often allocated by the buddy system as
>> order 0
>>> pages during page faults, resulting in highly non-contiguous
>> memory.
>>
>> If order 0 page is added to bio, the multipage bvec becomes nop
>> basically(256bvec holds 256 pages), then how can it make a difference
>> for you?
> 
> 
> 
>>
>>>
>>> As observed in the Antutu Sequential Read test below, it is similar
>> to
>>> the description above where the splitting caused by the queue limit
>>> leaves small requests sandwiched in between:
>>>
>>> block_bio_queue: 8,32 R 86925864 + 2144 [Thread-51]
>>> block_split: 8,32 R 86925864 / 86926888 [Thread-51]
>>> block_split: 8,32 R 86926888 / 86927912 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86925864 + 1024 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86926888 + 1024 [Thread-51]
>>> block_bio_queue: 8,32 R 86928008 + 2144 [Thread-51]
>>> block_split: 8,32 R 86928008 / 86929032 [Thread-51]
>>> block_split: 8,32 R 86929032 / 86930056 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86928008 + 1024 [Thread-51]
>>> block_rq_issue: 8,32 R 49152 () 86927912 + 96 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86929032 + 1024 [Thread-51]
>>> block_bio_queue: 8,32 R 86930152 + 2112 [Thread-51]
>>> block_split: 8,32 R 86930152 / 86931176 [Thread-51]
>>> block_split: 8,32 R 86931176 / 86932200 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86930152 + 1024 [Thread-51]
>>> block_rq_issue: 8,32 R 49152 () 86930056 + 96 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86931176 + 1024 [Thread-51]
>>> block_bio_queue: 8,32 R 86932264 + 2096 [Thread-51]
>>> block_split: 8,32 R 86932264 / 86933288 [Thread-51]
>>> block_split: 8,32 R 86933288 / 86934312 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86932264 + 1024 [Thread-51]
>>> block_rq_issue: 8,32 R 32768 () 86932200 + 64 [Thread-51]
>>> block_rq_issue: 8,32 R 524288 () 86933288 + 1024 [Thread-51]
>>>
>>> I simply prevents non-aligned situations in bio_iov_iter_get_pages.
>>
>> But there is still 4KB IO left if you limit max bio size is 512KB,
>> then how does this 4KB IO finally go in case of 1028KB IO?
>>
>>> Besides making the upper layer application aware of the queue
>> limit, I
>>> would appreciate any other directions or suggestions you may have.
>>
>> The problem is related with IO size from application.
>>
>> If you send unaligned IO, you can't avoid the last IO with small
>> size, no
>> matter if block layer bio split is involved or not. Your patch just
>> lets
>> __bio_iov_iter_get_pages split the bio, and you still have 4KB left
>> finally when application submits 1028KB, right?
>>
>> Then I don't understand why your patch improves sequential IO
>> performance.
>>
>> Thanks,
>> Ming
>>
> 
> The application performs I/O with a sufficitenly large I/O size,
> causing it to constantly fill up and submit full bios. However, in the
> iomap direct I/O scenario, pages are added to the bio one by one from
> the user buffer. This typically triggers page faults, resulting in the
> allocation of order 0 pages from the buddy system.
> 
> The remaining amount of each order in the buddy system varies over
> time. If there are not enough pages available in a particular order,
> pages are split from higher orders. When pages are obtained from the
> higher order, the user buffer may contain some small consecutive
> patterns.
> 
> In summary, the physical layout of the user buffer is unpredictable,
> and when it contains some small consecutive patterns, the size of the
> bio becomes randomly unaligned during filling.
> 
> This patch limits the bio to be filled up to the max_sectors. The
> submission is an async operation, so once the bio is queued, it will
> immediately return and continue filled and submit the next bio.
> 

Same as Ming, I still don't quite understand why your patch improves
sequential IO performance, are you trying to indicate that the
reason the bio is filled to 1028k is because memory is highly
fragmented? And user is issue more than 1028k to kernel at a time?

Thanks,
Kuai

> Best,
> Ed
> 

