Return-Path: <linux-kernel+bounces-1233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4E814C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E628B2818CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55B381C5;
	Fri, 15 Dec 2023 15:50:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D0A783716F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 275031 invoked by uid 1000); 15 Dec 2023 10:50:19 -0500
Date: Fri, 15 Dec 2023 10:50:19 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: gregkh@linuxfoundation.org, marcel@holtmann.org, johan.hedberg@gmail.com,
  luiz.dentz@gmail.com, wg@grandegger.com, mkl@pengutronix.de,
  aspriel@gmail.com, franky.lin@broadcom.com, hante.meuleman@broadcom.com,
  kvalo@kernel.org, briannorris@chromium.org, mka@chromium.org,
  johan@kernel.org, oneukum@suse.com, valentina.manea.m@gmail.com,
  shuah@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: Use device_driver directly in struct
 usb_driver and usb_device_driver
Message-ID: <d4a6b988-c938-4f2a-8815-9b4f1e7f338f@rowland.harvard.edu>
References: <20231215063101.792991-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215063101.792991-1-yajun.deng@linux.dev>

On Fri, Dec 15, 2023 at 02:31:01PM +0800, Yajun Deng wrote:
> There is usbdrv_wrap in struct usb_driver and usb_device_driver,
> it contains device_driver and for_devices. for_devices is used to
> distinguish between device drivers and interface drivers.
> 
> We can compare that if 'drv->probe' is equal to usb_probe_device instead
> of using for_devices in is_usb_device_driver().
> 
> Remove struct usbdrv_wrap, use device_driver directly in struct usb_driver
> and usb_device_driver. This makes the code more concise.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

However you should simplify the new test:

> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -176,11 +176,12 @@ static inline int is_root_hub(struct usb_device *udev)
>  }
>  
>  /* Do the same for device drivers and interface drivers. */
> -
> +extern int usb_probe_device(struct device *dev);
>  static inline int is_usb_device_driver(struct device_driver *drv)
>  {
> -	return container_of(drv, struct usbdrv_wrap, driver)->
> -			for_devices;
> +	if (drv->probe == usb_probe_device)
> +		return 1;
> +	return 0;
>  }

This should just be:

	return drv->probe == usb_probe_device;

Alan Stern

