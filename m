Return-Path: <linux-kernel+bounces-66108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1726855705
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2733F1F2A660
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE8145B24;
	Wed, 14 Feb 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dIqo28Ti"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCF145332;
	Wed, 14 Feb 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952448; cv=none; b=GWFhL2SPy6ijQLIfiQsJ/M80VK88O8wvZopKjMcXnI9FOMYRD/fEbG/GgF7jnRCbg5L7OloApnBqFwC66RF+4rchC+R8aClYCkAUPDf+Bx/aQglPOt9NsAIf1OMvJQvsH+4N4HD5mhMyzy+75s75HkmpF5P+sMgy8naztQCOJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952448; c=relaxed/simple;
	bh=w1DJYkt9FTZRnNhfN8ZM1D8JVVgGCSqPVVQnR9uVLaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fx8hYuOy5QMxA0F3mCDCbjmij1mR8grD0PqxvFzdEatsLCEX7+tc9mBjIN8A3HGI8p5jqRuwqLpuReCyuDN6Oubl7SsuEI9awQoFAtH8g4VEHInM4BZqo4DdYsEkblcQDAAbd9OzyX39eYEGmQHwbgmuZsANFaz9GvrWz2D4Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dIqo28Ti; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bgkZPYVA0V4hJb/XgJ4JlLp2dhut1zemAO++lcwUguU=; b=dI
	qo28TiVHsgnDlCbxnh68GM9Zatv6Sci78O0cUQy2nNvNRJOu5GGXgTmeiJKd69Fww1IFBXthHNpmz
	fjyLfZZFSh8TxB81ZUS+W3CXRgHnT7FQfuKn5nxjlKu/Ajmv7gKP8cdBUvoBLcSl8KsWovh3sMxtq
	sVaH3tsLT1XzcVs=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOS6-007pqx-Vb; Thu, 15 Feb 2024 00:14:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:20 -0600
Subject: [PATCH net-next v2 3/8] net: qlogic: qede: Use linkmode helpers
 for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-3-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=w1DJYkt9FTZRnNhfN8ZM1D8JVVgGCSqPVVQnR9uVLaE=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkkII+d18nk9TsjScFtFJDnDHC6I2nLalnU0
 zBCp3NJkTuJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JJAAKCRDmvw3LpmlM
 hGTQD/9padJ5okLCRydr6Wbzfdd810RJWCKYWF+vx0xycV5WdEaNoKa4AHigiBEcpnhS1umpB4z
 CfmZyHOVZVBsYgwiqPqFRFNCtqx3XPXfgt7eifpr7kN6M/kji/gIL3YI04Ju0oyjQ6CkDnQYOlD
 jVdef55dc8kgI9wPxPNEk7a37qKr8r+ZKO5ZpFmE82yYuFrzMbJtKsynd/H0LD7h9COt3n2o30a
 NfoSQRbwMV0/9tJrOapAQprbL2YnI6kzfCumMH1zpG0fLk95JTIt0k5pVTp4bNAdhg/bYqQwIy4
 dNDtEuClGKFfKTCYAr0w8BsbaefFGqvEkq/4Q/fyV1Q17misQdDgzN2Fm+GRVg5oe3S/4icgjOX
 XbbAz6J+W7t19mmLieCTLgkmfO6rjX0cYIeV0d3o150D5EtIGWpVtdw/0Qe2fgQUWWV1WCxO5/e
 JSB5MPGuUySE+h1TyrudJIWM/Aa4FySmQXmDReesi1T1HoYhhNLW13rIOL15o2nctnjO8TcK+nW
 kK/TdzZf+cKUImzxMcSSKvl598E/EByvVC6/2xOHz4ZV6ymtdlerJPplgVrmh0y3ISeCmI7VMWx
 8iiFSRigWoKJe+y+JubyjJfGhzIqPqVTgo/fjB8zUmTZ94AUXas9L1gagTP7vhWySqZN5dY7Zj2
 m9KMHVuknOrgKOA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for bit manipulation of EEE
