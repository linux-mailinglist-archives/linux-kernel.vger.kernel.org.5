Return-Path: <linux-kernel+bounces-97556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E27876BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F8F1C21288
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177B5E070;
	Fri,  8 Mar 2024 20:34:15 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DC92B50A80
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930055; cv=none; b=NkML2CNnw++vRh7hu9M4GtNksYvXatwexzgS4S1V935LD0V1oUpxibdwSiiCatFpQYPwClTekU38QliSwCK3gcDlFRazwHp61V1ul77/QdsEqEzlJ9ouOtIkn3LXULAodb4Um64LzpFSumYRjLWbKMfSSRzpANFkMm2Q0H4piMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930055; c=relaxed/simple;
	bh=IZaH6aC/i1n7v7img2naof+9A7gZ7xNYIB9VhpQKeaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAvfOx36aAmkTvlG7E4AbLFDeS55QbaTifDrUKGtI6LKUB2WHdFBdKhZTv4C2JEicrduOtiTwHz0Kj1Rjggs4uWDgd9xUsYkJdZO9jHr1VBJGuAbUYZUifvDLKpGcFzZ4tl7RQ+fInV5YrqjtJ1qxOR2kxgDynVXZi2iHPo2n6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 271622 invoked by uid 1000); 8 Mar 2024 15:34:04 -0500
Date: Fri, 8 Mar 2024 15:34:04 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Dingyan Li <18500469033@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Use EHCI control transfer pid macros instead of
 constant values.
Message-ID: <37bdd932-07a4-4514-a5cc-b70d48c962a6@rowland.harvard.edu>
References: <1e7f57d6-a4c1-4a3d-8cff-f966c89a8140@rowland.harvard.edu>
 <20240308010859.81987-1-18500469033@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308010859.81987-1-18500469033@163.com>

On Fri, Mar 08, 2024 at 09:08:59AM +0800, Dingyan Li wrote:
> Macros with good names offer better readability. Besides, also move
> the definition to ehci.h.
> 
> Signed-off-by: Dingyan Li <18500469033@163.com>
> ---

You found some things that I missed!  Good for you.  When you resubmit 
with a list of changes from the original version, you can add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-dbg.c | 10 +++++-----
>  drivers/usb/host/ehci-q.c   | 20 ++++++++------------
>  drivers/usb/host/ehci.h     |  8 +++++++-
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
> index c063fb042926..435001128221 100644
> --- a/drivers/usb/host/ehci-dbg.c
> +++ b/drivers/usb/host/ehci-dbg.c
> @@ -430,13 +430,13 @@ static void qh_lines(struct ehci_hcd *ehci, struct ehci_qh *qh,
>  				mark = '/';
>  		}
>  		switch ((scratch >> 8) & 0x03) {
> -		case 0:
> +		case PID_CODE_OUT:
>  			type = "out";
>  			break;
> -		case 1:
> +		case PID_CODE_IN:
>  			type = "in";
>  			break;
> -		case 2:
> +		case PID_CODE_SETUP:
>  			type = "setup";
>  			break;
>  		default:
> @@ -602,10 +602,10 @@ static unsigned output_buf_tds_dir(char *buf, struct ehci_hcd *ehci,
>  	list_for_each_entry(qtd, &qh->qtd_list, qtd_list) {
>  		temp++;
>  		switch ((hc32_to_cpu(ehci, qtd->hw_token) >> 8)	& 0x03) {
> -		case 0:
> +		case PID_CODE_OUT:
>  			type = "out";
>  			continue;
> -		case 1:
> +		case PID_CODE_IN:
>  			type = "in";
>  			continue;
>  		}
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 666f5c4db25a..ba37a9fcab92 100644
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
> @@ -620,7 +616,7 @@ qh_urb_transaction (
>  
>  		/* for zero length DATA stages, STATUS is always IN */
>  		if (len == 0)
> -			token |= (1 /* "in" */ << 8);
> +			token |= (PID_CODE_IN << 8);
>  	}
>  
>  	/*
> @@ -642,7 +638,7 @@ qh_urb_transaction (
>  	}
>  
>  	if (is_input)
> -		token |= (1 /* "in" */ << 8);
> +		token |= (PID_CODE_IN << 8);
>  	/* else it's already initted to "out" pid (0 << 8) */
>  
>  	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
> @@ -709,7 +705,7 @@ qh_urb_transaction (
>  
>  		if (usb_pipecontrol (urb->pipe)) {
>  			one_more = 1;
> -			token ^= 0x0100;	/* "in" <--> "out"  */
> +			token ^= (PID_CODE_IN << 8);	/* "in" <--> "out"  */
>  			token |= QTD_TOGGLE;	/* force DATA1 */
>  		} else if (usb_pipeout(urb->pipe)
>  				&& (urb->transfer_flags & URB_ZERO_PACKET)
> @@ -1203,7 +1199,7 @@ static int ehci_submit_single_step_set_feature(
>  		/* SETUP pid, and interrupt after SETUP completion */
>  		qtd_fill(ehci, qtd, urb->setup_dma,
>  				sizeof(struct usb_ctrlrequest),
> -				QTD_IOC | token | (2 /* "setup" */ << 8), 8);
> +				QTD_IOC | token | (PID_CODE_SETUP << 8), 8);
>  
>  		submit_async(ehci, urb, &qtd_list, GFP_ATOMIC);
>  		return 0; /*Return now; we shall come back after 15 seconds*/
> @@ -1216,7 +1212,7 @@ static int ehci_submit_single_step_set_feature(
>  	token ^= QTD_TOGGLE;   /*We need to start IN with DATA-1 Pid-sequence*/
>  	buf = urb->transfer_dma;
>  
> -	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
> +	token |= (PID_CODE_IN << 8);  /*This is IN stage*/
>  
>  	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
>  
> @@ -1229,7 +1225,7 @@ static int ehci_submit_single_step_set_feature(
>  	qtd->hw_alt_next = EHCI_LIST_END(ehci);
>  
>  	/* STATUS stage for GetDesc control request */
> -	token ^= 0x0100;        /* "in" <--> "out"  */
> +	token ^= (PID_CODE_IN << 8);        /* "in" <--> "out"  */
>  	token |= QTD_TOGGLE;    /* force DATA1 */
>  
>  	qtd_prev = qtd;
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index 1441e3400796..d7a3c8d13f6b 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -321,10 +321,16 @@ struct ehci_qtd {
>  	size_t			length;			/* length of buffer */
>  } __aligned(32);
>  
> +/* PID Codes that are used here, from EHCI specification, Table 3-16. */
> +#define PID_CODE_OUT   0
> +#define PID_CODE_IN    1
> +#define PID_CODE_SETUP 2
> +
>  /* mask NakCnt+T in qh->hw_alt_next */
>  #define QTD_MASK(ehci)	cpu_to_hc32(ehci, ~0x1f)
>  
> -#define IS_SHORT_READ(token) (QTD_LENGTH(token) != 0 && QTD_PID(token) == 1)
> +#define IS_SHORT_READ(token) (QTD_LENGTH(token) != 0 && \
> +						QTD_PID(token) == PID_CODE_IN)
>  
>  /*-------------------------------------------------------------------------*/
>  
> -- 
> 2.25.1
> 

