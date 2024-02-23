Return-Path: <linux-kernel+bounces-79166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD8861E66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69038B22FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A071482FF;
	Fri, 23 Feb 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnEy/YDP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A2146E71;
	Fri, 23 Feb 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722146; cv=none; b=kXYxmRzQVUT4Hb/A/CtT6Q9qT3weOa/jS93wQdODPSiErYlqLmOTH0H1u4q5moQs6eNOocy9MxfI2g8RiYIbUDnG1eQ9yxjholLPqmKp4SALxv4Aw6R06alO9jrHZDty+202Y9Kz8pfJbTdbOaQXQkfJqW7Neqwyb0Yzq18UUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722146; c=relaxed/simple;
	bh=1FS1ymrskWa5czitCxLd7qTbgAeF7WMP47xFmyGFtZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBeKRKpxAKU/M3p46F+ZCcZ07oxv96uLn+x+8OM+Pk13zWxCNelowsyEz/joyd+UxABpqc1RIMWbuZqgFSCsNYuUk0owIIU8MiEYqz4QQffvQGRboC8xUsNIQ3uX4TPQu4ygRgq8I9uH8GU91CDwqHZWtlqHItWHx+4CfcSL8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnEy/YDP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f48422fb6so191517466b.3;
        Fri, 23 Feb 2024 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722141; x=1709326941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhgF0KndogaQ4hiNACt7+FiqREIf4PihWNEH6HY1lds=;
        b=SnEy/YDPlKJmc99tEQ3xP3R347x7phk1lz8H/w0hs8+3fUaFG3BT9fHaTw7wbQCAXN
         phq6wXwc5QVVB1Iw7K2ayv5XA9mMsE6Z8AjYGOUT8unfxhMHvngnaM3+7PNkNLgF+q2a
         35hmhn8p3xFPgEjPebW/+uzVF/+al7QyI7Nel4ss7JUwsnolryBQmG/ePJlDtUZq/c2D
         Daf7yvZYf/FZdsJudgw+1JSQKSjbI/BS9dE/fpac7fB1OVRgZRw7IaFlmx/jy5+HenCz
         ANa5nggjwUG/e/mK4KJbeiavBOJXHRbHZQbPWkwcNksHar92es6TWBLBYWlBzEp7zB1a
         dkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722141; x=1709326941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhgF0KndogaQ4hiNACt7+FiqREIf4PihWNEH6HY1lds=;
        b=Bs+mT6llj2fOIkUCbxv/+UmUMhz0ct1C9f4VL+Lv7OTD7kHJ4BP93Fhjy60cGJq9jc
         qlGpagrp5g8H4+1VMsLi6FfzqSNmGFXsfoMmgDLRZj879b9s1a5qe1gUUC1d6V2kXjwV
         cz9+NdPQG2/V3jXE13WcBgduUuamdhkQkY9dX7Prho7vWCyNWcwToqXD9cKmVJWGqpmO
         nP/ku7MTvEVFhdwF2vBYwXC0HHl7Wp61BEnFFEyrRrEEZcmZwwUP9n1MMO+6AVywzJBI
         bDMNHNgqLmMr+Yq8tR41ZyXFqH0mkhRToJ93m7HTiL3+YQw85uAP68TJ4z4/3khrQ0S9
         jO9g==
X-Forwarded-Encrypted: i=1; AJvYcCV89xcFQ18opsEdg2NRx2B+ckCxKl0wnagZUGxEnBC+vrk5ugxFr2AfoxyM18MXZt/Hqy3lwtSGd8qAEwzBHcoTfg7Czod7OOX4AU+4
X-Gm-Message-State: AOJu0Yx+Mgk+8q9blPVUq17HFZQScbbdNqVNdyqlM0cnr612udc4fJ+8
	dnDIAQ9sXwavbOJEU5Bl1sEEyuwK4IxO4/4TpFIKTkRS5hDxfw7GK7YTlKyZ5qM=
X-Google-Smtp-Source: AGHT+IF3RhM7TbNf1aQB1m/C4OSlO3hX/Dcvkm6TCPRoAju58Z9KBRmh+VgOixuz97RguTQPJqai0w==
X-Received: by 2002:a17:906:bc8c:b0:a3f:50ad:fd71 with SMTP id lv12-20020a170906bc8c00b00a3f50adfd71mr615710ejb.19.1708722141366;
        Fri, 23 Feb 2024 13:02:21 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:21 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 07/16] net: dsa: vsc73xx: Add vlan filtering
