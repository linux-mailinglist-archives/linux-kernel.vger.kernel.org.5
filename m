Return-Path: <linux-kernel+bounces-129742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05F896F62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A646D28D45B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88C1494DE;
	Wed,  3 Apr 2024 12:50:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53891146A92
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148653; cv=none; b=X6zJW8sadPkoyCOU8YSWUKZgoCiXn3CEtbDayFqAyK1m9e1kPQAExnf2hpPNpyQHOjXkLGSRI6+Vwf/HRI9BholQ3tE/bBXGRPW0ncECGOfkUSeg496F0iF0w6AaNR5d/6APevzCeHhtaRzdifLOdWMm3IeVXRjyvn/doLWiHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148653; c=relaxed/simple;
	bh=o5G4LuYk6sEvisbWMiODRuymYHEM3nRIHoBwcx+FraY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpZCaUpesmPmmGpZhZdN0Zt1L/4nKJic+bYxkfXqFY1tHzAT4URGyQne8BIp/73SvWed7sQQezxAh5eywUBrgtb2h/1oZ7XG6KBnwawSEvaPVp62L23nPZ4rfSPSadEX0W0C4l0cXQNOi7vkLZUSQpb3fAm1ExjJqS85/LKcmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005wj-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEa-3T; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00EKY2-36;
	Wed, 03 Apr 2024 14:50:40 +0200
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
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v2 4/8] net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for readability
Date: Wed,  3 Apr 2024 14:50:35 +0200
Message-Id: <20240403125039.3414824-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403125039.3414824-1-o.rempel@pengutronix.de>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
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

Move the code out of a long if statement scope in ksz8_r_dyn_mac_table()
to improve code readability.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 60 +++++++++++++++--------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index c93eb351ab3d5..d258fb607b4af 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -416,7 +416,9 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	const u32 *masks;
 	const u16 *regs;
 	u16 ctrl_addr;
+	u64 buf = 0;
 	u8 data;
+	int cnt;
 	int rc;
 
 	shifts = dev->info->shifts;
@@ -432,38 +434,38 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	if (rc == -EAGAIN) {
 		if (addr == 0)
 			*entries = 0;
+		goto unlock_alu;
 	} else if (rc == -ENXIO) {
 		*entries = 0;
-	/* At least one valid entry in the table. */
-	} else {
-		u64 buf = 0;
-		int cnt;
-
-		ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
-		data_hi = (u32)(buf >> 32);
-		data_lo = (u32)buf;
-
-		/* Check out how many valid entry in the table. */
-		cnt = data & masks[DYNAMIC_MAC_TABLE_ENTRIES_H];
-		cnt <<= shifts[DYNAMIC_MAC_ENTRIES_H];
-		cnt |= (data_hi & masks[DYNAMIC_MAC_TABLE_ENTRIES]) >>
-			shifts[DYNAMIC_MAC_ENTRIES];
-		*entries = cnt + 1;
-
-		*fid = (data_hi & masks[DYNAMIC_MAC_TABLE_FID]) >>
-			shifts[DYNAMIC_MAC_FID];
-		*src_port = (data_hi & masks[DYNAMIC_MAC_TABLE_SRC_PORT]) >>
-			shifts[DYNAMIC_MAC_SRC_PORT];
-
-		mac_addr[5] = (u8)data_lo;
-		mac_addr[4] = (u8)(data_lo >> 8);
-		mac_addr[3] = (u8)(data_lo >> 16);
-		mac_addr[2] = (u8)(data_lo >> 24);
-
-		mac_addr[1] = (u8)data_hi;
-		mac_addr[0] = (u8)(data_hi >> 8);
-		rc = 0;
+		goto unlock_alu;
 	}
+
+	ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
+	data_hi = (u32)(buf >> 32);
+	data_lo = (u32)buf;
+
+	/* Check out how many valid entry in the table. */
+	cnt = data & masks[DYNAMIC_MAC_TABLE_ENTRIES_H];
+	cnt <<= shifts[DYNAMIC_MAC_ENTRIES_H];
+	cnt |= (data_hi & masks[DYNAMIC_MAC_TABLE_ENTRIES]) >>
+		shifts[DYNAMIC_MAC_ENTRIES];
+	*entries = cnt + 1;
+
+	*fid = (data_hi & masks[DYNAMIC_MAC_TABLE_FID]) >>
+		shifts[DYNAMIC_MAC_FID];
+	*src_port = (data_hi & masks[DYNAMIC_MAC_TABLE_SRC_PORT]) >>
+		shifts[DYNAMIC_MAC_SRC_PORT];
+
+	mac_addr[5] = (u8)data_lo;
+	mac_addr[4] = (u8)(data_lo >> 8);
+	mac_addr[3] = (u8)(data_lo >> 16);
+	mac_addr[2] = (u8)(data_lo >> 24);
+
+	mac_addr[1] = (u8)data_hi;
+	mac_addr[0] = (u8)(data_hi >> 8);
+	rc = 0;
+
+unlock_alu:
 	mutex_unlock(&dev->alu_mutex);
 
 	return rc;
-- 
2.39.2


