Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D336761E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGYQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGYQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:30:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D10311A;
        Tue, 25 Jul 2023 09:30:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4AA134AD;
        Tue, 25 Jul 2023 18:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690302573;
        bh=k+Peaua+jrXGhzwyW/0IjINrHEbJHZ4Qwtk++uw3Gfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgZHHBRxf2MqyGPPVQlzvzbaj2JnS+fCE9nRHlRrVkP/aqEDhNtthBp+6Uy3Lbk4k
         A5rHAKCo03sgqNFTozL3MI+t0v1omU9fpl+itPBoacyFqaszxJl6k/6U2gZJIW7d3b
         wfgQAe1NiuSLQhCtRxqh9uml470w1Lkxntfqajo4=
Date:   Tue, 25 Jul 2023 19:30:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] media: i2c: ds90ub953: Use
 v4l2_fwnode_endpoint_parse()
Message-ID: <20230725163039.GI31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-2-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-2-b91b1eca2ad3@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Jul 20, 2023 at 01:30:33PM +0300, Tomi Valkeinen wrote:
> Use v4l2_fwnode_endpoint_parse() to parse the sink endpoint parameters.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/i2c/ds90ub953.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index 591b52bf71c2..ad964bd6c7eb 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -25,6 +25,8 @@
>  #include <media/i2c/ds90ub9xx.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-event.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mediabus.h>
>  #include <media/v4l2-subdev.h>
>  
>  #define UB953_PAD_SINK			0
> @@ -1111,7 +1113,9 @@ static const struct regmap_config ub953_regmap_config = {
>  static int ub953_parse_dt(struct ub953_data *priv)
>  {
>  	struct device *dev = &priv->client->dev;
> +	struct v4l2_fwnode_endpoint vep = {};
>  	struct fwnode_handle *ep_fwnode;
> +	unsigned char nlanes;
>  	int ret;
>  
>  	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> @@ -1119,19 +1123,21 @@ static int ub953_parse_dt(struct ub953_data *priv)
>  	if (!ep_fwnode)
>  		return dev_err_probe(dev, -ENOENT, "no endpoint found\n");
>  
> -	ret = fwnode_property_count_u32(ep_fwnode, "data-lanes");
> +	vep.bus_type = V4L2_MBUS_CSI2_DPHY;

I would initialize .bus_type when declaring the variable.

> +	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &vep);
>  
>  	fwnode_handle_put(ep_fwnode);
>  
> -	if (ret < 0)
> +	if (ret)
>  		return dev_err_probe(dev, ret,
> -				     "failed to parse property 'data-lanes'\n");
> +				     "failed to parse sink endpoint data\n");
>  
> -	if (ret != 1 && ret != 2 && ret != 4)
> +	nlanes = vep.bus.mipi_csi2.num_data_lanes;
> +	if (nlanes != 1 && nlanes != 2 && nlanes != 4)
>  		return dev_err_probe(dev, -EINVAL,
> -				     "bad number of data-lanes: %d\n", ret);
> +				     "bad number of data-lanes: %d\n", nlanes);

%u as nlanes is now unsigned.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
> -	priv->num_data_lanes = ret;
> +	priv->num_data_lanes = nlanes;
>  
>  	return 0;
>  }
> 

-- 
Regards,

Laurent Pinchart
