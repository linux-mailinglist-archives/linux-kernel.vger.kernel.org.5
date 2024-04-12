Return-Path: <linux-kernel+bounces-141951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E78A2571
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DEA1F22BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CA1BC44;
	Fri, 12 Apr 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILoP8DVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2E1BC20
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898655; cv=none; b=uQQrhs7N4MOd6gm6VoamiVFbnBNV9bCrIiRHUZiviqDNzC9Sg7M+gd+aBWJLNkYbOlkjJV3zhldjHbnn6whEPQp8WrTAEeQR+bvfYni0bC48QP2dW7lfJz9qiBPdKHdgY1yOi9Y9tn73wTqE6XgnJaeJE8RMBhWwQ/EsDEHZP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898655; c=relaxed/simple;
	bh=n1nTu7+xRC3qxpPaBRrMAeZo5K6PsyIpi+vTtIf4SBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4PA9fVtSOaSTShlH6BztZyuDZfp6jh2blpV4STDvnT2HnIzQAG7EhlEH/ep8NLwIK/nWVLSXlg3XFvbjrkZc2yKSgH+ea3iArWmOjKiqElolue34vwr+5irGUtror3gjuXNuoWU8+O5XKRoHbYHXMCqRV73XCM/Tg67kGJbMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILoP8DVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE21C2BBFC;
	Fri, 12 Apr 2024 05:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712898654;
	bh=n1nTu7+xRC3qxpPaBRrMAeZo5K6PsyIpi+vTtIf4SBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILoP8DVHM+rOWyAyCSwYjPNpJ2HCEgAYwuctUOVN0QqrGrfMCQuqgxgmb1tLe02Pr
	 +Y/QcLsY2TXSsIu2rVfZl7evevaPh4DSpFXzcikhfjw2eJ/wNFc7W7w8VGwU5jItfk
	 paI4rGE3T87LBEJtbbsMMvviLgHp1bMal/Ec5NI0=
Date: Fri, 12 Apr 2024 07:10:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: li.hao40@zte.com.cn
Cc: jirislaby@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: wakeup hvc console immediately when needed
Message-ID: <2024041237-shifty-unethical-4a5d@gregkh>
References: <20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn>

On Fri, Apr 12, 2024 at 11:38:48AM +0800, li.hao40@zte.com.cn wrote:
> From: Li Hao <li.hao40@zte.com.cn>
> 
> Cancel the do_wakeup flag in hvc_struct, and change it to immediately
> wake up tty when hp->n_outbuf is 0 in hvc_push().
> 
> When we receive a key input character, the interrupt handling function
> hvc_handle_interrupt() will be executed, and the echo thread
> flush_to_ldisc() will be added to the queue.
> 
> If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
> enters kernel and waits for hp->n_outbuf to become 0 via
> tty_wait_until_sent(). If the echo thread finishes executing before
> reaching tty_wait_until_sent (for example, put_chars() takes too long),
> it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
> tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
> this round's tty_poll). Unless the next key input character comes,
> hvc_poll will be executed, and tty_wakeup() will be performed through
> the do_wakeup flag.
> 
> Signed-off-by: Li Hao <li.hao40@zte.com.cn>
> ---
>  drivers/tty/hvc/hvc_console.c | 12 +++++-------
>  drivers/tty/hvc/hvc_console.h |  1 -
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index cd1f657f7..2fa90d938 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -476,11 +476,13 @@ static void hvc_hangup(struct tty_struct *tty)
>  static int hvc_push(struct hvc_struct *hp)
>  {
>  	int n;
> +	struct tty_struct *tty;
> 
>  	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
> +	tty = tty_port_tty_get(&hp->port);
>  	if (n <= 0) {
>  		if (n == 0 || n == -EAGAIN) {
> -			hp->do_wakeup = 1;
> +			tty_wakeup(tty);
>  			return 0;
>  		}
>  		/* throw away output on error; this happens when
> @@ -491,7 +493,7 @@ static int hvc_push(struct hvc_struct *hp)
>  	if (hp->n_outbuf > 0)
>  		memmove(hp->outbuf, hp->outbuf + n, hp->n_outbuf);
>  	else
> -		hp->do_wakeup = 1;
> +		tty_wakeup(tty);
> 
>  	return n;
>  }
> @@ -739,11 +741,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
>  	poll_mask |= HVC_POLL_READ;
> 
>   out:
> -	/* Wakeup write queue if necessary */
> -	if (hp->do_wakeup) {
> -		hp->do_wakeup = 0;
> -		tty_wakeup(tty);
> -	}
> +	/* Wakeup in hvc_push */
>   bail:
>  	spin_unlock_irqrestore(&hp->lock, flags);
> 
> diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
> index cf4c1af08..6622f71ba 100644
> --- a/drivers/tty/hvc/hvc_console.h
> +++ b/drivers/tty/hvc/hvc_console.h
> @@ -36,7 +36,6 @@ struct hvc_struct {
>  	struct tty_port port;
>  	spinlock_t lock;
>  	int index;
> -	int do_wakeup;
>  	int outbuf_size;
>  	int n_outbuf;
>  	uint32_t vtermno;
> -- 
> 2.25.1

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

