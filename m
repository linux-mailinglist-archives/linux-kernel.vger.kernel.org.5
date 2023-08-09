Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABD877505F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHIBbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHIBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:31:39 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71619AD;
        Tue,  8 Aug 2023 18:31:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpMvEyN_1691544693;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpMvEyN_1691544693)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 09:31:34 +0800
Message-ID: <e5d5a440-af25-17a7-40a2-8dbbc8c20c69@linux.alibaba.com>
Date:   Wed, 9 Aug 2023 09:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230808033144.2276-1-Wenhua.Lin@unisoc.com>
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
> Clear interrupt after set the interrupt type.

Sorry, NAK. The commit message is meaningless.

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index c506cfd6df8e..31125f53bc97 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -374,29 +374,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
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
> @@ -409,29 +414,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
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
