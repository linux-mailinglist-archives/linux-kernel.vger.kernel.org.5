Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC075592F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQBrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:47:44 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21CE6B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:47:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R44hg2qtNz4f3mJ1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgC3Z6udnbRkEECWOA--.220S2;
        Mon, 17 Jul 2023 09:47:33 +0800 (CST)
Subject: Re: [PATCH 2/3] mm/page_ext: remove rollback for untouched
 mem_section in online_page_ext
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230714114749.1743032-1-shikemeng@huaweicloud.com>
 <20230714114749.1743032-3-shikemeng@huaweicloud.com>
 <20230714105422.648d17f9ba6141f26e469423@linux-foundation.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <af36016f-6143-ad66-385e-bb64a6205863@huaweicloud.com>
Date:   Mon, 17 Jul 2023 09:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230714105422.648d17f9ba6141f26e469423@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgC3Z6udnbRkEECWOA--.220S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1UGF1xCr1rZFWfWFyxuFg_yoWkAFb_Ja
        1Sv3WkXw4jqFnxtFWDtwn7XFnrWrWkCw1jgF1kGw4YyFyfJ395Cw1DtrnxXr1kXr4avr9F
        kws3ur4vqry2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 7/15/2023 1:54 AM, Andrew Morton wrote:
> On Fri, 14 Jul 2023 19:47:48 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> If init_section_page_ext failed, we only need rollback for mem_section
>> before failed mem_section. Make rollback end point to failed mem_section
>> to remove unnecessary rollback.
>>
>> As pfn += PAGES_PER_SECTION will be executed even if init_section_page_ext
>> failed. So pfn points to mem_section after failed mem_section. Subtract
>> one mem_section from pfn to get failed mem_section.
>>
>> ...
>>
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -424,6 +424,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
>>  		return 0;
>>  
>>  	/* rollback */
>> +	end = pfn - PAGES_PER_SECTION;
>>  	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
>>  		__free_page_ext(pfn);
>>  
> 
> This is a bugfix, yes?
> 
> I guess init_section_page_ext() never fails for anyone...
I marked this as cleanup because __free_page_ext can handle NULL page_ext
from uninitialized mem_section. Then no real bug will be triggered even
if init_section_page_ext failed.
-- 
Best wishes
Kemeng Shi

