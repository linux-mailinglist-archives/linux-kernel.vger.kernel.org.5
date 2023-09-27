Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7C7AFB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjI0GpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjI0Gow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:44:52 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17DA3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:44:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97F66240005;
        Wed, 27 Sep 2023 06:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695797089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkiMQS0h03kR9XwkdIs5uj8Y1YzwHNmKB+9PoQ4lSL0=;
        b=XRukPAckv6xotB3jVxFy4667OmM9aYny27MOBlx/BTcOP+fM4zVksB73m1skzTs3LuEPpg
        28sKZ9s7L/Oqt1lwd7bnXWCDqokDgIuJgssp5DI1MCsncP8PLw07fdqYpQURB8PlIIaM3D
        93bLk2K43GorkeGCMIk8B+OCDjV8tBPUf30PS4b4LpM1wn5+YvEI05vXKqtR6EFOczywI5
        xrHINcV0dOenfCZ2+TfOVVJblcbuVpw9L0kd6HO7Om4Fz8l3QxHEMsyT9NuuX2nhyIyx2d
        2p9J4fl9lVT/dZiNwsgHxJAR6mxaQrqmovXmMDr3X9tHCbxioEYFBz6WzsR54A==
Date:   Wed, 27 Sep 2023 08:44:46 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 06/40] soc/fsl: cpm: qmc: Convert to platform remove
 callback returning void
Message-ID: <20230927084446.66affc74@bootlin.com>
In-Reply-To: <20230925095532.1984344-7-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
        <20230925095532.1984344-7-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 11:54:57 +0200
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
>  drivers/soc/fsl/qe/qmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index b3c292c9a14e..92ec76c03965 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -1415,7 +1415,7 @@ static int qmc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int qmc_remove(struct platform_device *pdev)
> +static void qmc_remove(struct platform_device *pdev)
>  {
>  	struct qmc *qmc = platform_get_drvdata(pdev);
>  
> @@ -1427,8 +1427,6 @@ static int qmc_remove(struct platform_device *pdev)
>  
>  	/* Disconnect the serial from TSA */
>  	tsa_serial_disconnect(qmc->tsa_serial);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id qmc_id_table[] = {
> @@ -1443,7 +1441,7 @@ static struct platform_driver qmc_driver = {
>  		.of_match_table = of_match_ptr(qmc_id_table),
>  	},
>  	.probe = qmc_probe,
> -	.remove = qmc_remove,
> +	.remove_new = qmc_remove,
>  };
>  module_platform_driver(qmc_driver);
>  

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
