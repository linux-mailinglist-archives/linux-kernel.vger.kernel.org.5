Return-Path: <linux-kernel+bounces-70454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9C859811
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B9C1C20BE8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3B745DA;
	Sun, 18 Feb 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5tkRDZNI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535F7429B;
	Sun, 18 Feb 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276064; cv=none; b=EDYfyHiA7QAMwLuqYFs9eR7gduWtYFFAbcuIm6B/gDwcBnCCl4BYQkWPgRtIkCC/lzjwlFI/Ovz510i4As54oHA/RMFN0Qhp/PkKitN1Ug89ByMhK3jUy1w2k7HWTA+Rb3T1KnzJbrlC8CBfTWMtPRsBFY14RAlapJ/DnRzE7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276064; c=relaxed/simple;
	bh=xffr0GXqel7jbZc8Ik+9TtbWrjhgJxXahNX++S1de6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFvCTuOFtcBUrqZHRNHcNOYxnNhuIsT8IDl1KX62Fm2YEuO9Io6ZJeLozTrV2Hs+Xg3seCe7PanfiWaW+OZ9YeAWyFReuaR0JSK3exa2lyl35ctANlRqlWGAtJJ9HmKCfob9LnFCUmGPP5i4buon5ylXBSX+WEcWxmdQeFkEviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5tkRDZNI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZXONKmDn5sZIMxtipaagv56vEZFiWDyaXt+UaQErfVY=; b=5t
	kRDZNIv8LqY9BzcHg2fZgk6Bo8lUpMX9l4570v6gHvcOttKEqB/32jUA9t80992Ddnx8IeM3Nw3R9
	YB4qzGKfjsWqsJzKL37Zyaacfu1iKhFTwCzo8p8WvBpXleX/ktmAri9JXlVo11V5KMUzqSOizEXzM
	3b7nbAMih5lEXdM=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkdv-0088HX-G5; Sun, 18 Feb 2024 18:07:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 18 Feb 2024 11:07:04 -0600
Subject: [PATCH net-next v4 7/9] net: intel: igb: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-keee-u32-cleanup-v4-7-71f13b7c3e60@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4098; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=xffr0GXqel7jbZc8Ik+9TtbWrjhgJxXahNX++S1de6k=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jlAaf/p+bCP3YC5GLSi2piZ2Lnuh9K6p/OH5
 7GjWSxzhkKJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5QAAKCRDmvw3LpmlM
 hMzFEAClMXS6MM6wJcO2I2b80AcQRh2RBR4Qa1lZMF11IbFoPeU9VekKg26fjatWIgKOjZZg8Hx
 rOaOGX9ZVInHZlE9AQNreE5HzzxJkzzrVrLTVVre9pnNnG6OWvKSQIK0dMZcU8KVKqfuhd4Hh0t
 OtllpsIw34yFNr6GP9Wv6eA7PbsApeTu5MhRWwR6EyewIjJwN3qFLNcq+lXjUh/5ssPqMN3xaGO
 BabQhTkX1cT3b5iwT8Cwo/cR3+yLrGv21ztnA6OkF4rB3pleEqqrdBs5xNurQQr7b/og5BzJ6Zu
 frTECSNMpL5IIVhh0qMkmrbX+mtEFMWK46BBnw5Kd3F5EQElkmTGLJBcbznJCS+trqRaeWuCROE
 ZAdAGLx+nvFOzuMHWjUl0blfO5VwNXbAwtqR8n2O4TxjS6O6dhdPe10sPn/cEijS60cLVrQqoAU
 iEmVF8oMgU4wZkBgnEN7s17io3+bQjJ9OSW2HZ5tLuZ9ukpceWxUccbfSGxdmHTsZEuzjvs9Qgy
 r7xu+4qg6Z7sMhxxmVGygg+sj2lLHyp/uQ2hfcNI2I4UI7pLKWrqSjG4kjsXv7VYmz7bJ9Wkvtw
 vWzJ5edDdB1aFxPyIqOckldZ6PD0ObnbQElNTXnTRzKECVUciI3zvd/yjpjgH/kdx7LlzIKw9+t
 0WGZB83/wBwjHyQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 35 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b87b23d2151c..99977a22b843 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3038,11 +3038,13 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	    (hw->phy.media_type != e1000_media_type_copper))
 		return -EOPNOTSUPP;
 
-	edata->supported_u32 = (SUPPORTED_1000baseT_Full |
-				SUPPORTED_100baseT_Full);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 edata->supported);
 	if (!hw->dev_spec._82575.eee_disable)
-		edata->advertised_u32 =
-			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+		mii_eee_cap1_mod_linkmode_t(edata->advertised,
+					    adapter->eee_advert);
 
 	/* The IPCNFG and EEER registers are not supported on I354. */
 	if (hw->mac.type == e1000_i354) {
@@ -3068,7 +3070,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		mii_eee_cap1_mod_linkmode_t(edata->lp_advertised, phy_data);
 		break;
 	case e1000_i354:
 	case e1000_i210:
@@ -3079,7 +3081,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		mii_eee_cap1_mod_linkmode_t(edata->lp_advertised, phy_data);
 
 		break;
 	default:
@@ -3099,7 +3101,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised_u32 &= ~edata->advertised_u32;
+		linkmode_zero(edata->advertised);
 	}
 
 	return 0;
@@ -3109,6 +3111,8 @@ static int igb_set_eee(struct net_device *netdev,
 		       struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
 	struct e1000_hw *hw = &adapter->hw;
 	struct ethtool_keee eee_curr;
 	bool adv1g_eee = true, adv100m_eee = true;
@@ -3138,14 +3142,21 @@ static int igb_set_eee(struct net_device *netdev,
 			return -EINVAL;
 		}
 
-		if (!edata->advertised_u32 || (edata->advertised_u32 &
-		    ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL))) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 supported);
+		if (linkmode_andnot(tmp, edata->advertised, supported)) {
 			dev_err(&adapter->pdev->dev,
 				"EEE Advertisement supports only 100Tx and/or 100T full duplex\n");
 			return -EINVAL;
 		}
-		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
-		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
+		adv100m_eee = linkmode_test_bit(
+			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			edata->advertised);
+		adv1g_eee = linkmode_test_bit(
+			ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			edata->advertised);
 
 	} else if (!edata->eee_enabled) {
 		dev_err(&adapter->pdev->dev,
@@ -3153,7 +3164,7 @@ static int igb_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
+	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
 	if (hw->dev_spec._82575.eee_disable != !edata->eee_enabled) {
 		hw->dev_spec._82575.eee_disable = !edata->eee_enabled;
 		adapter->flags |= IGB_FLAG_EEE;

-- 
2.43.0


