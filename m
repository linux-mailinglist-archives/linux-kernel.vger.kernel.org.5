Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE27FDE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjK2RPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2RPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:15:51 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3DFBC;
        Wed, 29 Nov 2023 09:15:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C662E0004;
        Wed, 29 Nov 2023 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701278156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fi6pfw/YrdlpRPQlqpuxTgYt0q8n78JWGSCcDcbp5EI=;
        b=i4pse/XMReNnftJ2DWqBLM7jpvYxZPwRWmWUEakFhPmk2HCamL/ds+2m58H3Ce/FcdkE+f
        S+20MoxlcdoyCAIf6H1l6po+cFGyUk/3AOpPXeLp4PPTay1ItCwJ9O0H1SA5KJ7WUl5isz
        21iBx0ds/o/eeE2p2AX9bKDkREHNqrbHXhmKfEgcs+3MdPFfxHCHYneAAX8kFuikjYjhxA
        Mo2YrbnP/BnbOxS9xf41dmjT3mDAwRmeI8CG7DT+Dt2sJcTpJV0Kw/r/We9vnPGLKlXdmt
        x6ZWVhtk0y8ydlfh9qUfIYLqU/enO6Nw/n3iD3xVle2Md8ZJIWq2oyiuH0anig==
Date:   Wed, 29 Nov 2023 18:15:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     claudiu.beznea@tuxon.dev, sre@kernel.org,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [power/reset] at91-sama5d2: Add error handling in
 at91_shdwc_probe
Message-ID: <20231129171555abae472b@mail.local>
References: <20231129132939.34047-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129132939.34047-1-liuhaoran14@163.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 05:29:39-0800, Haoran Liu wrote:
> This patch adds error handling to the at91_shdwc_probe function
> in drivers/power/reset/at91-sama5d2_shdwc.c. The function
> previously did not handle the case where of_match_node could fail,
> potentially leading to unexpected behavior if the device tree match
> was unsuccessful.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index e76b102b57b1..2ac566c83aec 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -353,6 +353,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
>  		return PTR_ERR(at91_shdwc->shdwc_base);
>  
>  	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> +	if (!match) {

Can you elaborate how this will ever happen?

> +		dev_err(&pdev->dev, "No matching device found\n");
> +		return -ENODEV;
> +	}
> +
>  	at91_shdwc->rcfg = match->data;
>  
>  	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
