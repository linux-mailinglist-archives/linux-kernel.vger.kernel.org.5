Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5B7C9906
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJOMtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:49:29 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CBAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:49:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5C9B7FB03;
        Sun, 15 Oct 2023 14:49:24 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QmGYZ04xXnHb; Sun, 15 Oct 2023 14:49:23 +0200 (CEST)
Date:   Sun, 15 Oct 2023 14:49:20 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/1] drm/panel: st7703: Pick different reset sequence
Message-ID: <ZSvf0HIA3GaZlbac@qwark.sigxcpu.org>
References: <20230211171748.36692-1-frank@oltmanns.dev>
 <20230211171748.36692-2-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211171748.36692-2-frank@oltmanns.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, Feb 11, 2023 at 06:17:48PM +0100, Frank Oltmanns wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Switching to a different reset sequence, enabling IOVCC before enabling
> VCC.
> 
> There also needs to be a delay after enabling the supplies and before
> deasserting the reset. The datasheet specifies 1ms after the supplies
> reach the required voltage. Use 10-20ms to also give the power supplies
> some time to reach the required voltage, too.
> 
> This fixes intermittent panel initialization failures and screen
> corruption during resume from sleep on panel xingbangda,xbd599 (e.g.
> used in PinePhone).

Thanks, applied to drm-misc-next.
Cheers,
 -- Guido

> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Reported-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 6747ca237ced..45695aa51f62 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -411,29 +411,30 @@ static int st7703_prepare(struct drm_panel *panel)
>  		return 0;
>  
>  	dev_dbg(ctx->dev, "Resetting the panel\n");
> -	ret = regulator_enable(ctx->vcc);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +	ret = regulator_enable(ctx->iovcc);
>  	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
> +		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
>  		return ret;
>  	}
> -	ret = regulator_enable(ctx->iovcc);
> +
> +	ret = regulator_enable(ctx->vcc);
>  	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
> -		goto disable_vcc;
> +		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
> +		regulator_disable(ctx->iovcc);
> +		return ret;
>  	}
>  
> -	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -	usleep_range(20, 40);
> +	/* Give power supplies time to stabilize before deasserting reset. */
> +	usleep_range(10000, 20000);
> +
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -	msleep(20);
> +	usleep_range(15000, 20000);
>  
>  	ctx->prepared = true;
>  
>  	return 0;
> -
> -disable_vcc:
> -	regulator_disable(ctx->vcc);
> -	return ret;
>  }
>  
>  static const u32 mantix_bus_formats[] = {
> -- 
> 2.39.1
> 
