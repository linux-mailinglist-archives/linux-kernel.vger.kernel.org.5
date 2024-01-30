Return-Path: <linux-kernel+bounces-45460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D14843101
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4194FB24F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B884A21;
	Tue, 30 Jan 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwD682Hj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417F83CCE;
	Tue, 30 Jan 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656483; cv=none; b=WmkShpTcfftnQXYeZt4ZPF4oGCx/kHjH73mA3BqSqWJmY4iHd5eFeAfO8fq0kFglsKkzhoK+dbDknQfsdj9V34DajRkQOKwES/g592U9yiSBzQJlOzlfcRSaa5Ix3sbQPkweOwPaCAGRYbwpE0yjiJgJgFeda89ISRRy847heeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656483; c=relaxed/simple;
	bh=biU4n9JkMdJOmAVA0wTiIfvmyySAO8kYaLwtX8a899w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGsDlSTtWiIo5Q18E0ffbUGkcE6f3o1pv/sU+0rt4SIatXwpLEvw9aJynWDRGnLmkO7BTxkVE93pdeljse2LsydIWDWca8qb3VyHfHR2EgZ5arzX8wZrjicgpNUajyqE8Oz4QrU7q0g5wUn4NvHsEXCYvIEzvWhZhUg+jr7kCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwD682Hj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d8f3acc758so2301355ad.1;
        Tue, 30 Jan 2024 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656481; x=1707261281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAPqHzvNNOM7nTx+K7TaD2P+YhLDDwChHGAOyG76qvs=;
        b=mwD682Hjx0vluwysxYgXVmDwuxQoJUuNjV4ZOLP9HDCRNGriNJ4yF7gRKAUvdyElC+
         8xvovMsC45CFQmcvtIIfopSX8LGPdnysZ3JWCWfJVbnVC3RXmjflK1iBydzqh6lu4Rvq
         DLnM5q8MGVHNrAdEjkTz80Mziv601x4uiuH1x7mwtrFqrQzhA1mOVFtoPuuYydn19eEA
         dN25Gj2VF2CbkqCN+Tig8SqtI7gM4g4sw1WRkkRtdYLFvD3H3jwzU8BswkXWa/FByjpo
         m+VpNJADPHhpLCCN5Xwg9R3+v0C2UtpaSsMLfIZSzkndDeaU+sAQSO8OMeLa+HVrvDcZ
         qnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656481; x=1707261281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAPqHzvNNOM7nTx+K7TaD2P+YhLDDwChHGAOyG76qvs=;
        b=hSX4kvhQjmlnUjYZymC6exJFrhPw1MDcnbY9RMUnbE4JasXuzUlCEWpULXjAUZrY1h
         SaLC3DQIY5XYGylIS+A+D5AZ0Y3z8mfQzXH+qwv3XmQUQ8qhbv3+aAqve9hpfVu6gThz
         PntXEQ6IfYVYojUgOKRmw50qqYHJ9Br77xgCDmJXIAH7zQ6wBbi8Qdjn1t8VNTIxodjc
         LlA/7/qe3Jnyj6lHeaoozMnL+wrFrICOJisN3tqkIWyo32X10EZ2BX+6iI+JZGjg4XSH
         bxdUo5DglYzFminbymPAmMymK8pb6bmbA84de38BRfoako65kiIMhABTM7qJKsJYfKmP
         z19g==
X-Gm-Message-State: AOJu0YxM9+lluim9El293M87DELeY2s6/YK5/5ezyUp8IhFF+0Yd+WXH
	E0vtvZXfifvPHDUpV+1cFQuGMc7HmnY2NqNpzmNHa2CeBbqmQtJJ
X-Google-Smtp-Source: AGHT+IGf7aCaggewYjz7Y5m1+498l+aYohnS4dn/hsN+lq1fWGCAnJJbp2Vlk5kOyJvEZ52Q/AFDdA==
X-Received: by 2002:a17:902:d50e:b0:1d7:836d:7b3f with SMTP id b14-20020a170902d50e00b001d7836d7b3fmr3220325plg.9.1706656480889;
        Tue, 30 Jan 2024 15:14:40 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:40 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:29 -0300
Subject: [PATCH net-next v5 10/11] net: dsa: realtek: use the same mii bus
 driver for both interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-10-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9984; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=biU4n9JkMdJOmAVA0wTiIfvmyySAO8kYaLwtX8a899w=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKxjbzK02XBcQpG9ZkOqE5h3DZFU4R6hfZum
 XPH5FNdJwOJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsQAKCRC7Edu60Qc7
 VuDqCACs/xP1vRR5xd2BrmSNhv/s271S4XA7P5YQ5/MJIIN2iEwZA1A4G0xtH8wtcr+NRx6JLGo
 sAuYT62NMnp2V+h2OuZlTLiJzGzguQAZd3cO1RpEl5NcrDtCqPxIR9cqIDB+GO3pL5Le7QXnyHQ
 KUWXE7xrklWzJkPaHsNcA5YHcw/5s4l0y3tKrIP19e/WxJbb2BCADmlF9HBlZzt1W5v5bpGW9nk
 l6aXyC86wC449+LcfBlGDGDopIonyd5p6DMe7irgLAsv46U72Sk/ETdMOL8Mpro5Jgv7GETFGtk
 JoBmdjXlF3Ug7GQ10sBxd6Uzno1N+C9SL8D58tS8DqXkWCcj
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The realtek-mdio will now use this driver instead of the generic DSA
driver ("dsa user smi"), which should not be used with OF[1].

