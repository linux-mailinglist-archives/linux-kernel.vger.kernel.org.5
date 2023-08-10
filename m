Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6D77799E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjHJNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHJNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:30:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9733C2115;
        Thu, 10 Aug 2023 06:30:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxyepn5tRkq7gUAA--.34943S3;
        Thu, 10 Aug 2023 21:30:15 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9m5tRk6jtTAA--.11317S3;
        Thu, 10 Aug 2023 21:30:14 +0800 (CST)
Message-ID: <44e4e8a8-b714-1cfd-c20c-d8151e73cdac@loongson.cn>
Date:   Thu, 10 Aug 2023 21:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next] drm/loongson: Fix error handling in
 lsdc_pixel_pll_setup()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230720123950.543082-1-harshit.m.mogalapalli@oracle.com>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230720123950.543082-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxDc9m5tRk6jtTAA--.11317S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWrAFW7WrW5ZrWruF17Arc_yoW8XFW8pw
        s8Ca4jvrZFyFy2gwnrA3W8WFyrZ3W3KFyfuay7uwsI9r1DAryUWFWFvFyUJrZxXa48Aa1a
        qrn7GryY9FyDt3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/7/20 20:39, Harshit Mogalapalli wrote:
> There are two problems in lsdc_pixel_pll_setup()
> 1. If kzalloc() fails then call iounmap() to release the resources.
> 2. Both kzalloc and ioremap doesnot return error pointers on failure, so
>     using IS_ERR_OR_NULL() checks is a bit confusing and not very right,
>     fix this by changing those to NULL checks instead.
>
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> ---
> This is found with static analysis with smacth and only compile tested.
> ---
>   drivers/gpu/drm/loongson/lsdc_pixpll.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_pixpll.c b/drivers/gpu/drm/loongson/lsdc_pixpll.c
> index 04c15b4697e2..2609a2256da4 100644
> --- a/drivers/gpu/drm/loongson/lsdc_pixpll.c
> +++ b/drivers/gpu/drm/loongson/lsdc_pixpll.c
> @@ -120,12 +120,14 @@ static int lsdc_pixel_pll_setup(struct lsdc_pixpll * const this)
>   	struct lsdc_pixpll_parms *pparms;
>   
>   	this->mmio = ioremap(this->reg_base, this->reg_size);
> -	if (IS_ERR_OR_NULL(this->mmio))
> +	if (!this->mmio)
>   		return -ENOMEM;
>   
>   	pparms = kzalloc(sizeof(*pparms), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(pparms))
> +	if (!pparms) {
> +		iounmap(this->mmio);
>   		return -ENOMEM;
> +	}
>   
>   	pparms->ref_clock = LSDC_PLL_REF_CLK_KHZ;
>   

