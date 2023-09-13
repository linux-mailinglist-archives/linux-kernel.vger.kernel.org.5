Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580779F42B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIMV5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF25D1739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694642216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPQRbvLOZmGl85JZ1tM2zj4aMkpemVWqDsmEeF3LLZk=;
        b=c+CfopCCQOhOTgaA2Utd7ViVEX36bWlyq2aAcZUniRxeBQX2dh4u1QHDcO4Rz+xYsDlgtI
        vE2PXK3V/o3bA1vMdjIu8Q4AeIwr1E2AbRrlEgIKCIMYv5JKR8mP2JPVGMCE2awrHnfX/k
        yVfAM5I1wRA7DKk1AXH0DUy+4yhm22A=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-46PbJ-lXNrej_4DD78cyTw-1; Wed, 13 Sep 2023 17:56:55 -0400
X-MC-Unique: 46PbJ-lXNrej_4DD78cyTw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9cf208fb5so339256a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642213; x=1695247013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPQRbvLOZmGl85JZ1tM2zj4aMkpemVWqDsmEeF3LLZk=;
        b=bbJRQt2ckY8E/lKsbImgR/r/MfhC9lVaKVFscJBMHtBPpEzwySlLNHK8LIlxZrqfeq
         zgwzAj9+/NKmplOOGctD+WvhQmLj3q3N9Rcc828GLss33wgBLalQ08KDpIZXKE4LKO94
         ThhYiDs6mz0tM2hCW+d+UEHugjca86FjCnoJkVai6dB8l7XgYeo4qq3K8esYCk+kxPmL
         C+9xZxshrL6aL9JpXOTOvZ8xHhWyJBjse51N8TC3dBQDasczajyKVsD7n0QtH/vT4XN8
         7pVUA7H94qvT2eNoZtdEd4im0aYWJr8AbP95YZIxqeSqmVMQ2YnGalQ+K952M4ejudNW
         hwQw==
X-Gm-Message-State: AOJu0YyD0bcKY8uli1QVK6jwMXpTTAPJBiYyEsw/zdi3jofi+vMYQImv
        90AxnVgRhHOEjAUWxeP8Q8JWUF7mjxargZUNrh5XycHXxkQ5GIznBA88UpZD1RwBY5glOis6/Bk
        OsCfPpMGD4UesrVjMfmeoTYc9lSDEUz4m
X-Received: by 2002:a9d:6391:0:b0:6b9:b67e:ea8a with SMTP id w17-20020a9d6391000000b006b9b67eea8amr4385917otk.14.1694642213583;
        Wed, 13 Sep 2023 14:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmcyWv/N/waTDE8Zv0LtdG4EEVa4CaXjYSSgs7RbHPl2zj71vAj/xyBHNLJ1+5+YogC8ylVA==
X-Received: by 2002:a9d:6391:0:b0:6b9:b67e:ea8a with SMTP id w17-20020a9d6391000000b006b9b67eea8amr4385901otk.14.1694642213342;
        Wed, 13 Sep 2023 14:56:53 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id ei1-20020a05663829a100b0042b5423f021sm31168jab.54.2023.09.13.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:56:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:56:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>
