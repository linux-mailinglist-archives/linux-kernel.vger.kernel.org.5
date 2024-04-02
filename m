Return-Path: <linux-kernel+bounces-128020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA2895500
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5274328AF07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A9131758;
	Tue,  2 Apr 2024 13:13:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D383CB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063635; cv=none; b=cy8SDvmVARpXSN6NlCyuEE0L8JYoco3Og4+hBebB5FU4SAnvJTjT0zI080XWZdnOe4a8S/oUS9bozjfNmkjtKAliuxooV9a967DK+YCEEAPvKb9kMR4SUP9FJso6Wek5aBadfOLE2YxTs/xcdYY6OOoXhKl78JSPREDUG2aBq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063635; c=relaxed/simple;
	bh=UsatnV/EHjv/xbeltr+10uYRbmZdlwrwWcR2idpTWts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4G1v5hffM3iZJDMds2sbI9d0g2Tw3wVpeji+DwEtiRtDavq+5uVOeURr8ibYd/KvdYkG1BJsVf5KnmsfwBBPGkhUdRPH8my65M1OhxXKORyd3I6xg1JbLVEaHemzpzrwTq6FgfMwZk342ZyvRdQOwityiqESumwi0G6ulWcOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nn-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zWC-JI; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006Oq4-1c;
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
Subject: [PATCH net-next v1 8/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
Date: Tue,  2 Apr 2024 15:13:39 +0200
Message-Id: <20240402131339.1525330-9-o.rempel@pengutronix.de>
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

We already have a variable to provide number of entries. So use it,
instead of using error number.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 27dfcc645567d..813c701b71180 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -399,19 +399,11 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 	} while ((*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) && timeout);
 
 	/* Entry is not ready for accessing. */
-	if (*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) {
+	if (*data & masks[DYNAMIC_MAC_TABLE_NOT_READY])
 		return -ETIMEDOUT;
-	/* Entry is ready for accessing. */
-	} else {
-		ret = ksz_read8(dev, regs[REG_IND_DATA_8], data);
-		if (ret)
-			return ret;
 
-		/* There is no valid entry in the table. */
-		if (*data & masks[DYNAMIC_MAC_TABLE_MAC_EMPTY])
-			return -ENXIO;
-	}
-	return 0;
+	/* Entry is ready for accessing. */
+	return ksz_read8(dev, regs[REG_IND_DATA_8], data);
 }
 
 static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
@@ -439,13 +431,13 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 		goto unlock_alu;
 
 	ret = ksz8_valid_dyn_entry(dev, &data);
-	if (ret == -ENXIO) {
-		*entries = 0;
+	if (ret)
 		goto unlock_alu;
-	}
 
-	if (ret)
+	if (data & masks[DYNAMIC_MAC_TABLE_MAC_EMPTY]) {
+		*entries = 0;
 		goto unlock_alu;
+	}
 
 	ret = ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
 	if (ret)
@@ -1212,8 +1204,6 @@ int ksz8_fdb_dump(struct ksz_device *dev, int port,
 
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
 					   &entries);
-		if (ret == -ENXIO)
-			return 0;
 		if (ret)
 			return ret;
 
-- 
2.39.2


