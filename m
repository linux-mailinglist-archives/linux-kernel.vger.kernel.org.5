Return-Path: <linux-kernel+bounces-15196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDA822840
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4345E1C22F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C73179A4;
	Wed,  3 Jan 2024 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wu6zRJTx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5C18021;
	Wed,  3 Jan 2024 06:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D90C433C7;
	Wed,  3 Jan 2024 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704262016;
	bh=JtxIzIlnugHCagbmexlScQ8CXMjGCmhR4H3XfHvY6ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wu6zRJTxrben9Fh8b7yNPuWI+2YLyqJ3pSy9zVXvMSKtL9ZQpdm4bXhXETW45HD3E
	 imgSCd6JfnzElMI3XSlz43PmOtY8ntXS5Kzz+q1Z86Vl6tmP9CiAM1+xn+V82mw8+v
	 L/Jla+z9Qk32JZjswfJhE4CsnIlk2+CMxJQwEDZo=
Date: Wed, 3 Jan 2024 07:06:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Queue PM runtime idle on disconnect
 event
Message-ID: <2024010322-cement-richness-0781@gregkh>
References: <20240103023023.477-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103023023.477-1-quic_wcheng@quicinc.com>

On Tue, Jan 02, 2024 at 06:30:23PM -0800, Wesley Cheng wrote:
> There is a scenario where DWC3 runtime suspend is blocked due to the
> dwc->connected flag still being true while PM usage_count is zero after
> DWC3 giveback is completed and the USB gadget session is being terminated.
> This leads to a case where nothing schedules a PM runtime idle for the
> device.
> 
> The exact condition is seen with the following sequence:
>   1.  USB bus reset is issued by the host
>   2.  Shortly after, or concurrently, a USB PD DR SWAP request is received
>       (sink->source)
>   3.  USB bus reset event handler runs and issues
>       dwc3_stop_active_transfers(), and pending transfer are stopped
>   4.  DWC3 usage_count decremented to 0, and runtime idle occurs while
>       dwc->connected == true, returns -EBUSY
>   5.  DWC3 disconnect event seen, dwc->connected set to false due to DR
>       swap handling
>   6.  No runtime idle after this point
> 
> Address this by issuing an asynchronous PM runtime idle call after the
> disconnect event is completed, as it modifies the dwc->connected flag,
> which is what blocks the initial runtime idle.
> 
> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/gadget.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 858fe4c299b7..de6056277f94 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3973,6 +3973,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
>  	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
>  
>  	dwc3_ep0_reset_state(dwc);
> +
> +	/*
> +	 * Request PM idle to address condition where usage count is
> +	 * already decremented to zero, but waiting for the disconnect
> +	 * interrupt to set dwc->connected to FALSE.
> +	 */
> +	pm_request_idle(dwc->dev);
>  }
>  
>  static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

