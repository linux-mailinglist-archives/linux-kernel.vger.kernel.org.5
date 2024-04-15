Return-Path: <linux-kernel+bounces-145077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FB8A4F37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C61F21AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC56F515;
	Mon, 15 Apr 2024 12:38:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818535CDD9;
	Mon, 15 Apr 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184688; cv=none; b=a0T031E+99MMUUKzM3/3+fdWKMnMu5ZGSBgFjRZBGwwUFHSxOKgYoQKBFvtUJYB0CPs8Ilhgm9NmDkzVOInudKxuTeIMxEGoD1OY/hSLYzIrqrm2TWb93cd1Ay7ELNrRknDhnqxeM1HS4JOg/TV0MzCaL8nLaUANTVSqvee160A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184688; c=relaxed/simple;
	bh=w2bV1WOQV9E7abABHPykBMNAgiEoNt/pqr4lWLyjCcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqSmCJ860pYH5vFdvf2XvxjGSHL1tqQ9L3ySjLvkYOp0zRXB25At9d0icGcP242T2w5kMVhgC4jVOIF2fIIbdetCLX3pFmKYEfaCJXCHquH2EqyxLcg6suxcbGqo1fCyjikKpaZwu4uaOPFnmtTp1f7wdnpbaGAcSDUOBOCz7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C6C113CC;
	Mon, 15 Apr 2024 12:38:06 +0000 (UTC)
Message-ID: <abc944f1-997a-49b9-8b9e-aea4b53554ea@xs4all.nl>
Date: Mon, 15 Apr 2024 14:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: usb: siano: Fix allocation of urbs
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20240415-smatch-v3-1-ed3f23f9d5ee@chromium.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240415-smatch-v3-1-ed3f23f9d5ee@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 14:29, Ricardo Ribalda wrote:
> USB urbs must be allocated with usb_alloc_urb. Quoting the manual
> 
> Only use this function (usb_init_urb) if you _really_ understand what you
> are doing.
> 
> Fix the following smatch error:
> 
> drivers/media/usb/siano/smsusb.c:53:38: warning: array of flexible structures
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v3: Thanks Hans
> - Remove unneeded NULL assignment
> - Use the proper variable :)
> - Link to v2: https://lore.kernel.org/r/20240415-smatch-v2-1-65215936d398@chromium.org
> 
> Changes in v2: Thanks Hans
> - Only leave 1/6, the other ones are in another PR
> - Fix the return tag and NULLify the urbs on return
> - Link to v1: https://lore.kernel.org/r/20240410-smatch-v1-0-785d009a852b@chromium.org
> ---
>  drivers/media/usb/siano/smsusb.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
> index 723510520d09..ba2c02e1070e 100644
> --- a/drivers/media/usb/siano/smsusb.c
> +++ b/drivers/media/usb/siano/smsusb.c
> @@ -40,7 +40,7 @@ struct smsusb_urb_t {
>  	struct smscore_buffer_t *cb;
>  	struct smsusb_device_t *dev;
>  
> -	struct urb urb;
> +	struct urb *urb;
>  
>  	/* For the bottom half */
>  	struct work_struct wq;
> @@ -160,7 +160,7 @@ static int smsusb_submit_urb(struct smsusb_device_t *dev,
>  	}
>  
>  	usb_fill_bulk_urb(
> -		&surb->urb,
> +		surb->urb,
>  		dev->udev,
>  		usb_rcvbulkpipe(dev->udev, dev->in_ep),
>  		surb->cb->p,
> @@ -168,9 +168,9 @@ static int smsusb_submit_urb(struct smsusb_device_t *dev,
>  		smsusb_onresponse,
>  		surb
>  	);
> -	surb->urb.transfer_flags |= URB_FREE_BUFFER;
> +	surb->urb->transfer_flags |= URB_FREE_BUFFER;
>  
> -	return usb_submit_urb(&surb->urb, GFP_ATOMIC);
> +	return usb_submit_urb(surb->urb, GFP_ATOMIC);
>  }
>  
>  static void smsusb_stop_streaming(struct smsusb_device_t *dev)
> @@ -178,7 +178,7 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
>  	int i;
>  
>  	for (i = 0; i < MAX_URBS; i++) {
> -		usb_kill_urb(&dev->surbs[i].urb);
> +		usb_kill_urb(dev->surbs[i].urb);
>  		if (dev->surbs[i].wq.func)
>  			cancel_work_sync(&dev->surbs[i].wq);
>  
> @@ -338,6 +338,8 @@ static void smsusb_term_device(struct usb_interface *intf)
>  	struct smsusb_device_t *dev = usb_get_intfdata(intf);
>  
>  	if (dev) {
> +		int i;
> +
>  		dev->state = SMSUSB_DISCONNECTED;
>  
>  		smsusb_stop_streaming(dev);
> @@ -346,6 +348,9 @@ static void smsusb_term_device(struct usb_interface *intf)
>  		if (dev->coredev)
>  			smscore_unregister_device(dev->coredev);
>  
> +		for (i = 0; i < MAX_URBS; i++)
> +			usb_free_urb(dev->surbs[i].urb);
> +
>  		pr_debug("device 0x%p destroyed\n", dev);
>  		kfree(dev);
>  	}
> @@ -390,6 +395,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
>  	void *mdev;
>  	int i, rc;
>  	int align = 0;
> +	int n_urb = 0;
>  
>  	/* create device object */
>  	dev = kzalloc(sizeof(struct smsusb_device_t), GFP_KERNEL);
> @@ -461,16 +467,18 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
>  	dev->coredev->is_usb_device = true;
>  
>  	/* initialize urbs */
> -	for (i = 0; i < MAX_URBS; i++) {
> -		dev->surbs[i].dev = dev;
> -		usb_init_urb(&dev->surbs[i].urb);
> +	for (n_urb = 0; n_urb < MAX_URBS; n_urb++) {
> +		dev->surbs[n_urb].dev = dev;
> +		dev->surbs[n_urb].urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!dev->surbs[n_urb].urb)
> +			goto free_urbs;
>  	}
>  
>  	pr_debug("smsusb_start_streaming(...).\n");
>  	rc = smsusb_start_streaming(dev);
>  	if (rc < 0) {
>  		pr_err("smsusb_start_streaming(...) failed\n");
> -		goto err_unregister_device;
> +		goto free_urbs;
>  	}
>  
>  	dev->state = SMSUSB_ACTIVE;
> @@ -478,13 +486,19 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
>  	rc = smscore_start_device(dev->coredev);
>  	if (rc < 0) {
>  		pr_err("smscore_start_device(...) failed\n");
> -		goto err_unregister_device;
> +		goto free_urbs;
>  	}
>  
>  	pr_debug("device 0x%p created\n", dev);
>  
>  	return rc;
>  
> +free_urbs:
> +	for (i = 0; i < n_urb; i++) {
> +		usb_free_urb(dev->surbs[i].urb);
> +		dev->surbs[i].urb = NULL;
> +	}
> +
>  err_unregister_device:
>  	smsusb_term_device(intf);

After re-reading the code, I see that smsusb_term_device() actually
frees all URBs. So the 'free_urbs' goto label is not needed, it can
go straight to err_unregister_device. A comment just above
the 'smsusb_term_device(intf);' line mentioning that it will free
any allocated urbs would be helpful, though.

Regards,

	Hans

>  #ifdef CONFIG_MEDIA_CONTROLLER_DVB
> 
> ---
> base-commit: 34d7bf1c8e59f5fbf438ee32c96389ebe41ca2e8
> change-id: 20240410-smatch-8f235d50753d
> 
> Best regards,


