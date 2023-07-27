Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4867765B05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjG0R5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:57:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117F1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:57:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id P5F4qDaITwPEaP5F4qW8EI; Thu, 27 Jul 2023 19:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690480661;
        bh=6NdwEFY5PEBS94LBqV9kyzH4CKxF4uKgv/cX+8Q8EUg=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=f8lgaC4rt/NYabWboXiLRri3pJ3WFQMToqUOxBsJwJeNT6Q9ja/vLo+4duhJp4Y1A
         3t2gDKVw2i/BsaENfONMLEYhwkmngQSEigenlWFyZKEipPS++uvp362KPH7j9mergc
         E4tB/3cBMyerJh9N6zgUbXOwOuJpwzRcGcIeu60d0/hjHD9oj8THhvSTzz2iGmPcF1
         josw/bc9xR1uNS/Efcqa0yMvA8W/i4/RLLA7UQ5IoCy7B5INP7Gt9USRPdFHkYnWs+
         5rzPAYaQMe99vPZywrDXiv1qeAn8OdfsIyRtx7jg0kxUe82TzZdUea+IP5j0x8Y8GF
         DwhQIJUqiXC0Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Jul 2023 19:57:41 +0200
X-ME-IP: 86.243.2.178
Message-ID: <2419973d-1e21-5754-d309-436dc9c62be8@wanadoo.fr>
Date:   Thu, 27 Jul 2023 19:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] gpu: drm: aspeed: fix value check in
 aspeed_gfx_load()
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230727170342.18506-1-ruc_gongyuanjun@163.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230727170342.18506-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/07/2023 à 19:03, Yuanjun Gong a écrit :
> in aspeed_gfx_load(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index c8c7f8215155..3bfa39bc4f7e 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -199,7 +199,11 @@ static int aspeed_gfx_load(struct drm_device *drm)
>   			"missing or invalid clk device tree entry");
>   		return PTR_ERR(priv->clk);
>   	}
> -	clk_prepare_enable(priv->clk);
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable clock\n");
> +		return ret;
> +	}
>   
>   	/* Sanitize control registers */
>   	writel(0, priv->base + CRT_CTRL1);

Hi,

the code also lacks a clk_disable_unprepare() in aspeed_gfx_unload().

So using devm_clk_get_enabled() a few lines above should fix both issue.

CJ
