Return-Path: <linux-kernel+bounces-134071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8C89ACDC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612492835CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E34F894;
	Sat,  6 Apr 2024 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MdWAiPMC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365824F885;
	Sat,  6 Apr 2024 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434615; cv=none; b=Ohpy8K31ejQv4SdVzuQ0uBOldpFkCjGcJ2tbGAMmqUMY3RQBNpjecn02N6SVh5Qv29QC+mA3yHvonX5MwD0Mmco9EVhG0kmxlu09goGLMrSwwkEQ9kLhcBo5y3XN6aImw60SwhPADuAzPYs3KclyxD7iJP6z0nuKr4AiKbcX5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434615; c=relaxed/simple;
	bh=F0GHo7WXtaoyoLfifO6y6BpGbziO0HDIfRr+QScR4TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gONHfhmyBgvF9kInkaBeEhrkITr0SeGjRKyPHHoFKXL6FrkwK868wTVAn88tfPvuo9/p4dLdV82hhdqNdo0wGIKN0yr41jKHM3m7CjAZM+WEOtu0hargliaefweaT0t94ZUXc3r1rpOCCEMSHoLgDtS0HP7QnBE9gY8kTWXslYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MdWAiPMC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FPkrENK0Zuf73NwhJFCeyNLXWQmepl+j0ukaA706qw8=; b=Md
	WAiPMCnkR1I7PIpmceno0aJHibn36/FJyE0DUINa8S4VxS2SlnOXTPZUvduJHbQlV8+/WsBPtouE6
	Ly05LTzJ0SF8/NqgSm7RjU16xjSKXDPT3QILZ4kZmXGqZg0q27ctXP0t+npoXOPoxalT+4QR0Qs/K
	2JQdQDcj4M5tpuA=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCSj-00COEr-0v; Sat, 06 Apr 2024 22:16:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:16:00 -0500
Subject: [PATCH net-next 2/2] net: lan743x: Fixup EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-lan78xx-eee-v1-2-2993b14b849c@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3176; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=F0GHo7WXtaoyoLfifO6y6BpGbziO0HDIfRr+QScR4TM=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa2Sz6vE6PjAi9vSIfixJjbNP3YTwsv2Nyrsv
 Pe7Hx/H66KJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtkgAKCRDmvw3LpmlM
 hKRjD/9rLDVillq8rLS8CWq8BUAjaXqGjtXTOq7Oc97Ha8XKmdLAHv+kXJJXhJRcTlhJKx9I/aT
 bTzr7eFHzNeiD62qQp45Hed5ya99JYTIE7JuzbQtvnyGN8JMjssrJtLJx9D5rZFYYRPcr/N0G6d
 Sga5V7zEsfDMGjg7UaDTAvpPBqoPt8lGAple+6SSqHs0EIOjFTfwOv5a7DSHA/wXQRdZylI8+1J
 aULM9e7BungSnJWsaRfx3jalmiWngpGTh74Fk28HdHjmn5FkhW4eroepCuhYKeflQ6fAbsAhPy4
 NVFMa1ab/rOdXV2yHywYQ3p7Olq2+z9OfPT/ZfXuCa3JgQn3iBujnUDF1VRp9UtklHc2GiOIatS
 cnJakX1SANOexVM7ZXja7i/u1pest+V+WeFORipl/SJI5Sco8cyKfyX6z8XqC+HU1M8LyIZjZqR
 UHT1fn04WI62rCLIKWDw5nhlZ5ImSobmiM6IrBNMnE6mnHC58EYvjiq6wD0j2KVGySMmaSCWZyl
 Z32mkjtReKolYEfO1P9jeWjDiWGgljBE6J8vhHXTMTAnIc8Pfk/6KC1FSyb1fwOeISm2K6pVx/w
 XVL/Hbhm+qLLJWnkq7R8uyVlqZNgVs4mY6llq4DW4fnreOGcQQ6pjHWklc6s//nop4taqAwl4b8
 +TXgOJdIUhTKb6g==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The enabling/disabling of EEE in the MAC should happen as a result of
auto negotiation. So move the enable/disable into
lan743x_phy_link_status_change() which gets called by phylib when
there is a change in link status.

lan743x_ethtool_set_eee() now just programs the hardware with the LTI
timer value, and passed everything else to phylib, so it can correctly
setup the PHY.

lan743x_ethtool_get_eee() relies on phylib doing most of the work, the
MAC driver just adds the LTI timer value.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 21 ---------------------
 drivers/net/ethernet/microchip/lan743x_main.c    |  7 +++++++
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 8a6ae171e375..d0f4ff4ee075 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1076,15 +1076,10 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 
 	buf = lan743x_csr_read(adapter, MAC_CR);
 	if (buf & MAC_CR_EEE_EN_) {
-		eee->eee_enabled = true;
-		eee->tx_lpi_enabled = true;
 		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
 		buf = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
 		eee->tx_lpi_timer = buf;
 	} else {
-		eee->eee_enabled = false;
-		eee->eee_active = false;
-		eee->tx_lpi_enabled = false;
 		eee->tx_lpi_timer = 0;
 	}
 
@@ -1097,7 +1092,6 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 	struct lan743x_adapter *adapter;
 	struct phy_device *phydev;
 	u32 buf = 0;
-	int ret = 0;
 
 	if (!netdev)
 		return -EINVAL;
@@ -1114,23 +1108,8 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 	}
 
 	if (eee->eee_enabled) {
-		ret = phy_init_eee(phydev, false);
-		if (ret) {
-			netif_err(adapter, drv, adapter->netdev,
-				  "EEE initialization failed\n");
-			return ret;
-		}
-
 		buf = (u32)eee->tx_lpi_timer;
 		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
-
-		buf = lan743x_csr_read(adapter, MAC_CR);
-		buf |= MAC_CR_EEE_EN_;
-		lan743x_csr_write(adapter, MAC_CR, buf);
-	} else {
-		buf = lan743x_csr_read(adapter, MAC_CR);
-		buf &= ~MAC_CR_EEE_EN_;
-		lan743x_csr_write(adapter, MAC_CR, buf);
 	}
 
 	return phy_ethtool_set_eee(phydev, eee);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 75a988c0bd79..d37a49cd5c69 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1462,6 +1462,13 @@ static void lan743x_phy_link_status_change(struct net_device *netdev)
 		    phydev->interface == PHY_INTERFACE_MODE_1000BASEX ||
 		    phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
 			lan743x_sgmii_config(adapter);
+
+		data = lan743x_csr_read(adapter, MAC_CR);
+		if (phydev->enable_tx_lpi)
+			data |=  MAC_CR_EEE_EN_;
+		else
+			data &= ~MAC_CR_EEE_EN_;
+		lan743x_csr_write(adapter, MAC_CR, data);
 	}
 }
 

-- 
2.43.0


