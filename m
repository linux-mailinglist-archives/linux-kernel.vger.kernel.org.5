Return-Path: <linux-kernel+bounces-20110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5E82797B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E5C2831D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E1A5577C;
	Mon,  8 Jan 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZCpf1wB6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C954BDA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704747128; x=1736283128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R13qs6Drr+vE44nRwLO0hKg3RFvsSJlh1LucsPdn9Z4=;
  b=ZCpf1wB6d2thpbFqOQBaKUHLEkMX6hEs3ePodgw37A/AsIQ2FsF6X+H/
   4uJrFdvLOopRu3pJ4vuYzdvNujsOdUTHUINOuUUji/iTedH6tyufje8B5
   kR6ECPXnnQwgSK7YRBdY2xOiqYYjF0reOJYVIT9W1Sv56eOD69vktyJlq
   fH1v5ns8L/uMkCR/LZdF96uQuqr6RgYOJ5exlHOAfrrlIkC2Ty7PEOgfj
   DBG0vGetVW4jim/6Wm7baEaIkbYdGqYHjwRUI6+Q23BDa55fmlqA+8h4f
   HGeGV+uDIHSkfgPsdbuD6d6Hs/qTX15Opual/VzxfHg4D5G3rfbNbFRsQ
   Q==;
X-CSE-ConnectionGUID: RzH0H5YRR+uPLie5NZz9dg==
X-CSE-MsgGUID: aVc+rbS9QiS6xFtRCwB8LA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="14409064"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2024 13:52:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:51:50 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 13:51:49 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Horatiu
 Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH] phy: lan966x: Add missing serdes mux entry
Date: Mon, 8 Jan 2024 21:51:40 +0100
Message-ID: <20240108205140.1701770-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to the datasheet(Table 3-2: Port configuration) the serdes 2
(SD2) can be configured to run QSGMII or SGMII mode. Already the QSGMII
mode is supported in the serdes_muxes list  but was missing the SGMII mode.
In this mode the serdes is connected to the port 4.
Therefore add this entry in the list.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/lan966x_serdes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index c1a41b6cd29b1..b5ac2b7995e71 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -96,6 +96,8 @@ static const struct serdes_mux lan966x_serdes_muxes[] = {
 	SERDES_MUX_SGMII(SERDES6G(1), 3, HSIO_HW_CFG_SD6G_1_CFG,
 			 HSIO_HW_CFG_SD6G_1_CFG_SET(1)),
 
+	SERDES_MUX_SGMII(SERDES6G(2), 4, 0, 0),
+
 	SERDES_MUX_RGMII(RGMII(0), 2, HSIO_HW_CFG_RGMII_0_CFG |
 			 HSIO_HW_CFG_RGMII_ENA |
 			 HSIO_HW_CFG_GMII_ENA,
-- 
2.34.1


