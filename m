Return-Path: <linux-kernel+bounces-70455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5A859814
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DE0B20F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA874E0B;
	Sun, 18 Feb 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yc9l8/tk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67C745E5;
	Sun, 18 Feb 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276067; cv=none; b=ZQNH0vKoufrv+sqVT3FGJcZJGdeuuxw/RKo4tVSTMlY65vpO+qoPAJ+TDT+cO52JExf0db/yb4gA6BEM4krMApsrwaUoiTGaKCFU4fxUKZyr/jjDn73aj0OLXHWb3N99zPGzuG3cVoexDu8WklYbOFT7wySzUY2R70wp+Z0v8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276067; c=relaxed/simple;
	bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYYojPC2zFyBJpWVx16RIXm+WuXfMCYgzqOQQa3krPfW0jTnbNm5ihBuRz1udR+72fc905QNdVPJHe0IQ/dSKXW4q3FqTAOO4UmFYUZhDesQcq11Tyjn5WtU06Z+OtMZ1+RbHIsTsqL8y1uDOtbPe07DwXOP2KemeQwdIsbSto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yc9l8/tk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VwM8omFAb/USTaaRR/I+p2JFbh5V/UtXkfhHiw9cl4I=; b=Yc
	9l8/tkSqwjaElYJZfu/XA3cfDIXOFmDg/swedEeAVmxB2mUAH5wfpsuwODQ3aF04gGwkswjntUjDc
	7vK/K1lj4LIZMrJ2TxjfjX9P2fTYh/raj0jb83qv0C2E7akG3Gao8EjF/hZ1ad9yjQWIWACPfZB9j
	DsTqtqQDeTrRqO4=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkdy-0088HX-Oy; Sun, 18 Feb 2024 18:07:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 18 Feb 2024 11:07:05 -0600
Subject: [PATCH net-next v4 8/9] net: intel: igc: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-keee-u32-cleanup-v4-8-71f13b7c3e60@lunn.ch>
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
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=JUBlNHQ9KEInXfv/Ts82d6LWLEYOujFvKhAve8sOAdY=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jlBR1jCpUGgmoGhhgBBTwtCSWKQdM++eFeLI
 7FZYtP8Uc+JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5QQAKCRDmvw3LpmlM
 hAd+EAC/o1GrNt9qRvp7CrUNHCoEMKRI7L8QKnx0ZtDef3lGW8PNHh0YcY4ovJUxUT929XeeAEf
 jOnF4K05TU72oBh3svHIwfED0592QpL8g5cNHR7FoPQL6+KaczbLzb+y3J4+A31+oBaw5pX/TGn
 h9c+oWpkQy4Ut6f4fVpo7gwaFmfH7FVUlnRnKYVi+rEEyw9qvZ/gNZteE5sRQlKDuw6B3SUjBfW
 JtLRWd6b06gsSwi8lZazLessKtZ7nzyZiS0X1g2jcj9i/QP9IJ+tudfMEYHFf63p1PRLSdnhA1k
 tQfB5QGhEB0XUFLPd0YB+uqtd6yUycjIBzahOVGuIUx2nIrnHjGcGkwuJ/q3CZHPgQqwAF0sHrf
 KgENrYLWdbB2Fmh52QEn2+Jy0xBaAqgTELz4rOzWZxViNCYYxtzsBV8bqtaRu29D8Jc4ceUBG0m
 XTxIfyI1BxROvoL5OkF6j4qhQzKJ8tUxXVUHT6DBfIoXVEESJQCEN8lUwLHEHkWlYM8NHyjAJfq
 LeXpl2TIewsM3LpifPVU329mmPKaWVAIxAnpq+Pnt0RZry7B+DS5W9nXMFmb/rNO3wteGFDoCof
 YMj/0GxrECMSjqKlEEaEdlLa56NPgh19J1Oe6S1FR8IEG8iI/2fHrUIaLVi3qCeQ+yj7nuhMt6D
 cUPj0P35gT2jjKA==
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


