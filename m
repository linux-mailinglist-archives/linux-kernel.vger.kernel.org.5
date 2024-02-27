Return-Path: <linux-kernel+bounces-82527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF508685E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2121F224D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FF54900;
	Tue, 27 Feb 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xYwaSpjG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6294EB46;
	Tue, 27 Feb 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997395; cv=none; b=J1rli8rXCApqHwuHgV3rjkVALfXLEcVK2Y3ydR1gbZXtRMZOVzKMELe+4q64QE/N30qVTwcJDApphSHRWHx6AUj5lwDlklE4iRoqvjvTAjxbhYNp2oHHC/ulrSxAJN0/UP0hg698vE7uQGOBdV1ZeZOp9tjOqK36SjtE6h2o494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997395; c=relaxed/simple;
	bh=jBShEoehGOiH3XARbTLV/6y5l6NHG5lC8OunACxocoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSEfeQY6XI4qA69t6EvULy1cyvJy5JruBL4ZnbNEe54YNDorvv7cWuDXb05T/IHUueRPkuyEy0C9NQJP7YwJjQfZxIoINZPp567prEQqlxzcZImdvOvhurzKAU2YANdHKa7vqSknJQZXRX91Vla/uUxkpgIgooZDHEm7S/0oyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xYwaSpjG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aFRnThzSsM1GB0U7YhBosyITi6QEbbLLMwyncP4eReU=; b=xY
	waSpjG/8yIZ04GvmfZkMkg0AMRp5Qwcw7r++vxTcroQBwcVxmufJRbde/Eb93KsSAekeappG34w0u
	LC6mW5461YzYAdRw+W5C99zW3LP7vioVYf5KrEDDhCQluAtKcswRrOCG21gWIs9RevN9Ylthr7RFn
	Lx39e8hKWnxpQz8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remII-008mef-Ho; Tue, 27 Feb 2024 02:30:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 26 Feb 2024 19:29:11 -0600
Subject: [PATCH net-next v5 5/9] net: intel: i40e/igc: Remove setting
 Autoneg in EEE capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-keee-u32-cleanup-v5-5-9e7323c41c38@lunn.ch>
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
In-Reply-To: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tr3raubFQ8HFW2KFMLfIharnyWq1PxptRJUM
 z7IXujVVW+JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd069wAKCRDmvw3LpmlM
 hNyXD/9VFYCPWBbqLTi4Om5etVHiQ001TRUWzhHFvlb3TWiIKQOUwS2dbZ+Luvh2ZvGSGyId2on
 ObqVmwpvC0ZL3m3aBWYUVLSfTe0t1eIUlyaJNcv3EYdntFoqXAoGBhWyWL7g+eup38asKtdyTtn
 tLCRnyXdLBrEX3AFJeRwa+tTCirE1y+0VM9XpvHrvQJfQKupX6YUqePaVXXlH09gZP/r0P5Biop
 nJgQDkXdqPNJrdPVaScaOX1YTNQq3ljZ8AfL0yBfWh303Us5Efe+X8Rn4jaSGzTCKtiqlrCkw8G
 FsJrJFF4IjKrARtJ6VeAr73eajWqvgkWv2rxQzgGeOXz6BFL9gzGLjhDk8Q8TCXk37AGVntOuTF
 Yz4MKjgKArUAy27QqhMiLBnznt/vfCa2AkJaEy2g47veGtLwR1xzNIVbKrHc9bFTSjwLir7BBk7
 kxK7395KMTk+JJvCi6NUdBg5ElP14Z6EOu2J9MhCKDgYR+CymGrLOCEKJecH59XGk4r/8jN3wml
 Mnj7qfkgHNcenWy4IJisF6N5dJeXqyVQ9xygP4utKZKBCOUnTqSpmSb/t7XaGogto/ZL3kGrkIj
 ccBSjnNt2Y6lg7yesENubADlJgcaMOEIDOHTc2mhQsvVgjNpdiu92ghOXxbDVT03RacDxm13IC4
 6u0QWGVHRfSl/DQ==
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


