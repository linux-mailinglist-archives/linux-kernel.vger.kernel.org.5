Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4275F9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:26:05 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8040CE64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:26:04 -0700 (PDT)
Received: (qmail 1848894 invoked by uid 1000); 24 Jul 2023 10:26:03 -0400
Date:   Mon, 24 Jul 2023 10:26:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] usb: gadget: core: remove unbalanced mutex_unlock in
 usb_gadget_activate
Message-ID: <b4ccd0c4-78f7-4f7c-bf6f-cae048c6e841@rowland.harvard.edu>
References: <20230721222256.1743645-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721222256.1743645-1-m.grzeschik@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 12:22:56AM +0200, Michael Grzeschik wrote:
> Commit 286d9975a838 ("usb: gadget: udc: core: Prevent soft_connect_store() race")
> introduced one extra mutex_unlock of connect_lock in the usb_gadget_active function.
> 
> Fixes: 286d9975a838 ("usb: gadget: udc: core: Prevent soft_connect_store() race")
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---

Hard to see how we missed that...

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!

>  drivers/usb/gadget/udc/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 59188ea065e0c9..cd58f2a4e7f34d 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -878,7 +878,6 @@ int usb_gadget_activate(struct usb_gadget *gadget)
>  	 */
>  	if (gadget->connected)
>  		ret = usb_gadget_connect_locked(gadget);
> -	mutex_unlock(&gadget->udc->connect_lock);
>  
>  unlock:
>  	mutex_unlock(&gadget->udc->connect_lock);
> -- 
> 2.39.2
> 
