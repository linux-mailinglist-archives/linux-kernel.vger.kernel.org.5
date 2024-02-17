Return-Path: <linux-kernel+bounces-70003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1C859198
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5901C2096F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485607F49E;
	Sat, 17 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XbtwDvdk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2B7E581;
	Sat, 17 Feb 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193371; cv=none; b=bYYU9K/lM4QxLwcJe5MSBvsXVAoLcDkspeCMNVsc+tiJHc6ZXM8JtriJ8dmDQUqCzus3LrxISwxfkxUqn0/Ux0f5VDCgEIZSEmwp61DKmCFu6+mac4Q5FfMy4XL0VL1hzdAKOJimkZ0P32RIC6GQSCfPymSxWF9VhLnFN6YPMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193371; c=relaxed/simple;
	bh=w1DJYkt9FTZRnNhfN8ZM1D8JVVgGCSqPVVQnR9uVLaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bm9/x0YMeKcKI/fqJLgWFzTKqEgmzl9w/qDfUh3RA3eBaUEhJljwnUcSRD4r/F5SQfd6k1UNlP7g/FLgpjpCzXvbqMwQBk9KA9//CgbGZx+PBHSKE831pPuK4vfVkuTlkmFoGMvSjacfoWYLZeyXw6K2ZVk6NQ+RKw4BhigPUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XbtwDvdk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bgkZPYVA0V4hJb/XgJ4JlLp2dhut1zemAO++lcwUguU=; b=Xb
	twDvdknCyspMJC3tsle5kDdlsVSH7Y8rcPHzAM3dSkJdTszsordejLyHEsvQVFrcoW65K8U2ybRvQ
	xRqOuyP0A7f5ffZdNDKgtmJWZBjKiNhI9Ty986g7fkAc6J2i6mszrVAaCX3XmDBHKpdaOveTYIEFH
	mQpp2GdhP5hY1Vg=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbP7w-0084hf-Dd; Sat, 17 Feb 2024 19:09:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 17 Feb 2024 12:08:24 -0600
Subject: [PATCH net-next v3 3/8] net: qlogic: qede: Use linkmode helpers
 for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-keee-u32-cleanup-v3-3-fcf6b62a0c7f@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=w1DJYkt9FTZRnNhfN8ZM1D8JVVgGCSqPVVQnR9uVLaE=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0PY6W0jHOX8rQJCKgVnosXE7coleas4hMNphl
 9WSc4SAKESJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdD2OgAKCRDmvw3LpmlM
 hEhPEAC0EZ9NyFSjjhW8MJZ3dOVD6+dXQdUHHJq8UOPPi2l79vslkL9v0u6TL10PRiZTqQHJnIZ
 TkIA0plVfEz6GPBDtJ8F3Hgn0T0jUYmMU2MZWWhR0DQIiUzixfZEBG+5E0SM0gaFyILcgn2Qlkp
 22N87QCZWkE2u0NjLtAOKBtvsFKBA7ZxkT8V3NDj53X+UAQrwFntHuackbRExRFQk/hHJ7mFRLP
 BVIzcojiUKC6lFB6D0CA6k+k0RlcTlM3f9cH/48q4uzt0lhEK45qA2LyzaisFpfWz51tU+g6PM+
 1nx7itpoWetPrysf5++maJ+Sggl5haRDivaULhVupqXP8ML3WKE9DiTfrZHfUXpQES9n7DvM9HZ
 aOMVA43m0Hmi/iYvJxfCrtJn9uo1wNupuxsfwXpoaqeIlViOcjNDo9imaDZqDNCbr/Ut7V3fiCq
 JL6/zptX7YCZ7swrI/JaSSKQXZ5KKaUB0Wn2rPseeFisBzsvpRJQtwpny3nfI6RrGsS5wzZ0tlp
 p00m4AGExsqT5kj2yJ5cyG3ZaYFa5EnVqD8Mq6bBi0qLu0p2pBFL9rS5tyrwIg2wt1n8PDtsd8d
 UDmmPw1qPnxbZIUS8/QsYHjlRN1K90g3rwStuRU6cKyYGymBv26+1Rt/Sfh5EjxFviA8LUGrK65
 XeL8b40aH4kWV+w==
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


