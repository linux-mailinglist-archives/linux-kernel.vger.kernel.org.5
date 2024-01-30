Return-Path: <linux-kernel+bounces-44965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F788429B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB59B2B287
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC986AF1;
	Tue, 30 Jan 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGS3aFMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB9364D6;
	Tue, 30 Jan 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632867; cv=none; b=WR5BHrTRP7apf1V7JzliOTXBGkbcHG6d/C7gwtvrCcesnsUnMSlDCVRCERm4QBcHZLo1Ef7Na4QU7OoFXY3bUBIwEX3Sc6BPkZyT4r8lyckNCbAAeYc2TZxejBBH6nMAKCHR1bYkuZU5+q7J2U9ajOUHCkGp+h0WS9ViH/U1jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632867; c=relaxed/simple;
	bh=hw3BLY0wIeEGZGM9UVDCefwxIvj4sbE4suTDvWy8Zm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D17r8xG9YtVxaeSzq+UA7TinZtCFn69K3LBliRlkkb+NDjN3n7mowsZqcjNWLJst77n02MBelkDaHwZizF6Xjuc5K5loJnZjzfTeZJTc3QOA51EeUekggL768oWl52u29EGtUOz9sHyNT/T0ikq5bkLJdhEgJa/utwday+eD6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGS3aFMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2904C433F1;
	Tue, 30 Jan 2024 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632866;
	bh=hw3BLY0wIeEGZGM9UVDCefwxIvj4sbE4suTDvWy8Zm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGS3aFMF+w36TIg9TeFxAtSAuXyvBbtnO2F3d9C7yKaZjkRuTBu6+P9gAEscD5MLE
	 7X8FH6Ij24mVW5Tf9DnxrP8dq7Ts8ezxyg0o7OYUf//cPGA0TfsNLkjrXzJx6XQu/r
	 rx4KZI4T40MQooRy8VfOw9rZiD09KvEO306vYQec=
Date: Tue, 30 Jan 2024 08:41:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu, royluo@google.com,
	hadess@hadess.net, benjamin.tissoires@redhat.com,
	heikki.krogerus@linux.intel.com, oneukum@suse.com,
	grundler@chromium.org, yajun.deng@linux.dev, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, albertccwang@google.com, pumahsu@google.com
Subject: Re: [PATCH] [RFC] usb: host: Allow userspace to control usb suspend
 flows
Message-ID: <2024013056-fidelity-sandy-0353@gregkh>
References: <20240130064819.1362642-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130064819.1362642-1-guanyulin@google.com>

On Tue, Jan 30, 2024 at 06:47:13AM +0000, Guan-Yu Lin wrote:
> In a system with sub-system engaged, the controllers are controlled by
> both the main processor and the co-processor. Chances are when the main
> processor decides to suspend the USB device, the USB device might still
> be used by the co-processor. In this scenario, we need a way to let
> system know whether it can suspend the USB device or not. We introduce a
> new sysfs entry "deprecate_device_pm" to allow userspace to control the
> device power management functionality on demand. As the userspace should
> possess the information of both the main processor and the co-processor,
> it should be able to address the conflict mentioned above.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 10 +++++++++
>  drivers/usb/core/driver.c               | 18 ++++++++++++++++
>  drivers/usb/core/sysfs.c                | 28 +++++++++++++++++++++++++
>  drivers/usb/host/xhci-plat.c            | 20 ++++++++++++++++++
>  include/linux/usb.h                     |  4 ++++
>  5 files changed, 80 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 2b7108e21977..3f3d6c14201f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -19,6 +19,16 @@ Description:
>  		would be authorized by default.
>  		The value can be 1 or 0. It's by default 1.
>  
> +What:		/sys/bus/usb/devices/usbX/deprecate_device_pm
> +Date:		January 2024
> +Contact:	Guan-Yu Lin <guanyulin@google.com>
> +Description:
> +		Deprecates the device power management functionality of USB devices
> +		and their host contorller under this usb bus. The modification of
> +		this entry should be done when the system is active to ensure the
> +		correctness of system power state transitions.
> +		The value can be 1 or 0. It's by default 0.
> +
>  What:		/sys/bus/usb/device/.../authorized
>  Date:		July 2008
>  KernelVersion:	2.6.26
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index e02ba15f6e34..e03cf972160d 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1569,6 +1569,15 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +	/*
> +	 * Skip the entire suspend process under the same usb bus if its sysfs
> +	 * entry `deprecate_device_pm` is set.
> +	 */
> +	if (udev->bus->deprecate_device_pm) {
> +		dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __func__);

Nit, dev_dbg() already contains __func__ by default, so no need for that
at all.  And please use dev_dbg(), why are you using dev_vdbg()?

> +		return 0;
> +	}
> +
>  	unbind_no_pm_drivers_interfaces(udev);
>  
>  	/* From now on we are sure all drivers support suspend/resume
> @@ -1605,6 +1614,15 @@ int usb_resume(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int			status;
>  
> +	/*
> +	 * Skip the entire resume process under the same usb bus if its sysfs
> +	 * entry `deprecate_device_pm` is set.
> +	 */
> +	if (udev->bus->deprecate_device_pm) {
> +		dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __func__);

Same as above.  And for all other instances you added.

> +static ssize_t deprecate_device_pm_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct usb_device	*udev = to_usb_device(dev);
> +	int			val, rc;
> +
> +	if (sscanf(buf, "%d", &val) != 1 || val < 0 || val > 1)
> +		return -EINVAL;

Please use the builtin function for determining if a boolean has been
written through sysfs, don't roll your own.

Note, these are just cosmetic things, I'm not taking the time yet to
comment on the contents here, I'll let others do that first :)

thanks,

greg k-h

