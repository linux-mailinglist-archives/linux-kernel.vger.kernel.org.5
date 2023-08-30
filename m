Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B178DEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbjH3TOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjH3GpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:45:11 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD46194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:45:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbFCg4Rszz4f3nTT
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:45:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgA3DqFv5e5kVmazBw--.1578S2;
        Wed, 30 Aug 2023 14:45:04 +0800 (CST)
Subject: Re: [PATCH v2 7/7] mm/compaction: factor out code to test if we
 should run compaction for target order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-8-shikemeng@huaweicloud.com>
 <ZO1sBjE+1n3FQLbX@casper.infradead.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c915a3aa-d684-f468-4b41-02bdf9b5584d@huaweicloud.com>
Date:   Wed, 30 Aug 2023 14:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZO1sBjE+1n3FQLbX@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgA3DqFv5e5kVmazBw--.1578S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr13AFy5Zr4fCFy5WF4fuFg_yoWDGwc_ZF
        45XFsFvFWYyF4fGr42kr40yrZ5CFs8CFyDtrnxKw129a92ya9Iqw1vy347CF1aqr1UCr45
        urWfZa97Jw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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



on 8/29/2023 11:54 AM, Matthew Wilcox wrote:
> On Sat, Aug 26, 2023 at 11:36:17PM +0800, Kemeng Shi wrote:
>> +		if (compaction_suit_allocation_order(zone,
>> +				pgdat->kcompactd_max_order,
>> +				highest_zoneidx, ALLOC_WMARK_MIN) ==
>> +				COMPACT_CONTINUE)
> 
> The indentation is confusing here.  It looks like COMPACT_CONTINUE is
> an argument of compaction_suit_allocation_order().  How about:
> 
> 		ret = compaction_suit_allocation_order(zone,
> 				pgdat->kcompactd_max_order,
> 				highest_zoneidx, ALLOC_WMARK_MIN);
> 		if (ret == COMPACT_CONTINUE)
> 
Thanks for information, I will fix it this way in next version.
> (assuming there's a handy variable called ret)
> 
> You could also distinguih it by indenting COMPACT_CONTINUE by an
> extra tab, but I think it's worth an extra variable just because this is
> such a long line>
>> +		if (compaction_suit_allocation_order(zone,
>> +				cc.order, zoneid, ALLOC_WMARK_MIN) !=
>> +				COMPACT_CONTINUE)
>>  			continue;
> 
> Same here.
> 

