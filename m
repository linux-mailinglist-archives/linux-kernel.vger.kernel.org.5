Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA57A26E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjIOTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjIOTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:04:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED69B2;
        Fri, 15 Sep 2023 12:04:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD95D1536;
        Fri, 15 Sep 2023 21:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694804582;
        bh=BTus/aF+ZgDyAZjR1GTDuRFC/QbxDYyGIOGOqzEYQTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0CN2sIKSQUudetuONXKVTGFx5JjajdfVh1wcxkz/3ZtaKhuVSzmDIDfuRxgUkIpr
         742ZRBlET+0MJXTB8U78BT4wASXSTZS7G9liChZD0Z9f7F2jOne1EUHsvcpG2NBahz
         eVSmQ5AJ3mm+EDIdMDgk39BHiJ4LmkqNcpFg7+hc=
Date:   Fri, 15 Sep 2023 22:04:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jerry Liu <jerry.liu@technexion.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Modified uvc_ctrl_fill_xu_info
 'kmalloc' to 'kzalloc'
Message-ID: <20230915190449.GA12131@pendragon.ideasonboard.com>
References: <20230915161213.42503-1-jerry.liu@technexion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915161213.42503-1-jerry.liu@technexion.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

Thank you for the patch.

On Fri, Sep 15, 2023 at 09:12:14AM -0700, Jerry Liu wrote:
> If the request length of UVC XU is 1 (even though this is illegal), due
> to 'data' may be the non-zero value, UVC_GET_LEN could potentially result
> in a length that is not 1 because of the high byte is not zero. In order
> to ensure that 2-byte data array is set to 0, 'kmalloc' is modified to 'kzalloc'.

I don't think this can happen. The call to uvc_query_ctrl(UVC_GET_LEN)
is given a length of 2. If the device responds with less than two bytes,
the function will return an error, and uvc_ctrl_fill_xu_info() will
propagate the error to the caller, without accessing the data array.

> 
> Signed-off-by: Jerry Liu <jerry.liu@technexion.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5e9d3da862dd..054bc14f7a58 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2088,7 +2088,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
>  	u8 *data;
>  	int ret;
>  
> -	data = kmalloc(2, GFP_KERNEL);
> +	data = kzalloc(2, GFP_KERNEL);
>  	if (data == NULL)
>  		return -ENOMEM;
>  

-- 
Regards,

Laurent Pinchart
