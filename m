Return-Path: <linux-kernel+bounces-22102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1D82993D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922561C24848
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E947A7C;
	Wed, 10 Jan 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cTr9mjEx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C447F40;
	Wed, 10 Jan 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704886672; x=1736422672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T78Tl1qTZBEDtDopMTraFY8YsyTlW8PPISWExCLGH0k=;
  b=cTr9mjEx4iSdjuj3up2agluOZslc1IfwidokV7fppHgonOy2qaRdqmYa
   9UIAfMiqLHzfBqJTsSbdVi3N6wFdy/Euigqc8jD1gj2uPJvLKIdcKmF7M
   BLoanQxDSf5loe0dxmfVrT6MmOsGsUEkjvh0/w3cGZzV+dggZ7s3ViF8c
   GquN7mDZ4Uxpp7l5OdlB8hxB8llwdsQnH+yGaCvqFR9iWCL1Wf6BtrNI6
   Z93jJUBTsxQ8EiLvPGg8/RgoX2PJZ1L91UthixVbA9XdB2RNuAUCZPuV4
   2jyOmTrsI+VoMXiw3xgoV1dys2tBuQ8khD3qiZs3vCnkqV4GKtF8zK57g
   Q==;
X-CSE-ConnectionGUID: /AVVYdDBSmGfb5OcBoykfA==
X-CSE-MsgGUID: O5IgCn1lRnC2SJLAFDZmAQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="14975477"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2024 04:37:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 04:37:36 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 04:37:34 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horatiu.vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net] net: micrel: Fix PTP frame parsing for lan8841
Date: Wed, 10 Jan 2024 12:37:30 +0100
Message-ID: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
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
in minorVersionPTP.
Fix this issue by removing this check so the userspace can decide on this.

Fixes: cafc3662ee3f ("net: micrel: Add PHC support for lan8841")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9035c7f55d1bf..0f064d784e33b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3609,8 +3609,10 @@ static int lan8814_probe(struct phy_device *phydev)
 #define LAN8841_ADC_CHANNEL_MASK		198
 #define LAN8841_PTP_RX_PARSE_L2_ADDR_EN		370
 #define LAN8841_PTP_RX_PARSE_IP_ADDR_EN		371
+#define LAN8841_PTP_RX_VERSION			374
 #define LAN8841_PTP_TX_PARSE_L2_ADDR_EN		434
 #define LAN8841_PTP_TX_PARSE_IP_ADDR_EN		435
+#define LAN8841_PTP_TX_VERSION			438
 #define LAN8841_PTP_CMD_CTL			256
 #define LAN8841_PTP_CMD_CTL_PTP_ENABLE		BIT(2)
 #define LAN8841_PTP_CMD_CTL_PTP_DISABLE		BIT(1)
@@ -3654,6 +3656,12 @@ static int lan8841_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
 		      LAN8841_PTP_RX_PARSE_IP_ADDR_EN, 0);
 
+	/* Disable checking for minorVersionPTP field */
+	phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_VERSION, 0xff00);
+	phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_VERSION, 0xff00);
+
 	/* 100BT Clause 40 improvenent errata */
 	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
 		      LAN8841_ANALOG_CONTROL_1,
-- 
2.34.1


