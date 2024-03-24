Return-Path: <linux-kernel+bounces-113834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AA8886DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BF428635D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17D202391;
	Sun, 24 Mar 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6FmOdJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0A147C64;
	Sun, 24 Mar 2024 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320874; cv=none; b=YMPhLxtZaJPlVUTFc6QcN8togUKjI2yiruKugGyKlnntccBBnyH5drq814kO0T35brcHp9nxZNO8T3YiLlG6jdqe//vh6F30VKGnLKOqAalsxD6J0NsL+3WKVXYKKOJ6fToy4tlcgfvdzuRP+91yOymIAxGyj6T9Linw1LB0C1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320874; c=relaxed/simple;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7euOzq2I8HbqxTrw6p3/fQevf5HaNfLmzjxNe3D0PuVo1zqgIAlZ8IXpkcCWVDwQ4Sv+Di34Fr0fpr8IXgtg13an3WEXiKYyLjCUDjBpzbIYblK0vOfLUB7AfLHqdwxIDYG2NB0aCMfg61+wCxNWjKk9143zOnjQKvksQIZfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6FmOdJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618D0C433F1;
	Sun, 24 Mar 2024 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320873;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6FmOdJjggZzjLEyNe+x0i14awO9HzgIdIzYJsK/IEgBkVysEUEI5nku5E5dNlrVR
	 ekYYeLmt/BaPsAnoySMw/Vi2zpKihi5BPBeAIT1GuSxyzmQdpqCFkJKUBwqNMx0sYj
	 w71Lv0sW5vPQg5Xr+Qzn6vmybUuHSN8ps+5cBdXltKHdvPkdBjlK2Dy3TqtQSQMht7
	 LmYPAtgwKPaQTuJwMMJLVAIAkFHKXqHsttSbIO0ej0zqIMACY3VDdA/U5zKwkZv/yZ
	 JQhge7GP8HVp5C5GrqLo4W9iVm+w3OmfneDmA6YNq2PdG1X41VCvSW6e2dNC3ZpXcP
	 N58fY4xlaEy2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 437/713] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 18:42:43 -0400
Message-ID: <20240324224720.1345309-438-sashal@kernel.org>
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


