Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A357AD4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjIYJiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIYJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:38:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C8C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:38:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBEDC433C7;
        Mon, 25 Sep 2023 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695634722;
        bh=w98WX9GtUfJr2k0V0ZENqYfnjhsG5byDSk+WCEeWMiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXkKKrc0fzsVjfzljmFv06D2WO8dJoUKDI8raenhe71O2BYHK67s0K2Pk9vrSXU8R
         RMF5oiDvKAtpwOuNJzb9Qc0CVZWPQFtB8uVKnRYhJeaaJFKf9jVZlqXlNOgQWEC1rQ
         tKss7wtHEa0s2AL/fInrkIDomLsZs3e3OtPJrXlA=
Date:   Mon, 25 Sep 2023 11:38:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju@buaa.edu.cn>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: fix possible NULL pointer dereference caused
 by driver concurrency
Message-ID: <2023092552-tulip-yo-yo-cbb3@gregkh>
References: <20230925091741.797863-1-baijiaju@buaa.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925091741.797863-1-baijiaju@buaa.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:17:41PM +0800, Jia-Ju Bai wrote:
> In _dwc2_hcd_urb_enqueue(), "urb->hcpriv = NULL" is executed without 
> holding the lock "hsotg->lock". In _dwc2_hcd_urb_dequeue():
> 
>     spin_lock_irqsave(&hsotg->lock, flags);
>     ...
> 	if (!urb->hcpriv) {
> 		dev_dbg(hsotg->dev, "## urb->hcpriv is NULL ##\n");
> 		goto out;
> 	}
>     rc = dwc2_hcd_urb_dequeue(hsotg, urb->hcpriv); // Use urb->hcpriv
>     ...
> out:
>     spin_unlock_irqrestore(&hsotg->lock, flags);
> 
> When _dwc2_hcd_urb_enqueue() and _dwc2_hcd_urb_dequeue() are 
> concurrently executed, the NULL check of "urb->hcpriv" can be executed
> before "urb->hcpriv = NULL". After urb->hcpriv is NULL, it can be used 
> in the function call to dwc2_hcd_urb_dequeue(), which can cause a NULL 
> pointer dereference. 

Odd trailing spaces in your changelog text, is that intentional?

> 
> To fix this possible bug, "urb->hcpriv = NULL" should be executed with
> holding the lock "hsotg->lock".
> 
> Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
> ---
>  drivers/usb/dwc2/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 657f1f659ffa..35c7a4df8e71 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4769,8 +4769,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
>  	if (qh_allocated && qh->channel && qh->channel->qh == qh)
>  		qh->channel->qh = NULL;
>  fail2:
> -	spin_unlock_irqrestore(&hsotg->lock, flags);
>  	urb->hcpriv = NULL;
> +	spin_unlock_irqrestore(&hsotg->lock, flags);
>  	kfree(qtd);
>  fail1:
>  	if (qh_allocated) {
> -- 
> 2.34.1
> 

What commit id does this fix?

And how did you test this to verify it works properly?

And how was it found?

thanks,

greg k-h
