Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1171575BB95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGUAk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:40:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB32729;
        Thu, 20 Jul 2023 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689900022; x=1721436022;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/aqUdrVL1l9NPHnxxN37Ke6gxrSzgK2R7vkAMWUsfEU=;
  b=oAvA5lSncbZ3M4fZGSchcu6NfWI6YsCwUUDEDWWegmdFdhyNOMuyMkXd
   FKp3U9Zntz0T3GWzEDiwLR+/UvC3xzdAfS8gBTyJ7yfy6abTRPB8USHtT
   bl/SZSyuHqypfsdQmZJYEKbHHMbWdgpkhjiUnFFz0Q+Wj3xpMo5+5PyEq
   QIza6UDHCRfRfCJXwgeBBK88vuWDNbYG8Wq6CbCzVVIOCcMzS33tZ6NX3
   H6PPMu6miZV/BebsD0psUZIyHpJr++AqYxdg+bV9czE8J5r90A3kji7KT
   J0PUGJTEqiOZlTzZksq4+P2R4bgM6U7WNTGfzHRv/OV6avaj/6jpfrjwO
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="224303040"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 17:40:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 17:40:10 -0700
Received: from hat-linux.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 17:40:10 -0700
From:   <Tristram.Ha@microchip.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH v5 net-next] net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs
Date:   Thu, 20 Jul 2023 17:40:53 -0700
Message-ID: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tristram Ha <Tristram.Ha@microchip.com>

Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
of frame data, which can be used to implement ARP or multicast WoL.

ARP WoL matches any ARP frame with broadcast address.

Multicast WoL matches any multicast frame.

Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
---
v5
- Resend for patch submission.

v4
- Reduce variable use for calling the function to enable WoL.
- Provide a general description of how the pattern data are prepared.

v3
- Do not try to get IPv4 and IPv6 address from the driver
- As a result only generic ARP and multicast support are provided

v2
- use in_dev_put() only when IP support is enabled

v1
- use in_dev_get() to retrieve IP address to avoid compiler warning
- use ipv6_get_lladdr() to retrieve IPv6 address
- use that function only when IPv6 support is enabled
- export that function in addrconf.c
- program the MAC address in a loop
- always set datalen in lan874x_chk_wol_pattern()
- add spaces around "<<"
- select CRC16 in Kconfig as crc16() is used in driver

 drivers/net/phy/Kconfig |   1 +
 drivers/net/phy/smsc.c  | 259 +++++++++++++++++++++++++++++++++++++++-
 include/linux/smscphy.h |  34 ++++++
 3 files changed, 292 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 87b823858717..67aaeb75301f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -350,6 +350,7 @@ config ROCKCHIP_PHY
 
 config SMSC_PHY
 	tristate "SMSC PHYs"
+	select CRC16
 	help
 	  Currently supports the LAN83C185, LAN8187 and LAN8700 PHYs
 
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 692930750215..a66e9e1a0abe 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -20,6 +20,12 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
+#include <linux/crc16.h>
+#include <linux/etherdevice.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <net/if_inet6.h>
+#include <net/ipv6.h>
 #include <linux/smscphy.h>
 
 /* Vendor-specific PHY Definitions */
@@ -51,6 +57,7 @@ struct smsc_phy_priv {
 	unsigned int edpd_enable:1;
 	unsigned int edpd_mode_set_by_user:1;
 	unsigned int edpd_max_wait_ms;
+	bool wol_arp;
 };
 
 static int smsc_phy_ack_interrupt(struct phy_device *phydev)
