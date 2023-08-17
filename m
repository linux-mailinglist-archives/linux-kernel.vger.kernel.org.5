Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B577FB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353309AbjHQPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353319AbjHQPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3730C5;
        Thu, 17 Aug 2023 08:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DAF611D9;
        Thu, 17 Aug 2023 15:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE1C433C9;
        Thu, 17 Aug 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692287172;
        bh=r3gM2wBVuSBtneu8My7vWP8nSkzO9VJPLNZSYw6zw9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V455VNbfkD6kUBBQVwl9hnKTBVsfiIh+M02EHAkbZmoXJOCTFW+R+2GYBvDATjSh5
         Nv72ywmAYjPLV/WdMPP7tGdt1/zW5wiVIIZG4yBwWdbRyun/CvDOdzCKJKZqbOvCdF
         LTV+zpfmmR4oJbCN+lNFSApR7EuaVRNXoKjK0l48do5sdfoF3yPrt9z3uuicDXNjCC
         55Wb0z5c0KdOBNceOau9J9245wWKUpfFnC9eS09s+6eJXho2jYmv99xCdcEw9O1QLO
         NsyrRCXfFeOIdLKQYUhK37zKMtCN1rBdfr5J/88H0QwYHhk99MjsTa/v5c/Gn8bZCj
         Y/jvl51LUtKtQ==
Received: (nullmailer pid 1187293 invoked by uid 1000);
        Thu, 17 Aug 2023 15:46:10 -0000
Date:   Thu, 17 Aug 2023 10:46:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        andrew@aj.id.au, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] fsi: Use of_match_table for bus matching if
 specified
Message-ID: <20230817154610.GA1179394-robh@kernel.org>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
 <20230612195657.245125-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612195657.245125-4-eajames@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:56:46PM -0500, Eddie James wrote:
> Since we have two scom drivers, use the standard of matching if
> the driver specifies a table so that the right devices go to the
> right driver.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-core.c | 11 +++++++++--
>  drivers/fsi/fsi-scom.c |  8 ++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index b77013b9d8a7..ca4a9634fbc3 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/bitops.h>
>  #include <linux/cdev.h>
> @@ -1375,8 +1376,14 @@ static int fsi_bus_match(struct device *dev, struct device_driver *drv)
>  		if (id->engine_type != fsi_dev->engine_type)
>  			continue;
>  		if (id->version == FSI_VERSION_ANY ||
> -				id->version == fsi_dev->version)
> -			return 1;
> +		    id->version == fsi_dev->version) {
> +			if (drv->of_match_table) {
> +				if (of_driver_match_device(dev, drv))
> +					return 1;
> +			} else {
> +				return 1;
> +			}
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index bcb756dc9866..61dbda9dbe2b 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -10,6 +10,7 @@
>  #include <linux/cdev.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
> @@ -587,6 +588,12 @@ static int scom_remove(struct device *dev)
>  	return 0;
>  }
>  
> +static const struct of_device_id scom_of_ids[] = {
> +	{ .compatible = "ibm,fsi2pib" },

This is not documented. Please add a binding.

Rob
