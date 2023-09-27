Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B827B0598
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjI0NjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjI0NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:39:02 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6B2DA10A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:38:58 -0700 (PDT)
Received: (qmail 1499780 invoked by uid 1000); 27 Sep 2023 09:38:57 -0400
Date:   Wed, 27 Sep 2023 09:38:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v5] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
Message-ID: <aa8db441-766c-4b2f-8062-ec3dd9067789@rowland.harvard.edu>
References: <20230927073027.27952-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927073027.27952-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:00:27PM +0530, Krishna Kurapati wrote:
> In the event gadget_connect call (which invokes pullup) fails,
> propagate the error to udc bind operation which in turn sends the
> error to configfs. The userspace can then retry enumeration if
> it chooses to.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Changes in v5: Addressed proper unlocking of control_lock mutex

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/udc/core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 7d49d8a0b00c..824fe64e078a 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1125,12 +1125,12 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>  /* ------------------------------------------------------------------------- */
>  
>  /* Acquire connect_lock before calling this function. */
> -static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
> +static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
>  {
>  	if (udc->vbus)
> -		usb_gadget_connect_locked(udc->gadget);
> +		return usb_gadget_connect_locked(udc->gadget);
>  	else
> -		usb_gadget_disconnect_locked(udc->gadget);
> +		return usb_gadget_disconnect_locked(udc->gadget);
>  }
>  
>  static void vbus_event_work(struct work_struct *work)
> @@ -1604,12 +1604,23 @@ static int gadget_bind_driver(struct device *dev)
>  	}
>  	usb_gadget_enable_async_callbacks(udc);
>  	udc->allow_connect = true;
> -	usb_udc_connect_control_locked(udc);
> +	ret = usb_udc_connect_control_locked(udc);
> +	if (ret)
> +		goto err_connect_control;
> +
>  	mutex_unlock(&udc->connect_lock);
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>  	return 0;
>  
> + err_connect_control:
> +	udc->allow_connect = false;
> +	usb_gadget_disable_async_callbacks(udc);
> +	if (gadget->irq)
> +		synchronize_irq(gadget->irq);
> +	usb_gadget_udc_stop_locked(udc);
> +	mutex_unlock(&udc->connect_lock);
> +
>   err_start:
>  	driver->unbind(udc->gadget);
>  
> -- 
> 2.42.0
> 
