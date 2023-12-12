Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0F80E2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjLLD2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjLLD2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:28:24 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C746B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:28:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VyKmsuR_1702351703;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VyKmsuR_1702351703)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 11:28:24 +0800
Message-ID: <3487700e-5a26-488b-b955-091661e8aa90@linux.alibaba.com>
Date:   Tue, 12 Dec 2023 11:28:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmem: sprd: Fix programming errors in efuse caused
 by incorrect parameters
To:     Yanxin Huang <yanxin.huang@unisoc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20231208061134.26354-1-yanxin.huang@unisoc.com>
 <20231208061134.26354-2-yanxin.huang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231208061134.26354-2-yanxin.huang@unisoc.com>
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
> The second argument to sprd_efuse_raw_prog() is the efuse index block
> data, but the data passed in is the efuse block offset, which can cause
> efuse to be programmed to the wrong block.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>

Good catch.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/nvmem/sprd-efuse.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 24b63620d217..f0880f8fc56d 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -326,6 +326,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
>   {
>   	struct sprd_efuse *efuse = context;
>   	bool blk_double = efuse->data->blk_double;
> +	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
>   	bool lock;
>   	int ret;
>   
> @@ -350,7 +351,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
>   	else
>   		lock = true;
>   
> -	ret = sprd_efuse_raw_prog(efuse, offset, blk_double, lock, val);
> +	ret = sprd_efuse_raw_prog(efuse, index, blk_double, lock, val);
>   
>   	clk_disable_unprepare(efuse->clk);
>   
