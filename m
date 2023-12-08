Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79E6809D40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573286AbjLHHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573293AbjLHHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:40:42 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42586DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:40:48 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Smjjh2Xy3z4f3lV4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:40:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id 279B91A04FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:40:45 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP2 (Coremail) with SMTP id Syh0CgD3Tk15yHJlMbOhDA--.39237S3;
        Fri, 08 Dec 2023 15:40:44 +0800 (CST)
Message-ID: <4385d754-acbb-30b8-f311-ba542a8211e9@huaweicloud.com>
Date:   Fri, 8 Dec 2023 15:40:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
To:     Zhihao Cheng <chengzhihao1@huawei.com>, linan666@huaweicloud.com,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20231208071317.1268465-1-linan666@huaweicloud.com>
 <a1e3aa71-d89e-0579-b55f-125c17b45f29@huawei.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <a1e3aa71-d89e-0579-b55f-125c17b45f29@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3Tk15yHJlMbOhDA--.39237S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17Gr1rZw1fWr1fXw4fXwb_yoW8GFW7pa
        ykZa4Y9ryFkF1qkF4qq3WUXFZxJw48G3ykGFWxAw10qrW3Ary2krWa9r4qgrWkZF4xCaya
        qF17GrWrZFn7Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/8 15:29, Zhihao Cheng 写道:
> 在 2023/12/8 15:13, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> If idr_alloc() fails, dev->gd will be put after goto out_cleanup_disk in
>> ubiblock_create(), but dev->gd has not been assigned yet at this time, 
>> and
>> accessing it will trigger a null-pointer-dereference issue. Fix it by put
>> gd directly.
> Function 'put_disk()' checks disk whether is NULL, so I think it's a 
> 'memleak' problem, not a null-ptr-deref problem.
>>

Damn, I overlooked it here. Thanks for your review, I will fix the log
in v2.

>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/mtd/ubi/block.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
>> index 309a42aeaa4c..654bd7372cd8 100644
>> --- a/drivers/mtd/ubi/block.c
>> +++ b/drivers/mtd/ubi/block.c
>> @@ -434,7 +434,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
>>       list_del(&dev->list);
>>       idr_remove(&ubiblock_minor_idr, gd->first_minor);
>>   out_cleanup_disk:
>> -    put_disk(dev->gd);
>> +    put_disk(gd);
> 
> For memleak solution:
> 
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
>>   out_free_tags:
>>       blk_mq_free_tag_set(&dev->tag_set);
>>   out_free_dev:
> 
> 
> .

-- 
Thanks,
Nan