Subject: Re: [PATCH v7 1/3] cdx: add support for bus mastering
Message-ID: <20230913155651.4cae808c.alex.williamson@redhat.com>
In-Reply-To: <20230825131716.28610-1-nipun.gupta@amd.com>
References: <20230825131716.28610-1-nipun.gupta@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 18:47:14 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Introduce cdx_set_master() and cdx_clear_master() APIs to support
> enable and disable of bus mastering. Drivers need to use these APIs to
> enable/disable DMAs from the CDX devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---
> 
> Changes v6->v7:
> - None
> 
> Changes v5->v6:
> - change cdx_clear_master() to int return type
> 
> Changes v4->v5:
> - No change in this patch, patch 2/3 and patch 3/3 are updated
> 
> Changes v3->v4:
> - Added user of the Bus master enable and disable APIs in patch 2/2.
>   There is no change in this patch.
> 
> Changes v2->v3:
> - Changed return value from EOPNOTSUPP to -EOPNOTSUPP in
>   cdx_set_master()
> 
> Changes v1->v2:
> - Replace bme with bus_master_enable
> - Added check for dev_configure API callback
> - remove un-necessary error prints
> - changed conditional to if-else
> - updated commit message to use 72 columns
> 
>  drivers/cdx/cdx.c                       | 32 ++++++++++++++
>  drivers/cdx/controller/cdx_controller.c |  4 ++
>  drivers/cdx/controller/mcdi_functions.c | 58 +++++++++++++++++++++++++
>  drivers/cdx/controller/mcdi_functions.h | 13 ++++++
>  include/linux/cdx/cdx_bus.h             | 18 ++++++++
>  5 files changed, 125 insertions(+)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..9efb7584f952 100644
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
> +	int ret = -EOPNOTSUPP;
> +
> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
> +	dev_config.bus_master_enable = true;
> +	if (cdx->ops->dev_configure)
> +		ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +					      cdx_dev->dev_num, &dev_config);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_set_master);
> +
> +int cdx_clear_master(struct cdx_device *cdx_dev)
> +{
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret = -EOPNOTSUPP;
> +
> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
> +	dev_config.bus_master_enable = false;
> +	if (cdx->ops->dev_configure)
> +		ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +					      cdx_dev->dev_num, &dev_config);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_clear_master);
> +
>  /**
>   * cdx_bus_match - device to driver matching callback
>   * @dev: the cdx device to match against
> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
> index dc52f95f8978..39aa569d8e07 100644
> --- a/drivers/cdx/controller/cdx_controller.c
> +++ b/drivers/cdx/controller/cdx_controller.c
> @@ -55,6 +55,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
>  	case CDX_DEV_RESET_CONF:
>  		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
>  		break;
> +	case CDX_DEV_BUS_MASTER_CONF:
> +		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
> +						 dev_config->bus_master_enable);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
> index 0158f26533dd..6acd8fea4586 100644
> --- a/drivers/cdx/controller/mcdi_functions.c
> +++ b/drivers/cdx/controller/mcdi_functions.c
> @@ -137,3 +137,61 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
>  
>  	return ret;
>  }
> +
> +static int cdx_mcdi_ctrl_flag_get(struct cdx_mcdi *cdx, u8 bus_num,
> +				  u8 dev_num, u32 *flags)
> +{
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN);
> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN);
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
> +	u32 flags;
> +	int ret;
> +
> +	/*
> +	 * Get flags and then set/reset BUS_MASTER_BIT according to
> +	 * the input params.
> +	 */

Nit, this function isn't specific to the BUS_MASTER_BIT, but this
comment is.  s/BUS_MASTER_BIT/lbn bit/?  Thanks,

Alex

> +	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
> +	if (ret)
> +		return ret;
> +
> +	flags = flags & (u32)(~(BIT(lbn)));
> +	if (enable)
> +		flags |= (1 << lbn);
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
> index bead71b7bc73..8320ec3b9e37 100644
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
> +	bool bus_master_enable;
>  };
>  
>  typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
> @@ -170,4 +172,20 @@ extern struct bus_type cdx_bus_type;
>   */
>  int cdx_dev_reset(struct device *dev);
>  
> +/**
> + * cdx_set_master - enables bus-mastering for CDX device
> + * @cdx_dev: the CDX device to enable
> + *
> + * Return: 0 for success, -errno on failure
> + */
> +int cdx_set_master(struct cdx_device *cdx_dev);
> +
> +/**
> + * cdx_clear_master - disables bus-mastering for CDX device
> + * @cdx_dev: the CDX device to disable
> + *
> + * Return: 0 for success, -errno on failure
> + */
> +int cdx_clear_master(struct cdx_device *cdx_dev);
> +
>  #endif /* _CDX_BUS_H_ */

