Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765879F14D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjIMSmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjIMSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:42:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4951A3;
        Wed, 13 Sep 2023 11:42:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so20138366b.3;
        Wed, 13 Sep 2023 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694630531; x=1695235331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLA68BBqBCrQ8yDu4m3kkX3hNrfbrxe5MOJVvt5B+cQ=;
        b=OfYaZG3sDWvvCsZle6sVivjZDvOVt2QD0gAwJ0dURLnV/zkYCgU4gRX6H3JC8yzHh8
         CM3vlqbPAtHtKSnIRh3ZBmoQfbWwCVsAnYUFlOeVkFt2iTYtE/z8RKmKj9+tPsg4qJ8U
         VYHTf+SYCZW9XsfabXl9y7UfpaZA+Ms6GoCDiyQKFBcR4G96Rfa0VFo6K9WjsrVWFvpP
         58utgQ95SdpiIVg2CyZNsTUDx6UBqdz5TsOsJUDB/DBRISGV5LrtcKaq4d8TR0Szb3Qp
         L6s+V2FJZOob7mW1SBNhdu3TGS6hLaCqKEBQqLMoD+oW5Cqh3GcSPH0Z1Wtuy0raPz6E
         h+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694630531; x=1695235331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLA68BBqBCrQ8yDu4m3kkX3hNrfbrxe5MOJVvt5B+cQ=;
        b=VsdTayX5FTZ81AxubE4713JJdVX0mqlMZBE5/rEJWpq/0LHvFmAfRwqfvEFtbJNs7U
         CS1f7yBn7VPFlA31IqW1pjOlIo6RsNBtszkTrkOMcgv3syuiL8cEm1b3lO8wXyjnDT9y
         R6Z30p8eoJNIW6urxNO4wjiayX6Dm1+MOB7XPFY2IV8Ac4+FoJxHFzulXik+tC3jCOqf
         1vTU+CZASXR7SzFJ5B784FFUq/yvM3FnS2iQUegOp++PtFRLtoZdaCS4Dg86E3Bz3r5k
         z9cMq+5/+0G20h9/dXWlGlLXJU1qXUCp0YM56MWv9oUCwWsr8i0dqsl6QR0vFFj6ExzU
         NePw==
X-Gm-Message-State: AOJu0YzQ1SQr7BAKphwbrUFEMUndSf5WFVwMeVcR/X3Ye3i1RiyG7Cne
        YkmXgjwu8maL8CocG4Isg+Q=
X-Google-Smtp-Source: AGHT+IHYDNqi6Cl3Cj/URTAn9Q0sUSPeG/guEO3wVEi5HDLVctaXJCYBb9y9imHl5nfw0lBPBIabcA==
X-Received: by 2002:a17:906:20d0:b0:99d:dce8:41d6 with SMTP id c16-20020a17090620d000b0099ddce841d6mr2724806ejc.71.1694630530981;
        Wed, 13 Sep 2023 11:42:10 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906044a00b0099d0a8ccb5fsm8877361eja.152.2023.09.13.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:42:09 -0700 (PDT)
Date:   Wed, 13 Sep 2023 21:42:06 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230913184206.6dmfw4weoomjqwfp@skbuf>
References: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
 <20230912142644.u4sdkveei3e5hwaf@skbuf>
 <20230912170641.5bfc3cfe@wsk>
 <20230912215523.as4puqamj65dikip@skbuf>
 <20230913102219.773e38f8@wsk>
 <20230913105806.g5p3wck675gbw5fo@skbuf>
 <20230913141548.70658940@wsk>
 <20230913135102.hoyl4tifyf77kdo2@skbuf>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="homnli4owkxfms5h"
