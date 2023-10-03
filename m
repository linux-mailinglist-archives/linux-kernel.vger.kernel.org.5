Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7D7B60FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjJCGuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjJCGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:50:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07429B8;
        Mon,  2 Oct 2023 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696315827; x=1727851827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFplwQDIBjGQz2+jk1sYRlTujAtpCDfoBeIKi/VEBOw=;
  b=O0U8Ffq+7U0QwpHZ/DgpI9OByuXI/PvqrBX/0erAsFl9Lg9tZHNvobH6
   9mzVAu/Vj1IlH6YNrfMYSNT6u0vAGAa9v3MdAL6v9tVMSxTWOiQaThtLX
   FtSX1YxbKMwsugUx+7fT294tDiY0CFIYTBToT1ODAV9JGNPGH+cB15Cuj
   3hHijDdhKgyUULglb00gDe5qhiDTj+mawktOOAuuZ1TbCRgF34ZuWXCFY
   7TywanLUc9ZGh3JNT4gPDld/02B9rfUwh7yxKrSYRXJ8uN5oVQsRZCqGL
   Iu4Tzh46KwoxCfu2yJw6E3zRydl6olhzhN2LbvNuDSC7CucXL2rbS+eh0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367857400"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367857400"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821131128"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="821131128"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga004.fm.intel.com with SMTP; 02 Oct 2023 23:50:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 09:50:21 +0300
Date:   Tue, 3 Oct 2023 09:50:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 10/14] USB: typec: tps6598x: Add port registration for
 tps25750
Message-ID: <ZRu5rURFLbZYhDz6@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-11-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-11-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:30AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 doesn't have system configuration register to get dr/pr of the
> current applied binary configuration.
> 
> Get data role from the device node and power role from PD status register.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

This also has to be done at the same time you enable TPS25750.

> ---
> Changes in v9:
>   - Move device data structs to the top of of_device_id
> Changes in v8:
>   - Change tps->cb to tps->data
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - Add port registration to tipd data factory
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c     | 68 ++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h | 10 +++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 0195eabd96bf..ae08c5306707 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -40,6 +40,7 @@
>  #define TPS_REG_CTRL_CONF		0x29
>  #define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
> +#define TPS_REG_PD_STATUS		0x40
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
>  
> @@ -102,8 +103,11 @@ static const char *const modes[] = {
>  /* Unrecognized commands will be replaced with "!CMD" */
>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>  
> +struct tps6598x;
> +
>  struct tipd_data {
>  	irq_handler_t irq_handler;
> +	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
>  };
>  
>  struct tps6598x {
> @@ -208,6 +212,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
>  	return tps6598x_block_read(tps, reg, val, sizeof(u64));
>  }
>  
> +static inline int tps6598x_write8(struct tps6598x *tps, u8 reg, u8 val)
> +{
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u8));
> +}
> +
>  static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
>  {
>  	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
> @@ -1084,6 +1093,60 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
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
>  	struct device_node *np = client->dev.of_node;
> @@ -1183,7 +1246,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_role_put;
>  
> -	ret = tps6598x_register_port(tps, fwnode);
> +	ret = tps->data->register_port(tps, fwnode);
>  	if (ret)
>  		goto err_role_put;
>  
> @@ -1308,14 +1371,17 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
>  
>  static const struct tipd_data cd321x_data = {
>  	.irq_handler = cd321x_interrupt,
> +	.register_port = tps6598x_register_port,
>  };
>  
>  static const struct tipd_data tps6598x_data = {
>  	.irq_handler = tps6598x_interrupt,
> +	.register_port = tps6598x_register_port,
>  };
>  
>  static const struct tipd_data tps25750_data = {
>  	.irq_handler = tps25750_interrupt,
> +	.register_port = tps25750_register_port,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index c000170f4547..3a9a43394134 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -203,4 +203,14 @@
>  #define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
>  #define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
>  
> +/* PD STATUS REG */
> +#define TPS_REG_PD_STATUS_PORT_TYPE_MASK	GENMASK(5, 4)
> +#define TPS_PD_STATUS_PORT_TYPE(x) \
> +	TPS_FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, x)
> +
> +#define TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE	0
> +#define TPS_PD_STATUS_PORT_TYPE_SINK		1
> +#define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
> +#define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
> +
>  #endif /* __TPS6598X_H__ */
> -- 
> 2.34.1

-- 
heikki
