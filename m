Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E57DF565
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjKBOzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKBOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:55:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A311B;
        Thu,  2 Nov 2023 07:55:45 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BDCD8C1;
        Thu,  2 Nov 2023 15:55:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698936924;
        bh=rXfEvh5nSr6U891GXJKcDjrkDgnjLsjVT9M6OziGS48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cs+pJMCX0wUvva8pWbLz1gR2aD+BiJ5yIzUwgNgLSVoobUb9ksmuXPU8SVpAxe/43
         qklVgY+qe8srVlTSLNPa/gKMEJTRRcUX6T32qu5odxP6qqYmMncU2JLqIb9zDaton5
         4ZHs6UUPPPrnTHIEHPRKX4mImhuCRI/i2pGxaCqU=
Date:   Thu, 2 Nov 2023 15:55:39 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
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
Message-ID: <g4btjscnffrzhip2lys7wezk5acebho44g6kawc5fc5p47pqxs@4lch6fjqesec>
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

Hi Alexandra

On Thu, Nov 02, 2023 at 05:11:33PM +0300, Alexandra Diupina wrote:
> media_entity_pads_init() will not return 0 only if the
> 2nd parameter >= MEDIA_ENTITY_MAX_PADS (512), but 1 is
> passed, so checking the return value is redundant

I do also see

          if (hweight32(iter->flags & (MEDIA_PAD_FL_SINK |
                                       MEDIA_PAD_FL_SOURCE)) != 1) {
                  ret = -EINVAL;
                  break;
          }

as a possible failure in in media_entity_pads_init().

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")

And this does not really qualify as a fix imho

In general, being defensive and check for return errors in not a bad
thing. I would keep the check in place, it really doesn't hurt.

Same for the other patches in the series.

Thanks
  j

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
> --
> 2.30.2
>
