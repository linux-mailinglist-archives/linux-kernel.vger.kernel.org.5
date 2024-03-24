Return-Path: <linux-kernel+bounces-115237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602A888DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894421C2AA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6B2978F9;
	Mon, 25 Mar 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZSw/NFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9718521E;
	Sun, 24 Mar 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324335; cv=none; b=MMILoFDjbQtph99vCT/zqyE6MyTKld5we0B6IBovwPJhshi0yyZKBj8g+d3uGSAedL9Qc8VrbN4LKxO/YJ6KRYkcUICFvum4JNFKrc8Uo3W1QcEHk7KJB3WyQxp9Ub9kSc3bCkz7Jq7BN8ycWhaKf3L5TYnPIiCOtpa5buhNK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324335; c=relaxed/simple;
	bh=ZfOUDs7jrsD7iao803en/1YeW13GBtchnkANuEkhMvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVeCy4LN9988Du0wGXmnLpXPJlvDN5H59WSfj+iGFqTGOlBlpbWpqSpQ+RsT6u4jsY7vIGTgHwDZ7qp3Ht4YUaI2EkPU3+dovIWdy2h5p5POuXd8G1kV9Ca3tz0tuNyLq0KWrV1cxNXzr14ye33D/KdFXMld821EVTcKcjTkZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZSw/NFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE9EC433C7;
	Sun, 24 Mar 2024 23:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324333;
	bh=ZfOUDs7jrsD7iao803en/1YeW13GBtchnkANuEkhMvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZSw/NFwRq1yPkycdMnKRYkxGhJeZIBmw09ZjyUIAOBHEO19QjRXWUPvpVHTdQwhK
	 X3gxNmcQsg3IBt4ofnQ3NvGWbRL2mP5P2jOF+vfKtKcZZ6x3ZTXdOgcjh9Pb+OolCU
	 H+UoF8yAaUrZ3tYta3E4RbfUulOfpr0HLdyfk08m3DqoB+ADNqEyyuxDxWmzZcAXf4
	 YCz0NQPbpFLL/Lr9GqIFJTUK9Rkmu9skXsGYwKXQiEc2SYuV9Yuq03W9X7GKT5Yljc
	 i6rEn+192fmrxKX1vmt3QzALVo433AL5fqSx+xocWKkpuUy/aUJF0nPl9EaxR5cdIH
	 EkGd2o+UfWTfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/148] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 19:49:28 -0400
Message-ID: <20240324235012.1356413-105-sashal@kernel.org>
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

[ Upstream commit 117e7dc697c2739d754db8fe0c1e2d4f1f5d5f82 ]

SDM845 downstream uses non-default values for GDSC internal waits.
Program them accordingly to avoid surprises.

Fixes: 81351776c9fb ("clk: qcom: Add display clock controller driver for SDM845")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 6
Link: https://lore.kernel.org/r/20240103-topic-845gdsc-v1-1-368efbe1a61d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 0cc4909b5dbef..cb7a2d9247b04 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -569,6 +569,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
-- 
2.43.0