Content-Disposition: inline
In-Reply-To: <20230913135102.hoyl4tifyf77kdo2@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--homnli4owkxfms5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 13, 2023 at 04:51:02PM +0300, Vladimir Oltean wrote:
> > I'm really stunned, how much extra work is required to add two
> > callbacks to DSA subsystem (to have already implemented feature) for a
> > single chip IC.
> 
> Some observations are best kept to yourself. This is only the second HSR
> offload in the entire kernel. To complain that the infrastructure needs
> some extensions, for something that wasn't even needed for the first
> implementation (tracking a MAC address), is unrealistic.

Can you please test the attached incremental patch, which applies on top
of your RFC v4 series? It contains an implementation of my own review feedback.

--homnli4owkxfms5h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-microchip-incremental-updates-for-HSR-offloa.patch"

From bc0b8f180ad747267adb52496c1cb353626f6d1c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 13 Sep 2023 21:17:55 +0300
Subject: [PATCH] net: dsa: microchip: incremental updates for HSR offload

This contains the following changes squashed together:

- remove the REG_SW_MAC_ADDR_{0..5} macros from ksz8795_reg.h and
  ksz9477_reg.h, and re-add this register offset to the dev->info->regs[]
  array. Defining macros which have the same name but different values
  is bad practice, because it makes it hard to avoid code duplication.
  The same code does different things, depending on the file it's placed
  in. Case in point, we want to access REG_SW_MAC_ADDR from ksz_common.c,
  but currently we can't, because we don't know which kszXXXX_reg.h to
  include from the common code....

- propagate the extack argument from dsa_slave_changeupper() to
  ds->ops->port_hsr_join(), and modify the xrs700s implementation to add
  it. This patch should be moved *before* the ksz9477 offload, in a
  proper submission.

- add a new ds->ops->port_set_mac_address() DSA callback so that drivers
  can veto MAC address changes on ports. KSZ9477 will need it when it
  offloads HSR.

- new API in ksz_common.c for the management of the global switch MAC address.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/microchip/ksz8795_reg.h |   7 --
 drivers/net/dsa/microchip/ksz9477.c     |  11 +-
 drivers/net/dsa/microchip/ksz9477_reg.h |   7 --
 drivers/net/dsa/microchip/ksz_common.c  | 161 +++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_common.h  |   7 ++
 drivers/net/dsa/xrs700x/xrs700x.c       |   3 +-
 include/net/dsa.h                       |  13 +-
 net/dsa/port.c                          |   5 +-
 net/dsa/port.h                          |   3 +-
 net/dsa/slave.c                         |   9 +-
 10 files changed, 152 insertions(+), 74 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 7a57c6088f80..ee1b673d5f30 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -323,13 +323,6 @@
 	((addr) + REG_PORT_1_CTRL_0 + (port) *	\
 		(REG_PORT_2_CTRL_0 - REG_PORT_1_CTRL_0))
 
-#define REG_SW_MAC_ADDR_0		0x68
-#define REG_SW_MAC_ADDR_1		0x69
-#define REG_SW_MAC_ADDR_2		0x6A
-#define REG_SW_MAC_ADDR_3		0x6B
-#define REG_SW_MAC_ADDR_4		0x6C
-#define REG_SW_MAC_ADDR_5		0x6D
-
 #define TABLE_EXT_SELECT_S		5
 #define TABLE_EEE_V			1
 #define TABLE_ACL_V			2
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f36bc427c468..3783f2f3332f 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1169,7 +1169,7 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
 	struct net_device *slave;
-	u8 i, data;
+	u8 data;
 
 	/* Program which port(s) shall support HSR */
 	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
@@ -1184,15 +1184,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 		data |= HSR_DUPLICATE_DISCARD;
 		data &= ~HSR_NODE_UNICAST;
 		ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
