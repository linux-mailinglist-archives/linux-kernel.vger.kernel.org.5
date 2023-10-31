Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8FC7DCF32
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbjJaO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbjJaO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:27:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 48403DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:27:24 -0700 (PDT)
Received: (qmail 717038 invoked by uid 1000); 31 Oct 2023 10:27:23 -0400
Date:   Tue, 31 Oct 2023 10:27:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Manan Aurora <maurora@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com
Subject: Re: [PATCH] usb: gadget: Support transfers from device memory
Message-ID: <73356479-e037-4727-9444-6ad4c89f6b75@rowland.harvard.edu>
References: <20231031035403.661938-1-maurora@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031035403.661938-1-maurora@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

You forgot to update the kerneldoc for struct usb_request.

Alan Stern
