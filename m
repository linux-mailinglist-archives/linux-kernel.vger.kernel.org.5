Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF0801162
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378023AbjLAQNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378234AbjLAQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:13:50 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1B57010F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:13:54 -0800 (PST)
Received: (qmail 291319 invoked by uid 1000); 1 Dec 2023 11:13:53 -0500
Date:   Fri, 1 Dec 2023 11:13:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, tj@kernel.org, paulmck@kernel.org,
        Martin.Mueller5@de.bosch.com
Subject: Re: [PATCH v3] usb: hub: Add quirk to decrease IN-ep poll interval
 for Microchip USB491x hub
Message-ID: <39f334d2-abe6-4b4d-a48c-b22a907c6ea6@rowland.harvard.edu>
References: <20231201144705.97385-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201144705.97385-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:47:05PM +0100, Hardik Gajjar wrote:
> There is a potential delay in notifying Linux USB drivers of downstream
> USB bus activity when connecting a high-speed or superSpeed device via the
> Microchip USB491x hub. This delay is due to the fixed bInterval value of
> 12 in the silicon of the Microchip USB491x hub.
> 
> Microchip requested to ignore the device descriptor and decrease that
> value to 9 as it was too late to modify that in silicon.
> 
> This patch speeds up the USB enummeration process that helps to pass
> Apple Carplay certifications and improve the User experience when utilizing
> the USB device via Microchip Multihost USB491x Hub.
> 
> A new hub quirk HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL speeds up
> the notification process for Microchip USB491x hub by limiting
> the maximum bInterval value to 9.
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- Move implementation from config.c and quirk.c to hub.c as this is hub
> 	  specific changes.
> 	- Improve commit message.
> 	- Link to v1 - https://lore.kernel.org/all/20231123081948.58776-1-hgajjar@de.adit-jv.com/
> 
> changes since version 2:
>     - Call usb_set_interface after updating the bInterval to Tell the HCD about modification
> 	- Link to v2 - https://lore.kernel.org/all/20231130084855.119937-1-hgajjar@de.adit-jv.com/
> ---
>  drivers/usb/core/hub.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b4584a0cd484..b5ac29c5f016 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -47,12 +47,18 @@
>  #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
>  #define USB_PRODUCT_TUSB8041_USB3		0x8140
>  #define USB_PRODUCT_TUSB8041_USB2		0x8142
> +#define USB_VENDOR_MICROCHIP			0x0424
> +#define USB_PRODUCT_USB4913			0x4913
> +#define USB_PRODUCT_USB4914			0x4914
> +#define USB_PRODUCT_USB4915			0x4915
>  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
>  #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
> +#define HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL	0x08

Why use 0x08 instead of 0x04?

Alan Stern
