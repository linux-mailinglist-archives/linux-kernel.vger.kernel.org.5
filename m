Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399F78D9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjH3SeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjH3GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:51:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C511BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:51:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbFLV4Fdfz4f3l8n
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:50:58 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgBXecHS5u5kO1E_Bw--.63649S2;
        Wed, 30 Aug 2023 14:50:59 +0800 (CST)
Subject: Re: [PATCH v2 3/7] mm/compaction: correctly return failure with bogus
 compound_order in strict mode
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-4-shikemeng@huaweicloud.com>
 <20230829093909.4hpria3qtouvdv6a@techsingularity.net>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f95b565a-796c-8d97-566b-d7877c9c1006@huaweicloud.com>
Date:   Wed, 30 Aug 2023 14:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230829093909.4hpria3qtouvdv6a@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBXecHS5u5kO1E_Bw--.63649S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4rtw43tr4xCFyftr1DJrb_yoWDGrbE9r
        WkAFs7Aw1FgrnxA347uw17tF4fK3yxCr15Cry8GFyUu3yqvF43J3ZrAr13Za15Ja4xZwnx
        C3Wruw4jyw1YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



on 8/29/2023 5:39 PM, Mel Gorman wrote:
> On Sat, Aug 26, 2023 at 11:36:13PM +0800, Kemeng Shi wrote:
>> In strict mode, we should return 0 if there is any hole in pageblock. If
>> we successfully isolated pages at beginning at pageblock and then have a
>> bogus compound_order outside pageblock in next page. We will abort search
>> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
>> we will treat it as a successful isolation in strict mode as blockpfn is
>> not < end_pfn and return partial isolated pages. Then
>> isolate_freepages_range may success unexpectly with hole in isolated
>> range.
>>
>> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Modify the (likely(order <= MAX_ORDER)) block to avoid ever updating
> blockpfn past the end of the pageblock. Then remove the second redundant
> check.
> 
Sure, I will improve this in next version.

