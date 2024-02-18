Return-Path: <linux-kernel+bounces-70452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30985980A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44991F2145D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113C73172;
	Sun, 18 Feb 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pk89Yc2v"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377271B51;
	Sun, 18 Feb 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276057; cv=none; b=qxR8TUc5Ti74wwbnrtiaxu8O2KJfX9ommM1IZuzQEXTlQH3WBbRGWzXBAVRP2FSlYrtBd+/iemMN3TJqd8g3HbF9EosipkZh7ZMxDGjZTjmUbLN7c2XiCd7tN6luIzgSizoNG5IDWK4qaRdEQQXOGWXUDyh+n+wTsJX4KhP/Ipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276057; c=relaxed/simple;
	bh=jBShEoehGOiH3XARbTLV/6y5l6NHG5lC8OunACxocoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1VMwOtoeXmCKY3d/Poa72YOjS0r0rQ5J9tH3pfpw5ibX6XADNnG3oi/rNApeXPx67iSXq/46Oas6e7s14Jnx1kYIURQJCJFjifvo2XuWvRL/uMYkaIkBD+CfHSh63/gUlfBbF6XvZtXtseS65jOrDJYZCCAHCcKvtMiDDLhgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pk89Yc2v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aFRnThzSsM1GB0U7YhBosyITi6QEbbLLMwyncP4eReU=; b=Pk
	89Yc2vBB0hkAtYM0op8l3WOsI6xtG01wblt7FLT7nJm/Ax+xLUurl/bd7tL9CH/WATasT/02Tq6qG
	T5ttc0zFldzTa44E3jZ1yo6f81BOsJLijYDA4FjL5MgefEFcd5tYIsaKHYA2KBANwwjCkTFUSA4WT
	uCacSp4xR/wSuiw=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkdo-0088HX-UQ; Sun, 18 Feb 2024 18:07:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 18 Feb 2024 11:07:02 -0600
Subject: [PATCH net-next v4 5/9] net: intel: i40e/igc: Remove setting
 Autoneg in EEE capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-keee-u32-cleanup-v4-5-71f13b7c3e60@lunn.ch>
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
 Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=jBShEoehGOiH3XARbTLV/6y5l6NHG5lC8OunACxocoE=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jlAMT9Oz3fl2t1Fj5aWbUkFiXJyPsfMFfaXt
 ddsjRvTWY+JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5QAAKCRDmvw3LpmlM
 hMRDEADZfbTifRtNPmUUkeYI81wNBVFF22R1hpdrqUQ4yOsirNebG6Lxb6yo5/tpVcagYOPhRP2
 JtRRR8834buT3QWHcFEqG6HkAT2KomsSrgIpZxJISGMG4kIPqcWMdu2Ma1ulfETSLVe5C6FvSl7
 jSfOafcJ4Dlp1DLvvmdPT0PNufPbzxH3jVptyuASzExmxApjQoKy+2Bv1WKZ/EN2betp3aYKpuW
 LdlXNiTTq0qSjDkFok++I9CxOuwlol5Ni8z6JpVsn1JPRP4o6867nzUXkCeiqplebMkxsBV0vgi
 9aBv76el4AXAeF9q1Qclkb0HfYVHOJsYyMfAzcas/BPEGOOmEu88DlXfcP4LjAVPazeEN5zwDOs
 M0x5ofPejeGIefVduu6HeRUeLHuzm7MuUvImUSgAGTYcpZ+U4E28Ak5ifmUHEakS4luAhm0dw52
 a8U9fd11NvneMvaFCtLYibcfYRzVRbbfgfoVAoSMu0W7uUep8baUw+tEz1AF78ZGGlbhuZ4rmsm
 IGf+5oEF1EdeVH2bqDshxYCxfWAheN8Jha8DMFpEPHa5L4xvlfDbCMvvrByrJ1lRdN4ObAi4bEY
 dEI3refN+CI6JlrPPsIk9DV+pprTjJ4yncawVxxFNvZ/a8BBPNbT9WNZHBvZWZsUb+IpUIjJB8T
 4PhFdsczI68TF5w==
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


