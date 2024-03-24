Return-Path: <linux-kernel+bounces-113294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A988832D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423661F22215
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BA13CD5F;
	Sun, 24 Mar 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTzAKVvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862B13CD46;
	Sun, 24 Mar 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320095; cv=none; b=TPug+YOic6dto/XW1AcrdUOKPiaFF0204/cXEYILcceb4AhymNqDz2jx2TALIAwmXnyTsUDpzWdU4MTTszXbLlrDNwOxstXIqUSm/dUqd3RVBN4XNjhj7kAcSrVih16iA7qkLspqiNYV/BJri8Gw9pW5TWobUwhv9YVspIUqB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320095; c=relaxed/simple;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKKpt4KiTGO6Ni7Sj/GftldMreztY3gtEJQ96KKnT2XuIcC+Ibpi1ZpJbEKxV1xfUkoPB2xk9XPydkPjVXqUvHkslLWusLpFCD69orKwnoPvvi9Ze0SuL8UWuj60s3x/Vxe/TrwPjBWRLunJWxaouEEIxXxRHjmtncjeZYSlTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTzAKVvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020F3C433B2;
	Sun, 24 Mar 2024 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320094;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTzAKVvFLNTWyh6oKnkDYox+o/oKnErKjKOT4bizGs0t4Mf7mX0awz7Cb1t9HFiK3
	 dxgLtvNs+ZNTpAASukgAqpbjwjfCQ3N4AHIBPo81nRqBf5WaWs7s2cCn2IeufjIXqH
	 buucZFVRBCVUTrJSFuiYKLJZ8E7msVurVqQh1unMPiISssPCUmmt3gHkdATTxEtpJ6
	 AkNEykNmk4nwuUye7DMgvEESYsC5cnld7Z56H2X0QZ+At54cudn5hSqqRwvWMIoja0
	 NN1mlOs7nlVuRY0H1ICl7cqZTSi3yGrxm6+qnhMhXBpqFDrMGg/wzGEGc+f5ob9m1Q
	 0rJVpqmginA9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 403/715] clk: qcom: reset: Commonize the de/assert functions
Date: Sun, 24 Mar 2024 18:29:42 -0400
Message-ID: <20240324223455.1342824-404-sashal@kernel.org>
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

[ Upstream commit eda40d9c583e95e0b6ac69d2950eec10f802e0e8 ]

They do the same thing, except the last argument of the last function
call differs. Commonize them.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240105-topic-venus_reset-v2-2-c37eba13b5ce@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 2f8cf2c3f3e3 ("clk: qcom: reset: Ensure write completion on reset de/assertion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index e45e32804d2c7..20d1d35aaf229 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -22,8 +22,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	return 0;
 }
 
-static int
-qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
 	struct qcom_reset_controller *rst;
 	const struct qcom_reset_map *map;
@@ -33,21 +33,17 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 	map = &rst->reset_map[id];
 	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
+	return regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
 }
 
-static int
-qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	struct qcom_reset_controller *rst;
-	const struct qcom_reset_map *map;
-	u32 mask;
-
-	rst = to_qcom_reset_controller(rcdev);
-	map = &rst->reset_map[id];
-	mask = map->bitmask ? map->bitmask : BIT(map->bit);
+	return qcom_reset_set_assert(rcdev, id, true);
+}
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
+static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, false);
 }
 
 const struct reset_control_ops qcom_reset_ops = {
-- 
2.43.0


