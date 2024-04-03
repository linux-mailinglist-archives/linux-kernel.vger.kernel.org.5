Return-Path: <linux-kernel+bounces-129576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC9896CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CD51C2626F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A841474C7;
	Wed,  3 Apr 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbX4CYWY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFD146A9D;
	Wed,  3 Apr 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140696; cv=none; b=ijjcUSwC7Z7FoxEM8XuxMZoSxjbPzg1uVSBK7tbGUVNS/k2zOtY+MIkGjtcVLExQETr9ZU9nEV0Pej46h0WYpgkigJkKgrhPhcj+6iTBM4C7OzKkbvazseAhMXipO1PrWpZhJpptq0oVI+MyVctguEp/Roqpp6S9L6+k9+njj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140696; c=relaxed/simple;
	bh=rnY+cCtNMoXLjaxY0ForNaORLT90w5+ndaRME2CQa9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7IZ80hlMwTsiyduCz/iIo64gY2gaicKAFDjrsC/N3GE4q776XUdENPS7dZL2oRtNYJ5bPDHMkcRjNImycD0S5MQkl7HpeQXOmRZldmo9AJD8v68ZKG5iyr8pM+U+IUfVQAthWgJrC2SyXb2Y1b3nr4aPaUEp4G9L1vzCX6J48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbX4CYWY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e6777af4so10231553e87.2;
        Wed, 03 Apr 2024 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140691; x=1712745491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1eUz821Rsmmp3GT55xyp+NROU6XLGF51PaLaRHs81Q=;
        b=VbX4CYWYGJUZjeHXCySf+DO7HPQQltV1yuJB3YEM4261kcOnRyJ5OJTY8PUwoAuV7M
         txSExXTqrS3uAuBfGcI6DH5BH9ODmuFOmYiU7zjZWLr9MT3xY/yd/F2QejxrhxRidzXG
         yydszTe+Jh7Y/mf6IvZ3HGbzGbM7+LQEeBzX9ACRoMrWCN1+hM9R3wDTWCIMy96eACP7
         mzXEACBy+09rIKk/oPNJj7anuHlwioELogj77A91/x0vPH6p4o58Y58wMFtrRNQAwkE5
         9fVT0vytvHxCadBjhJVsxsvB6iTIyseSmG4B/0iegE8+J5fuT9swh9weqSWX9Zwr72eX
         7SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140691; x=1712745491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1eUz821Rsmmp3GT55xyp+NROU6XLGF51PaLaRHs81Q=;
        b=sEcImehadAeHnznPcbq+o5PdGFyLT+8P7SU88ul1GJrkupOZyUWeOv3xzsyhrgI5q/
         M1CwTjiWY/H70wPNCMCVb8yo2BHDF8bFOyMdCKYFuBWM6F9mQbSh30lq8UAELoQgRaZe
         T8YtS3TrEPwdJhgvDluqcMd9p8JhEyoodFJvhzUYfyFJ3Gf3hbauiNCOQOcbWs/mworC
         7DRVkEGi8/P8nkrg4ij7xoT2NM4QJLRaaqQAnxGXfYOAEOm0FTLLxEJodr5C6B3ChHOV
         /NDF/rLbs9n4CCZrTmxSubf9iATAkM7W/zN/JSRKG31y3/OlxR4V8XYhKu1LFJ1v1hI4
         DRLg==
X-Forwarded-Encrypted: i=1; AJvYcCWSQauI4T1kv7P6c/ABEhrOWaGmfKCDKLSLP2H3yb+U+9NpCm4XidcG49/vzihujDEUoVTkrT5mPOrgR9Ru3OdPosb4V8f6hqtwSkZ5
X-Gm-Message-State: AOJu0YwRtZjirKmyDTeYe6B7KyY/BRYj5Ay5ZAy2Iz1Dq/pU9vV1Crw7
	sVwJF6wjUw0SA/EVEIAwmWIqSvwVpi25D/3f6KMh/zdeLOfyDJbqfoArsfXMu+k=
X-Google-Smtp-Source: AGHT+IHux5Vw/3FbnxMw2EaITLCJaX36IJp620ir8Izdw5HfWGG9keLaFYsRQjvvnDVHYY3WgyWn+w==
X-Received: by 2002:a05:6512:ea6:b0:516:a13c:da5b with SMTP id bi38-20020a0565120ea600b00516a13cda5bmr4159688lfb.65.1712140690911;
        Wed, 03 Apr 2024 03:38:10 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:10 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v8 07/16] net: dsa: vsc73xx: Add vlan filtering
