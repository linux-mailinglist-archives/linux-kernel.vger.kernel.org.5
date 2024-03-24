Return-Path: <linux-kernel+bounces-115694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5E889713
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C247E1C26CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E635ADCA;
	Mon, 25 Mar 2024 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtJo5jy+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120420E64E;
	Sun, 24 Mar 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321662; cv=none; b=JeWoyRCZGNRNwcOszRiASkf/oNvQuD4soNo+g97vEd4nJY6AxuSdQNx53TWwrp2OYefmreugHpO8LqwG9gzoitHuwS0AEMJB4DwcH/yIFalncmiyUOHu3SWdyqGhexsDUUB3NdJGRRQ27OVT2QlfMM4Jp2aHc2omMNNZbwBlqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321662; c=relaxed/simple;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA0QkUpY42nZxdaTNvNBJZxhkJP89gg/oQjbvHBCCiij0LCZrLa8UsJOWUt2P0M5Y7X3rGF9Ehd/ewOlCP9w2Qy6dUyGkjXA15H0gJRhIyZVkwe/SosRl8CxrYnqsxmv+DXNOTr/E9Pd9zA0Equbvv7ErC5ua0rDgbszdX0txxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtJo5jy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9A2C433C7;
	Sun, 24 Mar 2024 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321660;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtJo5jy+fpsOkDMrS70Ky2SnY89HtbzRPJ7EgTjO8twTt7KHfkvXP14klnpgs/Xgv
	 45+AYm0sNYQ9xMQ63LCJmxN6szpj3sGeuMbe7fUTxK6HFmO6cpreTccUkCp7JvMZIq
	 dpDgNueaTMvnS1O1vnvCASUQRnlCbBECTW/5JopnJli27dZunK+83tZ4V1TO+w7w/a
	 Z3kkPjtOlG3WUFAsmCx2BhOmhal7KSjj89pr2FRk26Sgf2BBny2CoJuV3L5vLpXUTo
	 c7XLNJouW6LMzUBqvj3nR63SA+qfjdTO3Csujm71mR6JiHnE70NC9XLOWdEfmDfcvM
	 0blUroa/CWAfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 390/638] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 18:57:07 -0400
Message-ID: <20240324230116.1348576-391-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


