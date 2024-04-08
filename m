Return-Path: <linux-kernel+bounces-134945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9E89B939
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7336E1F21CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766441C9D;
	Mon,  8 Apr 2024 07:48:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837852C695
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562491; cv=none; b=XCf6JlXn1Lk/Xl+ANl7DTYxMJtHO8uqBU3u0PPNeD2u5DRhFEPdnLJdzUhFuBiri70W05QNfz0rmMVuwlrioRcy1Ury7u+zT2bxugncdvyq7ZK29D32QjGLIkuWMVG25iaDzK2XXLxTdeb2Gc6SDDBd7OSHMcta7qqWKyo2Bli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562491; c=relaxed/simple;
	bh=XoMMAwwDp0dn45ZIFO7UEOmt5TX2BzYk82gtFgEpbGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYN2S31J8xmTBDT8yD43AgMh1LYw0uyGl4ulWxw+Z9umD0Vgo/Td1vKXNCUFs+T/USlKRbyYMSF0qjEaslU4PD5MRqXer9k6s+8xqaTNpjwGB/Mj0eNUCOojNeVi4aJxLvxFpYDJlqhL3PxqU2zj7QlQCHkT/fANMKHJdAk+4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rtjjY-0005Ii-4e; Mon, 08 Apr 2024 09:48:04 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rtjjV-00B4Jy-5Q; Mon, 08 Apr 2024 09:48:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rtjjV-007ey6-02;
	Mon, 08 Apr 2024 09:48:01 +0200
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
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v4 7/9] net: dsa: microchip: enable ETS support for KSZ989X variants
Date: Mon,  8 Apr 2024 09:47:56 +0200
Message-Id: <20240408074758.1825674-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408074758.1825674-1-o.rempel@pengutronix.de>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
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

I tested ETS support on KSZ9893, so it should work other KSZ989X
variants too, which was till not listed as support.

With this change we now officially not support only ksz8 family of
chips.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v4:
- simplify ETS support check. At this point only ksz8 family is not
  supported.
---
 drivers/net/dsa/microchip/ksz_common.c | 12 +-----------
 drivers/net/dsa/microchip/ksz_common.h |  1 -
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 840b17b8507e1..a5898b7d7396f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1197,7 +1197,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1344,7 +1343,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1470,7 +1468,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1499,7 +1496,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1533,7 +1529,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1566,7 +1561,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1594,7 +1588,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1622,7 +1615,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1654,7 +1646,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1686,7 +1677,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -3638,7 +3628,7 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	if (!dev->info->tc_ets_supported)
+	if (is_ksz8(dev))
 		return -EOPNOTSUPP;
 
 	if (qopt->parent != TC_H_ROOT) {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbbaafca79379..0450606bab2b8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -60,7 +60,6 @@ struct ksz_chip_data {
 	u8 num_tx_queues;
 	u8 num_ipvs; /* number of Internal Priority Values */
 	bool tc_cbs_supported;
-	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
 	bool ksz87xx_eee_link_erratum;
 	const struct ksz_mib_names *mib_names;
-- 
2.39.2


