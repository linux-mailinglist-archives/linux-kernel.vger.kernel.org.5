Return-Path: <linux-kernel+bounces-51953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA18491D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C11F21297
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59771DA22;
	Sun,  4 Feb 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qbo2AZkM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61014A91;
	Sun,  4 Feb 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090056; cv=none; b=quyqYZeFESjWxzcJ3s9lVmc+4D7PMIzx1Ts3XsrPea7/PWYuXOXs6xNjqlVtaVUEpDlX69Oo6//+AN0iIhtydsxMapL3M3qXF9ecZBlm7v7tNo0C9qqQLHEfbOWcG1vcIN8fUiRcJr4oyvRXxRp1l6PlUfz/NhMFRkda2kegSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090056; c=relaxed/simple;
	bh=7O5kudOyUkfuKOsf1feA2qBdlnbcsxmqX0W2Kbo7rmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtJXiRTf2Qh2kPXTiuragUPTGc1JtOpq62kn1HjI3zn3szJkRcHOBIuP5tsQ+mg17ixbTRlVa7zewnTEa0mVcK3RlJeLvow2/3cCaVGCL5A6tLz0Vnl4RyNIYGTvp2Li8Rm2Rdz+sG8XRyESxzXM1sX5wYTkJ1KXUgq7PgB4LvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qbo2AZkM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VMT+7HT9bLdZtz1arkF5M0mqUpczvKtrktRMX+PXxh0=; b=qb
	o2AZkMrrvyZShRoCtkkEWgam5m0HSU6TPa/3uZogeU09NWJajQ2KXaUPxnFR1SY8VCSDYTXe/7gHQ
	L1fAs1aqKNrUOTQT37ez1kQz0LliIutbBePjLLVm7mT9evSbFMot9ZC3g75vKYCbSAtPoJJjsFyVn
	b86XwPYZ1S9e3Pw=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6Q-006z7T-Ce; Mon, 05 Feb 2024 00:40:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:22 -0600
Subject: [PATCH 5/8] net: intel: i40e/igc: Remove setting Autoneg in EEE
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-5-fb6e08329d9a@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=7O5kudOyUkfuKOsf1feA2qBdlnbcsxmqX0W2Kbo7rmo=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBp/zrzpuGGHdcJTLlVsL488w2Uusu4PUh7R
 0nXYrq5o3WJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaQAKCRDmvw3LpmlM
 hG66D/9NLRCHZoRQp8gY9TB7CsrIoSE+dx0IRf3PPHXhSiPhHeUvgmcgmlsn2cKn1tEL64IoSEF
 +MN373ADjjBxjq/Szuiney1GOIJ3RWuZb9GjiTyY6eRbHqvemufpEhz+8SMWtMUaRzms86gxDDz
 lVbjx1wlV1Tzb1S9O9LMFBSEW49r7f4h4f25EF9fBEvHobfHb5xOVxZ2T+1WChT+CgDaNhLO5mg
 jzcNcje8FUisl2joaGom87r4BpPITUIZ0TiCiWjmpRxvPFptTD/yKxAxWSVBoM7exMllB6mDiKc
 abO7xCAtYct7s2b/8g0b9QC5Ht+TFjCWp8fT1iezR8TCipX082MGh6f0XRSqP/4gP7FOPZY5Jxx
 XCXsa7HXABh7HMFkD1RZN90VS5O76vY/ns6BFAgEATJw9MFWbW081v+SFeBvRGRE/LznCKDV4o8
 tDo/i20mEW7dHBIHhOVX1h3Y8nuOpOiaqd4taFvZ9GCYZcVLypGCuTUDmC2OhJqELjMXESsiveI
 TUHfCDDfRAWVu8PjnfKncHVoH76/C60kCtyUYfw2A4KC9ZUdwWzNx5dv7y9tp8sWdBadUyIyqg8
 W60tUagyzazUSrWiBgGtQ+4N1mD0ekMpLYOxytlDShg0CbhvuhpumuKkBXyRw+Q4l9cO+ctbpNZ
 cn/bKdl7nfyHlNw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Energy Efficient Ethernet should always be negotiated with the link
peer. Don't include SUPPORTED_Autoneg in the results of get_eee() for
supported, advertised or lp_advertised, since it is
assumed. Additionally, ethtool(1) ignores the set bit, and no other
driver sets this.

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
index 7f844e967421..e9aed4069ebe 100644
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


