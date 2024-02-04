Return-Path: <linux-kernel+bounces-51956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7238491DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9610281C91
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3233CCC;
	Sun,  4 Feb 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a11NRg3H"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD7DDBB;
	Sun,  4 Feb 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090065; cv=none; b=uOh4KyNkVRiZMrqniXgkW6Xpxa3XB/DA6C0b51IJeZMlOfPtH4t/zCL9u3jNW3BI8q71sIUa3kerKUy99aOnhfQk4Cd/PHG+xoEzb7LtRSI/wZjqWOHLGv7n7yPZNF3RHJ5mtHlsaNtzuzxDYLupFfVLaakrOondnsdtalC2JOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090065; c=relaxed/simple;
	bh=GY/i358jYl4X2zeywHliUg8zbjHunLh0+ZONAyCsEDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAI++OIheVavLbfGXqVxUnmAvAKR5YQe/WKvqPkiKplhYqoxLFgxVcKvl6sQJtj8olYh27MsTRZ7KCirrGhSRmU5MMl0igljjwrG3xHiwkVFLGAM2K2uq0JzT61JxH/aTnIs2S3rGnA5BtrlS8TiX3ZkLdKdcGxFVBy5Omddj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a11NRg3H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qhzUzBBE/ag86Iuv8pKOl72IzBpodGhMjRQDM/+8K5Y=; b=a1
	1NRg3H7ioa/uQU6pi/ZYzRyp/9SW1iXD8TQh21Su2H/FGxpmTEIhW/G1CHiBRuLFnRY5iuX1nar71
	Vp/lgjZHmQODZsHCwzFL6WN98kX9yVukadk/EWHaVtIb4yyrDBPkzfpz6q9sX59x1yZZD0w8IihVb
	xM4YFFx/kjoZQLA=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWm6a-006z7T-7L; Mon, 05 Feb 2024 00:40:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:25 -0600
Subject: [PATCH 8/8] net: intel: igc: Use linkmode helpers for EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-8-fb6e08329d9a@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=GY/i358jYl4X2zeywHliUg8zbjHunLh0+ZONAyCsEDA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBqchq37ZWAaCXguBx3KZrCunBRHw7lO6YQI
 BGeHWL/fxmJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgagAKCRDmvw3LpmlM
 hP3+EACmrlqVvQVpi8hIGv7u5kcwmZhDfq2v8zuE8ahroCH+WVKmtXgT7ujGkPXLj5rrHSNQ/Tb
 oc2Gm0y9F67PRPsKstTJE6dA+6MbKjAt6WBUiVEQq/FKf5rRumNLyD1zJa3qQqPckX1QCdLS53R
 jS5ub1Kl29ZaY1uVJSM6maQ6TLbJDCO0fihwjnPzrQjM8yeRdCakWGGi1zOSmwqqSk53LiIk9/+
 szNw6xdTqY5leQVYyCoc+iLPDMCqeO7nMnUzXwzeaPRv9y0EU676Gc06lOKBP2X4xDU6xHZqTcu
 SKzpM9We/Bgd2sKHPUEiuywZv+OOeKktgaTksyQxG6Q+TXfLXdYAFx0INrkOb1duE9nY5nGZdPG
 6/zXaCs2uwEHbGyEowgLAGCli6RLOMmMALU02Ti+Xc7GCXB9RuyiPhe1BMZijpEvi4rDKgTSifB
 sLkyNIgCwf31Xm/KGlZ/aGdKMS8l0Bnn+ZViQhpfHkWyjtSEEfY+Gu6845mPQt7/FXT4hRo3E0B
 TL1SUMeyGbGcb4j/OtcSgf3p6Kq1gMJgCaePXLGV5Nd3idrfpE9+LNZVPa0PSq6HvHm4hLnNhMP
 zZaFrKD+qEymoaFGnDIrjnkeoHcqtpFNI+rza8BkAxh6WVJLybo4W4ECsNFYch9pa5P7XNJOUpc
 hk4xXG7KVvmucew==
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
index e9aed4069ebe..e9d78bcb0201 100644
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


