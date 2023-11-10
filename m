Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443297E8103
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346240AbjKJSVD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 13:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbjKJSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA0B32810B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:18:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153F7106F;
        Fri, 10 Nov 2023 02:18:58 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566393F6C4;
        Fri, 10 Nov 2023 02:18:12 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:18:09 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 06/12] bus: sun50i-de2: Convert to platform remove
 callback returning void
Message-ID: <20231110101809.78f64217@donnerap.manchester.arm.com>
In-Reply-To: <20231109202830.4124591-7-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
        <20231109202830.4124591-7-u.kleine-koenig@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 21:28:36 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

Hi,

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

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/bus/sun50i-de2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/sun50i-de2.c b/drivers/bus/sun50i-de2.c
> index 414f29cdedf0..3339311ce068 100644
> --- a/drivers/bus/sun50i-de2.c
> +++ b/drivers/bus/sun50i-de2.c
> @@ -24,10 +24,9 @@ static int sun50i_de2_bus_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int sun50i_de2_bus_remove(struct platform_device *pdev)
> +static void sun50i_de2_bus_remove(struct platform_device *pdev)
>  {
>  	sunxi_sram_release(&pdev->dev);
> -	return 0;
>  }
>  
>  static const struct of_device_id sun50i_de2_bus_of_match[] = {
> @@ -37,7 +36,7 @@ static const struct of_device_id sun50i_de2_bus_of_match[] = {
>  
>  static struct platform_driver sun50i_de2_bus_driver = {
>  	.probe = sun50i_de2_bus_probe,
> -	.remove = sun50i_de2_bus_remove,
> +	.remove_new = sun50i_de2_bus_remove,
>  	.driver = {
>  		.name = "sun50i-de2-bus",
>  		.of_match_table = sun50i_de2_bus_of_match,

