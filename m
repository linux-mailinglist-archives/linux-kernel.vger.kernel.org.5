Return-Path: <linux-kernel+bounces-66111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C885570E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C128F866
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5D146902;
	Wed, 14 Feb 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RUUb3Myx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9311468F0;
	Wed, 14 Feb 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952457; cv=none; b=atVTJ5YZnhy3aaeeT7tip7rY9VCvV8j9UJn4TbmfufsrlLRrjWtuqsVYddbKN6cXVa9CGUNLdnUwef4jLWYN5N0a19G7KNZmms/zFcba2UIfb8LcKJrACVYtOalp5bBsMDqrCBTR2RcS179jfsGaobsjN3Ee7iZLRWLvf8eDo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952457; c=relaxed/simple;
	bh=nLsygJVJCduLk95szsdKOpEa7GzGsR0GfRGWNH5oTU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3QwPGIuS8n+9/hn5CkDjXgb/8iPrd+DNw6KM9KG75OtH08RMn43LNG22emFwd+TVmFGkT5wNE56xQyMX6wR0ADrWfRWjUH2bz15izKyxdc7zVgR3lZUZElCAU3EBbgn4wVXqL8d0wyjZCGSFDHKdmgodfqx1mSHYzj1KaLB70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RUUb3Myx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SOMOZ6/FJXknA8+mFiIFxymCAEzF7Pi03pmztEUsl68=; b=RU
	Ub3MyxHW0OHnH2+JYo4k9foRknGy5oKWm0apnay6fyshEe7Y86ypbdPNMO/j/U2E3/2kAd72ZnFya
	6iLKJIRn2MqU8Hm0ZwOAA0CaLYoUENL0w9TCzLEGz+n8VGvPtI754yU7J5Sv3UGM/mxXL1DQvow5e
	vxgLUpohAcI7wD8=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOSG-007pqx-TN; Thu, 15 Feb 2024 00:14:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:23 -0600
Subject: [PATCH net-next v2 6/8] net: intel: e1000e: Use linkmode helpers
 for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-6-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=nLsygJVJCduLk95szsdKOpEa7GzGsR0GfRGWNH5oTU4=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUklucfkw4BIxR2M2JoZU1CZik7uA1zJsjtcw
 dtVu/ZqVcuJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JJQAKCRDmvw3LpmlM
 hJQqD/4iP8C+aiskVBclRtSTU9R6l288uCkWHl3gTi1cKG8A6dyYIgaAqcZNT9X5I7V6SM7yVnO
 06pGErLm1KP3RDoiDtHd/Ao9XJ9hAcnD13YSdxKT0ymNSZ4xePQij/mGtZkJ2RoiqIqTgzBirne
 lwdDxzGgStv3OaZPdmxHnqq9r+dBX7zG4FGR3I33DBGkgwasWYbDKRbHVYxBc3rw5Tc3pskN2lx
 Wfl7vH6L14U+F4QZ6wXERHtN3WZl9JQWgMDLzgM/DwTckwGOtWShMObkU1Wr6KCQ1u8V24TlR55
 MZ++jUcjCvpCcQXrQDGMeUdkQ5XhspK82eHzCB4QjOtgRssMyJX824yFk+kikq2gHL3wS0cwFsb
 OUXI969Wu/mctH7xc9+65hen1X1W2zAp5g1n9dell/PJ0gkUrFegF+qWks6cEdqhR5blVxZFc0U
 qysb4EejFzNWRmfXl9NbjcJ1HnRA/eG1kNksSIYXlGu3iD9HjfPrIw2u+hIiZD4PNoDUYHqgPV/
 wXtT+h2XkJYzqJwkXI1txBW+2yGpHY9PQn1AyHH0jYhSNVGhe8mDn/n28BIxft2itNaVoC0VpUK
 dQkFYoIT6FTdAHvK/YAYUikQPlmHvqjlWxh9NEa+UWpzQAuBkdd6HaNEyEbT4M1X96wsnVB6Owo
 FdmUbmcDA0cGpCA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

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


