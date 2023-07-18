Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E9757E12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjGRNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGRNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2397
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A8E8615A2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789DC433C8;
        Tue, 18 Jul 2023 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689687982;
        bh=LP5XtaQv54EoMmYJXFDRE3eQCb9mOnuAHwC9GJYmQ8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gc0nWe2ZKrwVHCHTnaeG80BT0dhgnN1ZyGym6eVWXpu++6a82HOZnl2nRKlk/fKKr
         vcnVBi0Tqw9DVp4mKq3rlngSVIObJ36m+tz8O+xgybCpozlqItqXXuU2jtDxmtww3O
         rTZxDjd/523k8/9Qpwb7hyhdW1nRQkF28bYpYLtc=
Date:   Tue, 18 Jul 2023 15:46:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, git@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
Subject: Re: [PATCH] cdx: add support for bus mastering
Message-ID: <2023071817-floss-visibly-396a@gregkh>
References: <20230718100651.18317-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718100651.18317-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:36:51PM +0530, Nipun Gupta wrote:
> Introduce cdx_set_master() and cdx_clear_master() APIs
> to support enable and disable of bus mastering. Drivers
> need to use these APIs to enable/disable DMAs from the
> CDX devices.

You do have a full 72 columns, why not use that?

> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---
>  drivers/cdx/cdx.c                       | 32 ++++++++++++++
>  drivers/cdx/controller/cdx_controller.c |  4 ++
>  drivers/cdx/controller/mcdi_functions.c | 57 +++++++++++++++++++++++++
>  drivers/cdx/controller/mcdi_functions.h | 13 ++++++
>  include/linux/cdx/cdx_bus.h             | 16 +++++++
>  5 files changed, 122 insertions(+)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..efb24672b7d9 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -182,6 +182,38 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
>  	return NULL;
>  }
>  
> +int cdx_set_master(struct cdx_device *cdx_dev)
> +{
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret;
> +
> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
> +	dev_config.bme = true;

What is "bme"?

And are you sure that the config can be on the stack?

> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +				      cdx_dev->dev_num, &dev_config);

Will dev_configure always be there?

> +	if (ret)
> +		dev_err(&cdx_dev->dev, "device master enable failed\n");

Why error out here, shouldn't the call have printed something if it
wanted to?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_set_master);
> +
> +void cdx_clear_master(struct cdx_device *cdx_dev)
> +{
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret;
> +
> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
> +	dev_config.bme = false;
> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +				      cdx_dev->dev_num, &dev_config);
> +	if (ret)
> +		dev_err(&cdx_dev->dev, "device master disable failed\n");

Same question as above.

> +}
> +EXPORT_SYMBOL_GPL(cdx_clear_master);
> +
>  /**
>   * cdx_bus_match - device to driver matching callback
>   * @dev: the cdx device to match against
> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
> index dc52f95f8978..ba670f0427d3 100644
> --- a/drivers/cdx/controller/cdx_controller.c
> +++ b/drivers/cdx/controller/cdx_controller.c
> @@ -55,6 +55,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
>  	case CDX_DEV_RESET_CONF:
>  		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
>  		break;
> +	case CDX_DEV_BUS_MASTER_CONF:
> +		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
> +						 dev_config->bme);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
> index 0158f26533dd..c4c00f376006 100644
> --- a/drivers/cdx/controller/mcdi_functions.c
> +++ b/drivers/cdx/controller/mcdi_functions.c
> @@ -137,3 +137,60 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
>  
>  	return ret;
>  }
> +
> +static int cdx_mcdi_ctrl_flag_get(struct cdx_mcdi *cdx, u8 bus_num,
> +				  u8 dev_num, u32 *flags)
> +{
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN);
> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN);

How big are these buffers?

> +	size_t outlen;
> +	int ret;
> +
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_BUS, bus_num);
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_DEVICE, dev_num);
> +	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_GET, inbuf,
> +			   sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
> +	if (ret)
> +		return ret;
> +
> +	if (outlen != MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN)
> +		return -EIO;
> +
> +	*flags = MCDI_DWORD(outbuf, CDX_DEVICE_CONTROL_GET_OUT_FLAGS);
> +
> +	return 0;
> +}
> +
> +static int cdx_mcdi_ctrl_flag_set(struct cdx_mcdi *cdx, u8 bus_num,
> +				  u8 dev_num, bool enable, int lbn)
> +{
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN);
> +	int ret, en;
> +	u32 flags;
> +
> +	/*
> +	 * Get flags and then set/reset BUS_MASTER_BIT according to
> +	 * the input params.
> +	 */
> +	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
> +	if (ret)
> +		return ret;
> +
> +	en = enable ? 1 : 0;

if/then/else?


> +	flags = (flags & (u32)(~(BIT(lbn)))) | (en << lbn);
> +
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_BUS, bus_num);
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_DEVICE, dev_num);
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_FLAGS, flags);
> +	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_SET, inbuf,
> +			   sizeof(inbuf), NULL, 0, NULL);
> +
> +	return ret;
> +}
> +
> +int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
> +			       u8 dev_num, bool enable)
> +{
> +	return cdx_mcdi_ctrl_flag_set(cdx, bus_num, dev_num, enable,
> +			MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_LBN);
> +}
> diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
> index 7440ace5539a..a448d6581eb4 100644
> --- a/drivers/cdx/controller/mcdi_functions.h
> +++ b/drivers/cdx/controller/mcdi_functions.h
> @@ -58,4 +58,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>  int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
>  			  u8 bus_num, u8 dev_num);
>  
> +/**
> + * cdx_mcdi_bus_master_enable - Set/Reset bus mastering for cdx device
> + *				represented by bus_num:dev_num
> + * @cdx: pointer to MCDI interface.
> + * @bus_num: Bus number.
> + * @dev_num: Device number.
> + * @enable: Enable bus mastering if set, disable otherwise.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
> +			       u8 dev_num, bool enable);
> +
>  #endif /* CDX_MCDI_FUNCTIONS_H */
> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index bead71b7bc73..acb4e40bd20e 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -21,11 +21,13 @@
>  struct cdx_controller;
>  
>  enum {
> +	CDX_DEV_BUS_MASTER_CONF,
>  	CDX_DEV_RESET_CONF,
>  };
>  
>  struct cdx_device_config {
>  	u8 type;
> +	bool bme;

What does "bme" mean?

thanks,

greg k-h
