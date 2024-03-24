Return-Path: <linux-kernel+bounces-114847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD588931F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB1B2866E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F72C6211;
	Mon, 25 Mar 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0vLHXQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0641774F3;
	Sun, 24 Mar 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323484; cv=none; b=dtxigUcw3C4iGLrxoe61wOKGdi56qvb24gcbqA+Sl4J0oZfkp0dKVXPixuudnQnOaHoHpt3+TH7ruz8Fgb1hdJprricbdhJJvs/+6lzDVcadj8qx1JBXr2KjMTAMpBVOTB+jvIAywLrjF3cwHT4zfULS/PyPWG/wEhlBb6H0Ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323484; c=relaxed/simple;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIJJuBLwHl69AD6ZSPcN6MAOueiX6dDanYXcRDRUg+WS3aYQlZs8X27A/YhYryI/Q9VdqfGppSA9QFYf8URfe1FeaMnilEUlZZqSTG1/9IHs3ecEQRfQcmGLDXwNP2DH04jVx5SaPkVwYjybr27XgIWNzN8vYJn0oTeNmoYecss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0vLHXQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CA3C433C7;
	Sun, 24 Mar 2024 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323483;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0vLHXQGuWUeBJS56iyo53ZKq7h2lJ8E1n2C7tJfHkcMko+ChmOpsGTD/YpcZew+j
	 Ythf3E4bTELA1MnQ4BaPliQD8SVAaPNbCns+G1iSkqZMptIn7iFuHJgsmjhZymEzD0
	 Hz9e68pWJbAtl6AmCSNNByL3nGX1hZh6/cYqGncbLxkOEGWUttiWeqrSXZpXwO/CLp
	 vlSEy2AkHg+XzKAn3pOywaMhdQxP/A+qTyyeHFw394qX3wXrkuSAK+iNigsGyxpMha
	 deI2mTvkeki4s/3Q8qeEe3K2e+/+cpkDD7A4uVipN3XyCKGUQga3pwhXAt6Rq/Kgub
	 JFKhXNaL8kB4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 188/317] clk: qcom: reset: Commonize the de/assert functions
Date: Sun, 24 Mar 2024 19:32:48 -0400
Message-ID: <20240324233458.1352854-189-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


