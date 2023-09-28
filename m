Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADC7B124D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjI1GF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:05:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046A9C;
        Wed, 27 Sep 2023 23:05:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx2yS4dg6z4f3k6W;
        Thu, 28 Sep 2023 14:05:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHHt6hFxVlUwZWBg--.8336S3;
        Thu, 28 Sep 2023 14:05:21 +0800 (CST)
Subject: Re: [PATCH -next 1/3] nbd: fold nbd config initialization into
 nbd_alloc_config()
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230707031536.666482-1-zhongjinghua@huaweicloud.com>
 <20230707031536.666482-2-zhongjinghua@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6ee779eb-39e4-badb-dc41-b6a6c8eb1c7e@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230707031536.666482-2-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHHt6hFxVlUwZWBg--.8336S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8Zw43Gry3ZFyDuw17ZFb_yoW5ZrWkpF
        45AFWjkrWUJF43GrWkA3s7WFyaywn7KF1xGry7X3sYvr9xCrWSkr1DG34fZFyUJr9rXF45
        JFWrWFs2ka4xKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrcTmDUUUU
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

ÔÚ 2023/07/07 11:15, Zhong Jinghua Ð´µÀ:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> There are no functional changes, make the code cleaner and prepare to
> fix null-ptr-dereference while accessing 'nbd->config'.
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/nbd.c | 41 +++++++++++++++++++----------------------
>   1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index cb38477f359f..cd6d78914954 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1526,17 +1526,20 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
>   	return error;
>   }
>   
> -static struct nbd_config *nbd_alloc_config(void)
> +static int nbd_alloc_and_init_config(struct nbd_device *nbd)
>   {
>   	struct nbd_config *config;
>   
> +	if (WARN_ON(nbd->config))
> +		return -EINVAL;
> +
>   	if (!try_module_get(THIS_MODULE))
> -		return ERR_PTR(-ENODEV);
> +		return -ENODEV;
>   
>   	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
>   	if (!config) {
>   		module_put(THIS_MODULE);
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>   	}
>   
>   	atomic_set(&config->recv_threads, 0);
> @@ -1544,7 +1547,10 @@ static struct nbd_config *nbd_alloc_config(void)
>   	init_waitqueue_head(&config->conn_wait);
>   	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
>   	atomic_set(&config->live_connections, 0);
> -	return config;
> +	nbd->config = config;
> +	refcount_set(&nbd->config_refs, 1);
> +
> +	return 0;
>   }
>   
>   static int nbd_open(struct block_device *bdev, fmode_t mode)
> @@ -1563,21 +1569,17 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
>   		goto out;
>   	}
>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> -		struct nbd_config *config;
> -
>   		mutex_lock(&nbd->config_lock);
>   		if (refcount_inc_not_zero(&nbd->config_refs)) {
>   			mutex_unlock(&nbd->config_lock);
>   			goto out;
>   		}
> -		config = nbd_alloc_config();
> -		if (IS_ERR(config)) {
> -			ret = PTR_ERR(config);
> +		ret = nbd_alloc_and_init_config(nbd);
> +		if (ret) {
>   			mutex_unlock(&nbd->config_lock);
>   			goto out;
>   		}
> -		nbd->config = config;
> -		refcount_set(&nbd->config_refs, 1);
> +
>   		refcount_inc(&nbd->refs);
>   		mutex_unlock(&nbd->config_lock);
>   		if (max_part)
> @@ -1979,22 +1981,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   		pr_err("nbd%d already in use\n", index);
>   		return -EBUSY;
>   	}
> -	if (WARN_ON(nbd->config)) {
> -		mutex_unlock(&nbd->config_lock);
> -		nbd_put(nbd);
> -		return -EINVAL;
> -	}
> -	config = nbd_alloc_config();
> -	if (IS_ERR(config)) {
> +
> +	ret = nbd_alloc_and_init_config(nbd);
> +	if (ret) {
>   		mutex_unlock(&nbd->config_lock);
>   		nbd_put(nbd);
>   		pr_err("couldn't allocate config\n");
> -		return PTR_ERR(config);
> +		return ret;
>   	}
> -	nbd->config = config;
> -	refcount_set(&nbd->config_refs, 1);
> -	set_bit(NBD_RT_BOUND, &config->runtime_flags);
>   
> +	config = nbd->config;
> +	set_bit(NBD_RT_BOUND, &config->runtime_flags);
>   	ret = nbd_genl_size_set(info, nbd);
>   	if (ret)
>   		goto out;
> 

