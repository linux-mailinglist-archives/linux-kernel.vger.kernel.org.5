Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54518808D37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjLGQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLGQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:10:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1284
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:10:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE9CC433C8;
        Thu,  7 Dec 2023 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701965441;
        bh=F9jvVm4Xw/p4U6hdGC3086OM1LmvQJua8bhrbGVSwCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZzWK5JRmFVCcZOjYN86lmpWzPq2AWQGQjfmSAYhjdi189K2Fnvuo5itPQU+PqFU8
         Z9VJfw88x0AQVscIPQmRyrOudv+vd7tsKBFL3NDICK+tQN2aufJJRIfw9X4ttqwmdt
         hj+EJxyOZ8oDpwivD1zh0rdV5yz7tHGY5MaxoV2X1Q7R3Ov1ZKlMFSF41/d2woB7p8
         512pMsymUMGsdxYrD76TVeDG0phxI0qEOvCqU8hxUFfDgotQxG16gzF5uL5pTPaDRb
         FDSo3mE5ysR9PjLl5zFwKDoc/nn+HLz5aVrxdh3tH0zCV1dbG8ytegL7vXLaIYw7nK
         1O2q7Xe54S7hg==
Date:   Thu, 7 Dec 2023 16:10:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jpanis@baylibre.com, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6594: Add null pointer check to
 tps6594_device_init
Message-ID: <20231207161037.GA111411@google.com>
References: <20231205095426.2532572-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205095426.2532572-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023, Kunwu Chan wrote:

> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/mfd/tps6594-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
> index 0fb9c5cf213a..6403c1063de9 100644
> --- a/drivers/mfd/tps6594-core.c
> +++ b/drivers/mfd/tps6594-core.c
> @@ -433,6 +433,9 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
>  	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
>  					       dev->driver->name, tps->chip_id, tps->reg);
>  
> +	if (!tps6594_irq_chip.name)
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate memory\n");
> +

The check is fine, but the use of dev_err_probe() is not.

Simply:

	return -ENOMEM;

>  	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
>  				       0, &tps6594_irq_chip, &tps->irq_data);
>  	if (ret)
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
