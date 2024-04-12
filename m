Return-Path: <linux-kernel+bounces-141970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A08A259F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D432848B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1751BC4B;
	Fri, 12 Apr 2024 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aOInRbYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839E1F619;
	Fri, 12 Apr 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899123; cv=none; b=p1tpxEi8KlXTzEUP2gDU+PBNPfqowQcrjDxVGu63pNOr6xmi2yR3xDrlni4soJ1ku5C5qNje920sLVE/mKUI9q9gQm4sjQzh5cg8vsJhTQQk1KBQTfEePksQJiKJdVoLOJ9FUzkq7r6WwQRmJhpX1x0LqSOuKDNZpVwVviI1a7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899123; c=relaxed/simple;
	bh=4wqTxoZFHiWRIlPPIHGTjlolEmrgei5d04Xo/JlN0go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrivz/lYLeE6wxRIGeWWikS1FiR0Jt0IiUuSO9upwXStfFdABhTV/5ACjWAbEpek8WmjFtkLQbg7v0lIzxs6vow4d3g4FfOktemeSwmhXgP52MwxgF8iUsqlfGkBj39wAShREv20YAoSJsVYPiRdYesTy9fQidpOfeLv35RPJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aOInRbYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ADDC2BBFC;
	Fri, 12 Apr 2024 05:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899122;
	bh=4wqTxoZFHiWRIlPPIHGTjlolEmrgei5d04Xo/JlN0go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOInRbYwcY73F+9XzxfeawyYGu3hSjC4p32UJ3k+cLbqQ6ALnD+/pTkngXODLnbhX
	 IAURGE0AROPtapKw1AWf5OvVrHzn9bL3N+lL2yZRJr9bNBrmi5fig4c+Oy/THCl01R
	 t9VHgsqEOQynEAScuTJOGA4Pz+9cD18PRIqcMVmU=
Date: Fri, 12 Apr 2024 07:18:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan Avdeev <me@provod.works>
Cc: laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: use correct buffer size when parsing
 configfs lists
Message-ID: <2024041230-preaching-ranger-66fe@gregkh>
References: <20240411164616.4130163-1-me@provod.works>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411164616.4130163-1-me@provod.works>

On Thu, Apr 11, 2024 at 12:46:16PM -0400, Ivan Avdeev wrote:
> This commit fixes uvc gadget support on 32-bit platforms.
> 
> Commit 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for
> reuse") introduced a helper function __uvcg_iter_item_entries() to aid
> with parsing lists of items on configfs attributes stores. This function
> is a generalization of another very similar function, which used a
> stack-allocated temporary buffer of fixed size for each item in the list
> and used the sizeof() operator to check for potential buffer overruns.
> The new function was changed to allocate the now variably sized temp
> buffer on heap, but wasn't properly updated to also check for max buffer
> size using the computed size instead of sizeof() operator.
> 
> As a result, the maximum item size was 7 (plus null terminator) on
> 64-bit platforms, and 3 on 32-bit ones. While 7 is accidentally just
> barely enough, 3 is definitely too small for some of UVC configfs
> attributes. For example, dwFrameInteval, specified in 100ns units,
> usually has 6-digit item values, e.g. 166666 for 60fps.
> 
> Fixes: 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for reuse")
> Signed-off-by: Ivan Avdeev <me@provod.works>
> ---
>  drivers/usb/gadget/function/uvc_configfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index 7e704b2bcfd1..a4377df612f5 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -92,10 +92,10 @@ static int __uvcg_iter_item_entries(const char *page, size_t len,
>  
>  	while (pg - page < len) {
>  		i = 0;
> -		while (i < sizeof(buf) && (pg - page < len) &&
> +		while (i < bufsize && (pg - page < len) &&
>  		       *pg != '\0' && *pg != '\n')
>  			buf[i++] = *pg++;
> -		if (i == sizeof(buf)) {
> +		if (i == bufsize) {
>  			ret = -EINVAL;
>  			goto out_free_buf;
>  		}
> 
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> -- 
> 2.43.2
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

