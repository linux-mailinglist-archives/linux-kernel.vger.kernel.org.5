Return-Path: <linux-kernel+bounces-66110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C685570B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213A128F0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0514601A;
	Wed, 14 Feb 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nYISlLWx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19F145FF3;
	Wed, 14 Feb 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952453; cv=none; b=OkX/nqt8tJhGzU1f4qjoLfKjZG7HWzVpr0iZ34uJVWYCRGiB08fydIwlsKL/YTVSfTqTOg6mRmOOqx2VmlxoP2Cw/V5Y8ZyDErLmfMhHiBYDjCLjCMn1LA54ZKLstymT37AvZXAvWL6S1OYnP1+dvjJbYsumng02UnGkAcU2xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952453; c=relaxed/simple;
	bh=9+M44JGWsDWJYIbg9x3Eie/quc/6CSKv3btaL1mRVk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mK9++Vr8qwFZuwCS1NtY2iEMV1qgaaSOV9Gip6Q5bHe3156UPnbr0XzQKCQWluywXjMwPbsyXfL8qRzezyIG5osgbK+GAdL6EDHI5bjMFCvGM+cfhYG2iSP6U5a4DvQJPbQx8hB/EYl/5FjKu6ROv4UgyTCuelMD3OYPH1kQb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nYISlLWx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=49iqTWfS/7oGaeehgWp7vgxQU4YHET0VID5+MapWGoc=; b=nY
	ISlLWxsAC6LYs872WEaIwPQGL6ohm+NGpCk3V02m6hb0+iElzuP54/oahiBRVEUL7KKFXZuFtrc2M
	D8kJcxZzzgKydkEWgg79f2HdeA4AKHCNCGypqZe+IKjmZCOh6RqhKgAlsU50/sSMdL0dHazSyM4Sn
	PFgbk8YgbySfDD4=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOSD-007pqx-KV; Thu, 15 Feb 2024 00:14:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:22 -0600
Subject: [PATCH net-next v2 5/8] net: intel: i40e/igc: Remove setting
 Autoneg in EEE capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-5-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=9+M44JGWsDWJYIbg9x3Eie/quc/6CSKv3btaL1mRVk8=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkk+rR68hA2G2PyV777v/AUcs9UNwvnxswYZ
 A2Rl6AaeMqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JJAAKCRDmvw3LpmlM
 hKLQD/9T1pxSQXqLaiLLzt97eAe5eh4P4BlIJxZg5HlocwxaIeSSoaLGERNr/OWaT4TIKyGRSh/
 lZirct/22D1jAULjbl9oYWmQB9d8OOy9gXWKqp/80sCszIHwXJI0X6918X1bNsl2A390Wil7wSa
 2Ooi2TvFjVLveS7RDsggmbplfNeKdLQp7VmCWB38g9F4PmF2dh2EjSYX4d925lVwUt3kvXvI53G
 WlCNpJsZpt3VELBsJacfYDoYaFXhOAvXUwl/XnFVw9effCslhGDxGhKYKWZP88rBRDTN/P7iDyy
 dqQCRdgKqSbSDErdgHgrL87BCuf7zi7y4l0zb3g3L6Qk08AwkOh3Ct0cvm8DBFdisvtfFj09z37
 Peh4XLIPMRS9PbHiJUaus/LEim9eNkNZevLOEYG6RsRp0IoRrodKhGdFkNXh1RfC3oJJJPtxLXn
 rSz1K4nqFO9X2g9Yq7XZ/kEKTaajs7Ec3GQ/8Iaea/5V67HwgD2LA+bBCZfMhxOLJXiomLSrPJK
 qfqXSwBLPmKiU0iKISe9X5QNeHE9bi0u8LhwP7vHzR09cW7z/f+jH8pL0MeLxLRv3bdcmP6mzOp
 1UfSIvRKDjhnDyDCo+K4F925AKdrHB7XI0w57CqJZIGR1n8aGJp4OjbBgnlQ1Op0SQolefAhA1l
 TWVacQfReSV1M4A==
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


