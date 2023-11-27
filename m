Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372B7FA100
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjK0NZk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjK0NZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:25:38 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344685
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:25:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bbw-0001DE-Lv; Mon, 27 Nov 2023 14:25:16 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bbt-00BxGz-0Y; Mon, 27 Nov 2023 14:25:13 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7bbs-000D9T-2y;
        Mon, 27 Nov 2023 14:25:12 +0100
Message-ID: <117dc1503ecd07448cc2e0b036b34a49f5e8c38e.camel@pengutronix.de>
Subject: Re: [RFC PATCH 6/8] net: pcs: add driver for MediaTek USXGMII PCS
From:   Philipp Zabel <p.zabel@pengutronix.de>
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Date:   Mon, 27 Nov 2023 14:25:12 +0100
In-Reply-To: <b9f787f3e4aa36e148d7595495af60db53f74417.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
         <b9f787f3e4aa36e148d7595495af60db53f74417.1699565880.git.daniel@makrotopia.org>
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

On Do, 2023-11-09 at 21:51 +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
[...]
> diff --git a/drivers/net/pcs/pcs-mtk-usxgmii.c b/drivers/net/pcs/pcs-mtk-usxgmii.c
> new file mode 100644
> index 0000000000000..b3ca66c9df2a9
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-mtk-usxgmii.c
> @@ -0,0 +1,688 @@
[...]
> +static int mtk_sgmii_wrapper_init(struct mtk_usxgmii_pcs *mpcs)
> +{
> +	struct device_node *r = mpcs->dev->of_node, *np;
[...]
> +	rstc = of_reset_control_get_shared(r, "sgmii");
> +

Superfluous whitespace.

> +	if (IS_ERR(rstc))
> +		return PTR_ERR(rstc);

Here you correctly check rstc for errors ...

[...]
> +	wp->reset = rstc;
[...]
> +
> +	if (IS_ERR(wp->reset))
> +		return PTR_ERR(wp->reset);

And here you check it again. The second check can be dropped.


regards
Philipp
