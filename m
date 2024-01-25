Return-Path: <linux-kernel+bounces-38159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3952383BBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A37281815
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5F71798E;
	Thu, 25 Jan 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="GYyg0/uN"
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF091175B6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170904; cv=none; b=M/oZCDwBb0J+ftD2WxElcpqQR5wUqv+C8SLs0bmqAC+xm4OUwwAOTyTV8JadBY6WpDtF2hRZHCQv2UVE0jCAgB1EuhubT9k5No1P6d6SNV2Z4E/pl3FrtOrpOFjUqWfn8+1GNyh7i2E4He3an3F5f8kgQJsn9S/Vg+jHlyhVEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170904; c=relaxed/simple;
	bh=lQwaeL0A2+FvcWJHCYoyDlQd8pHosLsv5ulV7zKsCxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqE09W3DOTtJaXc56af9sUzosPVRnvOP7V4tXwVwrz63kv9Jn1QrMp3OVM5th1dDafEzNUKYBKxNdQfoOaP2sXQ/2vgoD7odbnyj1lSbYSW48dvkvJfs7zjRsD9kBK+uz/qhCxc9LDBO9V3V6VMlLcGGarynQwfwuH99quU7UJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=GYyg0/uN; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLD0S23sfzPwr;
	Thu, 25 Jan 2024 09:05:44 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLD0R3YS0zpG0;
	Thu, 25 Jan 2024 09:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706169944;
	bh=lQwaeL0A2+FvcWJHCYoyDlQd8pHosLsv5ulV7zKsCxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYyg0/uNxnvai7JtsowGmje90sgOvepYothuLcWGQqmEQQUMgo8NVYcR91gyFwKXZ
	 zXB+8VbwKgK6pdONFV+rTxtSOmdDxzMh4PPU1Gfa7vIVjGyWbtbGPilqZa3P3ozhhG
	 zjz/SjzhFGUeffSCEfVpbQx//DDrZexKpQWqtQN8=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	stefan.portmann@impulsing.ch,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>
Subject: [PATCH net-next v2 2/2] net: dsa: Add KSZ8567 switch support
Date: Thu, 25 Jan 2024 09:05:04 +0100
Message-Id: <20240125080504.62061-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125080504.62061-1-dev@pschenker.ch>
References: <20240125080504.62061-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

This commit introduces support for the KSZ8567, a robust 7-port
Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
each capable of gigabit speeds, complemented by five 10/100 Mbps
MAC/PHYs.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

---

Changes in v2:
- Move the definition of KSZ8567 next to similar KSZ9567

 drivers/net/dsa/microchip/ksz9477_i2c.c     |  4 ++
 drivers/net/dsa/microchip/ksz_common.c      | 42 ++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  1 +
 drivers/net/dsa/microchip/ksz_spi.c         |  5 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index cac4a607e54a..82bebee4615c 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -103,6 +103,10 @@ static const struct of_device_id ksz9477_dt_ids[] = {
 		.compatible = "microchip,ksz8563",
 		.data = &ksz_switch_chips[KSZ8563]
 	},
+	{
+		.compatible = "microchip,ksz8567",
+		.data = &ksz_switch_chips[KSZ8567]
+	},
 	{
 		.compatible = "microchip,ksz9567",
 		.data = &ksz_switch_chips[KSZ9567]
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 245dfb7a7a31..77a0d7e86460 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1476,6 +1476,38 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable = {true, true, true},
 	},
 
+	[KSZ8567] = {
+		.chip_id = KSZ8567_CHIP_ID,
+		.dev_name = "KSZ8567",
+		.num_vlans = 4096,
+		.num_alus = 4096,
+		.num_statics = 16,
+		.cpu_ports = 0x7F,	/* can be configured as cpu port */
+		.port_cnt = 7,		/* total port count */
+		.port_nirqs = 3,
+		.num_tx_queues = 4,
+		.tc_cbs_supported = true,
+		.tc_ets_supported = true,
+		.ops = &ksz9477_dev_ops,
+		.mib_names = ksz9477_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz9477_regs,
+		.masks = ksz9477_masks,
+		.shifts = ksz9477_shifts,
+		.xmii_ctrl0 = ksz9477_xmii_ctrl0,
+		.xmii_ctrl1 = ksz9477_xmii_ctrl1,
+		.supports_mii	= {false, false, false, false,
+				   false, true, true},
+		.supports_rmii	= {false, false, false, false,
+				   false, true, true},
+		.supports_rgmii = {false, false, false, false,
+				   false, true, true},
+		.internal_phy	= {true, true, true, true,
+				   true, false, false},
+		.gbit_capable	= {false, false, false, false, false, true, true},
+	},
+
 	[KSZ9567] = {
 		.chip_id = KSZ9567_CHIP_ID,
 		.dev_name = "KSZ9567",
@@ -2649,6 +2681,7 @@ static void ksz_port_teardown(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -2705,7 +2738,8 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	    dev->chip_id == KSZ9563_CHIP_ID)
 		proto = DSA_TAG_PROTO_KSZ9893;
 
-	if (dev->chip_id == KSZ9477_CHIP_ID ||
+	if (dev->chip_id == KSZ8567_CHIP_ID ||
+	    dev->chip_id == KSZ9477_CHIP_ID ||
 	    dev->chip_id == KSZ9896_CHIP_ID ||
 	    dev->chip_id == KSZ9897_CHIP_ID ||
 	    dev->chip_id == KSZ9567_CHIP_ID)
@@ -2813,6 +2847,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8830_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -2839,6 +2874,7 @@ static int ksz_validate_eee(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -3183,6 +3219,7 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		case KSZ9896_CHIP_ID:
 		case KSZ9897_CHIP_ID:
 		case KSZ9567_CHIP_ID:
+		case KSZ8567_CHIP_ID:
 		case LAN9370_CHIP_ID:
 		case LAN9371_CHIP_ID:
 		case LAN9372_CHIP_ID:
@@ -3220,6 +3257,7 @@ static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -3239,6 +3277,7 @@ static int ksz_cls_flower_del(struct dsa_switch *ds, int port,
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -4142,6 +4181,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 15612101a155..060c5de9aa05 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -187,6 +187,7 @@ struct ksz_device {
 /* List of supported models */
 enum ksz_model {
 	KSZ8563,
+	KSZ8567,
 	KSZ8795,
 	KSZ8794,
 	KSZ8765,
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 6f6d878e742c..c8166fb440ab 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -164,6 +164,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,ksz8563",
 		.data = &ksz_switch_chips[KSZ8563]
 	},
+	{
+		.compatible = "microchip,ksz8567",
+		.data = &ksz_switch_chips[KSZ8567]
+	},
 	{
 		.compatible = "microchip,ksz9567",
 		.data = &ksz_switch_chips[KSZ9567]
@@ -204,6 +208,7 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "ksz9893" },
 	{ "ksz9563" },
 	{ "ksz8563" },
+	{ "ksz8567" },
 	{ "ksz9567" },
 	{ "lan9370" },
 	{ "lan9371" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index f177416635a2..c4466e56d9d7 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -24,6 +24,7 @@
 
 enum ksz_chip_id {
 	KSZ8563_CHIP_ID = 0x8563,
+	KSZ8567_CHIP_ID = 0x00856700,
 	KSZ8795_CHIP_ID = 0x8795,
 	KSZ8794_CHIP_ID = 0x8794,
 	KSZ8765_CHIP_ID = 0x8765,
-- 
2.34.1


