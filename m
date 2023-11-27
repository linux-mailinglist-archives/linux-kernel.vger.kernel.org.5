Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C77FA0C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjK0NTt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjK0NTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:19:47 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CDB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:19:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bUD-0007pG-Nn; Mon, 27 Nov 2023 14:17:17 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bUB-00BxG9-Dp; Mon, 27 Nov 2023 14:17:15 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bUB-000Cxr-18;
        Mon, 27 Nov 2023 14:17:15 +0100
Message-ID: <939b96b8727054729207211f25ff91ccf8328e28.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/2] phy: starfive: Add mipi dphy tx support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Shengyang Chen <shengyang.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        minda.chen@starfivetech.com, changhuang.liang@starfivetech.com,
        rogerq@kernel.org, geert+renesas@glider.be,
        keith.zhao@starfivetech.com, linux-kernel@vger.kernel.org
Date:   Mon, 27 Nov 2023 14:17:15 +0100
In-Reply-To: <20231117130421.79261-3-shengyang.chen@starfivetech.com>
References: <20231117130421.79261-1-shengyang.chen@starfivetech.com>
         <20231117130421.79261-3-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2023-11-17 at 21:04 +0800, Shengyang Chen wrote:
> Add mipi dphy tx support for the StarFive JH7110 SoC.
> It is used to transfer DSI data.
> 
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> ---
[...]
> diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> new file mode 100644
> index 000000000000..69aa172563e4
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> @@ -0,0 +1,542 @@
[...]
> +static int stf_dphy_probe(struct platform_device *pdev)
> +{
[...]
> +	dphy->topsys = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dphy->topsys)) {
> +		ret = PTR_ERR(dphy->topsys);
> +		return ret;

This could be shortened to:

		return PTR_ERR(dphy->topsys);

> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	dphy->mipitx_0p9 = devm_regulator_get(&pdev->dev, "mipi_0p9");
> +	if (IS_ERR(dphy->mipitx_0p9)) {
> +		ret = PTR_ERR(dphy->mipitx_0p9);
> +		return ret;

Same as above.

> +	}
> +
> +	dphy->txesc_clk = devm_clk_get(&pdev->dev, "dphy_txesc");
> +	if (IS_ERR(dphy->txesc_clk)) {
> +		ret = PTR_ERR(dphy->txesc_clk);
> +		dev_err(&pdev->dev, "txesc_clk get error\n");
> +		return ret;

Consider using dev_err_probe():

		return dev_err_probe(&pdev->dev, PTR_ERR(dphy->txesc_clk),
				     "txesc_clk get error\n");

And the same for the error paths below.

> +	}
> +
> +	dphy->sys_rst = reset_control_get_exclusive(&pdev->dev, "dphy_sys");

Why not devm_reset_control_get_exclusive()?

> +	if (IS_ERR(dphy->sys_rst)) {
> +		ret = PTR_ERR(dphy->sys_rst);
> +		dev_err(&pdev->dev, "sys_rst get error\n");
> +		return ret;
> +	}
> +
> +	dphy->txbytehs_rst = reset_control_get_exclusive(&pdev->dev, "dsi_txbytehs");

Same as above.

> +	if (IS_ERR(dphy->txbytehs_rst)) {
> +		dev_err(&pdev->dev, "Failed to get txbytehs_rst\n");
> +		return PTR_ERR(dphy->txbytehs_rst);
> +	}
> +
> +	dphy->phy = devm_phy_create(&pdev->dev, NULL, &stf_dphy_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		ret = PTR_ERR(dphy->phy);
> +		dev_err(&pdev->dev, "Failed to create phy\n");
> +		return ret;
> +	}
> +	phy_set_drvdata(dphy->phy, dphy);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret = PTR_ERR(phy_provider);
> +		dev_err(&pdev->dev, "Failed to create phy\n");
> +		return ret;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);

This can not be reached in the error case, so just:

	return 0;

should suffice.


regards
Philipp
