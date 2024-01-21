Return-Path: <linux-kernel+bounces-32049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C498355BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435E1281700
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B437143;
	Sun, 21 Jan 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dFInY6Zg"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2069.outbound.protection.outlook.com [40.92.107.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC737142;
	Sun, 21 Jan 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840981; cv=fail; b=FG6PGuJkiUqeWeQbL1vGTCmD7KGNcWtbnT7+wL8S2qg0MAxN8MxLdFBF3UXQpwGQmbm2gpLDvcGYnBMtd7bISafncnrasgN5MbdmCYgp8C/mHhRoiFx6ZQqBYCKvKR6FznwGl3UvNx5ynQXQejg0JJ7q/CET9pbFi91GmyHf9RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840981; c=relaxed/simple;
	bh=1Nd1CHY7Rnm9JqCXDwQn+P7LNvhcbaVhb+tx4Vxsjw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwBft0fD6LXgBH1aOnMcF4X8NAK1cHEuGc5Arvi0VI/wL33orLlVsZQ/qSkAmR+M3Ie4NKroo9yyFrhjjVSU4AlmLWqtWGE/1wgoffVu5snRZbURrmzIT6C0Dtu7zjD5aIcbDJKcofsj9iLqptX3mqpmBpHLxdemseDlsdErS3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dFInY6Zg; arc=fail smtp.client-ip=40.92.107.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlX6zIOnbg3G2pFJVl7iUPuB6jICbsZpJoJj/rEgxyR99/V7FgfcpZ+9O2igxYycrV48/0DhRUNO7puDRYi7vXvrekqdd0g1uNNnaaJgmbOgHtB/9SS+c4EfymPIIZeF8uNR8HRcALHwPsUGh7mmBuvgN02Efl5BGlhvniu9lxjF4YqzDSmuWALjcmh7SQf5PlKwAIq2fLPwHSD8y/oBap4ilDIe/leAF5/Xm69BZJ8atiBqtj0q0H7qtrDj6F4RWKRhNElCSQOSHZcT0iWFBaJ5pf+AVxUp9yxfrMWK459JjJ2zTDuYDoJUSD2PI27W3GsAq+wbeA8TU0aB011MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYYNimcnF3YqLTTNLWhrZAnb9da3v1uk3csr6SEAqU8=;
 b=cfrLDaPlSWH0dBLoRM7fV2zeVwqezkeW6pD2Bw1zQQpJTGXtLEIWNjSMgPnRRkq4oiS/fOuNAl6xHG6d/+H6i+WE7ft1+G6GkfAXSybpJk10+RJxhOZVQSOX80H8j9LgmU/+191W0lmaiDrMKFgKAD6LAPvmbCa5C15SG4hfh4tZNAxisiB/eSUYgAsA3Hvkw6hwi4sNJRhyT6TQ5v7+4nmEXlBV4+rPS4hhDKwMdq+YVgHk8vgvTglh13cye4DUWzdbubP4o+H2spUMQ8YEjKPLFDxwgCnMALjVg20yEIBFc1Hd6NqCUsrsErmZ48WSMhobKPkusAYyHdvI3NQjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYYNimcnF3YqLTTNLWhrZAnb9da3v1uk3csr6SEAqU8=;
 b=dFInY6Zg+AoAU750VowerFeTyk/1IA/bCtVWr7wBa63pxmsyg72LEZUYe3CwWPdbMGe8r/B545CZKtE5U9a0m8Phabk6doMtnai73OEIhF3wvngLdkqcXvv6kNez3ITAs/uYrl+kc627obGlNBsfERlPco3Gc8aGrpXEdCJzGQXDAHcblX4/oqhQchsJMNa433ZY5sfRr3eqWQQmj35T/b98l2Zd040Al1K0yWJ6JmxLKkW7f6iS4bnQv1edN4WXm4uGJud4d53akGjY77MNPcbEDXIGOHuegPjOruyRFpamfvM2OU3Hf/c1yN+iDUWlJeliEMTrd3abUKDi6l/wPg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:42:55 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:42:55 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 1/8] net: phy: Introduce Qualcomm IPQ5018 internal PHY driver
