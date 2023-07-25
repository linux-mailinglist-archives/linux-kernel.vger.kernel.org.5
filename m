Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10B761E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGYQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGYQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:36:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27810CC;
        Tue, 25 Jul 2023 09:36:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 052384AD;
        Tue, 25 Jul 2023 18:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690302943;
        bh=+R48A+5seDyRpwPko8HmAprRgULuPwTHhToPh14FLMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TatPvRQ4zCi+d+TLQ0JN6RejRXqWEhsiluClHvvv2O4fReYrOA95HLEe8QvQgEOJr
         fTzqHCNW7hN57Zdl2AQQI+j5gx9xrVNFsaqFrGa8Iu9QcRZn0BUIKeI8fia33FSHKj
         i/K8JAo3QZDYnCJySWjlbBc4SAIJErvFqcQXtXoU=
Date:   Tue, 25 Jul 2023 19:36:49 +0300
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
Subject: Re: [PATCH v2 4/8] media: i2c: ds90ub953: Handle
 V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
Message-ID: <20230725163649.GK31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-4-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-4-b91b1eca2ad3@ideasonboard.com>
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

On Thu, Jul 20, 2023 at 01:30:35PM +0300, Tomi Valkeinen wrote:
> Handle V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK flag to configure the CSI-2 RX
> continuous/non-continuous clock register.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/i2c/ds90ub953.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index ad964bd6c7eb..ad479923d2b4 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -138,6 +138,7 @@ struct ub953_data {
>  	struct regmap		*regmap;
>  
>  	u32			num_data_lanes;
> +	bool			non_cont_clk;

Maybe non_continous_clk for consistency with 1/8 ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  	struct gpio_chip	gpio_chip;
>  
> @@ -1139,6 +1140,9 @@ static int ub953_parse_dt(struct ub953_data *priv)
>  
>  	priv->num_data_lanes = nlanes;
>  
> +	priv->non_cont_clk = vep.bus.mipi_csi2.flags &
> +			     V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
> +
>  	return 0;
>  }
>  
> @@ -1201,7 +1205,7 @@ static int ub953_hw_init(struct ub953_data *priv)
>  		return dev_err_probe(dev, ret, "i2c init failed\n");
>  
>  	ub953_write(priv, UB953_REG_GENERAL_CFG,
> -		    UB953_REG_GENERAL_CFG_CONT_CLK |
> +		    (priv->non_cont_clk ? 0 : UB953_REG_GENERAL_CFG_CONT_CLK) |
>  		    ((priv->num_data_lanes - 1) << UB953_REG_GENERAL_CFG_CSI_LANE_SEL_SHIFT) |
>  		    UB953_REG_GENERAL_CFG_CRC_TX_GEN_ENABLE);
>  
> 

-- 
Regards,

Laurent Pinchart
