Return-Path: <linux-kernel+bounces-84554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9D86A839
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB25728AF53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB821A1C;
	Wed, 28 Feb 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEThuSc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DD224D4;
	Wed, 28 Feb 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100461; cv=none; b=WTROVQ1hBLNaY9UrS/jUVEm6bCbXgpoHoyHLW3YEcRcXctYuZ4ugEDw/QPRg30P9mbEgocWgG1uaK7vRdKz+hFICcXloJTQvdqZK19R0PD4TrPrRtIqXAverkiY35fWG3YNy1lms73BEbEl8BhsoWmRDheGZu9tST+QyfYDy4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100461; c=relaxed/simple;
	bh=pxc2ZZ/jk0gXN4weRBL2NBBmdZRdQq6VWS7o4nzzuj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3bs31Qb2wmNf/hV/EWRYbDGCcKaxuYfBcMqpurtgWii0W476UbMRYivvtK+Q+uqq5XN9mGoQ5tfu4l6TfXLNMHjhW6gg+UF88MI78h50//dl8lGMKrm4mw8xbphz5DqGKxP8zGJ4cnonBEo/u8f2i81NT8hRTJwwZh3pw/p5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEThuSc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA456C433F1;
	Wed, 28 Feb 2024 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709100461;
	bh=pxc2ZZ/jk0gXN4weRBL2NBBmdZRdQq6VWS7o4nzzuj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEThuSc4bNSWeaQNmhTxul4sBIUSAjOLhwLIVZQ8rDxznqlEh7qxDnkWdPuHKXjX3
	 IzSDFNUcOLoqHSTBWL+gKNhteNEdU+KP/9Kz96z730FiC25sRVPDxac7huK+zXSFAb
	 cZfZ9xC+hPN94H+ZZGzItK60eCzrPL+m17Kv7Bgg=
Date: Wed, 28 Feb 2024 07:07:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingliang Li <qingliang.li@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
Message-ID: <2024022829-ripple-quintet-a097@gregkh>
References: <20240228020040.25815-1-qingliang.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228020040.25815-1-qingliang.li@mediatek.com>

On Wed, Feb 28, 2024 at 10:00:40AM +0800, Qingliang Li wrote:
> When driver registers the wake irq with reverse enable ordering,
> the wake irq will be re-enabled when entering system suspend, triggering
> an 'Unbalanced enable for IRQ xxx' warning. The wake irq will be
> enabled in both dev_pm_enable_wake_irq_complete() and dev_pm_arm_wake_irq()
> 
> To fix this issue, complete the setting of WAKE_IRQ_DEDICATED_ENABLED flag
> in dev_pm_enable_wake_irq_complete() to avoid redundant irq enablement.
> 
> Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
> Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>
> ---
>  drivers/base/power/wakeirq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 42171f766dcb..5a5a9e978e85 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -313,8 +313,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
>  		return;
>  
>  	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
> -	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
> +	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
>  		enable_irq(wirq->irq);
> +		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
> +	}
>  }
>  
>  /**
> -- 
> 2.25.1
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

