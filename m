Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146347DC65C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjJaGRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJaGRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:17:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F6612D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:17:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA8C433CA;
        Tue, 31 Oct 2023 06:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698732048;
        bh=iB7SU7X4lCstBjTo8XyyKak/6Jb9SnOPNn+3KyJ7p0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh2A5CVZRru44YRIKIqWgBlvs+Eka4zB5nuE+V1uSdIzn+2pyUyu8fNZoXzVlJeb3
         jK88r+MzXmF/B9wcDF+a0H03NTf4zlODNJbAy8VhyW48AnY9vQUFXafHtFCKMZzIt3
         Q/LqauFxEy+LhgzZAEaZX3fI/h4nUR9xzrdK+h6U=
Date:   Tue, 31 Oct 2023 07:00:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manan Aurora <maurora@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com
Subject: Re: [PATCH] usb: gadget: Support transfers from device memory
Message-ID: <2023103156-clapping-shed-4626@gregkh>
References: <20231031035403.661938-1-maurora@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031035403.661938-1-maurora@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 03:54:02AM +0000, Manan Aurora wrote:
> USB gadget stack only supports usb_request objects that point to buffers
> located in memory. Support use cases where data is transferred from
> physical addresses in device mmio regions
> 
> Added a bit "pre_mapped" to usb_request to bypass dma_map_single and
> dma_map_sg for such requests
> 
> The caller must determine the dma address for the request before queuing
> it
> 
> Signed-off-by: Manan Aurora <maurora@google.com>
> ---
>  drivers/usb/gadget/udc/core.c | 4 ++--
>  include/linux/usb/gadget.h    | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index ded9531f141b..236165ba08f4 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -900,7 +900,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_activate);
>  int usb_gadget_map_request_by_dev(struct device *dev,
>  		struct usb_request *req, int is_in)
>  {
> -	if (req->length == 0)
> +	if (req->pre_mapped || req->length == 0)
>  		return 0;
>  
>  	if (req->num_sgs) {
> @@ -948,7 +948,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_map_request);
>  void usb_gadget_unmap_request_by_dev(struct device *dev,
>  		struct usb_request *req, int is_in)
>  {
> -	if (req->length == 0)
> +	if (req->pre_mapped || req->length == 0)
>  		return;
>  
>  	if (req->num_mapped_sgs) {
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index a771ccc038ac..6bc035439098 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -111,6 +111,7 @@ struct usb_request {
>  	unsigned		zero:1;
>  	unsigned		short_not_ok:1;
>  	unsigned		dma_mapped:1;
> +	unsigned		pre_mapped:1;
>  
>  	void			(*complete)(struct usb_ep *ep,
>  					struct usb_request *req);
> -- 
> 2.42.0.820.g83a721a137-goog
> 
> 

You can not add features/functionality that no in-kernel driver uses, so
this can not be accepted as-is, sorry.  Please submit it as part of a
patch series where it is actually used, otherwise we have no idea if
this is even something that we should do or not.

thanks,

greg k-h
