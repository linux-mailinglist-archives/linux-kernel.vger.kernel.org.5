Return-Path: <linux-kernel+bounces-118689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEA88BE12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76631F62A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79973811E5;
	Tue, 26 Mar 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKvQr6eO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31080BE1;
	Tue, 26 Mar 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445571; cv=none; b=JPP2HfkIy8ByyLA822gtpLhIhyD1S0E10M7Va0jRrYGtEMQ7UNMMiqJo4a1wqMQ6GwEGy2EXB3NvNO2w/vKyOAy5QdJdYwurduEdhTStTkaQrJ9/N5YDIe0hmeHCcSb85z73zigI+8ZwjLbLHnX/AdcpSOCDFxQMEgd+wD8N9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445571; c=relaxed/simple;
	bh=BXgCcV55X0n3ZpVCB4As3BKU3w5I/j7vrww/TR0BRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QijkC69+UGslkVG/wBYFy3LdGJ1WvjWAVizLEIwLlWpf3/5K0iGpTjJz5hdP2NM/4Tx/NUpS7i55oFCyVX6fTnZtTpxMj/R559v+Oq8VEbeJwkbVp1O3GV47fSjZIZrx9XgCHO3tct7gSWUH4g3ShMmGPPuR+zYe4+oxef6n1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKvQr6eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69D6C433F1;
	Tue, 26 Mar 2024 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445571;
	bh=BXgCcV55X0n3ZpVCB4As3BKU3w5I/j7vrww/TR0BRCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKvQr6eOEz6kOjWKWIZzNGejo0Ht9k9cR+FA0vuMBUackYozo3oLApXfoZUgjcj33
	 APNjIamrXhAJtVvSMiA+FZLQWGmtDjpXd6ZtiK7Y7Us6rY45UCgChs4GSr/hWIiHS2
	 QOxmEPH8tiMyTw2HMOVqESm/EPGaDfDkWczlpeMg=
Date: Tue, 26 Mar 2024 10:32:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Improve error checking and tagging
Message-ID: <2024032622-canine-fragility-39db@gregkh>
References: <20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de>

On Mon, Mar 25, 2024 at 12:32:30AM +0100, Michael Grzeschik wrote:
> Right now after one transfer was completed with EXDEV the currently
> encoded frame will get the UVC_STREAM_ERR tag attached. Since the
> complete and encode path are handling separate requests from different
> threads, there is no direct correspondence between the missed transfer
> of one request and the currently encoded request which might already
> belong to an completely different frame.
> 
> When queueing requests into the hardware by calling ep_queue the
> underlying ringbuffer of the usb driver will be filled. However when
> one of these requests will have some issue while transfer the hardware
> will trigger an interrupt but will continue transferring the pending
> requests in the ringbuffer. This interrupt-latency will make it
> impossible to react in time to tag the fully enqueued frame with the
> UVC_STREAM_ERR in the header.
> 
> This patch is also addressing this particular issue by delaying the
> transmit of the EOF/ERR tagged header by waiting for the last enqueued
> buffer of the frame to be completed. This way it is possible to react to
> send the EOF/ERR tag depending on the whole frame transfer status.
> 
> As this is patch is adding latency to the enqueuing path of the frames
> we make this errorcheck optional by adding an extra module parameter.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/usb/gadget/function/f_uvc.c     |  4 ++
>  drivers/usb/gadget/function/uvc.h       |  3 ++
>  drivers/usb/gadget/function/uvc_video.c | 69 +++++++++++++++++++++++++++++----
>  3 files changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 929666805bd23..6a7ca8ccaf360 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -33,6 +33,10 @@ unsigned int uvc_gadget_trace_param;
>  module_param_named(trace, uvc_gadget_trace_param, uint, 0644);
>  MODULE_PARM_DESC(trace, "Trace level bitmask");
>  
> +bool uvc_gadget_errorcheck_param = true;
> +module_param_named(errorcheck, uvc_gadget_errorcheck_param, bool, 0644);
> +MODULE_PARM_DESC(errorcheck, "Check and mark errors in the transfer of a frame");

I really really really really hate adding new module parameters as they
do not scale nor work properly for multiple devices and really, it's not
the 1990's anymore.

Any way to make this debugging thing part of a debugfs interface or
worst case, a sysfs entry instead?

Or why not just make it a tracing thing instead?

But wait, you are fixing a real issue here, why is it an option at all?
Shouldn't this always be the case and the driver should always recover
in this way?  Why would you not want this to be the default and only way
it operates?

thanks,

greg k-h

