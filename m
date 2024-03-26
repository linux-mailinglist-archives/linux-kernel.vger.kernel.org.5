Return-Path: <linux-kernel+bounces-118695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601288BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D571C28DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583B6BFAA;
	Tue, 26 Mar 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kL2JR6Hf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D46BB46;
	Tue, 26 Mar 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445893; cv=none; b=IKzjrtTzBbFblOjN3J+ePDh1m5QCuuI5nTkNRu5JoAP/BWcOEUe0U0V7dSWM/c+aHRHvVX4DQs22Q48bBvSuOo/ceDwVL1mKYsHg6c3whgTC+5lPGqD6gUj0hHJGtBd1bCQf7MjhgYVimuD/kF7Aum27polEl1U9YaqW8+siHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445893; c=relaxed/simple;
	bh=PpvEElaALOMzBdU/09Xc1Z37y/Dg3DUH2bQsNEp/h9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk9whRmfOm5W2z9vzvs1ZsjMNHbX9SZq5G8VEoP+PlQQZJ/kldQn+Eh5ps4FQAlUWEswxL2a8giEa6dWTbYQugHh131CD6tZ2a4vhfU8c8V4I3ufAshQarno04w16P462MU7JQR7Cg9AB4bk3tK3G87gnoFjnYj+dWF2hY1qIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kL2JR6Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0868EC433F1;
	Tue, 26 Mar 2024 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445893;
	bh=PpvEElaALOMzBdU/09Xc1Z37y/Dg3DUH2bQsNEp/h9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL2JR6HfJ/cu7afsToonpRaL9BTrovRT+hlWtS/crF88g1W9ZgqgpOxKLHPf9a3W/
	 8U6ouC0dhhAOP21z4q2UGkVQaDld/i/jToO/B1Cvrgla0uS1F/ox5eauyu4XJ7fOcW
	 /zHJVA+0sqSO+a1j+Hw6TL8uMNugjtJi9AxY0elw=
Date: Tue, 26 Mar 2024 10:38:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: fix event checking for tps6598x
Message-ID: <2024032605-pension-bagging-5000@gregkh>
References: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
 <20240325-tps6598x_fix_event_handling-v1-2-633fe0c87cc8@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-tps6598x_fix_event_handling-v1-2-633fe0c87cc8@wolfvision.net>

On Mon, Mar 25, 2024 at 10:02:22AM +0100, Javier Carrasco wrote:
> The current interrupt service routine of the tps6598x only reads the
> first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
> that any event above that range will be ignored, leaving interrupts
> unattended. Moreover, those events will not be cleared, and the device
> will keep the interrupt enabled.
> 
> This issue has been observed while attempting to load patches, and the
> 'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.
> 
> Read the complete INT_EVENT registers to handle all interrupts generated
> by the device in a similar fashion to what is already done for the
> tps25750.
> 
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 7c2f01344860..308748d6cae6 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event1 = 0;
> -	u64 event2 = 0;
> +	u64 event1[2] = { };
> +	u64 event2[2] = { };
>  	u32 status;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
>  
> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
>  	if (ret) {
> -		dev_err(tps->dev, "%s: failed to read events\n", __func__);
> +		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
>  		goto err_unlock;
>  	}
> -	trace_tps6598x_irq(event1, event2);
> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, 11);
> +	if (ret) {
> +		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
> +		goto err_unlock;
> +	}
> +	trace_tps6598x_irq(event1[0], event2[0]);
>  
> -	if (!(event1 | event2))
> +	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
>  		goto err_unlock;
>  
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
>  	/* Handle plug insert or removal */
> -	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
>  
>  err_clear_ints:
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
> +	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, 11);
> +	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, 11);
>  
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> -	if (event1 | event2)
> +	if (event1[0] | event1[1] | event2[0] | event2[1])
>  		return IRQ_HANDLED;
> +
>  	return IRQ_NONE;
>  }
>  
> 
> -- 
> 2.40.1
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