Date: Fri, 23 Feb 2024 22:00:37 +0100
Message-Id: <20240223210049.3197486-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements VLAN filtering for the vsc73xx driver.

After starting VLAN filtering, the switch is reconfigured from QinQ to
a simple VLAN aware mode. This is required because VSC73XX chips do not
support inner VLAN tag filtering.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - fix possible leak in 'vsc73xx_port_vlan_add'
  - use proper variable in statement from 'vsc73xx_port_vlan_filtering'
  - change 'vlan_no' name to 'vid'
  - codding style improvements
  - comment improvements
  - handle return of 'vsc73xx_update_bits'
  - reduce I/O operations
  - use 'size_t' for counting variables
v4:
  - reworked most of conditional register configs
  - simplified port_vlan function
  - move vlan table clearing from port_setup to setup
  - pvid configuration simplified (now kernel take care about no of
    pvids per port)
  - port vlans are stored in list now
  - introduce implementation of all untagged vlans state
  - many minor changes
v3:
  - reworked all vlan commits
  - added storage variables for pvid and untagged vlans
  - move length extender settings to port setup
  - remove vlan table cleaning in wrong places
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 570 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  29 ++
 2 files changed, 597 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index c3ef4c22f687..87ad8b78f141 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -22,9 +22,11 @@
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/etherdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
+#include <linux/dsa/8021q.h>
 #include <linux/random.h>
 #include <net/dsa.h>
 
@@ -62,6 +64,8 @@
 #define VSC73XX_CAT_DROP	0x6e
 #define VSC73XX_CAT_PR_MISC_L2	0x6f
 #define VSC73XX_CAT_PR_USR_PRIO	0x75
+#define VSC73XX_CAT_VLAN_MISC	0x79
+#define VSC73XX_CAT_PORT_VLAN	0x7a
 #define VSC73XX_Q_MISC_CONF	0xdf
 
 /* MAC_CFG register bits */
@@ -122,6 +126,17 @@
 #define VSC73XX_ADVPORTM_IO_LOOPBACK	BIT(1)
 #define VSC73XX_ADVPORTM_HOST_LOOPBACK	BIT(0)
 
+/*  TXUPDCFG transmit modify setup bits */
+#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE	GENMASK(20, 19)
+#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA	BIT(18)
+#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA	BIT(17)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID	GENMASK(15, 4)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA	BIT(3)
+#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA	BIT(1)
+#define VSC73XX_TXUPDCFG_TX_INSERT_TAG	BIT(0)
+
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT	4
+
 /* CAT_DROP categorizer frame dropping register bits */
 #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA	BIT(6)
 #define VSC73XX_CAT_DROP_FWD_CTRL_ENA		BIT(4)
@@ -135,6 +150,15 @@
 #define VSC73XX_Q_MISC_CONF_EARLY_TX_512	(1 << 1)
 #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE	BIT(0)
 
+/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits */
+#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
+#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
+
+/* CAT_PORT_VLAN categorizer port VLAN */
+#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
+
 /* Frame analyzer block 2 registers */
 #define VSC73XX_STORMLIMIT	0x02
 #define VSC73XX_ADVLEARN	0x03
@@ -189,7 +213,8 @@
 #define VSC73XX_VLANACCESS_VLAN_MIRROR		BIT(29)
 #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK	BIT(28)
 #define VSC73XX_VLANACCESS_VLAN_PORT_MASK	GENMASK(9, 2)
-#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(2, 0)
+#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT	2
+#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(1, 0)
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE	0
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY	1
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY	2
@@ -347,6 +372,12 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
 	{ 29, "TxQoSClass3" }, /* non-standard counter */
 };
 
+enum vsc73xx_port_vlan_conf {
+	VSC73XX_VLAN_FILTER,
+	VSC73XX_VLAN_FILTER_UNTAG_ALL,
+	VSC73XX_VLAN_IGNORE,
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 {
 	switch (block) {
@@ -564,6 +595,91 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_NONE;
 }
 
+static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 ||
+				((val & VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK) ==
+				VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE),
+				VSC73XX_POLL_SLEEP_US, VSC73XX_POLL_TIMEOUT_US,
+				false, vsc, VSC73XX_BLOCK_ANALYZER,
+				0, VSC73XX_VLANACCESS, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
+static int
+vsc73xx_read_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 *portmap)
+{
+	u32 val;
+	int ret;
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, &val);
+	*portmap = (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
+		   VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
+
+	return 0;
+}
+
+static int
+vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portmap)
+{
+	int ret;
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    VSC73XX_VLANACCESS_VLAN_PORT_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT)
+			    );
+
+	return vsc73xx_wait_for_vlan_table_cmd(vsc);
+}
+
+static int
+vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u8 portmap;
+	int ret;
+
+	ret = vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
+	if (ret)
+		return ret;
+
+	if (set)
+		portmap |= BIT(port);
+	else
+		portmap &= ~BIT(port);
+
+	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
+}
+
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -598,7 +714,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 		      VSC73XX_MACACCESS,
 		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
 
