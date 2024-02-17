Return-Path: <linux-kernel+bounces-69939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D361859089
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1869E1F217E8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2937C6E0;
	Sat, 17 Feb 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wkSTvW3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8E81E;
	Sat, 17 Feb 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183977; cv=none; b=YgUyw0M8mJrZ3gQxYVDtYhJzS2kTVRbjBupDjq0Heipff3+XMq1qrkftGD/xxwdBmRlNpPIng4IHR0OZYc4ApdyY6g5Q+EEXA0PH8QqM0DXjOzVa9kmifvOQZNi6wQAxoCc2Gb+OYr7O5owJtM5iQ22iGp2i+9+A32HwjB2TzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183977; c=relaxed/simple;
	bh=kRaAD7ZRFG9PP56SlAHdcep6YLhDgh49V/QqkUID8g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjsNoNYfVY2bm6UZFSuUZEq5oISrqBAsP8NLXQFpMG3KsEOHij5NzdpKZLBlueZ/jNvXAAStxUKVNtfiq5SmD4SuM8cS+aYCABsx68qXfE3J9cqHkn9kfau1tf5+Vw5ATNDHDHMgUeP1wKRyp7LTWgHhP+EzJmfOyBteZVO6hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wkSTvW3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB478C433C7;
	Sat, 17 Feb 2024 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708183977;
	bh=kRaAD7ZRFG9PP56SlAHdcep6YLhDgh49V/QqkUID8g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wkSTvW3vAxn8uz2A65Zq8BjynWM/uMOTjc7NTclLAzqdUoHEYDY3Y25TQ/umRRcpl
	 mU/D+1a1xnw/+HhdDac6kC5LrIDYJTHYe/j0XfnPZZdGKsm1NT22bkeqooWxfE49Gt
	 2wvFag7sW46qoBVFTPZ6XMQAuzrqw6GvVsO6kRaM=
Date: Sat, 17 Feb 2024 16:32:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into
 unattached state after try role"
Message-ID: <2024021739-self-pencil-b932@gregkh>
References: <20240215193352.1026707-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215193352.1026707-1-megi@xff.cz>

On Thu, Feb 15, 2024 at 08:33:50PM +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The reverted commit makes the state machine only ever go from SRC_ATTACH_WAIT
> to SNK_TRY in endless loop when toggling. After revert it goes to SRC_ATTACHED
> after initially trying SNK_TRY earlier, as it should for toggling to ever detect
> the power source mode and the port is again able to provide power to attached
> power sinks.
> 
> This reverts commit 2d6d80127006ae3da26b1f21a65eccf957f2d1e5.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> See https://lore.kernel.org/all/odggrbbgjpardze76qiv57mw6tllisyu5sbrta37iadjzwamcv@qr3ubwnlzqqt/
> for more.
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f7d7daa60c8d..295ae7eb912c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3743,9 +3743,6 @@ static void tcpm_detach(struct tcpm_port *port)
>  	if (tcpm_port_is_disconnected(port))
>  		port->hard_reset_count = 0;
>  
> -	port->try_src_count = 0;
> -	port->try_snk_count = 0;
> -
>  	if (!port->attached)
>  		return;
>  
> -- 
> 2.43.0
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

