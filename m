Return-Path: <linux-kernel+bounces-114985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438B888CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7085AB2D32F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BE2E2D35;
	Mon, 25 Mar 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKVDcEXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDA17B509;
	Sun, 24 Mar 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323724; cv=none; b=Lip1Aauxc1FttVTL0b5YPpgzRqoV6CiaCp24Opyc7pQDwvxzV12FannsprT+bh+YAbyPpKjRBcnzq5gyBpbNhArM3zYpkQ39oLHc5uXqydFvZCEBIszkOfboY7n6bnxXGp39q6aTR5eMwoVvz6nm0q9v6d9rQmSsfBLj+ZGd7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323724; c=relaxed/simple;
	bh=wTx2CP0rQOPjoKpSAi8r0GICFQMvOfBkNPFf9R3b24w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwIbj8OHjYIwudEZSXS78H+qd6PIe24VBSO74HrtKZR9MT8wh/cSwzYIOQnd2Cr2s6hFmY7wRRQHMF43Drb+H9eL9QU5iOfu2QQ+c6N7UktWdnoBKq9716iRGs+vLjeJLwSJ7UNPxOiLCahKEI+fPhQ7kC25dU3taP6ARYVEOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKVDcEXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AA8C433A6;
	Sun, 24 Mar 2024 23:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323724;
	bh=wTx2CP0rQOPjoKpSAi8r0GICFQMvOfBkNPFf9R3b24w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKVDcEXmVTlUt+yV/kg46kkOkfErAaoyRqcHMQxZrk4MzeEcqM7GWFu2FeNBavRvw
	 5NdKjWHpl3/ggAwZDyi8LpKdgjna+/czSRh2fEgVnxV1yHqV/b9vElA4ripPUs2nYU
	 606KIEXeKW1FrZkq4M9K78Sfmyevv28CGclI5MPpYaDaSUD9NYE5gE4Db0X7kagGeO
	 7I8BB9od03YPgzkv5VW0QlckyHdiUKkj1Av2ZyLhCHdmuXRBlMF0QcuIYJqagXy6Yw
	 4ZW5BFfvBCRExTIh9aGrUqnR+pAtAi3oJALbkzMIOwwnhyjhZRK9UgJT4WePVlIrWc
	 QX/IxG29/SH1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Alberto Bianchi <alberto.bianchi@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/238] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
Date: Sun, 24 Mar 2024 19:38:05 -0400
Message-ID: <20240324234027.1354210-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 81412999445d8..dce87589b1120 100644
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
 
@@ -386,6 +387,12 @@ static int dp83822_config_init(struct phy_device *phydev)
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


