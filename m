Return-Path: <linux-kernel+bounces-16911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47958245F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427892858E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CE24B2B;
	Thu,  4 Jan 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmOLFUPb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBE24209;
	Thu,  4 Jan 2024 16:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42676C433C8;
	Thu,  4 Jan 2024 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704384883;
	bh=RgM5h+3+nktRIk1RXfaB2IDOC076Sv+3EjtzUZZCrdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AmOLFUPb1gsPBpngLy7ADxYtYI1gxncmOxUvblZRjRoRDIZd9Rh7UnKnKj5cipM5K
	 5/l6xE+JWN8HJSMicYh0Vp8NscKQTIQqdK0IHvrW4Rtc9cToj87Wrr/OVuJngMMLCO
	 J22TjyGNyPcWtvJy5IcDEzB9JGDHmTSNfdsKzl8XT/kkOTJ0vQH8Eqz0j2faGXUknb
	 wqe7gtoq7UD176JF+vruX3MkAnoXBYpz1CSBoNKOwrVNIftEU29rwr0FdnnMEfEq74
	 v6wX37ZUQcipIy4JaTOY64lWRpmj4mmdjIWEgdr9REYY7qxfNWfteHCiKImgIqIXhs
	 4kcFO9jDRvOxg==
Message-ID: <2a001d00-32c8-4ec3-9635-08473df6a069@kernel.org>
Date: Thu, 4 Jan 2024 18:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] usb: typec: tipd: add init and reset functions to
 tipd_data
Content-Language: en-US
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 18:29, Javier Carrasco wrote:
> The current implementation includes a number of special cases for the
> tps25750. Nevertheless, init and reset functions can be generalized by
> adding function pointers to the tipd_data structure in order to offer
> that functionality to other parts without additional conditional
> clauses.
> 
> Some functionality like the cold reset request (GAID) is shared by the
> tps25750 and the tps6598x, so they can use the same reset function.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 45 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 806ef68273ca..f0c4cd571a37 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -115,6 +115,8 @@ struct tipd_data {
>  	void (*trace_power_status)(u16 status);
>  	void (*trace_status)(u32 status);
>  	int (*apply_patch)(struct tps6598x *tps);
> +	int (*init)(struct tps6598x *tps);
> +	int (*reset)(struct tps6598x *tps);
>  };
>  
>  struct tps6598x {
> @@ -1106,6 +1108,11 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	return 0;
>  };
>  
> +static int cd321x_init(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
>  static int tps25750_init(struct tps6598x *tps)
>  {
>  	int ret;
> @@ -1124,6 +1131,21 @@ static int tps25750_init(struct tps6598x *tps)
>  	return 0;
>  }
>  
> +static int tps6598x_init(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
> +static int cd321x_reset(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
> +static int tps6598x_reset(struct tps6598x *tps)
> +{
> +	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> +}
> +
>  static int
>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  {
> @@ -1187,7 +1209,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  	u32 vid;
>  	int ret;
>  	u64 mask1;
> -	bool is_tps25750;
>  
>  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -1207,8 +1228,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (IS_ERR(tps->regmap))
>  		return PTR_ERR(tps->regmap);
>  
> -	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
> -	if (!is_tps25750) {
> +	if (!device_is_compatible(tps->dev, "ti,tps25750")) {
>  		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
>  		if (ret < 0 || !vid)
>  			return -ENODEV;
> @@ -1251,8 +1271,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (is_tps25750 && ret == TPS_MODE_PTCH) {
> -		ret = tps25750_init(tps);
> +	if (ret == TPS_MODE_PTCH) {
> +		ret = tps->data->init(tps);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1340,8 +1360,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
>  err_reset_controller:
>  	/* Reset PD controller to remove any applied patch */
> -	if (is_tps25750)
> -		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> +	tps->data->reset(tps);
> +
>  	return ret;
>  }
>  
> @@ -1358,8 +1378,7 @@ static void tps6598x_remove(struct i2c_client *client)
>  	usb_role_switch_put(tps->role_sw);
>  
>  	/* Reset PD controller to remove any applied patch */
> -	if (device_is_compatible(tps->dev, "ti,tps25750"))
> -		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> +	tps->data->reset(tps);
>  
>  	if (tps->reset)
>  		gpiod_set_value_cansleep(tps->reset, 1);
> @@ -1393,7 +1412,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
> +	if (ret == TPS_MODE_PTCH) {

Won't this function will be invoked for all variants?
If so, why are we calling a tsp25750 specific function here?

>  		ret = tps25750_init(tps);
>  		if (ret)
>  			return ret;
> @@ -1423,6 +1442,8 @@ static const struct tipd_data cd321x_data = {
>  	.register_port = tps6598x_register_port,
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
> +	.init = cd321x_init,
> +	.reset = cd321x_reset,
>  };
>  
>  static const struct tipd_data tps6598x_data = {
> @@ -1430,6 +1451,8 @@ static const struct tipd_data tps6598x_data = {
>  	.register_port = tps6598x_register_port,
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
> +	.init = tps6598x_init,
> +	.reset = tps6598x_reset,
>  };
>  
>  static const struct tipd_data tps25750_data = {
> @@ -1438,6 +1461,8 @@ static const struct tipd_data tps25750_data = {
>  	.trace_power_status = trace_tps25750_power_status,
>  	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
> +	.init = tps25750_init,
> +	.reset = tps6598x_reset,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> 

-- 
cheers,
-roger

