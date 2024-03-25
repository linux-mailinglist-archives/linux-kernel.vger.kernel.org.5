Return-Path: <linux-kernel+bounces-117975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07B88B1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161CE1F3FE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CB84D1A;
	Mon, 25 Mar 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlRsSQTf"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62484A31;
	Mon, 25 Mar 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399528; cv=none; b=GnDdoxTn/zCZSFWhsuznGNctW5Hi0gC11swdJH+DX1NicolB4gunYCV3H6l9jD13W1qz5dbipyQNjsEY6bmaKHwZoZEt5y7GPAC7RvjoUVBIAOLc0uBrkMGCeNIBx/+p84CfBBGa5jJlPu/svaMvbLGr1zoh2YvGtUobdV38ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399528; c=relaxed/simple;
	bh=rgoixMAwGv72yjDjsqhIZ3P7MKK154c00Eqetsmo3dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRyQY+hNX1nZEuJIExAe6fjOQD0bgq3mrrouCtdi16NQ/J1Z/bgkXg6TSU+5ZYv1I53XhhOOqFAICs3HCOwu+HMbeEjN7LgN1O9BECNt3R5e+1GjEFmU6FUPbee+KDlieHECLfISqRpRhid5uOno+CdIqtqdX836Ru5wSYdSlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlRsSQTf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso5569511a12.2;
        Mon, 25 Mar 2024 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399525; x=1712004325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ln71Alhu87Jqe+kyFPpkWr0ICct1vn7MAEQLlK4m0s=;
        b=UlRsSQTfO7GtdfDmUoBhQ/c4j66KK6hAFhpbIE+AXMB+11BY9yi2xyIRYaGzZx0n9s
         tFYp/O689yK3lnR6Q6L414jigiMU/TA4CHbYxUQHNimx9TFDo/BnUYzblOz9J3TmQshP
         OxMwtV/Pmnq9svZ+D5WBc4QaxN4sBHhCvw/TcOClLrXsCKFwifh1A4qTUeHPCFQ7uMos
         NrcJ0QZYzs9NqltmZ3IF8ZbfcsTanwIvCjfNs+isUCQIVDveERiuakJpUMwP0tNXf1PH
         TrYJh8kClCLPUW9pYkuTSCSDLzJ9JZ6fWnj3XNikRG3/xMhV0a+WqOXV0TZL/PCDm8gb
         8n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399525; x=1712004325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ln71Alhu87Jqe+kyFPpkWr0ICct1vn7MAEQLlK4m0s=;
        b=PtXCVrUuNCEVKFmstAYNwuus7EKJS59G4HCst+RfkTRLUXl+OZ1iNlLKuKO5QmRnWj
         TSR1TKykkJ9SMt7p2XB58GdL5z8Lalq93s9GmRW+ulIL51Y0eV+XC4ktjuvxHnozVZJV
         M0wl8gcpxb/2K3NBE4hDJrFzCu1waZW5Grh7TA/rzVFd1q5ACcwMsI/QoUfkxSPIW58T
         O44Vsz0nBeOOz1JZUjy5Qx/pF2sNAdz3Hlq6gpiu6iWwNQuUyDERQ+PEwQt/5MuojcKz
         Z4qc9h2cxQNJIDhGQj7CQ9cGnlEc1m/MSF61WBJMduaiKcOjWI6AkgUYrVYLZ5NGdtOB
         axtw==
X-Forwarded-Encrypted: i=1; AJvYcCUdxl3+s8iJ/kz32ZWgtn+b8yX2jn0LTUuoFYo2zybznqX+rjnCw5NX8f7FFeVQsIND6DHHhvZtaiCr2KHlY/oxVyyHYWxwE4DzykFW
X-Gm-Message-State: AOJu0YxD7TrgienyOgSmJyBS/LF3N9YABhlJa+27cmKwWHEJsuJQiDAs
	7mL7CyeJCLGi6anZJJAvvKPw7MU6VeC5QIS4CIBFQyjZw7mJYasfSue7auRnVC8=
X-Google-Smtp-Source: AGHT+IFXMlXExNMnpgypW6EAl6Kz6e98neRXoVSfBxSKu1ouwdZ3ATgnzFtu6nkEkMbVDxhR0L/COg==
X-Received: by 2002:a50:bb6d:0:b0:566:4aa9:7143 with SMTP id y100-20020a50bb6d000000b005664aa97143mr5814927ede.14.1711399525225;
        Mon, 25 Mar 2024 13:45:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:24 -0700 (PDT)
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
Subject: [PATCH net-next v7 13/16] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Mon, 25 Mar 2024 21:43:38 +0100
Message-Id: <20240325204344.2298241-14-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
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
index 833e4e50e737..9d678414f3ca 100644
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


