Return-Path: <linux-kernel+bounces-124490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA058918D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EBA282079
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA713BC18;
	Fri, 29 Mar 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZZ6gEx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394313BADD;
	Fri, 29 Mar 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715228; cv=none; b=lAEy6V86pzo7g/WBsz9dRx/97QF2F0iVOZwfOwUE4ICpt3SCkJSGIqDBTYE7ynllwTK0HGVHOgTy4oFB0tyEcYnsti7PiAuvrWgTkX8NQaRtLRMOrx5BQVUK/I69awPBIFSH48ef1csuX0512VdBG6uMvgP1bD6BG5EIloXnpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715228; c=relaxed/simple;
	bh=h3WjRl6FCPiOb7UaxUViTXFAYJtueWeXNUOD1jxOCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN+8RZx9JkMgdmLbvIjjrtg2hyVPN2eROjB1jJX+P5ys8Zwn13U1SHKustjwoaNEiMwMgNR7Enu4GP72Nx1Cp449bJ57XV9cUEkgA0c3bPHP91AbUJALR5YqjMLbyjwSYDNXWqMFap8mV7BMyxVIHjpBxKPoi/HMepU93IPMEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZZ6gEx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693B2C433F1;
	Fri, 29 Mar 2024 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715228;
	bh=h3WjRl6FCPiOb7UaxUViTXFAYJtueWeXNUOD1jxOCi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZZ6gEx5QDL14zNYxjnmskP81epd22U8AvS8bKy+qypWlaCCcBHPLg2daiC3o+jts
	 HUHsz5eGMzTtmoJRytzHJNyE26TYtpTapHsPpC5sHvYmLaQSeCz9j/Qm9Y9bhSOAP8
	 dI6OzkuTrDiIO5yZkDg39U2nJwc9zhUGKeJ/TYb/JORJbR+fVKvi4sMuxJRy4nV74E
	 nMX2bazgaFw8fMq4nb0omxQC12GAe525tcXBHy5uaigW6yDo6PPQXmz8z48MFPh0B6
	 StzhnuCKbt+toGLznzJCp4DCSHvgr138Gtcsl5M/tgLPvZNZp1yA2Kk2J6nuVP9b77
	 MJIQpFQ1mfMdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 09/68] wifi: rtw89: pci: validate RX tag for RXQ and RPQ
Date: Fri, 29 Mar 2024 08:25:05 -0400
Message-ID: <20240329122652.3082296-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 0bc7d1d4e63cf31ff1b4396b0e2f0e3c76828d26 ]

PCI RX ring is a kind of read/write index ring, and DMA and ring index are
asynchronous, so suddenly driver gets newer index ahead before DMA. To
resolve this rare situation, we use a RX tag as helpers to make sure DMA
is done.

The RX tag is a 13-bit value, and range is from 1 ~ 0x1FFF, but 0 isn't
used so should be skipped.

Only enable this validation to coming WiFi 7 chips, because existing
chips use different design and don't really meet this situation.

Add missed rx_ring_eq_is_full for 8851BE by the way.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240121071826.10159-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 60 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      |  4 +-
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 7 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 769f1ce62ebcc..cb03474f81552 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -155,8 +155,8 @@ static void rtw89_pci_sync_skb_for_device(struct rtw89_dev *rtwdev,
 				   DMA_FROM_DEVICE);
 }
 
-static int rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
-				      struct sk_buff *skb)
+static void rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
+				       struct sk_buff *skb)
 {
 	struct rtw89_pci_rxbd_info *rxbd_info;
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
@@ -166,10 +166,58 @@ static int rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
 	rx_info->ls = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_LS);
 	rx_info->len = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_WRITE_SIZE);
 	rx_info->tag = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_TAG);
