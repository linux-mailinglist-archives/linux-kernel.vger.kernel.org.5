Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63D7DF69A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347487AbjKBPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjKBPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:38:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C81B4;
        Thu,  2 Nov 2023 08:37:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC7CA8C2;
        Thu,  2 Nov 2023 16:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698939460;
        bh=DT6KLFROME6gQwGlCCzP0AGObJaawrMfnQVmIvWpWNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYDmT76NHBPJgjme5FiNiLXeOAQot69NwrxIEc26GkBDLZkpjpCWqAPLVoBPV5kGx
         EHB58asAICMbrWB0pzaoMtfgEjGuyLAwi9OQhNFJlLdrKqTouq3D8OLkvbut4Jbyp+
         2Qex6Zc4DIF485SjXLJcjU6ZGWcEFzMc8fKr2F40=
Date:   Thu, 2 Nov 2023 17:38:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/4] Remove redundant return value check
Message-ID: <20231102153804.GA7129@pendragon.ideasonboard.com>
References: <20231102141135.369-1-adiupina@astralinux.ru>
 <20231102141135.369-2-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102141135.369-2-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:11:33PM +0300, Alexandra Diupina wrote:
> media_entity_pads_init() will not return 0 only if the
> 2nd parameter >= MEDIA_ENTITY_MAX_PADS (512), but 1 is
> passed, so checking the return value is redundant

That may be the case today, but may not be true tomorrow if the function
is extended to perform extra checks. I don't think dropping the error
check in drivers is a good idea.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/media/i2c/rdacm20.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index f4e2e2f3972a..ed249ade54e0 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -611,9 +611,7 @@ static int rdacm20_probe(struct i2c_client *client)
>  
>  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
>  	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> -	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> -	if (ret < 0)
> -		goto error_free_ctrls;
> +	media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  
>  	ret = v4l2_async_register_subdev(&dev->sd);
>  	if (ret)

-- 
Regards,

Laurent Pinchart