-	/* Clear VLAN table */
+	/* Set VLAN table to default values */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 		      VSC73XX_VLANACCESS,
 		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
@@ -627,6 +743,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Ingess VLAN reception mask (table 145) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
+		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -639,6 +758,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	udelay(4);
 
+	/* Clear VLAN table */
+	for (i = 0; i < VLAN_N_VID; i++)
+		vsc73xx_write_vlan_table_entry(vsc, i, 0);
+
+	INIT_LIST_HEAD(&vsc->vlans);
+
 	return 0;
 }
 
@@ -1029,6 +1154,443 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void
+vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
+		      enum vsc73xx_port_vlan_conf port_vlan_conf)
+{
+	u32 val = 0;
+
+	if (port_vlan_conf == VSC73XX_VLAN_IGNORE)
+		val = VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
+		      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
+			    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
+			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);
+
+	val = (port_vlan_conf == VSC73XX_VLAN_FILTER) ?
+	      VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
+}
+
+static int
+vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set,
+			     bool operate_on_storage)
+{
+	u32 val = 0;
+
+	if (operate_on_storage) {
+		vsc->untagged_storage[port] = set ? vid : VLAN_N_VID;
+		return 0;
+	}
+
+	if (set)
+		val = VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
+		      ((vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
+		       VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_TXUPDCFG,
+				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
+				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, val);
+}
+
+static int vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid,
+				    bool set, bool operate_on_storage)
+{
+	int ret;
+	u32 val;
+
+	if (operate_on_storage) {
+		vsc->pvid_storage[port] = set ? vid : VLAN_N_VID;
+		return 0;
+	}
+
+	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
+	vid = set ? vid : 0;
+
+	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				  VSC73XX_CAT_DROP,
+				  VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
+	if (ret)
+		return ret;
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_CAT_PORT_VLAN,
+				   VSC73XX_CAT_PORT_VLAN_VLAN_VID,
+				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
+}
+
+static bool vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid,
+				  bool operate_on_storage)
+{
+	u32 val;
+
+	if (operate_on_storage) {
+		if (vsc->pvid_storage[port] < VLAN_N_VID) {
+			*vid = vsc->pvid_storage[port];
+			return true;
+		}
+		return false;
+	}
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val);
+	if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
+		return false;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
+	*vid = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
+
+	return true;
+}
+
+static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
+{
+	return !dsa_port_is_vlan_filtering(dp);
+}
+
+static bool vsc73xx_port_get_untagged(struct vsc73xx *vsc, int port, u16 *vid,
+				      bool operate_on_storage)
+{
+	u32 val;
+
+	if (operate_on_storage) {
+		if (vsc->untagged_storage[port] < VLAN_N_VID) {
+			*vid = vsc->untagged_storage[port];
+			return true;
+		}
+		return false;
+	}
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
+	if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
+		return false;
+
+	*vid = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
+		VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
+
+	return true;
+}
+
+static struct vsc73xx_bridge_vlan *
+vsc73xx_bridge_vlan_find(struct vsc73xx *vsc, u16 vid)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if (vlan->vid == vid)
+			return vlan;
+
+	return NULL;
+}
+
+static size_t
+vsc73xx_bridge_vlan_num_tagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+	size_t num_tagged = 0;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if ((vlan->portmask & BIT(port)) &&
+		    !(vlan->untagged & BIT(port)) &&
+		    vlan->vid != ignored_vid)
+			num_tagged++;
+
+	return num_tagged;
+}
+
+static size_t
+vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+	size_t num_untagged = 0;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if ((vlan->portmask & BIT(port)) &&
+		    (vlan->untagged & BIT(port)) &&
+		    vlan->vid != ignored_vid)
+			num_untagged++;
+
+	return num_untagged;
+}
+
+static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int port)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if ((vlan->portmask & BIT(port)) &&
+		    (vlan->untagged & BIT(port)))
+			return vlan->vid;
+
+	return VLAN_N_VID;
+}
+
+static int
+vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool vlan_filtering, struct netlink_ext_ack *extack)
+{
+	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
+	struct vsc73xx *vsc = ds->priv;
+	bool store_untagged = false;
+	bool store_pvid = false;
+	u16 vid, vlan_untagged;
+
+	/* The swap processed below is required because vsc73xx is using
+	 * tag_8021q. When vlan_filtering is disabled, tag_8021q uses
+	 * pvid/untagged vlans for port recognition. The values configured for
+	 * vlans < 3072 are stored in storage table. When vlan_filtering is
+	 * enabled, we need to restore pvid/untagged from storage and keep
+	 * values used for tag_8021q.
+	 */
+	if (vlan_filtering) {
+		/* Use VLAN_N_VID to count all vlans */
+		size_t num_untagged =
+			vsc73xx_bridge_vlan_num_untagged(vsc, port, VLAN_N_VID);
+
+		port_vlan_conf = (num_untagged > 1) ?
+				 VSC73XX_VLAN_FILTER_UNTAG_ALL :
+				 VSC73XX_VLAN_FILTER;
+
+		vlan_untagged = vsc73xx_find_first_vlan_untagged(vsc, port);
+		if (vlan_untagged < VLAN_N_VID) {
+			store_untagged  = vsc73xx_port_get_untagged(vsc, port,
+								    &vid,
+								    false);
+			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
+						     true, false);
+			vsc->untagged_storage[port] = store_untagged ?
+						      vid : VLAN_N_VID;
+		}
+	} else {
+		vsc73xx_vlan_change_untagged(vsc, port,
+					     vsc->untagged_storage[port],
+					     vsc->untagged_storage[port] <
+					     VLAN_N_VID, false);
+	}
+
+	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+
+	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vid, false);
+	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
+				 vsc->pvid_storage[port] < VLAN_N_VID, false);
+	vsc->pvid_storage[port] = store_pvid ? vid : VLAN_N_VID;
+
+	return 0;
+}
+
+static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
+	size_t num_tagged, num_untagged;
+	struct vsc73xx *vsc = ds->priv;
+	int ret;
+	u16 vid;
+
+	/* Be sure to deny alterations to the configuration done by tag_8021q.
+	 */
+	if (vid_is_dsa_8021q(vlan->vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Range 3072-4095 reserved for dsa_8021q operation");
+		return -EBUSY;
+	}
+
+	/* The processed vlan->vid is excluded from the search because the VLAN
+	 * can be re-added with a different set of flags, so it's easiest to
+	 * ignore its old flags from the VLAN database software copy.
+	 */
+	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
+	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
+
+	/* VSC73XX allow only three untagged states: none, one or all */
+	if ((untagged && num_tagged > 0 && num_untagged > 0) ||
+	    (!untagged && num_untagged > 1)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Port can have only none, one or all untagged vlan");
+		return -EBUSY;
+	}
+
+	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
+
+	if (!vsc73xx_vlan) {
+		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
+		if (!vsc73xx_vlan)
+			return -ENOMEM;
+
+		vsc73xx_vlan->vid = vlan->vid;
+		vsc73xx_vlan->portmask = BIT(port);
+		vsc73xx_vlan->untagged = untagged ? BIT(port) : 0;
+
+		INIT_LIST_HEAD(&vsc73xx_vlan->list);
+		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
+	} else {
+		vsc73xx_vlan->portmask |= BIT(port);
+
+		if (untagged)
+			vsc73xx_vlan->untagged |= BIT(port);
+		else
+			vsc73xx_vlan->untagged &= ~BIT(port);
+	}
+
+	/* CPU port must be always tagged because port separation is based on
+	 * tag_8021q.
+	 */
+	if (port != CPU_PORT) {
+		bool operate_on_storage = vsc73xx_tag_8021q_active(dp);
+
+		if (!operate_on_storage) {
+			enum vsc73xx_port_vlan_conf port_vlan_conf =
+							VSC73XX_VLAN_FILTER;
+
+			if (num_tagged == 0 && untagged)
+				port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
+			vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+
+			if (port_vlan_conf == VSC73XX_VLAN_FILTER) {
+				if (untagged) {
+					ret = vsc73xx_vlan_change_untagged(vsc,
+									   port,
+									   vlan->vid,
+									   true,
+									   false);
+					if (ret)
+						goto err;
+				} else if (num_untagged == 1) {
+					vid = vsc73xx_find_first_vlan_untagged(vsc,
+									       port);
+					ret = vsc73xx_vlan_change_untagged(vsc,
+									   port,
+									   vid,
+									   true,
+									   false);
+					if (ret)
+						goto err;
+				}
+			}
+		}
+
+		if (pvid) {
+			ret = vsc73xx_vlan_change_pvid(vsc, port, vlan->vid,
+						       true,
+						       operate_on_storage);
+			if (ret)
+				goto err;
+		} else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
+			   vid == vlan->vid) {
+			vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
+		} else if (vsc->pvid_storage[port] == vlan->vid) {
+			vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
+		}
+	}
+
+	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
+	if (!ret)
+		return 0;
+err:
+	list_del(&vsc73xx_vlan->list);
+	kfree(vsc73xx_vlan);
+	return ret;
+}
+
+static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
+	size_t num_tagged, num_untagged;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+	int ret;
+	u16 vid;
+
+	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
+	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
+
+	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
+	if (ret)
+		return ret;
+
+	operate_on_storage = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+
+	if (!operate_on_storage) {
+		enum vsc73xx_port_vlan_conf port_vlan_conf =
+							VSC73XX_VLAN_FILTER;
+
+		if (num_tagged == 0)
+			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
+		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+
+		if (num_untagged <= 1) {
+			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
+			vsc73xx_vlan_change_untagged(vsc, port, vid,
+						     num_untagged, false);
+		}
+	} else if (vsc->untagged_storage[port] == vlan->vid) {
+		vsc73xx_vlan_change_untagged(vsc, port, 0, false, true);
+	}
+
+	if (vsc73xx_port_get_pvid(vsc, port, &vid, false) && vid == vlan->vid)
+		vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
+	else if (vsc->pvid_storage[port] == vlan->vid)
+		vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
+
+	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
+
+	if (vsc73xx_vlan) {
+		vsc73xx_vlan->portmask &= ~BIT(port);
+
+		if (vsc73xx_vlan->portmask)
+			return 0;
+
+		list_del(&vsc73xx_vlan->list);
+		kfree(vsc73xx_vlan);
+	}
+
+	return 0;
+}
+
+static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	/* Those bits are responsible for MTU only. Kernel take care about MTU,
+	 * let's enable +8 bytes frame length unconditionally.
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_VLAN_AWR |
+			    VSC73XX_MAC_CFG_VLAN_DBLAWR,
+			    VSC73XX_MAC_CFG_VLAN_AWR |
+			    VSC73XX_MAC_CFG_VLAN_DBLAWR);
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
+			    VSC73XX_CAT_DROP_TAGGED_ENA |
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA,
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
+			    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
+
+	if (port == CPU_PORT)
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
+	else
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
+
+	/* Initially, there is no backup VLAN configuration to keep track of, so
+	 * configure the storage values out of range
+	 */
+	vsc->pvid_storage[port] = VLAN_N_VID;
+	vsc->untagged_storage[port] = VLAN_N_VID;
+
+	return 0;
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1123,11 +1685,15 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
+	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
+	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
+	.port_vlan_add = vsc73xx_port_vlan_add,
+	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index e7b08599a625..facc50f1e320 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -25,6 +25,17 @@
  * @addr: MAC address used in flow control frames
  * @ops: Structure with hardware-dependent operations
  * @priv: Pointer to the configuration interface structure
