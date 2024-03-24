Return-Path: <linux-kernel+bounces-115217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B37888DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C1128EB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746522E7F0;
	Mon, 25 Mar 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G10bMdEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54D296BA3;
	Sun, 24 Mar 2024 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324321; cv=none; b=gliF+3sdzrcMcbpw1FYqh8N/TBtqvLzBmRoqHIRr1QUiyKDsxAV1A8B8UQ5tQ0srVINCY/WEsS8HhdSl74BBHwdGR256wr0L+0dmQnyXbYiIrIXeHz8HADF1nUVdUIj+Dwni3ld4eNKEDsuQolOXhPVs1Z4vdUQh1MzTHkazGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324321; c=relaxed/simple;
	bh=inW2J0Jzb+uXUTJeTih5K0+7+5J240UsLGu8g35ShlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOuCPOquid1n38187/ajjvkb9YcL1XaD9UyGO6+vcj2tVBY9A7AoIkCNwAdMntTlDca4BmplAY1yHPewbcJf1bodONMTZbxEnSh+fC2xET5cZGx7ePOMdjJ8zzx4JfJMIHbkWX0iw7vf7AsfUr+5uxF5vFWX4El2S73rGbDrf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G10bMdEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7878EC433F1;
	Sun, 24 Mar 2024 23:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324320;
	bh=inW2J0Jzb+uXUTJeTih5K0+7+5J240UsLGu8g35ShlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G10bMdEOMBw+cIIAUYJbp7nIXTI88H+K+tqorvxecDxgr/wITs1N9jRmwNr8HsDci
	 +zSPqzUdB6nzyIJTg5wMyXFz1pP0isEhwHa+XOlK2SoGxhygOS3cH6YMq10a1ttjLX
	 aGEjUP1I8H5ohvrk6PrT8/pCmgZwhwRKc9I1KmJg+gjfEOmsnAf70DcBKURAxXGHUF
	 cMfY0Q2eK+/DUIWse13VxTvNa0Ju+MUkvlZnupNjn6CU1aUEAqOFGkMBBhRSst7O9c
	 /GLRFsVvCX5Bwhd2BR+KFhsw9I4dZjZ7LbnNdtwDyCl6dU/MOBw7EakKxaEwGfofq9
	 QqMGyRd/MapUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/148] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 19:49:15 -0400
Message-ID: <20240324235012.1356413-92-sashal@kernel.org>
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
index 252d7abf577e3..3a1cfc2dd94c9 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -40,7 +40,12 @@ static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
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


