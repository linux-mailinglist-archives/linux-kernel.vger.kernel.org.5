Return-Path: <linux-kernel+bounces-939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291081484A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44501C21C66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF32C6AB;
	Fri, 15 Dec 2023 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oift66yL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6972DB6F;
	Fri, 15 Dec 2023 12:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D637C433C8;
	Fri, 15 Dec 2023 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702644059;
	bh=H5vSnFV7lt8AZLObSg4tyj2EUOKsSjouP970nDGMkbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oift66yLi2kgVZWCqJIbdxJ0IPCj2z4/h1jbGxhZvbg3m0tubNvAzKCk1TAXx9DHc
	 SKPqGJ9me6ZoomoBysmKoAnH9VTDvV4GDdSNe6n2ckm0MttGaXYyJdwHOLJcZTO5Vk
	 crQdlzR5nGV+QVw7S5Zrb3YacGANSRFm5pf6o8Zo=
Date: Fri, 15 Dec 2023 13:40:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	wg@grandegger.com, mkl@pengutronix.de, aspriel@gmail.com,
	franky.lin@broadcom.com, hante.meuleman@broadcom.com,
	kvalo@kernel.org, briannorris@chromium.org, mka@chromium.org,
	johan@kernel.org, oneukum@suse.com, stern@rowland.harvard.edu,
	valentina.manea.m@gmail.com, shuah@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: Use device_driver directly in struct
 usb_driver and usb_device_driver
Message-ID: <2023121505-dexterity-rectal-8898@gregkh>
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

Yes.

> We can compare that if 'drv->probe' is equal to usb_probe_device instead
> of using for_devices in is_usb_device_driver().

Why?

> Remove struct usbdrv_wrap, use device_driver directly in struct usb_driver
> and usb_device_driver. This makes the code more concise.

Really?  What does this help out with?  Are there future changes that
require this?

I'm all for cleanups, but I don't see what this helps with.

Also, you have a coding style issue in this patch, which means I
couldn't take it anyway:

> +extern int usb_probe_device(struct device *dev);

We don't do that in .c files :(

thanks,

greg k-h

