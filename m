Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84A77AFB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjI0Gow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjI0Goa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:44:30 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7BEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:44:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A25640003;
        Wed, 27 Sep 2023 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695797067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6w55e/rZZu6aBcdMenyM29aj/jZfbSewfoXt20wM3HE=;
        b=JCUyZ35Y34m8eNV5AYUbxw8m418hEdMFBN2Js5CxabrdUoH7FIHrMeVA293I3eI6POnkU7
        DOAJW5vbmOydtDsh2MYc9iZd0PXdjP+UQ5gHmA2d6ZVsidSIVAizBp+R+hNTQG0MJipQi2
        836XR2K6kykJDIY47I1Gc/W4BvuJI+oI8ibjeJfXMC91DmO1VHuP4eGlIjK698yaGAZ5GR
        zaawiGzo+wm2SPwNVqJzmrcnjT2Wr7cO111NYEKQh15D3bCLgfMm4l7KMIbAFhcIk9DDRQ
        ofpwEg5drYgz0WeN/2YEV6axZZXnR+EaG0eh1eHjw0NCTJFih0gujpVEfk8WCA==
Date:   Wed, 27 Sep 2023 08:44:24 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 07/40] soc/fsl: cpm: tsa: Convert to platform remove
 callback returning void
Message-ID: <20230927084424.177d2764@bootlin.com>
In-Reply-To: <20230925095532.1984344-8-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
        <20230925095532.1984344-8-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Mon, 25 Sep 2023 11:54:58 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/soc/fsl/qe/tsa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 3646153117b3..3f9981335590 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -706,7 +706,7 @@ static int tsa_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int tsa_remove(struct platform_device *pdev)
> +static void tsa_remove(struct platform_device *pdev)
>  {
>  	struct tsa *tsa = platform_get_drvdata(pdev);
>  	int i;
> @@ -729,7 +729,6 @@ static int tsa_remove(struct platform_device *pdev)
>  			clk_put(tsa->tdm[i].l1rclk_clk);
>  		}
>  	}
> -	return 0;
>  }
>  
>  static const struct of_device_id tsa_id_table[] = {
> @@ -744,7 +743,7 @@ static struct platform_driver tsa_driver = {
>  		.of_match_table = of_match_ptr(tsa_id_table),
>  	},
>  	.probe = tsa_probe,
> -	.remove = tsa_remove,
> +	.remove_new = tsa_remove,
>  };
>  module_platform_driver(tsa_driver);
>  

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