+ * @pvid_storage: Storage table with PVID configured for other state of
+ *	vlan_filtering. It has two alternating roles: it stores the PVID when
+ *	configured by the bridge but VLAN filtering is off, and it stores the
+ *	PVID necessary for tag_8021q operation when bridge VLAN filtering is
+ *	enabled.
+ * @untagged_storage: Storage table with eggres untagged VLAN configured for
+ *	other state of vlan_filtering.Keep VID necessary for tag8021q operations
+ *	when vlan filtering is enabled.
+ * @vlans: List of configured vlans. Contains port mask and untagged status of
+ *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
+ *	vlans.
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -35,6 +46,9 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	u16				pvid_storage[VSC73XX_MAX_NUM_PORTS];
+	u16				untagged_storage[VSC73XX_MAX_NUM_PORTS];
+	struct list_head		vlans;
 };
 
 /**
@@ -49,6 +63,21 @@ struct vsc73xx_ops {
 		     u32 val);
 };
 
+/**
+ * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan
+ *	database copy
+ * @vid: VLAN number
+ * @portmask: each bit represends one port
+ * @untagged: each bit represends one port configured with @vid untagged
+ * @list: list structure
+ */
+struct vsc73xx_bridge_vlan {
+	u16 vid;
+	u8 portmask;
+	u8 untagged;
+	struct list_head list;
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock);
 int vsc73xx_probe(struct vsc73xx *vsc);
 void vsc73xx_remove(struct vsc73xx *vsc);
-- 
2.34.1


