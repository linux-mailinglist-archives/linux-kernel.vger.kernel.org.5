Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8857C9908
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjJOMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjJOMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:50:12 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5BA9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:50:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7D3AFFB04;
        Sun, 15 Oct 2023 14:50:09 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sQ3EZ0YgUYnD; Sun, 15 Oct 2023 14:50:06 +0200 (CEST)
Date:   Sun, 15 Oct 2023 14:50:03 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/1] drm/panel: st7703: Fix timings when
 entering/exiting sleep
Message-ID: <ZSvf-xHBKRPzmNVf@qwark.sigxcpu.org>
References: <20230213123238.76889-1-frank@oltmanns.dev>
 <20230213123238.76889-2-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213123238.76889-2-frank@oltmanns.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Feb 13, 2023 at 01:32:38PM +0100, Frank Oltmanns wrote:
> Fix flickering of the pinephone's XDB599 panel that happens after
> resume.
> 
> Extend the delay after issuing the command to exit sleep mode from 60 to
> 120 msec as per the controller's specification.
> 
> Introduce a 120 msec delay after issuing the command to enter sleep
> mode. This is needed in order for the controller to reliably finalize
> the sleep in sequence before switching of power supply.
> 
> In contrast to the JH057N panel, the XBD599 panel does not require a 20
> msec delay after initialization and exiting sleep mode. Therefore, move
> the delay into the already existing device specific initialization
> function.
> 
> The XDB599 does not require a 20 msec delay between the SETBGP and
> SETVCOM commands. Therefore, remove the delay from the device specific
> initialization function.

Thanks. Applied to drm-misc-next.
Cheers,
 -- Guido

> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Cc: Ondrej Jirman <megi@xff.cz>
> Reported-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 6747ca237ced..c49f4ef883fc 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -126,6 +126,7 @@ static int jh057n_init_sequence(struct st7703 *ctx)
>  				   0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
>  				   0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
>  				   0x11, 0x18);
> +	msleep(20);
>  
>  	return 0;
>  }
> @@ -273,7 +274,6 @@ static int xbd599_init_sequence(struct st7703 *ctx)
>  	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
>  			       0x07, /* VREF_SEL = 4.2V */
>  			       0x07  /* NVREF_SEL = 4.2V */);
> -	msleep(20);
>  
>  	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
>  			       0x2C, /* VCOMDC_F = -0.67V */
> @@ -350,16 +350,14 @@ static int st7703_enable(struct drm_panel *panel)
>  		return ret;
>  	}
>  
> -	msleep(20);
> -
>  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>  	if (ret < 0) {
>  		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
>  		return ret;
>  	}
>  
> -	/* Panel is operational 120 msec after reset */
> -	msleep(60);
> +	/* It takes the controller 120 msec to wake up after sleep. */
> +	msleep(120);
>  
>  	ret = mipi_dsi_dcs_set_display_on(dsi);
>  	if (ret)
> @@ -384,6 +382,9 @@ static int st7703_disable(struct drm_panel *panel)
>  	if (ret < 0)
>  		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
>  
> +	/* It takes the controller 120 msec to enter sleep mode. */
> +	msleep(120);
> +
>  	return 0;
>  }
>  
> -- 
> 2.39.1
> 
