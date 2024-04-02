Return-Path: <linux-kernel+bounces-128015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3D8954F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F18628A12E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D384A48;
	Tue,  2 Apr 2024 13:13:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0781AB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063633; cv=none; b=YqsKEuhgiZxkoxTd2SUvwE8j8E/g77LKPonA44DOKsUnHj4meUb55iFe3F1Wyz3IMtGuKVT6XxYUwiAsg9nQOosZL3qAZRBic74Jsbhg55wq2cN97FDHFYpq+23WO9nUL/prZORA1FtHTFN0dCOOsr5+0o7g3e6BQutGiQ5QkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063633; c=relaxed/simple;
	bh=WcAXyZWabFzfkbREXpcfyvV+HcqY4LyLj6RdoVS4bSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNPN7l9z+wKK6cKrbl/gmZJaObRdLTsO1FgYACIAWoXKeBZT4rG/ppt0YMhbMHec/JXfMx8H+g/C4Ixx+ssef3x7KkB73BsKlWw/MCZpj+Bik3NoHhEc5o/UIWSdDvNekJIcgQG4ts1fH6jcqN8JiNclXe5A3CbPBk/gPPM8vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nj-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW3-GD; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006OpB-1K;
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
Subject: [PATCH net-next v1 3/8] net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
Date: Tue,  2 Apr 2024 15:13:34 +0200
Message-Id: <20240402131339.1525330-4-o.rempel@pengutronix.de>
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

Refactor ksz8_fdb_dump() to address potential issues:
- Limit the number of iterations to avoid endless loops.
- Handle error codes returned by ksz8_r_dyn_mac_table(), with
  an exception for -ENXIO when no more dynamic entries are detected.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 38 ++++++++++++++-----------
 drivers/net/dsa/microchip/ksz8795_reg.h |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index e407111db6637..b70aa2c0a85ec 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1191,27 +1191,33 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 int ksz8_fdb_dump(struct ksz_device *dev, int port,
 		  dsa_fdb_dump_cb_t *cb, void *data)
 {
-	int ret = 0;
-	u16 i = 0;
 	u16 entries = 0;
-	u8 fid;
-	u8 src_port;
-	u8 mac[ETH_ALEN];
+	int ret, i;
+
+	for (i = 0; i < KSZ8_DYN_MAC_ENTRIES; i++) {
+		u8 mac[ETH_ALEN];
+		u8 src_port;
+		u8 fid;
 
-	do {
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
 					   &entries);
-		if (!ret && port == src_port) {
-			ret = cb(mac, fid, false, data);
-			if (ret)
-				break;
-		}
-		i++;
-	} while (i < entries);
-	if (i >= entries)
-		ret = 0;
+		if (ret == -ENXIO)
+			return 0;
+		if (ret)
+			return ret;
 
-	return ret;
+		if (i >= entries)
+			return 0;
+
+		if (port != src_port)
+			continue;
+
+		ret = cb(mac, fid, false, data);
+		if (ret)
+			return ret;
+	}
+
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


