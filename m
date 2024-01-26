Return-Path: <linux-kernel+bounces-40183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913883DBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5337C1C2385D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDB1C683;
	Fri, 26 Jan 2024 14:29:52 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AAABF1BDE0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279391; cv=none; b=mMiDecmLStM4sivi+OmXRp+4TOY11SShY4A9lik/ep89Q7rMFb9gu50IUa2F+nWM+WvR89Nc2kl7dHskWJ7qIxDE4/ltMWCh1p2MtxD00bMAdhICjQ7CL5ByTDO6SDucf9ph1z0NSrMqyCmNT89G0ogf8LfGxhLqLCFj1VmZLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279391; c=relaxed/simple;
	bh=th1zKaNSdPkD3kmeMrwoKj4+vtw3MMPyjegeZjcjQx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDOmLXaEyy/iZQnfwp4Qg3QkxH9FkFVwoQiYdOBnx9WOP+bH9H7ioGb7OXqv5Kb7rOnkdq4Q4QnYAmiRfPvewh1y5c8ntsgubEThpbCw79rCf2G8JvhaRCa/J792ghGKe1a67YyxHqrB9bG75GbQq4wwXOivjrmy6TVcUl4KooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 281702 invoked by uid 1000); 26 Jan 2024 09:29:41 -0500
Date: Fri, 26 Jan 2024 09:29:41 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ingyu Jang <ingyujang25@unist.ac.kr>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, ysjeon@unist.ac.kr
Subject: Re: [PATCH] Remove redundant check for usb_generic_driver_probe()
Message-ID: <42b7cfa2-5ebf-4ef3-9890-4633444bad50@rowland.harvard.edu>
References: <20240126120313.1362573-1-ingyujang25@unist.ac.kr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126120313.1362573-1-ingyujang25@unist.ac.kr>

On Fri, Jan 26, 2024 at 09:03:13PM +0900, Ingyu Jang wrote:
> usb_generic_driver_probe() only returns 0.
> Inside this function, there are only errors that are marked as not fatal.
> However, drivers/usb/core/driver.c:269 checks
> if usb_generic_driver_probe() returns error.
> No need to change usb_generic_driver_probe() to return error,
> only remove redundant error check.
> 
> Signed-off-by: Ingyu Jang <ingyujang25@unist.ac.kr>
> ---
>  drivers/usb/core/driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index e01b1913d02b..b6274580b7ca 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -266,8 +266,6 @@ static int usb_probe_device(struct device *dev)
>  
>  	if (udriver->generic_subclass)
>  		error = usb_generic_driver_probe(udev);
> -	if (error)
> -		return error;
>  
>  	/* Probe the USB device with the driver in hand, but only
>  	 * defer to a generic driver in case the current USB

Don't do this unless you add comments both here _and_ in 
usb_generic_driver_probe() explaining that the routine never returns 
anything but 0.  Otherwise, some day in the future someone will change 
the probe routine to make it return an error code, and won't realize 
that code here needs to be changed too.

Better yet, don't make this change at all.  It's a trivial matter and 
it's not on a hot path.

Alan Stern

