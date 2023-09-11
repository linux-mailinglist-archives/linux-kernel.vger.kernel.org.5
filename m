Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0A79AE32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbjIKWie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjIKJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:14:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D1CCD;
        Mon, 11 Sep 2023 02:14:48 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B2859D5;
        Mon, 11 Sep 2023 11:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694423596;
        bh=VmW8CICYyfHZztwyCx9rRM1MR97iFuFrCYYGuaW2uEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfcJybmjfFvRA3412DuyTwyYgOBR8vcfgkW2k5jgO2CuQpVn+OHbs++rTYXBRyhC+
         Cc7cWCW9EuFkUa7rw62D4V8fmG0KrMGWFcftih/GVNDXo2GMD1nOQcxs70+NBndtM4
         VEPDXoc9PaX48RLnZxfd5C/HvNNzPfuKybUbGiW4=
Date:   Mon, 11 Sep 2023 11:14:43 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] media: i2c: mt9v032: Drop CONFIG_OF ifdeffery
Message-ID: <tyxele5dmdduwars6mh254hsixvsrpuwnap6lsuvxq6gl5pd4j@sdilwej4qukr>
References: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
 <20230910165432.76378-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910165432.76378-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 05:54:32PM +0100, Biju Das wrote:
> Drop of_match_ptr() from mt9v032_driver and get rid of ugly CONFIG_OF
> if check. This slightly increases the size of mt9v032_driver on non-OF
> system and shouldn't be an issue.
>
> Add mod_devicetable.h include.
>
> It also allows, in case if needed, to enumerate this device via ACPI with
> PRP0001 magic.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/i2c/mt9v032.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
> index 0f448aa27e53..1c6f6cea1204 100644
> --- a/drivers/media/i2c/mt9v032.c
> +++ b/drivers/media/i2c/mt9v032.c
> @@ -14,6 +14,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/log2.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
> @@ -1275,7 +1276,6 @@ static const struct i2c_device_id mt9v032_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mt9v032_id);
>
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id mt9v032_of_match[] = {
>  	{ .compatible = "aptina,mt9v022", .data = &mt9v032_models[MT9V032_MODEL_V022_COLOR] },
>  	{ .compatible = "aptina,mt9v022m", .data = &mt9v032_models[MT9V032_MODEL_V022_MONO] },
> @@ -1288,12 +1288,11 @@ static const struct of_device_id mt9v032_of_match[] = {
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mt9v032_of_match);
> -#endif
>
>  static struct i2c_driver mt9v032_driver = {
>  	.driver = {
>  		.name = "mt9v032",
> -		.of_match_table = of_match_ptr(mt9v032_of_match),
> +		.of_match_table = mt9v032_of_match,
>  	},
>  	.probe		= mt9v032_probe,
>  	.remove		= mt9v032_remove,
> --
> 2.25.1
>
