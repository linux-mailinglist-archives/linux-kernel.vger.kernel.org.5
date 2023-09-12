Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677DE79D0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjILM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjILM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:26:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD91704;
        Tue, 12 Sep 2023 05:26:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50098cc8967so8943235e87.1;
        Tue, 12 Sep 2023 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521606; x=1695126406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tam0pcNO13ytdmka8YXfp7vl5yqntntth/LVuA4R9o=;
        b=ZE+qG4+G8rw5Jr2ABqSmsDYH8i2+5K28yOIQ8BlGSzycOUEhqZhln4IevBTg6azJGM
         h1UQLOFAQdwQDDsTKkseqY6tOmcL6JXBljdsKs3mJPkpDwnK/nBHb03mvPrLVP2OCKmF
         pAz7fhzBhMKE+UC+QtWR3iQihHpkndwWnYlTNosDL2HrspAEgmBQNurq0EVftQFZTjON
         1+oVp9svRaSWo22QNltaXhpXP96PMjbSYPIxppY9ptHAw8IRG/HDKguZBz3k6UsxFDh5
         elKm2nFJZLVfQnkySDgw2FE1HvoKpG/r05tr3ceqpVyiw+hezrcIS9dd99IddTRZZDxy
         p11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521606; x=1695126406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tam0pcNO13ytdmka8YXfp7vl5yqntntth/LVuA4R9o=;
        b=YED1TWuWg/t3EvVaknx5+JYNiWqyR5biSXfTDihJpZY45sYKPxrZiH43RCYKpSVAIo
         RHunLv+FMrm3gAeXDzn8oEWOdCYGIKj5NfyOwm+99wk6IdH0eGvqRU6NIYZd1+xNPi5j
         zXgrOmVvczHdOTRwXhft4KKUONgcx+q/+NaVR8usyG5Wj0F89TL9VhaxTE7r4gBjyHh0
         C1cgjJ3xnYOoqP6Q3lLGzMvLXgxgZisgJCC7A3oWPRcAiAwx02IslUUCggzfRCleel6E
         lK5L5m4kM+opIjT6ddnFtlMmoJKQhjmx7xk4PnTpD97zKES95YvludWa5kOwLoRa3Zke
         +j8w==
X-Gm-Message-State: AOJu0YxTfmxI4SnBhxdovDW05ZMOixvCwz35qaU5TB+P1Ot0WXH4hPEZ
        n9e/oUc5XLPSwAaiVQovB9BbnVXtIeHnFQ==
X-Google-Smtp-Source: AGHT+IFN8vmhb3dY3X1yecbPYRN4CH2wfiLuug/QrpbR1LmVrly9mQipKGud3fT1Gl8Mp/Ng9K9lwg==
X-Received: by 2002:a05:6512:10ca:b0:500:9d32:8deb with SMTP id k10-20020a05651210ca00b005009d328debmr12815034lfg.51.1694521605460;
        Tue, 12 Sep 2023 05:26:45 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:45 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/8] net: dsa: vsc73xx: Add vlan filtering
Date:   Tue, 12 Sep 2023 14:21:59 +0200
Message-Id: <20230912122201.3752918-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements VLAN filtering for the vsc73xx driver.

After starting VLAN filtering, the switch is reconfigured from QinQ to
a simple VLAN aware mode. This is required because VSC73XX chips do not
support inner VLAN tag filtering.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - reworked all vlan commits
  - added storage variables for pvid and untagged vlans
  - move length extender settings to port setup
  - remove vlan table cleaning in wrong places
  - note: dev_warn was keept because function 'vsc73xx_vlan_set_untagged'
    and 'vsc73xx_vlan_set_pvid' are used later in tag implementation
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 425 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
 2 files changed, 425 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 541fbc195df1..d9a6eac1fcce 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -21,14 +21,18 @@
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
 
 #include "vitesse-vsc73xx.h"
 
