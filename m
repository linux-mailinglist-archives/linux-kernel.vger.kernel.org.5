Return-Path: <linux-kernel+bounces-16956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E4824680
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E245B23CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422952555C;
	Thu,  4 Jan 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7IZU/gW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AF250F1;
	Thu,  4 Jan 2024 16:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CBC433C8;
	Thu,  4 Jan 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704386517;
	bh=Ym8uX/Uf+LH1aEhgFAE+qkHEAf38+34oIYKfCtWPA9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w7IZU/gWh/MLLjezsKW7nPjT0isyn5eAFWzRNmGuvmGTcA6OzIMypnYgqTSmbBo3i
	 tEU794K1697ZfgI6sUgzXRXgz4lQ2yzakBxISzXGkip/pzXLRjOcEJlZaLr2b/Qre+
	 T5myvZbcwRTAsvfr8YHu7yy90X7U6bxJaXOG5Keg=
Date: Thu, 4 Jan 2024 17:41:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: niko.mauno@vaisala.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Make default authorization mode configurable
Message-ID: <2024010413-portable-lingo-3c11@gregkh>
References: <20240104163203.7381-1-niko.mauno@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163203.7381-1-niko.mauno@vaisala.com>

On Thu, Jan 04, 2024 at 06:32:03PM +0200, niko.mauno@vaisala.com wrote:
> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> Make the default USB device authorization mode configurable at build
> time. This is useful for systems that require a mode that is stricter
> than the standard setting, as it avoids relying on the kernel command
> line being properly set.
> 
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---
>  drivers/usb/core/Kconfig | 15 +++++++++++++++
>  drivers/usb/core/hcd.c   |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 351ede4b5de2..10ad320cc2f3 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -116,3 +116,18 @@ config USB_AUTOSUSPEND_DELAY
>  	  The default value Linux has always had is 2 seconds.  Change
>  	  this value if you want a different delay and cannot modify
>  	  the command line or module parameter.
> +
> +config USB_DEFAULT_AUTHORIZATION_MODE
> +	int "Default authorization mode for USB devices"
> +	range -1 2
> +	default -1
> +	depends on USB
> +	help
> +	  Select the default USB device authorization mode. Can be overridden
> +	  with usbcore.authorized_default command line or module parameter.
> +
> +	  The available values have the following meanings:
> +		-1 is authorized for all devices (leftover from wireless USB)
> +		0 is unauthorized for all devices
> +		1 is authorized for all devices

What's the difference now between -1 and 1?  We don't have wireless USB
anymore as that never turned into an actual product, so we shouldn't
reference it anymore, right?

We should get rid of the -1 option entirely, but keep the module option
and properly map it to '1'.


> +		2 is authorized for internal devices

Needs a "if you don't know what to select, please choose X" text here.

thanks,

greg k-h

