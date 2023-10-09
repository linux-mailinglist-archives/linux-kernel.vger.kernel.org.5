Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441087BEB5A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbjJIUNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378518AbjJIUNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:13:19 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DD94
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:13:15 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qpwcs-0004w0-5H; Mon, 09 Oct 2023 22:13:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] phy: Use device_get_match_data()
Date:   Mon, 09 Oct 2023 22:13:13 +0200
Message-ID: <7578192.EvYhyI6sBW@phil>
In-Reply-To: <20231009172923.2457844-15-robh@kernel.org>
References: <20231009172923.2457844-15-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Oktober 2023, 19:29:10 CEST schrieb Rob Herring:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  drivers/phy/rockchip/phy-rockchip-pcie.c | 11 ++++-------
>  drivers/phy/rockchip/phy-rockchip-usb.c  | 10 +++-------

For the Rockchip part:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 8234b83fdd88..1bbd6be2a584 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -12,10 +12,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> @@ -63,7 +62,7 @@ struct rockchip_pcie_data {
>  };
>  
>  struct rockchip_pcie_phy {
> -	struct rockchip_pcie_data *phy_data;
> +	const struct rockchip_pcie_data *phy_data;
>  	struct regmap *reg_base;
>  	struct phy_pcie_instance {
>  		struct phy *phy;
> @@ -350,7 +349,6 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>  	struct rockchip_pcie_phy *rk_phy;
>  	struct phy_provider *phy_provider;
>  	struct regmap *grf;
> -	const struct of_device_id *of_id;
>  	int i;
>  	u32 phy_num;
>  
> @@ -364,11 +362,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>  	if (!rk_phy)
>  		return -ENOMEM;
>  
> -	of_id = of_match_device(rockchip_pcie_phy_dt_ids, &pdev->dev);
> -	if (!of_id)
> +	rk_phy->phy_data = device_get_match_data(&pdev->dev);
> +	if (!rk_phy->phy_data)
>  		return -EINVAL;
>  
> -	rk_phy->phy_data = (struct rockchip_pcie_data *)of_id->data;
>  	rk_phy->reg_base = grf;
>  
>  	mutex_init(&rk_phy->pcie_mutex);
> diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
> index 8454285977eb..666a896c8f0a 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usb.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usb.c
> @@ -13,10 +13,9 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
> @@ -458,7 +457,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct rockchip_usb_phy_base *phy_base;
>  	struct phy_provider *phy_provider;
> -	const struct of_device_id *match;
>  	struct device_node *child;
>  	int err;
>  
> @@ -466,14 +464,12 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
>  	if (!phy_base)
>  		return -ENOMEM;
>  
> -	match = of_match_device(dev->driver->of_match_table, dev);
> -	if (!match || !match->data) {
> +	phy_base->pdata = device_get_match_data(dev);
> +	if (!phy_base->pdata) {
>  		dev_err(dev, "missing phy data\n");
>  		return -EINVAL;
>  	}
>  
> -	phy_base->pdata = match->data;
> -
>  	phy_base->dev = dev;
>  	phy_base->reg_base = ERR_PTR(-ENODEV);
>  	if (dev->parent && dev->parent->of_node)



