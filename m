Return-Path: <linux-kernel+bounces-116275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E888E889DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE5D29A9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450328D771;
	Mon, 25 Mar 2024 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugPNjafc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B31149DF5;
	Sun, 24 Mar 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324109; cv=none; b=sYOowntQ0KnzrpZfINAeKm0xbaRXpfUe4vPTk8B1MPXVA0bxs+Vq+b78TSXe8SUObwimd7PYDCETSVU4iz+ui+zkg2PpHC53J53i+T6oiHtUDr71pLXm2xXlN2CtwMHbBpLvPj6eaY7WjlHYKT3PXqWVWOT1QSaAmpFndRdFX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324109; c=relaxed/simple;
	bh=ecZIMq28dS5z5WXcLOYqbMa4zOh0Y+n31jjNNwg6oAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szW8sZF7Koi9PZmD0BrUvedgb9h8HLDcTAr1coMtQObK82JUknJDCbq7bP7N4YVqrC/mSAHPSXlRgVK1ALepc4OqGk05SsQzf4sRYn0pbt7cNIZ9ZIp86c3Nvn4Ntg9uNv+uo4Of+hrsk8IJUF2x0pJHiwJwE1OphymQPKz4twY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugPNjafc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85147C433A6;
	Sun, 24 Mar 2024 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324109;
	bh=ecZIMq28dS5z5WXcLOYqbMa4zOh0Y+n31jjNNwg6oAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugPNjafcJnPghIafwnz5KS/w+IJ6DtBrAchGO/6dQfQ77ukRnsxanHAm0x7K7u0jZ
	 8FRy70CfHIyTxMn5VT1gGO3e7ALffS4EFx/6G8Vr8ntGvZdGVZ0lRJHurcepGjhewO
	 87fbVJ0MP21FuZ0SP0aEsbyQAznufb9cd0q5TuVVAkAZj29md5hdach3O8t9TeT5LI
	 5KClVE5wUhM3bHcVQsMiw0L2YyKnfe2TfXG7+jXDLtwZLYfCszZYsgxF3mb7RfPs2G
	 yEyPjNXBAA44gqaXHqPVV/GEoQyRQnhhgbA6PDpAdv+nYp0aXdPCIrKGRjT/G9ZYK+
	 V+WO0SeonkTLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 108/183] clk: qcom: reset: Ensure write completion on reset de/assertion
Date: Sun, 24 Mar 2024 19:45:21 -0400
Message-ID: <20240324234638.1355609-109-sashal@kernel.org>
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
index 338b1210c8f87..5a44dc8bd25f2 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -32,7 +32,12 @@ static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
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


