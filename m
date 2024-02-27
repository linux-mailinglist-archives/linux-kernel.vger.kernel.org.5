Return-Path: <linux-kernel+bounces-82530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FC8685E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AB828AC84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8035629F9;
	Tue, 27 Feb 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t4OdcNFL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E25F843;
	Tue, 27 Feb 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997407; cv=none; b=hBm43XXCor6eBbFYhAMqwo7zrWJoi5NUYUgC6l+mpWb6WkglQ7eoD0ajIaJb+G1EH8NVEjVLsYRR+P9qTUQbsnTcSfA361y6xAEOtdz9zvHOI+i6HxiW9S8NmDZJyRUM7NhOE0To1+J/AP+sBQIdnCp2BV+nWlC3GHUqG4kXcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997407; c=relaxed/simple;
	bh=GLbpN+b7fMBqkKjjmSHSV3wUD/JZDYXsfXRADsHf3lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uquoOJ+dePCbtIChlVmhyOETu79WJB4hJmeFb1f71rsOQUOMusoH1EIYHtLG1VSlwiVM2IpDa8Ia31oc6CY5NddvTtSYrl+lpI1JFPPHQa9fNzltocM3vH7KG/Er+fm8lIrGJUqnkKk1/HO6B17URah5lPcBmWrDwU1KV8/vQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t4OdcNFL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=j7WYc5BzjQwZP7iBz9OnwnkxvlP37ESIju8ZWgAQlho=; b=t4
	OdcNFLj+zXpkW3FNqm+geAzwHTeWjn1j9BtBIWQOHK/CRtNac9RVnxFVONYXrhIOaw7UfJ0OL/ehn
	tVq8cfUNWS5fucQ3kE9tvlk1g9RMyrGwQCqB0DxVuWkTYiCvF03gyji5bml0m2m01CrVg38M+TZCx
	vxas57mRZkVIIuI=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remIS-008mef-Vz; Tue, 27 Feb 2024 02:30:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 26 Feb 2024 19:29:14 -0600
Subject: [PATCH net-next v5 8/9] net: intel: igc: Use linkmode helpers for
 EEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-keee-u32-cleanup-v5-8-9e7323c41c38@lunn.ch>
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
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=GLbpN+b7fMBqkKjjmSHSV3wUD/JZDYXsfXRADsHf3lg=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tr4FL68PUOtdpjKHIPxxcexRCI1y4UMd6Vlr
 rSihWxrcCaJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd06+AAKCRDmvw3LpmlM
 hP6ZD/92rT0gKDX7pqllheXiCM8p+u2G+QJdNENffYdQYlQoBxfqyPxkjGUzFdxb4shj4lB6Th4
 TYWtB4GP6JqMZjF8WyVCsMoBtk2naQmvlx/ZiJAtlez33qAP5dxVzyliGkttt8yPzszdM3k43XS
 Jqteqs6QSIGLV5cCzbFQjKN/rmvh/nUo1TeZbtVny2GaxCTLrkRtf4+YmzjumeqTLON/QyUyMvi
 a9HX1XfxT2d2Ma+aGx5evt3W4lwrXXXOVxxmzNv7i/ZD6IolovhsyVYI9gUsWILgjVBW4D+DQrU
 XO2dAq9nCwWALBFDRqrZZH2hYJO8qy2YEvxtwivOlQdDu7Luz9xhnjLJWNgMdg9Teyz/6wcXdjp
 PYMjgiXcfl2lBroeyviIxzCQjqa/vpyyuXKPC3b8irAI7p0RI6zA2yw6gWa2izIsgHduvATA4es
 /27pvw5+jCgN+X3Il/ALjzDuE8YNhOJe/i+sfTh9WfSDv7tsVDJnqZxvp/3hBbNxpniAsApDA2D
 HvvaasZdaeAUI4z9H2t8q193+Cr2bmmzz8L0Z3gcilVooVu6Hqt84oH7Q0R8bPk/L3bt3iBCvLN
 tF4KDHOwcQaFmWEdDPXpDz+TmxkT8sYSABRIU7xysRK3ZHQE9KixbdmYgi+mQhkEY3AKpID4gyr
 KwHp+THDbG0XsOQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Reviewed-by: Simon Horman <horms@kernel.org>
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