@@ -258,6 +265,246 @@ int lan87xx_read_status(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(lan87xx_read_status);
 
+static int lan874x_phy_config_init(struct phy_device *phydev)
+{
+	u16 val;
+	int rc;
+
+	/* Setup LED2/nINT/nPME pin to function as nPME.  May need user option
+	 * to use LED1/nINT/nPME.
+	 */
+	val = MII_LAN874X_PHY_PME2_SET;
+
+	/* The bits MII_LAN874X_PHY_WOL_PFDA_FR, MII_LAN874X_PHY_WOL_WUFR,
+	 * MII_LAN874X_PHY_WOL_MPR, and MII_LAN874X_PHY_WOL_BCAST_FR need to
+	 * be cleared to de-assert PME signal after a WoL event happens, but
+	 * using PME auto clear gets around that.
+	 */
+	val |= MII_LAN874X_PHY_PME_SELF_CLEAR;
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   val);
+	if (rc < 0)
+		return rc;
+
+	/* set nPME self clear delay time */
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_MCFGR,
+			   MII_LAN874X_PHY_PME_SELF_CLEAR_DELAY);
+	if (rc < 0)
+		return rc;
+
+	return smsc_phy_config_init(phydev);
+}
+
+static void lan874x_get_wol(struct phy_device *phydev,
+			    struct ethtool_wolinfo *wol)
+{
+	struct smsc_phy_priv *priv = phydev->priv;
+	int rc;
+
+	wol->supported = (WAKE_UCAST | WAKE_BCAST | WAKE_MAGIC |
+			  WAKE_ARP | WAKE_MCAST);
+	wol->wolopts = 0;
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return;
+
+	if (rc & MII_LAN874X_PHY_WOL_PFDAEN)
+		wol->wolopts |= WAKE_UCAST;
+
+	if (rc & MII_LAN874X_PHY_WOL_BCSTEN)
+		wol->wolopts |= WAKE_BCAST;
+
+	if (rc & MII_LAN874X_PHY_WOL_MPEN)
+		wol->wolopts |= WAKE_MAGIC;
+
+	if (rc & MII_LAN874X_PHY_WOL_WUEN) {
+		if (priv->wol_arp)
+			wol->wolopts |= WAKE_ARP;
+		else
+			wol->wolopts |= WAKE_MCAST;
+	}
+}
+
+static u16 smsc_crc16(const u8 *buffer, size_t len)
+{
+	return bitrev16(crc16(0xFFFF, buffer, len));
+}
+
+static int lan874x_chk_wol_pattern(const u8 pattern[], const u16 *mask,
+				   u8 len, u8 *data, u8 *datalen)
+{
+	size_t i, j, k;
+	int ret = 0;
+	u16 bits;
+
+	/* Pattern filtering can match up to 128 bytes of frame data.  There
+	 * are 8 registers to program the 16-bit masks, where each bit means
+	 * the byte will be compared.  The frame data will then go through a
+	 * CRC16 calculation for hardware comparison.  This helper function
+	 * makes sure only relevant frame data are included in this
+	 * calculation.  It provides a warning when the masks and expected
+	 * data size do not match.
+	 */
+	i = 0;
+	k = 0;
+	while (len > 0) {
+		bits = *mask;
+		for (j = 0; j < 16; j++, i++, len--) {
+			/* No more pattern. */
+			if (!len) {
+				/* The rest of bitmap is not empty. */
+				if (bits)
+					ret = i + 1;
+				break;
+			}
+			if (bits & 1)
+				data[k++] = pattern[i];
+			bits >>= 1;
+		}
+		mask++;
+	}
+	*datalen = k;
+	return ret;
+}
+
+static int lan874x_set_wol_pattern(struct phy_device *phydev, u16 val,
+				   const u8 data[], u8 datalen,
+				   const u16 *mask, u8 masklen)
+{
+	u16 crc, reg;
+	int rc;
+
+	/* Starting pattern offset is set before calling this function. */
+	val |= MII_LAN874X_PHY_WOL_FILTER_EN;
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			   MII_LAN874X_PHY_MMD_WOL_WUF_CFGA, val);
+	if (rc < 0)
+		return rc;
+
+	crc = smsc_crc16(data, datalen);
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			   MII_LAN874X_PHY_MMD_WOL_WUF_CFGB, crc);
+	if (rc < 0)
+		return rc;
+
+	masklen = (masklen + 15) & ~0xf;
+	reg = MII_LAN874X_PHY_MMD_WOL_WUF_MASK7;
+	while (masklen >= 16) {
+		rc = phy_write_mmd(phydev, MDIO_MMD_PCS, reg, *mask);
+		if (rc < 0)
+			return rc;
+		reg--;
+		mask++;
+		masklen -= 16;
+	}
+
+	/* Clear out the rest of mask registers. */
+	while (reg != MII_LAN874X_PHY_MMD_WOL_WUF_MASK0) {
+		phy_write_mmd(phydev, MDIO_MMD_PCS, reg, 0);
+		reg--;
+	}
+	return rc;
+}
+
+static int lan874x_set_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct net_device *ndev = phydev->attached_dev;
+	struct smsc_phy_priv *priv = phydev->priv;
+	u16 val, val_wucsr;
+	u8 data[128];
+	u8 datalen;
+	int rc;
+
+	if (wol->wolopts & WAKE_PHY)
+		return -EOPNOTSUPP;
+
+	/* lan874x has only one WoL filter pattern */
+	if ((wol->wolopts & (WAKE_ARP | WAKE_MCAST)) ==
+	    (WAKE_ARP | WAKE_MCAST)) {
+		phydev_info(phydev,
+			    "lan874x WoL supports one of ARP|MCAST at a time\n");
+		return -EOPNOTSUPP;
+	}
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return rc;
+
+	val_wucsr = rc;
+
+	if (wol->wolopts & WAKE_UCAST)
+		val_wucsr |= MII_LAN874X_PHY_WOL_PFDAEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_PFDAEN;
+
+	if (wol->wolopts & WAKE_BCAST)
+		val_wucsr |= MII_LAN874X_PHY_WOL_BCSTEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_BCSTEN;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		val_wucsr |= MII_LAN874X_PHY_WOL_MPEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_MPEN;
+
+	/* Need to use pattern matching */
+	if (wol->wolopts & (WAKE_ARP | WAKE_MCAST))
+		val_wucsr |= MII_LAN874X_PHY_WOL_WUEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_WUEN;
+
+	if (wol->wolopts & WAKE_ARP) {
+		const u8 pattern[2] = { 0x08, 0x06 };
+		const u16 mask[1] = { 0x0003 };
+
+		rc = lan874x_chk_wol_pattern(pattern, mask, 2, data,
+					     &datalen);
+		if (rc)
+			phydev_dbg(phydev, "pattern not valid at %d\n", rc);
+
+		/* Need to match broadcast destination address and provided
+		 * data pattern at offset 12.
+		 */
+		val = 12 | MII_LAN874X_PHY_WOL_FILTER_BCSTEN;
+		rc = lan874x_set_wol_pattern(phydev, val, data, datalen, mask,
+					     2);
+		if (rc < 0)
+			return rc;
+		priv->wol_arp = true;
+	}
+
+	if (wol->wolopts & WAKE_MCAST) {
+		/* Need to match multicast destination address. */
+		val = MII_LAN874X_PHY_WOL_FILTER_MCASTTEN;
+		rc = lan874x_set_wol_pattern(phydev, val, data, 0, NULL, 0);
+		if (rc < 0)
+			return rc;
+		priv->wol_arp = false;
+	}
+
+	if (wol->wolopts & (WAKE_MAGIC | WAKE_UCAST)) {
+		const u8 *mac = (const u8 *)ndev->dev_addr;
+		int i, reg;
+
+		reg = MII_LAN874X_PHY_MMD_WOL_RX_ADDRC;
+		for (i = 0; i < 6; i += 2, reg--) {
+			rc = phy_write_mmd(phydev, MDIO_MMD_PCS, reg,
+					   ((mac[i + 1] << 8) | mac[i]));
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   val_wucsr);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int smsc_get_sset_count(struct phy_device *phydev)
 {
 	return ARRAY_SIZE(smsc_hw_stats);
@@ -533,7 +780,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan874x_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 
 	/* IRQ related */
@@ -548,6 +795,10 @@ static struct phy_driver smsc_phy_driver[] = {
 	.get_tunable	= smsc_phy_get_tunable,
 	.set_tunable	= smsc_phy_set_tunable,
 
+	/* WoL */
+	.set_wol	= lan874x_set_wol,
+	.get_wol	= lan874x_get_wol,
+
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -566,7 +817,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan874x_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 
 	/* IRQ related */
@@ -581,6 +832,10 @@ static struct phy_driver smsc_phy_driver[] = {
 	.get_tunable	= smsc_phy_get_tunable,
 	.set_tunable	= smsc_phy_set_tunable,
 
+	/* WoL */
+	.set_wol	= lan874x_set_wol,
+	.get_wol	= lan874x_get_wol,
+
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 } };
diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
index e1c88627755a..1a6a851d2cf8 100644
--- a/include/linux/smscphy.h
+++ b/include/linux/smscphy.h
@@ -38,4 +38,38 @@ int smsc_phy_set_tunable(struct phy_device *phydev,
 			 struct ethtool_tunable *tuna, const void *data);
 int smsc_phy_probe(struct phy_device *phydev);
 
+#define MII_LAN874X_PHY_MMD_WOL_WUCSR		0x8010
+#define MII_LAN874X_PHY_MMD_WOL_WUF_CFGA	0x8011
+#define MII_LAN874X_PHY_MMD_WOL_WUF_CFGB	0x8012
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK0	0x8021
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK1	0x8022
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK2	0x8023
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK3	0x8024
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK4	0x8025
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK5	0x8026
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK6	0x8027
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK7	0x8028
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRA	0x8061
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRB	0x8062
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRC	0x8063
+#define MII_LAN874X_PHY_MMD_MCFGR		0x8064
+
+#define MII_LAN874X_PHY_PME1_SET		(2 << 13)
+#define MII_LAN874X_PHY_PME2_SET		(2 << 11)
+#define MII_LAN874X_PHY_PME_SELF_CLEAR		BIT(9)
+#define MII_LAN874X_PHY_WOL_PFDA_FR		BIT(7)
+#define MII_LAN874X_PHY_WOL_WUFR		BIT(6)
+#define MII_LAN874X_PHY_WOL_MPR			BIT(5)
+#define MII_LAN874X_PHY_WOL_BCAST_FR		BIT(4)
+#define MII_LAN874X_PHY_WOL_PFDAEN		BIT(3)
+#define MII_LAN874X_PHY_WOL_WUEN		BIT(2)
+#define MII_LAN874X_PHY_WOL_MPEN		BIT(1)
+#define MII_LAN874X_PHY_WOL_BCSTEN		BIT(0)
+
+#define MII_LAN874X_PHY_WOL_FILTER_EN		BIT(15)
+#define MII_LAN874X_PHY_WOL_FILTER_MCASTTEN	BIT(9)
+#define MII_LAN874X_PHY_WOL_FILTER_BCSTEN	BIT(8)
+
+#define MII_LAN874X_PHY_PME_SELF_CLEAR_DELAY	0x1000 /* 81 milliseconds */
+
 #endif /* __LINUX_SMSCPHY_H__ */
-- 
2.17.1

