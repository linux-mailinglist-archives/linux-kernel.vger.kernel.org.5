Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2179A5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjIKIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjIKIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:14:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE397;
        Mon, 11 Sep 2023 01:13:55 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E70FF475;
        Mon, 11 Sep 2023 10:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694419943;
        bh=jMjVS+X+BJhkZ5ZtTK2NO1bAfqBZCSUY/eVqYfaO0ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVpGRIB/Ar2tXrDuI7s56KqugK3oRzhq3D5brPxDZ5e01Zv0CQGsdNSsGBZwZ5XIe
         1gK/yc/EPb59+ZisgL+O6nB12r3mwN7+NjI/Poy5grqewFv1i7fn+oNQtvcI+jna5N
         NOPjzej9fvqiN1MpFkdFEObT9cR2F/OpeHi+Oh4A=
Date:   Mon, 11 Sep 2023 10:13:50 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] media: i2c: ov7670: Drop CONFIG_OF ifdeffery
Message-ID: <2ix6sdl6eqhin6l4crrfxyv27pxhhleuq2brbv3qaiwketdau2@a2katkkorxte>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
 <20230910150033.50596-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910150033.50596-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 04:00:33PM +0100, Biju Das wrote:
> Drop of_match_ptr() from ov7670_driver and get rid of ugly CONFIG_OF
> if check. This slightly increases the size of ov7670_driver on non-OF
> system and shouldn't be an issue.
>
> Add mod_devicetable.h include.
>
> It also allows, in case if needed, to enumerate this device via ACPI with
> PRP0001 magic.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/media/i2c/ov7670.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> index 644457e6993d..41032394a464 100644
> --- a/drivers/media/i2c/ov7670.c
> +++ b/drivers/media/i2c/ov7670.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/init.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> @@ -2013,18 +2014,16 @@ static const struct i2c_device_id ov7670_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ov7670_id);
>
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id ov7670_of_match[] = {
>  	{ .compatible = "ovti,ov7670", &ov7670_devdata },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, ov7670_of_match);
> -#endif
>
>  static struct i2c_driver ov7670_driver = {
>  	.driver = {
>  		.name	= "ov7670",
> -		.of_match_table = of_match_ptr(ov7670_of_match),
> +		.of_match_table = ov7670_of_match,

While at it, but possibily separate from this patch, all the

#if defined(CONFIG_MEDIA_CONTROLLER)

entries could be removed as well, as since commit 7d3c7d2a2914
("media: i2c: Add a camera sensor top level menu") the
MEDIA_CONTROLLER symbol is selected by the top-level menu.

Let me know if you intended to send a patch or should I.

For this one:
Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j



>  	},
>  	.probe		= ov7670_probe,
>  	.remove		= ov7670_remove,
> --
> 2.25.1
>