Date: Sun, 21 Jan 2024 20:42:30 +0800
Message-ID:
 <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nfEoGlwwp8/ShSyGEZ809gEznySqDSjYDALQWyLowDbaoJai5WxIrw==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 980c753f-cf0a-4d35-0300-08dc1a7e7d91
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Tcyqn8+gLjyoBqrZ8vnSkt/uFUACjcMSbgl/O2VTDiQj1z3ToG61wycj2N87BbWqJV8TwLr6L9PU86OYQcDLStIA1D0JRJpDwT36sG5t4ciVnmn6t9ev8/B+OSAFc8p+GWMssuORSOmXrNiDeMPmbEWSFitK/qfouGUAmO744Ol2Pu8wJB7i6HwrgNFZUpolszCx5DL9yzDP1KVsksMs1hbrLoazp2jwvtGLYa/qnyQvAgXgKJ4Pa5XYTe8hXescof49ezuHjgScwG3sXX7iHHhm8LEzUCjDEu4bguSWv0XwbRuRijEHCobJKYimJUc+cy0SukYhLbfQYBuixg48D6eHOAhvz5mIwDnEPRsoNkrBhRsdoLKMSMMFnWh24CK6trY2P/qezlmbvtYTDIQNa5AJfBXaNgn/DXnUA8S8M5OI4r6t56Xx80P47PqOVy2vmL2pGJT7Lj1ZlwNWq1y0o4LUaM5IBhCWniHKOSQ3cQ3FnOq9C+449RZ88cSNxKiugUCzUF7Lk5bwaJj8/KrWLPZHh1ehFBhAYyMeg/b0MxmBdunlQkYRLUVVBbf27OsloKHrbsEwMgnFby7gzA0ZcYnTaRkNWACqDp5cmsnFksbjpHhJHSIG/ey0V3myglk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SA5czwzNvszwxRjUHPn0nLeZuLBn9wOwl2/Q3uPEJ4qH3f4dfRFwEmnL7d86?=
 =?us-ascii?Q?Rf+9JzRXCmivzCweCA0fzPWeRW9/BzvTVAXD6rLDcuiubNca8xTP17GnUrU4?=
 =?us-ascii?Q?oWWdb6X7cS1jHhl09B3gx7A9e+IcxPoljvzSxMXjz+oiJG3iq/hQEKpbgUmg?=
 =?us-ascii?Q?rCCYGsW4zOAdk0goljP8Tg5AMkbDlqZu3amG90AzFaZIA8Jxugp2HWL6Bv6z?=
 =?us-ascii?Q?gyaSNvgNWLBF4FFZFvAbjzJHW4/BIyj4u9pcUxwnVONzZCCFbei0a63yNro/?=
 =?us-ascii?Q?RtrZ/JaIZZZwcZg8WBkkMp6KgEZgkZtyCYQpjv0+YQb82OslXnBt8vIosT0N?=
 =?us-ascii?Q?lFWkuQTvVqJ1SG9bwMzcKY3EadkvVs7aUdFYSC1YC4NLVWk8mSQ0jtKDW5Qg?=
 =?us-ascii?Q?G658k2Zwzjy0zejqAl7shzsdrWbZz13nZjbFCG7whZT7/32Bl5NH/mk/JBD7?=
 =?us-ascii?Q?vEGDek0OKSh2eRvBYqb+JxFRsCTFkRFYzLgs8wXPESzVZtKQKS/lkeZ+mMwd?=
 =?us-ascii?Q?SLyiLl/miSxvnF0l1IEY2BnoRuGzBIXA6NffyTWiFiimIKSg1ELeyWry6ShP?=
 =?us-ascii?Q?yQ+NhLcrAT4XGfOClLbjerAzVCF4FIGLWsD7VtiNslWfliS+Be2dGoGHN2f0?=
 =?us-ascii?Q?/gHB+lpXaie9prEgdyfEb5nm//8f/ixFfWk7fCbpE7RjKHx0RhS/Hg8nxDq9?=
 =?us-ascii?Q?oFwHmAqGNEEMJdCIcHaKw5mu4Ipb2HoUI+uLYBoEKnF1VQEg65XxOiMopt/H?=
 =?us-ascii?Q?0nXq+CxFZ32ZtKKeVA4THIy8CAXTRKwBAEftugtYkYh6cUxR4R2gUCZKhC8d?=
 =?us-ascii?Q?KRYS1auT6uhJL4955ckVBvC9QfQWQXBXYWawSSia9bg4CQ4bhGD/ri6t1v7R?=
 =?us-ascii?Q?WIQbgmCRbcyfaXbH8ILTX22OIUF6LiuAIKDM/zPYGOh1wEIAc61w6WTtJH47?=
 =?us-ascii?Q?zGu9qYAYwDDsTGkXa+1On0vMFrUANwPvYl5fdtc+PgB7Mq4AFTsLhMdZjVAU?=
 =?us-ascii?Q?5/HWuusdTd21EBtFv7kqQxVPHBIx1C5JXWub+Grw5u0IsO+M/bKgOZU74F8Y?=
 =?us-ascii?Q?5hC+1hZ2IENERWH0SH4RSnA4SUj+C0Zen/qat4ZaYqqWGmIUYqVjNLbq9vaZ?=
 =?us-ascii?Q?M0ofXbD4Rvcavb16BhTh8li7FJwXztrJXaSl7FBhjPRYFLoaL5DsC5boi49n?=
 =?us-ascii?Q?ZSbNleR61vzb+F5fEwqwM12slwqlOhpgwcvR9qdwpgE2G7/tojXyxKMnWrC2?=
 =?us-ascii?Q?8MhlJlX0mHxn3ESP5ZdE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c753f-cf0a-4d35-0300-08dc1a7e7d91
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:42:55.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/phy/Kconfig            |   5 ++
 drivers/net/phy/Makefile           |   1 +
 drivers/net/phy/ipq5018-internal.c | 125 +++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/net/phy/ipq5018-internal.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..2d068fea7008 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -202,6 +202,11 @@ config INTEL_XWAY_PHY
 	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
 	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
 
