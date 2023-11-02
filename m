Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840817DEC78
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjKBFr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjKBFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:45:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0F112;
        Wed,  1 Nov 2023 22:45:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F08C433C8;
        Thu,  2 Nov 2023 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698903931;
        bh=deTWce1Ruc+WuMtuvtN9mov19AKFx2bIim+XWnVSxyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFIZyzIM6Os/iGOUa/HBwCScp/KWQ75JB5Pxl+4A3LNJqZGM6tDk/gDrY5zF1BevE
         /7K8pQZg58ICXeHGyRPhoYoJrU1zR/pgPlfaQNe+0N2IemO4XII/p6b14c/wLvz7m2
         OECxYE+IreLfyBoX8+RRBIUtqwrOzIBsTSSSLyNs=
Date:   Thu, 2 Nov 2023 06:45:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dimadrumspro@gmail.com
Cc:     dimaac@bk.ru, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: tty: vt: vt.c: fixed segmentation fault in
 vt.c
Message-ID: <2023110236-onstage-skipper-30be@gregkh>
References: <20231101235332.4314-1-dimadrumspro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101235332.4314-1-dimadrumspro@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:53:32AM +0100, dimadrumspro@gmail.com wrote:
> From: dimaaac <dimadrumspro@gmail.com>
> 
> The previous code lacked proper synchronization, leading to potential data corruption and crashes. Added a spin lock to protect shared variable 'scrollback_delta' to prevent concurrent access.
> 
> Signed-off-by: dimaaac <dimaac@bk.ru>
> ---
>  drivers/tty/vt/vt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 5c47f77804f0..29cf7fe11662 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -301,12 +301,13 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
>  }
>  
>  /* Called  from the keyboard irq path.. */
> +static DEFINE_SPINLOCK(scrolldelta_lock);
> +
>  static inline void scrolldelta(int lines)
>  {
> -	/* FIXME */
> -	/* scrolldelta needs some kind of consistency lock, but the BKL was
> -	   and still is not protecting versus the scheduled back end */
> +	spin_lock(&scrolldelta_lock);
>  	scrollback_delta += lines;
> +	spin_unlock(&scrolldelta_lock);
>  	schedule_console_callback();
>  }
>  
> -- 
> 2.42.0
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
