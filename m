Return-Path: <linux-kernel+bounces-128016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C871E8954F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83597289763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFA84FA5;
	Tue,  2 Apr 2024 13:13:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C98062A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063633; cv=none; b=kM0mg2V/7QLoqu3tHsGHOXpoLS9RgUQDdihqNfCHh2lrlxIfAnk/fKQ5o9dOzdV9RgYKfbV/Dz5Z/kuHVAw5CRP8fFKUVwoK+aBmW9wlHkEtG3kCt9sb1KaGRQrCXXpr7nZCj+SEg2uVOjeUMEgwiElUiNJdYn7uKMhe53c9/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063633; c=relaxed/simple;
	bh=OCmAc0dU4f5Gke4kKPVWSsKvnUjZorH4TIhLd8GLc5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UA4KuWZESsegIMyk3B63LLRZgTv6xBYUyqnDrYND+RoVnmz+Vck1aq5lydWCbGoQEB25JcwVCRhY9OYjf9XKaVsM9mEYk/nlYq0Z5E2t/zOq8bdDkjNXuFBKG3PM3xittEEWC77cAdj9SIOpXJrOMI7huYKPbbxQNnNWJNr8CPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nh-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW1-ED; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006Oor-1B;
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
Subject: [PATCH net-next v1 1/8] net: dsa: microchip: Remove unused FDB timestamp support in ksz8_r_dyn_mac_table()
Date: Tue,  2 Apr 2024 15:13:32 +0200
Message-Id: <20240402131339.1525330-2-o.rempel@pengutronix.de>
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

The FDB timestamps are not being utilized. This commit removes the
unused timestamp support from ksz8_r_dyn_mac_table() function.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8.h    | 2 +-
 drivers/net/dsa/microchip/ksz8795.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 1a5225264e6a3..5b38cbb7b058b 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -20,7 +20,7 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port);
 int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
-			 u8 *fid, u8 *src_port, u8 *timestamp, u16 *entries);
+			 u8 *fid, u8 *src_port, u16 *entries);
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
 void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		    u64 *dropped, u64 *cnt);
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 14923535ca7e8..f59a03e6981d2 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -409,7 +409,7 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 }
 
 int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
-			 u8 *fid, u8 *src_port, u8 *timestamp, u16 *entries)
+			 u8 *fid, u8 *src_port, u16 *entries)
 {
 	u32 data_hi, data_lo;
 	const u8 *shifts;
@@ -454,8 +454,6 @@ int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 			shifts[DYNAMIC_MAC_FID];
 		*src_port = (data_hi & masks[DYNAMIC_MAC_TABLE_SRC_PORT]) >>
 			shifts[DYNAMIC_MAC_SRC_PORT];
-		*timestamp = (data_hi & masks[DYNAMIC_MAC_TABLE_TIMESTAMP]) >>
-			shifts[DYNAMIC_MAC_TIMESTAMP];
 
 		mac_addr[5] = (u8)data_lo;
 		mac_addr[4] = (u8)(data_lo >> 8);
@@ -1196,14 +1194,13 @@ int ksz8_fdb_dump(struct ksz_device *dev, int port,
 	int ret = 0;
 	u16 i = 0;
 	u16 entries = 0;
-	u8 timestamp = 0;
 	u8 fid;
 	u8 src_port;
 	u8 mac[ETH_ALEN];
 
 	do {
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
-					   &timestamp, &entries);
+					   &entries);
 		if (!ret && port == src_port) {
 			ret = cb(mac, fid, false, data);
 			if (ret)
-- 
2.39.2