+config IPQ5018_INTERNAL_PHY
+	tristate "Qualcomm IPQ5018 internal PHY"
+	help
+	  Supports for the Qualcomm IPQ5018 internal PHY.
+
 config LSI_ET1011C_PHY
 	tristate "LSI ET1011C PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..16d65378ae34 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
+obj-$(CONFIG_IPQ5018_INTERNAL_PHY)	+= ipq5018-internal.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
diff --git a/drivers/net/phy/ipq5018-internal.c b/drivers/net/phy/ipq5018-internal.c
new file mode 100644
index 000000000000..d1331951b4d8
--- /dev/null
+++ b/drivers/net/phy/ipq5018-internal.c
@@ -0,0 +1,125 @@
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/phy.h>
+#include <linux/reset.h>
+
+#define IPQ5018_PHY_ID			0x004dd0c0
+
+#define TX_RX_CLK_RATE			125000000 /* 125M */
+
+#define IPQ5018_PHY_FIFO_CONTROL	0x19
+#define  IPQ5018_PHY_FIFO_RESET		GENMASK(1, 0)
+
+struct ipq5018_phy {
+	int num_clks;
+	struct clk_bulk_data *clks;
+	struct reset_control *rst;
+
+	struct clk_hw *clk_rx, *clk_tx;
+	struct clk_hw_onecell_data *clk_data;
+};
+
+static int ipq5018_probe(struct phy_device *phydev)
+{
+	struct ipq5018_phy *priv;
+	struct device *dev = &phydev->mdio.dev;
+	char name[64];
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate priv\n");
+
+	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
+	if (priv->num_clks < 0)
+		return dev_err_probe(dev, priv->num_clks,
+				     "failed to acquire clocks\n");
+
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable clocks\n");
+
+	priv->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR_OR_NULL(priv->rst))
+		return dev_err_probe(dev, PTR_ERR(priv->rst),
+				     "failed to acquire reset\n");
+
+	ret = reset_control_reset(priv->rst);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to reset\n");
+
+	snprintf(name, sizeof(name), "%s#rx", dev_name(dev));
+	priv->clk_rx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
+						  TX_RX_CLK_RATE);
+	if (IS_ERR_OR_NULL(priv->clk_rx))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_rx),
+				     "failed to register rx clock\n");
+
+	snprintf(name, sizeof(name), "%s#tx", dev_name(dev));
+	priv->clk_tx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
+						  TX_RX_CLK_RATE);
+	if (IS_ERR_OR_NULL(priv->clk_tx))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_tx),
+				     "failed to register tx clock\n");
+
+	priv->clk_data = devm_kzalloc(dev,
+				      struct_size(priv->clk_data, hws, 2),
+				      GFP_KERNEL);
+	if (!priv->clk_data)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate clk_data\n");
+
+	priv->clk_data->num = 2;
+	priv->clk_data->hws[0] = priv->clk_rx;
+	priv->clk_data->hws[1] = priv->clk_tx;
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				     priv->clk_data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "fail to register clock provider\n");
+
+	return 0;
+}
+
+static int ipq5018_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
+			 IPQ5018_PHY_FIFO_RESET, 0);
+	if (ret < 0)
+		return ret;
+
+	msleep(50);
+
+	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
+			 IPQ5018_PHY_FIFO_RESET, IPQ5018_PHY_FIFO_RESET);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct phy_driver ipq5018_internal_phy_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(IPQ5018_PHY_ID),
+		.name		= "Qualcomm IPQ5018 internal PHY",
+		.flags		= PHY_IS_INTERNAL,
+		.probe		= ipq5018_probe,
+		.soft_reset	= ipq5018_soft_reset,
+	},
+};
+module_phy_driver(ipq5018_internal_phy_driver);
+
+static struct mdio_device_id __maybe_unused ipq5018_internal_phy_ids[] = {
+	{ PHY_ID_MATCH_EXACT(IPQ5018_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, ipq5018_internal_phy_ids);
+
+MODULE_DESCRIPTION("Qualcomm IPQ5018 internal PHY driver");
+MODULE_AUTHOR("Ziyang Huang <hzyitc@outlook.com>");
-- 
2.40.1


