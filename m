Return-Path: <linux-kernel+bounces-19761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7515D8272FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043A3B2137E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375535101B;
	Mon,  8 Jan 2024 15:26:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CE1C451010
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 499378 invoked by uid 1000); 8 Jan 2024 10:26:07 -0500
Date: Mon, 8 Jan 2024 10:26:07 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: Prevent null pointer dereference in
 update_port_device_state
Message-ID: <2d801dd7-93de-4323-a214-1a73cc5a8451@rowland.harvard.edu>
References: <20240108130706.15698-1-quic_ugoswami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108130706.15698-1-quic_ugoswami@quicinc.com>

On Mon, Jan 08, 2024 at 06:37:06PM +0530, Udipto Goswami wrote:
> Currently,the function update_port_device_state gets the usb_hub from
> udev->parent by calling usb_hub_to_struct_hub.
> However, in case the actconfig or the maxchild is 0, the usb_hub would
> be NULL and upon further accessing to get port_dev would result in null
> pointer dereference.
> 
> Fix this by introducing an if check after the usb_hub is populated.
> 
> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
> v2: Introduced comment for the if check & CC'ed stable.
> 
>  drivers/usb/core/hub.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index ffd7c99e24a3..d40b5500f95b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2053,9 +2053,18 @@ static void update_port_device_state(struct usb_device *udev)
>  
>  	if (udev->parent) {
>  		hub = usb_hub_to_struct_hub(udev->parent);
> -		port_dev = hub->ports[udev->portnum - 1];
> -		WRITE_ONCE(port_dev->state, udev->state);
> -		sysfs_notify_dirent(port_dev->state_kn);
> +
> +		/*
> +		 * usb_hub_to_struct_hub() if returns NULL can
> +		 * potentially cause NULL pointer dereference upon further
> +		 * access.
> +		 * Avoid this with an if check.
> +		 */

This is not what I meant.  It's perfectly obvious that if 
usb_hub_to_struct_hub() returns NULL then there will be a NULL-pointer 
dereference.  You don't need to explain that to anybody.

Instead, you need to explain why it is _possible_ for 
usb_hub_to_struct_hub() to return NULL.  The reason is because the 
lvstest driver messes around with usbcore internals without telling the 
hub driver, so hub will be NULL in cases where udev was created by 
lvstest.

Alan Stern

