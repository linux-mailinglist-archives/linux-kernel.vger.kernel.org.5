Return-Path: <linux-kernel+bounces-72494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6FC85B433
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F5BB20DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4D5C5F7;
	Tue, 20 Feb 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsHBV/H/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035B5BAFA;
	Tue, 20 Feb 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415252; cv=none; b=plstIByNz7f20Yl4knfYxu5PUaUOCCLnI+0NgGS2OgVcoQXaPiUO5SXKxkXs+jIqFnbLIcTbSYbcbxRTgvgYXjrQ0gpAX3OH1A8e+Flbn6yxlLhrCH+fWAnFvFJlYU5Vd9k3psprrI9LTeo7nlngtt47JeEn2530LMHw0IHD76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415252; c=relaxed/simple;
	bh=KD9IThA8REpHAfectdfIHbypkggASN/O0p4hx3l4Q2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCp6PoJynjV2iQsml951h3JZYzWhZYDijL5aA1ieNeZ24aqPIg1HeGNX/Uo6+xyHrcP30hRqJlA4jC4nSPSjHjbqA+zBCieAYpOu80QLNwagr36G5Fz8aNLitqbwNtWeaINNYns8yPXpdRhjMPP770suaA2JpKqLnk6boYM3pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsHBV/H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF89C43390;
	Tue, 20 Feb 2024 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708415251;
	bh=KD9IThA8REpHAfectdfIHbypkggASN/O0p4hx3l4Q2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsHBV/H/zCd3DaFr8RRSkbOOU5/yEeZ7vG2zoIUUCoueVIQa3SljAGCF48C34+Z6W
	 /UJ1BEPg4BILsJNFAB0hNf9ro/cvwdssj5PLJOWalM8jeJ572qOjUrm8ztq5tnx/uF
	 ipPWl4PgZRIDkI95zhLdAPz2tVksVMBetP0VVM2M=
Date: Tue, 20 Feb 2024 08:47:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: buckzhangwh@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:usb:disable usb hub&port async suspend to avoid
 block system PM
Message-ID: <2024022023-anemic-icy-6f3d@gregkh>
References: <20240220072413.4026-1-buckzhangwh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220072413.4026-1-buckzhangwh@gmail.com>

On Mon, Feb 19, 2024 at 11:24:13PM -0800, buckzhangwh@gmail.com wrote:
> From: weihui zhang <buckzhangwh@gmail.com>
> 
> many phones are crashed and unable to wake up by power key.
> We analyzed more than ten kernel-dumps, 

