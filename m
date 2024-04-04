Return-Path: <linux-kernel+bounces-130808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29480897D53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D2F1F25EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F669BE71;
	Thu,  4 Apr 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uENpXcX8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CC28F5;
	Thu,  4 Apr 2024 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193094; cv=none; b=d1DSykoa/fgK268yaUFlyxZlbW5qR8pf2p98rMpTUwslw8rDHlaLvu9tjTV4o7ma/vyUqRnUyoGQsFjkfkjI6vqCgBR1/US0COPO1hVQi1f/pyhpbKm1ew9jmDvFHO1dA5b//wK47sGE1AU+UMJYbBFMCHmcOoc5i1ojzrmmfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193094; c=relaxed/simple;
	bh=J7A8PN5wuZBV1TfL2Rk8R9fDGmF9fMdEqF4s6QCA04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7r/R64WIoEScQxtFEgNdJ/awn8CCDHil4DktnNMLVeKL8lA8E+g44r/EwoR7KJmztPE6/ejVikjmfRgb64Y9wJBLMwHmhw8DfUj8jTrsy/PHZ5dySUbASbblhmVav65NmdhLF46L3JTBtBBqDewiwDkWPL4aFAvDMJPGMX/8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uENpXcX8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 76EF5497;
	Thu,  4 Apr 2024 03:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712193053;
	bh=J7A8PN5wuZBV1TfL2Rk8R9fDGmF9fMdEqF4s6QCA04A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uENpXcX8VK2/0Uzr7fzR2mGdN6GLgXQUAEStarPMihUYWr4Mh5u3aWx1SrAkzAkJW
	 MYkTkIGdBh8UtzD1NWHinftKMnvNg4Lz39JzJPkc5akpUQ9WgD2ojSbIZwmaYGPA+Y
	 bgTGBZZsJTVzQR92fLQU+tdHrDj+IJzmMXJVXxV4=
Date: Thu, 4 Apr 2024 04:11:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"hn.chen" <hn.chen@sunplusit.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] media/uvcvideo: add quirk for invalid dev_sof in
 Logitech C920
Message-ID: <20240404011120.GH23803@pendragon.ideasonboard.com>
References: <20240325142611.15550-1-oleksandr@natalenko.name>
 <6046664.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6046664.lOV4Wx5bFT@natalenko.name>

Hi Oleksandr,

On Mon, Apr 01, 2024 at 06:45:16PM +0200, Oleksandr Natalenko wrote:
> On pondělí 25. března 2024 15:26:11, CEST Oleksandr Natalenko wrote:
> > Similarly to Logitech C922, C920 seems to also suffer from a firmware
> > bug that breaks hardware timestamping.
> > 
> > Add a quirk for this camera model too.
> > 
> > Before applying the quirk:
> > 
> > ```
> > 100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/SoE
> > 101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/SoE
> > 102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/SoE
> > 103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/SoE
> > 104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/SoE
> > 105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/SoE
> > 106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/SoE
> > …
> > ```
> > 
> > After applying the quirk:
> > 
> > ```
> > 154 (2) [-] none 154 192417 B 42.199823 42.207788 27.779 fps ts mono/SoE
> > 155 (3) [-] none 155 192040 B 42.231834 42.239791 31.239 fps ts mono/SoE
> > 156 (4) [-] none 156 192213 B 42.263823 42.271822 31.261 fps ts mono/SoE
> > 157 (5) [-] none 157 191981 B 42.299824 42.303827 27.777 fps ts mono/SoE
> > 158 (6) [-] none 158 191953 B 42.331835 42.339811 31.239 fps ts mono/SoE
> > 159 (7) [-] none 159 191904 B 42.363824 42.371813 31.261 fps ts mono/SoE
> > 160 (0) [-] none 160 192210 B 42.399834 42.407801 27.770 fps ts mono/SoE
> > ```
> > 
> > Link: https://lore.kernel.org/lkml/5764213.DvuYhMxLoT@natalenko.name/
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 723e6d5680c2e..444d7089885ea 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2573,7 +2573,8 @@ static const struct usb_device_id uvc_ids[] = {
> >  	  .bInterfaceClass	= USB_CLASS_VIDEO,
> >  	  .bInterfaceSubClass	= 1,
> >  	  .bInterfaceProtocol	= 0,
> > -	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> > +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT
> > +					       | UVC_QUIRK_INVALID_DEVICE_SOF) },
> >  	/* Logitech HD Pro Webcam C922 */
> >  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> >  				| USB_DEVICE_ID_MATCH_INT_INFO,
> > 
> 
> Gentle ping on this one.

Ricardo, could you include this in the next version of your hw timestamp
series ?

> Also, should I have added:
> 
> Fixes: 5d0fd3c806b9 ("[media] uvcvideo: Disable hardware timestamps by default")
> 
> ?

I don't think that's needed, no.

> (it's not that this change re-enables HW timestamping, but
> 5d0fd3c806b9 explicitly mentions C920 as affected)

-- 
Regards,

Laurent Pinchart

