Return-Path: <linux-kernel+bounces-114820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D78889189
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4D81F2D6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55C278691;
	Mon, 25 Mar 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFvTsdle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239ED5A79B;
	Sun, 24 Mar 2024 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323440; cv=none; b=ZeToIPuLD9U6NUAifzQQKr/sp8v35vj+WU5r4Q5niENr/1umxn9zfY+bI/vptwuTJdpJ+TfiYeCu11Uhxcq5DX+qH7Jap7KLi+OKCVci+KPJwLWTEcR8O85QG02jS1IWxpckPM95Vjy+abtT/ds5FbMxsCp6EcC6wdDmppDL5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323440; c=relaxed/simple;
	bh=V9bjB0fUZ2b6dT4tw8jYu2GTeYgTxhfwf2mCn1A+8N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdUG91VpzTRn+x7TWtP1w5R26zx5/RARFsfyeZTRUdnarYfC1aX9X7UobvFRauV7VVuRb6ogYNn72+yi4RiBoAQCgkXKOxN5+NbQFLwIakCEeAanI9OBq7lOyPZS3CO8irf8ZgLJSjZJhCRTBWU81TAeyVI8SGh9iN9imZkEfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFvTsdle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA2AC43390;
	Sun, 24 Mar 2024 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323439;
	bh=V9bjB0fUZ2b6dT4tw8jYu2GTeYgTxhfwf2mCn1A+8N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFvTsdle90UkADpjBI5nqG21EMQRE14UtpN/YIBYeyRvQsHgFBht+D+6ljegM5nES
	 xMGrqhXMlhZbHoqHNXpI0yxGOH70w+bWQvEKW8gn+WQisa4EL2v+24j3ADRY1BEn4e
	 LB90eKO6jvBZDknPhIE2GheUnwZ+2tefGgakW7mnrfqflIF8er8/SH8DqM1auGj0L4
	 mxSYT6ZvYpDji84U7tOZ8aLSn6hvoGnfsOy+1qdm8eTt9Pq/5qdaut/dtggcypjZQI
	 50AIu0oxIr1lbi/yoHoZD3kiFBdeV0X5syVgQ6G8cYjib8UmVylHCgFCFWUgxOJIvv
	 uFxZ5ZaPcbutw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Alberto Bianchi <alberto.bianchi@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 141/317] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
Date: Sun, 24 Mar 2024 19:32:01 -0400
Message-ID: <20240324233458.1352854-142-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

[ Upstream commit 621427fbdada788f18f77238e1c36f463c2cb9d1 ]

RGMII mode can be enable from dp83822 straps, and also writing bit 9
of register 0x17 - RMII and Status Register (RCSR).
When phy_interface_is_rgmii rgmii mode must be enabled, same for
contrary, this prevents malconfigurations of hw straps

References:
 - https://www.ti.com/lit/gpn/dp83822i p66

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Suggested-by: Alberto Bianchi <alberto.bianchi@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: c8a5c731fd12 ("net: phy: dp83822: Fix RGMII TX delay configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83822.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index f070aa97c77b4..267e6fd3d4448 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -94,7 +94,8 @@
 #define DP83822_WOL_INDICATION_SEL BIT(8)
 #define DP83822_WOL_CLR_INDICATION BIT(11)
 
-/* RSCR bits */
+/* RCSR bits */
+#define DP83822_RGMII_MODE_EN	BIT(9)
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
@@ -407,6 +408,12 @@ static int dp83822_config_init(struct phy_device *phydev)
 			if (err)
 				return err;
 		}
+
+		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
+					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+	} else {
+		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
 	}
 
 	if (dp83822->fx_enabled) {
-- 
2.43.0


