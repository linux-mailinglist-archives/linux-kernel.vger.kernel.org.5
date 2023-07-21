Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0A75CACC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGUO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGUO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:57:29 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1609C30C8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:57:24 -0700 (PDT)
Received: (qmail 1757634 invoked by uid 1000); 21 Jul 2023 10:57:24 -0400
Date:   Fri, 21 Jul 2023 10:57:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
References: <20230721100015.27124-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721100015.27124-1-liulongfang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
> On systems that use ECC memory. The ECC error of the memory will
> cause the USB controller to halt. It causes the usb_control_msg()
> operation to fail.

How often does this happen in real life?  (Besides, it seems to me that 
if your system is getting a bunch of ECC memory errors then you've got 
much worse problems than a simple USB failure!)

And why do you worry about ECC memory failures in particular?  Can't 
_any_ kind of failure cause the usb_control_msg() operation to fail?

> At this point, the returned buffer data is an abnormal value, and
> continuing to use it will lead to incorrect results.

The driver already contains code to check for abnormal values.  The 
check is not perfect, but it should prevent things from going too 
badly wrong.

> Therefore, it is necessary to judge the return value and exit.
> 
> Signed-off-by: liulongfang <liulongfang@huawei.com>

There is a flaw in your reasoning.

The operation carried out here is deliberately unsafe (for full-speed 
devices).  It is made before we know the actual maxpacket size for ep0, 
and as a result it might return an error code even when it works okay.  
This shouldn't happen, but a lot of USB hardware is unreliable.

Therefore we must not ignore the result merely because r < 0.  If we do 
that, the kernel might stop working with some devices.

Alan Stern

> ---
>  drivers/usb/core/hub.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a739403a9e45..6a43198be263 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4891,6 +4891,16 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  					USB_DT_DEVICE << 8, 0,
>  					buf, GET_DESCRIPTOR_BUFSIZE,
>  					initial_descriptor_timeout);
> +				/* On systems that use ECC memory, ECC errors can
> +				 * cause the USB controller to halt.
> +				 * It causes this operation to fail. At this time,
> +				 * the buf data is an abnormal value and needs to be exited.
> +				 */
> +				if (r < 0) {
> +					kfree(buf);
> +					goto fail;
> +				}
> +
>  				switch (buf->bMaxPacketSize0) {
>  				case 8: case 16: case 32: case 64: case 255:
>  					if (buf->bDescriptorType ==
> -- 
> 2.24.0
> 
