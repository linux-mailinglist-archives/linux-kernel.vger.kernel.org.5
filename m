Return-Path: <linux-kernel+bounces-114288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2373888F89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D031F29469
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673D16D9B7;
	Sun, 24 Mar 2024 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp62DTuF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2320E63C;
	Sun, 24 Mar 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321661; cv=none; b=X6hFWU3jcgmErbZjHSNEYS1J7jcHrlY5SwOcRoW3ojAp4kOQ8g7Tgf85ZmnFXMt9kbDegFVBJKSiRmMaRIG/uybHHZLMZmvfWwz8bMFxr8wFkuglLl+QJ2+xxHrYxA2ViDI5gxXxIyMZTfpJkKFQ7RIK41AISU0mcTEMgOF6GWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321661; c=relaxed/simple;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNlWS/0OIyDYnzCLl9q86T+bIYZ+vqcjdwZHL1C+70aNvFWvtpOkzOb8u2W1iNEZiy+uveD2nkAoekPjQV7hZzNgaUTatdNDXDx7KoTdYzx2y8TjC5wLhVZ2VCY/q72blwRx94IxhcPkdyxvdtXeAI2Ma17LXcgJlRTEzUHNpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp62DTuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E49C43390;
	Sun, 24 Mar 2024 23:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321659;
	bh=uIDSKaGEKevri4m+701P4fwqcj5BZkuhrTLKSp6QbB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mp62DTuFEBY0Y92XLm629R+YqqdgDHxTF1dLYvEZiWqz+FL7cQ4HkRqzNFFIUXymM
	 /9xT60KvGWBg9bkRb2FUcVbbqQU4Ntj48Ppes2sP0ZkZ++UJ5LHcxdeEcaqJNFr9KN
	 qNXTYTuksazP/N5fWKk8mn+pS89XeFh6jWlXN1DMqRowcSSxZOK6zks/FSPhV47tNV
	 zAwgqe7KDj3te1ximmbhTIsx4ag9T1mLwuRUFJ3gSRPQot4WsEnNsC3fZQ0p8T/tZK
	 AKqGqrYQyZWvhXrpz2+1DK1ZKPVoPTY0B5jIznhmsTE+zpnKbyvwoKm3CYYZEvdb1E
	 mTGZdlQqG2ZAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 389/638] clk: qcom: reset: Commonize the de/assert functions
Date: Sun, 24 Mar 2024 18:57:06 -0400
Message-ID: <20240324230116.1348576-390-sashal@kernel.org>
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


