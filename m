Return-Path: <linux-kernel+bounces-129738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73C896F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE21C2617F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723B147C79;
	Wed,  3 Apr 2024 12:50:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E2146A8E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148652; cv=none; b=ovCCQBGfhHgSapDNkivfYWDzDlTN0dIbw/IOXTU6bnZQHbTs3Ya0ZJpDEEdNSs8h2W7PhOWjGc8EzisqLlpJWg6jjMzxRp59koxYKUwp5mkRsMeq9cHlbr+7omTHKc+jtDyxEKG8kMxlZHSU9JNAO8fWHjdtZ3z4vlyd2sFmf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148652; c=relaxed/simple;
	bh=0SZNouPVLZrN/7eL7wDqp85qwlZCQuk7fS9ESBpSgzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HixMIcDgGrloYuUo7OgDE9wAQope8OEZ87AGFik9feuGZ7pmKPx4Gd7tkm3ZAxOnj83eCbfimdxgr0LyzCVay4Gq7dYboVj/+yVHFD3ODjbfzyhx9Ea+Mx/Rqc1B3+uDOyWTjcXPsxaG5LpsXAonHr39Oj37GYA0r/L2WyQZg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005yS-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEi-Ay; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00EKZS-0U;
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
Subject: [PATCH net-next v2 6/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
Date: Wed,  3 Apr 2024 14:50:37 +0200
Message-Id: <20240403125039.3414824-7-o.rempel@pengutronix.de>
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

EAGAIN was not used by previous code and not used by  current code. So,
remove it and use proper error value.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 5765d23bc6edc..eeb32df0939d1 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -396,7 +396,7 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 
 	/* Entry is not ready for accessing. */
 	if (*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) {
-		return -EAGAIN;
+		return -ETIMEDOUT;
 	/* Entry is ready for accessing. */
 	} else {
 		ksz_read8(dev, regs[REG_IND_DATA_8], data);
@@ -431,15 +431,14 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 
 	ret = ksz8_valid_dyn_entry(dev, &data);
-	if (ret == -EAGAIN) {
-		if (addr == 0)
-			*entries = 0;
-		goto unlock_alu;
-	} else if (ret == -ENXIO) {
+	if (ret == -ENXIO) {
 		*entries = 0;
 		goto unlock_alu;
 	}
 
+	if (ret)
+		goto unlock_alu;
+
 	ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
 	data_hi = (u32)(buf >> 32);
 	data_lo = (u32)buf;
-- 
2.39.2


