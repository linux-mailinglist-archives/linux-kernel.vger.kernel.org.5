Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F068D80D525
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjLKSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:19:23 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D395;
        Mon, 11 Dec 2023 10:19:29 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 274C0922;
        Mon, 11 Dec 2023 19:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702318724;
        bh=EIg4EO4Pq5viQln2mk2Z+mPdeO40bI0I0QIxtK3AB8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSNxKmzxVGwUHs/fJsZ2OsIyU/O1sYytP/uWYGE1ItV1/l+JIi+baiBxLbNDo6WAV
         aU2iyIrJNjNVcGIVL/X3g3UFqKHFkh56HLbdvHBbfT3mnneTF3btn6DGc/JYA4vLXy
         yqrrSsovOvwK6aLwDR/Zz+yxu0F1va4ZTyW+7LRc=
Date:   Mon, 11 Dec 2023 20:19:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 08/19] media: i2c: ov4689: Enable runtime PM before
 registering sub-device
Message-ID: <20231211181935.GG27535@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-9-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211175023.1680247-9-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 11, 2023 at 08:50:11PM +0300, Mikhail Rudenko wrote:
> As the sensor may be accessible right after its async sub-device is
> registered, enable runtime PM before doing so.

While at it, could you also switch to runtime PM autosuspend, possibly
in a separate patch ? See for instance the imx290 driver.

> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 2eef64cd0070..ba33b0ced532 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -874,16 +874,16 @@ static int ov4689_probe(struct i2c_client *client)
>  		goto err_clean_entity;
>  	}
>  
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_idle(dev);
> +
>  	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret) {
>  		dev_err(dev, "v4l2 async register subdev failed\n");
>  		goto err_clean_subdev;

Don't you need to disable runtime PM in the error path ?

>  	}
>  
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -	pm_runtime_idle(dev);
> -
>  	return 0;
>  
>  err_clean_subdev:

-- 
Regards,

Laurent Pinchart
