Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6E7F497E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKVO4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjKVO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:56:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0DB1A8;
        Wed, 22 Nov 2023 06:56:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED22229A;
        Wed, 22 Nov 2023 15:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700664938;
        bh=AQD+AKtGlu5tb4VGoUq86TgL623DydxCYLmlNgoA7c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzPk2RTolTmQljSyoiQ+sfpc6Pyg/8tXEJs3yMlo9BGljwJLnNAwonjJiomJXb5lo
         HSU807deQV2E+RgEs8lcoJSVasn35heION686EHylY6++bKv/LWGX7rIgYUeUPE5/G
         f7B2+xSxvjba7q15LmmnCQIEEj/zW+y6KBfecC4M=
Date:   Wed, 22 Nov 2023 16:56:15 +0200
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
Subject: Re: [PATCH 1/2] media: imx-mipi-csis: Fix clock handling in remove()
Message-ID: <20231122145615.GE8627@pendragon.ideasonboard.com>
References: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
 <20231122-imx-csis-v1-1-0617368eb996@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122-imx-csis-v1-1-0617368eb996@ideasonboard.com>
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

On Wed, Nov 22, 2023 at 03:13:48PM +0200, Tomi Valkeinen wrote:
> The driver always calls mipi_csis_runtime_suspend() and
> mipi_csis_clk_disable() in remove(). This causes multiple WARNs from the
> kernel, as the clocks get disabled too many times.

Did you try to unload the driver ? What a weird idea :-)

> Fix the remove() to call mipi_csis_runtime_suspend() and
> mipi_csis_clk_disable() in a way that reverses what is done in probe().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 6cb20b45e0a1..b39d7aeba750 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1502,8 +1502,10 @@ static void mipi_csis_remove(struct platform_device *pdev)
>  	v4l2_async_nf_cleanup(&csis->notifier);
>  	v4l2_async_unregister_subdev(&csis->sd);
>  
> +	if (!pm_runtime_enabled(&pdev->dev))
> +		mipi_csis_runtime_suspend(&pdev->dev);
> +
>  	pm_runtime_disable(&pdev->dev);
> -	mipi_csis_runtime_suspend(&pdev->dev);
>  	mipi_csis_clk_disable(csis);
>  	v4l2_subdev_cleanup(&csis->sd);
>  	media_entity_cleanup(&csis->sd.entity);
> 

-- 
Regards,

Laurent Pinchart
