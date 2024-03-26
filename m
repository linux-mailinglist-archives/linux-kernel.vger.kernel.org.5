Return-Path: <linux-kernel+bounces-118694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064188BE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621EF1C3CFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167405D734;
	Tue, 26 Mar 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHf+Cb4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E27482FE;
	Tue, 26 Mar 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445888; cv=none; b=kjByBRfGJcpnRF+D5TBtoSEcvb4EaUtkYX4q/H5/BGx7fCWZvJn5pyAaAQzCBxL0qMbP+Aqsx3fRUKgkKdKwv32RMAWIds+dCXfbOkdC/1M6NAR3fwJPctbSuNZBMEtB+6ScNtj9vJiLoFUXPyay8pRqyMmhWcbS1ciorfzoGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445888; c=relaxed/simple;
	bh=mQEX1MUJmQxCZbULnvOm+ar9krGd8RTh8z2bMcAYA2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZICAfLaAY1v6r7qr9yGwmSmKLwVLNA0EJzyPqOB2pkjmAqlH7l82HaVeekNkKYhgHzLPHQwI3WNBRgOivWlIEAYCQyLlNi0j1eAslpCG8f4WOyYaO2SQTF7rSclwlJNVI/oHAbl+pMsMlbBPOaDNedLx1F0EZk529UIk37R7cU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHf+Cb4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D4C433F1;
	Tue, 26 Mar 2024 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445887;
	bh=mQEX1MUJmQxCZbULnvOm+ar9krGd8RTh8z2bMcAYA2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHf+Cb4Cp6TmT+wJl0XDS12an+VJHvjtC3YC297IXw3bPbww8DMYBvxoKCo2PvBW6
	 Csf5GJOnpMekCJtszTZ0WD7qmOcLaNYhfBG/1RHE8fdJFRWCSJKUy+29ry6NJgq71T
	 E3/zy1kiqqqTO30JICuUqfihSR4b8FwoK1Ntni4g=
Date: Tue, 26 Mar 2024 10:38:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tipd: fix event checking for tps25750
Message-ID: <2024032652-caucasian-clothes-cf44@gregkh>
References: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
 <20240325-tps6598x_fix_event_handling-v1-1-633fe0c87cc8@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-tps6598x_fix_event_handling-v1-1-633fe0c87cc8@wolfvision.net>

On Mon, Mar 25, 2024 at 10:02:21AM +0100, Javier Carrasco wrote:
> In its current form, the interrupt service routine of the tps25750
> checks the event flags in the lowest 64 bits of the interrupt event
> register (event[0]), but also in the upper part (event[1]).
> 
> Given that all flags are defined as BIT() or BIT_ULL(), they are
> restricted to the first 64 bits of the INT_EVENT1 register. Including
> the upper part of the register can lead to false positives e.g. if the
> event 64 bits above the one being checked is set, but the one being
> checked is not.
> 
> Restrict the flag checking to the first 64 bits of the INT_EVENT1
> register.
> 
> Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 0717cfcd9f8c..7c2f01344860 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
> @@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  	 * a plug event. Therefore, we need to check
>  	 * for pr/dr status change to set TypeC dr/pr accordingly.
>  	 */
> -	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
> +	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
>  	    tps6598x_has_role_changed(tps, status))
>  		tps6598x_handle_plug_event(tps, status);
>  
> 
> -- 
> 2.40.1
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

