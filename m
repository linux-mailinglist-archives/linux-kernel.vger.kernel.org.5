Return-Path: <linux-kernel+bounces-51948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3288491C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA51B214DD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53F10A01;
	Sun,  4 Feb 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ACyqW11G"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F99BE5D;
	Sun,  4 Feb 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090045; cv=none; b=lpFO4Nfqtv+TBY0TI91yyavKLJHyAOnkQtUE8F+zTyCoZXdJJPJH7MfPBe9grinOcCfaCDOaHUAlygsfWpAPMoxUaTpIM03WjK8iWAYFFm9qgv9tvZcJep0Dg5hIqMaFXK29HbW2NPMhYVHaQZH1b6+Vwms0dAkoucY/IBseM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090045; c=relaxed/simple;
	bh=Cpjch1b1D9Jp2vWORWgwbDnErRScd5QZqvv0qT6yMzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loa1uD7x2rxJPmtFoWt8i9yNzg+ykDFMStGYxIR6nKNfBPZ554cs+DpwvkIF4OUYxhBOa9RFH9Bgp5mqk4jST9kKh5iltKVSUPZtxOnKoheA0puX4kpLUs9/hAIdeBjhHXA9R3UGAYWGCL1xhY2NKuFuUDn0kYfOVD3NJXazZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ACyqW11G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=sauFk9hjjr6pfRUCRoWd8WYck0QUyoBECM2fduhdkgE=; b=AC
	yqW11GQSsth0jqiJMmkoQvKInfmu5V9qNxon//vnegtjVdxg3I1jNSddotbXYx8zhCVbVqc+JqFGt
	WfpdQ9j1B3nCR98SlcK3JhrdtTPgfx2yadhAzlvhvrgFXw714lqDTDUNNqjsqrftdtA6KaZK59iDs
	1T1x5udWmwS0Sz4=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6G-006z7T-I3; Mon, 05 Feb 2024 00:40:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:19 -0600
Subject: [PATCH 2/8] net: usb: ax88179_178a: Use linkmode helpers for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-2-fb6e08329d9a@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Cpjch1b1D9Jp2vWORWgwbDnErRScd5QZqvv0qT6yMzg=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBoJEjpNMDvkqadpv9yFL1h1A7Hf4gta7ioS
 jqRDownKJiJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaAAKCRDmvw3LpmlM
 hAw+D/9nrVrHGFvrGdpbtwShUj8PZP0T7RCUAoJ6QYG56CQ2SmAP71TvYlHb3DASw4BWmQoA0V2
 LsthsrcZyDqnp2ub/TjkQkwTjmKjxR1ZpUQHcr5aQelUaEcbHtksNSRwweFkYxOjWISV0bTM7F7
 B5ByV1VebraSgmTmbm/y3kbnA0c4EY9mAErdGDB2F5Ff3tl4BsaHZ4cH/xyUb/IbmhR0OZF5mvt
 rmdtp0jgqkHle3Fv2O0uXvvuxxKo+pBVBmBYYrunWf+G3ClU0LysWaCp2rHvIRxKdbInGLOZBiz
 rg3Vj8d+g3YMwMuimq53fdNdocRi0UzP4TLtKXsXSngKhWtO7avR8GoG8Cu41LlDnl2RFx6vsG9
 1iyr1AY7pLkjImh4Izm5aHjoE1gKvpOgBo3CIptG9nyRr0i+Xmsxszdz+Y9mEZcyEjKyQ0ccAe1
 3K+LVEE6TwS1c60DA58q+sgf0ftr8J5X7fN/G6Z+lELW3hUERaMTNbpfQ2quSRFTLiaByJ4UB8o
 CGuvyV7q1rY8/Pn5dSq06oTZqUDYYhq4au3FsKynxlS2kFiteSasMDqZKGS81DLvAY65Gh+7pPt
 jTXBfGreO1lv6eYVwBxPBb3dBgzKphFugUDCOatb29/E/KbGH/qhHYGvflDBxQz5Y6r+vQ48jez
 lFnQVxEVru1w4Xg==
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


