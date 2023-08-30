Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7578DC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjH3SpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjH3HC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:02:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFE1A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:02:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RbFbY48jWz4f3jY4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:02:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAnnip76e5kzm5HBw--.65103S2;
        Wed, 30 Aug 2023 15:02:21 +0800 (CST)
Subject: Re: [PATCH v2 4/7] mm/compaction: simplify pfn iteration in
 isolate_freepages_range
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-5-shikemeng@huaweicloud.com>
 <20230829150153.j4lw36s7yx5be7al@techsingularity.net>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fd145323-6418-2a8a-484b-20f83f42e2d1@huaweicloud.com>
Date:   Wed, 30 Aug 2023 15:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230829150153.j4lw36s7yx5be7al@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAnnip76e5kzm5HBw--.65103S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUKw4Utr4kZr1rtrW7twb_yoW8Ww4xpa
        y5Ga1I9r1kGayUWFnxAw1DZ3WrK39IvF47XrW5Xr1fX395Xa4xZF93Ar4YkFyxtrnrCr1q
        vrZFgrZ2q3WDXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/29/2023 11:01 PM, Mel Gorman wrote:
> On Sat, Aug 26, 2023 at 11:36:14PM +0800, Kemeng Shi wrote:
>> We call isolate_freepages_block in strict mode, continuous pages in
>> pageblock will be isolated if isolate_freepages_block successed.
>> Then pfn + isolated will point to start of next pageblock to scan
>> no matter how many pageblocks are isolated in isolate_freepages_block.
>> Use pfn + isolated as start of next pageblock to scan to simplify the
>> iteration.
>>
>> The pfn + isolated always points to start of next pageblock as:
>> In case isolated buddy page has order higher than pageblock:
>> 1. page in buddy page is aligned with it's order
>> 2. order of page is higher than pageblock order
>> Then page is aligned with pageblock order. So pfn of page and isolated
>> pages count are both aligned pageblock order. So pfn + isolated is
>> pageblock order aligned.
>>
>> In case isolated buddy page has order lower than pageblock:
>> Buddy page with order N contains two order N - 1 pages as following:
>> |        order N        |
>> |order N - 1|order N - 1|
>> So buddy pages with order N - 1 will never cross boudary of order N.
>> Similar, buddy pages with order N - 2 will never cross boudary of order
>> N - 1 and so on. Then any pages with order less than pageblock order
>> will never crosa boudary of pageblock.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> While I don't think the patch is wrong, I also don't think it
> meaningfully simplifies the code or optimises enough to be justified.
> Even though a branch is eliminated, the whole path is not cheap.
> 
OK, I will drop this in next version if you insistant.

