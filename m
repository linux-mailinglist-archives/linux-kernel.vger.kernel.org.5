Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB577DE200
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjKAN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKAN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:59:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3032C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:59:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B1998D;
        Wed,  1 Nov 2023 14:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698847167;
        bh=Kk3cjpPlYgWjFuX7ru0ITvm8imGQnvx+xHTP55Nst3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoNlyhp61ZZwdbxNajaWf/3bxNhh9B4faX5CGYslMRpd22WVCTUkSZcGng3ZelBFg
         qUvuBfblVMaazuyzO341Ekx1lDdX9RVskSp5L+l1hJreb53muRxOD+WKTaPxBU8B1k
         wv6UEBV6B0kL7zT4JIWfqoryTUWZyOjuQURKhqcI=
Date:   Wed, 1 Nov 2023 15:59:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] drm/tidss: Return error value from from softreset
Message-ID: <20231101135951.GU12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-5-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-5-45149e0f9415@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 01, 2023 at 11:17:42AM +0200, Tomi Valkeinen wrote:
> Return an error value from dispc_softreset() so that the caller can
> handle the errors.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 9430625e2d62..cdbb88289082 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2702,7 +2702,7 @@ static void dispc_init_errata(struct dispc_device *dispc)
>  	}
>  }
>  
> -static void dispc_softreset(struct dispc_device *dispc)
> +static int dispc_softreset(struct dispc_device *dispc)
>  {
>  	u32 val;
>  	int ret;
> @@ -2712,8 +2712,12 @@ static void dispc_softreset(struct dispc_device *dispc)
>  	/* Wait for reset to complete */
>  	ret = readl_poll_timeout(dispc->base_common + DSS_SYSSTATUS,
>  				 val, val & 1, 100, 5000);
> -	if (ret)
> -		dev_warn(dispc->dev, "failed to reset dispc\n");
> +	if (ret) {
> +		dev_err(dispc->dev, "failed to reset dispc\n");
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  int dispc_init(struct tidss_device *tidss)
> @@ -2828,8 +2832,11 @@ int dispc_init(struct tidss_device *tidss)
>  	tidss->dispc = dispc;
>  
>  	/* K2G display controller does not support soft reset */
> -	if (feat->subrev != DISPC_K2G)
> -		dispc_softreset(dispc);
> +	if (feat->subrev != DISPC_K2G) {
> +		r = dispc_softreset(dispc);
> +		if (r)
> +			return r;

tidss->dispc will be set in this case. Could that cause problems ?

> +	}
>  
>  	return 0;
>  }
> 

-- 
Regards,

Laurent Pinchart
