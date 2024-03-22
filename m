Return-Path: <linux-kernel+bounces-111396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC2886BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BB0285438
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D03FB8E;
	Fri, 22 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MYVppFiD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8F3EA83;
	Fri, 22 Mar 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108821; cv=none; b=GyKcxRbFTEV2bEa9YPHsqKYmdQS7Jlr5V0yoFG5tpydrQiW3Bl8XUyoq/hzt/BNqH7u3VCG42t10qDpLIwhxEwYjCJ7V8mMv4m/PpoPGeCIwIOL8dcj0eDxywkysFLunhi70eSZy1/AtXjeFkNsS4qdyVzRG9gdg5cNrGH2S4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108821; c=relaxed/simple;
	bh=jDhCT7dJ9tH0LwY9EC0UdWhXPwXS80zRmC0TNEUs6/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkSUTjqGHEXHiaKppuLPJb6WFFoNNY72kD2Ojb9aROgG7nPTowbCeduMW0MbSvj7+Boh61qNoxxpvxxNXeVyB4a9kmhMi10rTBZOblgDMdSg8gTjrBvCcrISk8xiX87GdcjmTCWXooO4D66elYNqNs7FP8WMFfGMI2bsA6Q1hrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MYVppFiD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9416B8CC;
	Fri, 22 Mar 2024 12:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711108789;
	bh=jDhCT7dJ9tH0LwY9EC0UdWhXPwXS80zRmC0TNEUs6/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYVppFiDvrieB9bi/On5r+xzbJqi5hHDrBsIaL+C0BYJ5+2Jyc43bdnah7mq3X9Z4
	 mMN+lSXO4zEIFOHc0OZS39Fa6qdGjXZlxzPJhtiz255dotoMkRObfIyb5Ru+XP5ROH
	 afoCqSZmyOXYNpzGmOHw294UkIdnp3kOx+JfcTNE=
Date: Fri, 22 Mar 2024 14:00:14 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix power line control for
 Shine-Optics Camera
Message-ID: <20240322120014.GC31979@pendragon.ideasonboard.com>
References: <20240108-shine-v2-1-ddff959dab89@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108-shine-v2-1-ddff959dab89@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Mon, Jan 08, 2024 at 02:04:16PM +0000, Ricardo Ribalda wrote:
> The device does not implement the power line frequency control
> correctly. It is a UVC 1.5 device, but implements the control as a UVC
> 1.1 device.
> 
> Add the corresponding control mapping override.
> 
> Bus 003 Device 002: ID 3277:009e Shine-Optics Integrated Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x3277
>   idProduct          0x009e
>   bcdDevice            0.01
>   iManufacturer           3 Shine-Optics
>   iProduct                1 Integrated Camera
>   iSerial                 2 0001
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v2:
> - Fix camera name in subject
> - Link to v1: https://lore.kernel.org/r/20240108-shine-v1-1-9d7b03a1a901@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..ceca1addd7e0 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3012,6 +3012,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> +	/* Shine-Optics Integrated Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x3277,
> +	  .idProduct		= 0x009e,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
>  	/* Acer EasyCamera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240108-shine-06c600d17a2a
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 

-- 
Regards,

Laurent Pinchart

