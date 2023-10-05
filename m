Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956307BA11F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbjJEOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjJEOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:45:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537442C28C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E236C433BA;
        Thu,  5 Oct 2023 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696490532;
        bh=jUfZTGY+kqGGT0qdvtXa/BI0w4/Qe8O769xiXTh1Lw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDuG4qOyAI6SDULiYIDfJ7F+3i6I4BC0ubcw2u4vUMDe/2tUGp9zSD2r1XmPd9cjL
         pwkYyfgIRbIxWx+cfz33VTYVk0WND5Y2yGEBpWFAH3ZvC9bSOSue+GODPOM4qcPJVP
         hZUr97OTE5TBO4SBz+rHoNsEgTZx5hO+/SahJaco=
Date:   Thu, 5 Oct 2023 09:22:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonas Blixt <jonas.blixt@actia.se>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: usbip: fix stub_dev hub disconnect
Message-ID: <2023100548-kleenex-deceased-624e@gregkh>
References: <20230615092810.1215490-1-jonas.blixt@actia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615092810.1215490-1-jonas.blixt@actia.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:28:10AM +0200, Jonas Blixt wrote:
> If a hub is disconnected that has device(s) that's attached to the usbip layer
> the disconnect function might fail because it tries to release the port
> on an already disconnected hub.
> 
> Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
> Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
> ---
> v2:
>  - Clarify comment
> v1:
>  Link to v1: https://lore.kernel.org/linux-usb/20230615092205.GA1212960@W388ANL/T/#m575e37dc404067797eadf4444857366c73ba3420
> ---
>  drivers/usb/usbip/stub_dev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> index 2305d425e6c9..2170c95c8dab 100644
> --- a/drivers/usb/usbip/stub_dev.c
> +++ b/drivers/usb/usbip/stub_dev.c
> @@ -427,8 +427,13 @@ static void stub_disconnect(struct usb_device *udev)
>  	/* release port */
>  	rc = usb_hub_release_port(udev->parent, udev->portnum,
>  				  (struct usb_dev_state *) udev);
> -	if (rc) {
> -		dev_dbg(&udev->dev, "unable to release port\n");
> +	/*
> +	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
> +	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
> +	 * that error here.
> +	 */
> +	if (rc && (rc != -ENODEV)) {
> +		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
>  		return;
>  	}
>  
> -- 
> 2.25.1
> 

Shuah, what ever happened to this change, is it correct or was something
else applied to fix it?

thanks,

greg k-h
