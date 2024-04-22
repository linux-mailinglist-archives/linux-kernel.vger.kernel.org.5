Return-Path: <linux-kernel+bounces-153883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE08AD473
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE41C213D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13B155307;
	Mon, 22 Apr 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDBgI7nu"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342A15357A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812294; cv=none; b=TQed2B/BKhDrjGcxFk+5kom3rNttMl1AZbcYTf2+2GGPwMQ/G9lA3YTu8wNY0tpwWyJhrsfMFFrQmjzgAW2iTNnakDyWXzVIZ0C4uBQ23QuBqU74uyZNbHstMUB4C/Iw5sjppEnGMyuF3mY194HzrX11UWifRqH7yau31H6QXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812294; c=relaxed/simple;
	bh=4BrNoPwKBXYaMJhkzIKOVpin06weeAB2LUobZt4RwTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sr5XOI7sw3Qwj6gL9myNDbAln7yzXauxIm2taTJ6BurQmrln3rbXvi+tMUh+zvWfxqIGHwLswfxlaeqlnr7XZEtiYPWdXCmR/WfpM/Wo7TXNZf//9+C/G3bZbyEvTYKBkJLHevzhIW8yQEqHQLiYAVj919q4ESTHuby7eXSuz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDBgI7nu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713812290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nEfY1XozlY3i97oqjNfAQ99IopkjONdMTRbrJqH5LA=;
	b=CDBgI7nuTp0UNXJIVK/kq2arWUCNLXgS4+jEt/704hzJd4qK4VS51xL1oEtZ/KPZyINryD
	24BxU+VQAOYtFmMFqHKgQu0TIcIzRd0EYODCgU5eVMWQRvmNqLY61QGLWwvNpBnDYpVWLS
	uEErXji48kJqSSY/+DOxA6CqHe2Jl28=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] phy: zynqmp: Store instance instead of type
Date: Mon, 22 Apr 2024 14:58:01 -0400
Message-Id: <20240422185803.3575319-2-sean.anderson@linux.dev>
In-Reply-To: <20240422185803.3575319-1-sean.anderson@linux.dev>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The phy "type" is just the combination of protocol and instance, and is
never used apart from that. Store the instance directly, instead of
converting to a type first. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/xilinx/phy-zynqmp.c | 107 +++++++-------------------------
 1 file changed, 24 insertions(+), 83 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index f72c5257d712..b507ed4c3053 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -146,22 +146,6 @@
 /* Total number of controllers */
 #define CONTROLLERS_PER_LANE		5
 
-/* Protocol Type parameters */
-#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
-#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
-#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
-#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
-#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
-#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
-#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
-#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
-#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
-#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
-#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
-#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
-#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
-#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
-
 /* Timeout values */
 #define TIMEOUT_US			1000
 
@@ -184,7 +168,8 @@ struct xpsgtr_ssc {
 /**
  * struct xpsgtr_phy - representation of a lane
  * @phy: pointer to the kernel PHY device
- * @type: controller which uses this lane
+ * @instance: instance of the protocol type (such as the lane within a
+ *            protocol, or the USB/Ethernet controller)
  * @lane: lane number
  * @protocol: protocol in which the lane operates
  * @skip_phy_init: skip phy_init() if true
@@ -193,7 +178,7 @@ struct xpsgtr_ssc {
  */
 struct xpsgtr_phy {
 	struct phy *phy;
-	u8 type;
+	u8 instance;
 	u8 lane;
 	u8 protocol;
 	bool skip_phy_init;
@@ -330,8 +315,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
 
 	if (ret == -ETIMEDOUT)
 		dev_err(gtr_dev->dev,
-			"lane %u (type %u, protocol %u): PLL lock timeout\n",
-			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
+			"lane %u (protocol %u, instance %u): PLL lock timeout\n",
+			gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
 
 	return ret;
 }
@@ -643,8 +628,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
 	 * cumulating waits for both lanes. The user is expected to initialize
 	 * lane 0 last.
 	 */
-	if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
-	    gtr_phy->type == XPSGTR_TYPE_DP_0)
+	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
 		ret = xpsgtr_wait_pll_lock(phy);
 
 	return ret;
@@ -674,73 +658,33 @@ static const struct phy_ops xpsgtr_phyops = {
  * OF Xlate Support
  */
 
-/* Set the lane type and protocol based on the PHY type and instance number. */
+/* Set the lane protocol and instance based on the PHY type and instance number. */
 static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
 				unsigned int phy_instance)
 {
 	unsigned int num_phy_types;
-	const int *phy_types;
 
 	switch (phy_type) {
-	case PHY_TYPE_SATA: {
-		static const int types[] = {
-			XPSGTR_TYPE_SATA_0,
-			XPSGTR_TYPE_SATA_1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_SATA:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_SATA;
 		break;
-	}
-	case PHY_TYPE_USB3: {
-		static const int types[] = {
-			XPSGTR_TYPE_USB0,
-			XPSGTR_TYPE_USB1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_USB3:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_USB;
 		break;
-	}
-	case PHY_TYPE_DP: {
-		static const int types[] = {
-			XPSGTR_TYPE_DP_0,
-			XPSGTR_TYPE_DP_1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_DP:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_DP;
 		break;
-	}
-	case PHY_TYPE_PCIE: {
-		static const int types[] = {
-			XPSGTR_TYPE_PCIE_0,
-			XPSGTR_TYPE_PCIE_1,
-			XPSGTR_TYPE_PCIE_2,
-			XPSGTR_TYPE_PCIE_3,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_PCIE:
+		num_phy_types = 4;
 		gtr_phy->protocol = ICM_PROTOCOL_PCIE;
 		break;
-	}
-	case PHY_TYPE_SGMII: {
-		static const int types[] = {
-			XPSGTR_TYPE_SGMII0,
-			XPSGTR_TYPE_SGMII1,
-			XPSGTR_TYPE_SGMII2,
-			XPSGTR_TYPE_SGMII3,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_SGMII:
+		num_phy_types = 4;
 		gtr_phy->protocol = ICM_PROTOCOL_SGMII;
 		break;
-	}
 	default:
 		return -EINVAL;
 	}
@@ -748,7 +692,7 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
 	if (phy_instance >= num_phy_types)
 		return -EINVAL;
 
-	gtr_phy->type = phy_types[phy_instance];
+	gtr_phy->instance = phy_instance;
 	return 0;
 }
 
@@ -756,14 +700,11 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
  * Valid combinations of controllers and lanes (Interconnect Matrix).
  */
 static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
-	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
-	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
-	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
-	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
-		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
+	/* PCIe, SATA, USB, DP, SGMII */
+	{ 0, 0, 0, 1, 0 },
+	{ 1, 1, 0, 0, 1 },
+	{ 2, 0, 0, 1, 2 },
+	{ 3, 1, 1, 0, 3 },
 };
 
 /* Translate OF phandle and args to PHY instance. */
@@ -818,7 +759,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	 * is allowed to operate on the lane.
 	 */
 	for (i = 0; i < CONTROLLERS_PER_LANE; i++) {
-		if (icm_matrix[phy_lane][i] == gtr_phy->type)
+		if (icm_matrix[phy_lane][i] == gtr_phy->instance)
 			return gtr_phy->phy;
 	}
 
-- 
2.35.1.1320.gc452695387.dirty


