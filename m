Return-Path: <linux-kernel+bounces-84652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67286A994
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A815B22F87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CCC288D7;
	Wed, 28 Feb 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCFMSTNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC225630;
	Wed, 28 Feb 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107824; cv=none; b=FBk3AiTasa0nnl02E9RzC4/RhlHK7tix0164FidipDC0uZ7I0Ec9Evhl1bP7vIUjmQyW7VbtkMzQM+jlfP58vaHO7LYjoLhFEPoWG7OBNUEGfpdcVkYGTvO4V1g4Q5Q96efcusPI3Iz5EXzmhOVxbdvDbDraaOFRePmtP8GD/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107824; c=relaxed/simple;
	bh=5VutVpaVx3BCmDFWCvGkbB7mmJu+5yX0VMWEFfpDzd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv0Epj1owz5JXYLiPdL/KTfcohiIigO5V6LNNFEuWYD0vGQgD4B1JmCKK3nG49aqdyWWY9UaFaSmiHaiYbzVmTTvNQFs/vSMej/iNTZehK50G3CrctnNHsg9nRkcSXtH+oUZdtY9HdsJVw+dDQQ7r2VHanebguMdWAXCjgQKwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCFMSTNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2CDC433F1;
	Wed, 28 Feb 2024 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709107824;
	bh=5VutVpaVx3BCmDFWCvGkbB7mmJu+5yX0VMWEFfpDzd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCFMSTNz4uXPS3pW3XJknVG4hdfxE/VbO17Gzca1wjO4/QNu7MO0gm/iybMQECjyS
	 WWmA1Uyq/ofif9oKnS/uLYx0rtZYLSBUES/oNhzgiO8ZO3HVAt4IgDC0YhR/K8KmEe
	 +raIzodglHZsZYd1OXuLBT9z+a0MzMmbPzVcd54Y=
Date: Wed, 28 Feb 2024 09:10:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: buckzhangwh@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drivers:usb:disable usb hub&port async suspend
Message-ID: <2024022808-skies-unit-7309@gregkh>
References: <20240228072030.2470-1-buckzhangwh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228072030.2470-1-buckzhangwh@gmail.com>

On Tue, Feb 27, 2024 at 11:20:30PM -0800, buckzhangwh@gmail.com wrote:
> From: weihui zhang <buckzhangwh@gmail.com>
> 
> we prepare 30 mobile phones only for usb plugg in and out.
> testers plug USB in and out very frequently after phone in deep.
> Repeat the test again and again,some phones are crashed.
> our analysis：
> We analyze ten kernel-dumps,we found something common kernel is blocked.
> pasre in crash,all the dump are directed to usb(device port/hub).
> here is a kdump,task 446 &365&4511 are UN.
> 446:
> .... ->|kobj_attr_store
>           |state_store
>             |pm_suspend
>               |enter_state
>                 |suspend_devices_and_enter
>                  |dpm_resume_end
>                    |dpm_resume
>                     |dpm_resume
>                      |async_synchronize_full
>                       |async_synchronize_cookie_domain
>                        |schedule
> 446 is waiting for 365&4511,no doubtful usb thread.
> here is some warning log:
> [83.958310] musb device disconnect detected from VBUS GPIO.
> ..........
> [84.908017] musb device connection detected from VBUS GPIO.
> [84.911946] typec port1-partner: parent port1 should not be sleeping
> task 365 & 4511:
> ... ->worker_thread
>        |process_one_work
>         |async_run_entry_fn
>           |async_resume
>             |device_resume
>               |dpm_wait_for_superior
>                 |wait_for_completion
>                   |wait_for_common
>                      |schedule_timeout
> I guess usb async resume/suspend are disordered,So I try to disable.
> After that,we tested the case for a month,the bug never happened again.
> the fn device_enable_async_suspend set the dev->power.async_suspend= 1.
> dev->power.async_suspend=1&pm_async_enabled=1,fork task like 365
>    ---> dpm_resume
>            |dpm_async_fn
>              |async_resume  
> dev->power.async_suspend=0,disable async
>      --->dpm_resume
>             |device_resume
>               |call device resume fn.
> here is a demo:
> Only few devices such as scsi/pci/usb call device_enable_async_suspend.
> but scsi call device_disable_async_suspend at drivers/scsi/hosts.c
> 
> Signed-off-by: weihui zhang <buckzhangwh@gmail.com>
> ---
>  drivers/usb/core/hub.c  | 2 +-
>  drivers/usb/core/port.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index e38a4124f..de74f70e5 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2602,7 +2602,7 @@ int usb_new_device(struct usb_device *udev)
>  		add_device_randomness(udev->manufacturer,
>  				      strlen(udev->manufacturer));
>  
> -	device_enable_async_suspend(&udev->dev);
> +	device_disable_async_suspend(&udev->dev);
>  
>  	/* check whether the hub or firmware marks this port as non-removable */
>  	set_usb_port_removable(udev);
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index c628c1abc..97696c415 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -760,7 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  	pm_runtime_set_active(&port_dev->dev);
>  	pm_runtime_get_noresume(&port_dev->dev);
>  	pm_runtime_enable(&port_dev->dev);
> -	device_enable_async_suspend(&port_dev->dev);
> +	device_disable_async_suspend(&port_dev->dev);
>  
>  	/*
>  	 * Keep hidden the ability to enable port-poweroff if the hub
> -- 
> 2.17.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

