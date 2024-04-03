Return-Path: <linux-kernel+bounces-129582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D006896CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B32857F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125171494A1;
	Wed,  3 Apr 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcPCyzEM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9C148FF9;
	Wed,  3 Apr 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140714; cv=none; b=bkgUI7PW5pmb3DtY6IxhxK/TavPL8oDbLzAKgJZTrmCqlMU3t9j1ig1pvSX5tPjbolH5BKfzrOGwnlZQGlF/13svQ/EQbpLgCQ0akYYZrJAsjuLQTTmPM952yKq/D2/u3tJtsa//DMPpgGNUkyYyRmsRRU+OIOaIbcu6qgelcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140714; c=relaxed/simple;
	bh=3OB8TQ1rUhMuNxtWAU1N5y3sWwbu3WduaIW8pVqyg/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOCcsoAUOYHY30XoL+mmUvVPp0SWD1TgY7aisTssUa1vqtjjMI5+Qbodx9ajvMvL4jdyzc3XEf76zNKeKvr27DVYhVYHA4AEuxeMcM5LZGkgnq+nUcYk6sDE+Iikh5pULAXxwCNlruh1s6I86w7P3IeU6ex/PvB11wGcD22kyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcPCyzEM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4e62f3e63dso395270266b.0;
        Wed, 03 Apr 2024 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140710; x=1712745510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTbmqZooxysHTZKOHPv1gDt0WmS/83zgiBJ7JzV9ZNU=;
        b=mcPCyzEMpSGWLWI1ON4nX3jTOf+hguhJK3np18mVPMb6CV/I+P73mmnor+Cu62bEnL
         Qi5PyiLwjMaY7tntNqoEobuduRt9BB+HReLjXXGdd2+B1JrOQC1RLLz5C7bSd4+0NhSn
         7XZN4EQUogycR4NEWI8vQRf2WMM3pHXqCtA+nCU4M7lRvxcud1HdmeFYyczuw+wG7kEM
         671yU4XFgyegJ2E7XMyvoAZXGO9URkZxUYN3/fl73mohj2JxBhWbUT90fBjKlJRZcZjh
         W8bFWRxEcNS7fNEW0+auHb4gHghr2WGn7kwM1aTo1hrZkpcXrwtiV3O/iuMgqjqBRe3A
         KXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140710; x=1712745510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTbmqZooxysHTZKOHPv1gDt0WmS/83zgiBJ7JzV9ZNU=;
        b=mNb8Qt9weYcDllriMt1nGPl4DCAHWE1sU8oQEg+Rc4f5yVebdmrYQ18RlTe9e/EL4l
         zK4O2E2tDQpQ9Km4JkOaBYTZSpfYid0lhb6wmNuz6BvgvV0U3Z+y+BUUS1Tt2QaMxUL2
         aQYEW3ep2UcgsoCkz+gUUb/LZBVD4ts/DICSxTlaO8J7PHbUKzkgfTFUf3xLYzN1Mm7s
         1nWktulXbgz6nH5FnwUpUpjzhX8gx1iGXad+uv0zDvf5h/5HcPtKBmy1phmHRrUlLWn4
         LoU8c+4UOC4RaAXuzozvvO0FYYgMSS7LG6xdtxvaZ8LG1o2ErLBI5M5VW+//Xtkz8oDS
         ktBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgcTwHH/b5z+Vx7COdvxCYwPX18/a8bzDJjb1TV8NUOQe8e82B3weyufJuMeuLqfpiyC4PuojQcoDkd7eNPwhWVauAatAT3uZy5s1I
X-Gm-Message-State: AOJu0Yy2FH7BxFcXz8+NkkLV/05z2QhSGX9K9a/aEiuN64p2rPp0TOoa
	6vV4QPsxEGh1a9fAERsvWXIjwZ8jFUtnzkGXklCi7JJOXM1m6Mx/6kkiBwtbW+c=
X-Google-Smtp-Source: AGHT+IGBaVYnTJAnOpcxQSn0tCcmmFQ4MSWJ321680vFf6blh1Hu+HslR3PdtiUjXifOUg4C0s7Oqw==
X-Received: by 2002:a17:906:27c4:b0:a4e:2e14:f75e with SMTP id k4-20020a17090627c400b00a4e2e14f75emr8269752ejc.77.1712140710580;
        Wed, 03 Apr 2024 03:38:30 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:30 -0700 (PDT)
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
Subject: [PATCH net-next v8 13/16] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Wed,  3 Apr 2024 12:37:29 +0200
Message-Id: <20240403103734.3033398-14-paweldembicki@gmail.com>
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

This patch is a simple implementation of 802.1q tagging in the vsc73xx
driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
The VSC73XX family doesn't provide any tag support for external Ethernet
ports.

The only option available is VLAN-based tagging, which requires constant
hardware VLAN filtering. While the VSC73XX family supports provider
bridging, it only supports QinQ without full implementation of 802.1AD.
This means it only allows the doubled 0x8100 TPID.

In the simple port mode, QinQ is enabled to preserve forwarding of
VLAN-tagged frames.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v8:
  - resend only
v7:
  - adjust tag8021q implementation for vlan filtering implementation
    changes
v6:
  - resend only
v5:
  - improve commit message
v4:
  - adjust tag8021q implementation for changed untagged vlan storage
  - minor fixes
v3:
  - Split tagger and tag implementation into separate commits

 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 54 +++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3092b391031a..22a04636d09e 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -126,7 +126,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_VSC73XX_8021Q
 	select FIXED_PHY
 	select VITESSE_PHY
 	select GPIOLIB
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 433ffd4f44fd..d0442ea8a610 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -597,7 +597,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
@@ -687,7 +687,7 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -756,6 +756,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	mdelay(50);
 
+	rtnl_lock();
+	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+	if (ret)
+		return ret;
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
@@ -1210,6 +1216,21 @@ static int vsc73xx_vlan_set_untagged_hw(struct vsc73xx *vsc, int port, u16 vid)
 	return vsc73xx_vlan_change_untagged_hw(vsc, port, vid, true);
 }
 
+static int vsc73xx_vlan_change_untagged_tag_8021q(struct vsc73xx *vsc, int port,
+						  u16 vid, bool valid,
+						  bool operate_on_storage)
+{
+	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
+
+	portinfo->untagged_tag_8021q_configured = valid;
+	portinfo->untagged_tag_8021q = vid;
+
+	if (operate_on_storage)
+		return 0;
+
+	return vsc73xx_vlan_change_untagged_hw(vsc, port, vid, valid);
+}
+
 static int
 vsc73xx_vlan_change_pvid_hw(struct vsc73xx *vsc, int port, u16 vid, bool set)
 {
@@ -1537,6 +1558,33 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+
+	operate_on_storage = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+
+	if (untagged)
+		vsc73xx_vlan_change_untagged_tag_8021q(vsc, port, vid, true,
+						       operate_on_storage);
+	if (pvid)
+		vsc73xx_vlan_change_pvid(vsc, port, vid, true,
+					 operate_on_storage, true);
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, true);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, false);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx_portinfo *portinfo;
@@ -1667,6 +1715,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


