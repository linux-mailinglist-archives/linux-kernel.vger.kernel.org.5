Return-Path: <linux-kernel+bounces-70002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F57859194
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8864282706
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D47E0E9;
	Sat, 17 Feb 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GeWsZXvz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C97E580;
	Sat, 17 Feb 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193370; cv=none; b=G2pGUldnrSoxfGoGRmybxyuxPkSFxIa1pHS7w7VbQ3CkGyah+rrmRQNefFbJwJ1bqOW6IK4lTfC3J2/GZaKidPar5A6J8WTtHjf/uf7D9se/k6wW1YpDiCUUg2GGi1F/y2boD5VpSqg2h+l0FY4Sp1S8I5RonvQfX03j6Mc/OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193370; c=relaxed/simple;
	bh=jBShEoehGOiH3XARbTLV/6y5l6NHG5lC8OunACxocoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXQzKJ85ZaW3dt5/ICJizhzftpbl9/8M6PyplZ5YQxxK4lP6MUHSlYvsSpH/T+v+V9OMY6DPQ7EKYgeGZaUi5gLTXROvC3u3Jal4aNk8rK7rkLp1wFL0TTqhaGJx3FX1SNhQcmCwpivnxyRG3ETnTvm5s2/UaPrA1BQWGTOrm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GeWsZXvz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aFRnThzSsM1GB0U7YhBosyITi6QEbbLLMwyncP4eReU=; b=Ge
	WsZXvzoyXc6KytUoTSElPJ81kUgrOBxVQMMXwq/hJZ5AXQLyE7SCZLntg8sAeW6AXesLM1E45iXaB
	BTDz+Nx1ZdAznhc4az/tOjzyD+vIGkWsG5SZ3V51fgel3mWJO/yc2M3luzHDlujROrPQvuwWBnW+G
	W5Hy0PRH7sSpwzE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbP83-0084hf-Pd; Sat, 17 Feb 2024 19:09:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 17 Feb 2024 12:08:26 -0600
Subject: [PATCH net-next v3 5/8] net: intel: i40e/igc: Remove setting
 Autoneg in EEE capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-keee-u32-cleanup-v3-5-fcf6b62a0c7f@lunn.ch>
References: <20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch>
In-Reply-To: <20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=jBShEoehGOiH3XARbTLV/6y5l6NHG5lC8OunACxocoE=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0PY7k7SN/4S228ROAzg7ZuMLyNMUmBTSrVMwB
 alKMwysKQqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdD2OwAKCRDmvw3LpmlM
 hIAMD/9/if2OuCb4y445VS2/pfmVOV65uM3dKPOUIpYfYE4pqnEqNUHN09yJtOtOgAPCn+7nPsQ
 78NihovKh+pxO3ScOCoKfGkzcz6j3rRx9DX5yU2Mz7xGZh/AYfDDeKj2I9Pzl+UqGDIllEUscbn
 zExhnK3Gb0B+HGFIqF74KgN8AzoOenG8VLz7MXBe7v1/gzl/ZRXOQXA9lxokuotfV0UNl2nhrwC
 QW+hQcvwSY5qFu+u9kwqld+pfIGnFdn8TmflpUlD4MFXnaivCLZxVk2H1Bl0I9BwIL7v+IOKD+R
 HYPwoBO+NwFZZEq60YZGG66ciN5vlB6OEEv73u/AROr01D9OlwBJLlTSY/fctnk3Zaaer5Fcu4g
 s+a+p3Z2JEuA+1Jc5PqulsOLRBsfULx/EPPSnoMdpYnko7IgWMs1b/Qg61XPp3/ne7xYnXpKnUt
 HwLlKSoGp4/iTiejU5oZuf7MfKpj3ROHHr7lSBBMdLpH1dhGccG0El1naxVPpQsV9PnHp4Wf6tv
 30ZIMHfvXtMPIYFQDk6eKQtYZSEetgZk3CoLj4Ks0CeAfRnhgjuh5hfUUY8MJyKai8Zm3EfqU9D
 JHThBufm38cB/4OpIoUPWl6VeJUPr+4cP26J2SKGhc5rDfH7v7ysyCtrhA3BBGuqjWCYobqcyU6
 YWMovgekCvgh2/g==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Energy Efficient Ethernet should always be negotiated with the link
peer. Don't include SUPPORTED_Autoneg in the results of get_eee() for
supported, advertised or lp_advertised, since it is
assumed. Additionally, ethtool(1) ignores the set bit, and no other
driver sets this.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +------
 drivers/net/ethernet/intel/igc/igc_ethtool.c   | 4 ----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1b5473358e1a..42e7e6cdaa6d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5664,16 +5664,12 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	if (phy_cfg.eee_capability == 0)
 		return -EOPNOTSUPP;
 
-	edata->supported_u32 = SUPPORTED_Autoneg;
-	edata->lp_advertised_u32 = edata->supported_u32;
-
 	/* Get current configuration */
 	status = i40e_aq_get_phy_capabilities(hw, false, false, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
-	edata->advertised_u32 = phy_cfg.eee_capability ? SUPPORTED_Autoneg : 0U;
-	edata->eee_enabled = !!edata->advertised_u32;
+	edata->eee_enabled = !!phy_cfg.eee_capability;
 	edata->tx_lpi_enabled = pf->stats.tx_lpi_status;
 
 	edata->eee_active = pf->stats.tx_lpi_status && pf->stats.rx_lpi_status;
@@ -5691,7 +5687,6 @@ static int i40e_is_eee_param_supported(struct net_device *netdev,
 		u32 value;
 		const char *name;
 	} param[] = {
-		{edata->advertised_u32 & ~SUPPORTED_Autoneg, "advertise"},
 		{edata->tx_lpi_timer, "tx-timer"},
 		{edata->tx_lpi_enabled != pf->stats.tx_lpi_status, "tx-lpi"}
 	};
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 47c797dd2cd9..ac92d10a3e97 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1634,7 +1634,6 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
 
 	*edata = adapter->eee;
-	edata->supported_u32 = SUPPORTED_Autoneg;
 
 	eeer = rd32(IGC_EEER);
 
@@ -1647,9 +1646,6 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 
 	edata->eee_enabled = hw->dev_spec._base.eee_enable;
 
-	edata->advertised_u32 = SUPPORTED_Autoneg;
-	edata->lp_advertised_u32 = SUPPORTED_Autoneg;
-
 	/* Report correct negotiated EEE status for devices that
 	 * wrongly report EEE at half-duplex
 	 */

-- 
2.43.0


