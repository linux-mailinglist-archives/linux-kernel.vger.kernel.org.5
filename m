Return-Path: <linux-kernel+bounces-30187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCB831B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228A21C20A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBE2576F;
	Thu, 18 Jan 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtYI9Syd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9F25759;
	Thu, 18 Jan 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587244; cv=none; b=maCeGS0LYSHC2k/Vzg+ZPxU976aO8KDtdGxwtRiHeDH/+ykZRttHJcA/8Wv1cBQ92FqqY+5fP7jh9SkqiaY1osyuE8HEPS2XZZCeJyaKu8tXnBMzih4IsCSXItSobqAUhhRxOtpDFJFCm3Myo2Uxv16qLqu9Poi1uFoLETtrFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587244; c=relaxed/simple;
	bh=dz63Si+AMcFRAvV73H3y1FBriMnSZcSRfeMFkdG5Xuo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=b2MBz/PeYucrAM2MtVb2jaOS8f1/y0tG1Zds4BTXFDdg+eQVo8gcROyDSVeEmuujwh6+wRtRr5xMc/NbWJ/Jt3NOkTiR/jbBGpOnfjJzJ2ccQmvp2mKLCu0DYkeT9VZtpGtDxGO6MS4w6b7tjS+LJteSCWSMOvwrD/dolLmm4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtYI9Syd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C7BC433C7;
	Thu, 18 Jan 2024 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705587244;
	bh=dz63Si+AMcFRAvV73H3y1FBriMnSZcSRfeMFkdG5Xuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtYI9Syd6vP9sYWP9WmRdXJR3JLSlReeP6B1iAWde8XIMVY7NJ4/tnk4Oza+0pVtO
	 BGcUKN+zoex0A70BGQ0cnJxjctUtZg3A170XZVe2qluxKEx/sUnhzvgMPiX2CoTl39
	 FJUmq8tcfXmrLHGQee7dXMZxQe1lVviQjIewGAiY=
Date: Thu, 18 Jan 2024 15:14:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Message-ID: <2024011842-groggy-badly-393c@gregkh>
References: <20240118123747.45795-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118123747.45795-1-arefev@swemel.ru>

On Thu, Jan 18, 2024 at 03:37:47PM +0300, Denis Arefev wrote:
> The value of an arithmetic expression period_ns * 1000 is subject
> to overflow due to a failure to cast operands to a larger data
> type before performing arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
> Cc: <stable@vger.kernel.org> # v5.15+ 
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>  drivers/comedi/drivers/ni_tio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
> index da6826d77e60..acc914903c70 100644
> --- a/drivers/comedi/drivers/ni_tio.c
> +++ b/drivers/comedi/drivers/ni_tio.c
> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>  				GI_PRESCALE_X2(counter_dev->variant) |
>  				GI_PRESCALE_X8(counter_dev->variant), bits);
>  	}
> -	counter->clock_period_ps = period_ns * 1000;
> +	counter->clock_period_ps = period_ns * 1000UL;
>  	ni_tio_set_sync_mode(counter);
>  	return 0;
>  }
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

