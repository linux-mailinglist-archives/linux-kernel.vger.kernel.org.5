Return-Path: <linux-kernel+bounces-128019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA978954FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56267B20E03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32F131183;
	Tue,  2 Apr 2024 13:13:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DE83CAA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063635; cv=none; b=P0G/XmijSr8SgHD/lKFqgBQGuhL3TewcqJTrB8Zg60H2iTu3BhsFoN/L0ugEz8r1Tv19Ds0TOfqu9JJKibce+ilDf79cRT7voSeAWPnVtYD6kfuHdYulsuOM3zc1FPXvcTr0wkV8olZpOFjP/PWRviB9SxogrLuEw8+7eIGzPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063635; c=relaxed/simple;
	bh=t9QA8oYRz9Ov2cksud/TPgbQ22aTRdp92YkIsm9j238=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2q7t8uKoTJR0y0uDWIIpR3U0i3Zw3nXo7mnWSkzTbUgkj+LCb1RTsSu2VVvFyABAqMyFMT+Uj03VLbNVsPLqbRJ+NTkxRidbI3Swt13wv7hskpuOvb4AiBz12XkiAmBp1t9foipEt8zUmOeyHC8oDCpR4U90zWLS3zc71afrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nk-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW5-Gq; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006OpN-1O;
	Tue, 02 Apr 2024 15:13:40 +0200
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
Subject: [PATCH net-next v1 4/8] net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for readability
Date: Tue,  2 Apr 2024 15:13:35 +0200
Message-Id: <20240402131339.1525330-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402131339.1525330-1-o.rempel@pengutronix.de>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 60 +++++++++++++++--------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index b70aa2c0a85ec..1962195e16a6f 100644
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


