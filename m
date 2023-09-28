Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8B7B124F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjI1GFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjI1GFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:05:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A769C;
        Wed, 27 Sep 2023 23:05:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx2yy4nVMz4f3k67;
        Thu, 28 Sep 2023 14:05:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHHt67FxVlpAxWBg--.8358S3;
        Thu, 28 Sep 2023 14:05:47 +0800 (CST)
Subject: Re: [PATCH -next 2/3] nbd: factor out a helper to get nbd_config
 without holding 'config_lock'
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230707031536.666482-1-zhongjinghua@huaweicloud.com>
 <20230707031536.666482-3-zhongjinghua@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f0849d52-55b8-5771-d99a-341f6af74024@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:05:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230707031536.666482-3-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHHt67FxVlpAxWBg--.8358S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8Zw43Gry3ZFyDKr4xXrb_yoWrJF1DpF
        4UAa98KrWUGF15WF4vv397WrnxKwn2gFyxGry7W3WFvr9rAryakF1kKry3Zr1xGr9rJF43
        JFWrWFZ2ka47trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> There are no functional changes, just to make code cleaner and prepare
> to fix null-ptr-dereference while accessing 'nbd->config'.
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/nbd.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index cd6d78914954..7186a9a49445 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -393,6 +393,14 @@ static u32 req_to_nbd_cmd_type(struct request *req)
>   	}
>   }
>   
> +static struct nbd_config *nbd_get_config_unlocked(struct nbd_device *nbd)
> +{
> +	if (refcount_inc_not_zero(&nbd->config_refs))
> +		return nbd->config;
> +
> +	return NULL;
> +}
> +
>   static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>   {
>   	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
> @@ -407,13 +415,13 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>   		return BLK_EH_DONE;
>   	}
>   
> -	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> +	config = nbd_get_config_unlocked(nbd);
> +	if (!config) {
>   		cmd->status = BLK_STS_TIMEOUT;
>   		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>   		mutex_unlock(&cmd->lock);
>   		goto done;
>   	}
> -	config = nbd->config;
>   
>   	if (config->num_connections > 1 ||
>   	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
> @@ -975,12 +983,12 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   	struct nbd_sock *nsock;
>   	int ret;
>   
> -	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> +	config = nbd_get_config_unlocked(nbd);
> +	if (!config) {
>   		dev_err_ratelimited(disk_to_dev(nbd->disk),
>   				    "Socks array is empty\n");
>   		return -EINVAL;
>   	}
> -	config = nbd->config;
>   
>   	if (index >= config->num_connections) {
>   		dev_err_ratelimited(disk_to_dev(nbd->disk),
> @@ -1556,6 +1564,7 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
>   static int nbd_open(struct block_device *bdev, fmode_t mode)
>   {
>   	struct nbd_device *nbd;
> +	struct nbd_config *config;
>   	int ret = 0;
>   
>   	mutex_lock(&nbd_index_mutex);
> @@ -1568,7 +1577,9 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
>   		ret = -ENXIO;
>   		goto out;
>   	}
> -	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> +
> +	config = nbd_get_config_unlocked(nbd);
> +	if (!config) {
>   		mutex_lock(&nbd->config_lock);
>   		if (refcount_inc_not_zero(&nbd->config_refs)) {
>   			mutex_unlock(&nbd->config_lock);
> @@ -1584,7 +1595,7 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
>   		mutex_unlock(&nbd->config_lock);
>   		if (max_part)
>   			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
> -	} else if (nbd_disconnected(nbd->config)) {
> +	} else if (nbd_disconnected(config)) {
>   		if (max_part)
>   			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>   	}
> @@ -2194,7 +2205,8 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>   	}
>   	mutex_unlock(&nbd_index_mutex);
>   
> -	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> +	config = nbd_get_config_unlocked(nbd);
> +	if (!config) {
>   		dev_err(nbd_to_dev(nbd),
>   			"not configured, cannot reconfigure\n");
>   		nbd_put(nbd);
> @@ -2202,7 +2214,6 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>   	}
>   
>   	mutex_lock(&nbd->config_lock);
> -	config = nbd->config;
>   	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
>   	    !nbd->pid) {
>   		dev_err(nbd_to_dev(nbd),
> 

