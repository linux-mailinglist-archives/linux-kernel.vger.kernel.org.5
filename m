Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF178AE56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjH1LAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjH1K7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:59:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAEFF;
        Mon, 28 Aug 2023 03:59:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA3046B5;
        Mon, 28 Aug 2023 12:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693220304;
        bh=wMJK57kbx7lOYBO0YvZkYHNeXslbI+8ZdYW1nRpQ8l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnpASNMOK9DEnOJS+/n3gqrAZIbKWSYqHtES+Vq0ypNrwsN7ddmKqnZZJySYIOOz0
         C5mQTzTjVZKNNLJH1G8pnDGSikD1+yefUnKm7hsmWRZtWiVIWUmeGmaPSABnVHePda
         LKBPDFue1yGUSGsl0vu2McPlpqAzdJidq1jgDMRQ=
Date:   Mon, 28 Aug 2023 13:59:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: max9286: Fix some redundant of_node_put()
 calls
Message-ID: <20230828105954.GG14596@pendragon.ideasonboard.com>
References: <084fdd562690c08f1ee72bc08e63e8ee576dc86a.1693001599.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <084fdd562690c08f1ee72bc08e63e8ee576dc86a.1693001599.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Sat, Aug 26, 2023 at 12:13:40AM +0200, Christophe JAILLET wrote:
> This is odd to have a of_node_put() just after a for_each_child_of_node()
> or a for_each_endpoint_of_node() loop. It should already be called
> during the last iteration.
> 
> Remove these calls.
> 
> Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> /!\  This patch is speculative, review with case  /!\
> ---
>  drivers/media/i2c/max9286.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 20e7c7cf5eeb..f27a69b1b727 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1450,7 +1450,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
>  
>  		i2c_mux_mask |= BIT(id);
>  	}
> -	of_node_put(node);
>  	of_node_put(i2c_mux);
>  
>  	/* Parse the endpoints */
> @@ -1514,7 +1513,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
>  		priv->source_mask |= BIT(ep.port);
>  		priv->nsources++;
>  	}
> -	of_node_put(node);
>  
>  	of_property_read_u32(dev->of_node, "maxim,bus-width", &priv->bus_width);
>  	switch (priv->bus_width) {

-- 
Regards,

Laurent Pinchart
