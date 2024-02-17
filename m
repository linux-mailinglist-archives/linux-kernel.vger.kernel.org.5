Return-Path: <linux-kernel+bounces-70007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAAB8591A3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6FF28174D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8880052;
	Sat, 17 Feb 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+uWf32b"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1D80038;
	Sat, 17 Feb 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193379; cv=none; b=PxMj/WYZ1VEVqWv1aImTVx9K8+1EnsQXFcnyZKM3MLYiDh71//XAyMOtTpgEAhrAbMxPfKRMmo4/s+FmytXIyBOdFqU5j0CdkGKZrnrKRysxZYGaFZRIoziNElwdk50flXFllF5+gLUGTEfscHHhhjUNXmb80ql7F20STIPPazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193379; c=relaxed/simple;
	bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5AtO0D1x/2y0QbUXc3Hro4HdjNEmTM8mA/X80en1JbQlV2Ydxkn+L6zrLTSpY6Hl4QxNAkdOSqYYZ7xnYF82zJ9GWyUDYS+7sotmF81sAsXpzvBM3PjGC7Wnu2WdviNoEysUp/qauLzm0d7QCiPeITt8BQsr3o0VMzqZHIIdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h+uWf32b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VwM8omFAb/USTaaRR/I+p2JFbh5V/UtXkfhHiw9cl4I=; b=h+
	uWf32bDXfJHQJlMFbKO6z40qckTpR053ZZDrThpza8HPRCmYD5+qyuRiRGDdmFlLv8TlW8ISUbj6l
	boeUJRLC17kMIxYbNl8R5RR3C0kThhxypeYpnT0A5tY+DOel5jDpbWI0BrBzZ/v2tEPqfPj3jiOSD
	M5wzXybhUhJhe5Q=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbP8D-0084hf-KD; Sat, 17 Feb 2024 19:09:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 17 Feb 2024 12:08:29 -0600
Subject: [PATCH net-next v3 8/8] net: intel: igc: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-keee-u32-cleanup-v3-8-fcf6b62a0c7f@lunn.ch>
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
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0PY8QswMZXFgclyrmiaG6Mz5z1C9NpM6VoMTr
 6lMSfGhKCqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdD2PAAKCRDmvw3LpmlM
 hOLjEADIAYAUBqeIHdM2i1gNP2BQ6NHP0THsFP5kUpdF+K1kenJv0qXrOFtwSiazeWwckU8rDDa
 iU7BFilBn0lFc8ts4/NhsGYy6xlEsCk8k7aRc9OzEnsQMm/YzEutyHJ273avPL+41R8aMG9/e7+
 TazrzAWDTXwBi1VPIQlb38Oim45OPghmPCAIfbd287xo/AFoQjT5jeITBBO/WE3/Y6LolrMLxK5
 YXcWxlJaL7J1r1wKMp6U99icOY6tid1XdxZ7J3Ue5jiPmZxsDgSeIzT4VRaYbfJ+NpjuL+sdrqT
 Hh1FImogd5Ebu0vwkSB6fTt32/FR8+w2R4WFYkqNP8esEDlWabLkPFwBP00S5icCAz3KvdodWet
 G7PyjZPBC9CP+w2CIYs3FOL4G2JlTDRnqb0as5Oyx1Zn9FGQucl17WqV7nA5itVuOxFT8KS53d/
 ysLkTQL6B8GetPqlskK1uSTbFkYDFKknZPsvtD3Uq20RjywJ4ILmEIWcNLGh04XhZAjAlZQr8Yd
 63V0Gmq+nmEWZ3bE/vZrbf8382A9gzYMNjq4T5tlo2fApr1jj2T38h25dr1gfERwjaG9qkh6Cnl
 lvhAvXj9DyYwb0ZWcOSAqGLl5tyXkIZ8Y3Ip3U4Jp2CaMCalhsJ1nL7f4yNdOpBQgVfh1EfssjZ
 rghfWW6fjwdPtCQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index ac92d10a3e97..1a64f1ca6ca8 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1630,8 +1630,8 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	u32 eeer;
 
 	if (hw->dev_spec._base.eee_enable)
-		edata->advertised_u32 =
-			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+		mii_eee_cap1_mod_linkmode_t(edata->advertised,
+					    adapter->eee_advert);
 
 	*edata = adapter->eee;
 
@@ -1653,7 +1653,7 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised_u32 &= ~edata->advertised_u32;
+		linkmode_zero(edata->advertised);
 	}
 
 	return 0;
@@ -1695,7 +1695,8 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
+	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
+
 	if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
 		hw->dev_spec._base.eee_enable = edata->eee_enabled;
 		adapter->flags |= IGC_FLAG_EEE;

-- 
2.43.0


