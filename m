Return-Path: <linux-kernel+bounces-51954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572368491D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E941C20CBB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A5250EC;
	Sun,  4 Feb 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZMcxmBBH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E71EA71;
	Sun,  4 Feb 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090058; cv=none; b=LRCNNYJusX5sZygVyEJxOafLKY/sbmUVDUKSQEhfWbjhkooubdiYEzaDAhlY0KZ12lK2ETofU78cU25RJUUDz/5GTHY3REzX3TYkEXzYoVmkH5AxGKDFwBaCulHnLqnZEJrL0EL4WK0ZNNae9OKbwFB4KsHqlNusXvru7vFPstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090058; c=relaxed/simple;
	bh=nLsygJVJCduLk95szsdKOpEa7GzGsR0GfRGWNH5oTU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhgBU+rVPdc6qJMU6udhdEDtVD1dIZLLkVETqEIR0Y65H32MTFxGosXakFxabJelRa6kCjPY+N9rGd5rUa5AX4GvzX2NZhOD5Wj6Mfyyou6VSaidMMej1cdczMBXVf7MbvlCyJVHwte2jaWXuyxEusdiK/tpME+IdeADyu176YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZMcxmBBH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SOMOZ6/FJXknA8+mFiIFxymCAEzF7Pi03pmztEUsl68=; b=ZM
	cxmBBHlIhSCPAlwVLBoz3Fekp/dYlX6F3SanTzQTRzOR+lxnu6sEtW7uiemGZkSN5AS+iKyP2KiTl
	V4FDxCUDTJFQr+o90HYrb//4tNVP6zw5wRcCU9wfWrcN1Q28REsGFniPRYH9RomDuKrLiCcRp6C8j
	+INF94+EMgeVlwc=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6T-006z7T-Lq; Mon, 05 Feb 2024 00:40:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:23 -0600
Subject: [PATCH 6/8] net: intel: e1000e: Use linkmode helpers for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-6-fb6e08329d9a@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=nLsygJVJCduLk95szsdKOpEa7GzGsR0GfRGWNH5oTU4=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBpVzUXNjKxZFogkHO2Vi+0+ncows3pPdO7m
 IgiFrRgNjGJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaQAKCRDmvw3LpmlM
 hJ5GEAC+Up2GLnNGBrVKddbao8VwxNlTND+5pPoV/Tsh0UGTcxNgfMGyhNDlu4yDEKZUaCTAOVZ
 BOkqbMr0Yg6NF0wmfrUvqdk4/b7UaqnvMI4NVTo4VDdzvyFKR64Kyv6Cf6nStHQMOia+5V5k4By
 +ZAVelTkjyOH+0uUI0+iQOKhFfpXNRVH2I5rsPH9BIzh0WvAsAjTVPvAmTOOlXBE5bd9PCyREBK
 ErUeGpXGTXKtGyAq/cozv7Cv1vLIK96SMf3IBnjVbCya9ithFar8DRpq8ZVZ2E8HQpiX70Ubg9l
 J1+Zs9A1TixSu4SBszHkvbZjrn2y85aTvU3hVVYFWN3M28WTkXOWczm7xWiFjRS9bzz1z/ZvQUi
 aK0yPzLkZqXvfmXIb53E/YwKcp9gl7AylFxm1vns8rjN7QWCvBk3GUjWLkRhGXzhCBps5W/8rNx
 YIqcBiphznQNC1hadEUm/UIZFzNmq6Ho02XFMqWl0ozwz4BAL0QSG+DwGvOionnWxsIVBwyoDri
 0JYgES9vfbVZmjNq95mfCSTpFo4B/6MFwcgoxtfBLayJ1E08Wr0kNrFnqBlJCxJHFhg+DqKDdLC
 Ok0Yshs7CSybELHhfbI9+FkghH0Elw0OVlUEliIxgt2TFmQ1fDuDruITZ0V4FGPx8FZ25/TsLJa
 og612fGbmUSkMvA==
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


