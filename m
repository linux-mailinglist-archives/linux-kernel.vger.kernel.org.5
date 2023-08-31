Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058F478E70F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHaHQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHaHQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:16:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380AE62;
        Thu, 31 Aug 2023 00:16:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75645836;
        Thu, 31 Aug 2023 09:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693466054;
        bh=tVpuZI+y28Ywlldd4PZ6z5BJVpXZjNaH4iaRbuAIPbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lu2ZvOQ6sdIZ+07h4wvxA+rgmdmI7xLnvfEztbfY4wd9O0X7cNRGhrbrF4SEwlslZ
         VMvY9qmgXY7M6IuqD93rozTmaHdikGsVeCIu+ej4t8QF3BASPmahKkatNYrDvD+NKA
         b+Xm8/4rrLr2ZlgJBgLU9eaqIHn2UY1y8/lOkrs8=
Date:   Thu, 31 Aug 2023 10:15:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: imx-mipi-csis: Remove an incorrect
 fwnode_handle_put() call
Message-ID: <20230831071547.GC2698@pendragon.ideasonboard.com>
References: <dd5b741f496d074d342958f14baff5bae8c71531.1693429556.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd5b741f496d074d342958f14baff5bae8c71531.1693429556.git.christophe.jaillet@wanadoo.fr>
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

On Wed, Aug 30, 2023 at 11:06:14PM +0200, Christophe JAILLET wrote:
> The commit in Fixes has removed an fwnode_graph_get_endpoint_by_id() call
> in mipi_csis_subdev_init().
> So the reference that was taken should not be released anymore in the
> error handling path of the probe and in the remove function.
> 
> Remove the now incorrect fwnode_handle_put() calls.
> 
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 16f19a640130..5f93712bf485 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1490,7 +1490,6 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	v4l2_async_unregister_subdev(&csis->sd);
>  err_disable_clock:
>  	mipi_csis_clk_disable(csis);
> -	fwnode_handle_put(csis->sd.fwnode);
>  
>  	return ret;
>  }
> @@ -1510,7 +1509,6 @@ static void mipi_csis_remove(struct platform_device *pdev)
>  	mipi_csis_clk_disable(csis);
>  	v4l2_subdev_cleanup(&csis->sd);
>  	media_entity_cleanup(&csis->sd.entity);
> -	fwnode_handle_put(csis->sd.fwnode);
>  	pm_runtime_set_suspended(&pdev->dev);
>  }
>  

-- 
Regards,

Laurent Pinchart
