Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE153761F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGYQpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjGYQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:45:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C562691;
        Tue, 25 Jul 2023 09:44:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8FBE24AD;
        Tue, 25 Jul 2023 18:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690303386;
        bh=bK23WmEsE/Sbfaa8F+kEYiMalIo5AtdcZiq/DtZbfN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftt3TmjBa1fmI+fOI52FUU75LN6KNTdzu2Gg5lxnmeO2qFA24WlajNh36YB79wT7Z
         7Q90SPItYYQEL2MObG+lP+4KUG5GLn92CuTJgeMbXTItNrZlQb5YxjbdIg/1y9qTDQ
         +ld9pia72C5eKFbO3b4SB57COsaUwFiQ9QHUMZqs=
Date:   Tue, 25 Jul 2023 19:44:12 +0300
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
Subject: Re: [PATCH v2 7/8] media: i2c: ds90ub953: Support non-sync mode
Message-ID: <20230725164412.GM31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-7-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-7-b91b1eca2ad3@ideasonboard.com>
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

On Thu, Jul 20, 2023 at 01:30:38PM +0300, Tomi Valkeinen wrote:
> Add support for FPD-Link non-sync mode with external clock. The only
> thing that needs to be added is the calculation for the clkout.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/i2c/ds90ub953.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index 3a19c6dedd2f..846542e6e20d 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -143,6 +143,7 @@ struct ub953_data {
>  
>  	struct i2c_client	*client;
>  	struct regmap		*regmap;
> +	struct clk		*clkin;
>  
>  	u32			num_data_lanes;
>  	bool			non_cont_clk;
> @@ -842,15 +843,21 @@ static int ub953_i2c_master_init(struct ub953_data *priv)
>  
>  static u64 ub953_get_fc_rate(struct ub953_data *priv)
>  {
> -	if (priv->mode != UB953_MODE_SYNC) {
> +	switch (priv->mode) {
> +	case UB953_MODE_SYNC:
> +		if (priv->hw_data->is_ub971)
> +			return priv->plat_data->bc_rate * 160ull;
> +		else
> +			return priv->plat_data->bc_rate / 2 * 160ull;
> +
> +	case UB953_MODE_NONSYNC_EXT:
> +		/* CLKIN_DIV = 1 always */
> +		return clk_get_rate(priv->clkin) * 80ull;
> +
> +	default:
>  		/* Not supported */
>  		return 0;
>  	}
> -
> -	if (priv->hw_data->is_ub971)
> -		return priv->plat_data->bc_rate * 160ull;
> -	else
> -		return priv->plat_data->bc_rate / 2 * 160ull;
>  }
>  
>  static unsigned long ub953_calc_clkout_ub953(struct ub953_data *priv,
> @@ -1188,9 +1195,15 @@ static int ub953_hw_init(struct ub953_data *priv)
>  	dev_dbg(dev, "mode from %s: %#x\n", mode_override ? "reg" : "strap",
>  		priv->mode);
>  
> -	if (priv->mode != UB953_MODE_SYNC)
> +	if (priv->mode != UB953_MODE_SYNC &&
> +	    priv->mode != UB953_MODE_NONSYNC_EXT)
>  		return dev_err_probe(dev, -ENODEV,
> -				     "Only synchronous mode supported\n");
> +				     "Unsupported mode selected: %d\n",

%u

> +				     priv->mode);
> +
> +	if (priv->mode == UB953_MODE_NONSYNC_EXT && !priv->clkin)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "clkin required for non-sync ext mode\n");
>  
>  	ret = ub953_read(priv, UB953_REG_REV_MASK_ID, &v);
>  	if (ret)
> @@ -1318,6 +1331,11 @@ static int ub953_probe(struct i2c_client *client)
>  		goto err_mutex_destroy;
>  	}
>  
> +	priv->clkin = devm_clk_get_optional(dev, "clkin");
> +	if (IS_ERR(priv->clkin))
> +		return dev_err_probe(dev, PTR_ERR(priv->clkin),
> +				     "failed to parse 'clkin'\n");

You need to goto err_mutex_destroy.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  	ret = ub953_parse_dt(priv);
>  	if (ret)
>  		goto err_mutex_destroy;
> 

-- 
Regards,

Laurent Pinchart
