Return-Path: <linux-kernel+bounces-44162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F7841E26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E083D1C241AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458559155;
	Tue, 30 Jan 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="cKk37AcR"
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED757895
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604111; cv=none; b=m9apUzwQsRsl/1XzBEmU2A96blesyryWgDiXTK25JeN7bWsJK9GxK2gvAsOocvhwrJM6wvHSdODNfuPBtY+K7zQ+d1JpjHS24DSQl12bQSzXmmHz+W3IIAq/G9FIeRqAe96ZnX6vhbTRcJL3Sd5u5Fc3br2TsPNj1y28QOicV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604111; c=relaxed/simple;
	bh=rEPPzbtp7T8BNnKZfxSdq728QVo3IoiRwZKsrO9GbLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1My0hxCNsauwPnkP9BGMzFH53n/9618j8kqEednFUkmCdjwvDbbKZ/3FF+wdYpDTYa1qCaOPAmbW80BiAUwd8D2ORikqix0INgzys6pIoNT6/OWEQnjJNXVuvy/bA1MGqGtQNbB1GQcPFC71pKC3uPXH5cBP/TtOdnu3/kqTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=cKk37AcR; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TPJPD0pzpzZ47;
	Tue, 30 Jan 2024 09:34:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TPJPC3HYmzDMG;
	Tue, 30 Jan 2024 09:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706603664;
	bh=rEPPzbtp7T8BNnKZfxSdq728QVo3IoiRwZKsrO9GbLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKk37AcR+LkM+OY/V2qGKlAait3MxrdmdgByMTkEdbfr99RxEMu8M/R4x8WxHfCaC
	 2L6byxE/05zxqe/oyBOyVkvbEimN1BRjxkDHP9my9UHwbLent+DJq4CE/UKZLGmCil
	 tJ62wAf/wT7ZszYYt9YEFuE7CU3FIBb/PCmQuLT8=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	stefan.portmann@impulsing.ch,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v3 2/2] net: dsa: Add KSZ8567 switch support
Date: Tue, 30 Jan 2024 09:34:19 +0100
Message-Id: <20240130083419.135763-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130083419.135763-1-dev@pschenker.ch>
References: <20240130083419.135763-1-dev@pschenker.ch>
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
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

---

Changes in v3:
- Move KSZ8567_CHIP_ID also next to KSZ9567 in microchip-ksz.h
- Fix 80 chars warning.
- Add Arun's Acked-by. Thanks!

Changes in v2:
- Move the definition of KSZ8567 next to similar KSZ9567

 drivers/net/dsa/microchip/ksz9477_i2c.c     |  4 ++
 drivers/net/dsa/microchip/ksz_common.c      | 43 ++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  1 +
 drivers/net/dsa/microchip/ksz_spi.c         |  5 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 5 files changed, 53 insertions(+), 1 deletion(-)

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
index 245dfb7a7a31..6ae08de54061 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1476,6 +1476,39 @@ const struct ksz_chip_data ksz_switch_chips[] = {
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
+		.gbit_capable	= {false, false, false, false, false,
+				   true, true},
+	},
+
 	[KSZ9567] = {
 		.chip_id = KSZ9567_CHIP_ID,
 		.dev_name = "KSZ9567",
@@ -2649,6 +2682,7 @@ static void ksz_port_teardown(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -2705,7 +2739,8 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	    dev->chip_id == KSZ9563_CHIP_ID)
 		proto = DSA_TAG_PROTO_KSZ9893;
 
-	if (dev->chip_id == KSZ9477_CHIP_ID ||
+	if (dev->chip_id == KSZ8567_CHIP_ID ||
+	    dev->chip_id == KSZ9477_CHIP_ID ||
 	    dev->chip_id == KSZ9896_CHIP_ID ||
 	    dev->chip_id == KSZ9897_CHIP_ID ||
 	    dev->chip_id == KSZ9567_CHIP_ID)
@@ -2813,6 +2848,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8830_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -2839,6 +2875,7 @@ static int ksz_validate_eee(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -3183,6 +3220,7 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		case KSZ9896_CHIP_ID:
 		case KSZ9897_CHIP_ID:
 		case KSZ9567_CHIP_ID:
+		case KSZ8567_CHIP_ID:
 		case LAN9370_CHIP_ID:
 		case LAN9371_CHIP_ID:
 		case LAN9372_CHIP_ID:
@@ -3220,6 +3258,7 @@ static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -3239,6 +3278,7 @@ static int ksz_cls_flower_del(struct dsa_switch *ds, int port,
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
 	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
 	case KSZ9567_CHIP_ID:
@@ -4142,6 +4182,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
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
index f177416635a2..8c659db4da6b 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -33,6 +33,7 @@ enum ksz_chip_id {
 	KSZ9897_CHIP_ID = 0x00989700,
 	KSZ9893_CHIP_ID = 0x00989300,
 	KSZ9563_CHIP_ID = 0x00956300,
+	KSZ8567_CHIP_ID = 0x00856700,
 	KSZ9567_CHIP_ID = 0x00956700,
 	LAN9370_CHIP_ID = 0x00937000,
 	LAN9371_CHIP_ID = 0x00937100,
-- 
2.34.1


