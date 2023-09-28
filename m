Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2159C7B1254
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjI1GHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjI1GH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:07:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8A99;
        Wed, 27 Sep 2023 23:07:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rx30l4rw6z4f3jMv;
        Thu, 28 Sep 2023 14:07:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3Dt4bGBVlViRWBg--.10756S3;
        Thu, 28 Sep 2023 14:07:24 +0800 (CST)
Subject: Re: [PATCH -next 3/3] nbd: fix null-ptr-dereference while accessing
 'nbd->config'
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230707031536.666482-1-zhongjinghua@huaweicloud.com>
 <20230707031536.666482-4-zhongjinghua@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1a59b683-38e0-82ee-6122-4bd1613a2269@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:07:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230707031536.666482-4-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3Dt4bGBVlViRWBg--.10756S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWxWryxKry3Cr47Kr4DArb_yoW8KFW8pF
        4UAF47C34UGFW3GFWDC34xWry5Jwn2yryxGry7G3s5Zr97CrySkr1kK343WF1UAr9xJF45
        JFWrWas2ka48GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1YFAJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/07/07 11:15, Zhong Jinghua Ð´µÀ:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> nbd->config = config and refcount_set(&nbd->config_refs, 1) in
> nbd_genl_connect may be out of order, causing config_refs to be set to 1
> first, and then nbd_open accessing nbd->config reports a null pointer
> reference.
>     T1                      T2
> vfs_open
>    do_dentry_open
>      blkdev_open
>        blkdev_get
>          __blkdev_get
>            nbd_open
>             nbd_get_config_unlocked
>                          genl_rcv_msg
>                            genl_family_rcv_msg
>                              genl_family_rcv_msg_doit
>                                nbd_genl_connect
>                                  nbd_alloc_and_init_config
>                                    // out of order execution
>                                    refcount_set(&nbd->config_refs, 1); // 2
>               nbd->config
>               // null point
>                                    nbd->config = config; // 1
> 
> Fix it by adding a cpu memory barrier to guarantee sequential execution.
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/nbd.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7186a9a49445..c410cf29fb0c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -395,8 +395,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
>   
>   static struct nbd_config *nbd_get_config_unlocked(struct nbd_device *nbd)
>   {
> -	if (refcount_inc_not_zero(&nbd->config_refs))
> +	if (refcount_inc_not_zero(&nbd->config_refs)) {
> +		/*
> +		 * Add smp_mb__after_atomic to ensure that reading nbd->config_refs
> +		 * and reading nbd->config is ordered. The pair is the barrier in
> +		 * nbd_alloc_and_init_config(), avoid nbd->config_refs is set
> +		 * before nbd->config.
> +		 */
> +		smp_mb__after_atomic();
>   		return nbd->config;
> +	}
>   
>   	return NULL;
>   }
> @@ -1555,7 +1563,15 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
>   	init_waitqueue_head(&config->conn_wait);
>   	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
>   	atomic_set(&config->live_connections, 0);
> +
>   	nbd->config = config;
> +	/*
> +	 * Order refcount_set(&nbd->config_refs, 1) and nbd->config assignment,
> +	 * its pair is the barrier in nbd_get_config_unlocked().
> +	 * So nbd_get_config_unlocked() won't see nbd->config as null after
> +	 * refcount_inc_not_zero() succeed.
> +	 */
> +	smp_mb__before_atomic();
>   	refcount_set(&nbd->config_refs, 1);
>   
>   	return 0;
> 

