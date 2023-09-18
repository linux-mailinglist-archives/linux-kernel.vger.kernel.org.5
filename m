Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C637A41B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjIRHEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbjIRHEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:04:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D9121
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:03:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF4C433C7;
        Mon, 18 Sep 2023 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695020624;
        bh=opjulFiGRuWJn3Kbr+JNW9QH6jk0wc+wSlz5wGS+cYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5Ywz1ZVlBdMvCo2Xj/XXT0VztyffGjTs4GlZ/6PVUk3jCNSZTu/Z8ZLYXNq7PmMA
         Pzec9PzHCI/f0czfR43ykFT0m8aTYGTjUITwx5N7Mc04RDkaIaXpe2WigxUQIeF6XM
         BsDgoJWZA64LiCtb6GXp65VCn+AMpbJmQTOjkfTk=
Date:   Mon, 18 Sep 2023 09:03:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xingxing Luo <xingxing.luo@unisoc.com>
Cc:     b-liu@ti.com, s.shtylyov@omp.ru, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingxing0070.luo@gmail.com,
        Zhiyong.Liu@unisoc.com, Cixi.Geng1@unisoc.com,
        Orson.Zhai@unisoc.com, zhang.lyra@gmail.com
Subject: Re: [PATCH V2] usb: musb: Get the musb_qh poniter after musb_giveback
Message-ID: <2023091824-balancing-drizzly-4921@gregkh>
References: <20230918061038.30949-1-xingxing.luo@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918061038.30949-1-xingxing.luo@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:10:38PM +0800, Xingxing Luo wrote:
> When multiple threads are performing USB transmission, musb->lock will be
> unlocked when musb_giveback is executed. At this time, qh may be released
> in the dequeue process in other threads, resulting in a wild pointer, so
> it needs to be here get qh again, and judge whether qh is NULL, and when
> dequeue, you need to set qh to NULL.
> 
> Fixes: dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
> Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
> ---
>  drivers/usb/musb/musb_host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index a02c29216955..bc4507781167 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
>  	musb_giveback(musb, urb, status);
>  	qh->is_ready = ready;
>  
> +	/*
> +	 * musb->lock had been unlocked in musb_giveback, so qh may
> +	 * be freed, need to get it again
> +	 */
> +	qh = musb_ep_get_qh(hw_ep, is_in);
> +
>  	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
>  	 * invalidate qh as soon as list_empty(&hep->urb_list)
>  	 */
> -	if (list_empty(&qh->hep->urb_list)) {
> +	if (qh && list_empty(&qh->hep->urb_list)) {
>  		struct list_head	*head;
>  		struct dma_controller	*dma = musb->dma_controller;
>  
> @@ -2398,6 +2404,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>  		 * and its URB list has emptied, recycle this qh.
>  		 */
>  		if (ready && list_empty(&qh->hep->urb_list)) {
> +			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
>  			qh->hep->hcpriv = NULL;
>  			list_del(&qh->ring);
>  			kfree(qh);
> -- 
> 2.17.1
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
