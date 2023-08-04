Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F00770060
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHDMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHDMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD846B2;
        Fri,  4 Aug 2023 05:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE6061FCB;
        Fri,  4 Aug 2023 12:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A0C433C7;
        Fri,  4 Aug 2023 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691152871;
        bh=1nvF9hY+0aew8oE4SkTyeMAh9F8HI/TLfdQViOEqlPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ixvhh7ZVfgBmVQshItM3fPP2zMTIqm+0mKU41xEwHc6Kz3x2aZmmlwFL2yUAilJa+
         GJC+NvLGhPWpk4CPQhhdMsUPALl/42KIO5RsNNvh0d5mOQ+H7+NRvIu6DxBhfOw9hR
         3jNyVxmOJx3vAwk5mxQmyUzZv5S5FrxE5vCIjztg=
Date:   Fri, 4 Aug 2023 14:41:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chengdong zhou <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: usb function sourcesink and loopback
 support usb configfs
Message-ID: <2023080449-traitor-tricolor-267b@gregkh>
References: <20230801104223.281275-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801104223.281275-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:42:23AM -0700, chengdong zhou wrote:
> There are currently two issues that causes sourcesink and loopback to
> fail to export to usb configfs:
> 1. usb_function.name does not match usb_function_driver.name
> 2. usb configfs does not support function name with '/'
> 
> So, we adjusted usb_function.name to "sourcesink" and "loopback",
> and remove '/'
> 
> Signed-off-by: chengdong zhou <zhouscd@gmail.com>
> ---
>  drivers/usb/gadget/function/f_loopback.c   |  6 +++---
>  drivers/usb/gadget/function/f_sourcesink.c | 20 ++++++++++----------
>  drivers/usb/gadget/legacy/zero.c           |  6 +++---
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
> index ae41f556eb75..9900baa31c2d 100644
> --- a/drivers/usb/gadget/function/f_loopback.c
> +++ b/drivers/usb/gadget/function/f_loopback.c
> @@ -583,16 +583,16 @@ static struct usb_function_instance *loopback_alloc_instance(void)
>  
>  	return  &lb_opts->func_inst;
>  }
> -DECLARE_USB_FUNCTION(Loopback, loopback_alloc_instance, loopback_alloc);
> +DECLARE_USB_FUNCTION(loopback, loopback_alloc_instance, loopback_alloc);
>  
>  int __init lb_modinit(void)
>  {
> -	return usb_function_register(&Loopbackusb_func);
> +	return usb_function_register(&loopbackusb_func);
>  }
>  
>  void __exit lb_modexit(void)
>  {
> -	usb_function_unregister(&Loopbackusb_func);
> +	usb_function_unregister(&loopbackusb_func);
>  }
>  
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
> index 6803cd60cc6d..fc879b785ed0 100644
> --- a/drivers/usb/gadget/function/f_sourcesink.c
> +++ b/drivers/usb/gadget/function/f_sourcesink.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * f_sourcesink.c - USB peripheral source/sink configuration driver
> + * f_sourcesink.c - USB peripheral sourcesink configuration driver

Why are documentation changes like this required?

This doesn't make sense :(

