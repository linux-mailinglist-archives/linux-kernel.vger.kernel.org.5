Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D6784362
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjHVOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbjHVOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB010C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEFB5646CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E47C433C8;
        Tue, 22 Aug 2023 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692713203;
        bh=VNXJkvsPKaFuHwEHKETBibLSZ11x1btzzmXBiyyPrSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M54SdcugIYqOSsm7uA0TlcjeJ16SLC0WpkFEPi8BMtYaG7ORhnGkdsfWJSIIY/TWM
         uDhKbNHrGvTYAijhA4hVlLdsD2omxojfMjHD5bdhid+F601jMFNLC/wT3Q0/NBDlFj
         8mX4DqUCUfQANLqUjYMsJ90uhFhFzsqGbLdPrvQ8=
Date:   Tue, 22 Aug 2023 16:06:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Nipun.Gupta@amd.com, nikhil.agarwal@amd.com, puneet.gupta@amd.com,
        git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v3 2/5] cdx: Introduce lock to protect controller ops
Message-ID: <2023082223-cautious-confined-5e05@gregkh>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
 <20230814102223.418046-3-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814102223.418046-3-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:52:20PM +0530, Abhijit Gangurde wrote:
> Add a mutex lock to prevent race between controller ops initiated by
> the bus subsystem and the controller registration/unregistration.
> 
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/cdx/cdx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 1c0f76cf4f15..50df061f4537 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -72,6 +72,8 @@
>  
>  /* IDA for CDX controllers registered with the CDX bus */
>  DEFINE_IDA(cdx_controller_ida);
> +/* Lock to protect controller ops */
> +static DEFINE_MUTEX(cdx_controller_lock);
>  
>  static char *compat_node_name = "xlnx,versal-net-cdx";
>  
> @@ -396,6 +398,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  	if (!val)
>  		return -EINVAL;
>  
> +	mutex_lock(&cdx_controller_lock);
> +
>  	/* Unregister all the devices on the bus */
>  	cdx_unregister_devices(&cdx_bus_type);
>  
> @@ -415,6 +419,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  		put_device(&pd->dev);
>  	}
>  
> +	mutex_unlock(&cdx_controller_lock);
> +
>  	return count;
>  }
>  static BUS_ATTR_WO(rescan);
> @@ -538,11 +544,13 @@ int cdx_register_controller(struct cdx_controller *cdx)
>  		return ret;
>  	}
>  
> +	mutex_lock(&cdx_controller_lock);
>  	cdx->id = ret;
>  
>  	/* Scan all the devices */
>  	cdx->ops->scan(cdx);
>  	cdx->controller_registered = true;
> +	mutex_unlock(&cdx_controller_lock);
>  
>  	return 0;
>  }
> @@ -553,9 +561,13 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
>  	if (cdx->id >= MAX_CDX_CONTROLLERS)
>  		return;
>  
> +	mutex_lock(&cdx_controller_lock);
> +
>  	cdx->controller_registered = false;
>  	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
>  	ida_free(&cdx_controller_ida, cdx->id);
> +
> +	mutex_unlock(&cdx_controller_lock);
>  }
>  EXPORT_SYMBOL_GPL(cdx_unregister_controller);
>  
> -- 
> 2.25.1
> 

Ah, now you lock things, that answers the question in patch 1...