-
-		/* Self MAC address filtering for HSR frames to avoid
-		 * traverse of the HSR ring more than once.
-		 *
-		 * The HSR port (i.e. hsr0) MAC address is used.
-		 */
-		for (i = 0; i < ETH_ALEN; i++)
-			ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
-				   hsr->dev_addr[i]);
 	}
 
 	/* Enable per port self-address filtering.
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index cba3dba58bc3..c8866c180fe5 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -166,13 +166,6 @@
 #define SW_DOUBLE_TAG			BIT(7)
 #define SW_RESET			BIT(1)
 
-#define REG_SW_MAC_ADDR_0		0x0302
-#define REG_SW_MAC_ADDR_1		0x0303
-#define REG_SW_MAC_ADDR_2		0x0304
-#define REG_SW_MAC_ADDR_3		0x0305
-#define REG_SW_MAC_ADDR_4		0x0306
-#define REG_SW_MAC_ADDR_5		0x0307
-
 #define REG_SW_MTU__2			0x0308
 #define REG_SW_MTU_MASK			GENMASK(13, 0)
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b81c3ac422f9..318a8b4e32a0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -299,6 +299,7 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 };
 
 static const u16 ksz8795_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
 	[REG_IND_CTRL_0]		= 0x6E,
 	[REG_IND_DATA_8]		= 0x70,
 	[REG_IND_DATA_CHECK]		= 0x72,
@@ -427,6 +428,7 @@ static u8 ksz8863_shifts[] = {
 };
 
 static const u16 ksz9477_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x0302,
 	[P_STP_CTRL]			= 0x0B04,
 	[S_START_CTRL]			= 0x0300,
 	[S_BROADCAST_CTRL]		= 0x0332,
@@ -3420,9 +3422,93 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
-static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
+				    const unsigned char *addr)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+
+	if (dp->hsr_dev) {
+		dev_err(ds->dev,
+			"Cannot change MAC address on port %d with active HSR offload\n",
+			port);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/* Program the switch's MAC address register with the MAC address of the
+ * requesting user port. This single address is used by the switch for multiple
+ * features, like HSR self-address filtering and WoL. Other user ports are
+ * allowed to share ownership of this address as long as their MAC address is
+ * the same. The user ports' MAC addresses must not change while they have
+ * ownership of the switch MAC address.
+ */
+static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
+				  struct netlink_ext_ack *extack)
+{
+	struct net_device *slave = dsa_to_port(ds, port)->slave;
+	const unsigned char *addr = slave->dev_addr;
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	int i;
+
+	/* Make sure concurrent MAC address changes are blocked */
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (switch_macaddr) {
+		if (!ether_addr_equal(switch_macaddr->addr, addr)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Switch already configured for MAC address %pM",
+					       switch_macaddr->addr);
+			return -EBUSY;
+		}
+
+		refcount_inc(&switch_macaddr->refcount);
+		return 0;
+	}
+
+	switch_macaddr = kzalloc(sizeof(*switch_macaddr), GFP_KERNEL);
+	if (!switch_macaddr)
+		return -ENOMEM;
+
+	ether_addr_copy(switch_macaddr->addr, addr);
+	refcount_set(&switch_macaddr->refcount, 1);
+	dev->switch_macaddr = switch_macaddr;
+
+	/* Program the switch MAC address to hardware */
+	for (i = 0; i < ETH_ALEN; i++)
+		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+
+	return 0;
+}
+
+static void ksz_switch_macaddr_put(struct dsa_switch *ds)
+{
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	int i;
+
+	/* Make sure concurrent MAC address changes are blocked */
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (!refcount_dec_and_test(&switch_macaddr->refcount))
+		return;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, 0);
+
+	dev->switch_macaddr = NULL;
+	kfree(switch_macaddr);
+}
+
+static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+			struct netlink_ext_ack *extack)
 {
-	struct net_device *dm = dsa_port_to_master(dsa_to_port(ds, port));
 	struct ksz_device *dev = ds->priv;
 	enum hsr_version ver;
 	int ret;
@@ -3431,41 +3517,34 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 	if (ret)
 		return ret;
 
-	/* Check if HSR net_device's MAC address equals to DSA master.
-	 *
-	 * Only in that way one can assure correct operation between
-	 * different switch features - like WoL, PAUSE and HSR, which
-	 * are using in-switch programmed MAC address.
-	 */
-	if (!ether_addr_equal(dm->dev_addr, hsr->dev_addr)) {
-		dev_err(dev->dev,
-			"DSA master and HSR dev MAC must equal for offloading");
+	if (dev->chip_id != KSZ9477_CHIP_ID) {
+		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
 		return -EOPNOTSUPP;
 	}
 
-	switch (dev->chip_id) {
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477 can support HW offloading of only 1 HSR device */
-		if (dev->hsr_dev && hsr != dev->hsr_dev) {
-			dev_err(dev->dev, "Offload supported for a single HSR");
-			return -EOPNOTSUPP;
-		}
-
-		/* KSZ9477 only supports HSR v0 and v1 */
-		if (!(ver == HSR_V0 || ver == HSR_V1)) {
-			dev_err(dev->dev, "Only HSR v0 and v1 supported");
-			return -EOPNOTSUPP;
-		}
-
-		ksz9477_hsr_join(ds, port, hsr);
-		dev->hsr_dev = hsr;
-		dev->hsr_ports |= BIT(port);
+	/* KSZ9477 can support HW offloading of only 1 HSR device */
+	if (dev->hsr_dev && hsr != dev->hsr_dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Offload supported for a single HSR");
+		return -EOPNOTSUPP;
+	}
 
-		break;
-	default:
+	/* KSZ9477 only supports HSR v0 and v1 */
+	if (!(ver == HSR_V0 || ver == HSR_V1)) {
+		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
 		return -EOPNOTSUPP;
 	}
 
+	/* Self MAC address filtering, to avoid frames traversing
+	 * the HSR ring more than once.
+	 */
+	ret = ksz_switch_macaddr_get(ds, port, extack);
+	if (ret)
+		return ret;
+
+	ksz9477_hsr_join(ds, port, hsr);
+	dev->hsr_dev = hsr;
+	dev->hsr_ports |= BIT(port);
+
 	return 0;
 }
 
@@ -3473,24 +3552,17 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 			 struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
-	int ret = 0;
 
-	switch (dev->chip_id) {
-	case KSZ9477_CHIP_ID:
-		if (hsr != dev->hsr_dev)
-			return -EOPNOTSUPP;
+	WARN_ON(dev->chip_id != KSZ9477);
 
-		ksz9477_hsr_leave(ds, port, hsr);
-		dev->hsr_ports &= ~BIT(port);
-		if (!dev->hsr_ports)
-			dev->hsr_dev = NULL;
+	ksz9477_hsr_leave(ds, port, hsr);
+	dev->hsr_ports &= ~BIT(port);
+	if (!dev->hsr_ports)
+		dev->hsr_dev = NULL;
 
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ksz_switch_macaddr_put(ds);
 
-	return ret;
+	return 0;
 }
 
 static const struct dsa_switch_ops ksz_switch_ops = {
@@ -3514,6 +3586,7 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_hsr_join		= ksz_hsr_join,
 	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index e36d459de5a1..1f447a34f555 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -101,6 +101,11 @@ struct ksz_ptp_irq {
 	int num;
 };
 
+struct ksz_switch_macaddr {
+	unsigned char addr[ETH_ALEN];
+	refcount_t refcount;
+};
+
 struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
@@ -170,6 +175,7 @@ struct ksz_device {
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;
 
+	struct ksz_switch_macaddr *switch_macaddr;
 	struct net_device *hsr_dev;     /* HSR */
 	u8 hsr_ports;
 };
@@ -214,6 +220,7 @@ enum ksz_chip_id {
 };
 
 enum ksz_regs {
+	REG_SW_MAC_ADDR,
 	REG_IND_CTRL_0,
 	REG_IND_DATA_8,
 	REG_IND_DATA_CHECK,
diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 753fef757f11..b9d2e3625def 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -548,7 +548,8 @@ static void xrs700x_bridge_leave(struct dsa_switch *ds, int port,
 }
 
 static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
-			    struct net_device *hsr)
+			    struct net_device *hsr,
+			    struct netlink_ext_ack *extack)
 {
 	unsigned int val = XRS_HSR_CFG_HSR_PRP;
 	struct dsa_port *partner = NULL, *dp;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 0b9c6aa27047..d98439ea6146 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -969,6 +969,16 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+
+	/*
+	 * Notification for MAC address changes on user ports. Drivers can
+	 * currently only veto operations. They should not use the method to
+	 * program the hardware, since the operation is not rolled back in case
+	 * of other errors.
+	 */
+	int	(*port_set_mac_address)(struct dsa_switch *ds, int port,
+					const unsigned char *addr);
+
 	/*
 	 * Compatibility between device trees defining multiple CPU ports and
 	 * drivers which are not OK to use by default the numerically smallest
@@ -1198,7 +1208,8 @@ struct dsa_switch_ops {
 	 * HSR integration
 	 */
 	int	(*port_hsr_join)(struct dsa_switch *ds, int port,
-				 struct net_device *hsr);
+				 struct net_device *hsr,
+				 struct netlink_ext_ack *extack);
 	int	(*port_hsr_leave)(struct dsa_switch *ds, int port,
 				  struct net_device *hsr);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 37ab238e8304..5f01bd4f9dec 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -2024,7 +2024,8 @@ void dsa_shared_port_link_unregister_of(struct dsa_port *dp)
 		dsa_shared_port_setup_phy_of(dp, false);
 }
 
-int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
+int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
+		      struct netlink_ext_ack *extack)
 {
 	struct dsa_switch *ds = dp->ds;
 	int err;
@@ -2034,7 +2035,7 @@ int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
 
 	dp->hsr_dev = hsr;
 
-	err = ds->ops->port_hsr_join(ds, dp->index, hsr);
+	err = ds->ops->port_hsr_join(ds, dp->index, hsr, extack);
 	if (err)
 		dp->hsr_dev = NULL;
 
diff --git a/net/dsa/port.h b/net/dsa/port.h
index dc812512fd0e..334879964e2c 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -103,7 +103,8 @@ int dsa_port_phylink_create(struct dsa_port *dp);
 void dsa_port_phylink_destroy(struct dsa_port *dp);
 int dsa_shared_port_link_register_of(struct dsa_port *dp);
 void dsa_shared_port_link_unregister_of(struct dsa_port *dp);
-int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr);
+int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
+		      struct netlink_ext_ack *extack);
 void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr);
 int dsa_port_tag_8021q_vlan_add(struct dsa_port *dp, u16 vid, bool broadcast);
 void dsa_port_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid, bool broadcast);
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 48db91b33390..4c3e502d7e16 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -457,6 +457,13 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	if (ds->ops->port_set_mac_address) {
+		err = ds->ops->port_set_mac_address(ds, dp->index,
+						    addr->sa_data);
+		if (err)
+			return err;
+	}
+
 	/* If the port is down, the address isn't synced yet to hardware or
 	 * to the DSA master, so there is nothing to change.
 	 */
@@ -2862,7 +2869,7 @@ static int dsa_slave_changeupper(struct net_device *dev,
 		}
 	} else if (is_hsr_master(info->upper_dev)) {
 		if (info->linking) {
-			err = dsa_port_hsr_join(dp, info->upper_dev);
+			err = dsa_port_hsr_join(dp, info->upper_dev, extack);
 			if (err == -EOPNOTSUPP) {
 				NL_SET_ERR_MSG_WEAK_MOD(extack,
 							"Offloading not supported");
-- 
2.34.1


--homnli4owkxfms5h--
