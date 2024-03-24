Return-Path: <linux-kernel+bounces-113295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26488832F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8DF282D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F3413CD7B;
	Sun, 24 Mar 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFpr9L4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670813CD62;
	Sun, 24 Mar 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320096; cv=none; b=HuC6n91nmgqOk/U4wgyd9zOqMAOkNU5P6z21BYyLApdayM64UMYHx7bmem4K4qKTIqiaAXLhVvqiI5ViWz26y0TXdLjNyXrwB+crJBkzNaxOsbDiiYokSJBUNQyezz1zmegJuzp1IX0Klw4JnfjVXdjTto/G0BnQfksDg4K2j3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320096; c=relaxed/simple;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLypyTdQxO9fUoeqegz230WeqbxYqDfDMGhQCB2+VF+SiFId9HsnN8CeJDOmBVcgl9EmWxiJxnRQTCpBFC2bqKomphG8UzF1SUb+sq5Bvuhj0l+HRluZXBEImu5bi+PozMLb4AMUbSJ6lZuO+uRmy9rZBTO4xb/ydVzWRSio1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFpr9L4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A651C433A6;
	Sun, 24 Mar 2024 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320095;
	bh=pCc5yRqiW7zrM8WJbTTAP0OTtZg+beqdp63g2hcZTaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFpr9L4zdcGREvzwDtMfzHUrpnDhIbFWq31PrdKeJApzNp1A4WpZcnHi0oHPPwPzh
	 QCFnq4tGdKLUtGztkp5ikNz/cehOhDFOZbLaaSvIUPyn/uybX2CVJaw7yMUc6A/m+a
	 FYWUTo/zXZqClNlUQBVz94+EzEM0bAnJAvPW30gZubBRmg++G8JEb2dBQV+Joo4wv/
	 Re3zovD7tyN0YTYxAcDKTK+BF9QohX622Z02nxrnonGv0VL11iJreFWg9CFMNVE0iv
	 WX/M8EMj2hBf+oGASoaVA59zY3eRSy59y82nnmBufDR6QkuDfVQQTZ0CxdFTbO1/Rn
	 Vd66j6E/LTkxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 404/715] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 18:29:43 -0400
Message-ID: <20240324223455.1342824-405-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


