Return-Path: <linux-kernel+bounces-96870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD587626E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75209B2120C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE185579F;
	Fri,  8 Mar 2024 10:50:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55954BD5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895035; cv=none; b=E/cXPyFyk1BmgHbPzaF/qYLjxSVjncPkzK+z21NAwxFRhJe8MI2p9fb4e+bXXL9sEEIHAgjkjDq+EMYseNCIb7LjmK53eFLZwah9VWDkzOYXEqg1LWIbunHE/GNp1YAI4qEvsPYz9kgTfYqC6/i2+02u248Rc309ICh7FxjbuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895035; c=relaxed/simple;
	bh=GIWMlaYR05jwrmjmwXUaBfAlmloZULLT6JrTrW07M4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEWyAaVKLA3AHRWcXKRsWLN3C2+0k1tcf44tb+856OATMMSTOC9RI6xozBKQSi3llx+vwZsfyvzBmEeBCA/bdJzdG8n5pU36vsHU7Sv3B9zq/Rl71FgT4ZIjPakT4t86q86dAVyZsDaWPCF9KIlHilGWqqljYI5sudcxpgIIBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1riXo1-0002Bb-5q; Fri, 08 Mar 2024 11:50:25 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1riXo0-0057PD-2k; Fri, 08 Mar 2024 11:50:24 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1riXo0-00Ai9M-03;
	Fri, 08 Mar 2024 11:50:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: add regmap_range for KSZ9563 chip
Date: Fri,  8 Mar 2024 11:50:21 +0100
Message-Id: <20240308105021.2552975-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add register validation for KSZ9563.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 121 +++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 030b167764b39..2308be3bdc9d8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -666,6 +666,125 @@ static const struct regmap_access_table ksz8563_register_set = {
 	.n_yes_ranges = ARRAY_SIZE(ksz8563_valid_regs),
 };
 
