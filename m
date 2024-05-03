Return-Path: <linux-kernel+bounces-167680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C88BAD63
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9631C2171A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514B1553B8;
	Fri,  3 May 2024 13:14:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1B154426
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742053; cv=none; b=UtgXLLsRsL7NW9adlAauw3pwC2776140n4IvGLOuULpK34okDT/WM3HcqyiCUgbvQtu8gka80mzxxHXIIDTlondC3uFydF9C5nY1ZCxggGuXPVyzkI7sAlY4s1Iu+D0Vpb9hAoJjyMCsHOem/kLtGTFGAOwn2HmaFJe9SXt94KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742053; c=relaxed/simple;
	bh=5M+mi+5Ye4seAhS01+thjM8vxp9cwZVRplq4GOHkGt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0NG623HZYitZHLMroHtMJWv3ZP49nUTzevNwzaNYkqnfdZXfQPULicLUjMVw1FzLX0RohKfknUAN7SF9bGe4HMMij4sfsqLMAqMTTKQcAOwJkn78HooBBqDumVO3BDVodamQCQ86XTFiaXYKdUx7s93iXeZ1f2NvUk7dzf8I84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjf-0006EO-GI; Fri, 03 May 2024 15:13:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiKH-TD; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GHT-2H;
	Fri, 03 May 2024 15:13:53 +0200
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
Subject: [PATCH net-next v7 07/12] net: dsa: microchip: enable ETS support for KSZ989X variants
Date: Fri,  3 May 2024 15:13:46 +0200
Message-Id: <20240503131351.1969097-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503131351.1969097-1-o.rempel@pengutronix.de>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
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
index 5f02559a18bf5..6bf7e81c2f3ac 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1228,7 +1228,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1380,7 +1379,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1510,7 +1508,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1540,7 +1537,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1575,7 +1571,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1608,7 +1603,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1637,7 +1631,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1666,7 +1659,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1699,7 +1691,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1732,7 +1723,6 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipvs = 8,
 		.tc_cbs_supported = true,
-		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -3681,7 +3671,7 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	if (!dev->info->tc_ets_supported)
+	if (is_ksz8(dev))
 		return -EOPNOTSUPP;
 
 	if (qopt->parent != TC_H_ROOT) {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 42f445aef9c90..baf236792e107 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -64,7 +64,6 @@ struct ksz_chip_data {
 	u8 num_tx_queues;
 	u8 num_ipvs; /* number of Internal Priority Values */
 	bool tc_cbs_supported;
-	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
 	bool ksz87xx_eee_link_erratum;
-- 
2.39.2


