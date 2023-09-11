Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61479B460
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjIKVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjIKKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:10:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4D101;
        Mon, 11 Sep 2023 03:10:06 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D00C8B2A;
        Mon, 11 Sep 2023 12:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694426914;
        bh=/ISdF3ZWqCC3m3XdTKU5hMPPy5+kefEf4U55lLjJphw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLfiuZM6AgsxMBNHyXlZE41+sdgyH8lra/byIEQQWT6h/cCpzfARcWA+ZYFKIpuj+
         Fjy4F4ypB2g6ER6gbDZRuxLxWJzqUI/nHzwx5twjUOmXVneBV/6AcDfkBqNmYmftlb
         lgqBox8d2DUO+l3XV7bAcTJ4GMaWahXqA8JVJnXw=
Date:   Mon, 11 Sep 2023 12:10:00 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] media: tvp541x: Drop CONFIG_OF ifdeffery
Message-ID: <dgstv2on2hc2drl5ydnwz6ago6t7wwurgpwohuazx55ao2wtna@2smdk7sv2kty>
References: <20230910174051.85070-1-biju.das.jz@bp.renesas.com>
 <20230910174051.85070-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910174051.85070-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 06:40:51PM +0100, Biju Das wrote:
> Drop of_match_ptr() from tvp514x_driver and get rid of ugly CONFIG_OF
> if check. This slightly increases the size of tvp514x_driver on non-OF
> system and shouldn't be an issue.
>
> Add mod_devicetable.h include.
>
> It also allows, in case if needed, to enumerate this device via ACPI with
> PRP0001 magic.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/media/i2c/tvp514x.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/tvp514x.c b/drivers/media/i2c/tvp514x.c
> index 4d0ffaa312c5..569a9437ec86 100644
> --- a/drivers/media/i2c/tvp514x.c
> +++ b/drivers/media/i2c/tvp514x.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/videodev2.h>
> +#include <linux/mod_devicetable.h>

Might be a good occasion for alphabetically sorting the inclusions..

>  #include <linux/module.h>
>  #include <linux/v4l2-mediabus.h>
>  #include <linux/of.h>
> @@ -1190,7 +1191,6 @@ static const struct i2c_device_id tvp514x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tvp514x_id);
>
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id tvp514x_of_match[] = {
>  	{ .compatible = "ti,tvp5146", .data = tvp5146_init_reg_seq },
>  	{ .compatible = "ti,tvp5146m2", .data = tvp514xm_init_reg_seq },
> @@ -1199,11 +1199,10 @@ static const struct of_device_id tvp514x_of_match[] = {
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, tvp514x_of_match);
> -#endif
>
>  static struct i2c_driver tvp514x_driver = {
>  	.driver = {
> -		.of_match_table = of_match_ptr(tvp514x_of_match),
> +		.of_match_table = tvp514x_of_match,

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j

>  		.name = TVP514X_MODULE_NAME,
>  	},
>  	.probe = tvp514x_probe,
> --
> 2.25.1
>
