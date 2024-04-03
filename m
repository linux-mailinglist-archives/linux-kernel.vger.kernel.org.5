Return-Path: <linux-kernel+bounces-129745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814D896F63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D8D1F2881B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09E149C48;
	Wed,  3 Apr 2024 12:50:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391B146A99
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148655; cv=none; b=Aq6XwIgixqkS/vrhF49Phzx8p7tCofqQVA5Gmttr1uMicY1fXnOV5OOxJS8+xEuT3bJnMT9aW0B1o2G64BCd/QRJcLAw6quTv64ofcB7ZN14fs2i9XWY2WnfSrcfhHf3E+4gvaNKWxNSyaTz8k7QkpHevbhuBciZmCM/mS/Gjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148655; c=relaxed/simple;
	bh=nMx4gjGN1qXXT7qNACadIA0e3XqnSWgfBQC/sksnoHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DE9q6gDX0Zd74FMeLdqunjtC85ftMrgkYJLdV+uLiil3rgDlegE+qssAazTqxVYEnCSD1Ei4dnNWua4L7Ar52zF/pJKPT5q/3V7yor8yhx6X6WgIDxAmDGiHkrTS/+oX55UgErtA+eXrHye7/lMxsQjzGNgQIefBkimCauhrk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005uZ-0a; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00ABEU-Th; Wed, 03 Apr 2024 14:50:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00EKWZ-2R;
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
Subject: [PATCH net-next v2 2/8] net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
Date: Wed,  3 Apr 2024 14:50:33 +0200
Message-Id: <20240403125039.3414824-3-o.rempel@pengutronix.de>
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

ksz8_r_dyn_mac_table() is not used outside the source file. Make it
static.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8.h    | 2 --
 drivers/net/dsa/microchip/ksz8795.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 5b38cbb7b058b..571c26ce71e47 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -19,8 +19,6 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port);
 void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port);
 int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
-int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
-			 u8 *fid, u8 *src_port, u16 *entries);
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
 void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		    u64 *dropped, u64 *cnt);
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index f59a03e6981d2..e407111db6637 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -408,8 +408,8 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 	return 0;
 }
 
-int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
-			 u8 *fid, u8 *src_port, u16 *entries)
+static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
+				u8 *fid, u8 *src_port, u16 *entries)
 {
 	u32 data_hi, data_lo;
 	const u8 *shifts;
-- 
2.39.2


