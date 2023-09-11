Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11BD79BCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354434AbjIKVyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjIKJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:07:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C27CCC;
        Mon, 11 Sep 2023 02:07:42 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9C1C9D5;
        Mon, 11 Sep 2023 11:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694423171;
        bh=dB3BAFn1tvsxsRIUshagD2Y62dXixykRmP5IatNzS/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9ducT+tCgVKKj2LoRNLZxnWo0jmgFjKp9kXI2vWDubJEC/0wXqXt7JGGkEiNU0BU
         lKoq7HH6k0a5wSC611dLgAQNAmNaWKOYLbi/dvVQVxWiDGPr7XfsPX+H702fZkF+Px
         W8BuV2Vtf02IgpkuhMboV6Siv6kM8sYPp1ojpZCU=
Date:   Mon, 11 Sep 2023 11:07:38 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] media: mt9p031: Drop CONFIG_OF ifdeffery
Message-ID: <tgsuqxirofyrbz4cg2ougwa2auhs57qzlheqj4sbt36rxi4o5r@gfi3mypt2rdv>
References: <20230910160126.70122-1-biju.das.jz@bp.renesas.com>
 <20230910160126.70122-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910160126.70122-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 05:01:26PM +0100, Biju Das wrote:
> Drop of_match_ptr() from mt9p031_i2c_driver and get rid of ugly CONFIG_OF
> if check. This slightly increases the size of mt9p031_i2c_driver on non-OF
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
>  drivers/media/i2c/mt9p031.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> index 540cb519915c..91d5de5b95f0 100644
> --- a/drivers/media/i2c/mt9p031.c
> +++ b/drivers/media/i2c/mt9p031.c
> @@ -15,6 +15,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/log2.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
> @@ -1222,7 +1223,6 @@ static const struct i2c_device_id mt9p031_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mt9p031_id);
>
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id mt9p031_of_match[] = {
>  	{ .compatible = "aptina,mt9p006", .data = (void *)MEDIA_BUS_FMT_SGRBG12_1X12 },
>  	{ .compatible = "aptina,mt9p031", .data = (void *)MEDIA_BUS_FMT_SGRBG12_1X12 },
> @@ -1230,11 +1230,10 @@ static const struct of_device_id mt9p031_of_match[] = {
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mt9p031_of_match);
> -#endif
>
>  static struct i2c_driver mt9p031_i2c_driver = {
>  	.driver = {
> -		.of_match_table = of_match_ptr(mt9p031_of_match),
> +		.of_match_table = mt9p031_of_match,
>  		.name = "mt9p031",
>  	},
>  	.probe          = mt9p031_probe,
> --
> 2.25.1
>
