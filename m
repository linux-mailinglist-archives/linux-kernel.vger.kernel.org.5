Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA9778A73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHKJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHKJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:57:21 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9182728;
        Fri, 11 Aug 2023 02:57:20 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4A09C1000CD; Fri, 11 Aug 2023 10:57:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1691747838; bh=3HIl4Pdh0akdtOgpVnRFUOW7CwtiPKkOA8CKhy7hI/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qkr8lCMAGEaqpCpngAHqvXTtpXOGS2bhOeWvr3pavCW7Hg8CyqLS1sg88amOsEiap
         EIpGqPeRwQzLQZ9RhyHh0BPI7hVIvar6bUebjb0ztk85Ybk76L/BcH/Vo03HzuoMes
         LgClZ+PuaoXPZHksxqSR3P6QBUFaoGiqSvZ1dmimYsO9JL9cSxcIwX1AKZZH6f2w7I
         zNeiLHoLhNs1R4rwJWySqM1yNa004ctGBayIThlC+UG1GNWPL5c4cj0TOfxcGo18Kx
         XMASHz1DbTSNOk/bAm8ccq27tU1vC5PtGzSRx54bqzZGBqNClc2xXSfnlQj8idYXbX
         STJBe4e19p3Ug==
Date:   Fri, 11 Aug 2023 10:57:18 +0100
From:   Sean Young <sean@mess.org>
To:     wuxilin123@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] media: rc: ir-spi: Correct regulator name
Message-ID: <ZNYF/iGqrBQrV3IT@gofer.mess.org>
References: <20230805-ir-spi-v1-1-33af4a556139@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805-ir-spi-v1-1-33af4a556139@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 07:23:35PM +0800, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> The driver wrongly assumes regulator is called "irda_regulator"
> instead of "power".
> 
> Change it to "power" to match device tree binding.
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>  drivers/media/rc/ir-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
> index bbc81bed4f90..a447bb36100d 100644
> --- a/drivers/media/rc/ir-spi.c
> +++ b/drivers/media/rc/ir-spi.c
> @@ -119,7 +119,7 @@ static int ir_spi_probe(struct spi_device *spi)
>  	if (!idata)
>  		return -ENOMEM;
>  
> -	idata->regulator = devm_regulator_get(&spi->dev, "irda_regulator");
> +	idata->regulator = devm_regulator_get(&spi->dev, "power");

I agree that irda_regulator is not a great name and it probably should have
been picked up in review. However, is it safe to change without breaking
backwards compatibility?

Rob, what do you think?

Thanks
Sean

>  	if (IS_ERR(idata->regulator))
>  		return PTR_ERR(idata->regulator);
>  
> 
> ---
> base-commit: 024ff300db33968c133435a146d51ac22db27374
> change-id: 20230805-ir-spi-3473c5f34764
> 
> Best regards,
> -- 
> Xilin Wu <wuxilin123@gmail.com>