advertise, support and link partner support. The aim is to drop the
restricted _u32 variants in the near future.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 60 ++++++++++++++++---------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index dfa15619fd78..ae3ebf0cf999 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1789,18 +1789,26 @@ static int qede_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	if (current_link.eee.adv_caps & QED_EEE_1G_ADV)
-		edata->advertised_u32 = ADVERTISED_1000baseT_Full;
-	if (current_link.eee.adv_caps & QED_EEE_10G_ADV)
-		edata->advertised_u32 |= ADVERTISED_10000baseT_Full;
-	if (current_link.sup_caps & QED_EEE_1G_ADV)
-		edata->supported_u32 = ADVERTISED_1000baseT_Full;
-	if (current_link.sup_caps & QED_EEE_10G_ADV)
-		edata->supported_u32 |= ADVERTISED_10000baseT_Full;
-	if (current_link.eee.lp_adv_caps & QED_EEE_1G_ADV)
-		edata->lp_advertised_u32 = ADVERTISED_1000baseT_Full;
-	if (current_link.eee.lp_adv_caps & QED_EEE_10G_ADV)
-		edata->lp_advertised_u32 |= ADVERTISED_10000baseT_Full;
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->advertised,
+			 current_link.eee.adv_caps & QED_EEE_1G_ADV);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 edata->advertised,
+			 current_link.eee.adv_caps & QED_EEE_10G_ADV);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->supported,
+			 current_link.sup_caps & QED_EEE_1G_ADV);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 edata->supported,
+			 current_link.sup_caps & QED_EEE_10G_ADV);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->lp_advertised,
+			 current_link.eee.lp_adv_caps & QED_EEE_1G_ADV);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 edata->lp_advertised,
+			 current_link.eee.lp_adv_caps & QED_EEE_10G_ADV);
 
 	edata->tx_lpi_timer = current_link.eee.tx_lpi_timer;
 	edata->eee_enabled = current_link.eee.enable;
@@ -1812,9 +1820,12 @@ static int qede_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 
 static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
 	struct qed_link_params params;
+	bool unsupp;
 
 	if (!edev->ops->common->can_link_change(edev->cdev)) {
 		DP_INFO(edev, "Link settings are not allowed to be changed\n");
@@ -1832,21 +1843,26 @@ static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 	memset(&params, 0, sizeof(params));
 	params.override_flags |= QED_LINK_OVERRIDE_EEE_CONFIG;
 
-	if (!(edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
-				       ADVERTISED_10000baseT_Full)) ||
-	    ((edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
-				       ADVERTISED_10000baseT_Full)) !=
-	     edata->advertised_u32)) {
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 supported);
+
+	unsupp = linkmode_andnot(tmp, edata->advertised, supported);
+	if (unsupp) {
 		DP_VERBOSE(edev, QED_MSG_DEBUG,
-			   "Invalid advertised capabilities %d\n",
-			   edata->advertised_u32);
+			   "Invalid advertised capabilities %*pb\n",
+			   __ETHTOOL_LINK_MODE_MASK_NBITS, edata->advertised);
 		return -EINVAL;
 	}
 
-	if (edata->advertised_u32 & ADVERTISED_1000baseT_Full)
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			      edata->advertised))
 		params.eee.adv_caps = QED_EEE_1G_ADV;
-	if (edata->advertised_u32 & ADVERTISED_10000baseT_Full)
-		params.eee.adv_caps |= QED_EEE_10G_ADV;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			      edata->advertised))
+		params.eee.adv_caps = QED_EEE_10G_ADV;
+
 	params.eee.enable = edata->eee_enabled;
 	params.eee.tx_lpi_enable = edata->tx_lpi_enabled;
 	params.eee.tx_lpi_timer = edata->tx_lpi_timer;

-- 
2.43.0