Date: Wed,  3 Apr 2024 12:37:23 +0200
Message-Id: <20240403103734.3033398-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
v8:
  - set init value of 'ret' in 'vsc73xx_port_vlan_add'
v7:
  - rework pvid and untagged configuration routines
  - introduce portinfo structure which should make pvid/untagged
    procedures simpler
  - introduce 'vsc73xx_vlan_summary' structure
  - replace tagged/untagged count functions with 'vsc73xx_bridge_vlan_summary'
  - fix VSC73XX_VLANMASK configuration. It was copy from existing code.
  - stop configuring pvid/untagged registers whed pvid/untagged is
    disabled
v6:
  - resend only
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

 drivers/net/dsa/vitesse-vsc73xx-core.c | 545 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  42 ++
 2 files changed, 585 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 07f982cf62dd..433ffd4f44fd 100644
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
@@ -347,6 +372,17 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
 	{ 29, "TxQoSClass3" }, /* non-standard counter */
 };
 
+struct vsc73xx_vlan_summary {
+	size_t num_tagged;
+	size_t num_untagged;
+};
+
+enum vsc73xx_port_vlan_conf {
+	VSC73XX_VLAN_FILTER,
+	VSC73XX_VLAN_FILTER_UNTAG_ALL,
+	VSC73XX_VLAN_IGNORE,
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 {
 	switch (block) {
@@ -564,6 +600,90 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
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
+			    (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
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
@@ -598,7 +718,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 		      VSC73XX_MACACCESS,
 		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
 
-	/* Clear VLAN table */
+	/* Set VLAN table to default values */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 		      VSC73XX_VLANACCESS,
 		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
@@ -627,6 +747,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Ingess VLAN reception mask (table 145) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
+		      0xff);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -639,6 +762,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	udelay(4);
 
+	/* Clear VLAN table */
+	for (i = 0; i < VLAN_N_VID; i++)
+		vsc73xx_write_vlan_table_entry(vsc, i, 0);
+
+	INIT_LIST_HEAD(&vsc->vlans);
+
 	return 0;
 }
 
@@ -822,6 +951,12 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
 	val |= VSC73XX_MAC_CFG_WEXC_DIS;
+
+	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
+	 * let's enable +8 bytes frame length unconditionally.
+	 */
+	val |= VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR;
+
 	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
 
 	/* Flow control for the PHY facing ports:
@@ -1029,6 +1164,408 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
+{
+	return !dsa_port_is_vlan_filtering(dp);
+}
+
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
+static int vsc73xx_vlan_change_untagged_hw(struct vsc73xx *vsc, int port,
+					   u16 vid, bool set)
+{
+	u32 val = 0;
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
+static int vsc73xx_vlan_set_untagged_hw(struct vsc73xx *vsc, int port, u16 vid)
+{
+	return vsc73xx_vlan_change_untagged_hw(vsc, port, vid, true);
+}
+
+static int
+vsc73xx_vlan_change_pvid_hw(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u32 val = 0;
+	int ret;
+
+	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
+
+	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				  VSC73XX_CAT_DROP,
+				  VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
+	if (!set || ret)
+		return ret;
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_CAT_PORT_VLAN,
+				   VSC73XX_CAT_PORT_VLAN_VLAN_VID,
+				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
+}
+
+static int vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid,
+				    bool valid, bool operate_on_storage,
+				    bool tag_8021q_mode)
+{
+	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
+
+	if (tag_8021q_mode) {
+		portinfo->pvid_tag_8021q_configured = valid;
+		portinfo->pvid_tag_8021q = vid;
+	} else {
+		portinfo->pvid_vlan_filtering_configured = valid;
+		portinfo->pvid_vlan_filtering = vid;
+	}
+
+	if (operate_on_storage)
+		return 0;
+
+	return vsc73xx_vlan_change_pvid_hw(vsc, port, vid, valid);
+}
+
+static int vsc73xx_vlan_clear_pvid(struct vsc73xx *vsc, int port,
+				   bool operate_on_storage, bool tag_8021q_mode)
+{
+	return vsc73xx_vlan_change_pvid(vsc, port, 0, false,
+					operate_on_storage, tag_8021q_mode);
+}
+
+static int vsc73xx_vlan_set_pvid(struct vsc73xx *vsc, int port, u16 vid,
+				 bool operate_on_storage, bool tag_8021q_mode)
+{
+	return vsc73xx_vlan_change_pvid(vsc, port, vid, true,
+					operate_on_storage, tag_8021q_mode);
+}
+
+static bool vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid,
+				  bool tag_8021q_mode)
+{
+	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
+
+	if (tag_8021q_mode) {
+		if (portinfo->pvid_tag_8021q_configured)
+			*vid = portinfo->pvid_tag_8021q;
+		return portinfo->pvid_tag_8021q_configured;
+	}
+
+	if (portinfo->pvid_vlan_filtering_configured)
+		*vid = portinfo->pvid_vlan_filtering;
+	return portinfo->pvid_vlan_filtering_configured;
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
+static void vsc73xx_bridge_vlan_summary(struct vsc73xx *vsc, int port,
+					struct vsc73xx_vlan_summary *summary,
+					u16 ignored_vid)
+{
+	size_t num_tagged = 0, num_untagged = 0;
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list) {
+		if (!(vlan->portmask & BIT(port)) || vlan->vid == ignored_vid)
+			continue;
+
+		if (vlan->untagged & BIT(port))
+			num_untagged++;
+		else
+			num_tagged++;
+	}
+
+	summary->num_untagged = num_untagged;
+	summary->num_tagged = num_tagged;
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
+	u16 vid_pvid = 0, vid_untagged = 0;
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool set_untagged = false;
+	bool set_pvid = false;
+
+	portinfo = &vsc->portinfo[port];
+
+	/* The swap processed below is required because vsc73xx is using
+	 * tag_8021q. When vlan_filtering is disabled, tag_8021q uses
+	 * pvid/untagged vlans for port recognition. The values configured for
+	 * vlans and pvid/untagged states are stored in portinfo structure.
+	 * When vlan_filtering is enabled, we need to restore pvid/untagged from
+	 * portinfo structure. Analogic routine is processed when vlan_filtering
+	 * is disabled, but values used for tag_8021q are restored.
+	 */
+	if (vlan_filtering) {
+		struct vsc73xx_vlan_summary summary;
+
+		/* Use VLAN_N_VID to count all vlans */
+		vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
+
+		port_vlan_conf = (summary.num_untagged > 1) ?
+				 VSC73XX_VLAN_FILTER_UNTAG_ALL :
+				 VSC73XX_VLAN_FILTER;
+
+		if (summary.num_untagged == 1) {
+			vid_untagged = vsc73xx_find_first_vlan_untagged(vsc,
+									port);
+			set_untagged = true;
+		}
+
+		vid_pvid = portinfo->pvid_vlan_filtering;
+		set_pvid = portinfo->pvid_vlan_filtering_configured;
+	} else {
+		vid_untagged = portinfo->untagged_tag_8021q;
+		set_untagged = portinfo->untagged_tag_8021q_configured;
+		vid_pvid = portinfo->pvid_tag_8021q;
+		set_pvid = portinfo->pvid_tag_8021q_configured;
+	}
+
+	vsc73xx_vlan_change_untagged_hw(vsc, port, vid_untagged, set_untagged);
+	vsc73xx_vlan_change_pvid_hw(vsc, port, vid_pvid, set_pvid);
+	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
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
+	enum vsc73xx_port_vlan_conf port_vlan_conf;
+	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
+	struct vsc73xx_vlan_summary summary;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+	int ret = 0;
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
+	vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
+
+	/* VSC73XX allow only three untagged states: none, one or all */
+	if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
+	    (!untagged && summary.num_untagged > 1)) {
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
+		vsc73xx_vlan->portmask = 0;
+		vsc73xx_vlan->untagged = 0;
+
+		INIT_LIST_HEAD(&vsc73xx_vlan->list);
+		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
+	}
+
+	vsc73xx_vlan->portmask |= BIT(port);
+
+	if (untagged)
+		vsc73xx_vlan->untagged |= BIT(port);
+	else
+		vsc73xx_vlan->untagged &= ~BIT(port);
+
+	/* CPU port must be always tagged because port separation is based on
+	 * tag_8021q.
+	 */
+	if (port == CPU_PORT)
+		goto update_vlan_table;
+
+	operate_on_storage = vsc73xx_tag_8021q_active(dp);
+
+	if (pvid)
+		ret = vsc73xx_vlan_set_pvid(vsc, port, vlan->vid,
+					    operate_on_storage, false);
+	else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
+		 vid == vlan->vid)
+		ret = vsc73xx_vlan_clear_pvid(vsc, port, operate_on_storage,
+					      false);
+	if (ret)
+		goto err;
+
+	if (operate_on_storage)
+		goto update_vlan_table;
+
+	port_vlan_conf = VSC73XX_VLAN_FILTER;
+
+	if (summary.num_tagged == 0 && untagged)
+		port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
+	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+
+	if (port_vlan_conf == VSC73XX_VLAN_FILTER_UNTAG_ALL)
+		goto update_vlan_table;
+
+	if (untagged) {
+		ret = vsc73xx_vlan_set_untagged_hw(vsc, port, vlan->vid);
+	} else if (summary.num_untagged == 1) {
+		vid = vsc73xx_find_first_vlan_untagged(vsc, port);
+		ret = vsc73xx_vlan_set_untagged_hw(vsc, port, vid);
+	}
+	if (ret)
+		goto err;
+
+update_vlan_table:
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
+	struct vsc73xx_vlan_summary summary;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+	int ret;
+	u16 vid;
+
+	vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
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
+		if (summary.num_tagged == 0)
+			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
+		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+
+		if (summary.num_untagged <= 1) {
+			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
+			vsc73xx_vlan_change_untagged_hw(vsc, port, vid,
+							summary.num_untagged);
+		}
+	}
+
+	if (vsc73xx_port_get_pvid(vsc, port, &vid, false) && vid == vlan->vid)
+		vsc73xx_vlan_clear_pvid(vsc, port, operate_on_storage, false);
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
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+
+	portinfo = &vsc->portinfo[port];
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
+	portinfo->pvid_vlan_filtering_configured = false;
+	portinfo->pvid_tag_8021q_configured = false;
+	portinfo->untagged_tag_8021q_configured = false;
+
+	return 0;
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1120,11 +1657,15 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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
index e7b08599a625..ce007273eafe 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -14,6 +14,27 @@
  */
 #define VSC73XX_MAX_NUM_PORTS	8
 
