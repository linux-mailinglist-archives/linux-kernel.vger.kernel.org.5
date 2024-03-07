Return-Path: <linux-kernel+bounces-96025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7187563C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB20B23E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4B134CDB;
	Thu,  7 Mar 2024 18:42:58 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 20BD553804
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836978; cv=none; b=QqPpVzutSdCko6kj/rZ0UTeYzJS/P94pJXVa5T6lBTdEw9F911i7RvLx6qxeGAI9W5Fk0Na/7N6i4oqiYMtPbX6zh2y+3IhBxB5JKHISIy/B9a3NY5TYqcsp+boNEr4Tg/sEVs4CL80WFbLH2OtuVbxuwjUkX/91kALNYPO4xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836978; c=relaxed/simple;
	bh=MTvwfxmTyM79R2y6PoopPD/AeBFc8u0r4vdurAjyuhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfUGdJQTQgm10W3LRK18XFYsjuitIN41G8naqfiWf6B02ngwunxuNVescX/Szv1EZpXxQZT8aaXCjGq8QBp1cq+aZBXXEWOt5NItv4WmTHNirunMO6O/uMHdoCAPPp6AndsZ/Uv3F2DswtPwYw7NCvW3t849jnwuwo4ets1LPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 228290 invoked by uid 1000); 7 Mar 2024 13:42:55 -0500
Date: Thu, 7 Mar 2024 13:42:55 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Dingyan Li <18500469033@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Use EHCI control transfer pid macros instead of
 constant values.
Message-ID: <1e7f57d6-a4c1-4a3d-8cff-f966c89a8140@rowland.harvard.edu>
References: <20240307173159.318384-1-18500469033@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307173159.318384-1-18500469033@163.com>

On Fri, Mar 08, 2024 at 01:31:59AM +0800, Dingyan Li wrote:
> Macros with good names offer better readability. Besides, also move
> the definition to ehci.h.
> 
> Signed-off-by: Dingyan Li <18500469033@163.com>
> ---

Good idea, but you missed a few spots.

>  drivers/usb/host/ehci-q.c | 10 +++-------
>  drivers/usb/host/ehci.h   |  8 +++++++-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 666f5c4db25a..51b46001e344 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -27,10 +27,6 @@
>  
>  /*-------------------------------------------------------------------------*/
>  
> -/* PID Codes that are used here, from EHCI specification, Table 3-16. */
> -#define PID_CODE_IN    1
> -#define PID_CODE_SETUP 2
> -
>  /* fill a qtd, returning how much of the buffer we were able to queue up */
>  
>  static unsigned int
> @@ -230,7 +226,7 @@ static int qtd_copy_status (
>  			/* fs/ls interrupt xfer missed the complete-split */
>  			status = -EPROTO;
>  		} else if (token & QTD_STS_DBE) {
> -			status = (QTD_PID (token) == 1) /* IN ? */
> +			status = (QTD_PID(token) == PID_CODE_IN) /* IN ? */
>  				? -ENOSR  /* hc couldn't read data */
>  				: -ECOMM; /* hc couldn't write data */
>  		} else if (token & QTD_STS_XACT) {
> @@ -606,7 +602,7 @@ qh_urb_transaction (
>  		/* SETUP pid */
>  		qtd_fill(ehci, qtd, urb->setup_dma,
>  				sizeof (struct usb_ctrlrequest),
> -				token | (2 /* "setup" */ << 8), 8);
> +				token | (PID_CODE_SETUP << 8), 8);
>  
>  		/* ... and always at least one more pid */
>  		token ^= QTD_TOGGLE;

There is an occurrence on line 623.

> @@ -642,7 +638,7 @@ qh_urb_transaction (
>  	}
>  
>  	if (is_input)
> -		token |= (1 /* "in" */ << 8);
> +		token |= (PID_CODE_IN << 8);
>  	/* else it's already initted to "out" pid (0 << 8) */
>  
>  	maxpacket = usb_endpoint_maxp(&urb->ep->desc);

You could use PID_CODE_IN on lines 712 and 1232.

There are occurrences on lines 1206, 1219.

Also, there's a bunch of "switch" cases near line 433 in ehci-dbg.c.

Alan Stern

