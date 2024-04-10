Return-Path: <linux-kernel+bounces-138138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C989ED2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3DB23159
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E213E895;
	Wed, 10 Apr 2024 08:06:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BB13CFA1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736369; cv=none; b=NaPSsISaDvzVQYm9UfeEL1GfZo65QVrptm3YmkDqaD82dnoxj9iFkRL038mzhd+K7V40J9d+if/8HrcJ7e0Df7aEkPCe+BH30fLJujMmKaA5Xd3qFFz9zcwpjDzukfB/6Y9IgPHmXcOcmv64ZPWr5CBxsCu8vCNHNcSmuKTy9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736369; c=relaxed/simple;
	bh=X8srKv2lr8JCWuKwsYN93JdLXw2CFUfrrFAUDcqlebk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpzh9nMx7DTGf+VFiri6EQV5mrIZlYHLAeGCkTnEgk05r8JO9WfgtgaF/nG9GA7v1cW0f4peep2Kav0ep7pJVbUPeLZZuYizoX1krQyJ6SsfqaQ+/cHJuZ2p9TDu8MgGgavyhmnEs8/rdwVIQgd1bxc4fBd1+4EwMJ9fnvHGF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ruSy0-0004NT-Bh; Wed, 10 Apr 2024 10:06:00 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ruSxy-00BSb6-0O; Wed, 10 Apr 2024 10:05:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ruSxx-005Cuk-2v;
	Wed, 10 Apr 2024 10:05:57 +0200
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
Subject: [PATCH net-next v6 7/9] net: dsa: microchip: enable ETS support for KSZ989X variants
Date: Wed, 10 Apr 2024 10:05:54 +0200
Message-Id: <20240410080556.1241048-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410080556.1241048-1-o.rempel@pengutronix.de>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
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
index 78a9622adecde..87a807ac7900e 100644
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
index 0089d01a04b99..18cc6d1e42ede 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -63,7 +63,6 @@ struct ksz_chip_data {
 	u8 num_tx_queues;
 	u8 num_ipvs; /* number of Internal Priority Values */
 	bool tc_cbs_supported;
-	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
 	bool ksz87xx_eee_link_erratum;
 	const struct ksz_mib_names *mib_names;
-- 
2.39.2


