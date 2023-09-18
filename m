Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CCE7A4A59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbjIRM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbjIRM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:59:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBA10D;
        Mon, 18 Sep 2023 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695041900; x=1726577900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MjSCmVJgyfXuq8tj4KIK8MZa0UCrDHb4eV31N5ljfSc=;
  b=JWr8KXW4i8EpdbGmrxfRQym+AlmIq9wrStcidSZCGZmgNSvjziXc1i1p
   T2DM24ZibdF+IPV+BqUSFMggaOtyQPjNTv4zKgwJhlB35EHKopEZ5K6jy
   YFgQGGSJqfzoYjRV+av15lLDk8UWHqMMDE/X5tLsmcpLW5aF/hYAefn62
   cSE48DGNI1pRFMfKj+Z/3Y2QlyqcnLOvY9uhODhL1YR8lJqVD1u7m4Cuu
   OBqCEBTVGYLYJnka/h5+ZY1peCJGk1ef6kYO40HnTaUEY4zyDZAlCdrEh
   RrsTRmTMHORJcPblh737I+Qn4xy6J+cCenJ8dsKjlpkHDbBO+IOEW5psL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359897338"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359897338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889046131"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="889046131"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Sep 2023 05:57:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 15:58:15 +0300
Date:   Mon, 18 Sep 2023 15:58:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 10/15] USB: typec: Add port registration for tps25750
Message-ID: <ZQhJZ82nRCD797lA@kuha.fi.intel.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-11-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-11-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:26:34AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 doesn't have system configuration register to get dr/pr of the
> current applied binary configuration.
> 
> Get data role from the device node and power role from PD status register.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
>  drivers/usb/typec/tipd/core.c     | 61 ++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h | 10 +++++
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 8218d88a4a06..a97fda68cb54 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -39,6 +39,7 @@
>  #define TPS_REG_CTRL_CONF		0x29
>  #define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
> +#define TPS_REG_PD_STATUS		0x40
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
>  
> @@ -1028,6 +1029,60 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	return 0;
>  }
>  
> +static int
> +tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> +{
> +	struct typec_capability typec_cap = { };
> +	const char *data_role;
> +	u8 pd_status;
> +	int ret;
> +
> +	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
> +	if (ret)
> +		return ret;
> +
> +	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
> +	if (ret) {
> +		dev_err(tps->dev, "data-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_port_data_role(data_role);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
> +		return ret;
> +	}
> +
> +	typec_cap.data = ret;
> +	typec_cap.revision = USB_TYPEC_REV_1_3;
> +	typec_cap.pd_revision = 0x300;
> +	typec_cap.driver_data = tps;
> +	typec_cap.ops = &tps6598x_ops;
> +	typec_cap.fwnode = fwnode;
> +	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +
> +	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
> +	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
> +	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
> +		typec_cap.type = TYPEC_PORT_DRP;
> +		break;
> +	case TPS_PD_STATUS_PORT_TYPE_SINK:
> +		typec_cap.type = TYPEC_PORT_SNK;
> +		break;
> +	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
> +		typec_cap.type = TYPEC_PORT_SRC;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	tps->port = typec_register_port(tps->dev, &typec_cap);
> +	if (IS_ERR(tps->port))
> +		return PTR_ERR(tps->port);
> +
> +	return 0;
> +}
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	irq_handler_t irq_handler = tps6598x_interrupt;
> @@ -1124,7 +1179,11 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_role_put;
>  
> -	ret = tps6598x_register_port(tps, fwnode);
> +	if (np && of_device_is_compatible(np, "ti,tps25750"))

Why aren't you using is_tps25750 here?

> +		ret = tps25750_register_port(tps, fwnode);
> +	else
> +		ret = tps6598x_register_port(tps, fwnode);
> +
>  	if (ret)
>  		goto err_role_put;

thanks,

-- 
heikki