+#define VSC73XX_IS_CONFIGURED	0x1
+
 #define VSC73XX_BLOCK_MAC	0x1 /* Subblocks 0-4, 6 (CPU port) */
 #define VSC73XX_BLOCK_ANALYZER	0x2 /* Only subblock 0 */
 #define VSC73XX_BLOCK_MII	0x3 /* Subblocks 0 and 1 */
@@ -61,6 +65,8 @@
 #define VSC73XX_CAT_DROP	0x6e
 #define VSC73XX_CAT_PR_MISC_L2	0x6f
 #define VSC73XX_CAT_PR_USR_PRIO	0x75
+#define VSC73XX_CAT_VLAN_MISC	0x79
+#define VSC73XX_CAT_PORT_VLAN	0x7a
 #define VSC73XX_Q_MISC_CONF	0xdf
 
 /* MAC_CFG register bits */
@@ -121,6 +127,17 @@
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
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4
+
 /* CAT_DROP categorizer frame dropping register bits */
 #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA	BIT(6)
 #define VSC73XX_CAT_DROP_FWD_CTRL_ENA		BIT(4)
@@ -134,6 +151,15 @@
 #define VSC73XX_Q_MISC_CONF_EARLY_TX_512	(1 << 1)
 #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE	BIT(0)
 
+/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/
+#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
+#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
+
+/* CAT_PORT_VLAN categorizer port VLAN*/
+#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
+
 /* Frame analyzer block 2 registers */
 #define VSC73XX_STORMLIMIT	0x02
 #define VSC73XX_ADVLEARN	0x03
@@ -188,7 +214,8 @@
 #define VSC73XX_VLANACCESS_VLAN_MIRROR		BIT(29)
 #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK	BIT(28)
 #define VSC73XX_VLANACCESS_VLAN_PORT_MASK	GENMASK(9, 2)
-#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(2, 0)
+#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT	2
+#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(1, 0)
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE	0
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY	1
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY	2
@@ -343,6 +370,11 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
 	{ 29, "TxQoSClass3" }, /* non-standard counter */
 };
 
