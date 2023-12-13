Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59988119FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377698AbjLMQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:47:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128D8E;
        Wed, 13 Dec 2023 08:47:30 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1735166F;
        Wed, 13 Dec 2023 17:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702486003;
        bh=Xb0hnvp6j1flRuOPnAQ9U+s1v//0z7ARgZLX3J6aAdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nonG48jpReFfU9nioA7SEY8/B/b8cPO27dm6vAnGLllBYmkvw6UDT+Tqn9o0/li24
         02vpkfT/gZjB73g2S6t4uPkr/Uog5RS460tHrASq3lYaDUqwGRt8hprZO6yUo7T712
         nU9Px36aGlxxux47Im8b7nm2G0YlEqVshoepawdE=
Date:   Wed, 13 Dec 2023 18:47:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Subject: Re: [PATCH 04/12] usb: gadget: uvc: Replace snprintf() with the
 safer scnprintf() variant
Message-ID: <20231213164735.GA17912@pendragon.ideasonboard.com>
References: <20231213164246.1021885-1-lee@kernel.org>
 <20231213164246.1021885-5-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213164246.1021885-5-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Wed, Dec 13, 2023 at 04:42:33PM +0000, Lee Jones wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Daniel Scally <dan.scally@ideasonboard.com>
> Cc: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/usb/gadget/function/uvc_configfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index 9bf0e985acfab..7e704b2bcfd1c 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -3414,7 +3414,7 @@ static ssize_t f_uvc_opts_string_##cname##_show(struct config_item *item,\
>  	int result;							\
>  									\
>  	mutex_lock(&opts->lock);					\
> -	result = snprintf(page, sizeof(opts->aname), "%s", opts->aname);\
> +	result = scnprintf(page, sizeof(opts->aname), "%s", opts->aname);\
>  	mutex_unlock(&opts->lock);					\
>  									\
>  	return result;							\

-- 
Regards,

Laurent Pinchart
