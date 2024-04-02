Return-Path: <linux-kernel+bounces-128018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87E8954FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF08B1C22B66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0DD12CD8B;
	Tue,  2 Apr 2024 13:13:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97582898
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063634; cv=none; b=q5D/O6ozZMrrDvIN50oXTq/+qaBILbgiqmeRtz1YTOrLVlVy+ijFBSUwvkrOEXtsaCCcUhQYkhgHAzJEVmNlr2meF0IDpwxzkJDOQQH2nDrsf3Suzvi+o2RvDTXe/xRsRUQOA84dlluHhFGUd9F5bOXm5pMFTLZ3J6cShsCFVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063634; c=relaxed/simple;
	bh=L1PTgioQ9UTXOR1GMlJUXHK63uWuG9gFutlyR0MyD9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChzJwpj9dL0TqFtYe/5AzPzbSu3sFShD9moFJOMj7KB9nxHA3nT7O2Ag8tC2dMSs8581dWP6v4YEWz537FHq+BEDWzvcNZnx9s5is9IPR6/DbdytgnMaxSAhV8BVi7k3IjPHwe5Of1Q/Z+iiAPF0pdgpYaiJ3bWN15rcBZQuiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nl-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW6-Gp; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006OpX-1R;
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
Subject: [PATCH net-next v1 5/8] net: dsa: microchip: ksz8: Unify variable naming in ksz8_r_dyn_mac_table()
Date: Tue,  2 Apr 2024 15:13:36 +0200
Message-Id: <20240402131339.1525330-6-o.rempel@pengutronix.de>
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

Use 'ret' instead of 'rc' in ksz8_r_dyn_mac_table() to maintain
consistency with the rest of the file.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 1962195e16a6f..d5ec4b9772752 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -419,7 +419,7 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	u64 buf = 0;
 	u8 data;
 	int cnt;
-	int rc;
+	int ret;
 
 	shifts = dev->info->shifts;
 	masks = dev->info->masks;
@@ -430,12 +430,12 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	mutex_lock(&dev->alu_mutex);
 	ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 
-	rc = ksz8_valid_dyn_entry(dev, &data);
-	if (rc == -EAGAIN) {
+	ret = ksz8_valid_dyn_entry(dev, &data);
+	if (ret == -EAGAIN) {
 		if (addr == 0)
 			*entries = 0;
 		goto unlock_alu;
-	} else if (rc == -ENXIO) {
+	} else if (ret == -ENXIO) {
 		*entries = 0;
 		goto unlock_alu;
 	}
@@ -463,12 +463,12 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 
 	mac_addr[1] = (u8)data_hi;
 	mac_addr[0] = (u8)(data_hi >> 8);
-	rc = 0;
+	ret = 0;
 
 unlock_alu:
 	mutex_unlock(&dev->alu_mutex);
 
-	return rc;
+	return ret;
 }
 
 static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-- 
2.39.2


