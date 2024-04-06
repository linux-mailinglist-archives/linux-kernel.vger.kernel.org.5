Return-Path: <linux-kernel+bounces-134070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C503C89ACD9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E2A1C219DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0A4EB54;
	Sat,  6 Apr 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5dPGXmlh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E474EB44;
	Sat,  6 Apr 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434605; cv=none; b=i03Usj4Y14BwnNoUVjYs5gguMsu3PdB2XAGpdS1c2GjoXB68xXtp8ZP00NhXSLwx2lnr+JAWvsFVYxuK8cSjf24IWOwl4v3jwZLfmYJ1SYG2G40rtfar1giz6wIFmqLu8ht7hfluKsew9h1NmH6BPBCgFB+CJiVueftpoXheobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434605; c=relaxed/simple;
	bh=LzDrLCIRFXbyHZJ7V8iUoMb0IOYOM06aLEPPPW/2fc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKXAY1UnWa7KmaR6G8ooLacMV2g9Uncif5FmR7VAHUejYMAPt2u/1RNLTndVDs7da2meAmBZkqLUAlTYQBTYNi0WgUpTR4oSlT0uyVHN3hdPmv/apiXaRk23OAiQ4q+EfkGbtRd9FnTd2JO/ToPIF7iZgW3djB42HcZBAG25ztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5dPGXmlh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oh/cxGf6fDe2mzBzmglfTGPPEIubaDYcE+unOBbBPYA=; b=5d
	PGXmlhhfz0eNFM4TpJBJNpHoU2cbum1Yj099C6Yq3cvAGk22k7DOV+YLIfD9OkwBXjMzy3BZLPZZ+
	7x/SLhIY3K/j784g9JHmx+STUqHCs0YwO/uRERXV1RQnUzHY3vKbC3GxqFUHNAHx/nd0kAuS7fAUM
	euMDXF6P/u9m/FM=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCSf-00COEr-O9; Sat, 06 Apr 2024 22:16:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:15:59 -0500
Subject: [PATCH net-next 1/2] net: usb: lan78xx: Fixup EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-lan78xx-eee-v1-1-2993b14b849c@lunn.ch>
References: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
In-Reply-To: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=LzDrLCIRFXbyHZJ7V8iUoMb0IOYOM06aLEPPPW/2fc8=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa2SM4dz9/cnfzH353SiCIjg46UrI7GaUvSDF
 N6epE9u//KJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtkgAKCRDmvw3LpmlM
 hCnpEACpXk8zD6qZi8SrkrKffHDURQkfjWhmy85crP14/mSfuFjPdtwBWu/byuJ7FvdlqVSvx62
 tgZf9ekXxb6a+cTJDvpOZ1wbtwbAAfsdCb7MkqUA4KVQ5uMlkYW9GWgcghnGuEO7fGY4ueEaT2q
 isJGVRs58HymoYOyOQXeuIt3fYnDBsfazxElMdelK6qdO7sCcUSxDBg03KfU3qYFsJQGjznO+hn
 csxpM5ziEJdn9/VjWXoCNdkVnL+oirwIuP7fvzncgPFVBEgU2RyFl/e3TdpFdi4jO50ql/znWW7
 xidgoYQK+haRu0FrJAo6enUE5PgDuQQZcLzxy1s9MEt8iD+/3ne9MA98+16VrEqK+/sBH0mE/RW
 0RFpCANmqYtvs1kZjrDDRudkT3OTFnF8VdzNEBiIhW+f7xdBpP7xDX6ne4ArMhe5QnvxM5dKBUL
 pdCNsHrEds0u/N9+IJRGUiMEKLbMjnQP9e/UxTj0dNERIqLNqPaVPr/Ul5iW5pZ5LWsQM3hFZNl
 Igig2WSUx2b7P4ZiaBCwrMH+f2R9HxwwQI3OlWDwXHhn7kS5Yrh1VmDA3EICENkoyHQ9tWhgNci
 mUrAhfomfu4Zoe4z7bGr4b/SMEmW/WNEpf+ZFr6NwKfql68oRmwpN2Xov0G3AbF4vAT9R1J3BWS
 Kqde8dAOo8BXxdw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The enabling/disabling of EEE in the MAC should happen as a result of
auto negotiation. So move the enable/disable into
lan783xx_phy_link_status_change() which gets called by phylib when
there is a change in link status.

lan78xx_set_eee() now just programs the hardware with the LPI
timer value, and passed everything else to phylib, so it can correctly
setup the PHY.

lan743x_get_eee() relies on phylib doing most of the work, the
MAC driver just adds the LPI timer value.

Call phy_support_eee() to indicate the MAC does actually support EEE.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 80ee4fcdfb36..0030be502daa 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1692,15 +1692,10 @@ static int lan78xx_get_eee(struct net_device *net, struct ethtool_keee *edata)
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &buf);
 	if (buf & MAC_CR_EEE_EN_) {
-		edata->eee_enabled = true;
-		edata->tx_lpi_enabled = true;
 		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
 		ret = lan78xx_read_reg(dev, EEE_TX_LPI_REQ_DLY, &buf);
 		edata->tx_lpi_timer = buf;
 	} else {
-		edata->eee_enabled = false;
-		edata->eee_active = false;
-		edata->tx_lpi_enabled = false;
 		edata->tx_lpi_timer = 0;
 	}
 
@@ -1721,24 +1716,16 @@ static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
 	if (ret < 0)
 		return ret;
 
-	if (edata->eee_enabled) {
-		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
-		buf |= MAC_CR_EEE_EN_;
-		ret = lan78xx_write_reg(dev, MAC_CR, buf);
-
-		phy_ethtool_set_eee(net->phydev, edata);
-
-		buf = (u32)edata->tx_lpi_timer;
-		ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);
-	} else {
-		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
-		buf &= ~MAC_CR_EEE_EN_;
-		ret = lan78xx_write_reg(dev, MAC_CR, buf);
-	}
+	ret = phy_ethtool_set_eee(net->phydev, edata);
+	if (ret < 0)
+		goto out;
 
+	buf = (u32)edata->tx_lpi_timer;
+	ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);
+out:
 	usb_autopm_put_interface(dev->intf);
 
-	return 0;
+	return ret;
 }
 
 static u32 lan78xx_get_link(struct net_device *net)
@@ -2114,7 +2101,20 @@ static void lan78xx_remove_mdio(struct lan78xx_net *dev)
 
 static void lan78xx_link_status_change(struct net_device *net)
 {
+	struct lan78xx_net *dev = netdev_priv(net);
 	struct phy_device *phydev = net->phydev;
+	u32 data;
+	int ret;
+
+	ret = lan78xx_read_reg(dev, MAC_CR, &data);
+	if (ret < 0)
+		return;
+
+	if (phydev->enable_tx_lpi)
+		data |=  MAC_CR_EEE_EN_;
+	else
+		data &= ~MAC_CR_EEE_EN_;
+	lan78xx_write_reg(dev, MAC_CR, data);
 
 	phy_print_status(phydev);
 }
@@ -2408,6 +2408,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	mii_adv_to_linkmode_adv_t(fc, mii_adv);
 	linkmode_or(phydev->advertising, fc, phydev->advertising);
 
+	phy_support_eee(phydev);
+
 	if (phydev->mdio.dev.of_node) {
 		u32 reg;
 		int len;

-- 
2.43.0


