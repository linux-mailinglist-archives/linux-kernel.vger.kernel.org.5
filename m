Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8008775058
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHIB3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:29:13 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FC19A8;
        Tue,  8 Aug 2023 18:29:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpMyCmQ_1691544547;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpMyCmQ_1691544547)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 09:29:08 +0800
Message-ID: <4bfc8ac2-f253-ab4d-3d44-2cbd62dce20f@linux.alibaba.com>
Date:   Wed, 9 Aug 2023 09:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must
 be forced open
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230808033130.2226-1-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230808033130.2226-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> In the sleep state, Eic dbnc has no clock and the clk enable
> of dbnc needs to be forced open, so that eic can wake up normally.

Sounds reasonable to me. Should add a Fixes tag if need to backport for 
stable kernel?

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 0d85d9e80848..c506cfd6df8e 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -23,6 +23,7 @@
>   #define SPRD_EIC_DBNC_IC		0x24
>   #define SPRD_EIC_DBNC_TRIG		0x28
>   #define SPRD_EIC_DBNC_CTRL0		0x40
> +#define SPRD_EIC_DBNC_FORCE_CLK		0x8000
>   
>   #define SPRD_EIC_LATCH_INTEN		0x0
>   #define SPRD_EIC_LATCH_INTRAW		0x4
> @@ -213,6 +214,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
>   	u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
>   
>   	value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> +	value |= SPRD_EIC_DBNC_FORCE_CLK;
>   	writel_relaxed(value, base + reg);
>   
>   	return 0;
