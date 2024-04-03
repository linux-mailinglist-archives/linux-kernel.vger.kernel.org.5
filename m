Return-Path: <linux-kernel+bounces-129744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE0896F64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84741C26761
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3C149C47;
	Wed,  3 Apr 2024 12:50:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55D146A78
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148655; cv=none; b=WQq48lVwE1n0RLjis8b++HlUlhQzIWjJ7l84wMRGCU/F/moRWqnCO2zNLdrjjwl80BWW+Da5vwPEPhoNT99ONZnLW8mRdvSsbRWvZEQnJ9dFYje06inzU/1RL0c8BIIUyt/EP2NeEuls/Qm/IsBImO6gVkZPK1jTAujaI2bK+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148655; c=relaxed/simple;
	bh=Bcc7wC539i7cfCgpBSkB4ImTrUNgqBAy5MoTxbGa6hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5e6RqrOtjf/X+x6X3fryrXuG1ttUFI9CKZ9NR86NsJ4kl1AEjmHFyO5mXJcaDnvlC2OASYJjVKBI0pbIGJbWIJErKrDuv9SjqVaIhcl92OKee9os7UjvKwQ8hN/GWCfqanHyAedqBxo/LigAV2BvyaYYwuUToEPPMirhH2P5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005yV-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEm-Fz; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00EKbB-1F;
	Wed, 03 Apr 2024 14:50:41 +0200
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
Subject: [PATCH net-next v2 8/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
Date: Wed,  3 Apr 2024 14:50:39 +0200
Message-Id: <20240403125039.3414824-9-o.rempel@pengutronix.de>
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

We already have a variable to provide number of entries. So use it,
instead of using error number.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index de3d8357da855..ecef6f6f830b3 100644
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
@@ -1210,8 +1202,6 @@ int ksz8_fdb_dump(struct ksz_device *dev, int port,
 	for (i = 0; i < KSZ8_DYN_MAC_ENTRIES; i++) {
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
 					   &entries);
-		if (ret == -ENXIO)
-			return 0;
 		if (ret)
 			return ret;
 
-- 
2.39.2


