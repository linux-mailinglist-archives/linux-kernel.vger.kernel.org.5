Return-Path: <linux-kernel+bounces-82524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38D8685D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8701FB21A23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553A12B79;
	Tue, 27 Feb 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Swerx0G6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCC5C96;
	Tue, 27 Feb 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997387; cv=none; b=mmNDfAwhdApmqBN45J9bZSPbFvhGTOnChQwYsga/66Td/ICsXrb3+63SP/D/F94OwcEtxGkWh873q8MBDHV+2NpLsZ0Osa/T79PQrxYWlHnJt/RkN6GvGVgaS7JjYOBA/2v9kA0Q3FPKSLFtOuxB8cBPuphwIjhTcf8uBAOzmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997387; c=relaxed/simple;
	bh=n7KfKlNsBYdc2g7FNM0n6Q/PGUf1/ncJ+o7X6b7qkV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYylP8j4tQS1enP/uvh7sPzvVPzK43CEj6jXGICHcL8NnQzh3ztdfGOGuyvFF2J/JPRd0nBBSGUEAtM4Lri0BvzirtCCjNZtkgMPxoDHHpGi4pFWIjRn3F/gJMIirHve821dxeSKEXwbjX9yOaYJ9ajEMaQgBbG10waRCHbrrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Swerx0G6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zpy9vbBSw1Tk3nbAyfJ7JT6iwuk27LQXKHWZXYNnPtQ=; b=Sw
	erx0G6JfQ3aYVj5RFtMpyGbT27JcvCaw/nw+ACk23xn9Jh4RgYEwzUyNwIRIpROspmgUcl855jiSg
	5h1xSHtva7ASt7UsFu6wNiWQ6ioPrE6EOwwgVmfUCG3aLxwT20GlwPgXaDErKCgx/+N0hB+QKK7Aw
	8T68kB9ZdpQWJcU=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remI5-008mef-0w; Tue, 27 Feb 2024 02:29:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 26 Feb 2024 19:29:07 -0600
Subject: [PATCH net-next v5 1/9] net: usb: r8152: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-keee-u32-cleanup-v5-1-9e7323c41c38@lunn.ch>
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
In-Reply-To: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3813; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=n7KfKlNsBYdc2g7FNM0n6Q/PGUf1/ncJ+o7X6b7qkV0=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tr1xHyCpzaQdb/ipZ49qz9WLcw33+M7s8v0p
 TsSq7zXhFyJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd069QAKCRDmvw3LpmlM
 hG81D/46mRrR59p9YrJI2LJuGQ32YqfFXObTrgKuhlO0xKCMp9VKuUfNMn/vok/u0iBOa3rg4vy
 04iMZBuxpZEXB1Na8LijP5GFzTX0hSvuIM60lh4mYjeNAvN8pxEZyZ3OJRD3ol8jfcnxS03XLju
 2vvEGLS/dodcwT2B/VWckjmQ31emxY+4196wLh4P1BOLbP5KMiZfZRNYsk+CUBkt9fKVvUu1Lzd
 m0LnJUwZMis42gbxSXziWEEqt8UbdHtyltxZ3kruCUN73NsQAMtkrEHcr1KBes5wANNwrEfiPpj
 pARCelDdI4sxdujTHjwxsKixFTUVS//lanz20ob092628FKK2500Vspmbnp0kT1xmzIbj2uhf9v
 ytx6BYMu7KNmuKep4qWINiGq+By72JbvaNcpy9wWj4cHdJqueS5YaJ32zp4CQpabskwBrVj6hMK
 ChX0GMSh2ZxT71XHFdvQBChP5iwd16pC4sFC/765ssXnajIDPlD8AjMu613KjwmahV1OQ6CAk6H
 2cmzkuzHTJlxZHgiLANQ/u/G51f/6hQ35ORbbJvZCy+B86b2ZdeqD+fYcjuO4hQGTMhQneH841l
 waJ5vboYI65ni4uV/uNYDPA6jQnAlgbR0KHoG3UwpCO587AyYkp+qMUvVxEWMo1NWWi6irPo2T8
 M7BejpKOv55Kp6w==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Rework determining if EEE is active to make is similar as to how
phylib decides, and make use of a phylib helper to validate if EEE is
valid in for the current link mode. This then requires that PHYLIB is
selected.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/Kconfig |  1 +
 drivers/net/usb/r8152.c | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 3fd7dccf0f9c..3c360d4f0635 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -99,6 +99,7 @@ config USB_RTL8150
 config USB_RTL8152
 	tristate "Realtek RTL8152/RTL8153 Based USB Ethernet Adapters"
 	select MII
+	select PHYLIB
 	select CRC32
 	select CRYPTO
 	select CRYPTO_HASH
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3d806b3ff425..6d0dc2c967c4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
@@ -8924,30 +8925,29 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
 
 	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->advertised, val);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
 	eee->eee_enabled = tp->eee_en;
-	eee->eee_active = !!(supported & adv & lp);
-	eee->supported_u32 = supported;
-	eee->advertised_u32 = tp->eee_adv;
-	eee->lp_advertised_u32 = lp;
+
+	linkmode_and(common, eee->advertised, eee->lp_advertised);
+	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
 
 	return 0;
 }
 
 static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u16 val = ethtool_adv_to_mmd_eee_adv_t(eee->advertised_u32);
+	u16 val = linkmode_to_mii_eee_cap1_t(eee->advertised);
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
@@ -8959,23 +8959,22 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
 
 	val = ocp_reg_read(tp, OCP_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
 
 	val = ocp_reg_read(tp, OCP_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->advertised, val);
 
 	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
 	eee->eee_enabled = tp->eee_en;
-	eee->eee_active = !!(supported & adv & lp);
-	eee->supported_u32 = supported;
-	eee->advertised_u32 = tp->eee_adv;
-	eee->lp_advertised_u32 = lp;
+
+	linkmode_and(common, eee->advertised, eee->lp_advertised);
+	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
 
 	return 0;
 }

-- 
2.43.0


