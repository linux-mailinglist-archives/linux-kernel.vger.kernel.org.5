Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30E761E99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGYQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGYQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:34:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B32126;
        Tue, 25 Jul 2023 09:34:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7DF524AD;
        Tue, 25 Jul 2023 18:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690302784;
        bh=aij9G4GjATOyTE35RuKblu/wzs13SIYpwWwasKPsXqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXIviMYyRF8Yc1LYZsj7hEiAThQFey6p7bn7tG8eLXM4YXMSm661RElayROZhD/vu
         5haTU47ATuvp10b0BwH1OwHgolEzVM/UTkXLRv+VKqN1o3MEbqL3sbGyJrgcTLMHW4
         lS0o0jgTN6U8LCslYiWQam1xxZiQgO56X4ikvrv4=
Date:   Tue, 25 Jul 2023 19:34:10 +0300
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
Subject: Re: [PATCH v2 3/8] media: i2c: ds90ub913: Use
 v4l2_fwnode_endpoint_parse()
Message-ID: <20230725163410.GJ31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-3-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-3-b91b1eca2ad3@ideasonboard.com>
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

On Thu, Jul 20, 2023 at 01:30:34PM +0300, Tomi Valkeinen wrote:
> Use v4l2_fwnode_endpoint_parse() to parse the sink endpoint parameters.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/i2c/ds90ub913.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
> index 4dae5afa9fa9..cb53b0654a43 100644
> --- a/drivers/media/i2c/ds90ub913.c
> +++ b/drivers/media/i2c/ds90ub913.c
> @@ -21,6 +21,8 @@
>  #include <linux/regmap.h>
>  
>  #include <media/i2c/ds90ub9xx.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mediabus.h>
>  #include <media/v4l2-subdev.h>
>  
>  #define UB913_PAD_SINK			0
> @@ -83,7 +85,7 @@ struct ub913_data {
>  
>  	struct ds90ub9xx_platform_data *plat_data;
>  
> -	u32			pclk_polarity;
> +	u32			pclk_polarity_rising;

bool ?

>  };
>  
>  static inline struct ub913_data *sd_to_ub913(struct v4l2_subdev *sd)
> @@ -675,25 +677,31 @@ static int ub913_add_i2c_adapter(struct ub913_data *priv)
>  static int ub913_parse_dt(struct ub913_data *priv)
>  {
>  	struct device *dev = &priv->client->dev;
> +	struct v4l2_fwnode_endpoint vep = {};
>  	struct fwnode_handle *ep_fwnode;
>  	int ret;
>  
>  	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
>  						    UB913_PAD_SINK, 0, 0);
> -	if (!ep_fwnode) {
> -		dev_err_probe(dev, -ENOENT, "No sink endpoint\n");
> -		return -ENOENT;
> -	}
> +	if (!ep_fwnode)
> +		return dev_err_probe(dev, -ENOENT, "No sink endpoint\n");
>  
> -	ret = fwnode_property_read_u32(ep_fwnode, "pclk-sample",
> -				       &priv->pclk_polarity);
> +	vep.bus_type = V4L2_MBUS_PARALLEL;

I'd initialize this when declaring the variable.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &vep);
>  
>  	fwnode_handle_put(ep_fwnode);
>  
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to parse 'pclk-sample'\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to parse sink endpoint data\n");
> +
> +	if (vep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
> +		priv->pclk_polarity_rising = true;
> +	else if (vep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
> +		priv->pclk_polarity_rising = false;
> +	else
> +		return dev_err_probe(dev, -EINVAL,
> +				     "bad value for 'pclk-sample'\n");
>  
>  	return 0;
>  }
> @@ -726,7 +734,7 @@ static int ub913_hw_init(struct ub913_data *priv)
>  
>  	ub913_read(priv, UB913_REG_GENERAL_CFG, &v);
>  	v &= ~UB913_REG_GENERAL_CFG_PCLK_RISING;
> -	v |= priv->pclk_polarity ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
> +	v |= priv->pclk_polarity_rising ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
>  	ub913_write(priv, UB913_REG_GENERAL_CFG, v);
>  
>  	return 0;
> 

-- 
Regards,

Laurent Pinchart
