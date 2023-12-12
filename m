Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13180E2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbjLLDhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:37:07 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBBAC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:37:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VyL-1Lp_1702352229;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VyL-1Lp_1702352229)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 11:37:10 +0800
Message-ID: <69705c2a-3b6d-480a-bea1-2b602c8fc5ad@linux.alibaba.com>
Date:   Tue, 12 Dec 2023 11:37:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmem: sprd: Remove the lock operation to support
 customers being able to program efuse multiple times
To:     Yanxin Huang <yanxin.huang@unisoc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20231208061134.26354-1-yanxin.huang@unisoc.com>
 <20231208061134.26354-3-yanxin.huang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231208061134.26354-3-yanxin.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2023 2:11 PM, Yanxin Huang wrote:
> The customer uses the efuse interface to program efuse based on block
> size. Each time a part of the content is programmed, according to the
> original code logic, as long as the bytes parameter is equal to the block
> size, the block will be locked, which will result in the efuse block
> being unable to program multiple times.

Initially, we only supported one-time programming. Can you describe the 
scenarios for multiple programming?

> This patch removes the efuse block locking operation, as the unisoc efuse
> driver supports customers to program the same block multiple times.If you
> need to lock a block, you can directly program the lock bit of the block.

How can "directly program the lock bit of the block" for users? You 
already removed sprd_efuse_set_prog_lock().


BTW, You should separate the patches for bugfix and feature 
modifications into different patch sets, so that the bugfix patches can 
be reviewed and merged ASAP.

> Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
> ---
>   drivers/nvmem/sprd-efuse.c | 57 ++------------------------------------
>   1 file changed, 2 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index f0880f8fc56d..5220fd680f47 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -143,30 +143,6 @@ static void sprd_efuse_set_read_power(struct sprd_efuse *efuse, bool en)
>   	usleep_range(1000, 1200);
>   }
>   
> -static void sprd_efuse_set_prog_lock(struct sprd_efuse *efuse, bool en)
> -{
> -	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
> -
> -	if (en)
> -		val |= SPRD_EFUSE_LOCK_WR_EN;
> -	else
> -		val &= ~SPRD_EFUSE_LOCK_WR_EN;
> -
> -	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
> -}
> -
> -static void sprd_efuse_set_auto_check(struct sprd_efuse *efuse, bool en)
> -{
> -	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
> -
> -	if (en)
> -		val |= SPRD_EFUSE_AUTO_CHECK_EN;
> -	else
> -		val &= ~SPRD_EFUSE_AUTO_CHECK_EN;
> -
> -	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
> -}
> -
>   static void sprd_efuse_set_data_double(struct sprd_efuse *efuse, bool en)
>   {
>   	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
> @@ -191,8 +167,7 @@ static void sprd_efuse_set_prog_en(struct sprd_efuse *efuse, bool en)
>   	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
>   }
>   
> -static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
> -			       bool lock, u32 *data)
> +static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub, u32 *data)
>   {
>   	u32 status;
>   	int ret = 0;
> @@ -213,18 +188,8 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>   	sprd_efuse_set_prog_en(efuse, true);
>   	sprd_efuse_set_data_double(efuse, doub);
>   
> -	/*
> -	 * Enable the auto-check function to validate if the programming is
> -	 * successful.
> -	 */
> -	if (lock)
> -		sprd_efuse_set_auto_check(efuse, true);
> -
>   	writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
>   
> -	/* Disable auto-check and data double after programming */
> -	if (lock)
> -		sprd_efuse_set_auto_check(efuse, false);
>   	sprd_efuse_set_data_double(efuse, false);
>   
>   	/*
> @@ -239,10 +204,6 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>   		writel(SPRD_EFUSE_ERR_CLR_MASK,
>   		       efuse->base + SPRD_EFUSE_ERR_CLR);
>   		ret = -EBUSY;
> -	} else if (lock) {
> -		sprd_efuse_set_prog_lock(efuse, lock);
> -		writel(0, efuse->base + SPRD_EFUSE_MEM(blk));
> -		sprd_efuse_set_prog_lock(efuse, false);
>   	}
>   
>   	sprd_efuse_set_prog_power(efuse, false);
> @@ -327,7 +288,6 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
>   	struct sprd_efuse *efuse = context;
>   	bool blk_double = efuse->data->blk_double;
>   	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
> -	bool lock;
>   	int ret;
>   
>   	ret = sprd_efuse_lock(efuse);
> @@ -338,20 +298,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
>   	if (ret)
>   		goto unlock;
>   
> -	/*
> -	 * If the writing bytes are equal with the block width, which means the
> -	 * whole block will be programmed. For this case, we should not allow
> -	 * this block to be programmed again by locking this block.
> -	 *
> -	 * If the block was programmed partially, we should allow this block to
> -	 * be programmed again.
> -	 */
> -	if (bytes < SPRD_EFUSE_BLOCK_WIDTH)
> -		lock = false;
> -	else
> -		lock = true;
> -
> -	ret = sprd_efuse_raw_prog(efuse, index, blk_double, lock, val);
> +	ret = sprd_efuse_raw_prog(efuse, index, blk_double, val);
>   
>   	clk_disable_unprepare(efuse->clk);
>   
