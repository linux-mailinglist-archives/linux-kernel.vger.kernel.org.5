Return-Path: <linux-kernel+bounces-115114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C0888D28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5681C298AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114E1C633C;
	Mon, 25 Mar 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVMRGc6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDC18148A;
	Sun, 24 Mar 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324108; cv=none; b=DdFTK0h46L1SF7bdCZjos8c9Vo9jc3ALzK87sRP/ztrK3qeEKsuN7WtIH2fvaH5NSRIo2Vih8pN1C+dGBytPLb0cUmTUPjBf4qt79RCNubP+KS9/7MBHSLbXxJv5MKsz9bl128Kkh+y/9qqiC+C1Z/j+voZlJ7RSBL99XbdJA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324108; c=relaxed/simple;
	bh=xrN0NI/UzUokrl36YEZidI4lp+eL3iyinCugmIvfvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbAr93t2GqY3q9kfbwrpdwfneXvhKC0GH67hhW4CfSpi5yq3oVTwAl1tkDmybohSIgdEVpnxRxhxdGpKDtxmUicILsvAiYgMLALoVWWyJ52PtgHKnv/REJ79rRocACAr5XDLvotei3yDHnmJWCJCQBCqN5VclreNmYAuHISbUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVMRGc6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C343C433A6;
	Sun, 24 Mar 2024 23:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324107;
	bh=xrN0NI/UzUokrl36YEZidI4lp+eL3iyinCugmIvfvhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVMRGc6iXCylAl2ULexLmI87qAW4hrivSFR+Ko7msITgWstkCpfl0rLGQyoyssQRS
	 xxpTsobDePYmFm/d1ZXRXKxB1Dk9jLEgxAKFiZH58q6rPO7IXGoU/P4TohCsTYlcts
	 Q7e0WT8z0SnJFU4DxckOeuFGVWXPSOGo5T+Hl4ztM5u2vHIyGcoGCFa7C7INF7Ylww
	 /JdsGtf0FFwKu0b6oHzheznrSybnnkHr4l1FPdlwdG6s/+yUuSjfsOQ/V2XZQISwE9
	 Hy6KL8BZApBU/5EQYUKj0Mp/LbXIu0O+M2zy9hWQ7RPoNmVMsfkL+TyKNx2TgMM4de
	 7KmlXruXVCmaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 106/183] clk: qcom: reset: support resetting multiple bits
Date: Sun, 24 Mar 2024 19:45:19 -0400
Message-ID: <20240324234638.1355609-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 2a16adb572d2b..0e914ec7aeae1 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -30,7 +30,7 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
 }
@@ -44,7 +44,7 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index b8c113582072b..9a47c838d9b1b 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -12,6 +12,7 @@ struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
 	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
-- 
2.43.0