+/**
+ * struct vsc73xx_portinfo - port data structure: contains storage data
+ * @pvid_vlan_filtering_configured: imforms if port have configured pvid in vlan
+ *	fitering mode
+ * @pvid_vlan_filtering: pvid vlan number used in vlan fitering mode
+ * @pvid_tag_8021q_configured: imforms if port have configured pvid in tag_8021q
+ *	mode
+ * @pvid_tag_8021q: pvid vlan number used in tag_8021q mode
+ * @untagged_tag_8021q_configured: imforms if port have configured untagged vlan
+ *	in tag_8021q mode
+ * @untagged_tag_8021q: untagged vlan number used in tag_8021q mode
+ */
+struct vsc73xx_portinfo {
+	bool		pvid_vlan_filtering_configured;
+	u16		pvid_vlan_filtering;
+	bool		pvid_tag_8021q_configured;
+	u16		pvid_tag_8021q;
+	bool		untagged_tag_8021q_configured;
+	u16		untagged_tag_8021q;
+};
+
 /**
  * struct vsc73xx - VSC73xx state container: main data structure
  * @dev: The device pointer
@@ -25,6 +46,10 @@
  * @addr: MAC address used in flow control frames
  * @ops: Structure with hardware-dependent operations
  * @priv: Pointer to the configuration interface structure
+ * @portinfo: Storage table portinfo structructures
+ * @vlans: List of configured vlans. Contains port mask and untagged status of
+ *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
+ *	vlans.
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -35,6 +60,8 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
+	struct list_head		vlans;
 };
 
 /**
@@ -49,6 +76,21 @@ struct vsc73xx_ops {
 		     u32 val);
 };
 
+/**
+ * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan
+ *	database copy
+ * @vid: VLAN number
+ * @portmask: each bit represents one port
+ * @untagged: each bit represents one port configured with @vid untagged
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


