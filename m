Return-Path: <linux-kernel+bounces-63356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082F852E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6932B22A79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CB376E6;
	Tue, 13 Feb 2024 10:37:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94758250FE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820625; cv=none; b=BYE5+Ibn6sSx/QVkU2EyJCKk33/L7QgfmokKWkoomgFPjxKIHgHSCw3hSCKB1NeafcVKlbDRYlN6oF2eM3YgGd01HKchaNEhfvYmf8P54itTjHoirectXX/wb9XhXDqSKIwHhNY6CRJEaH71V96zSm5fyGYpBOhaA4KOVGlT5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820625; c=relaxed/simple;
	bh=OQNLkfn2weLX6cBIlGQmnnt7DIK8DFhuXLHeqDbcFy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNmQiiWwsgM/o4HGn+COXevG4eVR2viE9DBvZkdHDgRZSeCrcBOuz5cNBXRuJnmwPMcSgajz6jayKAgT4YbOkkR32btKCFMxrbdzLt3T7L41m4tUsVOHvB62L+B22JOaLFjfaRsioUsQKkRNoPOt3iu2+Ar5LTznPTV9c9zlBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9s-0003K0-MI
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:37:00 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9s-000SqH-5n
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:37:00 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D490D28D560
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:36:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E41E928D522;
	Tue, 13 Feb 2024 10:36:55 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b8acd59c;
	Tue, 13 Feb 2024 10:36:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 13 Feb 2024 11:36:44 +0100
Subject: [PATCH v8 2/3] can: xilinx_can: Add ECC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-xilinx_ecc-v8-2-8d75f8b80771@pengutronix.de>
References: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
In-Reply-To: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Srinivas Goud <srinivas.goud@amd.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=openpgp-sha256; l=8338; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gS9ttAxKlaZVOdUEMKLhADsphMzyBL6B+1TmW/EIUeM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBly0ZCLx3YJnmzr0QrOOE4bbY0rryv24n6HQUJH
 WB0FwgqbKiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZctGQgAKCRAoOKI+ei28
 bwDZCACNnZX5KR7bYK2I8TE9VceuF4Vx+FTn81CBamjsxoRnJr0qq6kTvefjJa7kq7N393diyX1
 FftLCK4Imn7WqRGXwjgVRgsA9BvnhXA3zBSksy7txHymRlKNjMFucRjtBDuQ9yq8Vgfo066w2jN
 k5wrII9iU7XMIgTboadPAcz1XGT2L/h/sVnAhRcRC1g6l6PNkPYWusIsHqiIT+xzRy0qhWnVDbH
 T8FckT2VbrLC3WAM4IX8hrkIMWz5Hq0Hij8dH7fxUYrPjF7F2/8Ha9MxYCEdd6H2Vz0GWDvGE0p
 /KmWqPzqGAqKH3265KCFivki49xp6nlUMdrABNOnzbAFqT5K
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Srinivas Goud <srinivas.goud@amd.com>

