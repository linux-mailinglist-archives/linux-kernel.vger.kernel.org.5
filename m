Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3067BEA72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378383AbjJITQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbjJITQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:16:29 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB986B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:16:26 -0700 (PDT)
Received: (qmail 155547 invoked by uid 1000); 9 Oct 2023 15:16:25 -0400
Date:   Mon, 9 Oct 2023 15:16:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v2] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <66f874d3-b480-4748-8732-d0cdce3ab4b7@rowland.harvard.edu>
References: <--in-reply-to=20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231009161402.104224-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009161402.104224-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:14:02PM +0200, Hardik Gajjar wrote:
> Currently, the timeout for the set address command is fixed at
> 5 seconds in the xhci driver. This means the host waits up to 5
> seconds to receive a response for the set_address command from
> the device.
> 
> In the automotive context, most smartphone enumerations, including
> screen projection, should ideally complete within 3 seconds.
> Achieving this is impossible in scenarios where the set_address is
> not successful and waits for a timeout.

What will you do about scenarios where the Set-Address completes very 
quickly but the following Get-Device-Descriptor times out after 5 
seconds?  Or any of the other transfers involved in device 
initialization and enumeration?

> The shortened address device timeout quirks provide the flexibility
> to align with a 3-second time limit in the event of errors.
> By swiftly triggering a failure response and swiftly initiating
> retry procedures, these quirks ensure efficient and rapid recovery,
> particularly in automotive contexts where rapid smartphone enumeration
> and screen projection are vital.
> 
> The quirk will set the timeout to 500 ms from 5 seconds.
> 
> To use the quirk, please write "vendor_id:product_id:p" to
> /sys/bus/usb/drivers/hub/module/parameter/quirks
> 
> For example,
> echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameter/quirks"
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- implement quirk instead of new API in xhci driver
> ---
>  drivers/usb/core/hub.c       | 15 +++++++++++++--
>  drivers/usb/core/quirks.c    |  3 +++
>  drivers/usb/host/xhci-mem.c  |  1 +
>  drivers/usb/host/xhci-ring.c |  3 ++-
>  drivers/usb/host/xhci.c      |  9 +++++----
>  drivers/usb/host/xhci.h      |  1 +
>  include/linux/usb/hcd.h      |  3 ++-
>  include/linux/usb/quirks.h   |  3 +++
>  8 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3c54b218301c..975449b03426 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -54,6 +54,9 @@
>  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
>  #define USB_PING_RESPONSE_TIME		400	/* ns */
>  
> +#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT		(HZ * 5) /* 5000ms */
> +#define USB_SHORT_ADDR_DEVICE_TIMEOUT		125  /* ~500ms */

That number, 125, is meaningless.  It's in units of jiffies, which vary 
from one system to another.  If you want the timeout to be about 500 ms, 
you should write it as (HZ / 2).

Alan Stern
