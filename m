Return-Path: <linux-kernel+bounces-51949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC58491CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C671F2116E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDB10A3B;
	Sun,  4 Feb 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="398yUCJr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBEBE65;
	Sun,  4 Feb 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090045; cv=none; b=OlajReUPtrZHsLebx5yioFt0RwyNQ9VQdUJkPmPatExeE5LVhRfj9TfwOTheVUbiquv9kDcgz6Oo1ZMIRaW3utqsqMaDWAKeSsLD7WY5gY5m7iT1ByIiDNZ5v+H2dgE/1d+VtrpdZkP4gUZ8QKXE5yPUd0mWy4zVKvONUS00MVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090045; c=relaxed/simple;
	bh=F0mfdZrj/FgaIdcQuHDCEsazFz0S4bAcsGtKqN8CFVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU4yb8JXgIIcPRKF6cnfLxg+oQUkSrY/9KPvZe1oAMZ9U8pqyQC3PvgPi4dGw1KKjg/3Lq6rMIC5GlE2dNupE2AYlrp8zT4FZ0+EUKa/UdvD9CJQrdh+sSBjAkATWXq52fdii2+GGG7zigAoR0yQ47fY1UlRhY/yu3n1tF5+q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=398yUCJr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cy2kGO2U2TPr1pnz3CApIMBYaE8Xib0u+l8VUL1Ic70=; b=39
	8yUCJrdNtIZSuZwtLEHMPm2jkANYun+1ozzN1FQ8M6NtnyQVuwMsTNfT63FF+T/139WJJOjhowhLM
	RT5ZRslw0wFQmL1z5O3KvZsTSuGfjySd9Bf6iVrPcBgBLw66uZgna9S9Xz+ZcF/KK+qQ6srMRynsw
	XUPle5n8SGRtKzo=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6D-006z7T-9A; Mon, 05 Feb 2024 00:40:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:18 -0600
Subject: [PATCH 1/8] net: usb: r8152: Use linkmode helpers for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-1-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBosEVBhWdcRq7v/M/7QBQSJoRWKWr+VUNRF
 Juz9Z/insWJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaAAKCRDmvw3LpmlM
 hHZOEADJyfCKM2B0x5eZEcjZDvkTSuCKtiAJAQ+VLAMB3eh58XyLnRuar4cYyBUONQF3h6EANYL
 UfbKHe/bd/m++33qitFc7ibDUatYE4qOrIVC6PG0OLaPlePJ6+GrzePmoIMLuv8jlpsoPRJvFKI
 Zqci5bkDmYgZDjDuAVQqQ8PmbI+uBSeMFhBM4f/C4PsGJRDYKkdBazp8bxPm0S41qHf1r13DbOB
 sITU2gPfS7j7de5THdg/HnxrdYY4SUz4LMYdldMdimlrs9rd8nXT4q+paIPH0T+AtLMqp0bg4rx
 qgc4k5TOqPwwf09kBd83hK8JwNTuMSIenx3vbWCsmaHz01HFwz2EHgs5+PWvw6ovBfVJHrKnOht
 lI3Aq9AdU23qeU0phrPTUXO9twZtjEtLfWfDW5KGRzkMW127mxKxSJNne5zYndHaqMl4FRGMqcQ
 wQgNcqtxOl0BO2pwrLfNLr3MlRLL5p9osXA7hnOluT/v9+XYgvAeV3C01avNpDfrJZ6iRPqFilk
 5LkRzFyvfP9byOUaPfEtr0hnPIIGGrarbubkxV4GF/yIBYRaTyFabpXGaYVHuh0wy2dAL0xKXBK
 Kbkw3nohgK2+f1MiZaftQTHaKOO7svZgMto9C6kaJt6ymWVY5Ujl6CnFIGM+/QcvuIqQmR3+ZBR
 mJSkbswk+bBI8rw==
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


