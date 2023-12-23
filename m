Return-Path: <linux-kernel+bounces-10576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7681D668
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D93EB22129
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C8208C0;
	Sat, 23 Dec 2023 20:01:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E658920316
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 63711 invoked by uid 1000); 23 Dec 2023 15:01:22 -0500
Date: Sat, 23 Dec 2023 15:01:22 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: Add quirk for Logitech Rallybar
Message-ID: <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
References: <20231222-rallybar-v2-1-5849d62a9514@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222-rallybar-v2-1-5849d62a9514@chromium.org>

On Fri, Dec 22, 2023 at 10:55:49PM +0000, Ricardo Ribalda wrote:
> Logitech Rallybar devices, despite behaving as UVC camera, they have a
> different power management system than the rest of the other Logitech
> cameras.
> 
> USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
> device unusable.
> 
> These are the only two devices that have this behavior, and we do not
> have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
> create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
> quirk.
> 
> Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

Would it make more sense to do this inside the uvc driver instead of 
creating a new single-purpose list in the core?

Alan Stern

> Tested with a Rallybar Mini with an Acer Chromebook Spin 513
> ---
> Changes in v2:
> - Add Fixes tag
> - Add UVC maintainer as Cc
> - Link to v1: https://lore.kernel.org/r/20231222-rallybar-v1-1-82b2a4d3106f@chromium.org
> ---
>  drivers/usb/core/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 15e9bd180a1d..8fa8de50e7f0 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -553,6 +553,14 @@ static const struct usb_device_id usb_interface_quirk_list[] = {
>  	{ }  /* terminating entry must be last */
>  };
>  
> +static const struct usb_device_id usb_interface_unsupported_quirk_list[] = {
> +	/* Logitech Rallybar VC systems*/
> +	{ USB_DEVICE(0x046d, 0x089b), .driver_info = USB_QUIRK_RESET_RESUME },
> +	{ USB_DEVICE(0x046d, 0x08d3), .driver_info = USB_QUIRK_RESET_RESUME },
> +
> +	{ }  /* terminating entry must be last */
> +};
> +
>  static const struct usb_device_id usb_amd_resume_quirk_list[] = {
>  	/* Lenovo Mouse with Pixart controller */
>  	{ USB_DEVICE(0x17ef, 0x602e), .driver_info = USB_QUIRK_RESET_RESUME },
> @@ -718,6 +726,8 @@ void usb_detect_interface_quirks(struct usb_device *udev)
>  	u32 quirks;
>  
>  	quirks = usb_detect_static_quirks(udev, usb_interface_quirk_list);
> +	quirks &= ~usb_detect_static_quirks(udev,
> +					usb_interface_unsupported_quirk_list);
>  	if (quirks == 0)
>  		return;
>  
> 
> ---
> base-commit: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
> change-id: 20231222-rallybar-19ce0c64d5e6
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 

