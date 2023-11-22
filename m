Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2B7F456A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbjKVMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjKVMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:10:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87698D6F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:10:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E0C433C9;
        Wed, 22 Nov 2023 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700655038;
        bh=wl0JFYvB32NP7y30q+NX9TJJbF3cXUAoYsHbwutxyDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8PF9xHLNQicGYNp8JtaNyx/n8NDLkfwt2tBPdzukJLzsRucicY7f/SIUft+4P54x
         7RuPTI8ETjaKi9ABpt5831/IdepwzgPfvCET6UsbhBN2/ZpPgdnZEt/TGd5IkwUPgW
         mRsQpX+OmnWmBwBINOlxM69RtI6EUvVlshgHQMhs=
Date:   Wed, 22 Nov 2023 12:10:34 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     joel@jms.id.au, andrew@codeconstruct.com.au,
        andriy.shevchenko@linux.intel.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kunwu.chan@hotmail.com,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
Message-ID: <2023112236-bullseye-pranker-491e@gregkh>
References: <20231122014212.304254-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122014212.304254-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 148d7ec3ebf4..e0854e878411 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
>  	ep->vhub = vhub;
>  	ep->ep.ops = &ast_vhub_epn_ops;
>  	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
> +	if (!ep->ep.name)
> +		return NULL;

This will break things if this ever triggers.  How was this tested?  The
"slot" for this device will still be seen as used and so the resources
never freed and then you can run out of space for real devices, right?

Looks like the other error handling in this function below this call is
also broken, can you fix that up too?

thanks,

greg k-h
