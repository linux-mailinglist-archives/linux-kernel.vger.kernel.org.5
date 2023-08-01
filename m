Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5404176AB34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjHAIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHAIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6DA1710;
        Tue,  1 Aug 2023 01:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C39461499;
        Tue,  1 Aug 2023 08:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD25C433C7;
        Tue,  1 Aug 2023 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690879189;
        bh=I7Ylvu2aXpgZrcBn8wo5FXmj7fgbxnRV7pCOxVuXjwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pumBEJWojxu/eL9wMP7/QHQ4s7hIpLv+khI9qapLE+Ii6HoDZlrGV5rlo8o248MkG
         zFjgr/HfTSBD0IphGJf5dSzPnoC+cN2uG1hWyOtA549TCxii6hVGWDKH7YXxP6BxfG
         VQsV4SOqp8gvPp2ZD9NMD8JassntwjYmoHTY5iuQ=
Date:   Tue, 1 Aug 2023 10:39:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chengdong zhou <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <2023080143-makeshift-cupid-8abb@gregkh>
References: <20230801083244.165392-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801083244.165392-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:32:45AM -0700, chengdong zhou wrote:
> Change function name from "source/sink" to "sourcesink".
> Keep the usb_function_driver.name consistent with usb_function.name
> for sourcesink and loopback.
> Cleaned up some code to decouple the sourcesink and loopback.
> 
> If usb_function.name and usb_function_driver.name are not the same,
> it will cause the function to be unable to be exported to userspace
> by the USB config file system.
> 
> Signed-off-by: chengdong zhou <zhouscd@gmail.com>
> ---
>  drivers/usb/gadget/function/f_loopback.c   | 13 +----------
>  drivers/usb/gadget/function/f_sourcesink.c | 25 ++--------------------
>  drivers/usb/gadget/function/g_zero.h       |  3 ---
>  drivers/usb/gadget/legacy/zero.c           |  6 +++---
>  4 files changed, 6 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
> index ae41f556eb75..45f542b5ff55 100644
> --- a/drivers/usb/gadget/function/f_loopback.c
> +++ b/drivers/usb/gadget/function/f_loopback.c
> @@ -583,16 +583,5 @@ static struct usb_function_instance *loopback_alloc_instance(void)
>  
>  	return  &lb_opts->func_inst;
>  }
> -DECLARE_USB_FUNCTION(Loopback, loopback_alloc_instance, loopback_alloc);
> -
> -int __init lb_modinit(void)
> -{
> -	return usb_function_register(&Loopbackusb_func);
> -}
> -
> -void __exit lb_modexit(void)
> -{
> -	usb_function_unregister(&Loopbackusb_func);
> -}
> -
> +DECLARE_USB_FUNCTION_INIT(loopback, loopback_alloc_instance, loopback_alloc);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
> index 6803cd60cc6d..f6d1c095aa2c 100644
> --- a/drivers/usb/gadget/function/f_sourcesink.c
> +++ b/drivers/usb/gadget/function/f_sourcesink.c
> @@ -858,7 +858,7 @@ static struct usb_function *source_sink_alloc_func(
>  	ss->bulk_qlen = ss_opts->bulk_qlen;
>  	ss->iso_qlen = ss_opts->iso_qlen;
>  
> -	ss->function.name = "source/sink";
> +	ss->function.name = "sourcesink";
>  	ss->function.bind = sourcesink_bind;
>  	ss->function.set_alt = sourcesink_set_alt;
>  	ss->function.get_alt = sourcesink_get_alt;
> @@ -1263,27 +1263,6 @@ static struct usb_function_instance *source_sink_alloc_inst(void)
>  
>  	return &ss_opts->func_inst;
>  }
> -DECLARE_USB_FUNCTION(SourceSink, source_sink_alloc_inst,
> +DECLARE_USB_FUNCTION_INIT(sourcesink, source_sink_alloc_inst,
>  		source_sink_alloc_func);
> -
> -static int __init sslb_modinit(void)
> -{
> -	int ret;
> -
> -	ret = usb_function_register(&SourceSinkusb_func);
> -	if (ret)
> -		return ret;
> -	ret = lb_modinit();
> -	if (ret)
> -		usb_function_unregister(&SourceSinkusb_func);
> -	return ret;
> -}
> -static void __exit sslb_modexit(void)
> -{
> -	usb_function_unregister(&SourceSinkusb_func);
> -	lb_modexit();
> -}
> -module_init(sslb_modinit);
> -module_exit(sslb_modexit);
> -
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/gadget/function/g_zero.h b/drivers/usb/gadget/function/g_zero.h
> index 98b8462ad538..c1ea28526c73 100644
> --- a/drivers/usb/gadget/function/g_zero.h
> +++ b/drivers/usb/gadget/function/g_zero.h
> @@ -62,9 +62,6 @@ struct f_lb_opts {
>  	int				refcnt;
>  };
>  
> -void lb_modexit(void);
> -int lb_modinit(void);
> -
>  /* common utilities */
>  void disable_endpoints(struct usb_composite_dev *cdev,
>  		struct usb_ep *in, struct usb_ep *out,
> diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
> index 23312a07efb4..0cddd20e54ff 100644
> --- a/drivers/usb/gadget/legacy/zero.c
> +++ b/drivers/usb/gadget/legacy/zero.c
> @@ -222,7 +222,7 @@ static int ss_config_setup(struct usb_configuration *c,
>  }
>  
>  static struct usb_configuration sourcesink_driver = {
> -	.label                  = "source/sink",
> +	.label                  = "sourcesink",
>  	.setup                  = ss_config_setup,
>  	.bConfigurationValue    = 3,
>  	.bmAttributes           = USB_CONFIG_ATT_SELFPOWER,
> @@ -282,7 +282,7 @@ static int zero_bind(struct usb_composite_dev *cdev)
>  	autoresume_cdev = cdev;
>  	timer_setup(&autoresume_timer, zero_autoresume, 0);
>  
> -	func_inst_ss = usb_get_function_instance("SourceSink");
> +	func_inst_ss = usb_get_function_instance("sourcesink");
>  	if (IS_ERR(func_inst_ss))
>  		return PTR_ERR(func_inst_ss);
>  
> @@ -302,7 +302,7 @@ static int zero_bind(struct usb_composite_dev *cdev)
>  		goto err_put_func_inst_ss;
>  	}
>  
> -	func_inst_lb = usb_get_function_instance("Loopback");
> +	func_inst_lb = usb_get_function_instance("loopback");
>  	if (IS_ERR(func_inst_lb)) {
>  		status = PTR_ERR(func_inst_lb);
>  		goto err_put_func_ss;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
