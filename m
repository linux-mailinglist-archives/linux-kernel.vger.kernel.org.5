Return-Path: <linux-kernel+bounces-95431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD4874D99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02511C20BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB112CD8A;
	Thu,  7 Mar 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxf4LwIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E2129A65;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811290; cv=none; b=b+7inSodsn+S+N3uci5lDb9uqBTTjTQa6K6cDadxHYvSMvuHbOfr5w0317gbxXt9seBqmYHWEmrYrS7iNEcs3rva4fpERzXeye88oQFx/ASI1Kpa35hAi9GlOS0ZiyTgk9vybsPCKT9yBwG5qYJTbAwvyBJzP9BqRI29V6u0anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811290; c=relaxed/simple;
	bh=xFguqMewgLv699i3A05fv1Nem4jn+AqwGZ8eZNYn1pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqdStqt8vJemp/ddP1w2cBCtiWbZi69pCE9kLX1pZP+Vn6QeXVIiI16hASfxImE74U4wRpPKALuyaASz2mplcHw08F6W3AJQ5hwgOQFyF881rjtnWKLMn5DCfvqrj6N7W5WwQymCe/aqRJYiiuwwMJTQ4jP2CFcjszyLZ+Yy5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxf4LwIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 961B0C41612;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=xFguqMewgLv699i3A05fv1Nem4jn+AqwGZ8eZNYn1pE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uxf4LwIE0hjhtBvU8vstw+l2OjVKB5Adxqj+uNFQo3wcUmACw0HA+QX8X1ulD5RNx
	 obe6cFJuEaVwtMyZbUxY8oyARIpAiLWJ32gszvo/0KsF2RJL936uIUfwIIj/b1ZBO3
	 zy3MH/3VzeMADG3aA4ss0gUa0ovtJKwsYsHtKzXHJXlFRX4DV7RT/3R8eGci9AwToc
	 w2Vc8Hwl8Hh3XX4MOGJawiP43WO0AJYH9YZJcrj6XAwYCiKAiZ/imKDotvIsFyuMNf
	 Ik6lHgoOAy9o5T0S7aRSimCIpYR8yMhLuIEOjRexAe9G/JmBjG9NIic1Krf8IZZPMR
	 DpYGGupx+pnAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84607C54E5D;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:54 +0800
Subject: [PATCH net-next v9 8/9] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-8-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=6833;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=JB/jq7y7ekKYQqQCVfF3Bi6IugEdAkkTOA3ttrqRJY4=;
 b=DSnLlxOvydrlwqHiN7HmaDVz+wz9hVJkUpFM0qlo9Se3G14PTS2EA6Y1mb9Zk75WCWMezqPs5
 dQ1ci1jvHM7AU/wSF/TQrAZEoDkhMLwLl77s/4UXMPp4Ytbvj4IhnXK
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Register the sub MDIO bus if it is found. Also implement the internal
PHY reset procedure as needed.

Note it's unable to put the MDIO bus node outside of MAC controller
(i.e. at the same level in the parent bus node). Because we need to
control all clocks and resets in FEMAC driver due to the phy reset
procedure. So the clocks can't be assigned to MDIO bus device, which is
an essential resource for the MDIO bus to work.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 74 +++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 9bf4beba7987..a4f856710d96 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -10,8 +10,10 @@
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -97,6 +99,13 @@ enum phy_reset_delays {
 	DELAYS_NUM,
 };
 
