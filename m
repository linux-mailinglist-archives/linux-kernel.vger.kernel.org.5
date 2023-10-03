Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4857B60E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJCGkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:40:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16B93;
        Mon,  2 Oct 2023 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696315205; x=1727851205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6S5hwyLdskcw55p3k+ZsbwAYNEZoDORzEEmPSEtltK4=;
  b=OfkwmR3wDohJInalCLvmLefa0by+BTrs+lL61EcCfQ32mzqjhHTmqwSP
   keRXxpTEBg08bTme3ZzaVSNabx7JtC5dcknv5ePR0fW3OwptPqDv3gONS
   51akHcPZq5MYfAA0hhGqpgJbwLIzlocYV81+0feDAAJ1Vh3y1xTRTXIE7
   x8p72A+sZmrwoCXIExfDgr4cy+jJzJYRmcZyDWkLRfDuIK2Bem5i9GHJn
   Pxau/Mmh8UcMftdti1aXJKMcEFo8b4sddMilR5AEhMfriBF9uI3N7cisy
   gfbQoLeirUQkdhR1UCO0MXTWimBlmbQJ3KK54tzmnVV/rLtEAhjib4Ifu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4369836"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="4369836"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700584720"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="700584720"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 02 Oct 2023 23:39:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 09:39:59 +0300
Date:   Tue, 3 Oct 2023 09:39:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 08/14] USB: typec: tps6598x: Add interrupt support for
 TPS25750
Message-ID: <ZRu3P7Dlo7CiQfFK@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-9-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-9-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:28AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps25750 event registers structure is different than tps6598x's,
> tps25750 has 11 bytes of events which are read at once where
> tps6598x has two event registers of 8 bytes each which are read
> separately. Likewise MASK event registers. Also, not all events
> are supported in both devices.
> 
> - Create a new handler to accommodate tps25750 interrupt
> - Add device data to of_device_id
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

I'm sorry, but I just realised that this one also has to be in place
by the time TPS25750 is enabled in patch 4/14. Otherwise the series is
not bisectable.

I think you need to refactor the patch order a bit:

First come the patches that prepare everything that needs preparing -
introduction of struct tipd_data (without anything TPS25750 specific),
and so on.

Then you have patches for things that are specific to TPS25750 (small
stuff just merge together) if needed.

In the very last patches you finally enable TPS25750.

thanks,

> ---
> Changes in v9:
>   - Move of_device_id to its original place
>   - Move device data structs to the top of of_device_id
>   - Use device_get_match_data to get device data
> Changes in v8:
>   - Populate of_device_id with device data
>   - Change tps->cb to tps->data
>   - Assign matched data to tps data
> Changes in v7:
>   - Add driver name to commit subject
>   - Create tps25750 interrupt handler
> Changes in v6:
>   - Create tipd callbacks factory 
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 96 +++++++++++++++++++++++++++++++----
>  1 file changed, 87 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 32e42798688f..52dc1cc16bed 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -18,6 +18,7 @@
>  #include <linux/usb/role.h>
>  #include <linux/workqueue.h>
>  #include <linux/firmware.h>
> +#include <linux/of_device.h>
>  
>  #include "tps6598x.h"
>  #include "trace.h"
> @@ -101,6 +102,10 @@ static const char *const modes[] = {
>  /* Unrecognized commands will be replaced with "!CMD" */
>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>  
> +struct tipd_data {
> +	irq_handler_t irq_handler;
> +};
> +
>  struct tps6598x {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -118,9 +123,11 @@ struct tps6598x {
>  	enum power_supply_usb_type usb_type;
>  
>  	int wakeup;
> +	u32 status; /* status reg */
>  	u16 pwr_status;
>  	struct delayed_work	wq_poll;
> -	irq_handler_t irq_handler;
> +
> +	const struct tipd_data *data;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -545,6 +552,64 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	return IRQ_NONE;
>  }
>  
> +static bool tps6598x_has_role_changed(struct tps6598x *tps, u32 status)
> +{
> +	status ^= tps->status;
> +
> +	return status & (TPS_STATUS_PORTROLE | TPS_STATUS_DATAROLE);
> +}
> +
> +static irqreturn_t tps25750_interrupt(int irq, void *data)
> +{
> +	struct tps6598x *tps = data;
> +	u64 event[2] = { };
> +	u32 status;
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +
> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
> +	if (ret) {
> +		dev_err(tps->dev, "%s: failed to read events\n", __func__);
> +		goto err_unlock;
> +	}
> +
> +	if (!(event[0] | event[1]))
> +		goto err_unlock;
> +
> +	if (!tps6598x_read_status(tps, &status))
> +		goto err_clear_ints;
> +
> +	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +		if (!tps6598x_read_power_status(tps))
> +			goto err_clear_ints;
> +
> +	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +		if (!tps6598x_read_data_status(tps))
> +			goto err_clear_ints;
> +
> +	/*
> +	 * data/port roles could be updated independently after
> +	 * a plug event. Therefore, we need to check
> +	 * for pr/dr status change to set TypeC dr/pr accordingly.
> +	 */
> +	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
> +	    tps6598x_has_role_changed(tps, status))
> +		tps6598x_handle_plug_event(tps, status);
> +
> +	tps->status = status;
> +
> +err_clear_ints:
> +	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
> +
> +err_unlock:
> +	mutex_unlock(&tps->lock);
> +
> +	if (event[0] | event[1])
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> @@ -600,7 +665,7 @@ static void tps6598x_poll_work(struct work_struct *work)
>  	struct tps6598x *tps = container_of(to_delayed_work(work),
>  					    struct tps6598x, wq_poll);
>  
> -	tps->irq_handler(0, tps);
> +	tps->data->irq_handler(0, tps);
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>  }
> @@ -969,7 +1034,6 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> -	irq_handler_t irq_handler = tps6598x_interrupt;
>  	struct device_node *np = client->dev.of_node;
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
> @@ -1017,7 +1081,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  			APPLE_CD_REG_INT_PLUG_EVENT;
>  
> -		irq_handler = cd321x_interrupt;
>  	} else {
>  		/* Enable power status, data status and plug event interrupts */
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> @@ -1025,7 +1088,10 @@ static int tps6598x_probe(struct i2c_client *client)
>  			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> -	tps->irq_handler = irq_handler;
> +	tps->data = device_get_match_data(tps->dev);
> +	if (!tps->data)
> +		return -EINVAL;
> +
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
>  	if (ret < 0)
> @@ -1125,7 +1191,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -						irq_handler,
> +						tps->data->irq_handler,
>  						IRQF_SHARED | IRQF_ONESHOT,
>  						dev_name(&client->dev), tps);
>  	} else {
> @@ -1231,10 +1297,22 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
>  };
>  
> +static const struct tipd_data cd321x_data = {
> +	.irq_handler = cd321x_interrupt,
> +};
> +
> +static const struct tipd_data tps6598x_data = {
> +	.irq_handler = tps6598x_interrupt,
> +};
> +
> +static const struct tipd_data tps25750_data = {
> +	.irq_handler = tps25750_interrupt,
> +};
> +
>  static const struct of_device_id tps6598x_of_match[] = {
> -	{ .compatible = "ti,tps6598x", },
> -	{ .compatible = "apple,cd321x", },
> -	{ .compatible = "ti,tps25750", },
> +	{ .compatible = "ti,tps6598x", &tps6598x_data},
> +	{ .compatible = "apple,cd321x", &cd321x_data},
> +	{ .compatible = "ti,tps25750", &tps25750_data},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> -- 
> 2.34.1

-- 
heikki
