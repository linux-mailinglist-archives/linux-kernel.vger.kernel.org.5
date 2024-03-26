Return-Path: <linux-kernel+bounces-118881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39D88C096
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ABF1F626CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC3548F7;
	Tue, 26 Mar 2024 11:24:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E255E58
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452284; cv=none; b=bQb6t12QzL+sFSG8TVP6fkAF1LveH84l3nrLOIpXh9BlMljeKaFZ6+uJvi2TmOZo8rI5UBzOHcEbfX4BOxY4RL64hW3mr7T0txyqEzmi5lFwVqK28EjGAEufUCAlNRc3f1I3f/fAiKm9eJfry+qlVtZMT9hu4szgroU+N7UTP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452284; c=relaxed/simple;
	bh=b5PW16lJdCBNP5ifrYSt60o5VKAKdhikWIeLZPiXsJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxLsqWxa9/BNFhq5kKjx3Br0pzJMcisieVt9WHB8IppXYjoh3DDK+avl/40GouSZXZa1e6/WQHZVAru9MHuJ2GEK7VISdbYtijZWRGV/EwwvhDZaB2+mouZgKADeeGhQyECY0a39l4WRpslzDOGeTJtn8v6y/sPRcnPL+VtrCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57A7A2F4;
	Tue, 26 Mar 2024 04:25:15 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2209F3F64C;
	Tue, 26 Mar 2024 04:24:41 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:24:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/5] firmware: arm_scmi: Add message dump traces for
 bad and unexpected replies
Message-ID: <ZgKwdhLQeYDd9SAl@bogus>
References: <20240325204620.1437237-1-cristian.marussi@arm.com>
 <20240325204620.1437237-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325204620.1437237-4-cristian.marussi@arm.com>

On Mon, Mar 25, 2024 at 08:46:18PM +0000, Cristian Marussi wrote:
> Trace also late-timed-out, out-of-order and unexpected/spurious messages.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c  | 10 ++++++++++
>  drivers/firmware/arm_scmi/mailbox.c |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 7fc1c5b1a2a4..207ed1a52d69 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -861,6 +861,9 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  			"Message for %d type %d is not expected!\n",
>  			xfer_id, msg_type);
>  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
> +
>  		return xfer;
>  	}
>  	refcount_inc(&xfer->users);
> @@ -885,6 +888,9 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  		dev_err(cinfo->dev,
>  			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
>  			msg_type, xfer_id, msg_hdr, xfer->state);
> +
> +		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
> +
>  		/* On error the refcount incremented above has to be dropped */
>  		__scmi_xfer_put(minfo, xfer);
>  		xfer = ERR_PTR(-EINVAL);
> @@ -921,6 +927,9 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
>  	if (IS_ERR(xfer)) {
>  		dev_err(dev, "failed to get free message slot (%ld)\n",
>  			PTR_ERR(xfer));
> +
> +		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
> +
>  		scmi_clear_channel(info, cinfo);
>  		return;
>  	}
> @@ -1040,6 +1049,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
>  		break;
>  	default:
>  		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
> +		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNKNOWN);
>  		break;
>  	}
>  }
> diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
> index b8d470417e8f..fb0824af7180 100644
> --- a/drivers/firmware/arm_scmi/mailbox.c
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -56,7 +56,9 @@ static void rx_callback(struct mbox_client *cl, void *m)
>  	 */
>  	if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
>  		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
> -		return;
> +		return scmi_bad_message_trace(smbox->cinfo,
> +				     shmem_read_header(smbox->shmem),
> +				     MSG_MBOX_SPURIOUS);

From previous patch, IIUC scmi_bad_message_trace is a void func and doesn't
return anything. Did you not get any build error/warning for this ?

-- 
Regards,
Sudeep

