Return-Path: <linux-kernel+bounces-70456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C54E859817
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E06282A43
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15A74E36;
	Sun, 18 Feb 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="joiWyt3w"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878BA74E16;
	Sun, 18 Feb 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276071; cv=none; b=nY8XlV0a4R8FtZYFCIbrb2rw8C6WDY6iGpnwoXUA5YIv1CGF93Z63JZJxj2B6K3kW5zXUXrpCAnalmDyeVe9Leqfcmk/mysPNNorp25ukTPNRG2DaE/A1npgQRHPdqxvoNDpRpgMQSDg2FPr06RbQLRMdB2QtmL9Ps7MDC4eiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276071; c=relaxed/simple;
	bh=RuYxKjCx1KM7jfq1OwKbVsYU1FZNAf3c6Gkohmi02zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GD+nAXUsapvWqfUrgFzl1e2xk5PE0FZX1iyOopFm4yaECj9w6Z27A6XCfbhba7XeGypSraHLkta1vJan/ONX5/u2FPwktPmv7I7ff4ITRuz7NW7Z1qY2nYcEHrU1p/H2+ntBqAh3Lc4IihmvOYzBJ0vuet2xWYsDWA1y1cs5CIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=joiWyt3w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=K1/H/lO2Y/ArsDeyXeOvrW6auZKE79iZc+y+GzqiREI=; b=jo
	iWyt3wNQkr0ba9NPQR49VGysSetZVYZl/Z3LSOWJ58Zi725VzyYwtoLdURcMQbR6gS0S9aDaKdLnR
	zVUCRJPldpVlHgwlfMSB+g1dtn/SnH5h5jGh6HUJIhlbdMefBGTxfBXIPrm0zEz6t5c5xifrGZxOX
	6lg+9b1oTRUq0m8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbke2-0088HX-1c; Sun, 18 Feb 2024 18:08:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 18 Feb 2024 11:07:06 -0600
Subject: [PATCH net-next v4 9/9] net: ethtool: eee: Remove legacy _u32 from
 keee
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-keee-u32-cleanup-v4-9-71f13b7c3e60@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5127; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=RuYxKjCx1KM7jfq1OwKbVsYU1FZNAf3c6Gkohmi02zY=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl0jlBT9FVJM6jr1aNdxTyfnA2A/SCXlRGYnR35
 FjwQd/txRKJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZdI5QQAKCRDmvw3LpmlM
 hEmiD/45OjbJdmoKPe3LT4Pn6JzQpmCkgG+uMi3Q8A+XS780OsviI9D2SJBTB9tUt9bS9mBq6CB
 b24ihU5CFCSOgNYlaAjJ7V3HQvueqM1YQRhxtVrcY9dgxZqbMqdS1jM5kEA/atcffWugNjIpd9l
 sB4GvqWhsEFZVLofmmIf+g2pl1E4yGcR4E9PNsOm3hDxRPs7Y0044FEvCMeM1FaF9q8jGUb4eAY
 v1nh72ooROoPtZ0O9JSaSCTdoNrLxjLOD6Iod/1PBrkmn37qc0O6QEh26JFgCKTVgn5Hs7Ubi69
 Gt3fg6po+8nmeiL59eD155DwuyTqBLhoSs9vdonNpCuNhQBVtUU48esETVMGmShvbfKJo+NGV1x
 S5SeO5VE6ZrUGozQgl1lbANIzYRv9RjmChOh2WNK9aU329h2Pcm3YdkRgs+eB3sDUx2kixOZN2Q
 HrqPyMinxjko/SRQnr5G3RymMvvM2iGUSClC5iblmsiDlrc6dOgfdbuGjtOA4R/dfmS4JU9mGfC
 2/P1LtxwPhpUYuLNQ8bP76NxN7Ox/sViWTiKs32UznzzZFQBeJNaTbiYCfIZ2Y6ul02AUHPupxO
 nCMK8OJbrS6VBrk0FRPJhgH/2OgrtRrNkb9L+I+LIror0v4DVw+lsopECstrrnryFvbYo/WadhE
 o2ewBq29LTRAYuQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

