Return-Path: <linux-kernel+bounces-66106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17C8556FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678B61C27D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBF1420CC;
	Wed, 14 Feb 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EcmZlUX1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA68662D;
	Wed, 14 Feb 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952444; cv=none; b=pTDRFHkih9ch9ql+gDcMvAJugZH4K7K0muGDbWN3LEVoKvpHRU7QEeO1coIbO/nOCkWkwEYSoNN55Tpy51/lVsE2e8yq6u5Bhvcb9OLdeP7ymIV/7Rh/uURPIGbjAzMTvJZ5busFHe5meElnRdGDqhcuKSSPkHl5keIrjoc/gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952444; c=relaxed/simple;
	bh=Cpjch1b1D9Jp2vWORWgwbDnErRScd5QZqvv0qT6yMzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJFPHdY45EVHKi2h0NAfgn/nNKAa6eE0vmVsEhcyz+w+AfKJlDq2avYRW0FB86Nl8CDnQ27QYkDjORyDTlRi9ZIbs7NHobL+sboWBSn3oxeqiv0TmVWhzbcKGAym+WmxbV0QVEdgptQv3IVvRUszX2sMpM2rcVZkyTPosVmdBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EcmZlUX1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=sauFk9hjjr6pfRUCRoWd8WYck0QUyoBECM2fduhdkgE=; b=Ec
	mZlUX1UNq6CGMMG95w8sPC14i27KZlqTSZGKA57NsJlVIjQ9FwBDhHwxtaz0l7cr9Rq8uq8kM0WZ3
	92UOvFqNHTCZ4SfH3RNOO5NPv6bFmkB0tAfrilrUSTg7Va5DRXNIWvPu2njlgshDVWGx3ylPCQDkf
	BsYBfLxCM0LqDK8=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOS3-007pqx-Ma; Thu, 15 Feb 2024 00:14:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:19 -0600
Subject: [PATCH net-next v2 2/8] net: usb: ax88179_178a: Use linkmode
 helpers for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-2-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Cpjch1b1D9Jp2vWORWgwbDnErRScd5QZqvv0qT6yMzg=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUkjg41ZWDOkDbY4cl40Mp4plWC8lPr7urE1Y
 xR07ZdFiaeJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JIwAKCRDmvw3LpmlM
 hN6FD/9iVloxbhIqi9a5XdLaZHPNJhtehuPbEtTJcduK9CjOBQJo3/YJ61KGd5GbWhYvcbJUM3p
 4ORL4n3zpsPJLCUpmyb5AaBpHGVpl2jVow+BXmYTq3ak0SAFy6sZEE9jH5csHzwd3VLbG4Aaxey
 YCYCdG/Lev2aCsILsqNXLSVlW4pe6bx8qGmhulchBIj6VfjJfbWJjC1DiIRtuUKvQ9SFLm27TvB
 sQTf6/jPPT4O2AlgHq+DtIie2a16S0KezI75fuNiBzY2g5/uefVcHq9H++6tAKo6D8ySCG/lP5f
 NVpTZA0/7h8yDd70FNNOxb89bjpEnWUlJrE/bS8ujD3LU83Ii02+e4z7jrwTCnhc6HeiByrWMVm
 soxaZ/7BEhvn0D3tQEwjRrQyWizBT6Q1P2M1pAGPq1rVPoqC206dBW7YdZ2Gx60O94+NACvUvYE
 DmJZ6yE07Xfnec7nQKx44bqjfO1Z5ciykD7+m8QlfJ3hGgaS6B5raS1q5t3qP8NnHU/4JMNvp72
 R2vojGJspg8mEglMV6ZY5zzHE39B02NfEPQTqBGz9k+dgO7TtfTVADuCnO8AzvUAoYuvC1fwht0
 2rVfbJluv7EynpimelGOXDCkEURXHWnmD9calR7xXpQmbKJs5ol+gtF0Th+v4CSxDiAxBVrl0pQ
 T0gvmhUd+Tq087w==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d6168eaa286f..d4bf9865d87b 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -676,21 +676,21 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 					    MDIO_MMD_PCS);
 	if (val < 0)
 		return val;
-	data->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->supported, val);
 
 	/* Get advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
 
 	/* Get LP advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
 
 	return 0;
 }
@@ -698,7 +698,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 static int
 ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
-	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised_u32);
+	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
 
 	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					      MDIO_MMD_AN, tmp16);
@@ -1663,7 +1663,6 @@ static int ax88179_reset(struct usbnet *dev)
 	ax88179_disable_eee(dev);
 
 	ax88179_ethtool_get_eee(dev, &eee_data);
-	eee_data.advertised_u32 = 0;
 	ax88179_ethtool_set_eee(dev, &eee_data);
 
 	/* Restart autoneg */

-- 
2.43.0


