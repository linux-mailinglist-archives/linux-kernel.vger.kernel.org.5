Return-Path: <linux-kernel+bounces-32050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F28355C0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613DFB2282A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5E374C9;
	Sun, 21 Jan 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ew7vzy9W"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2063.outbound.protection.outlook.com [40.92.107.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0937142;
	Sun, 21 Jan 2024 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840991; cv=fail; b=IMe+wmeE08RDoK/kV/B4SnrvGYOXnve2UguiS2MhVmGIkPozxOdP1djJcNUUC3sM53Fo5pp94h47s0CElwuwHXe18sb9PwkdSWIT8xeCKX/Gur/PNDeYhS/foU5ckJI2FBjJd3oLUIhxav72aLPQoykj3UUUJWHjqjjz951fmDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840991; c=relaxed/simple;
	bh=PK6+H4YbgWR3DK5mPkpaWVlE4JaGeo0QjI2gPSI6GeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGF4zxI+AloZ4V0mXi0CZlYucp0iCkdW+5FQFTfDFeB81vY0y0+/vRcY2uum+tFeyPzQsDVIxZFZMqnBNGtIDdUIZjTcB0J581xGPUMLKUZua48CKM1QENTmxnWr6lTI+OKzMIAdZ43S/IyIYjiCrIdfEsGgUbt3Se6F7pJR3QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ew7vzy9W; arc=fail smtp.client-ip=40.92.107.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BStRVttU4ppTUFqAhW63spEewwdGdKf4SrNP2A8icFp3ceMS1W8FGnPSp637IJJF8U93B4uP3p9NBq6jf9v75v+nf1kGadtp0wV5upPKJTNtX2Y55NSw0XQbjHTQs2H35aSQ+3FGubSFBuf6jh2x0B53uXcmo0nQVUgZKluDWR8n4oUI5CrcmGeVKsJqu+4ZRqo4tMQo5YZli1gLmwxKKkhKRCUg6EmToxytY3RrVK9c+RJfD6NF7/6a75LElwEHKpU5oTcFS2/Sb/n0x8Z3uUL2HT6qQgc0x+L0A1+5wwTBBlCxGXPH0KyQ3oGZzMLQe7bwf3EashaeBi/7QULJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqNPKD9cf2LOffkkH2VUh4R55yCvW8u1H6kgOvRNP7s=;
 b=VGZbqn1aR7uUErEzzN3Eo2OquBigzDFOlUwvtyywMG3QGnbfxjUmfvcci2A7nYy3TKecsac7tBNXwnda0nlXdtIjGsw6CWwkH1vObbtq0C6Q9tF63vS2bPoB1DW50u399ZR4m+IF+89g0Yw4/rmqdllgXUBQCOaWl4kdtWMdySinY3c4ViqMwMjK3DO5DF0C0IxGN5690bewugDuSHv9C07RUGQ+j7hATc34muKCJeJ5t1rRPETiRKeJITObOmMIgu0IhrumsYk8oKKzv3ZZio5TUIxz1oDqgVjsDai4ag7q+CITDOFKzBYLqlpPxlePX4dxl8+zzs3iaFNCeWU4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqNPKD9cf2LOffkkH2VUh4R55yCvW8u1H6kgOvRNP7s=;
 b=Ew7vzy9WKCc33NgPSUPcB+qK7M3rGTY3UHkjS6zudIQb4wHCiY7OA3EkHcCuRRRtAUoq3d5tdDYihMyQe9Kw5rKtNedMqYptBwzqSBgrjM5vfNGoKKSinCACGiORFiyEpckz129BKfADCj+By1xe/yUVNXecsU9UrjCkqDgubF8nFY5Y3EfsIhxj5IAx5qKf2lzO1Yl4hBIH1BCRoFdUMmk+jZMwTE4JaxmMJmlEXBhJ4KpboHM0GKANjtcXnr5BV4KDJLNjRJ4eo0Eg1iqi0q5ZUYWYjnNBjkFPBGxNsQULNf1Gqq/P074lFiKzascPIsDKgMildx+qXeqK6ztl4w==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:04 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:04 +0000
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
Subject: [PATCH 2/8] phy: Introduce Qualcomm ethernet uniphy driver
Date: Sun, 21 Jan 2024 20:42:31 +0800
Message-ID:
 <TYZPR01MB55568ACB534944D7DEB00C7AC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kV5Ly6/5oO4AGfwD/o4AHprlfetwjX3LAlGd2heNgymp5Zj+imTcnA==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-2-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a83ba4c-b354-4fba-3f06-08dc1a7e82bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YlO+NvKVBYRtbUvvAcPXv5r8yyj9e5mNrH1d44C45NEVyXEt2jHhpsv90mvoUdj6KzOGFzWax8o31GwP5JK3oF50/BHf7adqQ6AQSySWSmiuVsoms5fZT+/jT8Bj4OU8xXX30NPegtZCy1+yl32URF5Q/lYIeMfzeSbaC505VkI6X64jwDjdJeNJpXU6tIY2vhP9DYLJ2eP3gQVix4SQ1m7EDIdBOHe5oxYMfSjcf3pGTsCmSIC0Q06t87XSQxUqPB2CyX1ffzLO3MeZGSM3wijD0i+sWmfMmCb2PJRbjY4IkwCTzFbz2NtuuAsdPcP6l30ZDPULiTuXWtxMwhAyJiDYy58Rf4iNnb6nFjobaZy+D9HR1vnK0bWd9IBkpV8Y1oEwm1DnUaJ5u1C4aAjx1wupAlMZlousjBngbZ3sPzpJono3FWaVQ/59hZHl8tQxNinYxFCx/37tJL9L0kVedjqYZs1KlEFUunOZkJf/Lnizp6ELgDpUL73FvqC+ukuwfMS5+//Z99QBd8sv8i3NV/WxobR0npcsfv493ukzMgf/hNAPV0wythSIyS9AKNwYWHAKx4/VEuwFDD9buYHu17xwFUCLhGm8qFG+mMgbJPUB6IMyZcAMFbCunsf+jmoG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PKxZ9ifMc3p4joF8x+dxcbvALzRH7sKzgzO/lk2W1RcO08tARhAPIFh0H32?=
 =?us-ascii?Q?o3JKN03WlLu9p4w9betsSn5d8mqk4Qx0rXXgsFYwSp9cfJ/EuIl2VMzjccKh?=
 =?us-ascii?Q?w9omiLqy1zHQ0SV3SLiOdDNTYZSk3aYsdxqi7bmoERrE4DzELIZJJ+8ztSVl?=
 =?us-ascii?Q?VpeNScRGVgdpv4ly7X3V+EpZVWCF93mwK48xWGias/BjdF7YBEyhAi6fkFCu?=
 =?us-ascii?Q?elBoimmoeE+ucazdt2CWkjCOcNZBJ8w5N88/Csvf7wcC7qPzwlHs2jNXAmW3?=
 =?us-ascii?Q?8BolR5uVbt2xC7+zJ13603iN6syVTPGnbzZeaCfuXLW13u6ig0uS5V5B+gBw?=
 =?us-ascii?Q?aSIMdFAXsB+2BAx6XhD3/gsLesLJCH8BsYsEBgCLvL/Rhm00xwlIWHY/Ua0g?=
 =?us-ascii?Q?i34Wdxd/HXWqeYG+kbx7JSWsfvr2WR8eSZVxqSOpOLmri9q5fgqQcOWOguf1?=
 =?us-ascii?Q?rqCkluf6uSbY1W5byqSHAxgAdTdUs/9PvcLLvSJxqdsqilsnzTCc+VecNgiL?=
 =?us-ascii?Q?0WFttYdzhLc5BezUP1IoL5E/lhGVkVS+zd83obcihw8001vgBbz8/AWP9d1O?=
 =?us-ascii?Q?LSyXVqXiTt1HAazXExcESTcDEs5A82/2LWJieSdQkAPvlCJcL1Engs5OoNpn?=
 =?us-ascii?Q?HBAh1yLy76e/GefmbWWeBhPWD14gnHxx+Lz8ZbWNg6uIBVTqxED9EN4TOq94?=
 =?us-ascii?Q?n78+39GrNFbyTU22h14rDe7DkrIU1H6sqewrvn+vwGlB/I4FhuEjths771E0?=
 =?us-ascii?Q?bNDQDpnQ+E2FRHQ3orGVCM1jImBdmppVpetx4rvrOKoitleHTyPWDce7O2jv?=
 =?us-ascii?Q?KE0mAhDTtELuyOHD9WLVFfIjdw7GhPhI2WwhZzlZbJkr8NAXNNZ5lvdP/k7y?=
 =?us-ascii?Q?abl9S3gRtVWg+2el2Pm3to7ED9G7PTPdECwLRE9mIQhfdhDIHoMGHvkmJ8P7?=
 =?us-ascii?Q?Kp+Xz8mqIcxWvb1yI+irGlnSt5cWsCaHxvPhVifnDF2qM9qIfnBx4fANskov?=
 =?us-ascii?Q?FcsVTN47vq5bmKn6l57wdESNTSEC9zcuq8WFwhPZKRbDtwlqbbzvdOlzWzKS?=
 =?us-ascii?Q?w7JN6kpQNUUQDtTX0nvVZgCFzbhd/377CbT/Rty+OK0QKj/RPHVu7xsehlHb?=
 =?us-ascii?Q?nUr6N+yf3o4PLrT99zG7KQYE9GFroa3a5vB+snqCEZFfFktpAhBS4655WUhl?=
 =?us-ascii?Q?+/wNhT+ljqWuk4HVXZPV2PWnrOCLAEsEJZ4YfC1wE7q9kw2MdVkQ1WJ9XlIa?=
 =?us-ascii?Q?tiYX4XOzpu0fq12ulN0n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a83ba4c-b354-4fba-3f06-08dc1a7e82bc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:04.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/phy/qualcomm/Kconfig               |   7 +
 drivers/phy/qualcomm/Makefile              |   2 +
 drivers/phy/qualcomm/phy-qcom-eth-uniphy.c | 494 +++++++++++++++++++++
 include/dt-bindings/phy/qcom-eth-uniphy.h  |  15 +
 4 files changed, 518 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-eth-uniphy.c
 create mode 100644 include/dt-bindings/phy/qcom-eth-uniphy.h

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 97ca5952e34e..1cbbfd196115 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -28,6 +28,13 @@ config PHY_QCOM_EDP
 	  Enable this driver to support the Qualcomm eDP PHY found in various
 	  Qualcomm chipsets.
 
