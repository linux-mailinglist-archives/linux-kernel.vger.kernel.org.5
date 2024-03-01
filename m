Return-Path: <linux-kernel+bounces-89189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4086EBBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1642877C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA25D8E5;
	Fri,  1 Mar 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NehbFsZU"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284ED5D48F;
	Fri,  1 Mar 2024 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331501; cv=none; b=uiZCBtwkZb2JbViljwaWkgjZlRoaaICZ2n2pX8KDvT+uGzuE35MfckCQHW/nAGCLsABMqDJ/6neAcVf9z/rWJbrCKd7DQ9X1GMPeH6jgeUX2r69fLoCwdcDrOgnnoKKZ8Jhm2rYYNHlsijYi9hncSaG37IP28JdxoF5L5CIsK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331501; c=relaxed/simple;
	bh=g7oHv0s8fzKVC6d0N1BA5pGhmCqS8rRs+SghD8JRZvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwdurPHizj2rlAN8EYYNyZibxEcUPCd7nagrt+EhrxUwQ9K//xT7GLcP+7LThh6OrN/Y6U2xE0gokK8CuLBQPraXgOswakS4NeHMKwdiotGTQMQdbIrr5HsFMKxFpWKSyZ+7CQ9svPOzT5eWUUkMSkd2zZbZsTu09i2CYAGn01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NehbFsZU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a441d7c6125so336604866b.2;
        Fri, 01 Mar 2024 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331498; x=1709936298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkTG3Clv94c5jYZKV1oVVIC0KyY9HhflvF0/nRm9lOY=;
        b=NehbFsZU2M0hsTtx4+/xQg1CyyOWFlTaYzXnUAqH8MfpYuknMCXSbtdefLz8T/1rIY
         4JpJbhKwgolOV7yq9KGg355p1//NbBESlty9QoKgC17zUo/Eu50jDjDpAV/lAypRwCi9
         wRr5altodj1qW77ikfJYykefjFHJywvWMwS6HoT54+tDZrbFL30fFX9rwWFT/GAdKiEw
         mbocO+/OSiOYTDp7YrdbaEik4toQpqu5dn1FXnDMDQLEA5vDlZZi6McBvjDRrTzsRwbY
         yyh0sKTmM6hLM9d0xi9l2dO6c31iTbAnG09oMnIrVQDIJEvnvaSrDx/j98VpCeXJCPtj
         AEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331498; x=1709936298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkTG3Clv94c5jYZKV1oVVIC0KyY9HhflvF0/nRm9lOY=;
        b=RL9xI21+F6v3E7h6KJWmyxqPw8N/3A5gck7p4hqQnnhttpCBXOG98m+BHA14sM+guO
         cDAv5XGCu6puaL7cdjMSTyCgG8dc//Q75mLwzSXMGHTsoU3M2MJqgenmfeooThv8lWaq
         W5E84eEB2idmXUjrxzEXB3kQ99LiB7uGVrrehWRKp37dVlKPzd86K+zMKRce456NKpjt
         DNNPk5PsqCtRyuw9sWph1LGDNdUvUfhHIEDlc+8dM9NpXWJ+Crt+86rNYTPH6Iu1T35U
         NXTkDCr4ijU9253Fb5hpVvVqm+/dIgxaSYDvTL0mTf0LKvRoSy5gLx+wEUjLyH2XcpPd
         EMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVm8GEo80D40TMKDD91xwlBDyg6PXll0Wq96cf0uJtnyQ+7LJAVfsURrNSvHe3TqIYdWfFxXScKUDYfxFuqTQxZLtXqmIdacZW2dNkz
X-Gm-Message-State: AOJu0Yw3msZFF6r61ZMFqqlg50qZaBMo0FkEykvoN6tRhx2jD9j7zhYo
	L2f70XblQn0L4pUAIBWOiiXBb6990tQNgF3VVgw/WDeKefxXIJ19R/oZBNpvvME=
X-Google-Smtp-Source: AGHT+IESrcMRRWXLYvt/ribQa5+MCWl2l4GozwmwYt1/MCZAr4GZzDulerJHihxnr2j1nm3v4n/CpQ==
X-Received: by 2002:a17:906:5fd6:b0:a3f:a009:690 with SMTP id k22-20020a1709065fd600b00a3fa0090690mr2229223ejv.14.1709331498275;
        Fri, 01 Mar 2024 14:18:18 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:18:17 -0800 (PST)
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
Subject: [PATCH net-next v6 13/16] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Fri,  1 Mar 2024 23:16:35 +0100
Message-Id: <20240301221641.159542-14-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 39 ++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

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
index c643f445f026..f8175a33c0a6 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -592,7 +592,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
@@ -683,7 +683,7 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -752,6 +752,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
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
@@ -1554,6 +1560,33 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
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
+		vsc73xx_vlan_change_untagged(vsc, port, vid, true,
+					     operate_on_storage);
+	if (pvid)
+		vsc73xx_vlan_change_pvid(vsc, port, vid, true,
+					 operate_on_storage);
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
 	struct vsc73xx *vsc = ds->priv;
@@ -1695,6 +1728,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


