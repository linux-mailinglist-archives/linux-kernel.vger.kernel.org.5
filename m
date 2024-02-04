Return-Path: <linux-kernel+bounces-51952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250008491D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09762828F3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449C31426F;
	Sun,  4 Feb 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="URto8lFB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8A13AED;
	Sun,  4 Feb 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090052; cv=none; b=TlFdag9tuvyFhlfXNF0sm/bQbmHh80F/V6GdPGU9wReLJaXn8HILyt6doA7xdRBfOuJF0329IKgLK+Tfjr++pLaWcLeCFsXHBF7q8Ux8fxWRJf0Nr8cs2WlmuH00vjo5zauPU3NemcvsfaD6bxOdiN7TZpFL7zBrwVRdO0PA45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090052; c=relaxed/simple;
	bh=yGpciCvZe42X8Mm7gnxdnrEyn2lQDD1PdJhg+NXrF4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQO6QXJGAjRXLZ42zTV58gsFoN0VNE+XkhtSs5L8uS5YtqYOcMJlSGpxigvt00dPZUKof9Swd+dN9a4xIGsjRZEda9ZtRqdVSj5fT+k7DHmF707qBGgZN8v3fQLuYlek452lmUYcfCzJycWTlNYeky6wMc3O88J2KxAosu7xMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=URto8lFB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2doDt/91LNf7zzFsUBINicxOOYdEgf2b3C1wAn071vI=; b=UR
	to8lFByG5VmS3jcLKkE4cZh4CrkLMuo4ibIT8PeTw3mmEe9HolO2wXFJAaCmXadQaVC8T9GVlXxI1
	NzdyaR5a9fBzHi7L7NKggAFVP4MsNbo1f+gbXat3+dO0Nogds94E4FMh0p2IGM46AGcF9oJDODcoy
	kIBKCdFevAcp4HY=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6N-006z7T-3f; Mon, 05 Feb 2024 00:40:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:21 -0600
Subject: [PATCH 4/8] net: ethernet: ixgbe: Convert EEE to use linkmodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-4-fb6e08329d9a@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=yGpciCvZe42X8Mm7gnxdnrEyn2lQDD1PdJhg+NXrF4o=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBpDmpYmXcVeSnqCUCfj4AuZvYih8ct4aIbx
 Kfh3Gm5iAqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaQAKCRDmvw3LpmlM
 hCFcD/9Q7dRbdXUgdLfvaj0hb71Zsw3WnJjZqyt4hMRUEvY7m/0uJUMgbz+MlDZflhj73ItTPXB
 yb92ilkRsNgfR13MDrwgvLiSY0fmkMaG+ozLfDi9+VHEF+I/7qcxdm9+9MSfG0qi/7Xgv+l2RpG
 VlAqFnsJFoGStqBwV9lkCcc3P26TDAMyJ0d7FQENrr/T/ZBgp/C6+j2cmcNDOLFpT+GgOCXnkD/
 wTQrFPt2XXQXPccESXngoqnY7GWexMQw/7jML8ahXRFPgmLbXyZq7400Vw6H7jdgE7lZzIYwygz
 3n2ZL51hJVdOaiFDzcEGBlrOEymdpiBOUi7GfrVDL7m03euFUvWnVK39gbFcRP6+x+zZuGPwYis
 bsngfk2oZq08bhwD6kNxpqZamWOJwFx6cWScSHRqtYPaast9STPHnJ3a+XzEK6vFnCdVxXygqKm
 CdTACf9C0nXLbupsIKGV0NjF2o0e81zLJRjCzNKWIhby50o7eEhO1gUE6ybzDcLT/PtM2r4PsBQ
 2R05axTmS3HNNlXDfLQG/1Fx37TJiMcizqP+3aFWFUQezmxyEp0hbK64SBI4QyLHVBfGKB/5VnQ
 7CeZt9Oxnela6x8plSzz8CO4lwGFf14zjiJFOz3LdvqZvoiRxpfuDHkZDZPj9gf1vGq+w++FyWK
 oV+lENAMrd2mAQA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Convert the tables to make use of ETHTOOL link mode bits, rather than