+enum vsc73xx_port_vlan_conf {
+	VSC73XX_VLAN_FILTER,
+	VSC73XX_VLAN_IGNORE,
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 {
 	switch (block) {
@@ -563,7 +595,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -623,6 +655,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Ingess VLAN reception mask (table 145) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
+		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -1031,8 +1066,387 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 	return 9600 - ETH_HLEN - ETH_FCS_LEN;
 }
 
+static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || ((val & VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK) ==
+					    VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE),
+				1000, 10000, false, vsc, VSC73XX_BLOCK_ANALYZER,
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
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+	vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, &val);
+	*portmap = (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
+		   VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
+	return 0;
+}
+
+static int
+vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portmap)
+{
+	int ret;
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
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
+			    (portmap <<
+			     VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
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
+		portmap |= BIT(port) | BIT(CPU_PORT);
+	else
+		portmap &= ~BIT(port);
+
+	if (portmap == BIT(CPU_PORT))
+		portmap = 0;
+
+	return  vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
+}
+
+static void
+vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
+		      enum vsc73xx_port_vlan_conf port_vlan_conf)
+{
+	if (port_vlan_conf == VSC73XX_VLAN_IGNORE) {
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_TXUPDCFG,
+				    VSC73XX_TXUPDCFG_TX_INSERT_TAG, 0);
+	} else {
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+				    0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_TXUPDCFG,
+				    VSC73XX_TXUPDCFG_TX_INSERT_TAG,
+				    VSC73XX_TXUPDCFG_TX_INSERT_TAG);
+	}
+}
+
+static int
+vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u32 val = set ? VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, val);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
+			    (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
+			     VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
+	return 0;
+}
+
+static int
+vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u32 val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
+			    VSC73XX_CAT_PORT_VLAN_VLAN_VID,
+			    vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
+	return 0;
+}
+
+static int vsc73xx_vlan_port_is_pvid(struct vsc73xx *vsc, int port, u16 *vid)
+{
+	u32 val;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val);
+	if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
+		return 0;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
+	*vid = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
+
+	return VSC73XX_IS_CONFIGURED;
+}
+
+static int vsc73xx_vlan_port_is_untagged(struct vsc73xx *vsc, int port, u16 *vid)
+{
+	u32 val;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
+	if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
+		return 0;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+		     &val);
+	*vid = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
+		VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
+
+	return VSC73XX_IS_CONFIGURED;
+}
+
+static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, u16 vid,
+				     bool port_vlan)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no = 0;
+
+	if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)) ^ port_vlan) {
+		if (vsc->untagged_storage[port] < VLAN_N_VID &&
+		    !vid_is_dsa_8021q(vsc->untagged_storage[port]) &&
+		    !vid_is_dsa_8021q(vid) &&
+		    vsc->untagged_storage[port] != vid) {
+			dev_warn(vsc->dev,
+				 "Port %d can have only one untagged vid! Now is: %d.\n",
+				 port, vsc->untagged_storage[port]);
+			return -EOPNOTSUPP;
+		}
+		vsc->untagged_storage[port] = vid;
+	} else {
+		if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED &&
+		    !vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) && vlan_no != vid) {
+			dev_warn(vsc->dev,
+				 "Port %d can have only one untagged vid! Now is: %d.\n",
+				 port, vlan_no);
+			return -EOPNOTSUPP;
+		}
+		return vsc73xx_vlan_change_untagged(vsc, port, vid, 1);
+	}
+
+	return 0;
+}
+
+static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
+				 bool port_vlan)
+{
+	struct dsa_port *dsa_port = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no;
+
+	if (!dsa_port)
+		return -EINVAL;
+
+	if (dsa_port_is_vlan_filtering(dsa_port) ^ port_vlan) {
+		if (vsc->pvid_storage[port] < VLAN_N_VID &&
+		    !vid_is_dsa_8021q(vsc->pvid_storage[port]) &&
+		    !vid_is_dsa_8021q(vid) && vsc->pvid_storage[port] != vid) {
+			dev_warn(vsc->dev,
+				 "Port %d can have only one pvid! Now is: %d.\n",
+				 port, vsc->pvid_storage[port]);
+			return -EOPNOTSUPP;
+		}
+		vsc->pvid_storage[port] = vid;
+	} else {
+		if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED &&
+		    !vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) &&
+		    vlan_no != vid) {
+			dev_warn(vsc->dev,
+				 "Port %d can have only one pvid! Now is: %d.\n",
+				 port, vlan_no);
+			return -EOPNOTSUPP;
+		}
+		return vsc73xx_vlan_change_pvid(vsc, port, vid, 1);
+	}
+
+	return 0;
+}
+
+static int
+vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool vlan_filtering, struct netlink_ext_ack *extack)
+{
+	struct vsc73xx *vsc = ds->priv;
+	bool store_untagged  = false;
+	bool store_pvid  = false;
+	u16 vlan_no;
+
+	if (vlan_filtering)
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
+	else
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
+
+	if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED)
+		store_pvid = true;
+
+	if (vsc->pvid_storage[port] < VLAN_N_VID)
+		vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port], true);
+	else
+		vsc73xx_vlan_change_pvid(vsc, port, 0, false);
+
+	vsc->pvid_storage[port] = store_pvid ? vlan_no : VLAN_N_VID;
+
+	if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED)
+		store_untagged  = true;
+
+	if (vsc->untagged_storage[port] < VLAN_N_VID)
+		vsc73xx_vlan_change_untagged(vsc, port, vsc->untagged_storage[port], true);
+	else
+		vsc73xx_vlan_change_untagged(vsc, port, 0, false);
+
+	vsc->untagged_storage[port] = store_untagged ? vlan_no : VLAN_N_VID;
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
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no;
+	int ret;
+
+	/* Be sure to deny alterations to the configuration done by tag_8021q.
+	 */
+	if (vid_is_dsa_8021q(vlan->vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Range 3072-4095 reserved for dsa_8021q operation");
+		return -EBUSY;
+	}
+
+	if (port != CPU_PORT) {
+		if (untagged) {
+			ret = vsc73xx_vlan_set_untagged(ds, port, vlan->vid, true);
+			if (ret)
+				return ret;
+		} else {
+			if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no)
+			    == VSC73XX_IS_CONFIGURED &&
+			    vlan_no == vlan->vid)
+				vsc73xx_vlan_change_untagged(vsc, port, 0, false);
+			else if (vsc->untagged_storage[port] == vlan->vid)
+				vsc->untagged_storage[port] = VLAN_N_VID;
+		}
+		if (pvid) {
+			ret = vsc73xx_vlan_set_pvid(ds, port, vlan->vid, true);
+			if (ret)
+				return ret;
+		} else {
+			if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no)
+			    == VSC73XX_IS_CONFIGURED &&
+			    vlan_no == vlan->vid)
+				vsc73xx_vlan_change_pvid(vsc, port, 0, false);
+			else if (vsc->pvid_storage[port] == vlan->vid)
+				vsc->pvid_storage[port] = VLAN_N_VID;
+		}
+	}
+
+	return vsc73xx_update_vlan_table(vsc, port, vlan->vid, 1);
+}
+
+static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no;
+	int ret;
+
+	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, 0);
+	if (ret)
+		return ret;
+
+	if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED &&
+	    vlan_no == vlan->vid)
+		vsc73xx_vlan_change_untagged(vsc, port, 0, false);
+	else if (vsc->untagged_storage[port] == vlan->vid)
+		vsc->untagged_storage[port] = VLAN_N_VID;
+
+	if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) == VSC73XX_IS_CONFIGURED &&
+	    vlan_no == vlan->vid)
+		vsc73xx_vlan_change_pvid(vsc, port, 0, false);
+	else if (vsc->pvid_storage[port] == vlan->vid)
+		vsc->pvid_storage[port] = VLAN_N_VID;
+
+	return 0;
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
+	struct vsc73xx *vsc = ds->priv;
+	int ret, i;
+
+	/* Those bits are responsible for MTU only. Kernel take care about MTU,
+	 * let's enable +8 bytes frame length unconditionally.
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR,
+			    VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR);
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
+			    VSC73XX_CAT_DROP_TAGGED_ENA, 0);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA,
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, 0);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
+			    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
+
+	if (port == CPU_PORT)
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
+	else
+		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
+
+	for (i = 0; i <= VLAN_N_VID; i++) {
+		ret = vsc73xx_update_vlan_table(vsc, port, i, 0);
+		if (ret)
+			return ret;
+	}
+
 	/* Configure forward map to CPU <-> port only */
 	if (port == CPU_PORT)
 		vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK &
@@ -1041,6 +1455,10 @@ static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 		vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK &
 					 BIT(CPU_PORT);
 
+	/* Set storage values out of range*/
+	vsc->pvid_storage[port] = VLAN_N_VID;
+	vsc->untagged_storage[port] = VLAN_N_VID;
+
 	return 0;
 }
 
@@ -1098,6 +1516,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
+	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
+	.port_vlan_add = vsc73xx_port_vlan_add,
+	.port_vlan_del = vsc73xx_port_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 224e284a5573..b7614dd7d0eb 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -30,6 +30,8 @@ struct vsc73xx {
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
 	u8				forward_map[VSC73XX_MAX_NUM_PORTS];
+	u16				pvid_storage[VSC73XX_MAX_NUM_PORTS];
+	u16				untagged_storage[VSC73XX_MAX_NUM_PORTS];
 };
 
 struct vsc73xx_ops {
-- 
2.34.1