+static const struct regmap_range ksz9563_valid_regs[] = {
+	regmap_reg_range(0x0000, 0x0003),
+	regmap_reg_range(0x0006, 0x0006),
+	regmap_reg_range(0x000f, 0x000f),
+	regmap_reg_range(0x0010, 0x001f),
+	regmap_reg_range(0x0100, 0x0100),
+	regmap_reg_range(0x0104, 0x0107),
+	regmap_reg_range(0x010d, 0x010d),
+	regmap_reg_range(0x0110, 0x0113),
+	regmap_reg_range(0x0120, 0x012b),
+	regmap_reg_range(0x0201, 0x0201),
+	regmap_reg_range(0x0210, 0x0213),
+	regmap_reg_range(0x0300, 0x0300),
+	regmap_reg_range(0x0302, 0x030b),
+	regmap_reg_range(0x030e, 0x031b),
+	regmap_reg_range(0x0320, 0x032b),
+	regmap_reg_range(0x0330, 0x0336),
+	regmap_reg_range(0x0338, 0x033b),
+	regmap_reg_range(0x033e, 0x033e),
+	regmap_reg_range(0x0340, 0x035f),
+	regmap_reg_range(0x0370, 0x0370),
+	regmap_reg_range(0x0378, 0x0378),
+	regmap_reg_range(0x037c, 0x037d),
+	regmap_reg_range(0x0390, 0x0393),
+	regmap_reg_range(0x0400, 0x040e),
+	regmap_reg_range(0x0410, 0x042f),
+	regmap_reg_range(0x0500, 0x0519),
+	regmap_reg_range(0x0520, 0x054b),
+	regmap_reg_range(0x0550, 0x05b3),
+
+	/* port 1 */
+	regmap_reg_range(0x1000, 0x1001),
+	regmap_reg_range(0x1004, 0x100b),
+	regmap_reg_range(0x1013, 0x1013),
+	regmap_reg_range(0x1017, 0x1017),
+	regmap_reg_range(0x101b, 0x101b),
+	regmap_reg_range(0x101f, 0x1021),
+	regmap_reg_range(0x1030, 0x1030),
+	regmap_reg_range(0x1100, 0x1115),
+	regmap_reg_range(0x111a, 0x111f),
+	regmap_reg_range(0x1120, 0x112b),
+	regmap_reg_range(0x1134, 0x113b),
+	regmap_reg_range(0x113c, 0x113f),
+	regmap_reg_range(0x1400, 0x1401),
+	regmap_reg_range(0x1403, 0x1403),
+	regmap_reg_range(0x1410, 0x1417),
+	regmap_reg_range(0x1420, 0x1423),
+	regmap_reg_range(0x1500, 0x1507),
+	regmap_reg_range(0x1600, 0x1612),
+	regmap_reg_range(0x1800, 0x180f),
+	regmap_reg_range(0x1900, 0x1907),
+	regmap_reg_range(0x1914, 0x191b),
+	regmap_reg_range(0x1a00, 0x1a03),
+	regmap_reg_range(0x1a04, 0x1a07),
+	regmap_reg_range(0x1b00, 0x1b01),
+	regmap_reg_range(0x1b04, 0x1b04),
+	regmap_reg_range(0x1c00, 0x1c05),
+	regmap_reg_range(0x1c08, 0x1c1b),
+
+	/* port 2 */
+	regmap_reg_range(0x2000, 0x2001),
+	regmap_reg_range(0x2004, 0x200b),
+	regmap_reg_range(0x2013, 0x2013),
+	regmap_reg_range(0x2017, 0x2017),
+	regmap_reg_range(0x201b, 0x201b),
+	regmap_reg_range(0x201f, 0x2021),
+	regmap_reg_range(0x2030, 0x2030),
+	regmap_reg_range(0x2100, 0x2115),
+	regmap_reg_range(0x211a, 0x211f),
+	regmap_reg_range(0x2120, 0x212b),
+	regmap_reg_range(0x2134, 0x213b),
+	regmap_reg_range(0x213c, 0x213f),
+	regmap_reg_range(0x2400, 0x2401),
+	regmap_reg_range(0x2403, 0x2403),
+	regmap_reg_range(0x2410, 0x2417),
+	regmap_reg_range(0x2420, 0x2423),
+	regmap_reg_range(0x2500, 0x2507),
+	regmap_reg_range(0x2600, 0x2612),
+	regmap_reg_range(0x2800, 0x280f),
+	regmap_reg_range(0x2900, 0x2907),
+	regmap_reg_range(0x2914, 0x291b),
+	regmap_reg_range(0x2a00, 0x2a03),
+	regmap_reg_range(0x2a04, 0x2a07),
+	regmap_reg_range(0x2b00, 0x2b01),
+	regmap_reg_range(0x2b04, 0x2b04),
+	regmap_reg_range(0x2c00, 0x2c05),
+	regmap_reg_range(0x2c08, 0x2c1b),
+
+	/* port 3 */
+	regmap_reg_range(0x3000, 0x3001),
+	regmap_reg_range(0x3013, 0x3013),
+	regmap_reg_range(0x3017, 0x3017),
+	regmap_reg_range(0x301b, 0x301b),
+	regmap_reg_range(0x301f, 0x3020),
+	regmap_reg_range(0x3030, 0x3030),
+	regmap_reg_range(0x3300, 0x3301),
+	regmap_reg_range(0x3303, 0x3303),
+	regmap_reg_range(0x3400, 0x3401),
+	regmap_reg_range(0x3403, 0x3403),
+	regmap_reg_range(0x3410, 0x3417),
+	regmap_reg_range(0x3420, 0x3423),
+	regmap_reg_range(0x3500, 0x3507),
+	regmap_reg_range(0x3600, 0x3612),
+	regmap_reg_range(0x3800, 0x380f),
+	regmap_reg_range(0x3900, 0x3907),
+	regmap_reg_range(0x3914, 0x391b),
+	regmap_reg_range(0x3a00, 0x3a03),
+	regmap_reg_range(0x3a04, 0x3a07),
+	regmap_reg_range(0x3b00, 0x3b01),
+	regmap_reg_range(0x3b04, 0x3b04),
+	regmap_reg_range(0x3c00, 0x3c05),
+	regmap_reg_range(0x3c08, 0x3c1b),
+};
+
+static const struct regmap_access_table ksz9563_register_set = {
+	.yes_ranges = ksz9563_valid_regs,
+	.n_yes_ranges = ARRAY_SIZE(ksz9563_valid_regs),
+};
+
 static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x0000, 0x0003),
 	regmap_reg_range(0x0006, 0x0006),
@@ -1475,6 +1594,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, true},
 		.internal_phy = {true, true, false},
 		.gbit_capable = {true, true, true},
+		.wr_table = &ksz9563_register_set,
+		.rd_table = &ksz9563_register_set,
 	},
 
 	[KSZ8567] = {
-- 
2.39.2