+}
+
+static int rtw89_pci_validate_rx_tag(struct rtw89_dev *rtwdev,
+				     struct rtw89_pci_rx_ring *rx_ring,
+				     struct sk_buff *skb)
+{
+	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 target_rx_tag;
+
+	if (!info->check_rx_tag)
+		return 0;
+
+	/* valid range is 1 ~ 0x1FFF */
+	if (rx_ring->target_rx_tag == 0)
+		target_rx_tag = 1;
+	else
+		target_rx_tag = rx_ring->target_rx_tag;
+
+	if (rx_info->tag != target_rx_tag) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "mismatch RX tag 0x%x 0x%x\n",
+			    rx_info->tag, target_rx_tag);
+		return -EAGAIN;
+	}
 
 	return 0;
 }
 
+static
+int rtw89_pci_sync_skb_for_device_and_validate_rx_info(struct rtw89_dev *rtwdev,
+						       struct rtw89_pci_rx_ring *rx_ring,
+						       struct sk_buff *skb)
+{
+	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	int rx_tag_retry = 100;
+	int ret;
+
+	do {
+		rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
+		rtw89_pci_rxbd_info_update(rtwdev, skb);
+
+		ret = rtw89_pci_validate_rx_tag(rtwdev, rx_ring, skb);
+		if (ret != -EAGAIN)
+			break;
+	} while (rx_tag_retry--);
+
+	/* update target rx_tag for next RX */
+	rx_ring->target_rx_tag = rx_info->tag + 1;
+
+	return ret;
+}
+
 static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -259,9 +307,8 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 
 	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
 	skb = rx_ring->buf[skb_idx];
-	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
-	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
+	ret = rtw89_pci_sync_skb_for_device_and_validate_rx_info(rtwdev, rx_ring, skb);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update %d RXBD info: %d\n",
 			  bd_ring->wp, ret);
@@ -549,9 +596,8 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 
 	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
 	skb = rx_ring->buf[skb_idx];
-	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
-	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
+	ret = rtw89_pci_sync_skb_for_device_and_validate_rx_info(rtwdev, rx_ring, skb);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update %d RXBD info: %d\n",
 			  bd_ring->wp, ret);
@@ -1550,6 +1596,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		bd_ring->rp = 0;
 		rx_ring->diliver_skb = NULL;
 		rx_ring->diliver_desc.ready = false;
+		rx_ring->target_rx_tag = 0;
 
 		rtw89_write16(rtwdev, addr_num, bd_ring->len);
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
@@ -3148,6 +3195,7 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 	rx_ring->buf_sz = buf_sz;
 	rx_ring->diliver_skb = NULL;
 	rx_ring->diliver_desc.ready = false;
+	rx_ring->target_rx_tag = 0;
 
 	for (i = 0; i < len; i++) {
 		skb = dev_alloc_skb(buf_sz);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index ca5de77fee90a..83a36358504f4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1234,6 +1234,7 @@ struct rtw89_pci_info {
 	enum mac_ax_pcie_func_ctrl io_rcy_en;
 	enum mac_ax_io_rcy_tmr io_rcy_tmr;
 	bool rx_ring_eq_is_full;
+	bool check_rx_tag;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
@@ -1276,7 +1277,7 @@ struct rtw89_pci_tx_data {
 
 struct rtw89_pci_rx_info {
 	dma_addr_t dma;
-	u32 fs:1, ls:1, tag:11, len:14;
+	u32 fs:1, ls:1, tag:13, len:14;
 };
 
 #define RTW89_PCI_TXBD_OPTION_LS	BIT(14)
@@ -1405,6 +1406,7 @@ struct rtw89_pci_rx_ring {
 	u32 buf_sz;
 	struct sk_buff *diliver_skb;
 	struct rtw89_rx_desc_info diliver_desc;
+	u32 target_rx_tag:13;
 };
 
 struct rtw89_pci_isrs {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ade69bd30fc86..ca1374a717272 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -25,6 +25,8 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index f1e890bde0499..7c6ffedb77e27 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 920b20bbcfb73..ed71364e6437b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 4592de3dbd942..583ea673a4f54 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -35,6 +35,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 7b3d98d2c402c..9f46fb1661055 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_DEF,
 	.rx_ring_eq_is_full	= true,
+	.check_rx_tag		= true,
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
-- 
2.43.0


