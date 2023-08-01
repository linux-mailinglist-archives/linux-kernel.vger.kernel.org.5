Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911376A828
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHAFGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjHAFG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954A1FC3;
        Mon, 31 Jul 2023 22:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8211261460;
        Tue,  1 Aug 2023 05:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7C3C433C8;
        Tue,  1 Aug 2023 05:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690866386;
        bh=I5BKGPqNH5ZPF8HaNaiQAbuWCYAaEz3wP3sy1lgi9Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eplamN6cUeFBg89sP29RPJbOW6bqrwn0U67TDEnxsXY6w/BrvJpbzK3QCyPGhiJVh
         fam6cgd0hQ7Jkn4DXFDjPtIrxHmCSFKXO+g9bms5hM45je+HtZvh/eiblXyboDNUhG
         PH53K3kWNBfy6V2v35DpoIPET2OghzuYyM34d8Z8=
Date:   Tue, 1 Aug 2023 07:06:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhouscd <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <2023080159-uncorrupt-chamber-7de0@gregkh>
References: <20230801045449.156348-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801045449.156348-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:54:49PM -0700, zhouscd wrote:
> Inconsistent function names can cause the USB config FS not work.

I do not understand this text at all, sorry.

What exactly is broken and what is changed here to resolve the issue?

> 
> Signed-off-by: zhouscd <zhouscd@gmail.com>

What commit caused the problem?

And please use your full name for patches.

> ---
>  drivers/usb/gadget/function/f_loopback.c   | 13 +----------
>  drivers/usb/gadget/function/f_sourcesink.c | 25 ++--------------------
>  drivers/usb/gadget/function/g_zero.h       |  3 ---
>  3 files changed, 3 insertions(+), 38 deletions(-)
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

You just changed a user-visable api, right?  Where did you document this
and what will it affect?

thanks,

greg k-h
