Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70E7B30C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjI2KnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2KnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:43:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B3199;
        Fri, 29 Sep 2023 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695984198; x=1727520198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIKfg0g+s2/pWaLCuwkR8KFdNJBrossarMDpMiFUMZA=;
  b=HXmM6uSvflE1iSSToOwM0fUHs/jlu9zUixh8umAMHVw+zxig37TBDB4y
   NlPjoW6KDMCUimJcc4WiM1G7CzwsMi+CAuXbFXgnCvV/7vayhPF+aJOFi
   p99wAwcgxOritAVgQiwpwAu1sBaKdmh1k6+HRAmkY0qCpg32DsgOHL7U/
   PFdh61g9PeLYHZycvwUHzIkCt19VIwvxxmjPx1Qa4Aumx0INlvUp/kr4o
   p0ByX8Cyqq4OmmV3YGcEbuuQvt7gxYLAtihQ85FjrclHef9Cd+ebqWbCq
   87c8VWVMKJhXrJw1S3rXvNPrcO4UB2TM11SkYa6sQzGtIyqK9VV1umnZp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="413177156"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="413177156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840242522"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="840242522"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 29 Sep 2023 03:43:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 29 Sep 2023 13:43:12 +0300
Date:   Fri, 29 Sep 2023 13:43:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v7 08/14] USB: typec: tps6598x: Add interrupt support for
 TPS25750
Message-ID: <ZRaqQLKNnMSv3dMk@kuha.fi.intel.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
 <20230927175348.18041-9-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927175348.18041-9-alkuor@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:53:42PM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps25750 event registers structure is different than tps6598x's,
> tps25750 has 11 bytes of events which are read at once where
> tps6598x has two event registers of 8 bytes each which are read
> separately. Likewise MASK event registers. Also, not all events
> are supported in both devices.
> 
> Create a new handler to accommodate tps25750 interrupt
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
> Changes in v7:
>   - Add driver name to commit subject
>   - Create tps25750 interrupt handler
> Changes in v6:
>   - Create tipd callbacks factory 
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 90 ++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 56ffffe225f2..40a76826a44e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -101,6 +101,10 @@ static const char *const modes[] = {
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
> @@ -118,9 +122,11 @@ struct tps6598x {
>  	enum power_supply_usb_type usb_type;
>  
>  	int wakeup;
> +	u32 status; /* status reg */
>  	u16 pwr_status;
>  	struct delayed_work	wq_poll;
> -	irq_handler_t irq_handler;
> +
> +	struct tipd_data cb;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -545,6 +551,64 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
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
> @@ -600,7 +664,7 @@ static void tps6598x_poll_work(struct work_struct *work)
>  	struct tps6598x *tps = container_of(to_delayed_work(work),
>  					    struct tps6598x, wq_poll);
>  
> -	tps->irq_handler(0, tps);
> +	tps->cb.irq_handler(0, tps);
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>  }
> @@ -967,9 +1031,20 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	return 0;
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
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> -	irq_handler_t irq_handler = tps6598x_interrupt;
>  	struct device_node *np = client->dev.of_node;
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
> @@ -1017,15 +1092,18 @@ static int tps6598x_probe(struct i2c_client *client)
>  			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  			APPLE_CD_REG_INT_PLUG_EVENT;
>  
> -		irq_handler = cd321x_interrupt;
> +		tps->cb = cd321x_data;
>  	} else {
> +		if (is_tps25750)
> +			tps->cb = tps25750_data;
> +		else
> +			tps->cb = tps6598x_data;

No. You assing those to the "data" member of your of_device_id:

static const struct of_device_id tps6598x_of_match[] = {
        { .compatible = "apple,cd321x", .data = &cd321_data },
        { .compatible = "ti,tps25750", .data = &tps25750_data },
        { .compatible = "ti,tps6598x", .data = &tps6598x_data },
        { }
};

thanks,

-- 
heikki
