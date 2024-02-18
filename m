Return-Path: <linux-kernel+bounces-70447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC738597F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427322817D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125C6EB6A;
	Sun, 18 Feb 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y0gADhJ2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48B6EB42;
	Sun, 18 Feb 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276045; cv=none; b=ezAJuar3fD0dpOZDD+bIM5O3IHljQCGoo8u+LrdH2P/0sLOL0Nbf96JSlqJp/mUBMgWbl9C1oR8zf3b3dQUiNn4yNUHsi6mYAgx6te/E1lt2ATYNrh0Y4b3ZWH1F7GJv7b1okQ9OhkwbK+z7Vab9vBMuD6Xz7SvnW65AmOn6cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276045; c=relaxed/simple;
	bh=z58vyTAiVnpmwvSd4SKmRIwa1d8hKd2eZxCGc/JbUCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hdr8rwM0qSsrpCL/IYh8GlidHEWTjl4nn09JWMWxPLey8PPWi1coXoFEl9qvQHTCrwuqiwnLQxEiUXeT5tzqz4MedYE6N99ghjrJ1iBZpjUNOV7XGf96Ph0X5cPp3xXvHx54BRBDnoPtA9S0QdztF7sn5iDlbv2EV8prMQHyMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y0gADhJ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ITSb7tuO3rZ7WMe+oWG0eu6CGb3PGXPtHfF5HKSz74c=; b=y0
	gADhJ2nD+VD9ntRO9+pSVxVJihJK4ztWvpbQT+YUmhgc27/lQ9rjQQphUj3hxL+PJCuNIKPdzKbi1
	rUGnm4R/3Hwqk2iC8ixQgLaBYjUlLK4FC9qTGSAuRJ8dYRYn1MHx4jXwVArH0FGXI1UHYkmaGIN8U
	VXZgplhxfv6RcXE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkdb-0088HX-KK; Sun, 18 Feb 2024 18:07:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 18 Feb 2024 11:06:58 -0600
Subject: [PATCH net-next v4 1/9] net: usb: r8152: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-keee-u32-cleanup-v4-1-71f13b7c3e60@lunn.ch>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
In-Reply-To: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3767; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=z58vyTAiVnpmwvSd4SKmRIwa1d8hKd2eZxCGc/JbUCY=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jk+HKMQyW8jTLx8fFX5+cCFso8ByjcOJIMo6
 4/TbkAqzP6JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5PgAKCRDmvw3LpmlM
 hDhsD/0VZtueu7oG2OuUQZRxFFuP7MW5xydhYoEO8SwuZpie8b6OSGQMWIdzj32QN4FH2nHITYu
 mBIzCn8TTC3uKWKLeLdnxXKawDjdK40k68UuFMwQe/8OKy1c9aYg4932yAeofhFVbVPxc3vjlC1
 ObWYqjERxRibMJ1tFLRWVN7I3t8MmRUtqp1JFI68QsbAGVDqhlrZ49Sjqqz4LGXx3UTHhzawCmj
 MN5uFD6TMjqPQgs7J06udrzQS4N9CcvCJxDdMCY5QlA6V4F9jUhHZbBpDk+c21z+M5vKlgFtXSB
 NAG+ExOmAuZbpl9RedvuvryPHgHRMVJ9Qo3yeuGwcbE6hbt7pyIFR8EI/YUkQuZ4f8i7XmRqtyZ
 tLlUa6/t+0yzBnVj9+J8/i4BLc0b4C2Unsc6+OdBZhatd8k+G0z2LgraMf8Abm3J4f8BoVBKbE3
 XWBRqSCqAs8qlfaWdSxUViw/D9VIm/saVr8iGOSb17ngu8IIfJopzk1JYfGPisTASYr5YgByBxc
 hjM5KMVxnEmCHpHKfOaLzv8+ZFrM7OCYdjMik9m8JF1FTrloC+ePsvFagnx+zh7Nn68fvW8YDQK
 BxtVSjnGegqvMFIcPtDuYOuz4ygcL0M5qc8lQq6Db3uX4zTVV8bUiUuEMy4BnRZLrIWSDNseCbV
 Uaczba5fABF/EtQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Rework determining if EEE is active to make is similar as to how
phylib decides, and make use of a phylib helper to validate if EEE is
valid in for the current link mode. This then requires that PHYLIB is
selected.

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