With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
no longer necessary. Now, the realtek_variant.ds_ops can be used
directly.

The realtek_priv.setup_interface() has been removed as we can directly
call the new common function.

[1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  1 -
 drivers/net/dsa/realtek/realtek-smi.c  |  2 --
 drivers/net/dsa/realtek/realtek.h      |  5 +---
 drivers/net/dsa/realtek/rtl8365mb.c    | 49 ++++----------------------------
 drivers/net/dsa/realtek/rtl8366rb.c    | 52 ++++------------------------------
 drivers/net/dsa/realtek/rtl83xx.c      |  2 +-
 6 files changed, 14 insertions(+), 97 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 45d9ef43fe3d..1ae31575d096 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -131,7 +131,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->bus = mdiodev->bus;
 	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
-	priv->ds_ops = priv->variant->ds_ops_mdio;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 4d35621b5583..c075770c6986 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -348,8 +348,6 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = rtl83xx_setup_user_mdio;
-	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e9e28b189509..864bb9a88f14 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -62,7 +62,6 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
-	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
@@ -73,7 +72,6 @@ struct realtek_priv {
 	struct rtl8366_mib_counter *mib_counters;
 
 	const struct realtek_ops *ops;
-	int			(*setup_interface)(struct dsa_switch *ds);
 	int			(*write_reg_noack)(void *ctx, u32 addr, u32 data);
 
 	int			vlan_enabled;
@@ -115,8 +113,7 @@ struct realtek_ops {
 };
 
 struct realtek_variant {
-	const struct dsa_switch_ops *ds_ops_smi;
-	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct dsa_switch_ops *ds_ops;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 60f826a5a00a..778a962727ab 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return 0;
 }
 
-static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8365mb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static const struct rtl8365mb_extint *
 rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
 {
@@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			goto out_teardown_irq;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		goto out_teardown_irq;
 	}
 
 	/* Start statistics counter polling */
@@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
-	.get_tag_protocol = rtl8365mb_get_tag_protocol,
-	.change_tag_protocol = rtl8365mb_change_tag_protocol,
-	.setup = rtl8365mb_setup,
-	.teardown = rtl8365mb_teardown,
-	.phylink_get_caps = rtl8365mb_phylink_get_caps,
-	.phylink_mac_config = rtl8365mb_phylink_mac_config,
-	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
-	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.port_stp_state_set = rtl8365mb_port_stp_state_set,
-	.get_strings = rtl8365mb_get_strings,
-	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
-	.get_sset_count = rtl8365mb_get_sset_count,
-	.get_eth_phy_stats = rtl8365mb_get_phy_stats,
-	.get_eth_mac_stats = rtl8365mb_get_mac_stats,
-	.get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
-	.get_stats64 = rtl8365mb_get_stats64,
-	.port_change_mtu = rtl8365mb_port_change_mtu,
-	.port_max_mtu = rtl8365mb_port_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
 	.phylink_mac_config = rtl8365mb_phylink_mac_config,
 	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
 	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.phy_read = rtl8365mb_dsa_phy_read,
-	.phy_write = rtl8365mb_dsa_phy_write,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
@@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 };
 
 const struct realtek_variant rtl8365mb_variant = {
-	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
+	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index a0c365325b4a..54eff9cd0c03 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1033,12 +1033,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			return -ENODEV;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1785,17 +1783,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return ret;
 }
 
-static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8366rb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static int rtl8366rb_reset_chip(struct realtek_priv *priv)
 {
 	int timeout = 10;
@@ -1861,35 +1848,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
-	.get_tag_protocol = rtl8366_get_tag_protocol,
-	.setup = rtl8366rb_setup,
-	.phylink_get_caps = rtl8366rb_phylink_get_caps,
-	.phylink_mac_link_up = rtl8366rb_mac_link_up,
-	.phylink_mac_link_down = rtl8366rb_mac_link_down,
-	.get_strings = rtl8366_get_strings,
-	.get_ethtool_stats = rtl8366_get_ethtool_stats,
-	.get_sset_count = rtl8366_get_sset_count,
-	.port_bridge_join = rtl8366rb_port_bridge_join,
-	.port_bridge_leave = rtl8366rb_port_bridge_leave,
-	.port_vlan_filtering = rtl8366rb_vlan_filtering,
-	.port_vlan_add = rtl8366_vlan_add,
-	.port_vlan_del = rtl8366_vlan_del,
-	.port_enable = rtl8366rb_port_enable,
-	.port_disable = rtl8366rb_port_disable,
-	.port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
-	.port_bridge_flags = rtl8366rb_port_bridge_flags,
-	.port_stp_state_set = rtl8366rb_port_stp_state_set,
-	.port_fast_age = rtl8366rb_port_fast_age,
-	.port_change_mtu = rtl8366rb_change_mtu,
-	.port_max_mtu = rtl8366rb_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
-	.phy_read = rtl8366rb_dsa_phy_read,
-	.phy_write = rtl8366rb_dsa_phy_write,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
@@ -1928,8 +1889,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 };
 
 const struct realtek_variant rtl8366rb_variant = {
-	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
+	.ds_ops = &rtl8366rb_switch_ops,
 	.ops = &rtl8366rb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index f05fe6efe5a4..aa998e15c42b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -232,7 +232,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 
 	priv->ds->priv = priv;
 	priv->ds->dev = priv->dev;
-	priv->ds->ops = priv->ds_ops;
+	priv->ds->ops = priv->variant->ds_ops;
 	priv->ds->num_ports = priv->num_ports;
 
 	ret = dsa_register_switch(priv->ds);

-- 
2.43.0


