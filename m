Return-Path: <linux-kernel+bounces-116332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8A889E52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49F41F3763B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4E294E07;
	Mon, 25 Mar 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0IHf/Al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7D296194;
	Sun, 24 Mar 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324318; cv=none; b=uYkB4CVocQy3zkAWv7lPJ/Sz/2pxJhHuIYet4PaWRcaAiks9DWspq6P/U5ANgX8aLF+zDAexouOVc7qLKF1inUY0EPn0SHTKGOdGn8svta/38kOOu/BKgHcKPRMAVONQ8oxPuOrtKPpYGilJWCOi2En4bMkDjAqarjDHq796oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324318; c=relaxed/simple;
	bh=lADsJniJZHzbQRfYWEvMrBb8j0yKXv7+WxDIULm0MAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdYxalRgoHKNZPd8CWNWCrA4UjagScww6VkApyC4MhZVKe9rOSXFErzcIVFgXbll4AslBT7TO/pNvsdkDUVKVEX4yAepZuYxABpNycRHe9dAJMh6cnlsrXLYhlgwKDnKNImiT/Y/7GIVuICyOyGPmmg35oOzUrsnXP5h1JrBr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0IHf/Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFAC433F1;
	Sun, 24 Mar 2024 23:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324318;
	bh=lADsJniJZHzbQRfYWEvMrBb8j0yKXv7+WxDIULm0MAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0IHf/Alu+nB+HsU4bIEuPIHKx7eWUdMggiugDZMH2UNsfYIBA6kIn75AC8OX0Vug
	 WAJcY9sbcd7Io9NsDD/sLPcuF32ejC9XCH9/sKy7rM5OwDxfhvLVVnaXYi7DDKbmZB
	 YAcCyuBBkBGFKqRRPAb1Ftdg4cL4+HjDj/pxNPYQZ2a+2RxpG/docDiX0ibHThOVgf
	 6O7opwtt1OdbIBxoJUA1NQojR25lqYyQIhYggRBc0XqRytJeHryi4L3XHoSwM4tw0n
	 0zCFrYn66FwPfO1vwOOTw5lcP70lzUnkngGGjeJXWq5ys3/iG3IiH3kMsYpE33NFC0
	 r43Fj1Ccf8kSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/148] clk: qcom: reset: support resetting multiple bits
Date: Sun, 24 Mar 2024 19:49:13 -0400
Message-ID: <20240324235012.1356413-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Robert Marko <robimarko@gmail.com>

[ Upstream commit 4a5210893625f89723ea210d7c630b730abb37ad ]

This patch adds the support for giving the complete bitmask
in reset structure and reset operation will use this bitmask
for all reset operations.

Currently, reset structure only takes a single bit for each reset
and then calculates the bitmask by using the BIT() macro.

However, this is not sufficient anymore for newer SoC-s like IPQ8074,
IPQ6018 and more, since their networking resets require multiple bits
to be asserted in order to properly reset the HW block completely.

So, in order to allow asserting multiple bits add "bitmask" field to
qcom_reset_map, and then use that bitmask value if its populated in the
driver, if its not populated, then we just default to existing behaviour
and calculate the bitmask on the fly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20221107132901.489240-1-robimarko@gmail.com
Stable-dep-of: 2f8cf2c3f3e3 ("clk: qcom: reset: Ensure write completion on reset de/assertion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 4 ++--
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index fc68c8fa30ac7..60b60631c3445 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -38,7 +38,7 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
 }
@@ -52,7 +52,7 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 3e30f6724c7a4..a118311503d41 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -20,6 +20,7 @@ struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
 	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
-- 
2.43.0


