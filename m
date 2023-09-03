Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC0790E0C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348165AbjICU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjICU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:59:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E30103;
        Sun,  3 Sep 2023 13:58:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213.211-177-91.adsl-dyn.isp.belgacom.be [91.177.211.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB1E1124F;
        Sun,  3 Sep 2023 22:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693774649;
        bh=uWYgqjOYV1jmmpik9gU1rfKW/hbm/lrcAvIye6jA3P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9SphoLq2P9byG248ZNwKzk8Do8nb+3E/ip/9SP6edc2sj70yVe/SKm8FU4oO/6FE
         pMKaeNEEBEkGBuGUBwVbuYZO/T2GK2wYcOTK3eEn9gUIjGe4OinoPWmx7E2oxJOykY
         UvCJo/Z5ufNfdxOmqW2f7HkNpubJJFGS5fXNCysk=
Date:   Sun, 3 Sep 2023 23:59:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     fasih0001@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uvc_driver: Error Fix in the file
 drivers/media/usb/uvc/uvc_driver.c
Message-ID: <20230903205906.GD13794@pendragon.ideasonboard.com>
References: <20230903095431.28711-1-fasih0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230903095431.28711-1-fasih0001@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 03, 2023 at 02:54:31PM +0500, fasih0001@gmail.com wrote:
> From: Fasih <fasih0001@gmail.com>
> 
> Error fix for the line 2429 and 2430, The error message indicated that "Macros with complex values should be enclosed in parentheses".
> This typically means that the macro is defined in a way that involves complex expressions or compound literals,
> and the preprocessor requires them to be enclosed in parentheses for clarity and proper evaluation.
> To address this error and comply with the requirement to enclose complex values in parentheses,
> you should wrap the entire expression inside an extra set of parentheses.

Did you read Documentation/process/submitting-patches.rst ?

> Signed-off-by: Syed Muhammad Fasih Ul Hassan <fasih0001@gmail.com>
> 
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2095,6 +2095,8 @@ static int uvc_probe(struct usb_interface *intf,
>         int function;
>         int ret;
> 
> +       pr_info("I changed uvcvideo driver in the Linux Kernel\n");
> +

Have you read our patch before sending it out ?

>         /* Allocate memory for the device and initialize it. */
>         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>         if (dev == NULL)
> @@ -2417,9 +2419,9 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
>         .quirks = UVC_QUIRK_FORCE_Y8,
>  };
> 
> -#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
> -#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
> -       {.meta_format = m}
> +#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
> +#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) \
> +       {.meta_format = m})

Why do you think this is a good change ?

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Your patch seems corrupted.

> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..42d42b211094 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2095,6 +2095,8 @@ static int uvc_probe(struct usb_interface *intf,
>  	int function;
>  	int ret;
>  
> +	pr_info("I changed uvcvideo driver in the Linux Kernel\n");
> +
>  	/* Allocate memory for the device and initialize it. */
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (dev == NULL)
> @@ -2417,9 +2419,16 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
>  	.quirks = UVC_QUIRK_FORCE_Y8,
>  };
>  
> -#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
> -#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
> -	{.meta_format = m}
> +/* For line 2429 and 2430, The error message indicated that "Macros with complex values should be enclosed in parentheses".
> + * This typically means that the macro is defined in a way that involves complex expressions or compound literals,
> + * and the preprocessor requires them to be enclosed in parentheses for clarity and proper evaluation.
> + * To address this error and comply with the requirement to enclose complex values in parentheses,
> + * you should wrap the entire expression inside an extra set of parentheses like that:
> + * #define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
> + */
> +#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
> +#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) \
> +	{.meta_format = m})
>  
>  /*
>   * The Logitech cameras listed below have their interface class set to

-- 
Regards,

Laurent Pinchart
