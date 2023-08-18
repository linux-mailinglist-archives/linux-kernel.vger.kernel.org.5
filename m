Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F47806F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbjHRIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbjHRIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:15:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380772D73;
        Fri, 18 Aug 2023 01:15:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 65E59223;
        Fri, 18 Aug 2023 10:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692346464;
        bh=SjhLlmQNk8SVJA7m7XXf+wU+y4H03B0e+9YiDJJV15I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peKjs4r3YI95x1SbNzHxDw0cEI8pvS7xvHhXKbXjYJ58cCqwoRryBsdq8xCoLCmse
         lZI5QzyoUOZlVuESejMLHIqlrorPPR1CiHXde6rJfwUGIbJOQcO/1lS2Eh+MRaFHRz
         +RW4S6hjs8792oVK8XBFf8K7aqrdI85l/5/I2q+g=
Date:   Fri, 18 Aug 2023 11:15:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix power line control for a Chicony
 camera
Message-ID: <20230818081546.GA26285@pendragon.ideasonboard.com>
References: <20230817-chicony-v1-1-76bde4d6ff6b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817-chicony-v1-1-76bde4d6ff6b@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thu, Aug 17, 2023 at 12:38:04PM +0000, Ricardo Ribalda wrote:
> The device does not implement the control properly.
> 
> Fixes vl2-compliance error:
> 
> info: checking control 'Power Line Frequency' (0x00980918)
> fail: v4l2-test-controls.cpp(552): could not set valid menu item 3
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> This camera, like other Chicony devices, do not implement properly the
> Power Line Frequency control.
> 
> This time, I do not have direct access to the device, just to the
> report, but since other devices from the same family are showing the
> same error, it is safe to assume that the same fix will work here.

Why, ô why does UVC not provide a way to query this dynamically ? :-( Of
course, even if it did, I'm sure vendors would get it wrong... It sounds
like the Windows UVC compliance test suite must be a joke.

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..db2556e95b72 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> +	/* Chicony Electronics Co., Ltd */

I'll write

	/* Chicony Electronics Co., Ltd Integrated Camera */

as that's what the descriptors expose. Is this integrated in a
chromebook by any chance ? If so, could you share which model the camera
is found in, and can I add that to the comment ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x04f2,
> +	  .idProduct		= 0xb67c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>  	/* Chicony EasyCamera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> 
> ---
> base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> change-id: 20230817-chicony-9c35f2046c6f

-- 
Regards,

Laurent Pinchart
