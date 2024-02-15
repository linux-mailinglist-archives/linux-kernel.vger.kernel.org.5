Return-Path: <linux-kernel+bounces-66109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F57855708
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1BF28E8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4B145FEC;
	Wed, 14 Feb 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zemVsAkM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93766145B18;
	Wed, 14 Feb 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952450; cv=none; b=KRn74UQgUeWE/Z2edL2FYs5QPJd2l7tLro8WIwVEomK3BlBhoSKU98V9Jpw4h/HpuFH/h1oDz8AyfuqSupZLuuNBEQsyY3IgMojdjpdFdAJbKSiinH6Hq1kn6p8qruBYrPiY760D82xX2XLMNCPQZo7DPxjUjSYDNw1swhS1oM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952450; c=relaxed/simple;
	bh=6WQbQolAq5WAPWukfrjltstk+z0qZj+AW55w271U/ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARkK3Z+QcvSuvFkcqAVjHZoURfZrSsXG76KCkjvx/Sm+ik6bFcawvaVfatQtxpuNLtYiQYy95PCwBwj82eTeOyLhwUzl7S8+G6Qud7HUGRkYx2Nuzxa1Di97JSWUPogHLiZw/5LLggZznm6JxjmlBAwlsFiPY9Ps8IM7cfXshSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zemVsAkM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=N1CZYG16uNIIX1bzINMMJKicgWAqJc4xUccwHeGoHyI=; b=ze
	mVsAkM42tVnaeAhCmEdTmT2utCzw4dvfivzVxx4c2xvMHO+8FgMraPMDso2wUwPxcJUPkP6+uRyll
	0OIoF1ofJTFP+S4XNtQP+oyY45oUwuvdspzd4LynSj/K82Zt5NPtfHoIgOJCiWJ92VOiBsuJh6G6T
	GiauQ6Vi4ve5CJY=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOSA-007pqx-Be; Thu, 15 Feb 2024 00:14:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:21 -0600
Subject: [PATCH net-next v2 4/8] net: ethernet: ixgbe: Convert EEE to use
 linkmodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-4-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=6WQbQolAq5WAPWukfrjltstk+z0qZj+AW55w271U/ic=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkkpnErWegm/hSZ07cibEcmZhVFuZh0VmzwH
 yKKGsm+iR2JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JJAAKCRDmvw3LpmlM
 hPNGEADaErtOXgBoRPoBdcW946pa6SsqV7GkF3amERUOi2by2ZZL0a1l/DKUy21dxJk3Jqhqdvy
 xQz9ytLj+BoSQ3pkP6boKqTEc2h66Xft9MJkn0WEDlrh4hv1gDDvrEG+r2oqpS3BzIRQ6HDv+UI
 Onxye18e5AYhM1TLl3M3zqsj/rP2AV60tCmGxfiKpmnNfeXQoDsAzjTgR6ddqUYJk94wOS38BAc
 IqD9WYERvj+MCPjTO9cYFxZR8MWFExDwFtsH4viE0yiMnrczZuMqAqixzlsj0TJAY4qLzpaNQA3
 1z/Dtms7OWjPPXtxtg+Bqzi86K0eRMetNz4tsZG7qmdRcKu7jfFw3rTvIgtYQTJ6Hhv4IKkkJ64
 +aVN+ejcgnpltjq19ACrig2Bo1L64ZT+JI0JohbW9PUfChB/qiZjyv1SuoKz6hgWijv7FSKFJ9C
 9D5jkZBKWR/UYThQmztZWcOK9D0knyi7bsZ1TzA2uYpHcrAcmBcWzyZxWFJSi0xmfMJsZp757Es
 aEhfMHpzsrYeB5Z/Vp1X96EtjSazjo+F7edCYXeB2PeZPrW9PcSMAcZLmDH7HJDyCnvKyXNBUKB
 tEdCJsGDQeekrpQ3uXW5BBf/JuQidxQGztguFJD4XTTaxMB7DisHH0X1iK72TdMT03lOlcb9Jjo
 WWWpe3OcHwTsCiA==
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
index b1e7338a4ed1..a0879f125146 100644
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
 	int rc;
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


