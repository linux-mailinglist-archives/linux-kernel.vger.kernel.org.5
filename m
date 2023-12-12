Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E469F80E959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjLLKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjLLKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:41:21 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D79F;
        Tue, 12 Dec 2023 02:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702377684;
        bh=Pe5ciwL3SPsQpwVq7FUVuzFvF3mRvfpnvBCGZoOnIj4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=iWp10SHZ7U0fy9oHiQPf+Bu1hzpR/nvJm0FgbUzaktdMaV6R3gVCxCgnr4aODxZpU
         yVo1710KxH7lY9hmjnNH3G6qrnftYxlGoyefqHtNzJnzcD66I5wpSvtqGe8ytUlpkH
         fqaobWmBwxW2CJAJhRURjo3BlJ2lkrphPFGeZnfs06EVwpTaSEb5/wG0vAY9G19vvD
         g8SrROvGOFLGrLU1yqZerVArOb3FFtYUte5q2HACceZK3cVW4I2adLhUG17uyjwDma
         JHnumcJqnxxKnbtqyDIHO/3LC8GkwEyeC0yKFR5ADVBuznHkFsR9+G1eCThsdDYJyf
         5PP9iklPRW6pw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 38DB73781453;
        Tue, 12 Dec 2023 10:41:23 +0000 (UTC)
Message-ID: <d5d0d01f-7df1-451a-a4bc-4c85f31b03db@collabora.com>
Date:   Tue, 12 Dec 2023 11:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v3 2/8] phy: add driver for MediaTek pextp
 10GE SerDes PHY
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        weijie.gao@mediatek.com
References: <cover.1702352117.git.daniel@makrotopia.org>
 <a58dae1cce1b49093b0ae05159c784a9ec02f058.1702352117.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a58dae1cce1b49093b0ae05159c784a9ec02f058.1702352117.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/23 04:46, Daniel Golle ha scritto:
> Add driver for MediaTek's pextp 10 Gigabit/s Ethernet SerDes PHY which
> can be found in the MT7988 SoC.
> 
> The PHY can operates only in PHY_MODE_ETHERNET, the submode is one of
> PHY_INTERFACE_MODE_* corresponding to the supported modes:
> 
>   * USXGMII
>   * 10GBase-R
>   * 5GBase-R
>   * 2500Base-X
>   * 1000Base-X
>   * Cisco SGMII (MAC side)
> 
> In order to work-around a performance issue present on the first of
> two PEXTP present in MT7988 special tuning is applied which can be
> selected by adding the mediatek,usxgmii-performance-errata property to
> the device tree node.
> 
> There is no documentation what-so-ever for the pextp registers and
> this driver is based on a GPL licensed implementation found in
> MediaTek's SDK.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

..snip..

Can anyone from MediaTek **please** define those registers and fields?

In this form, this driver is pretty obscure and nobody knows what it's doing;
please remember that, by actually providing a definition for those registers and
fields, the operation (reliability) of this PHY may be improved and this driver
will be actually maintainable (and possibly support more than one variation of
this PHY in the future with less efforts).

MediaTek?

Regards,
Angelo

