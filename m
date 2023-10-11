Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093A7C567A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjJKOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjJKOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:15:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A1D1CB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:15:51 -0700 (PDT)
Received: (qmail 224905 invoked by uid 1000); 11 Oct 2023 10:15:48 -0400
Date:   Wed, 11 Oct 2023 10:15:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v3] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <c9014f9c-ea2b-4263-a7b1-03c92639118a@rowland.harvard.edu>
References: <6b26db15-89a0-d455-5740-9abb1befa3a8@intel.com>
 <20231011085011.89198-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011085011.89198-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:50:11AM +0200, Hardik Gajjar wrote:

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -54,6 +54,9 @@
>  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
>  #define USB_PING_RESPONSE_TIME		400	/* ns */
>  
> +#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS	5000 /* 5000ms */
> +#define USB_SHORT_ADDR_DEVICE_TIMEOUT_MS	500  /* 500ms */

You don't have to repeat the numbers in the comments.  You can just 
write /* ms */ -- just like in the comments immediately above.

>  		return -EINVAL;
>  	if (hcd->driver->address_device)
> -		retval = hcd->driver->address_device(hcd, udev);
> +		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
>  	else
>  		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>  			case 'o':
>  				flags |= USB_QUIRK_HUB_SLOW_RESET;
>  				break;
> +			case 'p':
> +				flags |= USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT;
> +				break;
>  			/* Ignore unrecognized flag characters */
>  			}
>  		}
> @@ -542,6 +545,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* INTEL VALUE SSD */
>  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
>  
> +	/* APTIV AUTOMOTIVE HUB */
> +	{ USB_DEVICE(0x2c48, 0x0132), .driver_info = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT },

This table is sorted by Vendor ID, then Product ID, then Class ID, as 
stated in the comment at the beginning of the definition.  Your new 
entry is in the wrong position.

Alan Stern
