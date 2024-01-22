Return-Path: <linux-kernel+bounces-34185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D7837552
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4789F1C28D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA5495E0;
	Mon, 22 Jan 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZF7CzXC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DF495C1;
	Mon, 22 Jan 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958985; cv=none; b=QowckRyjXkLK8Cc2ktZicT7JX1prVQIny8MjavjiBnTBMqsfdx4hKHl11TS7xlVu1hcSwt+YTpYF3FyWt2Xbk38Lb6Umi40O5UunnVSaH6bZdkiBrpMr46A1DC6h+bKmWYPJ0x9BszBkllBPrWyS63p/eMpBBluxhiK+AElCd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958985; c=relaxed/simple;
	bh=P9kbg96h8nA+vzLjsIPg4kILNbxrfwclXgGSuVa0iV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcB03xiR4ukyiteOPOUv3HO7GsL0QO6NlR/1c+8aBZMDqiyTalYf3WIdPmxS2QfSGvrITbhYYLK2wWyTMkgJeAWk56Ydt0O+EFmcXOURuQc5MLeVFBBrlztr3P/IM/eSqsUlQl+Ia8o7NnBokIBLGsv1sM6bIxZHsgOyubpufUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZF7CzXC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so384526266b.1;
        Mon, 22 Jan 2024 13:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958981; x=1706563781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=ZZF7CzXCpOsRuH9joj/zRy5uoHcxQi6iQob7AgG/RJqMzPNx7ixHT+a8d0hI54bjAO
         TG7mJ+5jq3k45+cacqikFMK6JkcDHlpg/oOnm2BJ19n5dU9imLQUIssvWa1qeN0HKdJR
         Hpr7U7LvnnpVZet+Qda2ZBHNEbIjgLNJgCVMOO80Vgd067bO3FYOYUrx58018RTJMyck
         YJE1ozY4xyQUHvivUc9xYGxPxCqeH8cnNCC3rbLXapwN4kQ+p/4ORZ/mMt8znyXhGPBj
         LH3bXfXuQVo77MGalF4a0PDPJRBbcH/tkIJaCWnOX2ZkhSbAjSA8kHuwW1uEdsPyB+DF
         LyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958981; x=1706563781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=hlrI7k47bYRDG0Cm4m2p324U/dBj4qHrTJdIuQ7Uq6kXQSn6uKjN8ZtF2briftg7PE
         PYeG9a9HX2s2MIbQ+Bq4E4b+R3e04hPq5NuWRjFmnr4M5rxGHKgrqpZEWoowD0vvYckl
         MW2O2OyBX3B4m6kaNLXu5/O7gq9Vy56PVizefQU0TZIt7NBCupJ+KrLpnqpjV1M6vfMg
         7gy33OVl7zyin7Yy+ZAZoigayILGnB+aaYh3T8xJNnqJMrmuaFptYz1+SCWQoovMST/O
         H/6e8xi/561IGPjEWZYKJxShZFW080v+yEs0zCeyZNeiw+TvNxRaIqILul4kDK3vfcyP
         l/zQ==
X-Gm-Message-State: AOJu0Yw9wEEZU01l/BmEXmXvi5gBaybasUq3jeGrW75QUzG3yfL5zTmt
	0lkL5IKxhBOeHNF6mRjQs23zAroFpc59dPW3pPAFfPpozekocflJ
X-Google-Smtp-Source: AGHT+IE5LJOIE9k3df9dlH8iu5nDtZ9w9DUSHlza5TVbEs++MjeSoe3Pzyu3dm/kg3ZQTK7Az8K3WA==
X-Received: by 2002:a17:907:d8f:b0:a2d:2121:2a93 with SMTP id go15-20020a1709070d8f00b00a2d21212a93mr1778897ejc.70.1705958981705;
        Mon, 22 Jan 2024 13:29:41 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:41 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next 04/13] net: phy: marvell-88q2xxx: fix typos
Date: Mon, 22 Jan 2024 22:28:37 +0100
Message-Id: <20240122212848.3645785-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
Fix linebreaks and use everywhere hexadecimal numbers written with
lowercase letters instead of mixing it up.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..dcebb4643aff 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -14,7 +14,7 @@
 #define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
 
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
-#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR	0x00FF
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LINK		0x0200
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_RX		0x1000
@@ -27,6 +27,8 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_RX_STAT			33328
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -63,7 +65,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		 * the link was already down.
 		 */
 		if (!phy_polling_mode(phydev) || !phydev->link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -71,7 +74,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		}
 
 		if (!link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -95,7 +99,8 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 	 * we always read the realtime status.
 	 */
 	if (!phy_polling_mode(phydev) || !phydev->link) {
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_100BT1_STAT1);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_100BT1_STAT1);
 		if (ret < 0)
 			return ret;
 		else if (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LINK)
@@ -200,7 +205,7 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	return mv88q2xxx_config_aneg(phydev);
 }
 
-static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
 
@@ -208,7 +213,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		/* Read the SQI from the vendor specific receiver status
 		 * register
 		 */
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_RX_STAT);
 		if (ret < 0)
 			return ret;
 
@@ -218,7 +224,7 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		 * but can be found in the Software Initialization Guide. Only
 		 * revisions >= A0 are supported.
 		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xfc5d, 0xff, 0xac);
 		if (ret < 0)
 			return ret;
 
@@ -227,10 +233,10 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 			return ret;
 	}
 
-	return ret & 0x0F;
+	return ret & 0x0f;
 }
 
-static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 {
 	return 15;
 }
@@ -246,8 +252,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q2xxx_soft_reset,
 		.set_loopback		= genphy_c45_loopback,
-		.get_sqi		= mv88q2xxxx_get_sqi,
-		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 };
 
-- 
2.39.2


