Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471247C99F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJOQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:13:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A6A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:13:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38411C433C8;
        Sun, 15 Oct 2023 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697386399;
        bh=1M1k5UESPxlG1NghWMG6kdrgsF3T+29Q+UCFG4pZ4SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+aXD3jK1RJIEnCg/GnrjLl8R0Wabm1jzf0iWWFrkQbFxGRTufCMFWvlUiNaZZYGK
         xjfzuUMdtS6Oc5PDUKghjp17lzhO/BhS/v1eBG7N1hG5T6gsNOdFS5L0Cre3K+cOvc
         Br49Lug56ehkc/QMvzZ9+DxV91b6um6U8Pe/EiBo=
Date:   Sun, 15 Oct 2023 18:13:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: remove unnecessary helper function
Message-ID: <2023101552-delay-dish-e2ae@gregkh>
References: <ZSvlS18qI7G7Dvpi@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSvlS18qI7G7Dvpi@lab-ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 04:12:43PM +0300, Calvince Otieno wrote:
> The function prism2sta_inf_handover() is called by the parent
> function prism2sta_ev_info() to print a literal debug information
> string using pr_debug(). The debugging utility function can be called
> directly within prism2sta_ev_info().
> 
> Furthermore, to make the debugging more module-specific, the netdev_dbg()
> function is preferred over the generic pr_debug() utility function.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2sta.c | 30 ++---------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
> index 57180bb71699..b5e95a3207fe 100644
> --- a/drivers/staging/wlan-ng/prism2sta.c
> +++ b/drivers/staging/wlan-ng/prism2sta.c
> @@ -90,9 +90,6 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev);
>  static int prism2sta_globalsetup(struct wlandevice *wlandev);
>  static int prism2sta_setmulticast(struct wlandevice *wlandev,
>  				  struct net_device *dev);
> -
> -static void prism2sta_inf_handover(struct wlandevice *wlandev,
> -				   struct hfa384x_inf_frame *inf);
>  static void prism2sta_inf_tallies(struct wlandevice *wlandev,
>  				  struct hfa384x_inf_frame *inf);
>  static void prism2sta_inf_hostscanresults(struct wlandevice *wlandev,
> @@ -922,30 +919,6 @@ static int prism2sta_setmulticast(struct wlandevice *wlandev,
>  	return result;
>  }
>  
> -/*
> - * prism2sta_inf_handover
> - *
> - * Handles the receipt of a Handover info frame. Should only be present
> - * in APs only.
> - *
> - * Arguments:
> - *	wlandev		wlan device structure
> - *	inf		ptr to info frame (contents in hfa384x order)
> - *
> - * Returns:
> - *	nothing
> - *
> - * Side effects:
> - *
> - * Call context:
> - *	interrupt
> - */
> -static void prism2sta_inf_handover(struct wlandevice *wlandev,
> -				   struct hfa384x_inf_frame *inf)
> -{
> -	pr_debug("received infoframe:HANDOVER (unhandled)\n");
> -}
> -
>  /*
>   * prism2sta_inf_tallies
>   *
> @@ -1724,7 +1697,8 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
>  	/* Dispatch */
>  	switch (inf->infotype) {
>  	case HFA384x_IT_HANDOVERADDR:
> -		prism2sta_inf_handover(wlandev, inf);
> +		netdev_dbg(wlandev->netdev,
> +			   "received infoframe:HANDOVER (unhandled)\n");
>  		break;
>  	case HFA384x_IT_COMMTALLIES:
>  		prism2sta_inf_tallies(wlandev, inf);
> -- 
> 2.34.1
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
