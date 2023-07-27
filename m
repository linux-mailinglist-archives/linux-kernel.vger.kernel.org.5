Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57304765069
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjG0Jzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjG0JzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:55:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7D11F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:55:21 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2950E29A;
        Thu, 27 Jul 2023 11:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690451660;
        bh=52l2fE698ZVJp/Pwim4ovXviYlJUSpyIEpTqajcG8hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ug4jKoFzBP5iUCIvhN0PK0CdPHa35wYWjxGDw9KsTCD46ZnvEnhWHO6dRJUD6J41s
         FpJup+JNNzMIKbc0kRx9WJl+/pEW3odZ0Mg4b7mwUd6CKI1xyA/FRIHfQt2GDTwlwW
         RDlP2H01fOFTpv4jyN7ccEZDXEPJPebmq5nRGT/A=
Date:   Thu, 27 Jul 2023 12:55:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
        guozhengkui@vivo.com, dianders@chromium.org, yuancan@huawei.com,
        arnd@arndb.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: omapdrm: dss: Remove redundant DSSERR()
Message-ID: <20230727095525.GG25174@pendragon.ideasonboard.com>
References: <20230727113923.3093070-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727113923.3093070-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruan,

Thank you for the patch.

On Thu, Jul 27, 2023 at 11:39:23AM +0000, Ruan Jinjie wrote:
> There is no need to call the DSSERR() function directly to print
> a custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message
> in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I expect Tomi to pick this up and push it to drm-misc.

> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 1 -
>  drivers/gpu/drm/omapdrm/dss/dsi.c   | 4 +---
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c | 1 -
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c | 1 -
>  4 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index c26aab4939fa..9209103f5dc5 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -4779,7 +4779,6 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
>  
>  	dispc->irq = platform_get_irq(dispc->pdev, 0);
>  	if (dispc->irq < 0) {
> -		DSSERR("platform_get_irq failed\n");
>  		r = -ENODEV;
>  		goto err_free;
>  	}
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index ea63c64d3a1a..63cfe0776788 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4935,10 +4935,8 @@ static int dsi_probe(struct platform_device *pdev)
>  		return PTR_ERR(dsi->pll_base);
>  
>  	dsi->irq = platform_get_irq(pdev, 0);
> -	if (dsi->irq < 0) {
> -		DSSERR("platform_get_irq failed\n");
> +	if (dsi->irq < 0)
>  		return -ENODEV;
> -	}
>  
>  	r = devm_request_irq(dev, dsi->irq, omap_dsi_irq_handler,
>  			     IRQF_SHARED, dev_name(dev), dsi);
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> index a26b77d99d52..d4fd6c680db3 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -782,7 +782,6 @@ static int hdmi4_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		DSSERR("platform_get_irq failed\n");
>  		r = -ENODEV;
>  		goto err_free;
>  	}
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> index e6611c683857..27c21ff8c4e5 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -756,7 +756,6 @@ static int hdmi5_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		DSSERR("platform_get_irq failed\n");
>  		r = -ENODEV;
>  		goto err_free;
>  	}

-- 
Regards,

Laurent Pinchart
