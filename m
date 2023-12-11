Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8D80D4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbjLKSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbjLKSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:09:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF3393;
        Mon, 11 Dec 2023 10:09:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B358922;
        Mon, 11 Dec 2023 19:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702318128;
        bh=nSEgZ3BmAZuUqBLLw01yamX9L8j3gOmdBUMb6OLQrOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v9l0YYAemrZx3jrxGD1vAAOV2InFLLDa9fbxqZNlqFi38ZG3NMqELpaj0E8pl0KSW
         Xue47+p39mSjhq7jkBwla8gzeU9WH7IWwG/QZ4c9oKR6J/Rzgd22JuCxjeutx8qILi
         PxQGrCYkPBocbXdlsj/yP5X00O/NAuKepQtnts8Q=
Date:   Mon, 11 Dec 2023 20:09:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 04/19] media: i2c: ov4689: Remove i2c_client from ov4689
 struct
Message-ID: <20231211180939.GC27535@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-5-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211175023.1680247-5-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 11, 2023 at 08:50:07PM +0300, Mikhail Rudenko wrote:
> The 'client' field within the 'ov4689' structure is solely used to
> access its 'dev' member. This commit removes the 'client' field and
> directly stores a pointer to the 'struct device'.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 51a15810cb1d..8c120d7f7830 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -78,7 +78,7 @@ struct ov4689_mode {
>  };
>  
>  struct ov4689 {
> -	struct i2c_client *client;
> +	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *xvclk;
>  	struct gpio_desc *reset_gpio;
> @@ -409,13 +409,13 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  {
>  	struct ov4689 *ov4689 = to_ov4689(sd);
> -	struct i2c_client *client = ov4689->client;
> +	struct device *dev = ov4689->dev;
>  	int ret = 0;
>  
>  	mutex_lock(&ov4689->mutex);
>  
>  	if (on) {
> -		ret = pm_runtime_resume_and_get(&client->dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  		if (ret < 0)
>  			goto unlock_and_return;
>  
> @@ -424,26 +424,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  					  ov4689->cur_mode->num_regs,
>  					  NULL);
>  		if (ret) {
> -			pm_runtime_put(&client->dev);
> +			pm_runtime_put(dev);
>  			goto unlock_and_return;
>  		}
>  
>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>  		if (ret) {
> -			pm_runtime_put(&client->dev);
> +			pm_runtime_put(dev);
>  			goto unlock_and_return;
>  		}
>  
>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  				OV4689_MODE_STREAMING, NULL);
>  		if (ret) {
> -			pm_runtime_put(&client->dev);
> +			pm_runtime_put(dev);
>  			goto unlock_and_return;
>  		}
>  	} else {
>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  			  OV4689_MODE_SW_STANDBY, NULL);
> -		pm_runtime_put(&client->dev);
> +		pm_runtime_put(dev);
>  	}
>  
>  unlock_and_return:
> @@ -557,7 +557,6 @@ static const struct v4l2_subdev_ops ov4689_subdev_ops = {
>   */
>  static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
>  {
> -	const struct device *dev = &ov4689->client->dev;
>  	const struct ov4689_gain_range *range;
>  	unsigned int n;
>  
> @@ -568,7 +567,8 @@ static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
>  	}
>  
>  	if (n == ARRAY_SIZE(ov4689_gain_ranges)) {
> -		dev_warn_ratelimited(dev, "no mapping found for gain %d\n",
> +		dev_warn_ratelimited(ov4689->dev,
> +				     "no mapping found for gain %d\n",
>  				     logical_gain);
>  		return -EINVAL;
>  	}
> @@ -584,7 +584,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct ov4689 *ov4689 =
>  		container_of(ctrl->handler, struct ov4689, ctrl_handler);
> -	struct i2c_client *client = ov4689->client;
> +	struct device *dev = ov4689->dev;
>  	int sensor_gain;
>  	s64 max_expo;
>  	int ret;
> @@ -601,7 +601,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> -	if (!pm_runtime_get_if_in_use(&client->dev))
> +	if (!pm_runtime_get_if_in_use(dev))
>  		return 0;
>  
>  	switch (ctrl->id) {
> @@ -629,13 +629,13 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>  		break;
>  	default:
> -		dev_warn(&client->dev, "%s Unhandled id:0x%x, val:0x%x\n",
> +		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>  			 __func__, ctrl->id, ctrl->val);
>  		ret = -EINVAL;
>  		break;
>  	}
>  
> -	pm_runtime_put(&client->dev);
> +	pm_runtime_put(dev);
>  
>  	return ret;
>  }
> @@ -700,8 +700,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  
>  	if (handler->error) {
>  		ret = handler->error;
> -		dev_err(&ov4689->client->dev, "Failed to init controls(%d)\n",
> -			ret);
> +		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
>  		goto err_free_handler;
>  	}
>  
> @@ -727,7 +726,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  static int ov4689_check_sensor_id(struct ov4689 *ov4689,
>  				  struct i2c_client *client)
>  {
> -	struct device *dev = &ov4689->client->dev;
> +	struct device *dev = ov4689->dev;
>  	u64 id = 0;
>  	int ret;
>  
> @@ -755,7 +754,7 @@ static int ov4689_configure_regulators(struct ov4689 *ov4689)
>  	for (i = 0; i < ARRAY_SIZE(ov4689_supply_names); i++)
>  		ov4689->supplies[i].supply = ov4689_supply_names[i];
>  
> -	return devm_regulator_bulk_get(&ov4689->client->dev,
> +	return devm_regulator_bulk_get(ov4689->dev,
>  				       ARRAY_SIZE(ov4689_supply_names),
>  				       ov4689->supplies);
>  }
> @@ -824,7 +823,8 @@ static int ov4689_probe(struct i2c_client *client)
>  	if (!ov4689)
>  		return -ENOMEM;
>  
> -	ov4689->client = client;
> +	ov4689->dev = dev;
> +
>  	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
>  
>  	ov4689->xvclk = devm_clk_get_optional(dev, NULL);

-- 
Regards,

Laurent Pinchart
