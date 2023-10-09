Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1027BEB68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbjJIUQd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378520AbjJIUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:16:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F294;
        Mon,  9 Oct 2023 13:16:29 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qpwfx-0004xo-Vr; Mon, 09 Oct 2023 22:16:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/20] pinctrl: rockchip: Convert to platform remove callback
 returning void
Date:   Mon, 09 Oct 2023 22:16:25 +0200
Message-ID: <3523328.iIbC2pHGDl@phil>
In-Reply-To: <20231009083856.222030-12-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-12-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Oktober 2023, 10:38:47 CEST schrieb Uwe Kleine-König:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 45e416f68e74..3bedf36a0019 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -3429,7 +3429,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int rockchip_pinctrl_remove(struct platform_device *pdev)
> +static void rockchip_pinctrl_remove(struct platform_device *pdev)
>  {
>  	struct rockchip_pinctrl *info = platform_get_drvdata(pdev);
>  	struct rockchip_pin_bank *bank;
> @@ -3450,8 +3450,6 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
>  		}
>  		mutex_unlock(&bank->deferred_lock);
>  	}
> -
> -	return 0;
>  }
>  
>  static struct rockchip_pin_bank px30_pin_banks[] = {
> @@ -3982,7 +3980,7 @@ static const struct of_device_id rockchip_pinctrl_dt_match[] = {
>  
>  static struct platform_driver rockchip_pinctrl_driver = {
>  	.probe		= rockchip_pinctrl_probe,
> -	.remove		= rockchip_pinctrl_remove,
> +	.remove_new	= rockchip_pinctrl_remove,
>  	.driver = {
>  		.name	= "rockchip-pinctrl",
>  		.pm = &rockchip_pinctrl_dev_pm_ops,
> 




