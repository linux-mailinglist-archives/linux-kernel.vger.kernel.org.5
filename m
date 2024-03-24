Return-Path: <linux-kernel+bounces-115002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C6888C78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A899F1F290F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD21C0887;
	Mon, 25 Mar 2024 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7QOd7Ye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673EF17C1AB;
	Sun, 24 Mar 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323764; cv=none; b=naWNleIEOmp+4gke59IKHThJ45NXJH/wYiyXax8gQcIeFJ0iONy1kKkxwLlx5mCBOfqPh59DmXS6ZjPe0JAs2stgerxBdCpiPw95XP8nLnVKprHh2u9uGkdIgQHP+hHHZR9EXaPf3pJNxJElSqTwG54KnzusypGU9XouCI12pD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323764; c=relaxed/simple;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8RWV6hMl/KQmOmkz/ZhnKu0PIJ7g6l3hzAbTZRZMoEDmPvfFvwuvhxfv+swC3FRJkOUqj0vL6WXk7kEQYe30T9l/0eKZqSh36IdS9NmeXhzsmj12vcxY1Sd3cn7HnINuSPgJxPWb2a/kt3ZvZd7COvzHr680X/iwHJN9AUY6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7QOd7Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23C3C433F1;
	Sun, 24 Mar 2024 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323763;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7QOd7Yen92fPiIdUlknPOd3QHtUW5L1+UKJ5/+gtJM/9nN0mNG2wxBnKy7prLs5d
	 DHy8oIHGIPVmBh2csMNjQGPbOjBQyjAInToMBKRQiKwAw6yGe2sFYrtBzPgOlwZD2p
	 UOA8iy9h4gPH7741l58ZscxsdqmqSWqOx9pXNDrP+f9I2zl3PCdj02c2bYYwhT00FU
	 woiMbYBJLdfTID/oEmSI7jG+s1UjJm/z08FmuMXWM8VmLIGf0cg4iHXMNV0M/v65IS
	 54PnshexYF31xm8vpn0rWYbAhHgCjVfnx6KF4QYC5LIp7zCTuU/HoPr7Mdg89GbYFH
	 vjXmnzzuuwyvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 138/238] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 19:38:46 -0400
Message-ID: <20240324234027.1354210-139-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 2f8cf2c3f3e3f7ef61bd19abb4b0bb797ad50aaf ]

Trying to toggle the resets in a rapid fashion can lead to the changes
not actually arriving at the clock controller block when we expect them
to. This was observed at least on SM8250.

Read back the value after regmap_update_bits to ensure write completion.

Fixes: b36ba30c8ac6 ("clk: qcom: Add reset controller support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240105-topic-venus_reset-v2-3-c37eba13b5ce@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 20d1d35aaf229..d96c96a9089f4 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -33,7 +33,12 @@ static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
 	map = &rst->reset_map[id];
 	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
+	regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
+
+	/* Read back the register to ensure write completion, ignore the value */
+	regmap_read(rst->regmap, map->reg, &mask);
+
+	return 0;
 }
 
 static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
-- 
2.43.0


