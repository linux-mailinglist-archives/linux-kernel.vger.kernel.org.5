Return-Path: <linux-kernel+bounces-25291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E243882CCC7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FF21C21373
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C052111F;
	Sat, 13 Jan 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sH0cOpGH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CE2136E;
	Sat, 13 Jan 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705151845; x=1736687845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abPbTNs1CsVgwLtFAdwl+WDAEAxIlyXeXILkvGReD2c=;
  b=sH0cOpGHq6e8sCNtatsTUroTd0Df+eXZlKXoQqcAv0GhwBsQCbgP/3P7
   vcoZ61S5aDp24ziPPR/skkws6/a4r0rLDHf7sf7tcQzyIvzgwv5q92JQD
   wDRpFXwrihLftemV+JBTqRdnmHMsHoPtm+1wBBzp1fa7jn+qRlgZWrIqO
   Xy+nBBb8Isfv0zuwLlq82MZJLb0Vv4X6Ek5SeMMEjoClzBnPRm6uLaUmz
   1DQ4Mk2h+EQiV0CEQ1EfYzjrTJa3S8+0VGsMN3Iedf0smEntK/c+HtrKm
   zQ+VvdK5l9qFrNXBLQ5AaHGU4o+fSeFyV99jcoI4OuGv/YSqcFTGaKY1a
   Q==;
X-CSE-ConnectionGUID: IbxK4g7OS92kjFhowD7KHA==
X-CSE-MsgGUID: /VvpAM8RRNOcuKNlJQ1zMQ==
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="245432934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2024 06:17:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 06:17:07 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 13 Jan 2024 06:17:04 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net 1/2] net: micrel: Fix PTP frame parsing for lan8814
Date: Sat, 13 Jan 2024 14:15:20 +0100
Message-ID: <20240113131521.1051921-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The HW has the capability to check each frame if it is a PTP frame,
which domain it is, which ptp frame type it is, different ip address in
the frame. And if one of these checks fail then the frame is not
timestamp. Most of these checks were disabled except checking the field
minorVersionPTP inside the PTP header. Meaning that once a partner sends
a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
frame was not timestamp because the HW expected by default a value of 0
in minorVersionPTP. This is exactly the same issue as on lan8841.
Fix this issue by removing this check so the userspace can decide on this.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index bf4053431dcb3..1752eaeadc42e 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -120,6 +120,9 @@
  */
 #define LAN8814_1PPM_FORMAT			17179
 
+#define PTP_RX_VERSION				0x0248
+#define PTP_TX_VERSION				0x0288
+
 #define PTP_RX_MOD				0x024F
 #define PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_ BIT(3)
 #define PTP_RX_TIMESTAMP_EN			0x024D
@@ -3150,6 +3153,10 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
 	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
 
+	/* Disable checking for minorVersionPTP field */
+	lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION, 0xff00);
+	lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION, 0xff00);
+
 	skb_queue_head_init(&ptp_priv->tx_queue);
 	skb_queue_head_init(&ptp_priv->rx_queue);
 	INIT_LIST_HEAD(&ptp_priv->rx_ts_list);
-- 
2.34.1