+config PHY_QCOM_ETH_UNIPHY
+	tristate "Qualcomm ethernet uniphy driver"
+	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Support for the Qualcomm ethernet uniphy.
+
 config PHY_QCOM_IPQ4019_USB
 	tristate "Qualcomm IPQ4019 USB PHY driver"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index b030858e0f8d..a9f01e688553 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -21,4 +21,6 @@ obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
+
+obj-$(CONFIG_PHY_QCOM_ETH_UNIPHY)	+= phy-qcom-eth-uniphy.o
 obj-$(CONFIG_PHY_QCOM_SGMII_ETH)	+= phy-qcom-sgmii-eth.o
diff --git a/drivers/phy/qualcomm/phy-qcom-eth-uniphy.c b/drivers/phy/qualcomm/phy-qcom-eth-uniphy.c
new file mode 100644
index 000000000000..71d4cefb8adb
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-eth-uniphy.c
@@ -0,0 +1,494 @@
+/*
+ * UNIPHY is the PCS between MAC and PHY which controls the mode of
+ * physical ports. Depends on different SoC, it can support
+ * SGMII/SGMII+/USXGMII. What's more, in some SoC it also support
+ * QSGMII/PSGMII which combine multi SGMII line into single physical port.
+ *
+ * =======================================================================
+ *        ________________________________
+ *       |  _______   IPQ807x             |
+ *       | | GMAC0 |__                    |
+ *       | |_______|  \                   |               _________
+ *       |  _______    \                  |          ____|   GPHY  |
+ *       | | GMAC1 |__  \     _________   |         /    | /Switch |
+ *       | |_______|  \  \___|         |  |     SGMII(+) |_________|
+ *       |  _______    \_____|         |  | P0    /
+ *       | | GMAC2 |_________| UNIPHY0 |--|-----or
+ *       | |_______|    _____|         |  |       \
+ *       |  _______    /   __|         |  |    (Q/P)SGMII __________
+ *       | | GMAC3 |__/   /  |_________|  |         \____| (Q/P)PHY |
+ *       | |_______|     /                |              |__________|
+ *       |  _______     /                 |
+ *       | | GMAC4 |--or                  |               _________
+ *       | |_______|    \     _________   | P1           | (X)GPHY |
+ *       |  ________     or--| UNIPHY1 |--|----SGMII(+)--| /Switch |
+ *       | | XGMAC0 |___/    |_________|  |    /USXGMII  |_________|
+ *       | |________|                     |
+ *       |  ________                      |
+ *       | | GMAC5  |___                  |               _________
+ *       | |________|   \     _________   | P2           | (X)GPHY |
+ *       |  ________     or--| UNIPHY2 |--|----SGMII(+)--| /Switch |
+ *       | | XGMAC1 |___/    |_________|  |    /USXGMII  |_________|
+ *       | |________|                     |
+ *       |________________________________|
+ *
+ * =======================================================================
+ *       _________________________________
+ *       |  _______   IPQ50xx   ______    | P0             ______
+ *       | | GMAC0 |___________| GPHY |---|------UTP------| RJ45 |
+ *       | |_______|           |______|   |               |______|
+ *       |  _______           _________   |               _________
+ *       | | GMAC1 |_________| UNIPHY0 |  | P1           |   GPHY  |
+ *       | |_______|         |_________|--|----SGMII(+)--| /Switch |
+ *       |________________________________|              |_________|
+ *
+ * =======================================================================
+ */
+
+#include <dt-bindings/phy/qcom-eth-uniphy.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+
+#define TCSR_ETH_CMN				0x0
+#define  TCSR_ETH_CMN_ENABLE			BIT(0)
+
+
+#define CMN_PLL_REFCLK_SRC			0x28
+#define  CMN_PLL_REFCLK_SRC_FROM_MASK		GENMASK(9, 8)
+#define   CMN_PLL_REFCLK_SRC_FROM(x)		FIELD_PREP(CMN_PLL_REFCLK_SRC_FROM_MASK, (x))
+#define   CMN_PLL_REFCLK_SRC_FROM_REG		CMN_PLL_REFCLK_SRC_FROM(0)
+#define   CMN_PLL_REFCLK_SRC_FROM_LOGIC		CMN_PLL_REFCLK_SRC_FROM(1)
+#define   CMN_PLL_REFCLK_SRC_FROM_PCS		CMN_PLL_REFCLK_SRC_FROM(2)
+
+#define CMN_PLL_REFCLK				0x784
+#define  CMN_PLL_REFCLK_EXTERNAL		BIT(9)
+#define  CMN_PLL_REFCLK_DIV_MASK		GENMASK(8, 4)
+#define   CMN_PLL_REFCLK_DIV(x)			FIELD_PREP(CMN_PLL_REFCLK_DIV_MASK, (x))
+#define  CMN_PLL_REFCLK_FREQ_MASK		GENMASK(3, 0)
+#define   CMN_PLL_REFCLK_FREQ(x)		FIELD_PREP(CMN_PLL_REFCLK_FREQ_MASK, (x))
+#define   CMN_PLL_REFCLK_FREQ_25M		CMN_PLL_REFCLK_FREQ(3)
+#define   CMN_PLL_REFCLK_FREQ_31250K		CMN_PLL_REFCLK_FREQ(4)
+#define   CMN_PLL_REFCLK_FREQ_40M		CMN_PLL_REFCLK_FREQ(6)
+#define   CMN_PLL_REFCLK_FREQ_48M		CMN_PLL_REFCLK_FREQ(7)
+#define   CMN_PLL_REFCLK_FREQ_50M		CMN_PLL_REFCLK_FREQ(8)
+
+#define CMN_PLL_CTRL				0x780
+#define  CMN_PLL_CTRL_RST_N			BIT(6)
+
+#define CMN_PLL_STATUS				0x64
+#define  CMN_PLL_STATUS_LOCKED			BIT(2)
+
+
+#define IPQ50XX_UNIPHY_CLKOUT			0x74
+#define  IPQ50XX_UNIPHY_CLKOUT_DS_MASK		GENMASK(3, 2)
+#define   IPQ50XX_UNIPHY_CLKOUT_DS(x)		FIELD_PREP(IPQ50XX_UNIPHY_CLKOUT_DS_MASK, (x))
+#define   IPQ50XX_UNIPHY_CLKOUT_DS_2_8V		IPQ50XX_UNIPHY_CLKOUT_DS(0)
+#define   IPQ50XX_UNIPHY_CLKOUT_DS_1_5V		IPQ50XX_UNIPHY_CLKOUT_DS(1)
+#define  IPQ50XX_UNIPHY_CLKOUT_DIV_MASK		GENMASK(1, 1)
+#define   IPQ50XX_UNIPHY_CLKOUT_DIV(x)		FIELD_PREP(IPQ50XX_UNIPHY_CLKOUT_DIV_MASK, (x))
+#define   IPQ50XX_UNIPHY_CLKOUT_DIV_50M		IPQ50XX_UNIPHY_CLKOUT_DIV(0)
+#define   IPQ50XX_UNIPHY_CLKOUT_DIV_25M		IPQ50XX_UNIPHY_CLKOUT_DIV(1)
+#define  IPQ50XX_UNIPHY_CLKOUT_ENABLE		BIT(0)
+
+#define IPQ53XX_UNIPHY_CLKOUT			0x610
+#define  IPQ53XX_UNIPHY_CLKOUT_LDO_LEVEL_MASK	GENMASK(10, 8)
+#define  IPQ53XX_UNIPHY_CLKOUT_DIV_MASK		GENMASK(5, 5)
+#define   IPQ53XX_UNIPHY_CLKOUT_DIV(x)		FIELD_PREP(IPQ53XX_UNIPHY_CLKOUT_DIV_MASK, (x))
+#define   IPQ53XX_UNIPHY_CLKOUT_DIV_50M		IPQ53XX_UNIPHY_CLKOUT_DIV(0)
+#define   IPQ53XX_UNIPHY_CLKOUT_DIV_25M		IPQ53XX_UNIPHY_CLKOUT_DIV(1)
+#define  IPQ53XX_UNIPHY_CLKOUT_PULLDOWN		BIT(3)
+#define  IPQ53XX_UNIPHY_CLKOUT_DS_MASK		GENMASK(2, 1)
+#define   IPQ53XX_UNIPHY_CLKOUT_DS(x)		FIELD_PREP(IPQ53XX_UNIPHY_CLKOUT_DS_MASK, (x))
+#define   IPQ53XX_UNIPHY_CLKOUT_DS_2_8V		IPQ53XX_UNIPHY_CLKOUT_DS(0)
+#define   IPQ53XX_UNIPHY_CLKOUT_DS_1_5V		IPQ53XX_UNIPHY_CLKOUT_DS(1)
+#define  IPQ53XX_UNIPHY_CLKOUT_ENABLE		BIT(0)
+
+
+#define UNIPHY_MODE				0x46c
+#define  UNIPHY_MODE_USXG			BIT(13)
+#define  UNIPHY_MODE_XPCS			BIT(12)
+#define  UNIPHY_MODE_SGMIIPLUS			BIT(11)
+#define  UNIPHY_MODE_SGMII			BIT(10)
+#define  UNIPHY_MODE_PSGMII			BIT(9)
+#define  UNIPHY_MODE_QSGMII			BIT(8)
+#define  UNIPHY_MODE_CH0_MODE_MASK		GENMASK(6, 4)
+#define   UNIPHY_MODE_CH0_MODE(x)		FIELD_PREP(UNIPHY_MODE_CH0_MODE_MASK, (x))
+#define   UNIPHY_MODE_CH0_MODE_1000BASEX	UNIPHY_MODE_CH0_MODE(0)
+#define   UNIPHY_MODE_CH0_MODE_MAC		UNIPHY_MODE_CH0_MODE(2)
+#define  UNIPHY_MODE_SGMII_CHANNEL_MASK		GENMASK(2, 1)
+#define   UNIPHY_MODE_SGMII_CHANNEL(x)		FIELD_PREP(UNIPHY_MODE_SGMII_CHANNEL_MASK, (x))
+#define   UNIPHY_MODE_SGMII_CHANNEL_0		UNIPHY_MODE_SGMII_CHANNEL(0)
+#define   UNIPHY_MODE_SGMII_CHANNEL_1		UNIPHY_MODE_SGMII_CHANNEL(1)
+#define   UNIPHY_MODE_SGMII_CHANNEL_4		UNIPHY_MODE_SGMII_CHANNEL(2)
+#define  UNIPHY_MODE_AN_MODE_MASK		BIT(0)
+#define   UNIPHY_MODE_AN_MODE(x)		FIELD_PREP(UNIPHY_MODE_AN_MODE_MASK, (x))
+#define   UNIPHY_MODE_AN_MODE_ATHEROS		UNIPHY_MODE_AN_MODE(0)
+#define   UNIPHY_MODE_AN_MODE_STANDARD		UNIPHY_MODE_AN_MODE(1)
+
+#define UNIPHY_PLL_CTRL				0x780
+#define  UNIPHY_PLL_CTRL_RST_N			BIT(6)
+
+#define UNIPHY_CALIBRATION			0x1E0
+#define  UNIPHY_CALIBRATION_DONE		BIT(7)
+
+
+#define UNIPHY_CHANNEL(x)			(0x480 + 0x18 * (x))
+#define  UNIPHY_CHANNEL_RSTN			BIT(11)
+#define  UNIPHY_CHANNEL_FORCE_SPEED_25M		BIT(3)
+
+#define UNIPHY_SGMII				0x218
+#define  UNIPHY_SGMII_MODE_MASK			GENMASK(6, 4)
+#define   UNIPHY_SGMII_MODE(x)			FIELD_PREP(UNIPHY_SGMII_MODE_MASK, (x))
+#define   UNIPHY_SGMII_MODE_SGMII		UNIPHY_SGMII_MODE(3)
+#define   UNIPHY_SGMII_MODE_SGMIIPLUS		UNIPHY_SGMII_MODE(5)
+#define   UNIPHY_SGMII_MODE_USXGMII		UNIPHY_SGMII_MODE(7)
+#define  UNIPHY_SGMII_RATE_MASK			GENMASK(1, 0)
+#define   UNIPHY_SGMII_RATE(x)			FIELD_PREP(UNIPHY_SGMII_RATE_MASK, (x))
+
+
+#define SGMII_CLK_RATE				125000000 /* 125M */
+#define SGMII_PLUS_CLK_RATE			312500000 /* 312.5M */
+
+
+struct qcom_eth_uniphy {
+	struct device *dev;
+	void __iomem *base;
+	int num_clks;
+	struct clk_bulk_data *clks;
+	struct reset_control *rst;
+
+	int mode;
+
+	struct clk_hw *clk_rx, *clk_tx;
+	struct clk_hw_onecell_data *clk_data;
+};
+
+
+#define rmwl(addr, mask, val) \
+	writel(((readl(addr) & ~(mask)) | ((val) & (mask))), addr)
+
+static int cmn_init(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *cmn_base;
+	void __iomem *tcsr_base;
+	u32 val;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cmn");
+	if (!res)
+		return 0;
+
+	cmn_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR_OR_NULL(cmn_base))
+		return PTR_ERR(cmn_base);
+
+	/* For IPQ50xx, tcsr is necessary to enable cmn block */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr");
+	if (res) {
+		tcsr_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR_OR_NULL(tcsr_base))
+			return PTR_ERR(tcsr_base);
+
+		rmwl((tcsr_base + TCSR_ETH_CMN), TCSR_ETH_CMN_ENABLE,
+		     TCSR_ETH_CMN_ENABLE);
+	}
+
+	rmwl((cmn_base + CMN_PLL_REFCLK_SRC),
+	     CMN_PLL_REFCLK_SRC_FROM_MASK,
+	     CMN_PLL_REFCLK_SRC_FROM_REG);
+	rmwl((cmn_base + CMN_PLL_REFCLK),
+	     (CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_FREQ_MASK
+	      | CMN_PLL_REFCLK_DIV_MASK),
+	     (CMN_PLL_REFCLK_FREQ_48M | CMN_PLL_REFCLK_DIV(2)));
+
+	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N, 0);
+	msleep(1);
+	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N,
+	     CMN_PLL_CTRL_RST_N);
+	msleep(1);
+
+	return read_poll_timeout(readl, val,
+				 (val & CMN_PLL_STATUS_LOCKED),
+				 100, 200000, false,
+				 (cmn_base + CMN_PLL_STATUS));
+}
+
+
+static void uniphy_write(struct qcom_eth_uniphy *uniphy, int addr, u32 val)
+{
+	writel(val, (uniphy->base + addr));
+}
+
+static u32 uniphy_read(struct qcom_eth_uniphy *uniphy, int addr)
+{
+	return readl((uniphy->base + addr));
+}
+
+static void uniphy_rmw(struct qcom_eth_uniphy *uniphy, int addr, u32 mask, u32 val)
+{
+	u32 v = uniphy_read(uniphy, addr);
+	v &= ~mask;
+	v |= val & mask;
+	uniphy_write(uniphy, addr, v);
+}
+
+static int uniphy_clkout_init(struct qcom_eth_uniphy *uniphy)
+{
+	u32 val;
+	int ret;
+
+	ret = of_property_read_u32(uniphy->dev->of_node, "clkout-frequency", &val);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret < 0)
+		return ret;
+
+	switch(val) {
+		case QCOM_ETH_UNIPHY_CLKOUT_FREQ_25M:
+			uniphy_rmw(uniphy, IPQ50XX_UNIPHY_CLKOUT,
+				   IPQ50XX_UNIPHY_CLKOUT_DIV_MASK,
+				   IPQ50XX_UNIPHY_CLKOUT_DIV_25M);
+			break;
+		case QCOM_ETH_UNIPHY_CLKOUT_FREQ_50M:
+			uniphy_rmw(uniphy, IPQ50XX_UNIPHY_CLKOUT,
+				   IPQ50XX_UNIPHY_CLKOUT_DIV_MASK,
+				   IPQ50XX_UNIPHY_CLKOUT_DIV_50M);
+			break;
+		default:
+			dev_err(uniphy->dev, "Unsupported clkout-frequency: %d\n", val);
+			return -EINVAL;
+	}
+
+	ret = of_property_read_u32(uniphy->dev->of_node, "clkout-drive-strength", &val);
+	if (ret != -EINVAL) {
+		if (ret < 0)
+			return ret;
+
+		switch(val) {
+			case QCOM_ETH_UNIPHY_CLKOUT_DS_1_5V:
+				uniphy_rmw(uniphy, IPQ50XX_UNIPHY_CLKOUT,
+					   IPQ50XX_UNIPHY_CLKOUT_DS_MASK,
+					   IPQ50XX_UNIPHY_CLKOUT_DS_1_5V);
+				break;
+			case QCOM_ETH_UNIPHY_CLKOUT_DS_2_8V:
+				uniphy_rmw(uniphy, IPQ50XX_UNIPHY_CLKOUT,
+					   IPQ50XX_UNIPHY_CLKOUT_DS_MASK,
+					   IPQ50XX_UNIPHY_CLKOUT_DS_2_8V);
+				break;
+			default:
+				dev_err(uniphy->dev, "Unsupported clkout-drive-strength: %d\n", val);
+				return -EINVAL;
+		}
+
+	}
+
+	uniphy_rmw(uniphy, IPQ50XX_UNIPHY_CLKOUT,
+		   IPQ50XX_UNIPHY_CLKOUT_ENABLE,
+		   IPQ50XX_UNIPHY_CLKOUT_ENABLE);
+
+	return 0;
+}
+
+static int uniphy_mode_set(struct qcom_eth_uniphy *uniphy)
+{
+	int ret;
+
+	ret = of_property_read_u32(uniphy->dev->of_node, "mode",
+				   &uniphy->mode);
+	if (ret < 0)
+		return ret;
+
+	switch(uniphy->mode) {
+		case QCOM_ETH_UNIPHY_MODE_SGMII:
+			uniphy_write(uniphy, UNIPHY_MODE,
+				     UNIPHY_MODE_SGMII);
+			uniphy_rmw(uniphy, UNIPHY_SGMII,
+				   UNIPHY_SGMII_MODE_MASK,
+				   UNIPHY_SGMII_MODE_SGMII);
+			break;
+		default:
+			dev_err(uniphy->dev, "Unsupported mode: %d\n",
+				uniphy->mode);
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int uniphy_calibrate(struct qcom_eth_uniphy *uniphy)
+{
+	u32 val;
+
+	uniphy_rmw(uniphy, UNIPHY_PLL_CTRL, UNIPHY_PLL_CTRL_RST_N, 0);
+	msleep(1);
+	uniphy_rmw(uniphy, UNIPHY_PLL_CTRL, UNIPHY_PLL_CTRL_RST_N,
+		   UNIPHY_PLL_CTRL_RST_N);
+	msleep(1);
+
+	return read_poll_timeout(uniphy_read, val,
+				 (val & UNIPHY_CALIBRATION_DONE),
+				 100, 200000, false,
+				 uniphy, UNIPHY_CALIBRATION);
+}
+
+static int uniphy_clk_register(struct qcom_eth_uniphy *uniphy)
+{
+	unsigned long rate;
+	char name[64];
+	int ret;
+
+	switch (uniphy->mode) {
+		case QCOM_ETH_UNIPHY_MODE_SGMII:
+			rate = SGMII_CLK_RATE;
+			break;
+	}
+
+	snprintf(name, sizeof(name), "%s#rx", dev_name(uniphy->dev));
+	uniphy->clk_rx = clk_hw_register_fixed_rate(uniphy->dev, name,
+						    NULL, 0, rate);
+	if (IS_ERR_OR_NULL(uniphy->clk_rx))
+		return dev_err_probe(uniphy->dev, PTR_ERR(uniphy->clk_rx),
+				     "failed to register rx clock\n");
+
+	snprintf(name, sizeof(name), "%s#tx", dev_name(uniphy->dev));
+	uniphy->clk_tx = clk_hw_register_fixed_rate(uniphy->dev, name,
+						    NULL, 0, rate);
+	if (IS_ERR_OR_NULL(uniphy->clk_tx))
+		return dev_err_probe(uniphy->dev, PTR_ERR(uniphy->clk_tx),
+				     "failed to register rx clock\n");
+
+	uniphy->clk_data = devm_kzalloc(uniphy->dev,
+					struct_size(uniphy->clk_data, hws, 2),
+					GFP_KERNEL);
+	if (!uniphy->clk_data)
+		return dev_err_probe(uniphy->dev, -ENOMEM,
+				     "failed to allocate clk_data\n");
+
+	uniphy->clk_data->num = 2;
+	uniphy->clk_data->hws[0] = uniphy->clk_rx;
+	uniphy->clk_data->hws[1] = uniphy->clk_tx;
+	ret = of_clk_add_hw_provider(uniphy->dev->of_node,
+				     of_clk_hw_onecell_get,
+				     uniphy->clk_data);
+	if (ret)
+		return dev_err_probe(uniphy->dev, ret,
+				     "fail to register clock provider\n");
+
+	return 0;
+}
+
+static int qcom_eth_uniphy_calibrate(struct phy *phy)
+{
+	struct qcom_eth_uniphy *uniphy = phy_get_drvdata(phy);
+	dev_info(uniphy->dev, "calibrating\n");
+	return uniphy_calibrate(uniphy);
+}
+
+static const struct phy_ops qcom_eth_uniphy_ops = {
+	.calibrate = qcom_eth_uniphy_calibrate,
+	.owner = THIS_MODULE,
+};
+
+static int qcom_eth_uniphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_eth_uniphy *uniphy;
+	struct phy *phy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	ret = cmn_init(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to init cmn block\n");
+
+	uniphy = devm_kzalloc(dev, sizeof(*uniphy), GFP_KERNEL);
+	if (!uniphy)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate priv\n");
+
+	uniphy->dev = dev;
+	uniphy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(uniphy->base))
+		return dev_err_probe(dev, PTR_ERR(uniphy->base),
+				     "failed to ioremap base\n");
+
+	uniphy->num_clks = devm_clk_bulk_get_all(uniphy->dev, &uniphy->clks);
+	if (uniphy->num_clks < 0)
+		return dev_err_probe(uniphy->dev, uniphy->num_clks,
+				     "failed to acquire clocks\n");
+
+	ret = clk_bulk_prepare_enable(uniphy->num_clks, uniphy->clks);
+	if (ret)
+		return dev_err_probe(uniphy->dev, ret,
+				     "failed to enable clocks\n");
+
+	uniphy->rst = devm_reset_control_array_get_exclusive(uniphy->dev);
+	if (IS_ERR_OR_NULL(uniphy->rst))
+		return dev_err_probe(uniphy->dev, PTR_ERR(uniphy->rst),
+				     "failed to acquire reset\n");
+
+	ret = reset_control_reset(uniphy->rst);
+	if (ret)
+		return dev_err_probe(uniphy->dev, ret,
+				     "failed to reset\n");
+
+	ret = uniphy_clkout_init(uniphy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to init clkout\n");
+
+	ret = uniphy_mode_set(uniphy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set mode\n");
+
+	ret = uniphy_calibrate(uniphy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to calibrate\n");
+
+	ret = uniphy_clk_register(uniphy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register clocks\n");
+
+	phy = devm_phy_create(dev, dev->of_node, &qcom_eth_uniphy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "failed to register phy\n");
+
+	phy_set_drvdata(phy, uniphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(dev, PTR_ERR(phy_provider),
+				     "failed to register phy provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_eth_uniphy_of_match[] = {
+	{ .compatible = "qcom,ipq5018-eth-uniphy" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_eth_uniphy_of_match);
+
+static struct platform_driver qcom_eth_uniphy_driver = {
+	.probe	= qcom_eth_uniphy_probe,
+	.driver	= {
+		.name		= "qcom-eth-uniphy",
+		.of_match_table	= qcom_eth_uniphy_of_match,
+	},
+};
+module_platform_driver(qcom_eth_uniphy_driver);
+
+MODULE_DESCRIPTION("Qualcomm ethernet uniphy driver");
+MODULE_AUTHOR("Ziyang Huang <hzyitc@outlook.com>");
diff --git a/include/dt-bindings/phy/qcom-eth-uniphy.h b/include/dt-bindings/phy/qcom-eth-uniphy.h
new file mode 100644
index 000000000000..038f82522ccd
--- /dev/null
+++ b/include/dt-bindings/phy/qcom-eth-uniphy.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_PHY_QCOM_ETH_UNIPHY
+#define _DT_BINDINGS_PHY_QCOM_ETH_UNIPHY
+
+#define QCOM_ETH_UNIPHY_MODE_SGMII		0
+#define QCOM_ETH_UNIPHY_MODE_SGMII_PLUS		1
+
+#define QCOM_ETH_UNIPHY_CLKOUT_FREQ_25M		25000000
+#define QCOM_ETH_UNIPHY_CLKOUT_FREQ_50M		50000000
+
+#define QCOM_ETH_UNIPHY_CLKOUT_DS_1_5V		1500
+#define QCOM_ETH_UNIPHY_CLKOUT_DS_2_8V		2800
+
+#endif
-- 
2.40.1


