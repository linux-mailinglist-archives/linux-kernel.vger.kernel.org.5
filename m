Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21AF7FD955
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjK2O0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjK2O0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:26:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA8AF;
        Wed, 29 Nov 2023 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701268008; x=1732804008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vU5nIcIA/G5AH3PqLyM/mmU21yIpCzIkpJ6WCyjOrE=;
  b=ecoJrFJgckEphCpTfLaGYTEdVvOIG1UhBo58f+6XVtFFYOGMyeyWvxBN
   Hv+3ACHxkvBsvGKq+a/vqwe8U/Lwh0Cc1F6w3SOg+uEGj9o6bsiQx9ap/
   lt2jG8ijfEbqOCOjI3IsvQkM71XeBm/Llq532VxtIZsDMWbkkODfPFjKv
   zNewLunw1d2F9YAfEqFodhmazgF3cnfEPeGyFkE6mg4aXbCgKFKmYdosI
   WL6s+ijb6540iX236ITZe8hamjU2KXAdYuNr/GtmrZ/4zvojvq/dT/+st
   g/Fm0dCJ1OhY8IVYCUy2nKREkf84ll4GHzfowTNIKBKkpQDqH7DzvtA62
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373353386"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373353386"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:26:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772696789"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="772696789"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 29 Nov 2023 06:26:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 29 Nov 2023 16:26:43 +0200
Date:   Wed, 29 Nov 2023 16:26:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, rogerq@kernel.org,
        christophe.jaillet@wanadoo.fr, a-govindraju@ti.com,
        trix@redhat.com, abdelalkuor@geotab.com
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to
 identify devices
Message-ID: <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
References: <20231123210021.463122-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123210021.463122-1-alex@shruggie.ro>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to keep you waiting.

On Thu, Nov 23, 2023 at 11:00:21PM +0200, Alexandru Ardelean wrote:
> Using the {of_}device_is_compatible function(s) is not too expensive.
> But since the driver already needs to match for the 'struct tipd_data'
> device parameters (via device_get_match_data()), we can add a simple 'type'
> field.
> 
> This adds a minor optimization in certain operations, where we the check
> for TPS25750 (or Apple CD321X) is a bit faster.
> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/usb/typec/tipd/core.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index fbd23de5c5cb..69d3e11bb30c 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -105,7 +105,14 @@ static const char *const modes[] = {
>  
>  struct tps6598x;
>  
> +enum tipd_type {
> +	TIPD_TYPE_TI_TPS6598X,
> +	TIPD_TYPE_APPLE_CD321X,
> +	TIPD_TYPE_TI_TPS25750X,
> +};
> +
>  struct tipd_data {
> +	enum tipd_type type;
>  	irq_handler_t irq_handler;
>  	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
>  	void (*trace_power_status)(u16 status);

Why not just match against the structures themselves?

        if (tps->data == &tps25750_data)
                ...

> @@ -1195,7 +1202,6 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> -	struct device_node *np = client->dev.of_node;
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
>  	u32 status;
> @@ -1211,11 +1217,19 @@ static int tps6598x_probe(struct i2c_client *client)
>  	mutex_init(&tps->lock);
>  	tps->dev = &client->dev;
>  
> +	if (dev_fwnode(tps->dev))
> +		tps->data = device_get_match_data(tps->dev);
> +	else
> +		tps->data = i2c_get_match_data(client);
> +
> +	if (!tps->data)
> +		return -EINVAL;
> +
>  	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
>  	if (IS_ERR(tps->regmap))
>  		return PTR_ERR(tps->regmap);
>  
> -	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
> +	is_tps25750 = (tps->data->type == TIPD_TYPE_TI_TPS25750X);
>  	if (!is_tps25750) {
>  		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
>  		if (ret < 0 || !vid)
> @@ -1229,7 +1243,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		tps->i2c_protocol = true;
>  
> -	if (np && of_device_is_compatible(np, "apple,cd321x")) {
> +	if (tps->data->type == TIPD_TYPE_APPLE_CD321X) {
>  		/* Switch CD321X chips to the correct system power state */
>  		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
>  		if (ret)
> @@ -1247,13 +1261,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> -	if (dev_fwnode(tps->dev))
> -		tps->data = device_get_match_data(tps->dev);
> -	else
> -		tps->data = i2c_get_match_data(client);
> -	if (!tps->data)
> -		return -EINVAL;
> -
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
>  	if (ret < 0)
> @@ -1366,7 +1373,7 @@ static void tps6598x_remove(struct i2c_client *client)
>  	usb_role_switch_put(tps->role_sw);
>  
>  	/* Reset PD controller to remove any applied patch */
> -	if (device_is_compatible(tps->dev, "ti,tps25750"))
> +	if (tps->data->type == TIPD_TYPE_TI_TPS25750X)
>  		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>  }
>  
> @@ -1396,7 +1403,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
> +	if (tps->data->type == TIPD_TYPE_TI_TPS25750X && ret == TPS_MODE_PTCH) {
>  		ret = tps25750_init(tps);
>  		if (ret)
>  			return ret;
> @@ -1419,6 +1426,7 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
>  };
>  
>  static const struct tipd_data cd321x_data = {
> +	.type = TIPD_TYPE_APPLE_CD321X,
>  	.irq_handler = cd321x_interrupt,
>  	.register_port = tps6598x_register_port,
>  	.trace_power_status = trace_tps6598x_power_status,
> @@ -1426,6 +1434,7 @@ static const struct tipd_data cd321x_data = {
>  };
>  
>  static const struct tipd_data tps6598x_data = {
> +	.type = TIPD_TYPE_TI_TPS6598X,
>  	.irq_handler = tps6598x_interrupt,
>  	.register_port = tps6598x_register_port,
>  	.trace_power_status = trace_tps6598x_power_status,
> @@ -1433,6 +1442,7 @@ static const struct tipd_data tps6598x_data = {
>  };
>  
>  static const struct tipd_data tps25750_data = {
> +	.type = TIPD_TYPE_TI_TPS25750X,
>  	.irq_handler = tps25750_interrupt,
>  	.register_port = tps25750_register_port,
>  	.trace_power_status = trace_tps25750_power_status,
> -- 
> 2.42.1

thanks,

-- 
heikki
