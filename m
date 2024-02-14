Return-Path: <linux-kernel+bounces-66107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D6855702
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD058B28328
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2413F006;
	Wed, 14 Feb 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uP0qoXg4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3513F008;
	Wed, 14 Feb 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952445; cv=none; b=PAa4BgPpOQ6a5Vv25Szp7k2fwBlPSullYdSdv2aPg6m5hw4PUA+jCHjnBukq6ZUuCoqcYTVX8hnii76XJnGoaUDEC7zERh9IBwQYdf0FMB2UNgoe+N5BOtLP+3qU8ADg+3Hryem9hbJlVcQXRk2SQqQojopbNrNaojy0+5BAc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952445; c=relaxed/simple;
	bh=F0mfdZrj/FgaIdcQuHDCEsazFz0S4bAcsGtKqN8CFVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOkCNVGJp+GiWZYaGesJPcAaCLylKupCiJZOU7rCOGEMGbB2yK+LAYyj9tmLmSdvXLmjXy3xMwJ5AQkcT7wD2BHO9pIMbcfqwTcSfomG7w4ikACTAQDQAyExoLY++GH+r3XYHPU2L5Sf60g4parJHZ1BKBSdQVY+FGgVYQ/1lXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uP0qoXg4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cy2kGO2U2TPr1pnz3CApIMBYaE8Xib0u+l8VUL1Ic70=; b=uP
	0qoXg4dx5oMZc0Iv6uyhdgoe9Ru9lQnFBArmstvh6Ryh545tHEHsdaY3ugqKteu7Y1IOCXWMp9rgO
	GgdqlDrQ6q11AmTyzf0j5+alk0NHrVjEKz5z73x5x+bXLrUNPYPLNS194Z6nFiWY9Pa40aG/QSQYy
	6fYdFNkbXS9dGmU=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOS0-007pqx-Dd; Thu, 15 Feb 2024 00:14:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:18 -0600
Subject: [PATCH net-next v2 1/8] net: usb: r8152: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-1-4ac534b83d66@lunn.ch>
References: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
In-Reply-To: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=F0mfdZrj/FgaIdcQuHDCEsazFz0S4bAcsGtKqN8CFVA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkjfDOiT7wmdGuQ6MHVBZSDeJjy+AriB0xgA
 Q20DCz14HaJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JIwAKCRDmvw3LpmlM
 hC+QD/41sRM9msf8/LaoNjawjEnqaKsUrkZRMAvhFdGWnakR1s85yBU4WSovRcxZgqZcvQpT5Uz
 t/lrAFTqQmkF+hwXQfIO70vA7rMKPQlwYHwo9LeCjPDLzToxyS/Ra0X7IL4B1xL4QkF6Ur64AlG
 lULMuLf+N4ZLMAOS49qCoy4hGhF0SYABPcNWPUisiTIB5DVCUfLXjftf4N920mW4S2bujFV2tHm
 PLaK+OPgTS+KQC+h8QT/2NtGOeQYkXmTXOt1+hTe2ub1l10aaK0+g9aXZ/43OJ4to5IPmVlFb9f
 W5+bd1Ty90uUqbRJgtAYWI8g3g3HNIRUCa+ULq6gupZjpiI6TT02lOKzIxE0J5ZWjz5jRm5+C3c
 yQ/iwHjvbYEtIdDVB3K+QRFuqMbZQ7c6soKqXblCCsUq/P/eIa0WInxJLiBy5Dm//ULswC9eoIn
 ouOtWo8WmLFtiHNXTUk6Ir1u0qhKxNniIdGuo4/5Aq/itlC0VNEuiDobO+m6GTo/Y1IbSeFjK8c
 r4JxtIvEirQgNc+Jab0LMkkztvc2uzi8JOcxbEn/mhYmc2iXI6cfZsOf5HTiWfTXI79VUnTJAKe
 sDO2P4elnZ6tOVyWiYqp0xRrS/mLpyTSNyFxMHt8Q2vMEGb6uVYqmFdPgwn3FtcoSyDXDH+yV0a
 GBSR1XKBtcAxH+A==
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
 drivers/net/usb/r8152.c | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

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
index 3d806b3ff425..fa5e9b7f3bb4 100644
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
@@ -8924,23 +8925,22 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
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


