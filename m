Return-Path: <linux-kernel+bounces-129740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AA896F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC401F2870A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB8146D71;
	Wed,  3 Apr 2024 12:50:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69624146D4A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148653; cv=none; b=gCZ/r45IC9OtahvUjmZPOeQpmaRQnQuNGaGgOcXyZKE1DWGSXjcIiW772aaJcM3jBqetFSA5cVjJQO8lcl9G12i2DwH4rfgOo+ILj9IvGBSRIH7Dre8P/fSX5fIdNP348/Ap6j9zgsMC4bWIzJamai9dMejeBr/98JST64iOeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148653; c=relaxed/simple;
	bh=f1wmLifa3arJQ/tA8IkHxFJBOXYe1/TIZAQD6djffYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eq9cvfWtDwrTvYUlNz+v54uKD785tPAHVQiplVspKH0tqLnjpFTIvoeNEcpVeeI1rYYNZAd50TlJpwKRprFgyAqa7QXIIUYWGtHo5XgYDsYL3omQDErQeS6K7BCtBeURGm85CU0MzhcVg5cGIUMQ+JfGAESa9kcUCtYiCUSYEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005w0-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEZ-1R; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00EKXN-2l;
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
Subject: [PATCH net-next v2 3/8] net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
Date: Wed,  3 Apr 2024 14:50:34 +0200
Message-Id: <20240403125039.3414824-4-o.rempel@pengutronix.de>
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

Refactor ksz8_fdb_dump() to address potential issues:
- Limit the number of iterations to avoid endless loops.
- Handle error codes returned by ksz8_r_dyn_mac_table(), with
  an exception for -ENXIO when no more dynamic entries are detected.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- move variable declaration out of "for" scope
- rework "if (port != src_port); continue" to to "if (port == src_port);
  code"
---
 drivers/net/dsa/microchip/ksz8795.c     | 29 ++++++++++++++-----------
 drivers/net/dsa/microchip/ksz8795_reg.h |  1 +
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index e407111db6637..c93eb351ab3d5 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1191,27 +1191,30 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 int ksz8_fdb_dump(struct ksz_device *dev, int port,
 		  dsa_fdb_dump_cb_t *cb, void *data)
 {
-	int ret = 0;
-	u16 i = 0;
-	u16 entries = 0;
-	u8 fid;
-	u8 src_port;
 	u8 mac[ETH_ALEN];
+	u8 src_port, fid;
+	u16 entries = 0;
+	int ret, i;
 
-	do {
+	for (i = 0; i < KSZ8_DYN_MAC_ENTRIES; i++) {
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
 					   &entries);
-		if (!ret && port == src_port) {
+		if (ret == -ENXIO)
+			return 0;
+		if (ret)
+			return ret;
+
+		if (i >= entries)
+			return 0;
+
+		if (port == src_port) {
 			ret = cb(mac, fid, false, data);
 			if (ret)
-				break;
+				return ret;
 		}
-		i++;
-	} while (i < entries);
-	if (i >= entries)
-		ret = 0;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int ksz8_add_sta_mac(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 7c9341ef73b03..0d13a6e29b0e6 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -794,5 +794,6 @@
 #define TAIL_TAG_LOOKUP			BIT(7)
 
 #define FID_ENTRIES			128
+#define KSZ8_DYN_MAC_ENTRIES		1024
 
 #endif
-- 
2.39.2