All MAC drivers have been converted to use the link mode members of
keee. So remove the _u32 values, and the code in the ethtool core to
convert the legacy _u32 values to link modes.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/ethtool.h |  3 ---
 net/ethtool/eee.c       | 31 ++++---------------------------
 net/ethtool/ioctl.c     | 29 ++++++++++-------------------
 3 files changed, 14 insertions(+), 49 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b90c33607594..9901e563f706 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -226,9 +226,6 @@ struct ethtool_keee {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
-	u32	supported_u32;
-	u32	advertised_u32;
-	u32	lp_advertised_u32;
 	u32	tx_lpi_timer;
 	bool	tx_lpi_enabled;
 	bool	eee_active;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index db6faa18fe41..bf398973eb8a 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -4,9 +4,6 @@
 #include "common.h"
 #include "bitset.h"
 
-#define EEE_MODES_COUNT \
-	(sizeof_field(struct ethtool_keee, supported_u32) * BITS_PER_BYTE)
-
 struct eee_req_info {
 	struct ethnl_req_info		base;
 };
@@ -41,15 +38,6 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 	ret = dev->ethtool_ops->get_eee(dev, eee);
 	ethnl_ops_complete(dev);
 
-	if (!ret && !ethtool_eee_use_linkmodes(eee)) {
-		ethtool_convert_legacy_u32_to_link_mode(eee->supported,
-							eee->supported_u32);
-		ethtool_convert_legacy_u32_to_link_mode(eee->advertised,
-							eee->advertised_u32);
-		ethtool_convert_legacy_u32_to_link_mode(eee->lp_advertised,
-							eee->lp_advertised_u32);
-	}
-
 	return ret;
 }
 
@@ -62,11 +50,6 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 	int len = 0;
 	int ret;
 
-	BUILD_BUG_ON(sizeof(eee->advertised_u32) * BITS_PER_BYTE !=
-		     EEE_MODES_COUNT);
-	BUILD_BUG_ON(sizeof(eee->lp_advertised_u32) * BITS_PER_BYTE !=
-		     EEE_MODES_COUNT);
-
 	/* MODES_OURS */
 	ret = ethnl_bitset_size(eee->advertised, eee->supported,
 				__ETHTOOL_LINK_MODE_MASK_NBITS,
@@ -154,16 +137,10 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (ethtool_eee_use_linkmodes(&eee)) {
-		ret = ethnl_update_bitset(eee.advertised,
-					  __ETHTOOL_LINK_MODE_MASK_NBITS,
-					  tb[ETHTOOL_A_EEE_MODES_OURS],
-					  link_mode_names, info->extack, &mod);
-	} else {
-		ret = ethnl_update_bitset32(&eee.advertised_u32, EEE_MODES_COUNT,
-					    tb[ETHTOOL_A_EEE_MODES_OURS],
-					    link_mode_names, info->extack, &mod);
-	}
+	ret = ethnl_update_bitset(eee.advertised,
+				  __ETHTOOL_LINK_MODE_MASK_NBITS,
+				  tb[ETHTOOL_A_EEE_MODES_OURS],
+				  link_mode_names, info->extack, &mod);
 	if (ret < 0)
 		return ret;
 	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1763e8b697e1..5464f237d8dd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1513,9 +1513,6 @@ static void eee_to_keee(struct ethtool_keee *keee,
 {
 	memset(keee, 0, sizeof(*keee));
 
-	keee->supported_u32 = eee->supported;
-	keee->advertised_u32 = eee->advertised;
-	keee->lp_advertised_u32 = eee->lp_advertised;
 	keee->eee_active = eee->eee_active;
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
@@ -1532,6 +1529,8 @@ static void eee_to_keee(struct ethtool_keee *keee,
 static void keee_to_eee(struct ethtool_eee *eee,
 			const struct ethtool_keee *keee)
 {
+	bool overflow;
+
 	memset(eee, 0, sizeof(*eee));
 
 	eee->eee_active = keee->eee_active;
@@ -1539,22 +1538,14 @@ static void keee_to_eee(struct ethtool_eee *eee,
 	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
 	eee->tx_lpi_timer = keee->tx_lpi_timer;
 
-	if (ethtool_eee_use_linkmodes(keee)) {
-		bool overflow;
-
-		overflow = !ethtool_convert_link_mode_to_legacy_u32(&eee->supported,
-								    keee->supported);
-		ethtool_convert_link_mode_to_legacy_u32(&eee->advertised,
-							keee->advertised);
-		ethtool_convert_link_mode_to_legacy_u32(&eee->lp_advertised,
-							keee->lp_advertised);
-		if (overflow)
-			pr_warn("Ethtool ioctl interface doesn't support passing EEE linkmodes beyond bit 32\n");
-	} else {
-		eee->supported = keee->supported_u32;
-		eee->advertised = keee->advertised_u32;
-		eee->lp_advertised = keee->lp_advertised_u32;
-	}
+	overflow = !ethtool_convert_link_mode_to_legacy_u32(&eee->supported,
+							    keee->supported);
+	ethtool_convert_link_mode_to_legacy_u32(&eee->advertised,
+						keee->advertised);
+	ethtool_convert_link_mode_to_legacy_u32(&eee->lp_advertised,
+						keee->lp_advertised);
+	if (overflow)
+		pr_warn("Ethtool ioctl interface doesn't support passing EEE linkmodes beyond bit 32\n");
 }
 
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)

-- 
2.43.0