Odd trailing whitespace :(

> the common was  that system were all blocked by usb.
> the phone doesn't crash again,after we disable usb hub&port async suspend.

That's not ok to disable, why is this needed?


> 
> here is one kernel-dump analysis case:
> task 446 & 4511 &365 state are Uninterrupt
> task 446 dpm_wait_for_superior then schedule out.
> 
> PID: 446  TASK: ffffff81f3e9cb00 CPU: 4 COMMAND: "charge"
> 
>  #0 [ffffffc015a0b9a0] __switch_to at ffffffc010088b54
> 
>  #1 [ffffffc015a0b9f0] __schedule at ffffffc010f7ef2c
> 
>  #2 [ffffffc015a0ba40] schedule at ffffffc010f7f3a4
> 
>  #3 [ffffffc015a0baa0] async_synchronize_cookie_domain at 
> 
>  #4 [ffffffc015a0bb00] async_synchronize_full at ffffffc010131e0c
> 
>  #5 [ffffffc015a0bb10] dpm_resume at ffffffc0107ec408
> 
>  #6 [ffffffc015a0bb70] dpm_resume_end at ffffffc0107ed0e8
> 
>  #7 [ffffffc015a0bbb0] suspend_devices_and_enter at ffffffc0101776d8
> 
>  #8 [ffffffc015a0bbf0] enter_state at ffffffc010177e70
> 
>  #9 [ffffffc015a0bc20] pm_suspend at ffffffc010177d5c
> 
> PID: 4511 TASK: ffffff8153b0e740 CPU: 6 COMMAND: "kworker/u16:11"
> 
>  #0 [ffffffc01bc9baa0] __switch_to at ffffffc01010293c
> 
>  #1 [ffffffc01bc9bb10] __schedule at ffffffc0116b0008
> 
>  #2 [ffffffc01bc9bb70] schedule at ffffffc0116b0794
> 
>  #3 [ffffffc01bc9bbe0] schedule_timeout at ffffffc0116b6c2c
> 
>  #4 [ffffffc01bc9bc40] wait_for_common at ffffffc0116b198c
> 
>  #5 [ffffffc01bc9bca0] dpm_wait_for_superior at ffffffc010b999e8  
> 
>  #6 [ffffffc01bc9bce0] device_resume at ffffffc010b9d804 
> //x0(struct device)= ffffff81f32a3808
> 
>  #7 [ffffffc01bc9bd10] async_resume at ffffffc010b9d6ec
> 
>  #8 [ffffffc01bc9bd40] async_run_entry_fn at ffffffc0101e238c
> 
>  #9 [ffffffc01bc9bdb0] process_one_work at ffffffc0101d00e0
> 
> crash_arm64> struct device ffffff81f32a3808 -x
> 
> struct device {
> 
>   kobj = {
> 
>     name = 0xffffff81f15c6d80 "usb1-port1",
> 
>     entry = {
> 
>       next = 0xffffff81f32a6018,
> 
>       prev = 0xffffff81e4103838
> 
>     },
>  type = 0xffffffc0124102b8 <usb_port_device_type>,
> 
>   bus = 0x0,
> 
>   driver = 0xffffffc0124102e8 <usb_port_driver>,
> 
>     async_suspend = 0x1,
>   ...........

All of the changelog text has extra lines?  Well some of them do, why?

Please fix that up.

> 
> PID: 365 TASK: ffffff81f3bf6900 CPU: 0 COMMAND: "kworker/u16:5"
> 
>  #0 [ffffffc0158dbac0] __switch_to at ffffffc010088b54
> 
>  #1 [ffffffc0158dbb10] __schedule at ffffffc010f7ef2c
> 
>  #2 [ffffffc0158dbb60] schedule at ffffffc010f7f3a4
> 
>  #3 [ffffffc0158dbbe0] schedule_timeout at ffffffc010f83fd8
> 
>  #4 [ffffffc0158dbc40] wait_for_common at ffffffc010f80600
> 
>  #5 [ffffffc0158dbc90] wait_for_completion at ffffffc010f8051c
> 
>  #6 [ffffffc0158dbcb0] dpm_wait_for_superior at ffffffc0107eee00
> 
>  #7 [ffffffc0158dbd00] device_resume at ffffffc0107ec6a8 
> //x0(struct device) = 0xffffff81ee1b3030
> 
>  #8 [ffffffc0158dbd40] async_resume at ffffffc0107ec588
> 
>  #9 [ffffffc0158dbd60] async_run_entry_fn at ffffffc010131c60
> 
>  crash_arm64> struct device ffffff81ee1b3030 -x
> 
> struct device {
> 
>   kobj = {
> 
>     name = 0xffffff81f1fc1500 "1-0:1.0",
> 
> 	  type = 0xffffffc011b62a38 <usb_if_device_type>,
>  ............

I don't understand, why the kobject structure stuff here?


> 
> Signed-off-by: weihui zhang <buckzhangwh@gmail.com>
> ---
>  drivers/usb/core/hub.c     | 2 +-
>  drivers/usb/core/message.c | 2 +-
>  drivers/usb/core/port.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
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

Why?  You just changed the way the whole system worked?

Are you sure that the device itself shouldn't be fixed instead of doing
this for ALL devices?

>  
>  	/* check whether the hub or firmware marks this port as non-removable */
>  	set_usb_port_removable(udev);
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 077dfe48d..944f01aa7 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2203,7 +2203,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  			"adding %s (config #%d, interface %d)\n",
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
> -		device_enable_async_suspend(&intf->dev);
> +		device_disable_async_suspend(&intf->dev);
>  		ret = device_add(&intf->dev);
>  		if (ret != 0) {
>  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
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

Again, I don't think this is a wise change, how did you test it?

thanks,

greg k-h

