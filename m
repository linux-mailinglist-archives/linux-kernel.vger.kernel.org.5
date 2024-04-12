Return-Path: <linux-kernel+bounces-143170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E08A3554
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2084D281B36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE4150998;
	Fri, 12 Apr 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWCXmCeY"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5614F9EA;
	Fri, 12 Apr 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945053; cv=none; b=K60qOD+1ezRrn+FY3lUnPRXy2fudIJ4zn1tJ/Y32oP7SrmoTwrRt4dEh2nZoKmebKGthNV8Fm/iFz9uTaBmaTzDEqMFxCATUqJiYEj5ErkyE2f8oO0jG8IegVUExao2+KXhhvurYwQZVPBGKLTiWK95DOyBOifGbz/Zd6djjeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945053; c=relaxed/simple;
	bh=tbHO/TE0urFDQY0QRj9ooUJURLBzp9JI1C+6T25mPjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVDufH72bPflAoA5ARj47NLn5KN6qTI/bucNN6MVaryEbNr/+XTk7TIpDhLmQkv2iXomsy/5tHIpj0SW7eviGPfkV1T12g7625fqCC9TGchIwb8oh1/GHWkZJAKcTHjpQQBcWp6yP/1Z/tz6soM2xDgsgCKqfSGoGDe1mayjn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWCXmCeY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so11649771fa.3;
        Fri, 12 Apr 2024 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945050; x=1713549850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVOumlgGtBlZ85ugSU3wCdejk77Ru/Jzabc/ZwR7GtA=;
        b=gWCXmCeYCVeT+KMs0a874ELowlSjqqcZPufxhDqD229bYkBIEGnppGc/r/JWdIJsjr
         SiRvkJYOCh3X2FcNC3/jG+0Hvo2mRtCLKnaaomSpaTObSyRizOFtrfL5cOU0gpFWUn2p
         R0Iugdd/9AVqsXn83d12SDCOLXIqUJHHp7c+e5qhbIqDNyzOnRLyNXekXrTXJwW6nwtY
         d9MB8X5hJBQR2H49ayXyVMvyWcaysaH94QbpdKkWmHVespcMJRBSgoNQ1BOBRvoAo63W
         W5tNEaY9bNYG2htePV24kcVdX4gb107HjR9xKK2wQ/PiFkmCqgQwEjToMMXL8MpCNDA+
         lYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945050; x=1713549850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVOumlgGtBlZ85ugSU3wCdejk77Ru/Jzabc/ZwR7GtA=;
        b=vZy9CrnAnOPtlX00AMeT7MQF169mJHiWh62uaBvOt7ITG7hS/YvyGysB1FSkldPIWS
         ad/yJLm2UtFOupc0DPBRbHOtKrngkLGErOXwYLKHESAoaa+xGFrYxNdWdRzJYBWLQgiF
         iwuBCvjyNphUVilLx9UKTW0WkA3VCpgsnzgmJp9oE42PW4+K8HFxF3+8ytTlzi75uj9V
         bgnP7ehEiRkHLIU3+sfkiO5sgGo7Fl5w6gHnSvozfrl9HXU4YS08OfVDjn2XHjOprCvr
         YKkOHsgKcAq4dMjCB/8IYzuFbmqXWiC88w3vxqVUkgkvgdzmkwCN4OBsitdusyj2/rIw
         f2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHgrix3iG2rGl/Kz/tIRYXLp65IqS6194RJYQ/vrsFwUvrennDaD3Gm7EvAdjpZqrJyMdIn1Pu8KRe+MZaPEft9eBbAsufPm/NEphneoKAHm/jHGs0p3k0nSpG2Y1XgayHzabA
X-Gm-Message-State: AOJu0YzHkevp8NBeMX7EP/WmVdiRPtM92MC2CcX5A7FS6GVsKv6oYWat
	Jf1nQHnay2TeXi+u7nRcJU3syTIj3SNoRwNC4rlTKcL9JsPIUTRx
X-Google-Smtp-Source: AGHT+IErtp2nV7mcKdqRo+jq1OWZkiMk/4riy2CBgl5T4ICW2MsRDn+iJIiWgWyWac4RMpk9UBQ8Xg==
X-Received: by 2002:a05:651c:33a:b0:2d8:6561:72ca with SMTP id b26-20020a05651c033a00b002d8656172camr2074103ljp.19.1712945049992;
        Fri, 12 Apr 2024 11:04:09 -0700 (PDT)
Received: from localhost ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id g20-20020a05651c079400b002d86998c8f6sm570047lje.88.2024.04.12.11.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:04:09 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: stmmac: Move MAC caps init to phylink MAC caps getter
Date: Fri, 12 Apr 2024 21:03:17 +0300
Message-ID: <20240412180340.7965-5-fancer.lancer@gmail.com>
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

After a set of fixes the stmmac_phy_setup() and stmmac_reinit_queues()
method have turned to having some duplicated code. Let's get rid from the
duplication by moving the MAC-capabilities initialization to the PHYLINK
MAC-capabilities getter. The getter is called during each network device
interface open/close cycle. So the MAC-capabilities will be initialized in
normal device functioning and in case of the Tx/Rx queues
re-initialization as the original code semantics implies.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c6fb14b5555..cb72dd93191e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
 			priv->pause, tx_cnt);
 }
 
+static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
+					 phy_interface_t interface)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	/* Get the MAC-specific capabilities */
+	stmmac_mac_phylink_get_caps(priv);
+
+	config->mac_capabilities = priv->hw->link.caps;
+
+	if (priv->plat->max_speed)
+		phylink_limit_mac_speed(config, priv->plat->max_speed);
+
+	return config->mac_capabilities;
+}
+
 static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
@@ -1105,6 +1121,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
+	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
@@ -1204,7 +1221,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
 	struct phylink *phylink;
-	int max_speed;
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
@@ -1225,15 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	/* Get the MAC specific capabilities */
-	stmmac_mac_phylink_get_caps(priv);
-
-	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
@@ -7327,7 +7334,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret = 0, i;
-	int max_speed;
 
 	if (netif_running(dev))
 		stmmac_release(dev);
@@ -7341,14 +7347,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
-	stmmac_mac_phylink_get_caps(priv);
-
-	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.43.0