> +
> +	/* Setup operation mode */
> +	if (is_10g)
> +		iowrite32(0x00c9071c, pextp->base + 0x9024);
> +	else
> +		iowrite32(0x00d9071c, pextp->base + 0x9024);
> +
> +	if (is_5g)
> +		iowrite32(0xaaa5a5aa, pextp->base + 0x2020);
> +	else
> +		iowrite32(0xaa8585aa, pextp->base + 0x2020);
> +
> +	if (is_2p5g || is_5g || is_10g) {
> +		iowrite32(0x0c020707, pextp->base + 0x2030);
> +		iowrite32(0x0e050f0f, pextp->base + 0x2034);
> +		iowrite32(0x00140032, pextp->base + 0x2040);
> +	} else {
> +		iowrite32(0x0c020207, pextp->base + 0x2030);
> +		iowrite32(0x0e05050f, pextp->base + 0x2034);
> +		iowrite32(0x00200032, pextp->base + 0x2040);
> +	}
> +
> +	if (is_2p5g || is_10g)
> +		iowrite32(0x00c014aa, pextp->base + 0x50f0);
> +	else if (is_5g)
> +		iowrite32(0x00c018aa, pextp->base + 0x50f0);
> +	else
> +		iowrite32(0x00c014ba, pextp->base + 0x50f0);
> +
> +	if (is_5g) {
> +		iowrite32(0x3777812b, pextp->base + 0x50e0);
> +		iowrite32(0x005c9cff, pextp->base + 0x506c);
> +		iowrite32(0x9dfafafa, pextp->base + 0x5070);
> +		iowrite32(0x273f3f3f, pextp->base + 0x5074);
> +		iowrite32(0xa8883868, pextp->base + 0x5078);
> +		iowrite32(0x14661466, pextp->base + 0x507c);
> +	} else {
> +		iowrite32(0x3777c12b, pextp->base + 0x50e0);
> +		iowrite32(0x005f9cff, pextp->base + 0x506c);
> +		iowrite32(0x9d9dfafa, pextp->base + 0x5070);
> +		iowrite32(0x27273f3f, pextp->base + 0x5074);
> +		iowrite32(0xa7883c68, pextp->base + 0x5078);
> +		iowrite32(0x11661166, pextp->base + 0x507c);
> +	}
> +
> +	if (is_2p5g || is_10g) {
> +		iowrite32(0x0e000aaf, pextp->base + 0x5080);
> +		iowrite32(0x08080d0d, pextp->base + 0x5084);
> +		iowrite32(0x02030909, pextp->base + 0x5088);
> +	} else if (is_5g) {
> +		iowrite32(0x0e001abf, pextp->base + 0x5080);
> +		iowrite32(0x080b0d0d, pextp->base + 0x5084);
> +		iowrite32(0x02050909, pextp->base + 0x5088);
> +	} else {
> +		iowrite32(0x0e000eaf, pextp->base + 0x5080);
> +		iowrite32(0x08080e0d, pextp->base + 0x5084);
> +		iowrite32(0x02030b09, pextp->base + 0x5088);
> +	}
> +
> +	if (is_5g) {
> +		iowrite32(0x0c000000, pextp->base + 0x50e4);
> +		iowrite32(0x04000000, pextp->base + 0x50e8);
> +	} else {
> +		iowrite32(0x0c0c0000, pextp->base + 0x50e4);
> +		iowrite32(0x04040000, pextp->base + 0x50e8);
> +	}
> +
> +	if (is_2p5g || mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x0f0f0c06, pextp->base + 0x50eC);
> +	else
> +		iowrite32(0x0f0f0606, pextp->base + 0x50eC);
> +
> +	if (is_5g) {
> +		iowrite32(0x50808c8c, pextp->base + 0x50a8);
> +		iowrite32(0x18000000, pextp->base + 0x6004);
> +	} else {
> +		iowrite32(0x506e8c8c, pextp->base + 0x50a8);
> +		iowrite32(0x18190000, pextp->base + 0x6004);
> +	}
> +
> +	if (is_10g)
> +		iowrite32(0x01423342, pextp->base + 0x00f8);
> +	else if (is_5g)
> +		iowrite32(0x00a132a1, pextp->base + 0x00f8);
> +	else if (is_2p5g)
> +		iowrite32(0x009c329c, pextp->base + 0x00f8);
> +	else
> +		iowrite32(0x00fa32fa, pextp->base + 0x00f8);
> +
> +	/* Force SGDT_OUT off and select PCS */
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x80201f20, pextp->base + 0x00f4);
> +	else
> +		iowrite32(0x80201f21, pextp->base + 0x00f4);
> +
> +	/* Force GLB_CKDET_OUT */
> +	iowrite32(0x00050c00, pextp->base + 0x0030);
> +
> +	/* Force AEQ on */
> +	iowrite32(0x02002800, pextp->base + 0x0070);
> +	ndelay(1020);
> +
> +	/* Setup DA default value */
> +	iowrite32(0x00000020, pextp->base + 0x30b0);
> +	iowrite32(0x00008a01, pextp->base + 0x3028);
> +	iowrite32(0x0000a884, pextp->base + 0x302c);
> +	iowrite32(0x00083002, pextp->base + 0x3024);
> +	if (mtk_interface_mode_is_xgmii(interface)) {
> +		iowrite32(0x00022220, pextp->base + 0x3010);
> +		iowrite32(0x0f020a01, pextp->base + 0x5064);
> +		iowrite32(0x06100600, pextp->base + 0x50b4);
> +		if (interface == PHY_INTERFACE_MODE_USXGMII)
> +			iowrite32(0x40704000, pextp->base + 0x3048);
> +		else
> +			iowrite32(0x47684100, pextp->base + 0x3048);
> +	} else {
> +		iowrite32(0x00011110, pextp->base + 0x3010);
> +		iowrite32(0x40704000, pextp->base + 0x3048);
> +	}
> +
> +	if (!mtk_interface_mode_is_xgmii(interface) && !is_2p5g)
> +		iowrite32(0x0000c000, pextp->base + 0x3064);
> +
> +	if (interface != PHY_INTERFACE_MODE_10GBASER) {
> +		iowrite32(0xa8000000, pextp->base + 0x3050);
> +		iowrite32(0x000000aa, pextp->base + 0x3054);
> +	} else {
> +		iowrite32(0x00000000, pextp->base + 0x3050);
> +		iowrite32(0x00000000, pextp->base + 0x3054);
> +	}
> +
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x00000f00, pextp->base + 0x306c);
> +	else if (is_2p5g)
> +		iowrite32(0x22000f00, pextp->base + 0x306c);
> +	else
> +		iowrite32(0x20200f00, pextp->base + 0x306c);
> +
> +	if (interface == PHY_INTERFACE_MODE_10GBASER && pextp->da_war)
> +		iowrite32(0x0007b400, pextp->base + 0xa008);
> +
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x00040000, pextp->base + 0xa060);
> +	else
> +		iowrite32(0x00050000, pextp->base + 0xa060);
> +
> +	if (is_10g)
> +		iowrite32(0x00000001, pextp->base + 0x90d0);
> +	else if (is_5g)
> +		iowrite32(0x00000003, pextp->base + 0x90d0);
> +	else if (is_2p5g)
> +		iowrite32(0x00000005, pextp->base + 0x90d0);
> +	else
> +		iowrite32(0x00000007, pextp->base + 0x90d0);
> +
> +	/* Release reset */
> +	iowrite32(0x0200e800, pextp->base + 0x0070);
> +	usleep_range(150, 500);
> +
> +	/* Switch to P0 */
> +	iowrite32(0x0200c111, pextp->base + 0x0070);
> +	ndelay(1020);
> +	iowrite32(0x0200c101, pextp->base + 0x0070);
> +	usleep_range(15, 50);
> +
> +	if (mtk_interface_mode_is_xgmii(interface)) {
> +		/* Switch to Gen3 */
> +		iowrite32(0x0202c111, pextp->base + 0x0070);
> +	} else {
> +		/* Switch to Gen2 */
> +		iowrite32(0x0201c111, pextp->base + 0x0070);
> +	}
> +	ndelay(1020);
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x0202c101, pextp->base + 0x0070);
> +	else
> +		iowrite32(0x0201c101, pextp->base + 0x0070);
> +	usleep_range(100, 500);
> +	iowrite32(0x00000030, pextp->base + 0x30b0);
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x80201f00, pextp->base + 0x00f4);
> +	else
> +		iowrite32(0x80201f01, pextp->base + 0x00f4);
> +
> +	iowrite32(0x30000000, pextp->base + 0x3040);
> +	usleep_range(400, 1000);
> +}
> +
> +static int mtk_pextp_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
> +	switch (submode) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		mtk_pextp_setup(pextp, submode);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mtk_pextp_reset(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	reset_control_assert(pextp->reset);
> +	usleep_range(100, 500);
> +	reset_control_deassert(pextp->reset);
> +	usleep_range(1, 10);
> +
> +	return 0;
> +}
> +
> +static int mtk_pextp_power_on(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	return clk_bulk_prepare_enable(MTK_PEXTP_NUM_CLOCKS, pextp->clocks);
> +}
> +
> +static int mtk_pextp_power_off(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(MTK_PEXTP_NUM_CLOCKS, pextp->clocks);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mtk_pextp_ops = {
> +	.power_on	= mtk_pextp_power_on,
> +	.power_off	= mtk_pextp_power_off,
> +	.set_mode	= mtk_pextp_set_mode,
> +	.reset		= mtk_pextp_reset,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int mtk_pextp_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct phy_provider *phy_provider;
> +	struct mtk_pextp_phy *pextp;
> +	struct phy *phy;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	pextp = devm_kzalloc(&pdev->dev, sizeof(*pextp), GFP_KERNEL);
> +	if (!pextp)
> +		return -ENOMEM;
> +
> +	pextp->base = devm_of_iomap(&pdev->dev, np, 0, NULL);
> +	if (!pextp->base)
> +		return -EIO;
> +
> +	pextp->dev = &pdev->dev;
> +
> +	pextp->clocks[0].id = "topxtal";
> +	pextp->clocks[0].clk = devm_clk_get(&pdev->dev, pextp->clocks[0].id);
> +	if (IS_ERR(pextp->clocks[0].clk))
> +		return PTR_ERR(pextp->clocks[0].clk);
> +
> +	pextp->clocks[1].id = "xfipll";
> +	pextp->clocks[1].clk = devm_clk_get(&pdev->dev, pextp->clocks[1].id);
> +	if (IS_ERR(pextp->clocks[1].clk))
> +		return PTR_ERR(pextp->clocks[1].clk);
> +
> +	pextp->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(pextp->reset))
> +		return PTR_ERR(pextp->reset);
> +
> +	pextp->da_war = of_property_read_bool(np, "mediatek,usxgmii-performance-errata");
> +
> +	phy = devm_phy_create(&pdev->dev, NULL, &mtk_pextp_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, pextp);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id mtk_pextp_match[] = {
> +	{ .compatible = "mediatek,mt7988-xfi-pextp", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pextp_match);
> +
> +static struct platform_driver mtk_pextp_driver = {
> +	.probe = mtk_pextp_probe,
> +	.driver = {
> +		.name = "mtk-pextp",
> +		.of_match_table = mtk_pextp_match,
> +	},
> +};
> +module_platform_driver(mtk_pextp_driver);
> +
> +MODULE_DESCRIPTION("MediaTek pextp SerDes PHY driver");
> +MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
> +MODULE_LICENSE("GPL");


