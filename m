Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28127E6642
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjKIJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:08:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15D1173E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:08:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A8C433C8;
        Thu,  9 Nov 2023 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699520897;
        bh=ZHs2VZOvcPjgptqZe3ptOWOMPWMo+3HeM8M53lCT57A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rq3hnKiJdeuClbvuFPi+b4gKLuRbbwsgSer5lX2n6cT0QfYokfFkw1t3UyaCeKM6p
         KN0PB+X2H62xuDg8XIpwgj78XNpY0SebjdhFzF22QGzd5RjHWQ2/J7AEk41XrdnXTw
         Ux3627BMD5wpcF3W8+p2Wfg+S6F0KZyO0EjbD2Q0=
Date:   Thu, 9 Nov 2023 10:08:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        laurentiu.tudor@nxp.com
Subject: Re: [PATCH] bus: fsl-mc: fix double-free on mc_dev
Message-ID: <2023110905-swiftness-dawn-2aaf@gregkh>
References: <20231108164546.2699574-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108164546.2699574-1-ioana.ciornei@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 06:45:46PM +0200, Ioana Ciornei wrote:
> The blamed commit tried to simplify how the deallocations are done but,
> in the process, introduced a double-free on the mc_dev variable.
> 
> In case the MC device is a DPRC, a new mc_bus is allocated and the
> mc_dev variable is just a reference to one of its fields. In this
> circumstance, on the error path only the mc_bus should be freed.
> 
> This commit introduces back the following checkpatch warning which is a
> false-positive.
> 
> WARNING: kfree(NULL) is safe and this check is probably not required
> +       if (mc_bus)
> +               kfree(mc_bus);
> 
> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 2f6d5002e43d..b405ee330af1 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	if (mc_bus)
> +		kfree(mc_bus);
> +	else
> +		kfree(mc_dev);
>  
>  	return error;
>  }
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
