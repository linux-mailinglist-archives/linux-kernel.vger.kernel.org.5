Return-Path: <linux-kernel+bounces-82528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD78685E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E992AB23FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6AF54FBE;
	Tue, 27 Feb 2024 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IhEe23WV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AF54BF7;
	Tue, 27 Feb 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997399; cv=none; b=lO5awoiCeCM9hEnYCs43zQQ9rGBu0OGSbIwM3ThftRVRGbgb8Lki7XqlB/tn1yW4ZNtRKyOlxnLF2vx+/1GQuvXSHQm0eett8FdCyQErPNDzcGgspKpXLerStCYqpJGAo43LKUpEelCJYfQzsC5eBwM5LqFYK0u5jStVL53+PbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997399; c=relaxed/simple;
	bh=PX0276prl5bF0Zk/hDHop6Y8pnHyHYPG6F7vOSTrfII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4bCXdJDi0aDl+1fVmTb8o6R1OILVJZG0zWsOuB49gkRNTZISHl0bTTUkXHozV4fj8arPNGLePiGYyXGctQGmkSP44fjvsvharAOn3NQktc7rWatbU+TFJGS7LUPs1fVnq7KT66rk6ubnWSdywOwKRbYuYsxMMFUHVH5TnDbSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IhEe23WV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KBe7PSdB/4N4eh9woXxZp2COIAUibBjbd71nXWJwB2E=; b=Ih
	Ee23WVyNCiH6KwotDzZezOuA0Z6O1lLT7CqwQHrOIjC/6v4g6hr7U+ZA8brURnZ/DXXcsNg9FGHdW
	Ja+5ZXfPkJdbPI0spGyxxKwzPpI091XrT1dJeJ/N4Em1qU/fbr4lfNAYoKqmi9r7DJxeLx96Iul1d
	0KwAu+2C1tnYpww=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remIM-008mef-0w; Tue, 27 Feb 2024 02:30:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 26 Feb 2024 19:29:12 -0600
Subject: [PATCH net-next v5 6/9] net: intel: e1000e: Use linkmode helpers
 for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-keee-u32-cleanup-v5-6-9e7323c41c38@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=PX0276prl5bF0Zk/hDHop6Y8pnHyHYPG6F7vOSTrfII=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tr399O/qZLa+qtmk1D+wb8mIMB5uVkItxltd
 fQDjV+4iSGJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd069wAKCRDmvw3LpmlM
 hGz4D/9gkS9mGuVikuYHJ7HYII28YAzZuB6JgiHmuKa7/lJQ1R21GGykTuZVZ27dMSwAamohMK4
 zwKekSM6jCXpPgVQP/Qq0RKrpsD0J63h81tLjpTaOE/CFeY8NGFQQDT8NRUX1Kmbt29iRfTDTNw
 8gu0aCYYmP3ElEu+pouz4+LFbY6qTlK3FS5TXQr4hD/bRi3ukpxe7X3ClwsK7eLFsA1V6xobEiH
 c3iRkpDgZ0pesibjPuD6r+T8G1TZsX0DoOxkfzESwru9AbpF7hyuV4Wv+Z+UgC/Xfdf9Cx9UQYL
 F3WK0/vNhCSnFmF6vs1pI4dO9XRdM7hCoJr4iiKAAE57yBOuM7zUbhk4HP+S4y8D39nA2AfF/gY
 PDBnbRIwdipEqnTQBzdW3lKlm39B/+vXavVXXEEACKCi4pdl9Hm24LacFTJA2upwsO+npis3vgQ
 IL/xVNwOz8Zqj2XTj9jh4Td3cegZ0giL9vnanhO7Ry/d96iH1pMJcqtt54C2U2GHUWP9AtV0V1z
 /jsQ4Hx1gy8EdIHTNwZgYalWVPjSg1VEDI2UyUtLDjF29wy6SNeWR8aqmdLEVSn3Uzmz94wTTSY
 MHEZcdnw9RyAlOkHad2Ci2EyM+hnvgeLApEm0pyTPh9iwEyglt4k/IlSxPRjsbsKresuNEh5gwO
 FXXgDhcSgzoY/NA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index ff243ae71b78..dc553c51d79a 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2223,16 +2223,16 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	ret_val = e1000_read_emi_reg_locked(hw, cap_addr, &phy_data);
 	if (ret_val)
 		goto release;
-	edata->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(phy_data);
+	mii_eee_cap1_mod_linkmode_t(edata->supported, phy_data);
 
 	/* EEE Advertised */
-	edata->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+	mii_eee_cap1_mod_linkmode_t(edata->advertised, adapter->eee_advert);
 
 	/* EEE Link Partner Advertised */
 	ret_val = e1000_read_emi_reg_locked(hw, lpa_addr, &phy_data);
 	if (ret_val)
 		goto release;
-	edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+	mii_eee_cap1_mod_linkmode_t(edata->lp_advertised, phy_data);
 
 	/* EEE PCS Status */
 	ret_val = e1000_read_emi_reg_locked(hw, pcs_stat_addr, &phy_data);
@@ -2265,6 +2265,8 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
 	struct e1000_hw *hw = &adapter->hw;
 	struct ethtool_keee eee_curr;
 	s32 ret_val;
@@ -2283,12 +2285,17 @@ static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		return -EINVAL;
 	}
 
-	if (edata->advertised_u32 & ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL)) {
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 supported);
+
+	if (linkmode_andnot(tmp, edata->advertised, supported)) {
 		e_err("EEE advertisement supports only 100TX and/or 1000T full-duplex\n");
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
+	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
 
 	hw->dev_spec.ich8lan.eee_disable = !edata->eee_enabled;
 

-- 
2.43.0


