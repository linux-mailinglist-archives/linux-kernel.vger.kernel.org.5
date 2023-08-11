Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06F7797E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjHKTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHKTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520430E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76FB6103F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4CFC433C7;
        Fri, 11 Aug 2023 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691782814;
        bh=W/sCTIlzhkPgtcy2Dt4RkaCyTpwyn9jYHCdoz8xGBbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAD98GDrATySo70mVck09vWKE7GpPiXNyqXE3ZmGHWTD0sO5upnB0CPu06sXzbBwW
         4xmsEybRFtiatRPr7yLs1QHf1ubqGbExAcBHJk3AOyddyAxi0jRTsunHWpe+miXSzg
         tvgZ+IMTZ2tgXgEIYbIC9iKLFBAZz3qg0rBj3fRg=
Date:   Fri, 11 Aug 2023 21:40:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     tomas.winkler@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: make mei_class a static const structure
Message-ID: <2023081112-wistful-coping-f775@gregkh>
References: <20230810194652.27004-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810194652.27004-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:46:52PM +0400, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the mei_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  drivers/misc/mei/main.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 51876da3fd65..902789d3106b 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -27,7 +27,9 @@
>  #include "mei_dev.h"
>  #include "client.h"
>  
> -static struct class *mei_class;
> +static const struct class mei_class = {
> +	.name = "mei",
> +};
>  static dev_t mei_devt;

Extra line after the new structure?

>  #define MEI_MAX_DEVS  MINORMASK
>  static DEFINE_MUTEX(mei_minor_lock);
> @@ -1115,7 +1117,7 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
>  
>  	dev->dev_state = state;
>  
> -	clsdev = class_find_device_by_devt(mei_class, dev->cdev.dev);
> +	clsdev = class_find_device_by_devt(&mei_class, dev->cdev.dev);
>  	if (clsdev) {
>  		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
>  		put_device(clsdev);
> @@ -1232,7 +1234,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
>  		goto err_dev_add;
>  	}
>  
> -	clsdev = device_create_with_groups(mei_class, parent, devno,
> +	clsdev = device_create_with_groups(&mei_class, parent, devno,
>  					   dev, mei_groups,
>  					   "mei%d", dev->minor);
>  
> @@ -1264,7 +1266,7 @@ void mei_deregister(struct mei_device *dev)
>  
>  	mei_dbgfs_deregister(dev);
>  
> -	device_destroy(mei_class, devno);
> +	device_destroy(&mei_class, devno);
>  
>  	mei_minor_free(dev);
>  }
> @@ -1274,10 +1276,9 @@ static int __init mei_init(void)
>  {
>  	int ret;
>  
> -	mei_class = class_create("mei");
> -	if (IS_ERR(mei_class)) {
> +	ret = class_register(&mei_class);
> +	if (ret) {
>  		pr_err("couldn't create class\n");

This message doesn't make sense anymore.  No need for it either, just
remove it and do a simple:
		return err;
here instead.

thanks,

greg k-h
