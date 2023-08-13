Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC777AA89
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHMSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5610CE;
        Sun, 13 Aug 2023 11:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E7961344;
        Sun, 13 Aug 2023 18:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21AC433C8;
        Sun, 13 Aug 2023 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691951060;
        bh=wafaiX+7NIalhVrFxtCoQeOwe8RD/H1orkbikL1Pz98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npS1YE7Q63hnAa/vcBYVkRgcf2caax4v8+OxC4AOKufDFadnJ7yClFzj1rNFOn82H
         KmkqST7Lc+v8MWgSjN+xlFlq2mFnN+gSl+tAUb10ktGxazkWeUjupPPjKIVmyGDlDu
         iZCBjfSLtN7YTj4raJVLYN8tpYU16wLSl+2wM4r8yayMrbWTuz3yDBE/09JC2ueNss
         zD7icQTCVsHy+8F5dPTKT4u7ebE9InzobG6rkhTpRRiPR0ALrZLcIr/hYrQ97X8BpY
         52Yrhk2efj/lh8WYFE0qLo0uslgLVgGfqknNuiE4pkcJNowEkFMT2hSxNn6x6Y5ebK
         g+4I/nCpqRq+g==
Date:   Sun, 13 Aug 2023 20:24:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <ZNkfz1yKD90XmTFL@vergenet.net>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-5-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151135.1028780-5-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:11:34PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partialy based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

...

Hi Keguang Zhang,

some minor feedback from my side.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

...

> +const struct reg_field ls1b_dwmac_syscon_regfields[] = {
> +	[GMAC1_USE_UART1]	= REG_FIELD(LS1X_SYSCON0, 4, 4),
> +	[GMAC1_USE_UART0]	= REG_FIELD(LS1X_SYSCON0, 3, 3),
> +	[GMAC1_SHUT]		= REG_FIELD(LS1X_SYSCON1, 13, 13),
> +	[GMAC0_SHUT]		= REG_FIELD(LS1X_SYSCON1, 12, 12),
> +	[GMAC1_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 3, 3),
> +	[GMAC0_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 2, 2),
> +	[GMAC1_USE_PWM23]	= REG_FIELD(LS1X_SYSCON1, 1, 1),
> +	[GMAC0_USE_PWM01]	= REG_FIELD(LS1X_SYSCON1, 0, 0)
> +};

nit: Perhaps ls1b_dwmac_syscon_regfields should be static.

> +
> +const struct reg_field ls1c_dwmac_syscon_regfields[] = {
> +	[GMAC_SHUT]		= REG_FIELD(LS1X_SYSCON0, 6, 6),
> +	[PHY_INTF_SELI]		= REG_FIELD(LS1X_SYSCON1, 28, 30)
> +};

Likewise, perhaps ls1c_dwmac_syscon_regfields should be static.

...

> +static const struct of_device_id ls1x_dwmac_syscon_match[] = {
> +	{ .compatible = "loongson,ls1b-syscon", .data = &ls1b_dwmac_syscon },
> +	{ .compatible = "loongson,ls1c-syscon", .data = &ls1c_dwmac_syscon },
> +	{ }
> +};o

I am seeing a warning about ls1x_dwmac_syscon_match being unused.
I think this is due to CONFIG_OF being unset.

> +
> +static int ls1x_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct device_node *syscon_np;
> +	const struct of_device_id *match;
> +	struct regmap *regmap;
> +	struct ls1x_dwmac *dwmac;
> +	const struct ls1x_dwmac_syscon *syscon;
> +	size_t size;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	/* Probe syscon */
> +	syscon_np = of_parse_phandle(pdev->dev.of_node, "syscon", 0);
> +	if (!syscon_np)
> +		return -ENODEV;
> +
> +	match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
> +	if (!match) {
> +		of_node_put(syscon_np);
> +		return -EINVAL;
> +	}
> +	syscon = (const struct ls1x_dwmac_syscon *)match->data;
> +
> +	regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> +		return ret;
> +	}
> +
> +	size = syscon->nr_reg_fields * sizeof(struct regmap_field *);
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat)) {
> +		dev_err(&pdev->dev, "dt configuration failed\n");
> +		return PTR_ERR(plat_dat);
> +	}
> +
> +	plat_dat->bsp_priv = dwmac;
> +	plat_dat->init = ls1x_dwmac_init;
> +	dwmac->dev = &pdev->dev;
> +	dwmac->plat_dat = plat_dat;
> +	dwmac->syscon = syscon;
> +	dwmac->regmap = regmap;
> +
> +	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> +	if (ret)
> +		goto err_remove_config_dt;
> +
> +	return 0;
> +
> +err_remove_config_dt:
> +	if (pdev->dev.of_node)
> +		stmmac_remove_config_dt(pdev, plat_dat);
> +
> +	return ret;
> +}

...
