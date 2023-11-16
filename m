Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66637EE13E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjKPNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjKPNOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:14:42 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0AFD4F;
        Thu, 16 Nov 2023 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700140475; bh=y2DhplH7I27Y0L2UWkQcKl1WHDTXBalYzLOWjRTlj8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=leGw3WNbo2KRqITmwNwKgZPplnr5hMIkay12M2b/Wl9w+/+2yjd4pReXQuTxdbRjF
         yhdNm35PTw3RaSisMuXuGXCW/noR7gh5lLHIZJE5rgT3OU4GNKQs9j8hpKaE1HGk0M
         tQeIq/xB8FHIgADALHWQfkNV5eRWd35fiUd7XYO1VXN3C1r6n4PVWBQC4Ioa+BEEpY
         O4aB+FkTvdxNFsZhODq89y7O+PPpXaWJ8BANRQuHrbHAvX8xl0lNIB1/QiZ5Fv0KP2
         VNpIlf/vzieRZpQaPmN1xHZnewatfhuuBePb4H16wYgRTYJHuGnJM6brvyNw5R5YZD
         XIlkQNK686lCQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id A311F1000AC; Thu, 16 Nov 2023 13:14:35 +0000 (GMT)
Date:   Thu, 16 Nov 2023 13:14:35 +0000
From:   Sean Young <sean@mess.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] media: ir-hix5hd2: Use device_get_match_data()
Message-ID: <ZVYVu-fiM6dETizU@gofer.mess.org>
References: <20231115210113.3738233-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115210113.3738233-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:01:13PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.

This is now applied. Sorry about the delay.

Thanks
Sean

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/media/rc/ir-hix5hd2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
> index 0034f615b466..de5bb9a08ea4 100644
> --- a/drivers/media/rc/ir-hix5hd2.c
> +++ b/drivers/media/rc/ir-hix5hd2.c
> @@ -9,7 +9,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <media/rc-core.h>
>  
> @@ -251,7 +253,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct hix5hd2_ir_priv *priv;
>  	struct device_node *node = pdev->dev.of_node;
> -	const struct of_device_id *of_id;
>  	const char *map_name;
>  	int ret;
>  
> @@ -259,12 +260,11 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	of_id = of_match_device(hix5hd2_ir_table, dev);
> -	if (!of_id) {
> +	priv->socdata = device_get_match_data(dev);
> +	if (!priv->socdata) {
>  		dev_err(dev, "Unable to initialize IR data\n");
>  		return -ENODEV;
>  	}
> -	priv->socdata = of_id->data;
>  
>  	priv->regmap = syscon_regmap_lookup_by_phandle(node,
>  						       "hisilicon,power-syscon");
> -- 
> 2.42.0
> 
