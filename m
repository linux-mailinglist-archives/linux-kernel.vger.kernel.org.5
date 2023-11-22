Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98F7F47D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjKVNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbjKVNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:32:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1413BC;
        Wed, 22 Nov 2023 05:32:19 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 05306276;
        Wed, 22 Nov 2023 14:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700659907;
        bh=E5/m/rqwfREn1ed0gWEEq3irr5h/sFczHfzDfuCVRaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/eiRLiiFnEZlQBVQA6UwO2FVnWMQptylAS2QIwiYJKVq6nl3IBykaDM2fYB5hlWh
         BNH37s20AHoR57bp+gl01GHWWKNE4D05BGjZNXYm3aNPXW5LW041E2bTYb46/H+ohi
         27zmWo8btF+A0dryOD9S8kaUHUqylOGaoCclxeLk=
Date:   Wed, 22 Nov 2023 15:32:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: Always use uvc_status_stop()
Message-ID: <20231122133224.GD3909@pendragon.ideasonboard.com>
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-2-15d8cd8ed74f@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122-guenter-mini-v5-2-15d8cd8ed74f@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Wed, Nov 22, 2023 at 11:45:48AM +0000, Ricardo Ribalda wrote:
> The only thread safe way to stop the status handler is with uvc_status.

The commit message should explain why.

> Let's remove all the code paths partially stopping uvc_status.

And should explain what the implications are.

> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 4 ----
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  drivers/media/usb/uvc/uvc_status.c | 8 ++++----
>  drivers/media/usb/uvc/uvc_v4l2.c   | 2 +-
>  drivers/media/usb/uvc/uvcvideo.h   | 2 +-
>  5 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index e59a463c2761..8e22a07e3e7b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2765,10 +2765,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
>  	struct uvc_entity *entity;
>  	unsigned int i;
>  
> -	/* Can be uninitialized if we are aborting on probe error. */
> -	if (dev->async_ctrl.work.func)
> -		cancel_work_sync(&dev->async_ctrl.work);
> -
>  	/* Free controls and control mappings for all entities. */
>  	list_for_each_entry(entity, &dev->entities, list) {
>  		for (i = 0; i < entity->ncontrols; ++i) {
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index ded2cb6ce14f..d5dbf2644272 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2282,7 +2282,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
>  	    UVC_SC_VIDEOCONTROL) {
>  		mutex_lock(&dev->lock);
>  		if (dev->users)
> -			uvc_status_stop(dev);
> +			uvc_status_stop(dev, true);
>  		mutex_unlock(&dev->lock);
>  		return 0;
>  	}
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index a78a88c710e2..9c5da1244999 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
>  
>  void uvc_status_unregister(struct uvc_device *dev)
>  {
> -	usb_kill_urb(dev->int_urb);
> +	uvc_status_stop(dev, false);
>  	uvc_input_unregister(dev);
>  }
>  
> @@ -310,7 +310,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags)
>  	return usb_submit_urb(dev->int_urb, flags);
>  }
>  
> -void uvc_status_stop(struct uvc_device *dev)
> +void uvc_status_stop(struct uvc_device *dev, bool run_async_work)
>  {
>  	struct uvc_ctrl_work *w = &dev->async_ctrl;
>  
> @@ -326,7 +326,7 @@ void uvc_status_stop(struct uvc_device *dev)
>  	 * Cancel any pending asynchronous work. If any status event was queued,
>  	 * process it synchronously.
>  	 */
> -	if (cancel_work_sync(&w->work))
> +	if (cancel_work_sync(&w->work) && run_async_work)
>  		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
>  
>  	/* Kill the urb. */
> @@ -338,7 +338,7 @@ void uvc_status_stop(struct uvc_device *dev)
>  	 * cancelled before returning or it could then race with a future
>  	 * uvc_status_start() call.
>  	 */
> -	if (cancel_work_sync(&w->work))
> +	if (cancel_work_sync(&w->work) && run_async_work)
>  		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
>  
>  	/*
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4988f03640a..f90206263ff4 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -672,7 +672,7 @@ static int uvc_v4l2_release(struct file *file)
>  
>  	mutex_lock(&stream->dev->lock);
>  	if (--stream->dev->users == 0)
> -		uvc_status_stop(stream->dev);
> +		uvc_status_stop(stream->dev, false);
>  	mutex_unlock(&stream->dev->lock);
>  
>  	usb_autopm_put_interface(stream->dev->intf);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6fb0a78b1b00..ba8f8c1f2c83 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -745,7 +745,7 @@ int uvc_status_init(struct uvc_device *dev);
>  void uvc_status_unregister(struct uvc_device *dev);
>  void uvc_status_cleanup(struct uvc_device *dev);
>  int uvc_status_start(struct uvc_device *dev, gfp_t flags);
> -void uvc_status_stop(struct uvc_device *dev);
> +void uvc_status_stop(struct uvc_device *dev, bool run_async_work);
>  
>  /* Controls */
>  extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
> 

-- 
Regards,

Laurent Pinchart
