Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C217D9091
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjJ0IDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjJ0IDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:03:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F31BD;
        Fri, 27 Oct 2023 01:03:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20AA6669;
        Fri, 27 Oct 2023 10:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698393776;
        bh=XBUsbRDaPiyitopG0DEbk3R5O/2FPzd2BnU2ptaoZPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQZwmdMUSDW0XXeU9cMmkQdVq93futIpC+O3rvEz084T6zswzJWyxuh44A7+620NS
         aLc5HB0p5v5X2Z5MGHwkxoE/JpFpThV3N8Th2oqk6PYhEvdJF1eH/9477cpAHCx5dZ
         8ewJAsoI1fMBzjRRcLjW9PQEPC1yD3phZGqSs71g=
Date:   Fri, 27 Oct 2023 11:03:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Shuzhen Wang <shuzhenwang@google.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Add missing initialization of ssp
 config descriptor
Message-ID: <20231027080315.GK26306@pendragon.ideasonboard.com>
References: <14ceb63f-1769-4025-ad90-c38112dfec79@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14ceb63f-1769-4025-ad90-c38112dfec79@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuzhen,

Thank you for the patch.

On Thu, Oct 26, 2023 at 12:29:02PM -0700, Shuzhen Wang wrote:
> In case the uvc gadget is super speed plus, the corresponding config
> descriptor wasn't initialized. As a result, the host will not recognize
> the devices when using super speed plus connection.
> 
> This patch initializes them to super speed descriptors.
> 
> Signed-off-by: Shuzhen Wang <shuzhenwang@google.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>   drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index faa398109431..786379f1b7b7 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -516,6 +516,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
>   	void *mem;
>   
>   	switch (speed) {
> +	case USB_SPEED_SUPER_PLUS:
>   	case USB_SPEED_SUPER:
>   		uvc_control_desc = uvc->desc.ss_control;
>   		uvc_streaming_cls = uvc->desc.ss_streaming;
> @@ -564,7 +565,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
>   		bytes += uvc_interrupt_ep.bLength + uvc_interrupt_cs_ep.bLength;
>   		n_desc += 2;
>   
> -		if (speed == USB_SPEED_SUPER) {
> +		if (speed == USB_SPEED_SUPER ||
> +		    speed == USB_SPEED_SUPER_PLUS) {
>   			bytes += uvc_ss_interrupt_comp.bLength;
>   			n_desc += 1;
>   		}
> @@ -619,7 +621,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
>   
>   	if (uvc->enable_interrupt_ep) {
>   		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_ep);
> -		if (speed == USB_SPEED_SUPER)
> +		if (speed == USB_SPEED_SUPER ||
> +		    speed == USB_SPEED_SUPER_PLUS)
>   			UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_interrupt_comp);
>   
>   		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_cs_ep);
> @@ -795,6 +798,13 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>   		goto error;
>   	}
>   
> +	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
> +	if (IS_ERR(f->ssp_descriptors)) {
> +		ret = PTR_ERR(f->ssp_descriptors);
> +		f->ssp_descriptors = NULL;
> +		goto error;
> +	}
> +
>   	/* Preallocate control endpoint request. */
>   	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
>   	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);

-- 
Regards,

Laurent Pinchart
