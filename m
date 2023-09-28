Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49667B1247
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjI1GDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:03:35 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230999;
        Wed, 27 Sep 2023 23:03:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx2wH6dFdz4f3l1M;
        Thu, 28 Sep 2023 14:03:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd0wFxVlIupVBg--.64905S3;
        Thu, 28 Sep 2023 14:03:30 +0800 (CST)
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
To:     Ming Lei <ming.lei@redhat.com>, linan666@huaweicloud.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
 <ZRT7cVFcE6QMHfie@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZRT7cVFcE6QMHfie@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd0wFxVlIupVBg--.64905S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4ftry5Aw17Xry5XFykAFb_yoW8Aw4fpF
        4Fy3WSkF4UJF1Skan5Xw47ur9Yqw48KFWFk34rJ34ayr9xuFsakrs7KFyavFyDKr18Ww1v
        9Fn8WFsIyw4UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
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

ÔÚ 2023/09/28 12:05, Ming Lei Ð´µÀ:
> On Mon, Sep 11, 2023 at 10:33:08AM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
>> krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
>> may occurs.
>>
>>    T1
>>    nbd_ioctl
>>     __nbd_ioctl
>>      nbd_add_socket
>>       blk_mq_freeze_queue
>> 				T2
>>    				recv_work
>>    				 nbd_read_reply
>>    				  sock_xmit
>>       krealloc config->socks
>> 				   def config->socks
>>
>> Pass nbd_sock to nbd_read_reply(). And introduce a new function
>> sock_xmit_recv(), which differs from sock_xmit only in the way it get
>> socket.
>>
> 
> I am wondering why not grab queue usage counter before calling nbd_read_reply()
> for avoiding such issue, something like the following change:
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index df1cd0f718b8..09215b605b12 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -837,9 +837,6 @@ static void recv_work(struct work_struct *work)
>   	while (1) {
>   		struct nbd_reply reply;
>   
> -		if (nbd_read_reply(nbd, args->index, &reply))
> -			break;
> -
>   		/*
>   		 * Grab .q_usage_counter so request pool won't go away, then no
>   		 * request use-after-free is possible during nbd_handle_reply().
> @@ -852,6 +849,9 @@ static void recv_work(struct work_struct *work)
>   			break;
>   		}
>   

This break how nbd works, if there is no reply yet, recv_work() will
wait for reply in:

nbd_read_reply
  sock_xmit
   sock_recvmsg

After this change, recv_work() will just return if there is no io.

Thanks,
Kuai

> +		if (nbd_read_reply(nbd, args->index, &reply))
> +			break;
> +
>   		cmd = nbd_handle_reply(nbd, args->index, &reply);
>   		if (IS_ERR(cmd)) {
>   			percpu_ref_put(&q->q_usage_counter);
> 
> Thanks,
> Ming
> 
> .
> 

