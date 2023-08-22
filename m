Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36C78437E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjHVOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjHVOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4299E7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDAA65807
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A62C433CA;
        Tue, 22 Aug 2023 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692713304;
        bh=OiO4Q0DrwnUgVuWcPzjWf7klGr0wIyHezsX7cDgwsVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiihC7ll43QWv7GYzP+aWWA2r+24DDlJGB2Ms13ZeBzK8K+TkSg49SWRH4ygwvZvJ
         V1UE3uYinJD54vcunhqoLw8wR1JGEltsI7+1xg2zMQTTQACi/R+AHf97Wv5wHWnVAq
         GQKlTmgV6ETD6LXMvgjIA63yV2HHPf7dlILmXMbo=
Date:   Tue, 22 Aug 2023 16:08:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Nipun.Gupta@amd.com, nikhil.agarwal@amd.com, puneet.gupta@amd.com,
        git@amd.com, michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH v3 3/5] cdx: add support for bus enable and disable
Message-ID: <2023082201-silenced-exfoliate-e6a6@gregkh>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
 <20230814102223.418046-4-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814102223.418046-4-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:52:21PM +0530, Abhijit Gangurde wrote:
> CDX bus needs to be disabled before updating/writing devices
> in the FPGA. Once the devices are written, the bus shall be
> rescanned. This change provides sysfs entry to enable/disable the
> CDX bus.
> 
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx | 27 +++++++
>  drivers/cdx/cdx.c                       | 94 +++++++++++++++++++++++++
>  drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++
>  drivers/cdx/controller/mc_cdx_pcol.h    | 54 ++++++++++++++
>  drivers/cdx/controller/mcdi_functions.c | 24 +++++++
>  drivers/cdx/controller/mcdi_functions.h | 18 +++++
>  include/linux/cdx/cdx_bus.h             | 12 ++++
>  7 files changed, 279 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 7af477f49998..04c8dfe7e201 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -11,6 +11,33 @@ Description:
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
>  
> +What:		/sys/bus/cdx/enable
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing bus number in hex to this file will attempt to enable
> +		the CDX bus. The bus number for the cdx devices can be found
> +		at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the bus
> +		number for the respective device.
> +
> +		For example ::
> +
> +		  # echo 00 > /sys/bus/cdx/enable
> +
> +What:		/sys/bus/cdx/disable
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing bus number in hex to this file will attempt to disable
> +		the CDX bus. CDX bus should be disabled before updating the
> +		devices in FPGA. The bus number for the cdx devices can be
> +		found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the
> +		bus number for the respective device.
> +
> +		For example ::
> +
> +		  # echo 00 > /sys/bus/cdx/disable
> +
>  What:		/sys/bus/cdx/devices/.../vendor
>  Date:		March 2023
>  Contact:	nipun.gupta@amd.com
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 50df061f4537..411beb035fdd 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -70,6 +70,10 @@
>  #define CDX_DEFAULT_DMA_MASK	(~0ULL)
>  #define MAX_CDX_CONTROLLERS 16
>  
> +#define CONTROLLER_ID(X)	\
> +	(((X) & CDX_CONTROLLER_ID_MASK) >> CDX_CONTROLLER_ID_SHIFT)
> +#define BUS_ID(X) ((X) & CDX_BUS_NUM_MASK)
> +
>  /* IDA for CDX controllers registered with the CDX bus */
>  DEFINE_IDA(cdx_controller_ida);
>  /* Lock to protect controller ops */
> @@ -384,6 +388,94 @@ static struct attribute *cdx_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cdx_dev);
>  
> +static struct cdx_controller *cdx_find_controller(u8 controller_id)
> +{
> +	struct cdx_controller *cdx = NULL;
> +	struct platform_device *pd;
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, compat_node_name) {
> +		if (!np)
> +			return NULL;
> +
> +		pd = of_find_device_by_node(np);
> +		if (!pd)
> +			return NULL;
> +
> +		cdx = platform_get_drvdata(pd);
> +		if (cdx && cdx->controller_registered && cdx->id == controller_id) {
> +			put_device(&pd->dev);
> +			break;
> +		}
> +
> +		put_device(&pd->dev);

Where is the locking if a platform device is removed?

> +	}
> +
> +	return cdx;
> +}
> +
> +static ssize_t enable_store(const struct bus_type *bus,
> +			    const char *buf, size_t count)
> +{
> +	unsigned long controller_id;
> +	struct cdx_controller *cdx;
> +	u8 bus_id;
> +	int ret;
> +
> +	if (kstrtou8(buf, 16, &bus_id))
> +		return -EINVAL;
> +
> +	controller_id = CONTROLLER_ID(bus_id);
> +	bus_id = BUS_ID(bus_id);
> +
> +	mutex_lock(&cdx_controller_lock);
> +
> +	cdx = cdx_find_controller(controller_id);

You lock before you call this function?  Is the lock required before you
call it?  If so, please document that and enforce it with the proper
sparse marking.

thanks,

greg k-h
