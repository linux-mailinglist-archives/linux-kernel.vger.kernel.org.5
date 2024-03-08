Return-Path: <linux-kernel+bounces-96610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62480875EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A7428445E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B04F8A3;
	Fri,  8 Mar 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyK/+/8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F21CD09;
	Fri,  8 Mar 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884519; cv=none; b=eY5I9wLhmFjrCl7J/TP2NZDoM91ta30TabbhuSKvl4C9uO8v7ygZTEKwKNaYfYyAodceBMPRna0ZzOefXCKMC4IkAGgQuewwwhJnm+s3XOvjF2tiFzlH2LC0zG0vE7gVUEv06RpvADGhGso9+A7kXDReBgM2+kkxzM7NV7ZHU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884519; c=relaxed/simple;
	bh=LdHdlTz00/xGuGZrRMcWu5Guyy6/rT9KdfA6ao/pU6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1tcFvwf/g6EDYjHY67KZHLjoRYm1owJnRriteNRtP9vCTid58NiaGrDpdwLOPRBvKwPfPea4q9cOLaGMbAbnp5U9b6/16mt41KyGI3g4MjFJc465z6ELMKvovxR13fowR7EiPGSibZ6fcQdF5rBHyzogNDqjHcD0OATt7hEJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyK/+/8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B843C433C7;
	Fri,  8 Mar 2024 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709884518;
	bh=LdHdlTz00/xGuGZrRMcWu5Guyy6/rT9KdfA6ao/pU6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yyK/+/8zqyTe2hKRyMhT3GgGH/Kh+i/kPwiF1jso98anyRttX/LPN+RmyKZol0Vfi
	 cBZ0vACiHC4yhXYuXLAZvsJ1hwGKwj/IO01FS6I/IrWNiSfNZnrn77XIW9CWZvd7OK
	 SO2rFAyLfhP9yxa+m1lI6wIdTUZ9i4dWFeXFvUSk=
Date: Fri, 8 Mar 2024 07:55:16 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Dingyan Li <18500469033@163.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Use EHCI control transfer pid macros instead of
 constant values.
Message-ID: <2024030802-huntsman-undertake-a38a@gregkh>
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

