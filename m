Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2257A4A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjIRMrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbjIRMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:47:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07710E;
        Mon, 18 Sep 2023 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695041206; x=1726577206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJ1zp68bNG5G9J5GGwAmMBIOGWs61scPElasfTnNOpg=;
  b=UuwBQVtKPugcK0VmbAqilryGhqK6UfoMEj9IdKym871dZLiSoA4HIAXe
   cyg5KRX1Yd30VSikc/BtX1WSaEX0k+IhVoKC1DDNHRsrJGHBYSxD758kQ
   o1Mjgga2O8RvKYVueWmmkMCCMSZ+oSoRMUWHYtLTort63nHxB4xCnuJyN
   /p2Tq4M8718IdHL735gtXwf5mzG1epbzKP93vchMqVZzCx060uoPUQdxT
   pN9TF2ZR2BXuNTuy/7NwaNCKYrIijUMzhS4Nfs8QSTslmiyu3DfCF8fE/
   cHF7v365MSs0HwVtdja5oFvKiX0ruA6UwFROC4cG05QS+tTQZ0drO0J40
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383465402"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383465402"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739128262"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="739128262"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 18 Sep 2023 05:46:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 15:46:40 +0300
Date:   Mon, 18 Sep 2023 15:46:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 08/15] USB: typec: Add interrupt support for TPS25750
Message-ID: <ZQhGsA4PyiaUy7+7@kuha.fi.intel.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-9-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-9-alkuor@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 17, 2023 at 11:26:32AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> Update tps6598x interrupt handler to accommodate tps25750 interrupt

You have the "why" explained here, but please also explain what you
are doing - in this case it's not completely clear.

> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
>  drivers/usb/typec/tipd/core.c | 49 +++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index bd5436fd88fd..17b3bc480f97 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -120,6 +120,7 @@ struct tps6598x {
>  	enum power_supply_usb_type usb_type;
>  
>  	int wakeup;
> +	u32 status; /* status reg */
>  	u16 pwr_status;
>  	struct delayed_work	wq_poll;
>  	irq_handler_t irq_handler;
> @@ -539,50 +540,71 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
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
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event1 = 0;
> -	u64 event2 = 0;
> +	u64 event[2] = { };
>  	u32 status;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
>  
> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> +	if (tps->is_tps25750) {
> +		ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
> +	} else {
> +		ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event[0]);
> +		ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event[1]);
> +	}
> +
>  	if (ret) {
>  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>  		goto err_unlock;
>  	}
> -	trace_tps6598x_irq(event1, event2);
> +	trace_tps6598x_irq(event[0], event[1]);
>  
> -	if (!(event1 | event2))
> +	if (!(event[0] | event[1]))
>  		goto err_unlock;
>  
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
> -	/* Handle plug insert or removal */
> -	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
> +	/*
> +	 * data/port roles could be updated independently after
> +	 * a plug event. Therefore, we need to check
> +	 * for pr/dr status change to set TypeC dr/pr accordingly.
> +	 */
> +	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
> +		tps6598x_has_role_changed(tps, status))

Alignment.

>  		tps6598x_handle_plug_event(tps, status);
>  
> +	tps->status = status;
>  err_clear_ints:
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
> +	if (tps->is_tps25750) {
> +		tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
> +	} else {
> +		tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event[0]);
> +		tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event[1]);
> +	}
>  
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> -	if (event1 | event2)
> +	if (event[0] | event[1])
>  		return IRQ_HANDLED;
>  	return IRQ_NONE;
>  }
> @@ -1003,7 +1025,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  		irq_handler = cd321x_interrupt;
>  	} else {
> -

You need to fix patch 4 instead - that's where you add that empty
line.

>  		tps->is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
>  		/* Enable power status, data status and plug event interrupts */
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> -- 
> 2.34.1

-- 
heikki
