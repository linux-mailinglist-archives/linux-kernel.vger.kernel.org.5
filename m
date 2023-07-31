Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89ED7699E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjGaOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:43:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90411B;
        Mon, 31 Jul 2023 07:43:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E72F5A4;
        Mon, 31 Jul 2023 16:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690814568;
        bh=MLNoO+/MO9+/q9PVWJ6qVaFWadOGMp1aPfXNwUfPx+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8UNMm//9ospU3KOme+OeI8hCw2lNBlKSZoVvoE2V74GngICmn2c58wgz2KAnCrQw
         dLhM7qvzjGmVcSUUMP0A3txJFb146tvfral19ho2ZPxBoAplkoWxkn5TgXw4OB7E+/
         JIGPXrEpdBfDYC/e40DMckLkBQQeBj/yh/Nkq3yg=
Date:   Mon, 31 Jul 2023 17:43:56 +0300
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
Subject: Re: [PATCH v3 1/9] media: i2c: ds90ub9x3: Fix sub-device matching
Message-ID: <20230731144356.GA30939@pendragon.ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
 <20230731-fpdlink-additions-v3-1-8acfc49c215a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731-fpdlink-additions-v3-1-8acfc49c215a@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Mon, Jul 31, 2023 at 04:24:35PM +0300, Tomi Valkeinen wrote:
> 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode

s/^/Commit /

> matching") recently changed how async sub-device matching works. This
> breaks the UB9x3 drivers, as they set the subdev.fwnode to an endpoint.
> Afaiu, the fix is simply to not set subdev.fwnode at all.
> 
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>

Sakari, was the v4l2-async series meant to break these drivers ? I
understand the two series got merged for the same kernel version, is
this a merge conflict, or is there an issue in the v4l2-async rework ?

> ---
>  drivers/media/i2c/ds90ub913.c | 14 +-------------
>  drivers/media/i2c/ds90ub953.c | 13 +------------
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
> index 80d9cf6dd945..5410ccb54057 100644
> --- a/drivers/media/i2c/ds90ub913.c
> +++ b/drivers/media/i2c/ds90ub913.c
> @@ -749,19 +749,9 @@ static int ub913_subdev_init(struct ub913_data *priv)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to init pads\n");
>  
> -	priv->sd.fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> -							  UB913_PAD_SOURCE, 0,
> -							  0);
> -
> -	if (!priv->sd.fwnode) {
> -		ret = -ENODEV;
> -		dev_err_probe(dev, ret, "Missing TX endpoint\n");
> -		goto err_entity_cleanup;
> -	}
> -
>  	ret = v4l2_subdev_init_finalize(&priv->sd);
>  	if (ret)
> -		goto err_fwnode_put;
> +		goto err_entity_cleanup;
>  
>  	ret = ub913_v4l2_notifier_register(priv);
>  	if (ret) {
> @@ -782,8 +772,6 @@ static int ub913_subdev_init(struct ub913_data *priv)
>  	ub913_v4l2_nf_unregister(priv);
>  err_subdev_cleanup:
>  	v4l2_subdev_cleanup(&priv->sd);
> -err_fwnode_put:
> -	fwnode_handle_put(priv->sd.fwnode);
>  err_entity_cleanup:
>  	media_entity_cleanup(&priv->sd.entity);
>  
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index cadf75eb0773..20b9cf893f74 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -1221,18 +1221,9 @@ static int ub953_subdev_init(struct ub953_data *priv)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to init pads\n");
>  
> -	priv->sd.fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> -							  UB953_PAD_SOURCE, 0,
> -							  0);
> -	if (!priv->sd.fwnode) {
> -		ret = -ENODEV;
> -		dev_err_probe(dev, ret, "Missing TX endpoint\n");
> -		goto err_entity_cleanup;
> -	}
> -
>  	ret = v4l2_subdev_init_finalize(&priv->sd);
>  	if (ret)
> -		goto err_fwnode_put;
> +		goto err_entity_cleanup;
>  
>  	ret = ub953_v4l2_notifier_register(priv);
>  	if (ret) {
> @@ -1253,8 +1244,6 @@ static int ub953_subdev_init(struct ub953_data *priv)
>  	ub953_v4l2_notifier_unregister(priv);
>  err_free_state:
>  	v4l2_subdev_cleanup(&priv->sd);
> -err_fwnode_put:
> -	fwnode_handle_put(priv->sd.fwnode);
>  err_entity_cleanup:
>  	media_entity_cleanup(&priv->sd.entity);
>  
> 

-- 
Regards,

Laurent Pinchart
