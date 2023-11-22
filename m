Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4CF7F4999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbjKVPEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344284AbjKVPEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:04:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB092;
        Wed, 22 Nov 2023 07:04:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A829C276;
        Wed, 22 Nov 2023 16:03:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700665412;
        bh=Khzc5e3MF7Rql+822BCxtzuamdUU+FbcCsol+NM5omk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AswJOSfmq6jWjqkIxgblejlN62dmvtlzl37M8vuQGgBZBmIsx26UtuYGztLY0u0n6
         uVBswsKVdRwNhFnxuCRFlLaXRb4HBY4E2DFHPsRdG0fYwEADJUFgoKkrWG+nPp7aVD
         IfrZ5CQIb56bscsj4eIMFYAo3EkrsgwH3CLFa4wA=
Date:   Wed, 22 Nov 2023 17:04:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: imx-mipi-csis: Drop extra clock enable at
 probe()
Message-ID: <20231122150410.GF8627@pendragon.ideasonboard.com>
References: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
 <20231122-imx-csis-v1-2-0617368eb996@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122-imx-csis-v1-2-0617368eb996@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 22, 2023 at 03:13:49PM +0200, Tomi Valkeinen wrote:
> The driver always enables the clocks at probe() and disables them only
> at remove(). It is not clear why the driver does this, as it supports
> runtime PM, and enables and disables the clocks in the runtime resume
> and suspend callbacks. Also, in the case runtime PM is not available,
> the driver calls the resume and suspend callbacks manually from probe()
> and remove().

Probably a historical mistake. It predates my involvement with the
driver :-)

> Drop the unnecessary clock enable, thus enabling the clocks only when
> actually needed.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index b39d7aeba750..b08f6d2e7516 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1435,24 +1435,18 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	/* Reset PHY and enable the clocks. */
>  	mipi_csis_phy_reset(csis);
>  
> -	ret = mipi_csis_clk_enable(csis);
> -	if (ret < 0) {
> -		dev_err(csis->dev, "failed to enable clocks: %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* Now that the hardware is initialized, request the interrupt. */
>  	ret = devm_request_irq(dev, irq, mipi_csis_irq_handler, 0,
>  			       dev_name(dev), csis);
>  	if (ret) {
>  		dev_err(dev, "Interrupt request failed\n");
> -		goto err_disable_clock;
> +		return ret;
>  	}
>  
>  	/* Initialize and register the subdev. */
>  	ret = mipi_csis_subdev_init(csis);
>  	if (ret < 0)
> -		goto err_disable_clock;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, &csis->sd);
>  
> @@ -1486,8 +1480,6 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	v4l2_async_nf_unregister(&csis->notifier);
>  	v4l2_async_nf_cleanup(&csis->notifier);
>  	v4l2_async_unregister_subdev(&csis->sd);
> -err_disable_clock:
> -	mipi_csis_clk_disable(csis);
>  
>  	return ret;
>  }
> @@ -1506,7 +1498,6 @@ static void mipi_csis_remove(struct platform_device *pdev)
>  		mipi_csis_runtime_suspend(&pdev->dev);
>  
>  	pm_runtime_disable(&pdev->dev);
> -	mipi_csis_clk_disable(csis);
>  	v4l2_subdev_cleanup(&csis->sd);
>  	media_entity_cleanup(&csis->sd.entity);
>  	pm_runtime_set_suspended(&pdev->dev);
> 

-- 
Regards,

Laurent Pinchart