+enum clk_type {
+	CLK_MAC,
+	CLK_MACIF,
+	CLK_PHY,
+	CLK_NUM,
+};
+
 struct hisi_femac_queue {
 	struct sk_buff **skb;
 	dma_addr_t *dma_phys;
@@ -108,7 +117,7 @@ struct hisi_femac_queue {
 struct hisi_femac_priv {
 	void __iomem *port_base;
 	void __iomem *glb_base;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
 	struct reset_control *mac_rst;
 	struct reset_control *phy_rst;
 	u32 phy_reset_delays[DELAYS_NUM];
@@ -116,6 +125,7 @@ struct hisi_femac_priv {
 
 	struct device *dev;
 	struct net_device *ndev;
+	struct platform_device *mdio_pdev;
 
 	struct hisi_femac_queue txq;
 	struct hisi_femac_queue rxq;
@@ -693,6 +703,7 @@ static const struct net_device_ops hisi_femac_netdev_ops = {
 static void hisi_femac_core_reset(struct hisi_femac_priv *priv)
 {
 	reset_control_assert(priv->mac_rst);
+	usleep_range(200, 300);
 	reset_control_deassert(priv->mac_rst);
 }
 
@@ -712,6 +723,10 @@ static void hisi_femac_sleep_us(u32 time_us)
 
 static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 {
+	/* MAC clock must be disabled before PHY reset
+	 */
+	clk_disable(priv->clks[CLK_MAC].clk);
+	clk_disable(priv->clks[CLK_MACIF].clk);
 	/* To make sure PHY hardware reset success,
 	 * we must keep PHY in deassert state first and
 	 * then complete the hardware reset operation
@@ -727,6 +742,9 @@ static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 	reset_control_deassert(priv->phy_rst);
 	/* delay some time to ensure later MDIO access */
 	hisi_femac_sleep_us(priv->phy_reset_delays[POST_DELAY]);
+
+	clk_enable(priv->clks[CLK_MAC].clk);
+	clk_enable(priv->clks[CLK_MACIF].clk);
 }
 
 static void hisi_femac_port_init(struct hisi_femac_priv *priv)
@@ -768,11 +786,12 @@ static void hisi_femac_port_init(struct hisi_femac_priv *priv)
 static int hisi_femac_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct device_node *node = dev->of_node, *mdio_np;
 	struct net_device *ndev;
 	struct hisi_femac_priv *priv;
 	struct phy_device *phy;
 	int ret;
+	bool mdio_registered = false;
 
 	ndev = alloc_etherdev(sizeof(*priv));
 	if (!ndev)
@@ -797,17 +816,16 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 		goto out_free_netdev;
 	}
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clk\n");
-		ret = -ENODEV;
+	ret = devm_clk_bulk_get_all(&pdev->dev, &priv->clks);
+	if (ret < 0 || ret != CLK_NUM) {
+		dev_err(dev, "failed to get clk bulk: %d\n", ret);
 		goto out_free_netdev;
 	}
 
-	ret = clk_prepare_enable(priv->clk);
+	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
 	if (ret) {
-		dev_err(dev, "failed to enable clk %d\n", ret);
-		goto out_free_netdev;
+		dev_err(dev, "failed to enable clk bulk: %d\n", ret);
+		goto out_disable_clk;
 	}
 
 	priv->mac_rst = devm_reset_control_get(dev, "mac");
@@ -830,11 +848,29 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 		hisi_femac_phy_reset(priv);
 	}
 
+	// Register the optional MDIO bus
+	for_each_available_child_of_node(node, mdio_np) {
+		if (of_node_name_prefix(mdio_np, "mdio")) {
+			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
+			of_node_put(mdio_np);
+			if (!priv->mdio_pdev) {
+				dev_err(dev, "failed to register MDIO bus device\n");
+				ret = -ENODEV;
+				goto out_disable_clk;
+			}
+			mdio_registered = true;
+			break;
+		}
+	}
+
+	if (!mdio_registered)
+		dev_warn(dev, "MDIO subnode not found. This is usually a bug.\n");
+
 	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
 	if (!phy) {
 		dev_err(dev, "connect to PHY failed!\n");
 		ret = -ENODEV;
-		goto out_disable_clk;
+		goto out_unregister_mdio_bus;
 	}
 
 	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
@@ -885,8 +921,10 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 out_disconnect_phy:
 	netif_napi_del(&priv->napi);
 	phy_disconnect(phy);
+out_unregister_mdio_bus:
+	platform_device_unregister(priv->mdio_pdev);
 out_disable_clk:
-	clk_disable_unprepare(priv->clk);
+	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
 out_free_netdev:
 	free_netdev(ndev);
 
@@ -902,7 +940,8 @@ static void hisi_femac_drv_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 
 	phy_disconnect(ndev->phydev);
-	clk_disable_unprepare(priv->clk);
+	platform_device_unregister(priv->mdio_pdev);
+	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
 	free_netdev(ndev);
 }
 
@@ -919,7 +958,7 @@ static int hisi_femac_drv_suspend(struct platform_device *pdev,
 		netif_device_detach(ndev);
 	}
 
-	clk_disable_unprepare(priv->clk);
+	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
 
 	return 0;
 }
@@ -928,8 +967,14 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clk bulk: %d\n", ret);
+		return ret;
+	}
 
-	clk_prepare_enable(priv->clk);
 	if (priv->phy_rst)
 		hisi_femac_phy_reset(priv);
 
@@ -946,6 +991,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 
 static const struct of_device_id hisi_femac_match[] = {
 	{.compatible = "hisilicon,hi3516cv300-femac",},
+	{.compatible = "hisilicon,hi3798mv200-femac",},
 	{},
 };
 

-- 
2.43.0


