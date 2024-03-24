Return-Path: <linux-kernel+bounces-115442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3F8896D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37461F349CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087421345C;
	Mon, 25 Mar 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcv90Ifg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A531E3850;
	Sun, 24 Mar 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320800; cv=none; b=EGALNA5xFGy1d2lwHHhnskRdenViq7Ha6vgujPKuXVR9vn9nqQ2a+HuetKHpjzl5qrr97OccnUajGKaJdj7d7S9kkhYn8y+l0DycCJtcpVtFmG2iR7sIHxtAPFJgf2RlO1n5CJzlDkU5zIKevS4EHb9beqJ3gFo17GTU1Q3W/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320800; c=relaxed/simple;
	bh=CdRcVWACKoGMPyJTmaHPMOZhKs0ZjfmHxlgo6m8IUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtuqkEINuUCuN0mk8Pg/7xFrG5nf8NusKdh4lRPfQJynDRdyXodICAqlr8TxwWFMkoZQWUOdvs3i3SxhoOwG5HARXvxwLQWmhWWGMK44WRETdYcRfM755Ygk2gTU2zYLFQI6z/QUXqZUrqOR2XoZrHdzjr75nQ3g5VmJ47gyBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcv90Ifg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5A1C43394;
	Sun, 24 Mar 2024 22:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320799;
	bh=CdRcVWACKoGMPyJTmaHPMOZhKs0ZjfmHxlgo6m8IUEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xcv90IfgQqfWcB7cBkngk5D/+fCxcZcW1dtfuKiUTeFnwA8/7ydDa5sC7LQE7TN7n
	 ++YdzLmHEOQcQCs7Cm2uvMM3/7AInlVTHhPp8EKsZ/KGiBCmgjEYfqezM2NNqq3seG
	 0aQI/SgivC3zuHcd3LocAQp+pObW1QFvjxsKnkDmSNve7eTJlHeT/VNKe8dlxqBZN0
	 l8Lub3Dj4f3FPW53X2OuvHKQ5bspKsweOGmSjIjsRZm1Eno6o5gqMhlBWo0qqxeDv2
	 BzbiCTppT/bq3Ubnbpnr90XmUaTvj937xFk/7tk31YGte45m5JcSrMahNnQZtF7cEg
	 77Soh/h8VUN+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 363/713] net: dsa: microchip: make sure drive strength configuration is not lost by soft reset
Date: Sun, 24 Mar 2024 18:41:29 -0400
Message-ID: <20240324224720.1345309-364-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit e3fb8e8ba72b053d05ca2602acdd6b869f9f296f ]

This driver has two separate reset sequence in different places:
- gpio/HW reset on start of ksz_switch_register()
- SW reset on start of ksz_setup()

The second one will overwrite drive strength configuration made in the
ksz_switch_register().

To fix it, move ksz_parse_drive_strength() from ksz_switch_register() to
ksz_setup().

Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength configuration")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20240304135612.814404-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index ff4b39601c937..d5d7e48b7b928 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2176,6 +2176,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
+static int ksz_parse_drive_strength(struct ksz_device *dev);
+
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2197,6 +2199,10 @@ static int ksz_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -4236,10 +4242,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
-		ret = ksz_parse_drive_strength(dev);
-		if (ret)
-			return ret;
-
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
-- 
2.43.0


