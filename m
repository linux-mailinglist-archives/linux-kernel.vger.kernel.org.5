Return-Path: <linux-kernel+bounces-23944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626982B441
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B377FB2629F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3099524DA;
	Thu, 11 Jan 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/g+FFK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7C3A1BE;
	Thu, 11 Jan 2024 17:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A20C433C7;
	Thu, 11 Jan 2024 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704994839;
	bh=YpwQWCnVnBBUqaWv4bCZdTrssGsplr32Ot76UMUI56k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/g+FFK6nTrDAxLRA+VBZOpXbMiBXYh+19KibTOdCTjWQbuON45UT/bze6yen1iVf
	 bmBp7ToVw35MTC/kLxOiPIZ2sPXb1eF1kbe3CIHDZUUhpNlEeOKrMI8kexAny/B6ML
	 jAg7by1QGy6GIDBr0wwu9/P831XSc643oHzfU/KcLSidmUWLt4ulseGO3NqwduuNYQ
	 kc0iub6ufQd1TgzmSGnQCoOrAWGyvB4yNP7srNINsnJE/mUyMgzNAHPepDY/cInZqJ
	 L8XEXFDlJpogAzsNPkf8L+wdtCxZu60LnO3yo3GDnwI/HoMzoJQFqgAWs/N+m9CCJ+
	 Gw3oql/C8a4zw==
Date: Thu, 11 Jan 2024 18:40:35 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: em28xx: return error on media_device_register()
 failure
Message-ID: <20240111184035.18a6ad4b@coco.lan>
In-Reply-To: <b7ca60c4-2392-448e-90e4-5078051d7af6@fintech.ru>
References: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
	<20240111074905.67d61b00@coco.lan>
	<b7ca60c4-2392-448e-90e4-5078051d7af6@fintech.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 11 Jan 2024 07:10:10 -0800
Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:

> On 1/10/24 22:49, Mauro Carvalho Chehab wrote:
> > Em Wed, 10 Jan 2024 09:39:58 -0800
> > Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:
> >   
> >> In an unlikely case of failure in media_device_register(), release
> >> resources and return the erroneous value. Otherwise, possible issues
> >> with registering the device will continue to be ignored.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with static
> >> analysis tool SVACE.
> >>
> >> Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
> >> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> >> ---
> >>  drivers/media/usb/em28xx/em28xx-cards.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> >> index 4d037c92af7c..dae731dfc569 100644
> >> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> >> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> >> @@ -4095,6 +4095,8 @@ static int em28xx_usb_probe(struct usb_interface *intf,
> >>  	 */
> >>  #ifdef CONFIG_MEDIA_CONTROLLER
> >>  	retval = media_device_register(dev->media_dev);
> >> +	if (retval)
> >> +		goto err_free;  
> > 
> > Not freeing resources here is intentional. See, the media controller 
> > API is optional on this driver. It will just provide a way to identify
> > the device's topology, but the device is completely usable without
> > it.
> > 
> > Perhaps we need, instead, a patch documenting it, and preventing
> > static analysis tools to point it as an issue.
> > 
> > Thanks,
> > Mauro  
> 
> Thank you for your feedback, however I had a few questions...
> 
> While I understand what you mean about optional nature of media
> controller registration in this case, a quick glance into other calls to
> media_device_register() across the source code shows that usually
> failure with registering is handled as a proper error regardless of
> whether the device is still usable. But if you think that we can make an
> exception here, I'll happily oblige.

It depends on how the actual device is controlled. "Normal"
media devices are fully controlled via v4l2 API. On those, the
media controller API is there just to let userspace to query
about the internal settings, but the actual pipelines are
created via V4L2 API. Almost all normal applications will
just ignore the media controller API.

Embedded hardware, however, require setting pipelines via media 
controller for they to actually work. Almost all drivers
implementing the media controller API fall on this category.

> 
> Then if I am to continue on this path, would the following comment above
> the call to media_device_register() suffice?
> 
>  #ifdef CONFIG_MEDIA_CONTROLLER
> +	/*
> +	 * No need to check the return value, the device will still be 	     +
>  * usable without media controller API.
> +	 */
>  	retval = media_device_register(dev->media_dev);

That works for me. It would still produce alerts at static
analyzers, as they'll notice that we're storing retval there
without actually using it.

Thanks,
Mauro