Add ECC support for Xilinx CAN Controller, so this driver reports
1bit/2bit ECC errors for FIFO's based on ECC error interrupt. ECC
feature for Xilinx CAN Controller selected through 'xlnx,has-ecc' DT
property

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 105 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3722eaa84234..af2af4eade3c 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -31,6 +31,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/u64_stats_sync.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
@@ -58,6 +59,13 @@ enum xcan_reg {
 					  */
 	XCAN_F_BTR_OFFSET	= 0x08C, /* Data Phase Bit Timing */
 	XCAN_TRR_OFFSET		= 0x0090, /* TX Buffer Ready Request */
+
+	/* only on AXI CAN cores */
+	XCAN_ECC_CFG_OFFSET	= 0xC8, /* ECC Configuration */
+	XCAN_TXTLFIFO_ECC_OFFSET	= 0xCC, /* TXTL FIFO ECC error counter */
+	XCAN_TXOLFIFO_ECC_OFFSET	= 0xD0, /* TXOL FIFO ECC error counter */
+	XCAN_RXFIFO_ECC_OFFSET	= 0xD4, /* RX FIFO ECC error counter */
+
 	XCAN_AFR_EXT_OFFSET	= 0x00E0, /* Acceptance Filter */
 	XCAN_FSR_OFFSET		= 0x00E8, /* RX FIFO Status */
 	XCAN_TXMSG_BASE_OFFSET	= 0x0100, /* TX Message Space */
@@ -124,6 +132,18 @@ enum xcan_reg {
 #define XCAN_IXR_TXFLL_MASK		0x00000004 /* Tx FIFO Full intr */
 #define XCAN_IXR_TXOK_MASK		0x00000002 /* TX successful intr */
 #define XCAN_IXR_ARBLST_MASK		0x00000001 /* Arbitration lost intr */
+#define XCAN_IXR_E2BERX_MASK		BIT(23) /* RX FIFO two bit ECC error */
+#define XCAN_IXR_E1BERX_MASK		BIT(22) /* RX FIFO one bit ECC error */
+#define XCAN_IXR_E2BETXOL_MASK		BIT(21) /* TXOL FIFO two bit ECC error */
+#define XCAN_IXR_E1BETXOL_MASK		BIT(20) /* TXOL FIFO One bit ECC error */
+#define XCAN_IXR_E2BETXTL_MASK		BIT(19) /* TXTL FIFO Two bit ECC error */
+#define XCAN_IXR_E1BETXTL_MASK		BIT(18) /* TXTL FIFO One bit ECC error */
+#define XCAN_IXR_ECC_MASK		(XCAN_IXR_E2BERX_MASK | \
+					XCAN_IXR_E1BERX_MASK | \
+					XCAN_IXR_E2BETXOL_MASK | \
+					XCAN_IXR_E1BETXOL_MASK | \
+					XCAN_IXR_E2BETXTL_MASK | \
+					XCAN_IXR_E1BETXTL_MASK)
 #define XCAN_IDR_ID1_MASK		0xFFE00000 /* Standard msg identifier */
 #define XCAN_IDR_SRR_MASK		0x00100000 /* Substitute remote TXreq */
 #define XCAN_IDR_IDE_MASK		0x00080000 /* Identifier extension */
@@ -137,6 +157,11 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
+#define XCAN_ECC_1BIT_CNT_MASK		GENMASK(15, 0) /* FIFO ECC 1bit count mask */
+#define XCAN_ECC_2BIT_CNT_MASK		GENMASK(31, 16) /* FIFO ECC 2bit count mask */
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BRPR_TDC_ENABLE		BIT(16) /* Transmitter Delay Compensation (TDC) Enable */
@@ -202,6 +227,13 @@ struct xcan_devtype_data {
  * @devtype:			Device type specific constants
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
+ * @ecc_enable:			ECC enable flag
+ * @ecc_rx_2_bit_errors:	RXFIFO 2bit ECC count
+ * @ecc_rx_1_bit_errors:	RXFIFO 1bit ECC count
+ * @ecc_txol_2_bit_errors:	TXOLFIFO 2bit ECC count
+ * @ecc_txol_1_bit_errors:	TXOLFIFO 1bit ECC count
+ * @ecc_txtl_2_bit_errors:	TXTLFIFO 2bit ECC count
+ * @ecc_txtl_1_bit_errors:	TXTLFIFO 1bit ECC count
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -221,6 +253,13 @@ struct xcan_priv {
 	struct xcan_devtype_data devtype;
 	struct phy *transceiver;
 	struct reset_control *rstc;
+	bool ecc_enable;
+	u64_stats_t ecc_rx_2_bit_errors;
+	u64_stats_t ecc_rx_1_bit_errors;
+	u64_stats_t ecc_txol_2_bit_errors;
+	u64_stats_t ecc_txol_1_bit_errors;
+	u64_stats_t ecc_txtl_2_bit_errors;
+	u64_stats_t ecc_txtl_1_bit_errors;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -523,6 +562,9 @@ static int xcan_chip_start(struct net_device *ndev)
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
 		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
 
+	if (priv->ecc_enable)
+		ier |= XCAN_IXR_ECC_MASK;
+
 	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
 		ier |= XCAN_IXR_RXMNF_MASK;
 
@@ -1127,6 +1169,50 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->can.can_stats.bus_error++;
 	}
 
+	if (priv->ecc_enable && isr & XCAN_IXR_ECC_MASK) {
+		u32 reg_rx_ecc, reg_txol_ecc, reg_txtl_ecc;
+
+		reg_rx_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
+		reg_txol_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
+		reg_txtl_ecc = priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
+
+		/* The counter reaches its maximum at 0xffff and does not overflow.
+		 * Accept the small race window between reading and resetting ECC counters.
+		 */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+
+		if (isr & XCAN_IXR_E2BERX_MASK) {
+			u64_stats_add(&priv->ecc_rx_2_bit_errors,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BERX_MASK) {
+			u64_stats_add(&priv->ecc_rx_1_bit_errors,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_rx_ecc));
+		}
+
+		if (isr & XCAN_IXR_E2BETXOL_MASK) {
+			u64_stats_add(&priv->ecc_txol_2_bit_errors,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_txol_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BETXOL_MASK) {
+			u64_stats_add(&priv->ecc_txol_1_bit_errors,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txol_ecc));
+		}
+
+		if (isr & XCAN_IXR_E2BETXTL_MASK) {
+			u64_stats_add(&priv->ecc_txtl_2_bit_errors,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_txtl_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BETXTL_MASK) {
+			u64_stats_add(&priv->ecc_txtl_1_bit_errors,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txtl_ecc));
+		}
+	}
+
 	if (cf.can_id) {
 		struct can_frame *skb_cf;
 		struct sk_buff *skb = alloc_can_err_skb(ndev, &skb_cf);
@@ -1354,8 +1440,8 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct xcan_priv *priv = netdev_priv(ndev);
+	u32 isr_errors, mask;
 	u32 isr, ier;
-	u32 isr_errors;
 	u32 rx_int_mask = xcan_rx_int_mask(priv);
 
 	/* Get the interrupt status from Xilinx CAN */
@@ -1374,10 +1460,15 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	if (isr & XCAN_IXR_TXOK_MASK)
 		xcan_tx_interrupt(ndev, isr);
 
+	mask = XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
+		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
+		XCAN_IXR_RXMNF_MASK;
+
+	if (priv->ecc_enable)
+		mask |= XCAN_IXR_ECC_MASK;
+
 	/* Check for the type of error interrupt and Processing it */
-	isr_errors = isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
-			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
-			    XCAN_IXR_RXMNF_MASK);
+	isr_errors = isr & mask;
 	if (isr_errors) {
 		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
 		xcan_err_interrupt(ndev, isr);
@@ -1793,6 +1884,7 @@ static int xcan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = netdev_priv(ndev);
+	priv->ecc_enable = of_property_read_bool(pdev->dev.of_node, "xlnx,has-ecc");
 	priv->dev = &pdev->dev;
 	priv->can.bittiming_const = devtype->bittiming_const;
 	priv->can.do_set_mode = xcan_do_set_mode;
@@ -1909,6 +2001,11 @@ static int xcan_probe(struct platform_device *pdev)
 		   priv->reg_base, ndev->irq, priv->can.clock.freq,
 		   hw_tx_max, priv->tx_max);
 
+	if (priv->ecc_enable) {
+		/* Reset FIFO ECC counters */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+	}
 	return 0;
 
 err_disableclks:

-- 
2.43.0



