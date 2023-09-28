Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748A7B124B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjI1GEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjI1GEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:04:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DD2E5;
        Wed, 27 Sep 2023 23:04:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx2xc3qj1z4f3k5s;
        Thu, 28 Sep 2023 14:04:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd10FxVlJPtVBg--.64960S3;
        Thu, 28 Sep 2023 14:04:37 +0800 (CST)
Subject: Re: [PATCH -next] nbd: get config_lock before sock_shutdown
To:     Jens Axboe <axboe@kernel.dk>,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230707062256.1271948-1-zhongjinghua@huaweicloud.com>
 <1b67a9dd-c28a-661a-3a46-dab509d4c34e@kernel.dk>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ae49487b-9aa8-fe37-792b-676f7e70b23b@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b67a9dd-c28a-661a-3a46-dab509d4c34e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd10FxVlJPtVBg--.64960S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fKw4xWFWfWF17Aw4kXrb_yoW8tw1UpF
        W5CF4qkr4UXw4Sva9xC347Wr1UK342grW7Gry8Zwn0vr95uryI9FyDKa4fCryUtrnrCF4F
        qFWFgasYk3y3JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/01 8:27, Jens Axboe 写道:
> On 7/7/23 12:22?AM, Zhong Jinghua wrote:
>> Config->socks in sock_shutdown may trigger a UAF problem.
>> The reason is that sock_shutdown does not hold the config_lock,
>> so that nbd_ioctl can release config->socks at this time.
>>
>> T0: NBD_SET_SOCK
>> T1: NBD_DO_IT
>>
>> T0						T1
>>
>> nbd_ioctl
>>    mutex_lock(&nbd->config_lock)
>>    // get lock
>>    __nbd_ioctl
>>      nbd_start_device_ioctl
>>        nbd_start_device
>>         mutex_unlock(&nbd->config_lock)
>>           // relase lock
>>           wait_event_interruptible
>>           (kill, enter sock_shutdown)
>>           sock_shutdown
>> 					nbd_ioctl
>> 					  mutex_lock(&nbd->config_lock)
>> 					  // get lock
>> 					  __nbd_ioctl
>> 					    nbd_add_socket
>> 					      krealloc
>> 						kfree(p)
>> 					        //config->socks is NULL
>>             nbd_sock *nsock = config->socks // error
>>
>> Fix it by moving config_lock up before sock_shutdown.
>>
>> Signed-off-by: Zhong Jinghua <zhongjinghua@huaweicloud.com>
>> ---
>>   drivers/block/nbd.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index c410cf29fb0c..accbe99ebb7e 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1428,13 +1428,18 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
>>   	mutex_unlock(&nbd->config_lock);
>>   	ret = wait_event_interruptible(config->recv_wq,
>>   					 atomic_read(&config->recv_threads) == 0);
>> +
>> +	/*
>> +	 * recv_work in flush_workqueue will not get this lock, because nbd_open
>> +	 * will hold nbd->config_refs
>> +	 */
>> +	mutex_lock(&nbd->config_lock);
>>   	if (ret) {
>>   		sock_shutdown(nbd);
>>   		nbd_clear_que(nbd);
>>   	}
>>   
>>   	flush_workqueue(nbd->recv_workq);
>> -	mutex_lock(&nbd->config_lock);
> 
> Feels pretty iffy to hold config_lock over the flush. If anything off
> recv_work() ever grabs it, we'd be stuck. Your comment assumes that the
> only case this will currently happen is if we drop the last ref, or at
> least that's the case that'd do it even if you don't mention it
> explicitly.
> 
> Maybe this is all fine, but recv_work() should have a comment matching
> this one, and this comment should be more descriptive as well.

Jinghua,

Please add comment as Jens suggested, and resend this patch.

Thanks,
Kuai

> 

