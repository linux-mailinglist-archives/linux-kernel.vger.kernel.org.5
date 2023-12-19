Return-Path: <linux-kernel+bounces-5100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA71818691
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3A1C23C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEC15AED;
	Tue, 19 Dec 2023 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOZmthOv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAE1B26C;
	Tue, 19 Dec 2023 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702986390; x=1734522390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WEzL+7IBWT3CuJXkkH+2HS8kUtbdQLdbSW9v5d27kbE=;
  b=VOZmthOviHQdPRo0VD5ak1Ee6C9kxNqlINuF+aRZJgMzmTfkayY6vS+1
   kOod5VtsW7GrLJoAog+HUiJ/E8znVa+SNXda5xEMCRt5SK1KCqDaNBhkY
   CZkBwtlhIBatA+1Z9Z3aXM7T0bgqryRtrMNpWhazUTKGKJJ4aN2ksFiO5
   BL9VoPNJw9JiIHiA2jYDipQPCtL2I8VBkw5ruUnzqRUFpkSRbGC5TKWAS
   GdoOVl8+/2BQNNYtncv0iFKGxLhvFs0acxuBl5IBBotzmV/gRvw0o62Lv
   DipjlYA+LU/oAc99UfiNrZHLpxNf4vL5pK4zjAmzsslFYVTbjwbdDwjcQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459988450"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="459988450"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894262777"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="894262777"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 19 Dec 2023 03:46:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 13:46:26 +0200
Date: Tue, 19 Dec 2023 13:46:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: tipd: add init and reset functions to
 tipd_data
Message-ID: <ZYGCkspfQITU6r4R@kuha.fi.intel.com>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>

On Thu, Dec 14, 2023 at 05:29:09PM +0100, Javier Carrasco wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
> -- 
> 2.39.2

-- 
heikki

