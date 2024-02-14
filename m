Return-Path: <linux-kernel+bounces-66113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0127855719
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE15B2660C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DB1474D2;
	Wed, 14 Feb 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KTKfCbqz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC696250F6;
	Wed, 14 Feb 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952474; cv=none; b=nv2MJhMd9zgzQZtFYHHGyuDl7nSKaSImE9/7Wn2SQaEngwA27BKqAjg9FkFoN2YuRZ/1aG3H2l+Ro/zOm1vGHA5Mlnjw9Pvz7GgeE8PoH4SJ7tuqwTT8KiAlR5tR5EAP0ElMZEPxvesLEDZEYbeB6u9yWKTSTx/7+ezk404LpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952474; c=relaxed/simple;
	bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXkHEeDPZPWuiSw00XBrIWfbJxVaZ165Aw35Fex/jrft4JoT/9dcobI31tzBO/2SopNFWH6XTCZiP9RkzslwdkjGZrGgEU64fr+bNJsxAahURStpBoK0nbXlRGlHvVBbqm4/8pET2ecMqCMvrF88VwSuPLOc/v4pKqq50zWY2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KTKfCbqz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VwM8omFAb/USTaaRR/I+p2JFbh5V/UtXkfhHiw9cl4I=; b=KT
	KfCbqzHMlot+Qw4VoK7sWzsR5eTkkxy5tkQyuR836xwuSc8UenUGk1NAo3ocYCvRF3J2LZrUOm+zW
	o9JCPCeth3907YcUiVNDjKnk5Hgl3JtsqUG0RIBr0w2QeUiTwrqJjxgAX5wr68pBYWr4Sl8An2U9s
	jE8NNWhAtTtyv5U=;
Received: from c-76-156-77-114.hsd1.mn.comcast.net ([76.156.77.114] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raOSN-007pqx-IF; Thu, 15 Feb 2024 00:14:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 Feb 2024 17:13:25 -0600
Subject: [PATCH net-next v2 8/8] net: intel: igc: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-keee-u32-cleanup-v2-8-4ac534b83d66@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlzUklKe7j/H8r+mEvYMjo5M5wQh5Gdw3q5KAH6
 L4whiI972WJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZc1JJQAKCRDmvw3LpmlM
 hM1xD/4lxlo53phEXX7A+P7upo21SlhwgWCNZMC87FoevHKp68+yAODJhTyHVO3yo4u23qG+2+3
 wNMfeQuHGf3WU3WLoZI19M3MXvOvpaRuORsWD2dQE7RfWyTc96Y/+6nFRTJkHuPAF28DdbPT7dg
 du/5w20lBhkS6IP0IcJP0HBrdVysT45EHnfEBd+94BWl3V8ObTcboi3LOswuQzqUGcl/ODndHmc
 LRWGNt10pa4KnGYVN01LcghbfJxPWqf5WQeIPtIQew1+kCwkA/wtWRuDzG7qwrdVUXi+08sZfnz
 9U1SrZQT+bgCaUC07pmkLMhvmIJMgppqgNHPNcRhuw6d8bkLLsVIquS0OAScGxlaIQBzzP56I7y
 3PaphJ2FTOeNzVVbzpudFftXfa2y/7dJhiTVwajYimZ3sYTkOyTdhEuS+nJwLHVCBkNUN3MVOyc
 A59iMSl8qVyEZm5x+7/zrqcN17CEIiXkQQcnc1F94IvhUpj86R2WdsVKoMl0KJq3GAAe3D9YhAK
 ClQLSYI5P5Ld4msk2tuDKc8SAddHjnGNYrsjDuw7njYUNbzVuQjyiuBSvfrKClGVtFSRuJ7+YFM
 ARcRM8h671nefDkpmgYUmaE1ltPGHsWXymsy8Zbs1lVSOP98rMbc3wVr3pVFgmBsrzFZKYguQV8
 qIgXgkNp3fpbajw==
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


