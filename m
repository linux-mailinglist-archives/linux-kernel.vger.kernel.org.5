Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853BA7AFFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjI0JPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjI0JPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:15:35 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149B92;
        Wed, 27 Sep 2023 02:15:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VszroM3_1695806129;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VszroM3_1695806129)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 17:15:29 +0800
Message-ID: <106d5134-6829-5a25-f1b1-37e5fe20a617@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 17:15:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 2/4] gpio: sprd: Clear interrupt after set the
 interrupt type
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
 <20230921090027.11136-3-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230921090027.11136-3-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> The initialization state of the EIC module is a high level trigger.
> If it is currently a high level, the interrupt condition is met at
> this time, and the EIC interrupt has a latch capability, which will
> cause an interrupt to occur after booting. To avoid this, When setting
> the EIC interrupt trigger type, clear the interrupt once.

With Andy's comments,
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index bfa8a4c7515a..96f1c7fd3988 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -375,29 +375,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_EDGE_FALLING:
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
> +			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_EDGE_BOTH:
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_LEVEL_HIGH:
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_level_irq);
>   			break;
>   		case IRQ_TYPE_LEVEL_LOW:
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
>   			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
> +			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_level_irq);
>   			break;
>   		default:
> @@ -410,29 +415,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_EDGE_FALLING:
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
> +			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_EDGE_BOTH:
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_edge_irq);
>   			break;
>   		case IRQ_TYPE_LEVEL_HIGH:
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
> +			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_level_irq);
>   			break;
>   		case IRQ_TYPE_LEVEL_LOW:
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
>   			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
> +			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>   			irq_set_handler_locked(data, handle_level_irq);
>   			break;
>   		default:
