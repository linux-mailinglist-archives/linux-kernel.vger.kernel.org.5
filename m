Return-Path: <linux-kernel+bounces-143169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC878A3552
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5331C222A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31315150982;
	Fri, 12 Apr 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnOJYNpk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19F14F9CD;
	Fri, 12 Apr 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945052; cv=none; b=H/x13seRZZT+DPKQuQcXzCA2vticcWkAtgGyWVYOwnPpfN/aB/XRNfioil8KDfes78OVFs/wfdaMkppm3lF/YvrdJRq0Gw6JHN0Uu0WOUEOfS6pVI+BHQSv4RY+EpDEdltsboLF06/X9cx+JAH10PFTicL/fMW2lV5a7/GRc/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945052; c=relaxed/simple;
	bh=aNMo0yvz1nHeNP7+0UB6L1URTtu+mZYwgTmQjLMI9ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHS1xSOxti9De2JQsYWVHYmuBTdEjnVVgibJUVqHsU4yEyHSmysUUsCFF5NK1plpi8yIwAZNz3WxqtiZZ9pK6fM5TnZFR6EC7tNsWyA4/IdHhfwisrnrTHyn0njl/SeE1ipsR83u2/W7/myXHwLgnV7bUd2uXoEioZmK3wXeWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnOJYNpk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so1394045e87.1;
        Fri, 12 Apr 2024 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945048; x=1713549848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns1oG6LOVs/ZVq4Sc81vjB8AQ3EikXTsb00t4EvYj64=;
        b=MnOJYNpkGAI6pZVNQZEdqdv9RgELyCzbifL7bofLrrr3HEp8KIflU5AHJ5hNxRfXD7
         2yqnNPwR4LtKc/80TFPOaH1zhhXTYSM1JWW6uj/ywUpVrQXp2h40EUA31T4jwhD0Eve3
         Xp38pm9uubyxIIhmjYUi7NC/SDjS6vbV+bX3lE/Nc9s9PpEQLMq9VOXWPcFD7SxTkkW3
         kVtFUT/UHBU8mItdlGsTLbUtD5J9yDkC84LN8moTEyPRtpXVtVjf7fZer+6+XQJtzdSl
         0D7vlLlVHjI5N6vxzsLfF9e8oOSrRWO50W4ZwT5b9wXfSxI9CqFRxcfDzCuQUw4VwpKY
         jn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945048; x=1713549848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns1oG6LOVs/ZVq4Sc81vjB8AQ3EikXTsb00t4EvYj64=;
        b=u94omJ4o1J7wYI+iWK1ggmk/FdcwCBqsLqzH28J7NFHW0b10UTXWRce4hHpU1yFefL
         sdxT3dLpGCoFa091KvBpypi1et3VeXEu8/BV/z33mJPPaxwgpFLSfimLVn2PbAYQkRIN
         PgXl+mA+A14CutT9s2IA3+tx9vkDt/rMHJVApf3FVFPq+9r/WraTNUNWyyijq1smFH+Q
         hn5EaVgNzVgHJokWiTy0ln+gtBTIzYnkq/GWPjrrIE5geDW8zHDCoXtlyBXkMhWfaWbA
         dvMT0Gb6hVmCyehL/PHC1LCCTwj+gpJezx0bkrv2gBqdj6x/DyaGau97EB8cWMGkdeM8
         ks5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUvdmxJvutlES870dNHV3FoBwePh4Eu3JqffPcQMcmzEm9ZEQXEvc/krEGIsnl2aey0UKJBJbVVnxFkscdIDm+6dDA1l5NI/0DK9hRAZja7bBJ/E0MuqU3V/8dkqeskqI0EAhR
X-Gm-Message-State: AOJu0YyTv3VshlIkmb7/aZqI6U/WlO/MqdwHo9UFfq3/F4TqjdRSXGJX
	KxD/rR/cj2AN5M1Mx3HBl3Cx3JkP1VrON1OrtF/AzWfRJNPnk2Pv
X-Google-Smtp-Source: AGHT+IEPxhaQXizBkl9ASIbotUhT2y0fS/NO9YBxkzcJIIW1FjddxqImEe8ftmrAW7xDAo1JjdZaVw==
X-Received: by 2002:a05:6512:4802:b0:514:b4ca:f478 with SMTP id eo2-20020a056512480200b00514b4caf478mr1825505lfb.39.1712945048305;
        Fri, 12 Apr 2024 11:04:08 -0700 (PDT)
Received: from localhost ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id bi40-20020a0565120ea800b005187164f908sm386802lfb.109.2024.04.12.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:04:07 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH net 3/4] net: stmmac: Fix IP-cores specific MAC capabilities
Date: Fri, 12 Apr 2024 21:03:16 +0300
Message-ID: <20240412180340.7965-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412180340.7965-1-fancer.lancer@gmail.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the list of the MAC capabilities specific to the particular DW MAC
IP-cores currently supported by the driver:

DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
	   MAC_10 | MAC_100

DW GMAC:  MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_10 | MAC_100 | MAC_1000

Allwinner sun8i MAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
                     MAC_10 | MAC_100 | MAC_1000

DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
            MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
if there is more than 1 active Tx/Rx queues:
	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
           MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD

DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD

DW XLGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD |
          MAC_25000FD | MAC_40000FD | MAC_50000FD | MAC_100000FD

As you can see there are only two common capabilities:
MAC_ASYM_PAUSE | MAC_SYM_PAUSE.
Meanwhile what is currently implemented defines 10/100/1000 link speeds
for all IP-cores, which is definitely incorrect for DW MAC100, DW XGMAC
and DW XLGMAC devices.

Seeing the flow-control is implemented as a callback for each MAC IP-core
(see dwmac100_flow_ctrl(), dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(),
etc) and since the MAC-specific setup() method is supposed to be called
for each available DW MAC-based device, the capabilities initialization
can be freely moved to these setup() functions, thus correctly setting up
the MAC-capabilities for each IP-core (including the Allwinner Sun8i). A
new stmmac_link::caps field was specifically introduced for that so to
have all link-specific info preserved in a single structure.

Note the suggested change fixes three earlier commits at a time. The
commit 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC
supports") permitted the 10-100 link speeds and 1G half-duplex mode for DW
XGMAC IP-core even though it doesn't support them. The commit df7699c70c1b
("net: stmmac: Do not cut down 1G modes") incorrectly added the MAC1000
capability to the DW MAC100 IP-core. Similarly to the DW XGMAC the commit
8a880936e902 ("net: stmmac: Add XLGMII support") incorrectly permitted the
10-100 link speeds and 1G half-duplex mode for DW XLGMAC IP-core.

Fixes: 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC supports")
Fixes: df7699c70c1b ("net: stmmac: Do not cut down 1G modes")
Fixes: 8a880936e902 ("net: stmmac: Add XLGMII support")
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 ++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c   |  2 ++
 .../ethernet/stmicro/stmmac/dwmac100_core.c    |  2 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 10 ++++------
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    | 18 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  7 ++++---
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index a6fefe675ef1..3b7d4ac1e7be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -553,6 +553,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 struct mac_link {
+	u32 caps;
 	u32 speed_mask;
 	u32 speed10;
 	u32 speed100;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b21d99faa2d0..e1b761dcfa1d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1096,6 +1096,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3927609abc44..8555299443f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	mac->link.duplex = GMAC_CONTROL_DM;
 	mac->link.speed10 = GMAC_CONTROL_PS;
 	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index a6e8d7bd9588..7667d103cd0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	dev_info(priv->device, "\tDWMAC100\n");
 
 	mac->pcsr = priv->ioaddr;
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100;
 	mac->link.duplex = MAC_CONTROL_F;
 	mac->link.speed10 = 0;
 	mac->link.speed100 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index ec6a13e644b3..a38226d7cc6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -70,14 +70,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
 {
-	priv->phylink_config.mac_capabilities |= MAC_2500FD;
-
 	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
+		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
@@ -1385,6 +1381,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 	mac->link.duplex = GMAC_CONFIG_DM;
 	mac->link.speed10 = GMAC_CONFIG_PS;
 	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index e841e312077e..f8e7775bb633 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
-static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
-						 MAC_10000FD | MAC_25000FD |
-						 MAC_40000FD | MAC_50000FD |
-						 MAC_100000FD;
-}
-
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1540,7 +1532,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1601,7 +1592,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
@@ -1661,6 +1651,9 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD;
 	mac->link.duplex = 0;
 	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
 	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
@@ -1698,6 +1691,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD |
+			 MAC_40000FD | MAC_50000FD |
+			 MAC_100000FD;
 	mac->link.duplex = 0;
 	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
 	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8a1f02398ee..7c6fb14b5555 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1225,12 +1225,11 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10 | MAC_100 | MAC_1000;
-
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
 
+	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
+
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
@@ -7344,6 +7343,8 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 
 	stmmac_mac_phylink_get_caps(priv);
 
+	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
+
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-- 
2.43.0


