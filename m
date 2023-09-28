Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF99D7B273F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjI1VNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1VNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F019D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695935567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKryvrq2p/NzaN3OZkdGvBtpLDKKqO0aHSPPBvcQba0=;
        b=W7gEBH1Sx5jnK61Njm39pv0VoV+/rnEwC+V6/gXCrgN9Hh5ojxU7DXYOMAqHWJ5UJqUY8S
        RNqNTcP4eRhvK3O6Zr1Dh/zZuCM/BqoEAUD2IBgXh9nCfbq2UFNt+7U88xCL2Y0nY0Aekt
        AnMDAlgCTS+bGrFiaGmUh1in6a/mtHI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-79bV7eovN1O1lpV5niIRwA-1; Thu, 28 Sep 2023 17:12:45 -0400
X-MC-Unique: 79bV7eovN1O1lpV5niIRwA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-79f9edb0086so1527902139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935565; x=1696540365;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKryvrq2p/NzaN3OZkdGvBtpLDKKqO0aHSPPBvcQba0=;
        b=P9AG1+vZldMXj3RBxIuaR55U4KeV7kiFDb7usrOSzwD3X1gTSQUkNpmubNmSlYQ/h3
         ykTZkDrIgszhcH93zHko5yqLFdDuWeRDkFq6OSLejkcPGnySREUjlxn0DMsQ9qeE18IJ
         ViZF1KN+qWiXPoQYFMfKLtanhf9YVzF5NA5CWLRs+D8IkakcatdYEMTArR4OQ/keSqZ/
         takjHhLzMFfrSsSjR8RRF8BvGa20SZ0XcSEnrMPTVjS5upYzs2JBTQxFpySQywba0dz1
         dqtqfYILGX75Va2hb+74mK0g7yXC/tA05qisfHTFLM6z+xx8fL2xZLhnyuHU8qhjVHZ8
         Aw5g==
X-Gm-Message-State: AOJu0Yzhd0rwzzyItzYO9wwgDVp3N31XA5YeP9ATafY+61Vj/quvsUI2
        sVD1PZ9n3xjyWcWLF2aCjeSiX542t0NqJJxIniwBHfFOZH0HQPPvZEyTZxzieGXbip1JKtXkvIT
        2YnskSJC4bxm7BGcrsydBYGr4
X-Received: by 2002:a5d:85c1:0:b0:795:bea:ae13 with SMTP id e1-20020a5d85c1000000b007950beaae13mr2819786ios.20.1695935565043;
        Thu, 28 Sep 2023 14:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGilTi00h11elh2QhFyJynxhXf4r+aLvG1BsmXG8Hk5ObL/QgDqzPuBHST5Cv6Po9yb88SAnw==
X-Received: by 2002:a5d:85c1:0:b0:795:bea:ae13 with SMTP id e1-20020a5d85c1000000b007950beaae13mr2819767ios.20.1695935564708;
        Thu, 28 Sep 2023 14:12:44 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t23-20020a6b5f17000000b0079f9efd067asm4391241iob.1.2023.09.28.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:12:43 -0700 (PDT)
Date:   Thu, 28 Sep 2023 15:12:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v8 1/3] cdx: add support for bus mastering
Message-ID: <20230928151241.6a7b4065.alex.williamson@redhat.com>
In-Reply-To: <20230915045423.31630-1-nipun.gupta@amd.com>
References: <20230915045423.31630-1-nipun.gupta@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 10:24:21 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Introduce cdx_set_master() and cdx_clear_master() APIs to support
> enable and disable of bus mastering. Drivers need to use these APIs to
> enable/disable DMAs from the CDX devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---

Applied series to vfio next branch for v6.7.  Thanks,

Alex

> 
> Changes v7->v8:
> - Fix a comment in cdx_mcdi_ctrl_flag_set()
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
> +				  u8 dev_num, bool enable, int bit_pos)
> +{
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN);
> +	u32 flags;
> +	int ret;
> +
> +	/*
> +	 * Get flags and then set/reset bit at bit_pos according to
> +	 * the input params.
> +	 */
> +	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
> +	if (ret)
> +		return ret;
> +
> +	flags = flags & (u32)(~(BIT(bit_pos)));
> +	if (enable)
> +		flags |= (1 << bit_pos);
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

