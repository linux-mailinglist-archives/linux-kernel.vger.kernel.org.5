Return-Path: <linux-kernel+bounces-76338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C285F5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF71F26CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F8405DF;
	Thu, 22 Feb 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EIckSPvn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B592B9BF;
	Thu, 22 Feb 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597890; cv=none; b=KyLF2jsPxO1dit6QWOakN2Rw/nGSXloo2bUhHZNQKGmrpmCHidG/z6UGsDVtLIW3kkD0WcMzk1+s+H3LsfRV5B1VZ2bSY7AD2VfF1GeeErbKVAm1Kk38WIdXv//mDc6vEXDGNT4y5PmmmbCvadUoW/9P6Ze1i+OuRWxR+91hJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597890; c=relaxed/simple;
	bh=nuuL7hB4TcvbbVbRfMlIGQCum1S/wpqfTGXfKwhC6NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODeyZRUK2zewiZhBtu2yg0cvX/YhVhRkeZP5DZNf3OIm5UeeJkjwRsO1iXCvUxr1mvXsJsIbSS+TNOwy5jIOrFn49wjsBYb827XKkTDvHdQhbcg+xsFOSVyguyxRG3YGUfJBOT8q+CAKBKdgs26CjI1bkvWePGiGUpzEJAaPmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EIckSPvn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EB47FF80C;
	Thu, 22 Feb 2024 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708597887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMIMzbe/1Q31wGmkXkbGHU+gqkl0OYYUD/vdMXzfwlI=;
	b=EIckSPvnAF4apzAGi9zM1Xd1plUv4izqVFK4ay2waJmIsy7JiybyQEevYh+kNZgkv72wty
	wzG+1z+7WOdLXVQ5B/r1ouTZI7hJ9BYL2+5gE12NFB9uzpQj+XMA+4Op5PfdokhrKc8s/X
	PuHQ11N4IcKU86KeCnVIyAckE0cSf7nZngWC4ySUDFeVKx05E0bH46xkA4p2WWtmmaR3Ef
	nOmTOIxtz1hI4f26PVlGZPARiMbXEF7pHdDV0jifUC/h0Fzur+wLHF+QHsrwGn3/+ygRYK
	3TcKhdF9PVALPSCi0nuPXZqsHUHOzR6rHrRpWeARNdPCrbfT+eAOb6MlG3xyJA==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH net-next 2/3] net: phy: dp83826: Add support for phy-mode configuration
Date: Thu, 22 Feb 2024 11:31:16 +0100
Message-Id: <20240222103117.526955-3-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

The TI DP83826 PHY can operate in either MII mode or RMII mode.
By default, it is configured by straps.
It can also be configured by writing to the bit 5 of register 0x17 - RMII
and Status Register (RCSR).

When phydev->interface is rmii, rmii mode must be enabled, otherwise
mii mode must be set.
This prevents misconfiguration of hw straps.

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 drivers/net/phy/dp83822.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 30f2616ab1c2..2d8275e59dcc 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -100,6 +100,7 @@
 #define DP83822_WOL_CLR_INDICATION BIT(11)
 
 /* RCSR bits */
+#define DP83822_RMII_MODE_EN	BIT(5)
 #define DP83822_RGMII_MODE_EN	BIT(9)
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
@@ -500,6 +501,16 @@ static int dp83826_config_init(struct phy_device *phydev)
 	u16 val, mask;
 	int ret;
 
+	if (phydev->interface == PHY_INTERFACE_MODE_RMII)
+		ret = phy_set_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+				       DP83822_RMII_MODE_EN);
+	else
+		ret = phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+					 DP83822_RMII_MODE_EN);
+
+	if (ret)
+		return ret;
+
 	if (dp83822->cfg_dac_minus != DP83826_CFG_DAC_MINUS_DEFAULT) {
 		val = FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDI_MASK, dp83822->cfg_dac_minus) |
 		      FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDIX_MASK,
-- 
2.34.1


