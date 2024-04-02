Return-Path: <linux-kernel+bounces-128014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426A8954F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CF01C22852
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33584A4B;
	Tue,  2 Apr 2024 13:13:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11381721
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063633; cv=none; b=hRrWNm6zZgi0S02eG1Ce/THzB6rOEFzSLnLuO7JkrkZ2ng0p6ynteuprag3cxeEmK7t5lGXp7+K5HAwxzQlsuMxMe3JpUSLMtKQZZafnt18SM+7UJZ1Lga799l/lbtQZ71QyVa8rhKC5KwvT+o4ebuMQoTIOKYKVn8Y2LJ6SLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063633; c=relaxed/simple;
	bh=i1PFc7lD0popc40JSZRnhqej4YBxofX5vZ/4vsj7PXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeV5JLtV9MxeFw/ZR/KLOKwtaZb0guPxwiGlciMVHj7yR+N7z0PyfdKGXi/KgFK1zzGYEyeTResVN5zeARqiNYemLDi2UWInbWlcX6uSy2cbM+ENA5+6DWW8rupIzY6TuTbRnfCcUX+JgOrtn7s5W0tYnUvC0nJvc0DmpGYHFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nm-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW9-Ie; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006Opi-1V;
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
Subject: [PATCH net-next v1 6/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
Date: Tue,  2 Apr 2024 15:13:37 +0200
Message-Id: <20240402131339.1525330-7-o.rempel@pengutronix.de>
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

EAGAIN was not used by previous code and not used by  current code. So,
remove it and use proper error value.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d5ec4b9772752..401f77055cc27 100644
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