the old u32 SUPPORTED speeds. Make use of the linkmode helps to set
bits and compare linkmodes. As a result, the _u32 members of keee are
no longer used, a step towards removing them.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++++------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ca69a8221793..960116871082 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3403,30 +3403,31 @@ static int ixgbe_get_module_eeprom(struct net_device *dev,
 
 static const struct {
 	ixgbe_link_speed mac_speed;
-	u32 supported;
+	u32 link_mode;
 } ixgbe_ls_map[] = {
-	{ IXGBE_LINK_SPEED_10_FULL, SUPPORTED_10baseT_Full },
-	{ IXGBE_LINK_SPEED_100_FULL, SUPPORTED_100baseT_Full },
-	{ IXGBE_LINK_SPEED_1GB_FULL, SUPPORTED_1000baseT_Full },
-	{ IXGBE_LINK_SPEED_2_5GB_FULL, SUPPORTED_2500baseX_Full },
-	{ IXGBE_LINK_SPEED_10GB_FULL, SUPPORTED_10000baseT_Full },
+	{ IXGBE_LINK_SPEED_10_FULL, ETHTOOL_LINK_MODE_10baseT_Full_BIT },
+	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
+	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
+	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
 
 static const struct {
 	u32 lp_advertised;
-	u32 mac_speed;
+	u32 link_mode;
 } ixgbe_lp_map[] = {
-	{ FW_PHY_ACT_UD_2_100M_TX_EEE, SUPPORTED_100baseT_Full },
-	{ FW_PHY_ACT_UD_2_1G_T_EEE, SUPPORTED_1000baseT_Full },
-	{ FW_PHY_ACT_UD_2_10G_T_EEE, SUPPORTED_10000baseT_Full },
-	{ FW_PHY_ACT_UD_2_1G_KX_EEE, SUPPORTED_1000baseKX_Full },
-	{ FW_PHY_ACT_UD_2_10G_KX4_EEE, SUPPORTED_10000baseKX4_Full },
-	{ FW_PHY_ACT_UD_2_10G_KR_EEE, SUPPORTED_10000baseKR_Full},
+	{ FW_PHY_ACT_UD_2_100M_TX_EEE, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
+	{ FW_PHY_ACT_UD_2_1G_T_EEE, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
+	{ FW_PHY_ACT_UD_2_10G_T_EEE, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
+	{ FW_PHY_ACT_UD_2_1G_KX_EEE, ETHTOOL_LINK_MODE_1000baseKX_Full_BIT },
+	{ FW_PHY_ACT_UD_2_10G_KX4_EEE, ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT },
+	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u32 info[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	struct ixgbe_hw *hw = &adapter->hw;
 	s32 rc;
@@ -3436,28 +3437,29 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 	if (rc)
 		return rc;
 
-	edata->lp_advertised_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_lp_map); ++i) {
 		if (info[0] & ixgbe_lp_map[i].lp_advertised)
-			edata->lp_advertised_u32 |= ixgbe_lp_map[i].mac_speed;
+			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+					 edata->lp_advertised);
 	}
 
-	edata->supported_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
-			edata->supported_u32 |= ixgbe_ls_map[i].supported;
+			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+					 edata->lp_advertised);
 	}
 
-	edata->advertised_u32 = 0;
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
-			edata->advertised_u32 |= ixgbe_ls_map[i].supported;
+			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+					 edata->advertised);
 	}
 
-	edata->eee_enabled = !!edata->advertised_u32;
+	edata->eee_enabled = !linkmode_empty(edata->advertised);
 	edata->tx_lpi_enabled = edata->eee_enabled;
-	if (edata->advertised_u32 & edata->lp_advertised_u32)
-		edata->eee_active = true;
+
+	linkmode_and(common, edata->advertised, edata->lp_advertised);
+	edata->eee_active = !linkmode_empty(common);
 
 	return 0;
 }
@@ -3504,7 +3506,7 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 			return -EINVAL;
 		}
 
-		if (eee_data.advertised_u32 != edata->advertised_u32) {
+		if (!linkmode_equal(eee_data.advertised, edata->advertised)) {
 			e_err(drv,
 			      "Setting EEE advertised speeds is not supported\n");
 			return -EINVAL;

-- 
2.43.0


