Return-Path: <linux-kernel+bounces-63355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32927852E19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0FA282F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8C374C9;
	Tue, 13 Feb 2024 10:37:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD52556E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820625; cv=none; b=ru1QAa/aRc2qCBS+RhWNCWoWmktw1ObUYfyczq6tcbLMCDfIOb1zXA9h9QIaG62NlKVAMtK4AmymuiBbG7tzMlXP8p6tjiwr9VUTmEdYajP+Nnz48F9Z1HAQ98zEnwIuxKZ7NV0GdtaahDoA0+tXhL1pmFL97bSRXdPXu3xWPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820625; c=relaxed/simple;
	bh=Jp6tNSdjSsC9LzR+F9BEv8HFfLEkEp33evtGY9YtxYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQEtFEK2jwUjZRjBz6gu2atGGzEusGVO/V4u2KARbFWeBKqM5YVP6+A5K+w7PvmF9U1AKL0UHkoiDD3ClI6QNTWS0yVTn4UhdIlM3+dqQkLpgxT1VM9hjeF1MgJ8VJpOu4/6qq/M91JutxuIwwjEXHi+nnSFYgicjxaoDo8mSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9s-0003Jw-Ku
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:37:00 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq9s-000SqB-3l
	for linux-kernel@vger.kernel.org; Tue, 13 Feb 2024 11:37:00 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C6E3C28D55F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:36:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1BC1128D525;
	Tue, 13 Feb 2024 10:36:56 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 176c2619;
	Tue, 13 Feb 2024 10:36:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 13 Feb 2024 11:36:45 +0100
Subject: [PATCH v8 3/3] can: xilinx_can: Add ethtool stats interface for
 ECC errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-xilinx_ecc-v8-3-8d75f8b80771@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4531; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dNs+TfFXHp8UoDrintPodrh7/2sUKiVmMtrwIfjEaDA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBly0ZEUHK7FW/4BO0TagCM8AasjVGSlWduY1Pdu
 3MDqmGYmNGJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZctGRAAKCRAoOKI+ei28
 b/1eB/9SIIq+eB8ulaG3zZoCZclbhuQxdvbvH87ds3WiJeZejquKSGhnvr1KSE1D1B+tnzrJJp8
 hKEA2n4z/8kuGM+n8lIfP5bJyTivOZju8zi504sGHq91HeGG53AJxjFZP7wvOJ/miL7zG/ne6Ru
 5M1LfZrovBgSGIXokdlMy1YIKj0WVg65M8T7AIAZ9PVOzv48YYG8mNIWGRm3/HBXLJ2Q+lhMbHt
 ddhpdDL33nwUng2gHOs0BoaQ+j1tIyvFzdrk8r1tdbs+Xifv0QMLEO/XKyJuKcebteIEYJz1qwD
 DlYW2pukarxHeJA6UabmQp32YU8dJTxsREmHX8he1LiLSt8U
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Srinivas Goud <srinivas.goud@amd.com>

Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors
information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index af2af4eade3c..fae0120473f8 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -228,6 +228,7 @@ struct xcan_devtype_data {
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
  * @ecc_enable:			ECC enable flag
+ * @syncp:			synchronization for ECC error stats
  * @ecc_rx_2_bit_errors:	RXFIFO 2bit ECC count
  * @ecc_rx_1_bit_errors:	RXFIFO 1bit ECC count
  * @ecc_txol_2_bit_errors:	TXOLFIFO 2bit ECC count
@@ -254,6 +255,7 @@ struct xcan_priv {
 	struct phy *transceiver;
 	struct reset_control *rstc;
 	bool ecc_enable;
+	struct u64_stats_sync syncp;
 	u64_stats_t ecc_rx_2_bit_errors;
 	u64_stats_t ecc_rx_1_bit_errors;
 	u64_stats_t ecc_txol_2_bit_errors;
@@ -347,6 +349,24 @@ static const struct can_tdc_const xcan_tdc_const_canfd2 = {
 	.tdcf_max = 0,
 };
 
+enum xcan_stats_type {
+	XCAN_ECC_RX_2_BIT_ERRORS,
+	XCAN_ECC_RX_1_BIT_ERRORS,
+	XCAN_ECC_TXOL_2_BIT_ERRORS,
+	XCAN_ECC_TXOL_1_BIT_ERRORS,
+	XCAN_ECC_TXTL_2_BIT_ERRORS,
+	XCAN_ECC_TXTL_1_BIT_ERRORS,
+};
+
+static const char xcan_priv_flags_strings[][ETH_GSTRING_LEN] = {
+	[XCAN_ECC_RX_2_BIT_ERRORS] = "ecc_rx_2_bit_errors",
+	[XCAN_ECC_RX_1_BIT_ERRORS] = "ecc_rx_1_bit_errors",
+	[XCAN_ECC_TXOL_2_BIT_ERRORS] = "ecc_txol_2_bit_errors",
+	[XCAN_ECC_TXOL_1_BIT_ERRORS] = "ecc_txol_1_bit_errors",
+	[XCAN_ECC_TXTL_2_BIT_ERRORS] = "ecc_txtl_2_bit_errors",
+	[XCAN_ECC_TXTL_1_BIT_ERRORS] = "ecc_txtl_1_bit_errors",
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:	Driver private data structure
@@ -1182,6 +1202,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
 
+		u64_stats_update_begin(&priv->syncp);
+
 		if (isr & XCAN_IXR_E2BERX_MASK) {
 			u64_stats_add(&priv->ecc_rx_2_bit_errors,
 				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
@@ -1211,6 +1233,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 			u64_stats_add(&priv->ecc_txtl_1_bit_errors,
 				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txtl_ecc));
 		}
+
+		u64_stats_update_end(&priv->syncp);
 	}
 
 	if (cf.can_id) {
@@ -1637,6 +1661,43 @@ static int xcan_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
 	return 0;
 }
 
+static void xcan_get_strings(struct net_device *ndev, u32 stringset, u8 *buf)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(buf, &xcan_priv_flags_strings,
+		       sizeof(xcan_priv_flags_strings));
+	}
+}
+
+static int xcan_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(xcan_priv_flags_strings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void xcan_get_ethtool_stats(struct net_device *ndev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->syncp);
+
+		data[XCAN_ECC_RX_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_rx_2_bit_errors);
+		data[XCAN_ECC_RX_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_rx_1_bit_errors);
+		data[XCAN_ECC_TXOL_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_txol_2_bit_errors);
+		data[XCAN_ECC_TXOL_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_txol_1_bit_errors);
+		data[XCAN_ECC_TXTL_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_txtl_2_bit_errors);
+		data[XCAN_ECC_TXTL_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_txtl_1_bit_errors);
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
+}
+
 static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
@@ -1646,6 +1707,9 @@ static const struct net_device_ops xcan_netdev_ops = {
 
 static const struct ethtool_ops xcan_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_strings = xcan_get_strings,
+	.get_sset_count = xcan_get_sset_count,
+	.get_ethtool_stats = xcan_get_ethtool_stats,
 };
 
 /**

-- 
2.43.0



